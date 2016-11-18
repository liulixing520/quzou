package org.ofbiz.system;

import static org.ofbiz.base.util.UtilGenerics.checkList;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastList;
import javolution.util.FastMap;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.io.FilenameUtils;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.FileUtil;
import org.ofbiz.base.util.GeneralException;
import org.ofbiz.base.util.ObjectType;
import org.ofbiz.base.util.StringUtil;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilGenerics;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.ebiz.product.UtilUUID;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.entity.util.EntityFindOptions;
import org.ofbiz.entity.util.EntityListIterator;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;

public class SystemServices {
	public static final String module = SystemServices.class.getName();
	public static final String LABEL_RESOURCE = "CmsUiLabels";
	private static String ofbizHome = System.getProperty("ofbiz.home");
	 public static final String DATE_FOLDER_FORMAT = "yyyyMMdd";

	    public static final Boolean useDebug = UtilProperties.getPropertyAsBoolean("contentUpload.properties", "isable.debug.config", false);

	public static Map<String, Object> setSeoMSG(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map result = new HashMap();
		Delegator delegator = dctx.getDelegator();
		String PSCTypeId = (String) context.get("PSCTypeId");
		String typeContent = (String) context.get("typeContent");
		String PSId = (String) context.get("PSId");
		String contentId;
		GenericValue gv;
		try {
			List<EntityExpr> exprs = FastList.newInstance();
			exprs.add(EntityCondition.makeCondition("productStoreId", EntityOperator.EQUALS, PSId));
			exprs.add(EntityCondition.makeCondition("productStoreContentTypeId", EntityOperator.EQUALS, PSCTypeId));
			EntityFindOptions opts = new EntityFindOptions();
			opts.setMaxRows(1);
			opts.setFetchSize(1);
			List<GenericValue> list = delegator.findList("ProductStoreContent", EntityCondition.makeCondition(exprs, EntityOperator.AND), null, null, opts, false);
			if (list.size() == 0) {
				contentId = delegator.getNextSeqId("Content");
				gv = delegator.makeValue("Content");
				gv.set("contentId", contentId);
				gv.set("description", typeContent);
				gv.create();
				gv = null;
				gv = delegator.makeValue("ProductStoreContent");
				gv.set("productStoreId", PSId);
				gv.set("productStoreContentTypeId", PSCTypeId);
				gv.set("contentId", contentId);
				gv.create();
			} else {
				contentId = (String) list.get(0).get("contentId");
				exprs = FastList.newInstance();
				exprs.add(EntityCondition.makeCondition("Content", EntityOperator.EQUALS, contentId));
				opts = new EntityFindOptions();
				opts.setMaxRows(1);
				opts.setFetchSize(1);
				GenericValue contentObj = delegator.findOne("Content", false, "contentId", contentId);
				if (null == contentObj) {
					contentObj = delegator.makeValue("Content");
					contentObj.put("contentId", contentId);
					contentObj.put("description", typeContent);
					contentObj.create();
				} else {
					contentObj.set("description", typeContent);
					contentObj.store();
				}
			}
			//ShopUtil.returnAjaxInfo(result, context);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	/*
	 * 邮件短信模板的增删改
	 */
	public static Map<String, Object> createTemplate(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map result = new HashMap();
		Delegator delegator = dctx.getDelegator();

		GenericValue contentObj = null;
		GenericValue dataResource = null;
		GenericValue electronicText = null;
		GenericValue contentPurpose = null;
		GenericValue productStoreMsgSetting = null;
		try {
			String eventTypeId = context.get("eventTypeId").toString();
			String msgTypeId = context.get("msgTypeId").toString();
			String productStoreId = context.get("productStoreId").toString();
			String subject = context.get("subject")!=null?context.get("subject").toString():" ";
			String content = context.get("content")!=null?context.get("content").toString():" ";

			Map productStoreMsgSettingObj = new HashMap();
			productStoreMsgSettingObj.put("eventTypeId", eventTypeId);
			productStoreMsgSettingObj.put("msgTypeId", msgTypeId);
			productStoreMsgSettingObj.put("productStoreId", productStoreId);
			productStoreMsgSettingObj.put("subject", subject);
			if (msgTypeId.equals("SMS")) {
				productStoreMsgSettingObj.put("content", content);
				productStoreMsgSetting = delegator.makeValue("ProductStoreMsgSetting", productStoreMsgSettingObj);
				productStoreMsgSetting.create();
			} else {
				String contentId = delegator.getNextSeqId("Content");
				String dataResourceId = delegator.getNextSeqId("DataResource");
				String contentPurposeTypeId = (msgTypeId.equals("MAIL")) ? "EMAIL_TEMPLATE" : "MSG_TEMPLATE";

				productStoreMsgSettingObj.put("contentId", contentId);
				productStoreMsgSetting = delegator.makeValue("ProductStoreMsgSetting", productStoreMsgSettingObj);

				Map contentData = new HashMap();
				contentData.put("contentId", contentId);
				contentData.put("dataResourceId", dataResourceId);
				contentData.put("contentTypeId", "NOE_TEMPLATE");

				Map electronicTextObj = new HashMap();
				electronicTextObj.put("dataResourceId", dataResourceId);
				electronicTextObj.put("textData", content);

				Map dataResourceObj = new HashMap();
				dataResourceObj.put("dataResourceTypeId", "ELECTRONIC_TEXT");
				dataResourceObj.put("dataResourceId", dataResourceId);

				Map contentPurposeObj = new HashMap();
				contentPurposeObj.put("contentId", contentId);
				contentPurposeObj.put("contentPurposeTypeId", contentPurposeTypeId);

				contentObj = delegator.makeValue("Content", contentData);
				dataResource = delegator.makeValue("DataResource", dataResourceObj);
				electronicText = delegator.makeValue("ElectronicText", electronicTextObj);
				contentPurpose = delegator.makeValue("ContentPurpose", contentPurposeObj);

				dataResource.create();
				contentObj.create();
				electronicText.create();
				contentPurpose.create();
				productStoreMsgSetting.create();
			}
			result.put("flag", "1");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("flag", "0");
		}
		return result;
	}

	public static Map<String, Object> updateTemplate(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map result = new HashMap();
		Delegator delegator = dctx.getDelegator();
		try {
			/*
			 * String contentId = context.get("contentId").toString(); String
			 * contentName = context.get("contentName").toString(); String
			 * contentPurposeTypeId =
			 * context.get("contentPurposeTypeId").toString(); String textData =
			 * context.get("textData").toString();
			 * 
			 * GenericValue content = delegator.findByPrimaryKey("Content",
			 * UtilMisc.toMap("contentId", contentId));
			 * content.setFields(UtilMisc.toMap("contentName", contentName));
			 * content.store();
			 * 
			 * List<GenericValue> contentPurposeList =
			 * delegator.findByAnd("ContentPurpose", UtilMisc.toMap("contentId",
			 * contentId)); if (contentPurposeList.size() == 1) { GenericValue
			 * contentPurpose = contentPurposeList.get(0);
			 * contentPurpose.setFields(UtilMisc.toMap("contentPurposeTypeId",
			 * contentPurposeTypeId)); contentPurpose.store(); } else { throw
			 * new Exception("对应关系错误！"); } List<GenericValue> electronicTextList
			 * = delegator.findByAnd("ElectronicText",
			 * UtilMisc.toMap("dataResourceId", content.get("dataResourceId")));
			 * if (electronicTextList.size() == 1) { GenericValue electronicText
			 * = electronicTextList.get(0);
			 * electronicText.setFields(UtilMisc.toMap("textData", textData));
			 * electronicText.store(); } else { throw new Exception("对应关系错误！");
			 * } result.put("flag", "1");
			 */
			String eventTypeId = context.get("eventTypeId").toString();
			String msgTypeId = context.get("msgTypeId").toString();
			String productStoreId = context.get("productStoreId").toString();
			String subject = context.get("subject")!=null?context.get("subject").toString():" ";
			String content = context.get("content")!=null?context.get("content").toString():" ";

			GenericValue contentObj = null;
			GenericValue electronicText = null;
			GenericValue productStoreMsgSetting = null;

			List<GenericValue> productStoreMsgSettingList = delegator.findByAnd("ProductStoreMsgSetting", UtilMisc.toMap("eventTypeId", eventTypeId, "msgTypeId", msgTypeId, "productStoreId", productStoreId));
			if (productStoreMsgSettingList.size() != 1) {
				throw new Exception("the result by coondition is not only one!");
			} else {
				productStoreMsgSetting = productStoreMsgSettingList.get(0);
			}
			productStoreMsgSetting.put("subject", subject);
			if (msgTypeId.equals("SMS")) {
				productStoreMsgSetting.put("content", content);
				productStoreMsgSetting.store();
			} else {
				String contentId = productStoreMsgSetting.get("contentId").toString();

				contentObj = delegator.findByPrimaryKey("Content", UtilMisc.toMap("contentId", contentId));

				String dataResourceId = contentObj.get("dataResourceId").toString();
				List<GenericValue> electronicTextList = delegator.findByAnd("ElectronicText", UtilMisc.toMap("dataResourceId", dataResourceId));
				if (electronicTextList.size() == 1) {
					electronicText = electronicTextList.get(0);
					electronicText.set("textData", content);
				} else {
					throw new Exception("the result by coondition is not only one!");
				}
				electronicText.store();
				productStoreMsgSetting.store();
			}
			result.put("flag", "1");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("flag", "0");
		}
		return result;
	}

	public static Map<String, Object> deleteTemplate(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map result = new HashMap();
		Delegator delegator = dctx.getDelegator();

		try {
			String contentId = context.get("contentId").toString();
			GenericValue content = delegator.findByPrimaryKey("Content", UtilMisc.toMap("contentId", contentId));
			String dataResourceId = content.get("dataResourceId").toString();

			GenericValue dataResource = null;
			GenericValue electronicText = null;
			GenericValue contentPurpose = null;

			List<GenericValue> contentPurposeList = delegator.findByAnd("ContentPurpose", UtilMisc.toMap("contentId", contentId));
			if (contentPurposeList.size() == 1) {
				contentPurpose = contentPurposeList.get(0);
			} else {
				throw new Exception("对应关系错误！");
			}
			dataResource = delegator.findByPrimaryKey("DataResource", UtilMisc.toMap("dataResourceId", dataResourceId));

			List<GenericValue> electronicTextList = delegator.findByAnd("ElectronicText", UtilMisc.toMap("dataResourceId", dataResourceId));
			if (electronicTextList.size() == 1) {
				electronicText = electronicTextList.get(0);
			} else {
				throw new Exception("对应关系错误！");
			}

			electronicText.remove();
			dataResource.remove();
			contentPurpose.remove();
			content.remove();

			result.put("flag", "1");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("flag", "0");
		}
		return result;
	}

	// 查找用户信息
	public static Map<String, Object> findUsersInfoByCondition(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map result = FastMap.newInstance();
		result.put("userList", FastList.newInstance());
		result.put("userListSize", 0);
		Delegator delegator = dctx.getDelegator();

		Object VIEW_INDEX_1 = context.get("VIEW_INDEX_1");
		Object VIEW_SIZE_1 = context.get("VIEW_SIZE_1");
		Object userLoginId = context.get("userLoginId");// userlogin
		Object Email = context.get("Email");// contactMech
		Object name = context.get("name");// person
		Object mobilePhone = context.get("mobilePhone");// contactMech
		Object address = context.get("address");// contactMech=postalAddress
		Object remark = context.get("remark");// person/party_group--/comments
		Object regionDateStart = context.get("regionDateStart");// party-createDate
		Object regionDateEnd = context.get("regionDateEnd");// party-createDate
		Object loginDateStart = context.get("loginDateStart");// user_login_history--fromDate
		Object loginDateEnd = context.get("loginDateEnd");// user_login_history--fromDate
		Object gradeToo = context.get("gradeToo");// partyClassification-partyClassificationGroupId
		Object integralLow = context.get("integralLow");// RewardAccount
		Object integralHigh = context.get("integralHigh");// RewardAccount
		Object gender_M = context.get("gender_M");// Person
		Object gender_F = context.get("gender_F");
		Object gender_NULL = context.get("gender_NULL");
		Object stateProvinceGeoId = context.get("stateProvinceGeoId");// PostalAddress
		Object cityGeoId = context.get("cityGeoId");
		Object countyGeoId = context.get("countyGeoId");
		Object accountBalanceLow = context.get("accountBalanceLow");// FinAccount-actualBalance
		Object accountBalanceHigh = context.get("accountBalanceHigh");

		Map params = FastMap.newInstance();
		if (UtilValidate.isNotEmpty(accountBalanceHigh)) {
			params.put("accountBalanceHigh", accountBalanceHigh);
		}
		if (UtilValidate.isNotEmpty(accountBalanceLow)) {
			params.put("accountBalanceLow", accountBalanceLow);
		}
		if (UtilValidate.isNotEmpty(countyGeoId)) {
			params.put("countyGeoId", countyGeoId);
		}
		if (UtilValidate.isNotEmpty(cityGeoId)) {
			params.put("cityGeoId", cityGeoId);
		}
		if (UtilValidate.isNotEmpty(stateProvinceGeoId)) {
			params.put("stateProvinceGeoId", stateProvinceGeoId);
		}
		if (UtilValidate.isNotEmpty(gender_NULL)) {
			params.put("gender_NULL", gender_NULL);
		}
		if (UtilValidate.isNotEmpty(gender_F)) {
			params.put("gender_F", gender_F);
		}
		if (UtilValidate.isNotEmpty(gender_M)) {
			params.put("gender_M", gender_M);
		}
		if (UtilValidate.isNotEmpty(integralHigh)) {
			params.put("integralHigh", integralHigh);
		}
		if (UtilValidate.isNotEmpty(integralLow)) {
			params.put("integralLow", integralLow);
		}
		if (UtilValidate.isNotEmpty(gradeToo)) {
			List gradeList = FastList.newInstance();
			if (((String) gradeToo).startsWith("{") && ((String) gradeToo).endsWith("}")) {
				String idsStr = ((String) gradeToo).substring(1, ((String) gradeToo).length() - 1);
				String[] idsArr = idsStr.split(",");
				for (String id : idsArr) {
					gradeList.add(id.trim());
				}
			} else {
				gradeList.add(gradeToo);
			}
			params.put("gradeToo", gradeList);
		}
		if (UtilValidate.isNotEmpty(loginDateEnd)) {
			params.put("loginDateEnd", loginDateEnd);
		}
		if (UtilValidate.isNotEmpty(loginDateStart)) {
			params.put("loginDateStart", loginDateStart);
		}
		if (UtilValidate.isNotEmpty(regionDateEnd)) {
			params.put("regionDateEnd", regionDateEnd);
		}
		if (UtilValidate.isNotEmpty(regionDateStart)) {
			params.put("regionDateStart", regionDateStart);
		}
		if (UtilValidate.isNotEmpty(remark)) {
			params.put("remark", remark);
		}
		if (UtilValidate.isNotEmpty(address)) {
			params.put("address", address);
		}
		if (UtilValidate.isNotEmpty(mobilePhone)) {
			params.put("mobilePhone", mobilePhone);
		}
		if (UtilValidate.isNotEmpty(name)) {
			params.put("name", name);
		}
		if (UtilValidate.isNotEmpty(Email)) {
			params.put("Email", Email);
		}
		if (UtilValidate.isNotEmpty(userLoginId)) {
			params.put("userLoginId", userLoginId);
		}

		List conditionList = FastList.newInstance();
		// userLoginId
		if (null != userLoginId) {
			if (!(((String) userLoginId).trim().equals(""))) {
				List<GenericValue> userLoginList = delegator.findList("UserLogin", EntityCondition.makeCondition("userLoginId", EntityOperator.LIKE, "%" + userLoginId + "%"), null, null, null, false);
				List idsIn = FastList.newInstance();
				for (GenericValue userLogin : userLoginList) {
					if (UtilValidate.isNotEmpty(userLogin.get("partyId"))) {
						idsIn.add(userLogin.get("partyId"));
					}
				}
				EntityCondition condt = EntityCondition.makeCondition("partyId", EntityOperator.IN, idsIn);
				conditionList.add(condt);
			}
		}
		// Email
		if (null != Email) {
			if (!(((String) Email).trim().equals(""))) {
				// contactmech
				List cdtList = FastList.newInstance();
				EntityCondition cdt;
				cdt = EntityCondition.makeCondition("infoString", EntityOperator.LIKE, "%" + Email + "%");
				cdtList.add(cdt);
				cdt = EntityCondition.makeCondition("contactMechTypeId", EntityOperator.EQUALS, "EMAIL_ADDRESS");
				cdtList.add(cdt);
				EntityCondition condition = EntityCondition.makeCondition(cdtList, EntityOperator.AND);
				List<GenericValue> contactMechList = delegator.findList("ContactMech", condition, null, null, null, false);
				// partycontactmech
				cdtList = FastList.newInstance();
				for (GenericValue contactMech : contactMechList) {
					cdt = EntityCondition.makeCondition("contactMechId", EntityOperator.EQUALS, contactMech.get("contactMechId"));
					cdtList.add(cdt);
				}
				List<GenericValue> partyContactMechList = delegator.findList("PartyContactMech", EntityCondition.makeCondition(cdtList, EntityOperator.OR), null, null, null, false);
				List idsIn = FastList.newInstance();
				for (GenericValue partyContactMech : partyContactMechList) {
					if (UtilValidate.isNotEmpty(partyContactMech.get("partyId"))) {
						idsIn.add(partyContactMech.get("partyId"));
					}
				}
				EntityCondition condt = EntityCondition.makeCondition("partyId", EntityOperator.IN, idsIn);
				conditionList.add(condt);
			}
		}
		// name
		if (null != name) {
			if (!(((String) name).trim().equals(""))) {
				List cdtList = FastList.newInstance();
				EntityCondition cdt;
				cdt = EntityCondition.makeCondition("firstName", EntityOperator.LIKE, "%" + name + "%");
				cdtList.add(cdt);
				cdt = EntityCondition.makeCondition("middleName", EntityOperator.LIKE, "%" + name + "%");
				cdtList.add(cdt);
				cdt = EntityCondition.makeCondition("lastName", EntityOperator.LIKE, "%" + name + "%");
				cdtList.add(cdt);
				cdt = EntityCondition.makeCondition(cdtList, EntityOperator.OR);

				List<GenericValue> personList = delegator.findList("Person", cdt, null, null, null, false);
				List idsIn = FastList.newInstance();
				for (GenericValue person : personList) {
					if (UtilValidate.isNotEmpty(person.get("partyId"))) {
						idsIn.add(person.get("partyId"));
					}
				}
				EntityCondition condt = EntityCondition.makeCondition("partyId", EntityOperator.IN, idsIn);
				conditionList.add(condt);
			}
		}
		// mobilePhone
		if (null != mobilePhone) {
			if (!(((String) mobilePhone).trim().equals(""))) {
				// postalAddress
				List<GenericValue> telecomNumberList = delegator.findList("TelecomNumber", EntityCondition.makeCondition("contactNumber", EntityOperator.LIKE, "%" + mobilePhone + "%"), null, null, null, false);
				if(UtilValidate.isNotEmpty(telecomNumberList)){
					// PartycontactMech
					List cdtList = FastList.newInstance();
					EntityCondition cdt;
					for (GenericValue telecomNumber : telecomNumberList) {
						cdt = EntityCondition.makeCondition("contactMechId", EntityOperator.EQUALS, telecomNumber.get("contactMechId"));
						cdtList.add(cdt);
					}
					cdt = EntityCondition.makeCondition(cdtList, EntityOperator.OR);
					List<GenericValue> partyContactMechList = delegator.findList("PartyContactMech", cdt, null, null, null, false);
					List idsIn = FastList.newInstance();
					for (GenericValue partyContactMech : partyContactMechList) {
						if (UtilValidate.isNotEmpty(partyContactMech.get("partyId"))) {
							idsIn.add(partyContactMech.get("partyId"));
						}
					}
					EntityCondition condt = EntityCondition.makeCondition("partyId", EntityOperator.IN, idsIn);
					conditionList.add(condt);
				}
			}
		}
		// address
		if (null != address) {
			if (!(((String) address).trim().equals(""))) {
				// postalAddress
				List cdtList = FastList.newInstance();
				cdtList.add(EntityCondition.makeCondition("address1", EntityOperator.LIKE, "%" + address + "%"));
				cdtList.add(EntityCondition.makeCondition("address2", EntityOperator.LIKE, "%" + address + "%"));
				List<GenericValue> postalAddressList = delegator.findList("PostalAddress", EntityCondition.makeCondition(cdtList, EntityOperator.OR), null, null, null, false);
				// PartycontactMech
				cdtList = FastList.newInstance();
				EntityCondition cdt;
				for (GenericValue postalAddress : postalAddressList) {
					cdt = EntityCondition.makeCondition("contactMechId", EntityOperator.EQUALS, postalAddress.get("contactMechId"));
					cdtList.add(cdt);
				}
				cdt = EntityCondition.makeCondition(cdtList, EntityOperator.OR);
				List<GenericValue> partyContactMechList = delegator.findList("PartyContactMech", cdt, null, null, null, false);
				List idsIn = FastList.newInstance();
				for (GenericValue partyContactMech : partyContactMechList) {
					if (UtilValidate.isNotEmpty(partyContactMech.get("partyId"))) {
						idsIn.add(partyContactMech.get("partyId"));
					}
				}
				EntityCondition condt = EntityCondition.makeCondition("partyId", EntityOperator.IN, idsIn);
				conditionList.add(condt);
			}
		}
		// remark
		if (null != remark) {
			if (!(((String) remark).trim().equals(""))) {
				List<GenericValue> personList = delegator.findList("Person", EntityCondition.makeCondition("comments", EntityOperator.LIKE, "%" + remark + "%"), null, null, null, false);
				List<GenericValue> partyGroupList = delegator.findList("PartyGroup", EntityCondition.makeCondition("comments", EntityOperator.LIKE, "%" + remark + "%"), null, null, null, false);
				List idsIn = FastList.newInstance();
				for (GenericValue person : personList) {
					if (UtilValidate.isNotEmpty(person.get("partyId"))) {
						idsIn.add(person.get("partyId"));
					}
				}
				for (GenericValue partyGroup : partyGroupList) {
					if (UtilValidate.isNotEmpty(partyGroup.get("partyId"))) {
						idsIn.add(partyGroup.get("partyId"));
					}
				}
				EntityCondition condt = EntityCondition.makeCondition("partyId", EntityOperator.IN, idsIn);
				conditionList.add(condt);
			}
		}
		// regionDateStart/regionDateEnd
		{
			List cdtList = FastList.newInstance();
			EntityCondition cdt;
			if (null != regionDateStart) {
				if (!(((String) regionDateStart).trim().equals(""))) {
					String regionDateStartStr = ((String) regionDateStart);
					if (UtilValidate.isNotEmpty(regionDateStartStr) && regionDateStartStr.length() > 8) {
						regionDateStartStr = regionDateStartStr.trim();
						if (regionDateStartStr.length() < 14)
							regionDateStartStr = regionDateStartStr + " " + "00:00:00.000";
						try {
							Object converted = ObjectType.simpleTypeConvert(regionDateStartStr, "Timestamp", null, null);
							if (converted != null) {
								cdtList.add(EntityCondition.makeCondition("createDate", EntityOperator.GREATER_THAN_EQUAL_TO, converted));
							}
						} catch (GeneralException e) {
							Debug.logWarning(e.getMessage(), module);
						}
					}
				}
			}
			if (null != regionDateEnd) {
				if (!(((String) regionDateEnd).trim().equals(""))) {
					String regionDateEndStr = ((String) regionDateEnd);
					if (UtilValidate.isNotEmpty(regionDateEndStr) && regionDateEndStr.length() > 8) {
						regionDateEndStr = regionDateEndStr.trim();
						if (regionDateEndStr.length() < 14)
							regionDateEndStr = regionDateEndStr + " " + "23:59:59.999";
						try {
							Object converted = ObjectType.simpleTypeConvert(regionDateEndStr, "Timestamp", null, null);
							if (converted != null) {
								cdtList.add(EntityCondition.makeCondition("createDate", EntityOperator.LESS_THAN_EQUAL_TO, converted));
							}
						} catch (GeneralException e) {
							Debug.logWarning(e.getMessage(), module);
						}
					}
				}
			}
			if (cdtList.size() > 0) {
				cdt = EntityCondition.makeCondition(cdtList, EntityOperator.OR);
				List<GenericValue> partyList = delegator.findList("Party", cdt, null, null, null, false);
				List idsIn = FastList.newInstance();
				for (GenericValue party : partyList) {
					if (UtilValidate.isNotEmpty(party.get("partyId"))) {
						idsIn.add(party.get("partyId"));
					}
				}
				EntityCondition condt = EntityCondition.makeCondition("partyId", EntityOperator.IN, idsIn);
				conditionList.add(condt);
			}
		}
		// loginDateStart/loginDateEnd
		{
			List cdtList = FastList.newInstance();
			EntityCondition cdt;
			if (null != loginDateStart) {
				if (!(((String) loginDateStart).trim().equals(""))) {
					String loginDateStartStr = ((String) loginDateStart);
					if (UtilValidate.isNotEmpty(loginDateStartStr) && loginDateStartStr.length() > 8) {
						loginDateStartStr = loginDateStartStr.trim();
						if (loginDateStartStr.length() < 14)
							loginDateStartStr = loginDateStartStr + " " + "00:00:00.000";
						try {
							Object converted = ObjectType.simpleTypeConvert(loginDateStartStr, "Timestamp", null, null);
							if (converted != null) {
								cdtList.add(EntityCondition.makeCondition("fromDate", EntityOperator.GREATER_THAN_EQUAL_TO, converted));
							}
						} catch (GeneralException e) {
							Debug.logWarning(e.getMessage(), module);
						}
					}
				}
			}
			if (null != loginDateEnd) {
				if (!(((String) loginDateEnd).trim().equals(""))) {
					String loginDateEndStr = ((String) loginDateEnd);
					if (UtilValidate.isNotEmpty(loginDateEndStr) && loginDateEndStr.length() > 8) {
						loginDateEndStr = loginDateEndStr.trim();
						if (loginDateEndStr.length() < 14)
							loginDateEndStr = loginDateEndStr + " " + "23:59:59.999";
						try {
							Object converted = ObjectType.simpleTypeConvert(loginDateEndStr, "Timestamp", null, null);
							if (converted != null) {
								cdtList.add(EntityCondition.makeCondition("fromDate", EntityOperator.LESS_THAN_EQUAL_TO, converted));
							}
						} catch (GeneralException e) {
							Debug.logWarning(e.getMessage(), module);
						}
					}
				}
			}
			if (cdtList.size() > 0) {
				EntityFindOptions findOpts = new EntityFindOptions(true, EntityFindOptions.TYPE_SCROLL_INSENSITIVE, EntityFindOptions.CONCUR_READ_ONLY, true);
				List<GenericValue> userLoginHistoryList = delegator.findList("UserLoginHistory", EntityCondition.makeCondition(cdtList, EntityOperator.AND), null, null, findOpts, false);
				List idsIn = FastList.newInstance();
				for (GenericValue userLoginHistory : userLoginHistoryList) {
					if (UtilValidate.isNotEmpty(userLoginHistory.get("partyId"))) {
						idsIn.add(userLoginHistory.get("partyId"));
					}
				}
				EntityCondition condt = EntityCondition.makeCondition("partyId", EntityOperator.IN, idsIn);
				conditionList.add(condt);
			}
		}
		// "gradeToo" partyClassification-partyClassificationGroupId
		if (null != gradeToo) {
			List gradeList = FastList.newInstance();
			if (((String) gradeToo).startsWith("{") && ((String) gradeToo).endsWith("}")) {
				String idsStr = ((String) gradeToo).substring(1, ((String) gradeToo).length() - 1);
				String[] idsArr = idsStr.split(",");
				for (String id : idsArr) {
					gradeList.add(id.trim());
				}
			} else {
				gradeList.add(gradeToo);
			}
			List cdtList = FastList.newInstance();
			EntityCondition cdt;

			cdt = EntityCondition.makeCondition("partyClassificationGroupId", EntityOperator.IN, gradeList);
			List<GenericValue> partyClassificationList = delegator.findList("PartyClassification", cdt, null, null, null, false);
			List idsIn = FastList.newInstance();
			for (GenericValue partyClassification : partyClassificationList) {
				if (UtilValidate.isNotEmpty(partyClassification.get("partyId"))) {
					idsIn.add(partyClassification.get("partyId"));
				}
			}
			EntityCondition condt = EntityCondition.makeCondition("partyId", EntityOperator.IN, idsIn);
			conditionList.add(condt);

		}
		// integralLow/integralHigh RewardAccount
		{
			EntityCondition cdt;
			List cdtList = FastList.newInstance();
			if (null != integralLow) {
				if (!(((String) integralLow).trim().equals(""))) {
					Integer integralLowInt = Integer.valueOf((String) integralLow);
					cdt = EntityCondition.makeCondition("availableBalance", EntityOperator.GREATER_THAN_EQUAL_TO, integralLowInt);
					cdtList.add(cdt);
				}
			}
			if (null != integralHigh) {
				if (!(((String) integralHigh).trim().equals(""))) {
					Integer integralHighInt = Integer.valueOf((String) integralHigh);
					cdt = EntityCondition.makeCondition("availableBalance", EntityOperator.LESS_THAN_EQUAL_TO, integralHighInt);
					cdtList.add(cdt);
				}
			}
			if (cdtList.size() > 0) {
				cdt = EntityCondition.makeCondition(cdtList, EntityOperator.AND);
				List<GenericValue> rewardAccountList = delegator.findList("RewardAccount", cdt, null, null, null, false);
				List idsIn = FastList.newInstance();
				for (GenericValue rewardAccount : rewardAccountList) {
					if (UtilValidate.isNotEmpty(rewardAccount.get("partyId"))) {
						idsIn.add(rewardAccount.get("partyId"));
					}
				}
				EntityCondition condt = EntityCondition.makeCondition("partyId", EntityOperator.IN, idsIn);
				conditionList.add(condt);
			}
		}
		// gender_M gender_F gender_NULL
		{
			EntityCondition cdt;
			List cdtList = FastList.newInstance();
			if (null != gender_M) {
				cdt = EntityCondition.makeCondition("gender", EntityOperator.EQUALS, "M");
				cdtList.add(cdt);
			}
			if (null != gender_F) {
				cdt = EntityCondition.makeCondition("gender", EntityOperator.EQUALS, "F");
				cdtList.add(cdt);
			}
			if (null != gender_NULL) {
				cdt = EntityCondition.makeCondition("gender", EntityOperator.EQUALS, null);
				cdtList.add(cdt);
			}
			if (cdtList.size() > 0) {
				cdt = EntityCondition.makeCondition(cdtList, EntityOperator.OR);
				List<GenericValue> personList = delegator.findList("Person", cdt, null, null, null, false);
				List idsIn = FastList.newInstance();
				for (GenericValue person : personList) {
					if (UtilValidate.isNotEmpty(person.get("partyId"))) {
						idsIn.add(person.get("partyId"));
					}
				}
				EntityCondition condt = EntityCondition.makeCondition("partyId", EntityOperator.IN, idsIn);
				conditionList.add(condt);
			}
		}
		// stateProvinceGeoId cityGeoId countyGeoId PostalAddress
		{
			EntityCondition cdt;
			List cdtList = FastList.newInstance();
			if (null != stateProvinceGeoId) {
				if (!(((String) stateProvinceGeoId).trim().equals(""))) {
					cdt = EntityCondition.makeCondition("stateProvinceGeoId", EntityOperator.EQUALS, stateProvinceGeoId);
					cdtList.add(cdt);
				}
			}
			if (null != cityGeoId) {
				if (!(((String) cityGeoId).trim().equals(""))) {
					cdt = EntityCondition.makeCondition("cityGeoId", EntityOperator.EQUALS, cityGeoId);
					cdtList.add(cdt);
				}
			}
			if (null != countyGeoId) {
				if (!(((String) countyGeoId).trim().equals(""))) {
					cdt = EntityCondition.makeCondition("countyGeoId", EntityOperator.EQUALS, countyGeoId);
					cdtList.add(cdt);
				}
			}
			if (cdtList.size() > 0) {
				cdt = EntityCondition.makeCondition(cdtList, EntityOperator.AND);
				List<GenericValue> postalAddressList = delegator.findList("PostalAddress", cdt, null, null, null, false);
				// partyContactMech
				cdtList = FastList.newInstance();
				for (GenericValue postalAddress : postalAddressList) {
					cdt = EntityCondition.makeCondition("contactMechId", EntityOperator.EQUALS, postalAddress.get("contactMechId"));
					cdtList.add(cdt);
				}
				cdt = EntityCondition.makeCondition(cdtList, EntityOperator.AND);
				List<GenericValue> partyContactMechList = delegator.findList("PartyContactMech", cdt, null, null, null, false);
				List idsIn = FastList.newInstance();
				for (GenericValue partyContactMech : partyContactMechList) {
					if (UtilValidate.isNotEmpty(partyContactMech.get("partyId"))) {
						idsIn.add(partyContactMech.get("partyId"));
					}
				}
				EntityCondition condt = EntityCondition.makeCondition("partyId", EntityOperator.IN, idsIn);
				conditionList.add(condt);
			}
		}
		// accountBalanceLow accountBalanceHigh FinAccount-actualBalance
		{
			EntityCondition cdt;
			List cdtList = FastList.newInstance();
			if (null != accountBalanceLow) {
				if (!(((String) accountBalanceLow).trim().equals(""))) {
					Integer accountBalanceLowInt = Integer.valueOf((String) accountBalanceLow);
					cdt = EntityCondition.makeCondition("availableBalance", EntityOperator.GREATER_THAN_EQUAL_TO, accountBalanceLowInt);
					cdtList.add(cdt);
				}
			}
			if (null != accountBalanceHigh) {
				if (!(((String) accountBalanceHigh).trim().equals(""))) {
					Integer accountBalanceHighInt = Integer.valueOf((String) accountBalanceHigh);
					cdt = EntityCondition.makeCondition("availableBalance", EntityOperator.LESS_THAN_EQUAL_TO, accountBalanceHighInt);
					cdtList.add(cdt);
				}
			}
			if (cdtList.size() > 0) {
				cdt = EntityCondition.makeCondition(cdtList, EntityOperator.AND);
				List<GenericValue> finAccountList = delegator.findList("FinAccount", cdt, null, null, null, false);
				List idsIn = FastList.newInstance();
				for (GenericValue finAccount : finAccountList) {
					if (UtilValidate.isNotEmpty(finAccount.get("partyId"))) {
						idsIn.add(finAccount.get("partyId"));
					}
				}
				EntityCondition condt = EntityCondition.makeCondition("partyId", EntityOperator.IN, idsIn);
				conditionList.add(condt);
			}
		}

		// split pages
		int lowIndex = 0;
		int highIndex = 0;
		int viewIndex = 0;
		int viewSize = 20;
		try {
			viewIndex = Integer.parseInt((String) VIEW_INDEX_1);
		} catch (Exception e) {
			lowIndex = 0;
		}
		try {
			viewSize = Integer.parseInt((String) VIEW_SIZE_1);
		} catch (Exception e) {
			viewSize = 20;
		}
		lowIndex = viewIndex * viewSize + 1;
		highIndex = (viewIndex + 1) * viewSize;
		EntityListIterator pli = null;
		try {
			EntityCondition conditionAll = EntityCondition.makeCondition(conditionList, EntityOperator.AND);
			pli = delegator.find("Party", conditionAll, null, null, null, null);
			List<GenericValue> partyList = pli.getPartialList(lowIndex, viewSize);
			int partyListSize = pli.getResultsSizeAfterPartialList();
			if (highIndex > partyListSize) {
				highIndex = partyListSize;
			}
			result.put("userList", partyList);
			result.put("userListSize", partyListSize);
//			for (GenericValue party : partyList) {
//				System.out.println(">>>>>>>>>>>>>>>>>" + party.get("partyId") + "<<<<<<<<<<<<<<<");
//			}
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
		} finally {
			if (pli != null) {
				try {
					pli.close();
				} catch (GenericEntityException e) {
					Debug.logWarning(e, e.getMessage(), module);
				}
			}
		}
		result.put("viewIndex", viewIndex);
		result.put("viewSize", viewSize);
		result.put("highIndex", highIndex);
		result.put("lowIndex", lowIndex);
		result.put("params", params);

		return result;
	}

	public static Map<String, Object> sendRegistConfirmEmail(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map returnMap = FastMap.newInstance();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();
		Object sendToObj = context.get("sendTo");
		Object userLoginIdObj = context.get("userLoginId");
		Object productStoreIdObj = context.get("productStoreId");
		Object verifyCodeObj = context.get("verifyCode");
		String sendTo;
		String userLoginId;
		String productStoreId;
		String verifyCode;
		/*if (UtilValidate.isEmpty(verifyCodeObj)) {
			return ServiceUtil.returnError("verifyCode can not be null!");
		} else {
			verifyCode = verifyCodeObj.toString();
		}*/
		if (UtilValidate.isNotEmpty(verifyCodeObj)) {
			verifyCode = verifyCodeObj.toString();
		}
		if (UtilValidate.isEmpty(sendToObj)) {
			//eturn ServiceUtil.returnError("sendTo can not be null!");
			Debug.logError("sendTo can not be null!", module);
			return ServiceUtil.returnSuccess();
		} else {
			sendTo = sendToObj.toString();
			String[] sendToArr = sendTo.split(",");
			for (String emailAddress : sendToArr) {
				if (!UtilValidate.isEmail(emailAddress)) {
					//return ServiceUtil.returnError("sendTo contains wrong email Address!");
					Debug.logError("sendTo contains wrong email Address!", module);
					return ServiceUtil.returnSuccess();
				}
			}
		}
		if (UtilValidate.isEmpty(userLoginIdObj)) {
			userLoginId = sendToObj.toString();
		} else {
			userLoginId = userLoginIdObj.toString();
		}
		if (UtilValidate.isEmpty(productStoreIdObj)) {
			//return ServiceUtil.returnError("sendTo contains wrong email Address!");
			Debug.logError("sendTo contains wrong email Address!", module);
			return ServiceUtil.returnSuccess();
		} else {
			productStoreId = productStoreIdObj.toString();
		}
		GenericValue autoSendPermis = delegator.findOne("ProductStoreMsgSetting", false, "productStoreId", productStoreId, "eventTypeId", "E_REGISTER", "msgTypeId", "MAIL");
		if (UtilValidate.isEmpty(autoSendPermis)) {
			//return ServiceUtil.returnError("there is no model of register Email!");
			Debug.logError("there is no model of register Email!", module);
			return ServiceUtil.returnSuccess();
		} else if (!autoSendPermis.get("ifAutoSend").equals("1")) {
			//return ServiceUtil.returnError("there is not allowed to auto send register Email!");
			Debug.logError("there is not allowed to auto send register Email!", module);
			return ServiceUtil.returnSuccess();
		}
		String contentId = autoSendPermis.get("contentId").toString();
		if (UtilValidate.isEmpty(contentId)) {
			//return ServiceUtil.returnError("the model has no content!");
			Debug.logError("the model has no content!", module);
			return ServiceUtil.returnSuccess();
		}
		GenericValue contentObj = autoSendPermis.getRelatedOne("Content");
		if (UtilValidate.isEmpty(contentObj)) {
			//return ServiceUtil.returnError("the model has no content!");
			Debug.logError("the model has no content!", module);
			return ServiceUtil.returnSuccess();
		}
		String dataResourceId = contentObj.get("dataResourceId").toString();
		if (UtilValidate.isEmpty(dataResourceId)) {
			//return ServiceUtil.returnError("the model has no content!");
			Debug.logError("the model has no content!", module);
			return ServiceUtil.returnSuccess();
		}
		GenericValue electronicText = delegator.findOne("ElectronicText", false, "dataResourceId", dataResourceId);
		if (UtilValidate.isEmpty(electronicText) || UtilValidate.isEmpty(electronicText.get("textData"))) {
			//return ServiceUtil.returnError("the model has no content!");
			Debug.logError("the model has no content!", module);
			return ServiceUtil.returnSuccess();
		}
		String modelContent = electronicText.get("textData").toString();

		String basePath = UtilProperties.getPropertyValue("contentUpload.properties", "basePath");
		// String linkPlaceHolder =
		// UtilProperties.getPropertyValue("contentUpload.properties",
		// "linkUrlSite");
		// String namePlaceHolder =
		// UtilProperties.getPropertyValue("contentUpload.properties",
		// "nameSite");
		/*String linkPath = basePath + "control/verifyRegister?uName=" + userLoginId + "&verifyCode=" + verifyCode;
		String linkContent = "<a href=\"" + linkPath + "\" target=\"_blank\">" + linkPath + "</a>";
		modelContent = StringUtil.replaceString(modelContent, "{registerVeryficationLinkUrl}", linkContent);*/
		modelContent = StringUtil.replaceString(modelContent, "{partyId}", userLoginId);
		modelContent = StringUtil.replaceString(modelContent, "{username}", userLoginId);
		modelContent = StringUtil.replaceString(modelContent, "{nowDate}", UtilDateTime.nowDateString("yyyy-MM-dd"));

		Map serviceContext = FastMap.newInstance();
		serviceContext.put("body", modelContent);
		serviceContext.put("subject", UtilProperties.getPropertyValue("contentUpload.properties", "registEmailSubject"));
		serviceContext.put("sendTo", sendTo);
		try {
			Map sendReturn = dispatcher.runSync("sendMail", serviceContext);
		} catch (GenericServiceException e) {
			//e.printStackTrace();
			//return ServiceUtil.returnError("sendMail failure!");
			Debug.logError("", module);
			return ServiceUtil.returnSuccess();
		}
		return ServiceUtil.returnSuccess();
	}

	public static Map<String, Object> batchSendEmail(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();
		Map returnMap = FastMap.newInstance();

		Object sendBatchObj = context.get("sendBatch");
		Object contentObj = context.get("content");
		Object subjectObj = context.get("subject");
		Object partyIdListObj = context.get("partyIdList");
		Object userLoginObj = context.get("userLogin");

		String sendBatch = null;
		String subject = null;
		String content = null;
		List<String> partyIdList = null;
		GenericValue userLogin = null;
		if (UtilValidate.isNotEmpty(sendBatchObj)) {
			sendBatch = sendBatchObj.toString();
		}
		if (UtilValidate.isNotEmpty(subjectObj)) {
			subject = subjectObj.toString();
		} else {
			Debug.logError("Email subject can not be null!", module);
			return ServiceUtil.returnSuccess();
		}
		if (UtilValidate.isNotEmpty(contentObj)) {
			content = contentObj.toString();
		} else {
			Debug.logError("Email content can not be null!", module);
			return ServiceUtil.returnSuccess();
		}
		if (UtilValidate.isNotEmpty(partyIdListObj) && partyIdListObj instanceof List) {
			partyIdList = (List<String>) partyIdListObj;
		} else {
			//return ServiceUtil.returnError("partyList can not be null or has no content!");
			Debug.logError("partyList can not be null or has no content!", module);
			return ServiceUtil.returnSuccess();
		}
		if (UtilValidate.isNotEmpty(userLoginObj) && userLoginObj instanceof GenericValue) {
			userLogin = (GenericValue) userLoginObj;
		} else {
			//return ServiceUtil.returnError("userLogin can not be null!");
			Debug.logError("userLogin can not be null!", module);
			return ServiceUtil.returnSuccess();
		}
		// 创建ContactList记录
		String contactListId = delegator.getNextSeqId("ContactList");
		String contactListTypeId = "GROUPMAIL";
		String contactMechTypeId = "EMAIL_ADDRESS";
		String ownerPartyId = (String) userLogin.get("partyId");

		GenericValue contactList = delegator.makeValidValue("ContactList", UtilMisc.toMap("contactListId", contactListId, "contactListTypeId", contactListTypeId, "contactMechTypeId", contactMechTypeId, "ownerPartyId", ownerPartyId));
		contactList.create();

		String communicationEventId = delegator.getNextSeqId("CommunicationEvent");
		String communicationEventTypeId = "EMAIL_COMMUNICATION";
		// contactListId
		// subject
		// content
		String contentMimeTypeId = "text/html";
		String messageId = null;
		if (UtilValidate.isNotEmpty(sendBatch)) {
			messageId = sendBatch;
		}
		// 创建CommunicationEvent记录
		Map commAttrsMap = FastMap.newInstance();
		commAttrsMap.put("communicationEventId", communicationEventId);
		commAttrsMap.put("communicationEventTypeId", communicationEventTypeId);
		commAttrsMap.put("contactListId", contactListId);
		commAttrsMap.put("subject", subject);
		commAttrsMap.put("content", content);
		commAttrsMap.put("contentMimeTypeId", contentMimeTypeId);
		if (UtilValidate.isNotEmpty(messageId))
			commAttrsMap.put("messageId", messageId);
		if (UtilValidate.isNotEmpty(messageId)) {
			try {
				List<GenericValue> checkMessageIds = delegator.findByAnd("CommunicationEvent", "messageId", messageId);
				if (UtilValidate.isNotEmpty(checkMessageIds)) {
					//return ServiceUtil.returnError("发送批次代号已存在!");
					Debug.logError("SendBatch code is already exists!", module);
					return ServiceUtil.returnSuccess();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		GenericValue communicationEvent = delegator.makeValue("CommunicationEvent", commAttrsMap);
		communicationEvent.create();
		// 遍历partyList集合，获取联系方式
		for (String partyId : partyIdList) {
			List<GenericValue> partyContactMechs = delegator.findByAnd("PartyContactMech", "partyId", partyId);
			if (UtilValidate.isNotEmpty(partyContactMechs)) {
				for (GenericValue partyContactMech : partyContactMechs) {
					GenericValue contactMech = delegator.findByPrimaryKey("ContactMech", UtilMisc.toMap("contactMechId", partyContactMech.get("contactMechId")));
					if (UtilValidate.isNotEmpty(contactMech)&&UtilValidate.isNotEmpty(contactMech.get("contactMechTypeId")) && contactMech.get("contactMechTypeId").equals("EMAIL_ADDRESS") && UtilValidate.isEmail((String) contactMech.get("infoString")) && UtilValidate.isNotEmpty(contactMech.get("infoString"))) {
						String sendTo = (String) contactMech.get("infoString");
						Map mailContext = FastMap.newInstance();
						mailContext.put("body", content);
						mailContext.put("contentType", contentMimeTypeId);
						mailContext.put("subject", subject);
						mailContext.put("sendTo", sendTo);
						String statusId = null;
						try {
							Map sendMailReturn = dispatcher.runSync("sendMail", mailContext);
							statusId = "COM_COMPLETE";
						} catch (Exception e) {
							statusId = "COM_PENDING";
							e.printStackTrace();
						}
						// 创建ContactListParty记录
						GenericValue contactListParty = delegator.makeValidValue("ContactListParty", UtilMisc.toMap("contactListId", contactListId, "partyId", partyId, "preferredContactMechId", contactMech.get("contactMechId"), "fromDate", UtilDateTime.nowTimestamp()));
						contactListParty.create();
						// 创建ContactListCommStatus记录
						GenericValue contactListCommStatus = delegator.makeValidValue("ContactListCommStatus",
							UtilMisc.toMap("contactListId", contactListId, "partyId", partyId, "statusId", statusId, "communicationEventId", communicationEventId, "contactMechId", partyContactMech.get("contactMechId")));
						contactListCommStatus.create();
					}
				}
			}
		}
		return ServiceUtil.returnSuccess();
	}

	public static Map<String, Object> batchSendSMS(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();
		final int MAXSIZE = 66;

		Object sendBatchObj = context.get("sendBatch");
		Object contentObj = context.get("content");
		Object subjectObj = context.get("subject");
		Object partyIdListObj = context.get("partyIdList");
		Object userLoginObj = context.get("userLogin");

		String sendBatch = null;
		String subject = null;
		String content = null;
		List<String> partyIdList = null;
		GenericValue userLogin = null;
		if (UtilValidate.isNotEmpty(sendBatchObj)) {
			sendBatch = sendBatchObj.toString();
		}
		if (UtilValidate.isNotEmpty(subjectObj)) {
			subject = subjectObj.toString();
		} else {
			//return ServiceUtil.returnError("Email subject can not be null!");
			Debug.logError("Email subject can not be null!", module);
			return ServiceUtil.returnSuccess();
		}
		if (UtilValidate.isNotEmpty(contentObj)) {
			content = contentObj.toString();
		} else {
			//return ServiceUtil.returnError("Email content can not be null!");
			Debug.logError("Email content can not be null!", module);
			return ServiceUtil.returnSuccess();
		}
		if (UtilValidate.isNotEmpty(partyIdListObj) && partyIdListObj instanceof List) {
			partyIdList = (List<String>) partyIdListObj;
		} else {
			//return ServiceUtil.returnError("partyList can not be null or has no content!");
			Debug.logError("partyList can not be null or has no content!", module);
			return ServiceUtil.returnSuccess();
		}
		if (UtilValidate.isNotEmpty(userLoginObj) && userLoginObj instanceof GenericValue) {
			userLogin = (GenericValue) userLoginObj;
		} else {
			//return ServiceUtil.returnError("userLogin can not be null!");
			Debug.logError("userLogin can not be null!", module);
			return ServiceUtil.returnSuccess();
		}
		// 创建ContactList记录
		String contactListId = delegator.getNextSeqId("ContactList");
		String contactListTypeId = "GROUPSMS";
		String contactMechTypeId = "TELECOM_NUMBER";
		String ownerPartyId = (String) userLogin.get("partyId");

		GenericValue contactList = delegator.makeValidValue("ContactList", UtilMisc.toMap("contactListId", contactListId, "contactListTypeId", contactListTypeId, "contactMechTypeId", contactMechTypeId, "ownerPartyId", ownerPartyId));
		contactList.create();

		String communicationEventId = delegator.getNextSeqId("CommunicationEvent");
		String communicationEventTypeId = "SMS_COMMUNICATION";
		// contactListId
		// subject
		// content
		String messageId = null;
		if (UtilValidate.isNotEmpty(sendBatch)) {
			messageId = sendBatch;
		}
		// 创建CommunicationEvent记录
		Map commAttrsMap = FastMap.newInstance();
		commAttrsMap.put("communicationEventId", communicationEventId);
		commAttrsMap.put("communicationEventTypeId", communicationEventTypeId);
		commAttrsMap.put("contactListId", contactListId);
		commAttrsMap.put("subject", subject);
		commAttrsMap.put("content", content);
		if (UtilValidate.isNotEmpty(messageId))
			commAttrsMap.put("messageId", messageId);
		if (UtilValidate.isNotEmpty(messageId)) {
			try {
				List<GenericValue> checkMessageIds = delegator.findByAnd("CommunicationEvent", "messageId", messageId);
				if (UtilValidate.isNotEmpty(checkMessageIds)) {
					//return ServiceUtil.returnError("发送批次代号已存在!");
					Debug.logError("SendBatch code is already exists!", module);
					return ServiceUtil.returnSuccess();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		GenericValue communicationEvent = delegator.makeValue("CommunicationEvent", commAttrsMap);
		communicationEvent.create();
		// 组织短信内容
		List<String> smsContentList = FastList.newInstance();
		if (content.length() > MAXSIZE) {
			int max = content.length();
			for (int i = 0; i < max; i += MAXSIZE) {
				int last = i + MAXSIZE;
				if (last >= max)
					last = max;
				smsContentList.add(content);
			}
		} else {
			smsContentList.add(content.toString());
		}
		List<Map> contactInfoList = FastList.newInstance();
		Map partyAvaliableContactInfo = null;
		StringBuilder mobileNumSB = new StringBuilder("");
		// 遍历partyList集合，获取联系方式
		for (String partyId : partyIdList) {
			/*List<GenericValue> partyContactMechs = delegator.findByAnd("PartyContactMech", "partyId", partyId);
			if (UtilValidate.isNotEmpty(partyContactMechs)) {
				for (GenericValue partyContactMech : partyContactMechs) {
					GenericValue contactMech = delegator.findByPrimaryKey("ContactMech", UtilMisc.toMap("contactMechId", partyContactMech.get("contactMechId")));
					if (UtilValidate.isNotEmpty(contactMech) && (UtilValidate.isEmpty(contactMech.get("contactMechTypeId"))||contactMech.get("contactMechTypeId").equals("POSTAL_ADDRESS"))) {
						GenericValue telecomNum = delegator.findByPrimaryKey("TelecomNumber", UtilMisc.toMap("contactMechId", partyContactMech.get("contactMechId")));
						if (UtilValidate.isNotEmpty(telecomNum)) {
							if (UtilValidate.isNotEmpty(telecomNum.get("contactNumber"))
								&& (((telecomNum.getString("contactNumber")).startsWith("01") && (telecomNum.getString("contactNumber")).length() == 12) || ((telecomNum.getString("contactNumber")).startsWith("1")) && (telecomNum.getString("contactNumber")).length() == 11)) {
								String mobileNum = telecomNum.getString("contactNumber");
								mobileNumSB.append(mobileNum+";");
								partyAvaliableContactInfo = FastMap.newInstance();
								partyAvaliableContactInfo.put("partyId", partyId);
								partyAvaliableContactInfo.put("contactMechId", contactMech.get("contactMechId"));
								contactInfoList.add(partyAvaliableContactInfo);
								//String statusId = sendSMS(smsContentList,mobileNum);
								/*发送短信
								String statusId = "COM_COMPLETE";
								for (String smsContent : smsContentList) {
									Client hc = null;
									try {
										//StringBuffer ustr = new StringBuffer("http://www.ixtoo.com/sms/sms_message2.jsp?user=rosso&pass=rosso123");
										StringBuffer ustr = new StringBuffer("http://119.254.104.137:8080/ystSms/sms_message2.jsp?user=rosso&pass=rosso123");
										ustr.append("&mobile=").append(mobileNum);
										ustr.append("&msg=").append(URLEncoder.encode(smsContent, "utf-8"));
										//ustr.append("&msgid=1");
										//ustr.append("&sendtime="+UtilDateTime.nowDateString("yyyy-MM-dd.HH:mm:ss"));
										GetMethod method = new GetMethod(ustr.toString());
										hc = new HttpClient(method);
										int status = hc.executeMethod();
										String strState = hc.getResponseBodyAsString().trim();
										System.out.println(">>>>>>>>>>>>>>>>>>>>:"+strState);
										//int state = Integer.parseInt(strState.substring(0, strState.indexOf(",")).trim());
										int state = Integer.parseInt(strState);
										if (state != 0) {
											statusId = "COM_PENDING";
										}
									} catch (Exception e) {
										e.printStackTrace();
									} finally {
										if (hc != null)
											hc.shutDown();
									}
								}*/
								/* 创建ContactListParty记录
								GenericValue contactListParty = delegator.makeValidValue("ContactListParty", UtilMisc.toMap("contactListId", contactListId, "partyId", partyId, "preferredContactMechId", contactMech.get("contactMechId"), "fromDate", UtilDateTime.nowTimestamp()));
								contactListParty.create();
								// 创建ContactListCommStatus记录
								GenericValue contactListCommStatus = delegator.makeValidValue("ContactListCommStatus",
									UtilMisc.toMap("contactListId", contactListId, "partyId", partyId, "statusId", statusId, "communicationEventId", communicationEventId, "contactMechId", partyContactMech.get("contactMechId")));
								contactListCommStatus.create();
								* /
							}
						}
					}
				}
			}*/
			Map<String, Object> contactMeches = ContactMechTools.getPrimaryPartyContactMechValueMaps(delegator, partyId, false);
			if(UtilValidate.isNotEmpty(contactMeches.get("mobileNumber"))){
				GenericValue mobileNumber =	(GenericValue)contactMeches.get("mobileNumber");
				if(UtilValidate.isNotEmpty(mobileNumber.getString("contactNumber"))){
					String mobileNum = mobileNumber.getString("contactNumber");
					mobileNumSB.append(mobileNum+";");
					partyAvaliableContactInfo = FastMap.newInstance();
					partyAvaliableContactInfo.put("partyId", partyId);
					partyAvaliableContactInfo.put("contactMechId", mobileNumber.get("contactMechId"));
					contactInfoList.add(partyAvaliableContactInfo);
				}
			}
		}
		String mobileNums = mobileNumSB.toString();
		if(mobileNums.length()>0){
			mobileNums = mobileNums.substring(0, mobileNums.length()-1);
			//发送短信
			String statusId = sendSMS(smsContentList,mobileNums);
			//遍历有效信息集合，创建数据库存储
			if(!statusId.equals("error")){
				for(Map m:contactInfoList){
					// 创建ContactListParty记录
					GenericValue contactListParty = delegator.makeValidValue("ContactListParty", UtilMisc.toMap("contactListId", contactListId, "partyId", m.get("partyId"), "preferredContactMechId", m.get("contactMechId"), "fromDate", UtilDateTime.nowTimestamp()));
					contactListParty.create();
					// 创建ContactListCommStatus记录
					GenericValue contactListCommStatus = delegator.makeValidValue("ContactListCommStatus",
						UtilMisc.toMap("contactListId", contactListId, "partyId", m.get("partyId"), "statusId", statusId, "communicationEventId", communicationEventId, "contactMechId", m.get("contactMechId")));
					contactListCommStatus.create();
				}
			}
		}
		return ServiceUtil.returnSuccess();
	}
	
	//发送短信
	public static String sendSMS(List<String> smsContentList,String mobileNum){
		String statusId = "COM_COMPLETE";
		for (String smsContent : smsContentList) {
			Client hc = null;
			try {
				//StringBuffer ustr = new StringBuffer("http://www.ixtoo.com/sms/sms_message2.jsp?user=rosso&pass=rosso123");
				StringBuffer ustr = new StringBuffer("http://119.254.104.137:8080/ystSms/sms_message2list.jsp?user=rosso&pass=rosso123");
				ustr.append("&mobile=").append(mobileNum);
				ustr.append("&msg=").append(URLEncoder.encode(smsContent, "utf-8"));
				//ustr.append("&msgid=1");
				//ustr.append("&sendtime="+UtilDateTime.nowDateString("yyyy-MM-dd.HH:mm:ss"));
				GetMethod method = new GetMethod(ustr.toString());
				hc = new HttpClient(method);
				int status = hc.executeMethod();
				String strState = hc.getResponseBodyAsString().trim();
				System.out.println(">>>>>>>>>>>>>>>>>>>>:"+strState);
				//int state = Integer.parseInt(strState.substring(0, strState.indexOf(",")).trim());
				if(UtilValidate.isInteger(strState)){
					int state = Integer.parseInt(strState);
					if (state != 0) {
						statusId = "COM_PENDING";
					}
				}else{
					statusId = "error";
				}
			} catch (Exception e) {
				e.printStackTrace();
				statusId = "error";
			} finally {
				if (hc != null)
					hc.shutDown();
			}
		}
		return statusId;
	}
	/**
	 * 各个事件节点自动发送邮件服务
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
	public static Map<String, Object> autoSendEventMailService(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();
		final int MAXSIZE = 66;

		String productStoreId = (String) context.get("productStoreId");
		String eventTypeId = (String) context.get("eventTypeId");
		String msgTypeId = (String) context.get("msgTypeId");
		String partyId = (String) context.get("partyId");
		String orderId = (String) context.get("orderId");
		String sendTo = (String) context.get("sendTo");
		String sendCc = (String) context.get("sendCc");
		String sendBcc = (String) context.get("sendBcc");
		List<String> productIdList = (List<String>) context.get("productIdList");
		List<String> returnBackProductIdList = (List<String>) context.get("returnBackProductIdList");
		String contentType = (String) context.get("contentType");
		String findBackPassword = (String) context.get("findBackPassword");
		String newPassword = (String) context.get("newPassword");
		String paymentAmount = (String) context.get("paymentAmount");
		String userName = (String) context.get("userName");
		String memberCardId = (String) context.get("memberCardId");
		String returnBackPayment = (String) context.get("returnBackPayment");

		GenericValue productStoreMsgSettingObj = delegator.findByPrimaryKey("ProductStoreMsgSetting", UtilMisc.toMap("productStoreId", productStoreId, "eventTypeId", eventTypeId, "msgTypeId", msgTypeId));
		if (UtilValidate.isEmpty(productStoreMsgSettingObj)) {
			//return ServiceUtil.returnError("No \"" + msgTypeId + "\" model defined on this event:\"" + eventTypeId + "\"");
			Debug.logError("No \"" + msgTypeId + "\" model defined on this event:\"" + eventTypeId + "\"", module);
			return ServiceUtil.returnSuccess();
		}
		String ifAutoSend = (String) productStoreMsgSettingObj.get("ifAutoSend");
		if (ifAutoSend.equals("0")) {
			//return ServiceUtil.returnError("Mail model unused!");
			Debug.logError("Mail model unused!", module);
			return ServiceUtil.returnSuccess();
		}
		// 获取模板内容信息
		String subject = (String) productStoreMsgSettingObj.get("subject");
		String content = (String) productStoreMsgSettingObj.get("content");
		try {
			String contentId = (String) productStoreMsgSettingObj.get("contentId");
			if (UtilValidate.isNotEmpty(contentId)) {
				GenericValue contentObj = delegator.findByPrimaryKey("Content", UtilMisc.toMap("contentId", contentId));
				if (!contentObj.get("contentTypeId").equals("NOE_TEMPLATE")) {
					//return ServiceUtil.returnError("Model content missing!");
					Debug.logError("Model content missing!", module);
					return ServiceUtil.returnSuccess();
				}
				GenericValue electronicTextObj = null;
				if (UtilValidate.isNotEmpty(contentObj.get("dataResourceId"))) {
					electronicTextObj = delegator.findByPrimaryKey("ElectronicText", UtilMisc.toMap("dataResourceId", contentObj.get("dataResourceId")));
				}
				if (UtilValidate.isNotEmpty(electronicTextObj) && UtilValidate.isNotEmpty(electronicTextObj.get("textData"))) {
					content = (String) electronicTextObj.get("textData");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			//return ServiceUtil.returnError("Mail model missing!");
			Debug.logError("Mail model missing!", module);
			return ServiceUtil.returnSuccess();
		}
		// 替换内容的占位符
		String name = null;
		String productNames = null;
		String returnBackProducts = null;
		String nowDate = UtilDateTime.nowDateString("yyyy-MM-dd");
		if (UtilValidate.isEmpty(findBackPassword)) {
			if (content.contains("{findBackPassword}".subSequence(0, "{findBackPassword}".length()))) {
				//return ServiceUtil.returnError("arguments didn't contains used PlaceHolder:findBackPassword");
				Debug.logError("arguments didn't contains used PlaceHolder:findBackPassword", module);
				return ServiceUtil.returnSuccess();
			}
		}
		if (UtilValidate.isEmpty(newPassword)) {
			if (content.contains("{newPassword}".subSequence(0, "{newPassword}".length()))) {
				//return ServiceUtil.returnError("arguments didn't contains used PlaceHolder:newPassword");
				Debug.logError("arguments didn't contains used PlaceHolder:newPassword", module);
				return ServiceUtil.returnSuccess();
			}
		}
		if (UtilValidate.isEmpty(paymentAmount)) {
			if (content.contains("{paymentAmount}".subSequence(0, "{paymentAmount}".length()))) {
				//return ServiceUtil.returnError("arguments didn't contains used PlaceHolder:paymentAmount");
				Debug.logError("arguments didn't contains used PlaceHolder:paymentAmount", module);
				return ServiceUtil.returnSuccess();
			}
		}
		if (UtilValidate.isEmpty(userName)) {
			if (content.contains("{userName}".subSequence(0, "{userName}".length()))) {
				//return ServiceUtil.returnError("arguments didn't contains used PlaceHolder:userName");
				Debug.logError("arguments didn't contains used PlaceHolder:userName", module);
				return ServiceUtil.returnSuccess();
			}
		}
		if (UtilValidate.isEmpty(memberCardId)) {
			if (content.contains("{memberCardId}".subSequence(0, "{memberCardId}".length()))) {
				//return ServiceUtil.returnError("arguments didn't contains used PlaceHolder:memberCardId");
				Debug.logError("arguments didn't contains used PlaceHolder:memberCardId", module);
				return ServiceUtil.returnSuccess();
			}
		}
		if (UtilValidate.isEmpty(orderId)) {
			if (content.contains("{orderId}".subSequence(0, "{orderId}".length()))) {
				//return ServiceUtil.returnError("arguments didn't contains used PlaceHolder:orderId");
				Debug.logError("arguments didn't contains used PlaceHolder:orderId", module);
				return ServiceUtil.returnSuccess();
			}
		}
		if (UtilValidate.isEmpty(returnBackPayment)) {
			if (content.contains("{returnBackPayment}".subSequence(0, "{returnBackPayment}".length()))) {
				//return ServiceUtil.returnError("arguments didn't contains used PlaceHolder:returnBackPayment");
				Debug.logError("arguments didn't contains used PlaceHolder:returnBackPayment", module);
				return ServiceUtil.returnSuccess();
			}
		}

		GenericValue partyObj = delegator.findByPrimaryKey("Party", UtilMisc.toMap("partyId", partyId));
		if (UtilValidate.isNotEmpty(partyObj)) {
			if (partyObj.get("partyTypeId").equals("PARTY_GROUP")) {
				name = (String) delegator.findByPrimaryKey("PartyGroup", UtilMisc.toMap("partyId", partyId)).get("groupNsame");
			} else if (partyObj.get("partyTypeId").equals("PERSON")) {
				GenericValue personObj = delegator.findByPrimaryKey("Person", UtilMisc.toMap("partyId", partyId));
				String personalTitle = UtilValidate.isEmpty(personObj.get("personalTitle"))?"":(String)personObj.get("personalTitle");
				String firstName = UtilValidate.isEmpty(personObj.get("firstName"))?"":(String)personObj.get("firstName");
				String middleName =UtilValidate.isEmpty(personObj.get("middleName"))?"":(String)personObj.get("middleName");
				String lastName =UtilValidate.isEmpty(personObj.get("lastName"))?"":(String)personObj.get("lastName");
				name = (personalTitle + firstName + middleName + lastName).trim();
			}
		}

		if (UtilValidate.isNotEmpty(productIdList)) {
			StringBuilder sb = new StringBuilder("");
			for (String productId : productIdList) {
				String productName = (String) delegator.findByPrimaryKey("Product", UtilMisc.toMap("productId", productId)).get("productName");
				if (UtilValidate.isNotEmpty(productName)) {
					sb.append(productName);
				} else {
					sb.append("编号：" + productId + "商品");
				}
				sb.append("、");
			}
			productNames = sb.toString();
			productNames = productNames.substring(0, productNames.length() - 1);
		} else {
			if (content.contains("{productIdList}".subSequence(0, "{productIdList}".length()))) {
				//return ServiceUtil.returnError("arguments didn't contains used PlaceHolder:productIdList");
				Debug.logError("arguments didn't contains used PlaceHolder:productIdList", module);
				return ServiceUtil.returnSuccess();
			}
		}

		if (UtilValidate.isNotEmpty(returnBackProductIdList)) {
			StringBuilder sb = new StringBuilder("");
			for (String productId : returnBackProductIdList) {
				String productName = (String) delegator.findByPrimaryKey("Product", UtilMisc.toMap("productId", productId)).get("productName");
				if (UtilValidate.isNotEmpty(productName)) {
					sb.append(productName);
				} else {
					sb.append("编号：" + productId + "商品");
				}
				sb.append("、");
			}
			returnBackProducts = sb.toString();
			returnBackProducts = returnBackProducts.substring(0, returnBackProducts.length() - 1);
		} else {
			if (content.contains("{returnBackProducts}".subSequence(0, "{returnBackProducts}".length()))) {
				//return ServiceUtil.returnError("arguments didn't contains used PlaceHolder:returnBackProducts");
				Debug.logError("arguments didn't contains used PlaceHolder:returnBackProducts", module);
				return ServiceUtil.returnSuccess();
			}
		}

		content = StringUtil.replaceString(content, "{partyId}", UtilValidate.isEmpty(name) ? partyId : name);
		content = StringUtil.replaceString(content, "{productIdList}", productNames);
		content = StringUtil.replaceString(content, "{paymentAmount}", paymentAmount);
		content = StringUtil.replaceString(content, "{newPassword}", newPassword);
		content = StringUtil.replaceString(content, "{findBackPassword}", findBackPassword);
		content = StringUtil.replaceString(content, "{nowDate}", nowDate);
		content = StringUtil.replaceString(content, "{orderId}", orderId);
		content = StringUtil.replaceString(content, "{returnBackProductIdList}", returnBackProducts);
		content = StringUtil.replaceString(content, "{username}", userName);
		content = StringUtil.replaceString(content, "{memberCardId}", memberCardId);
		content = StringUtil.replaceString(content, "{returnBackPayment}", returnBackPayment);
		// 发送方式组织
		if (msgTypeId.equals("MAIL")) {
			// 邮件
			if (UtilValidate.isEmpty(sendTo)) {
				if (UtilValidate.isEmpty(partyId)) {
					//return ServiceUtil.returnError("contactMech missing,one of sendTo and partyId is required!");
					Debug.logError("contactMech missing,one of sendTo and partyId is required!", module);
					return ServiceUtil.returnSuccess();
				}
				
				Map contactMeches = ContactMechTools.getPrimaryPartyContactMechValueMaps(delegator, partyId, false);
				if(UtilValidate.isNotEmpty(contactMeches.get("emailAddress"))){
					GenericValue emailAddress = (GenericValue)contactMeches.get("emailAddress");
					if(UtilValidate.isNotEmpty(emailAddress.get("infoString"))){
						sendTo = emailAddress.getString("infoString");
					}else{
						Debug.logError("Party contactMech missing!", module);
						return ServiceUtil.returnSuccess();
					}
				}else{
					Debug.logError("Party contactMech missing!", module);
					return ServiceUtil.returnSuccess();
				}
				/*List<GenericValue> partyContactMechList = delegator.findByAnd("PartyContactMech", UtilMisc.toMap("partyId", partyId));
				if (UtilValidate.isEmpty(partyContactMechList)) {
					//return ServiceUtil.returnError("Party contactMech missing!");
					Debug.logError("Party contactMech missing!", module);
					return ServiceUtil.returnSuccess();
				}
				for (GenericValue partyContactMechObj : partyContactMechList) {
					GenericValue contactMechObj = delegator.findByPrimaryKey("ContactMech", UtilMisc.toMap("contactMechId", partyContactMechObj.get("contactMechId")));
					if (UtilValidate.isNotEmpty(contactMechObj) &&UtilValidate.isNotEmpty(contactMechObj.get("contactMechTypeId")) && contactMechObj.get("contactMechTypeId").equals("EMAIL_ADDRESS") && UtilValidate.isNotEmpty(contactMechObj.get("contactMechTypeId")) && UtilValidate.isEmail((String) contactMechObj.get("infoString"))) {
						sendTo = contactMechObj.get("infoString").toString();
						break;
					}
				}*/
				
				if (UtilValidate.isEmpty(sendTo)) {
					//return ServiceUtil.returnError("Party contactMech missing!");
					Debug.logError("Party contactMech missing!", module);
					return ServiceUtil.returnSuccess();
				}
			}
			Map serviceContext = FastMap.newInstance();
			serviceContext.put("body", content);
			serviceContext.put("subject", subject);
			serviceContext.put("sendTo", sendTo);
			if (UtilValidate.isNotEmpty(contentType)) {
				serviceContext.put("contentType", contentType);
			}
			if (UtilValidate.isNotEmpty(sendCc)) {
				serviceContext.put("sendCc", sendCc);
			}
			if (UtilValidate.isNotEmpty(sendBcc)) {
				serviceContext.put("sendBcc", sendBcc);
			}
			try {
				Map sendReturn = dispatcher.runSync("sendMail", serviceContext);
				if (ServiceUtil.isError(sendReturn)) {
					//return ServiceUtil.returnError("sendMail failure!");
					Debug.logError("sendMail failure!", module);
					return ServiceUtil.returnSuccess();
				}
			} catch (GenericServiceException e) {
				e.printStackTrace();
				//return ServiceUtil.returnError("sendMail failure!");
				Debug.logError("sendMail failure!", module);
				return ServiceUtil.returnSuccess();
			}
			return ServiceUtil.returnSuccess();
		}
		if (msgTypeId.equals("SMS")) {
			// 短信
			if (UtilValidate.isEmpty(partyId)) {
				//return ServiceUtil.returnError("contactMech missing,one of sendTo and partyId is required!");
				Debug.logError("contactMech missing,one of sendTo and partyId is required!", module);
				return ServiceUtil.returnSuccess();
			}
			/*List<GenericValue> partyContactMechList = delegator.findByAnd("PartyContactMech", UtilMisc.toMap("partyId", partyId));
			if (UtilValidate.isEmpty(partyContactMechList)) {
				//return ServiceUtil.returnError("Party contactMech missing!");
				Debug.logError("Party contactMech missing!", module);
				return ServiceUtil.returnSuccess();
			}
			for (GenericValue partyContactMechObj : partyContactMechList) {
				GenericValue telecomNumObj = delegator.findByPrimaryKey("TelecomNumber", UtilMisc.toMap("contactMechId", partyContactMechObj.get("contactMechId")));
				if (UtilValidate.isNotEmpty(telecomNumObj) && UtilValidate.isNotEmpty(telecomNumObj.get("contactNumber"))) {
					sendTo = telecomNumObj.getString("contactNumber");
					break;
				}
			}*/
			Map contactMeches = ContactMechTools.getPrimaryPartyContactMechValueMaps(delegator, partyId, false);
			if(UtilValidate.isNotEmpty(contactMeches.get("mobileNumber"))){
				GenericValue mobileNumber = (GenericValue)contactMeches.get("mobileNumber");
				if(UtilValidate.isNotEmpty(mobileNumber.get("contactNumber"))){
					sendTo = mobileNumber.getString("contactNumber");
				}else{
					Debug.logError("Party contactMech missing!", module);
					return ServiceUtil.returnSuccess();
				}
			}else{
				Debug.logError("Party contactMech missing!", module);
				return ServiceUtil.returnSuccess();
			}
			if (UtilValidate.isEmpty(sendTo)) {
				//return ServiceUtil.returnError("Party mobileNum missing!");
				Debug.logError("Party mobileNum missing!", module);
				return ServiceUtil.returnSuccess();
			}
			// 组织短信内容
			List<String> smsContentList = FastList.newInstance();
			if (content.length() > MAXSIZE) {
				int max = content.length();
				for (int i = 0; i < max; i += MAXSIZE) {
					int last = i + MAXSIZE;
					if (last >= max)
						last = max;
					smsContentList.add(content);
				}
			} else {
				smsContentList.add(content.toString());
			}
			// 发送短信
			boolean sendStatus = true;
			for (String smsContent : smsContentList) {
				Client hc = null;
				try {
					StringBuffer ustr = new StringBuffer("http://119.254.104.137:8080/ystSms/sms_message2list.jsp?user=rosso&pass=rosso123");
					ustr.append("&mobile=").append(sendTo);
					ustr.append("&msg=").append(URLEncoder.encode(smsContent, "utf-8"));
					GetMethod method = new GetMethod(ustr.toString());
					hc = new HttpClient(method);
					int status = hc.executeMethod();
					String strState = hc.getResponseBodyAsString().trim();
					System.out.println(">>>>>>>>>>>>>>>>>>>>:"+strState);
					//int state = Integer.parseInt(strState.substring(0, strState.indexOf(",")).trim());
					if(UtilValidate.isInteger(strState)){
						int state = Integer.parseInt(strState);
						if (state != 0) {
							sendStatus = false;
						}
					}else{
						sendStatus = false;
					}
				} catch (Exception e) {
					e.printStackTrace();
					//return ServiceUtil.returnError("Send mail falure!");
					Debug.logError("Send mail falure!", module);
					return ServiceUtil.returnSuccess();
				} finally {
					if (hc != null)
						hc.shutDown();
				}
			}
			if (sendStatus) {
				return ServiceUtil.returnSuccess();
			} else {
				//return ServiceUtil.returnError("Send mail is not completed!");
				Debug.logError("Send mail is not completed!", module);
				return ServiceUtil.returnSuccess();
			}
		}
		if (msgTypeId.equals("INTERNAL_MSG")) {
			// 站内消息
			GenericValue userLogin = delegator.findOne("UserLogin", true, UtilMisc.toMap("userLoginId", "system"));
			Map commArgs = FastMap.newInstance();
			commArgs.put("communicationEventId", delegator.getNextSeqId("CommunicationEvent"));
			commArgs.put("subject", subject);
			commArgs.put("content", content);
			commArgs.put("communicationEventTypeId", "NOTICE_COMMUNICATION");
			commArgs.put("partyIdTo", partyId);
			commArgs.put("userLogin", userLogin);
			try{
				dispatcher.runSync("createCommunicationEvent", commArgs);
			}catch(Exception e){
				Debug.logError(e, module);
			}
			/*
			<entity-one entity-name="UserLogin" value-field="sysUserLogin">
                <field-map field-name="userLoginId" value="system"/>
            </entity-one>
            String communicationEventId = delegator.getNextSeqId("CommunicationEvent");
			GenericValue communicationEventObj = delegator.makeValue("CommunicationEvent", UtilMisc.toMap("communicationEventId", communicationEventId, "subject", subject, "content", content, "communicationEventTypeId", "NOTICE_COMMUNICATION", "partyIdTo", partyId));
			communicationEventObj.create();
			*/
		}
		return ServiceUtil.returnSuccess();
	}

	public static Map<String, Object> createRegion(DispatchContext dctx, Map<String, ? extends Object> context) {
		Delegator delegator = dctx.getDelegator();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		GenericValue userLogin = (GenericValue) context.get("userLogin");
		Map result = new HashMap();
		Map<String, Object> geoResult;
		String geoName = (String) context.get("geoName");
		String navTabId = (String) context.get("navTabId");
		String callbackType = (String) context.get("callbackType");
		String geoTypeId = (String) context.get("geoTypeId");
		String geoCode = (String) context.get("geoCode");
		String parentGeoId = (String) context.get("parentGeoId");
		Long sequenceNum = (Long) context.get("sequenceNum");
		String geoId = null;
		try {
			Map<String, Object> geoContextMap = new HashMap<String, Object>();
			geoId = delegator.getNextSeqId("Geo");
			geoContextMap.put("userLogin", userLogin);
			geoContextMap.put("geoId", geoId);
			geoContextMap.put("geoName", geoName);
			geoContextMap.put("geoTypeId", geoTypeId);
			geoContextMap.put("geoCode", geoCode);
			geoResult = dispatcher.runSync("createGeo", geoContextMap);
		} catch (GenericServiceException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(e.getMessage());
		}
		if (geoResult == null) {
			String errMsg = ServiceUtil.getErrorMessage(geoResult);
			Debug.logError(errMsg, module);
			return ServiceUtil.returnError(errMsg);
		}
		if (ServiceUtil.isError(geoResult)) {
			String errMsg = ServiceUtil.getErrorMessage(geoResult);
			Debug.logError(errMsg, module);
			return ServiceUtil.returnError(errMsg);
		}
		try {
			if (UtilValidate.isNotEmpty(parentGeoId)) {
				GenericValue geoAssoc = delegator.makeValue("GeoAssoc");
				geoAssoc.put("geoId", parentGeoId);
				geoAssoc.put("geoIdTo", geoId);
				geoAssoc.put("sequenceNum", sequenceNum);
				geoAssoc.put("geoAssocTypeId", "REGIONS");
				geoAssoc.create();
			}
		} catch (GenericEntityException e) {
			String errMsg = "Error creating new virtual product from variant products: " + e.toString();
			Debug.logError(e, errMsg, module);
		}
		result.put("geoId", geoId);
		result.put("navTabId", navTabId);
		result.put("callbackType", callbackType);
		return result;
	}

	public static String createRegionByRequest(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		GenericDelegator delegator = (GenericDelegator) request.getAttribute("delegator");
		try {
			Map<String, Object> geoContextMap = new HashMap<String, Object>();
			geoContextMap.put("userLogin", userLogin);
			String geoId = delegator.getNextSeqId("Geo");
			geoContextMap.put("geoId", geoId);
			geoContextMap.put("geoName", request.getParameter("geoName"));
			geoContextMap.put("geoTypeId", request.getParameter("geoTypeId"));
			geoContextMap.put("geoCode", request.getParameter("geoCode"));
			ModelService pService = dispatcher.getDispatchContext().getModelService("createGeo");
			geoContextMap = pService.makeValid(geoContextMap, ModelService.IN_PARAM);
			Map<String, Object> result = dispatcher.runSync(pService.name, geoContextMap);

			String parentGeoId = request.getParameter("parentGeoId");
			if (UtilValidate.isNotEmpty(parentGeoId)) {
				GenericValue geoAssoc = delegator.makeValue("GeoAssoc");
				geoAssoc.put("geoId", parentGeoId);
				geoAssoc.put("geoIdTo", geoId);
				geoAssoc.put("sequenceNum", Long.valueOf(request.getParameter("sequenceNum")));
				geoAssoc.put("geoAssocTypeId", "REGIONS");
				geoAssoc.create();
			}
			Map<String, Object> resMap = FastMap.newInstance();
			resMap.put("geoId", geoId);
			resMap.put("navTabId", "EditRegion");
			resMap.put("callbackType", "closeCurrent");
			resMap.put("message", "新建地区成功");
			resMap.put("statusCode", "200");
			request.setAttribute("geoId", geoId);
			toJsonObject(resMap, response);

		} catch (Exception e) {
			Debug.logError(e.getMessage(), module);
			return ModelService.RESPOND_ERROR;
		}
		return ModelService.RESPOND_SUCCESS;
	}

	public static String updateRegion(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		GenericDelegator delegator = (GenericDelegator) request.getAttribute("delegator");
		try {
			String geoId = request.getParameter("geoId");
			Map<String, Object> geoContextMap = new HashMap<String, Object>();
			geoContextMap.put("userLogin", userLogin);
			geoContextMap.put("geoId", geoId);
			geoContextMap.put("geoName", request.getParameter("geoName"));
			geoContextMap.put("geoTypeId", request.getParameter("geoTypeId"));
			geoContextMap.put("geoCode", request.getParameter("geoCode"));
			ModelService pService = dispatcher.getDispatchContext().getModelService("updateGeo");
			geoContextMap = pService.makeValid(geoContextMap, ModelService.IN_PARAM);
			Map<String, Object> result = dispatcher.runSync(pService.name, geoContextMap);
			String parentGeoId = request.getParameter("parentGeoId");
			if (UtilValidate.isNotEmpty(parentGeoId)) {
				GenericValue gv = delegator.findByPrimaryKey("GeoAssoc", UtilMisc.toMap("geoId", parentGeoId, "geoIdTo", geoId));
				if (UtilValidate.isEmpty(gv)) {
					delegator.removeByAnd("GeoAssoc", UtilMisc.toMap("geoIdTo", geoId));
					GenericValue geoAssoc = delegator.makeValue("GeoAssoc");
					geoAssoc.put("geoId", parentGeoId);
					geoAssoc.put("geoIdTo", geoId);
					geoAssoc.put("sequenceNum", Long.valueOf(request.getParameter("sequenceNum")));
					geoAssoc.put("geoAssocTypeId", "REGIONS");
					geoAssoc.create();
				} else {
					gv.put("sequenceNum", Long.valueOf(request.getParameter("sequenceNum")));
					gv.store();
				}
			} else {
				delegator.removeByAnd("GeoAssoc", UtilMisc.toMap("geoIdTo", geoId));
			}
			Map<String, Object> resMap = FastMap.newInstance();
			resMap.put("navTabId", "EditRegion");
			resMap.put("geoId", geoId);
			resMap.put("callbackType", "closeCurrent");
			resMap.put("message", "修改地区成功");
			resMap.put("statusCode", "200");
			toJsonObject(resMap, response);

		} catch (Exception e) {
			Debug.logError(e.getMessage(), module);
			return ModelService.RESPOND_ERROR;
		}
		return ModelService.RESPOND_SUCCESS;
	}

	public static Map<String, Object> deleteRegion(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Delegator delegator = dctx.getDelegator();
		Map result = ServiceUtil.returnSuccess();
		String geoId = (String) context.get("geoId");
		List<GenericValue> geoAssocs = delegator.findByAnd("GeoAssoc", UtilMisc.toMap("geoId", geoId));
		if (UtilValidate.isNotEmpty(geoAssocs)) {
			// ShopUtil.returnTitleMessage(result, false, "delete");
			result = ServiceUtil.returnError("不能删除带有子地区的地区，删除失败！");
		} else {
			// delete
			delegator.removeByAnd("GeoAssoc", UtilMisc.toMap("geoIdTo", geoId));
			GenericValue gv = delegator.findByPrimaryKey("Geo", UtilMisc.toMap("geoId", geoId));
			gv.remove();
		}
		// ShopUtil.returnTitleMessage(result,true,"delete");
		return result;
	}

	/**
	 * 图片设置附件处理
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static String uploadProductImageSetting(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		try {
			String imageTypeId = request.getParameter("imageTypeId");
			String imageUrlPrefix = UtilProperties.getPropertyValue("productUpload", "product.uploadfile.setting");
			String imageFilePath = ofbizHome + imageUrlPrefix;
			Map<String, Object> context = uploadFile(imageFilePath, request);
			Map<String, Object> resMap = FastMap.newInstance();
			resMap.put("filePath", UtilProperties.getPropertyValue("productUpload", "setting.url.prefix") + "/" + context.get("filePath"));
			resMap.put("imageTypeId", imageTypeId);
			response.setContentType("text/json; charset=UTF-8");
			toJsonObject(resMap, response);
		} catch (Exception e) {
			Debug.logError("When Create Product Brand Happen " + e.getMessage(), module);
			return ModelService.RESPOND_ERROR;
		}

		return ModelService.RESPOND_SUCCESS;
	}

	/**
	 * 水印图片附件处理
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static String uploadProductImageWater(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		try {
			String imageUrlPrefix = UtilProperties.getPropertyValue("productUpload", "product.uploadfile.water");
			String imageFilePath = ofbizHome + imageUrlPrefix;
			Map<String, Object> context = uploadFile(imageFilePath, request);
			Map<String, Object> resMap = FastMap.newInstance();
			resMap.put("filePath", UtilProperties.getPropertyValue("productUpload", "water.url.prefix") + "/" + context.get("filePath"));
			response.setContentType("text/json; charset=UTF-8");
			toJsonObject(resMap, response);
		} catch (Exception e) {
			Debug.logError("When Create Product Brand Happen " + e.getMessage(), module);
			return ModelService.RESPOND_ERROR;
		}

		return ModelService.RESPOND_SUCCESS;
	}

	public static Map<String, Object> imageSettingDo(DispatchContext dctx, Map<String, ? extends Object> context) {
		Delegator delegator = dctx.getDelegator();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Map result = new HashMap();
		try {
			String productStoreId = (String) context.get("productStoreId");
			String navTabId = (String) context.get("navTabId");
			// image setting parameters
			Map<String, ?> imageTypeIdMap = UtilGenerics.checkMap(context.get("imageTypeIdMap"));
			Map<String, ?> heightMap = UtilGenerics.checkMap(context.get("heightMap"));
			Map<String, ?> widthMap = UtilGenerics.checkMap(context.get("widthMap"));
			Map<String, ?> commentsMap = UtilGenerics.checkMap(context.get("commentsMap"));
			Map<String, ?> defaultImageUrlMap = UtilGenerics.checkMap(context.get("defaultImageUrlMap"));
			Map<String, ?> imageScaleTypeIdMap = UtilGenerics.checkMap(context.get("imageScaleTypeIdMap"));
			Map<String, ?> openWatermarkMap = UtilGenerics.checkMap(context.get("openWatermarkMap"));

			if (imageTypeIdMap != null) {
				for (String rowKey : imageTypeIdMap.keySet()) {
					Double height = null;
					String heightStr = (String) heightMap.get(rowKey);
					if (UtilValidate.isNotEmpty(heightStr)) {
						height = new Double(heightStr);
					}
					Double width = null;
					String widthStr = (String) widthMap.get(rowKey);
					if (UtilValidate.isNotEmpty(widthStr)) {
						width = new Double(widthStr);
					}
					String comments = (String) commentsMap.get(rowKey);
					String defaultImageUrl = (String) defaultImageUrlMap.get(rowKey);
					String imageScaleTypeId = (String) imageScaleTypeIdMap.get(rowKey);
					String openWatermark = (String) openWatermarkMap.get(rowKey);
					GenericValue productStoreImageSetting = delegator.findByPrimaryKey("ProductStoreImageSetting", UtilMisc.toMap("imageTypeId", rowKey, "productStoreId", productStoreId));
					if (UtilValidate.isNotEmpty(productStoreImageSetting)) {
						productStoreImageSetting.setNonPKFields(context);
						productStoreImageSetting.set("height", height);
						productStoreImageSetting.set("width", width);
						productStoreImageSetting.set("comments", comments);
						productStoreImageSetting.set("defaultImageUrl", defaultImageUrl);
						productStoreImageSetting.set("imageScaleTypeId", imageScaleTypeId);
						productStoreImageSetting.set("openWatermark", openWatermark);
						productStoreImageSetting.store();
					} else {
						productStoreImageSetting = delegator.makeValue("ProductStoreImageSetting");
						productStoreImageSetting.set("imageTypeId", rowKey);
						productStoreImageSetting.set("productStoreId", productStoreId);
						productStoreImageSetting.set("height", height);
						productStoreImageSetting.set("width", width);
						productStoreImageSetting.set("comments", comments);
						productStoreImageSetting.set("defaultImageUrl", defaultImageUrl);
						productStoreImageSetting.set("imageScaleTypeId", imageScaleTypeId);
						productStoreImageSetting.set("openWatermark", openWatermark);
						productStoreImageSetting.create();
					}
				}
			}
			// image water parameters watermarkTypeId
			String imageWaterTypeId = (String) context.get("imageWaterTypeId");
			GenericValue gv = delegator.findByPrimaryKey("ProductStoreWatermarkSetting", UtilMisc.toMap("imageTypeId", imageWaterTypeId, "productStoreId", productStoreId));
			if (UtilValidate.isNotEmpty(gv)) {
				gv.setNonPKFields(context);
				gv.store();
			} else {
				GenericValue productStoreWatermarkSetting = delegator.makeValue("ProductStoreWatermarkSetting");
				productStoreWatermarkSetting.set("imageTypeId", imageWaterTypeId);
				productStoreWatermarkSetting.set("productStoreId", productStoreId);
				productStoreWatermarkSetting.setNonPKFields(context);
				productStoreWatermarkSetting.create();
			}
			result.put("navTabId", navTabId);
		} catch (GenericEntityException e) {
			String errMsg = "Error creating new virtual product from variant products: " + e.toString();
			Debug.logError(e, errMsg, module);
		}
		return result;
	}
	public static String createProductStore(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		GenericDelegator delegator = (GenericDelegator) request.getAttribute("delegator");
		boolean beganTransaction = false;
		try {
			beganTransaction = TransactionUtil.begin();
			Map<String, Object> context = UtilHttp.getParameterMap(request);
			//检测productStoreId是否存在，存在：错误
			GenericValue productSotre = null;
			String productStoreId = (String)context.get("productStoreId");
			if(UtilValidate.isEmpty(productStoreId)){
				productStoreId = delegator.getNextSeqId("ProductStore");
			}else{
				productSotre = delegator.findOne("ProductStore", true, UtilMisc.toMap("productStoreId",productStoreId));
			}
			if(UtilValidate.isNotEmpty(productSotre)){
				Debug.logError("店铺编号重复！", module);
				Map<String, Object> resMap = FastMap.newInstance();
				resMap.put("navTabId", "EditProductStore");
				resMap.put("message", "店铺编号重复！操作失败");
				resMap.put("statusCode", "300");
				toJsonObject(resMap, response);
				return ModelService.RESPOND_ERROR;
			}

			//product Store
			Map<String, Object> productStoreContextMap = context;
			productStoreContextMap.put("userLogin", userLogin);
			productStoreContextMap.put("productStoreId", productStoreId);
			productStoreContextMap.put("inventoryFacilityId", (String)context.get("inventoryFacilityId"));
			productStoreContextMap.put("storeName", (String)context.get("storeName"));
			productStoreContextMap.put("stateProvinceGeoId", (String)context.get("stateProvinceGeoId"));
			productStoreContextMap.put("cityGeoId", (String)context.get("cityGeoId"));
			productStoreContextMap.put("countyGeoId", (String)context.get("countyGeoId"));
			productStoreContextMap.put("address1", (String)context.get("address1"));
			productStoreContextMap.put("payToPartyId", "Company");
			ModelService pService = dispatcher.getDispatchContext().getModelService("createProductStore");
			productStoreContextMap = pService.makeValid(productStoreContextMap, ModelService.IN_PARAM);
			Map<String, Object> result = dispatcher.runSync(pService.name, productStoreContextMap);
			productStoreId = (String)result.get("productStoreId");
			//product store role
			String managerPartyId = (String) context.remove("managerPartyId");
			if(UtilValidate.isNotEmpty(managerPartyId)){
				Map<String, Object> roleContextMap = new HashMap<String, Object>();
				roleContextMap.put("userLogin", userLogin);
				roleContextMap.put("partyId", managerPartyId);
				roleContextMap.put("roleTypeId", "MANAGER");
				roleContextMap.put("productStoreId", productStoreId);
				pService = dispatcher.getDispatchContext().getModelService("createProductStoreRole");
				roleContextMap = pService.makeValid(roleContextMap, ModelService.IN_PARAM);
				result = dispatcher.runSync(pService.name, roleContextMap);
			}
			
			//复制10000模板的支付设置
			if(!"10000".equals(productStoreId)){
				try {
					List<GenericValue> storePayments=delegator.findByAnd("ProductStorePaymentSetting", UtilMisc.toMap("productStoreId","10000"));
					for(GenericValue storePayment: storePayments){
						GenericValue newStorePayment = (GenericValue) storePayment.clone();
						newStorePayment.set("productStoreId", productStoreId);
						newStorePayment.create();
					}
				}catch (GenericEntityException e) {
					Debug.logError("Could not find ProductStorePaymentSetting for productStoreId : 10000 " + e.getMessage(), module);
				}
			}
			//没有货运设置
			if(!"10000".equals(productStoreId)){
				try {
					GenericValue pssm = delegator.makeValue("ProductStoreShipmentMeth");
					String  productStoreShipMethId = delegator.getNextSeqId("ProductStoreShipmentMeth");
					pssm.set("productStoreShipMethId", productStoreShipMethId);
					pssm.set("productStoreId", productStoreId);
					pssm.set("shipmentMethodTypeId", "NO_SHIPPING");
					pssm.set("partyId", "_NA_");
					pssm.set("roleTypeId", "CARRIER");
					pssm.set("allowUspsAddr", "N");
					pssm.set("requireUspsAddr", "N");
					pssm.set("includeNoChargeItems", "Y");
					pssm.create();
				}catch (GenericEntityException e) {
					Debug.logError("Could create ProductStoreShipmentMeth for productStoreId : 10000 " + e.getMessage(), module);
				}
			}

			Map<String, Object> resMap = FastMap.newInstance();
			resMap.put("productStoreId", productStoreId);
			resMap.put("navTabId", "EditProductStore");
			resMap.put("callbackType", "closeCurrent");
			resMap.put("message", "新建店铺成功");
			resMap.put("statusCode", "200");
			toJsonObject(resMap, response);

		} catch (Exception e) {
			try {
	            // only rollback the transaction if we started one...
	            TransactionUtil.rollback(beganTransaction, "Error looking up entity values in WebTools Entity Data Maintenance", e);
	        } catch (GenericEntityException e2) {
	            Debug.logError(e2, "Could not rollback transaction: " + e2.toString(), "GetContentLookupList.groovy");
	        }
			Map<String, Object> resMap = FastMap.newInstance();
			resMap.put("navTabId", "EditProductStore");
			resMap.put("message", "店铺创建操作失败");
			resMap.put("statusCode", "300");
			toJsonObject(resMap, response);
			Debug.logError(e.getMessage(), module);
			return ModelService.RESPOND_ERROR;
		}
		finally {
	        // only commit the transaction if we started one... this will throw an exception if it fails
			try {
                TransactionUtil.commit(beganTransaction);
            } catch (GenericEntityException e2) {
                Debug.logError(e2, "Could not commit transaction: " + e2.toString(), module);
                return ModelService.RESPOND_ERROR;
            }
	    }
		return ModelService.RESPOND_SUCCESS;
	}
	public static String updateProductStore(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		GenericDelegator delegator = (GenericDelegator) request.getAttribute("delegator");
		boolean beganTransaction = false;
		try {
			beganTransaction = TransactionUtil.begin();
			Map<String, Object> context = UtilHttp.getParameterMap(request);
			//检测productStoreId是否存在，存在：错误
			GenericValue productSotre = null;
			String productStoreId = (String)context.remove("productStoreId");
			String mobile = (String)context.remove("mobile");
			String telPhone = (String)context.remove("telPhone");
			String navTabId = (String)context.remove("navTabId");
			String managerPartyId = (String) context.remove("managerPartyId");
			String managerPartyName = (String) context.remove("managerPartyName");
			String facilityId = (String) context.remove("facilityId");
			if(UtilValidate.isEmpty(productStoreId)){
				Debug.logError("店铺编号为空！", module);
				Map<String, Object> resMap = FastMap.newInstance();
				resMap.put("navTabId", "EditProductStore");
				resMap.put("message", "店铺编号为空！操作失败");
				resMap.put("statusCode", "300");
				toJsonObject(resMap, response);
				return ModelService.RESPOND_ERROR;
			}else{
				productSotre = delegator.findOne("ProductStore", true, UtilMisc.toMap("productStoreId",productStoreId));
				Map<String, Object> productStoreContextMap = context;
				productStoreContextMap.put("userLogin", userLogin);
				productStoreContextMap.put("productStoreId", productStoreId);
				ModelService pService = dispatcher.getDispatchContext().getModelService("updateProductStore");
				productStoreContextMap = pService.makeValid(productStoreContextMap, ModelService.IN_PARAM);
				Map<String, Object> result = dispatcher.runSync(pService.name, productStoreContextMap);
			}
			if(UtilValidate.isEmpty(productSotre)){
				Debug.logError("店铺不存在！", module);
				Map<String, Object> resMap = FastMap.newInstance();
				resMap.put("navTabId", "EditProductStore");
				resMap.put("message", "店铺不存在！操作失败");
				resMap.put("statusCode", "300");
				toJsonObject(resMap, response);
				return ModelService.RESPOND_ERROR;
			}
			
			//product store role
			if(UtilValidate.isNotEmpty(managerPartyId)){
				List<GenericValue> psrList = delegator.findByAnd("ProductStoreRole", UtilMisc.toMap("productStoreId",productStoreId,"partyId",managerPartyId));
				if(UtilValidate.isEmpty(psrList)){
					delegator.removeByAnd("ProductStoreRole", UtilMisc.toMap("productStoreId",productStoreId));
					Map<String, Object> roleContextMap = new HashMap<String, Object>();
					roleContextMap.put("userLogin", userLogin);
					roleContextMap.put("partyId", managerPartyId);
					roleContextMap.put("roleTypeId", "MANAGER");
					roleContextMap.put("productStoreId", productStoreId);
					ModelService pService = dispatcher.getDispatchContext().getModelService("createProductStoreRole");
					roleContextMap = pService.makeValid(roleContextMap, ModelService.IN_PARAM);
					Map<String, Object> result = dispatcher.runSync(pService.name, roleContextMap);
				}
			}else{
				List<GenericValue> psrList = delegator.findByAnd("ProductStoreRole", UtilMisc.toMap("productStoreId",productStoreId));
				if(UtilValidate.isNotEmpty(managerPartyId))
					delegator.removeAll(psrList);
			}
			
			//复制10000模板的支付设置
			if(!"10000".equals(productStoreId)){
				try {
					List<GenericValue> storePayments=delegator.findByAnd("ProductStorePaymentSetting", UtilMisc.toMap("productStoreId","10000"));
					for(GenericValue storePayment: storePayments){
						String paymentMethodTypeId = storePayment.getString("paymentMethodTypeId");
						String paymentServiceTypeEnumId = storePayment.getString("paymentServiceTypeEnumId");
						GenericValue storePaymentGv = delegator.findByPrimaryKey("ProductStorePaymentSetting", UtilMisc.toMap("productStoreId",productStoreId,"paymentMethodTypeId",paymentMethodTypeId,"paymentServiceTypeEnumId",paymentServiceTypeEnumId));
						if(UtilValidate.isEmpty(storePaymentGv)){
							GenericValue newStorePayment = (GenericValue) storePayment.clone();
							newStorePayment.set("productStoreId", productStoreId);
							newStorePayment.create();
						}
					}
				}catch (GenericEntityException e) {
					Debug.logError("Could not find ProductStorePaymentSetting for productStoreId : 10000 " + e.getMessage(), module);
				}
			}
			//没有货运设置
			if(!"10000".equals(productStoreId)){
				try {
					List<GenericValue> pssms=delegator.findByAnd("ProductStoreShipmentMeth", UtilMisc.toMap("shipmentMethodTypeId","NO_SHIPPING","productStoreId",productStoreId));
					if(UtilValidate.isEmpty(pssms)){
						GenericValue pssm = delegator.makeValue("ProductStoreShipmentMeth");
						String  productStoreShipMethId = delegator.getNextSeqId("ProductStoreShipmentMeth");
						pssm.set("productStoreShipMethId", productStoreShipMethId);
						pssm.set("productStoreId", productStoreId);
						pssm.set("shipmentMethodTypeId", "NO_SHIPPING");
						pssm.set("partyId", "_NA_");
						pssm.set("roleTypeId", "CARRIER");
						pssm.set("allowUspsAddr", "N");
						pssm.set("requireUspsAddr", "N");
						pssm.set("includeNoChargeItems", "Y");
						pssm.create();
					}
				}catch (GenericEntityException e) {
					Debug.logError("Could create ProductStoreShipmentMeth for productStoreId : 10000 " + e.getMessage(), module);
				}
			}
			Map<String, Object> resMap = FastMap.newInstance();
			resMap.put("productStoreId", productStoreId);
			resMap.put("navTabId", "EditProductStore");
			resMap.put("message", "修改店铺成功");
			resMap.put("statusCode", "200");
			toJsonObject(resMap, response);

		} catch (Exception e) {
			try {
	            // only rollback the transaction if we started one...
	            TransactionUtil.rollback(beganTransaction, "Error looking up entity values in WebTools Entity Data Maintenance", e);
	        } catch (GenericEntityException e2) {
	            Debug.logError(e2, "Could not rollback transaction: " + e2.toString(), module);
	        }
			Map<String, Object> resMap = FastMap.newInstance();
			resMap.put("navTabId", "EditProductStore");
			resMap.put("message", "店铺修改操作失败");
			resMap.put("statusCode", "300");
			toJsonObject(resMap, response);
			Debug.logError(e.getMessage(), module);
			return ModelService.RESPOND_ERROR;
		}
		finally {
	        // only commit the transaction if we started one... this will throw an exception if it fails
			try {
                TransactionUtil.commit(beganTransaction);
            } catch (GenericEntityException e2) {
                Debug.logError(e2, "Could not commit transaction: " + e2.toString(), module);
                return ModelService.RESPOND_ERROR;
            }
	    }
		return ModelService.RESPOND_SUCCESS;
	}
	public static void toJsonObject(Map<String, Object> attrMap, HttpServletResponse response) {
		JSONObject json = JSONObject.fromObject(attrMap);
		String jsonStr = json.toString();
		if (jsonStr == null) {
			Debug.logError("JSON Object was empty; fatal error!", module);
		}
		// set the X-JSON content type
		response.setContentType("text/html");
		// jsonStr.length is not reliable for unicode characters
		try {
			response.setContentLength(jsonStr.getBytes("UTF8").length);
		} catch (UnsupportedEncodingException e) {
			Debug.logError("Problems with Json encoding", module);
		}
		// return the JSON String
		Writer out;
		try {
			out = response.getWriter();
			out.write(jsonStr);
			out.flush();
		} catch (IOException e) {
			Debug.logError("Unable to get response writer", module);
		}
	}
	 /**
     * 附件上传处理<br/>
     * 上传文件处理,不进行文件类型过滤<br/>
     * 
     * @param folder
     * @param request
     * @return
     * @throws Exception
     */
    public static Map<String, Object> uploadFile(String folder, HttpServletRequest request) throws Exception
    {
	return uploadFile(null, folder, request);
    }

    /**
     * uploadFile 上传文件处理<br/>
     * 上传文件处理,支持文件类型过滤<br/>
     * 
     * @param folder
     *            默认目录
     * @param mimeTypeId
     *            文件类型
     * @param request
     * @return
     * @throws Exception
     */
    public static Map<String, Object> uploadFile(String mimeTypeId, String folder, HttpServletRequest request) throws Exception
    {
	Map<String, Object> context = FastMap.newInstance();
	FileItemFactory factory = new DiskFileItemFactory(10240, FileUtil.getFile("runtime/tmp"));
	// 默认上传文件是10240, 不够可以修改这个参数为下面这种,可以指定缓存大小.new
	// DiskFileItemFactory(10240,FileUtil.getFile("runtime/tmp"));
	ServletFileUpload upload = new ServletFileUpload(factory);

	try
	{
	    List<FileItem> items = UtilGenerics.<FileItem> checkList(upload.parseRequest(request));

	    Iterator<FileItem> it = items.iterator();
	    while (it.hasNext())
	    {
		FileItem fileItem = it.next();
		if (fileItem.isFormField())
		{
		    String fieldName = fileItem.getFieldName();
		    Object fieldValue = fileItem.getString("UTF-8");

		    if (!context.containsKey(fieldName))
		    {
			context.put(fieldName, fieldValue);
		    } else if (context.containsKey(fieldName))
		    {
			Object mapValue = context.get(fieldName);
			if (mapValue instanceof List<?>)
			{
			    checkList(mapValue, Object.class).add(fieldValue);
			} else if (mapValue instanceof String)
			{
			    List<String> newList = FastList.newInstance();
			    newList.add((String) mapValue);
			    newList.add((String) fieldValue);
			    context.put(fieldName, newList);
			} else
			{
			    Debug.logWarning("Form field found [" + fieldName + "] which was not handled!", module);
			}
		    }
		} else
		{
		    if (fileItem.getSize() > 0)
		    {
			String mimeTypeCheckIsOn = UtilProperties.getPropertyValue("sysCommon", "mimeTypeCheckIsOn", "Y");
			if (mimeTypeCheckIsOn.equals("Y") && UtilValidate.isNotEmpty(mimeTypeId))// 注释限制文件类型上传的代码.
			{
			    String contentType = fileItem.getContentType();
			    if (UtilValidate.isNotEmpty(contentType) && !mimeTypeId.equalsIgnoreCase(contentType))
			    {
				Debug.logError("上传文件类型不匹配", module);
				throw new Exception("上传文件类型不匹配");
			    }
			}

			String filePath = saveFileItemToFile(fileItem, folder);
			context.put("fileName", FilenameUtils.getBaseName(fileItem.getName()));
			context.put("contentType", fileItem.getContentType());
			context.put("filePath", filePath);
			context.put(fileItem.getFieldName(), filePath);
		    }
		}
	    }
	} catch (Exception e)
	{
	    Debug.logError(e.getMessage(), module);
	    if (useDebug)
	    {
		throw e;
	    }
	}
	return context;
    }
    /**
     * saveFileItemToFile<br/>
     * 将每个文件的 FileItem存储到指定的文件夹下,存储的时候在指定文件夹下按照日期时间归档存储<br/>
     * 
     * @param fileItem
     * @param folder
     * @return 存储以后的文件路径
     * @throws Exception
     */
    public static String saveFileItemToFile(FileItem fileItem, String folder) throws Exception
    {
	String uuid = UtilUUID.uuidTomini();
	String extension = FilenameUtils.getExtension(fileItem.getName());

	String filePath = UtilDateTime.nowDateString(DATE_FOLDER_FORMAT);
	File saveFilePath = new File(folder + filePath);
	if (!saveFilePath.exists())
	{
	    saveFilePath.mkdirs();
	}

	filePath = filePath + "/" + uuid + FilenameUtils.EXTENSION_SEPARATOR_STR + extension.toLowerCase();
	File saveFile = new File(folder + filePath);
	if (!saveFile.exists())
	{
	    saveFile.createNewFile();
	}

	fileItem.write(saveFile);

	return filePath;
    }
}
