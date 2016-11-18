package org.ofbiz.system;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastList;
import javolution.util.FastMap;
import net.sf.json.JSONObject;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.inventory.FacilityEvents;
import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;

public class SystemEvents {
	public static final String module = FacilityEvents.class.getName();
	private static final String IMAGE_FOLDER = UtilProperties.getPropertyValue("productUpload.properties", "product.uploadfile.brand");

	public static String setSeoMSG(HttpServletRequest request, HttpServletResponse response) {
		String message;
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		String productStoreId = null == ProductStoreWorker.getProductStoreId(request) ? "10000" : ProductStoreWorker.getProductStoreId(request);
		try {
			// Map<String, Object> context =
			// UtilFileUpload.uploadFile(IMAGE_FOLDER, request);
			Map<String, Object> context = UtilHttp.getParameterMap(request);
			Map arg = null;
			String PSCTypeId;
			String typeContent;

			arg = new HashMap();
			PSCTypeId = context.get("PSCTypeId0").toString();
			typeContent = context.get("typeContent0").toString();
			arg.put("PSCTypeId", PSCTypeId);
			arg.put("typeContent", typeContent);
			arg.put("PSId", productStoreId);
			arg.put("userLogin", userLogin);
			dispatcher.runSync("setSeoMSG", arg);

			arg = new HashMap();
			PSCTypeId = context.get("PSCTypeId1").toString();
			typeContent = context.get("typeContent1").toString();
			arg.put("PSCTypeId", PSCTypeId);
			arg.put("typeContent", typeContent);
			arg.put("PSId", productStoreId);
			arg.put("userLogin", userLogin);
			dispatcher.runSync("setSeoMSG", arg);

			arg = new HashMap();
			PSCTypeId = context.get("PSCTypeId2").toString();
			typeContent = context.get("typeContent2").toString();
			arg.put("PSCTypeId", PSCTypeId);
			arg.put("typeContent", typeContent);
			arg.put("PSId", productStoreId);
			arg.put("userLogin", userLogin);
			dispatcher.runSync("setSeoMSG", arg);

			arg = new HashMap();
			PSCTypeId = context.get("PSCTypeId3").toString();
			typeContent = context.get("typeContent3").toString();
			arg.put("PSCTypeId", PSCTypeId);
			arg.put("typeContent", typeContent);
			arg.put("PSId", productStoreId);
			arg.put("userLogin", userLogin);
			dispatcher.runSync("setSeoMSG", arg);

			// toJsonObject(UtilMisc.toMap("statusCode", "200", "message",
			// "操作成功", "callbackType", context.get("callbackType"), "navTabId",
			// context.get("navTabId")), response);
			message = "操作成功！";
		} catch (Exception e) {
			e.printStackTrace();
			message = "操作失败！";
		}
		request.setAttribute("message", message);
		return "success";
	}

	public static String deleteTemplate(HttpServletRequest request, HttpServletResponse response) {
		String message;
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		try {
			Map<String, Object> context = UtilHttp.getParameterMap(request);
			context.put("userLogin", userLogin);
			ModelService pService = dispatcher.getDispatchContext().getModelService("deleteTemplate");
			context = pService.makeValid(context, ModelService.IN_PARAM);
			Map returnMap = dispatcher.runSync(pService.name, context);
			Object flag = returnMap.get("flag");
			if (flag.equals("1")) {
				toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功", "navTabId", "templateList"), response);
			} else {
				toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作失败"), response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作失败"), response);
		}
		return "success";
	}

	public static String updateTemplate(HttpServletRequest request, HttpServletResponse response) {
		String message;
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		try {
			Map<String, Object> context = UtilHttp.getParameterMap(request);
			context.put("userLogin", userLogin);
			if(UtilValidate.isEmpty(request.getParameter("content"))){
				context.put("content", " ");
			}
			if(UtilValidate.isEmpty(request.getParameter("subject"))){
				context.put("subject", " ");
			}
			ModelService pService = dispatcher.getDispatchContext().getModelService("updateTemplate");
			context = pService.makeValid(context, ModelService.IN_PARAM);
			Map returnMap = dispatcher.runSync(pService.name, context);
			Object flag = returnMap.get("flag");
			if (flag.equals("1")) {
				toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功", "callbackType", "closeCurrent", "navTabId", "autoSendMgr"), response);
			} else {
				toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作失败"), response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作失败"), response);
		}
		return "success";
	}

	public static String createTemplate(HttpServletRequest request, HttpServletResponse response) {
		String message;
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		/*
		 * GenericDelegator delegator = (GenericDelegator)
		 * request.getAttribute("delegator"); GenericValue content; GenericValue
		 * dataResource; GenericValue electronicText; GenericValue
		 * contentPurpose;
		 * 
		 * Map<String, Object> context = UtilHttp.getParameterMap(request);
		 * String contentId = delegator.getNextSeqId("Content"); String
		 * dataResourceId = delegator.getNextSeqId("DataResource"); String
		 * contentName = context.get("contentName").toString(); String
		 * contentPurposeId = context.get("contentPurposeId").toString(); String
		 * textData = context.get("textData").toString(); try { Map
		 * electronicTextObj = new HashMap();
		 * electronicTextObj.put("dataResourceId", dataResourceId);
		 * electronicTextObj.put("textData", textData);
		 * 
		 * Map dataResourceObj = new HashMap();
		 * dataResourceObj.put("dataResourceTypeId", "ELECTRONIC_TEXT");
		 * dataResourceObj.put("dataResourceId", dataResourceId);
		 * 
		 * Map contentObj = new HashMap(); contentObj.put("contentId",
		 * contentId); contentObj.put("contentName", contentName);
		 * contentObj.put("dataResourceId", dataResourceId);
		 * contentObj.put("contentTypeId", "NOE_TEMPLATE");
		 * 
		 * Map contentPurposeObj = new HashMap();
		 * contentPurposeObj.put("contentId", contentId);
		 * contentPurposeObj.put("contentPurposeTypeId", contentPurposeId);
		 * 
		 * content = delegator.makeValue("Content", contentObj); dataResource =
		 * delegator.makeValue("DataResource", dataResourceObj); electronicText
		 * = delegator.makeValue("ElectronicText", electronicTextObj);
		 * contentPurpose = delegator.makeValue("ContentPurpose",
		 * contentPurposeObj);
		 * 
		 * dataResource.create(); electronicText.create(); content.create();
		 * contentPurpose.create();
		 * 
		 * toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功",
		 * "callbackType", "closeCurrent", "navTabId", "templateList"),
		 * response); } catch (Exception e) { e.printStackTrace();
		 * toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作失败"),
		 * response); return "false"; }
		 */
		try {
			Map<String, Object> context = UtilHttp.getParameterMap(request);
			context.put("userLogin", userLogin);
			if (null == context.get("subject") || "".equals(context.get("subject"))) {
				context.put("subject", " ");
			}
			if(UtilValidate.isEmpty(request.getParameter("content"))){
				context.put("content", " ");
			}
			ModelService pService = dispatcher.getDispatchContext().getModelService("createTemplate");
			context = pService.makeValid(context, ModelService.IN_PARAM);
			Map returnMap = dispatcher.runSync(pService.name, context);
			Object flag = returnMap.get("flag");
			if (flag.equals("1")) {
				toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功", "callbackType", "closeCurrent", "navTabId", "autoSendMgr"), response);
			} else {
				toJsonObject(UtilMisc.toMap("statusCode", "300", "message", "操作失败"), response);
			}

		} catch (Exception e) {
			e.printStackTrace();
			toJsonObject(UtilMisc.toMap("statusCode", "300", "message", "操作失败"), response);
		}
		return "success";
	}

	public static String setAutoSend(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		Map<String, Object> context = UtilHttp.getParameterMap(request);
		GenericDelegator delegator = (GenericDelegator) request.getAttribute("delegator");
		try {
			List<GenericValue> msgTypeList = delegator.findList("Enumeration", EntityCondition.makeCondition(UtilMisc.toMap("enumTypeId", "MSG_TYPE")), null, UtilMisc.toList("sequenceId"), null, false);
			List<GenericValue> eventTypeList = delegator.findList("Enumeration", EntityCondition.makeCondition(UtilMisc.toMap("enumTypeId", "MSG_EVENT_TYPE")), null, UtilMisc.toList("sequenceId"), null, false);
			String productStoreId = context.get("productStoreId").toString();
			String eventTypeId;
			String msgTypeId;
			String ifAuto;
			String paraKey;
			String eventMsgGroup;
			String[] msgList;
			GenericValue productStoreMsgSetting;
			for (GenericValue eventType : eventTypeList) {
				for (GenericValue msgType : msgTypeList) {
					paraKey = eventType.get("enumId").toString().trim() + msgType.get("enumId").toString().trim();
					Object obj = context.get(paraKey);
					if (null != obj && !"".equals(obj)) {
						eventMsgGroup = obj.toString();
						msgList = eventMsgGroup.split("@split@");
						if (msgList.length == 3) {
							eventTypeId = msgList[0];
							msgTypeId = msgList[1];
							ifAuto = msgList[2];
							List<GenericValue> productStoreMsgSettingList = delegator.findList("ProductStoreMsgSetting", EntityCondition.makeCondition(UtilMisc.toMap("productStoreId", productStoreId, "eventTypeId", eventTypeId, "msgTypeId", msgTypeId)), null, null, null, false);
							if (productStoreMsgSettingList.size() != 1) {
								throw new Exception("data from database Exception!");
							} else {
								productStoreMsgSetting = productStoreMsgSettingList.get(0);
								productStoreMsgSetting.set("ifAutoSend", ifAuto);
								productStoreMsgSetting.store();
							}
						} else {
							throw new Exception("the value from page was wrong organizationed");
						}
					}
				}
			}
			toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功！", "navTabId", "autoSendMgr"), response);
		} catch (Exception e) {
			e.printStackTrace();
			toJsonObject(UtilMisc.toMap("statusCode", "300", "message", "操作过程中出现异常！"), response);
		}
		return "success";
	}

	public static String sendManualMail(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		Map<String, Object> context = UtilHttp.getParameterMap(request);
		GenericDelegator delegator = (GenericDelegator) request.getAttribute("delegator");

		Object mailType = context.get("mailType");// EMAIL、NOTE
		Object sendBatch = context.get("sendBatch");
		Object grade = context.get("grade");
		Object chooseType = context.get("chooseType");// ordinary、advanced
		Object chooseList = context.get("chooseList");
		Object subject = context.get("subject");
		Object content = context.get("content");

		List partyIdList = FastList.newInstance();
		if (null != chooseType && !chooseType.equals("")) {
			if (chooseType.equals("ordinary")) {
				if (null == grade) {
					toJsonObject(UtilMisc.toMap("statusCode", "300", "message", "请选择要发送的会员类型！"), response);
					return "success";
				} else {
					EntityCondition cdt;
					FastList<EntityCondition> cdtList = FastList.newInstance();
					if (grade instanceof String) {
						cdt = EntityCondition.makeCondition("partyClassificationGroupId", EntityOperator.EQUALS, ((String) grade).trim());
						cdtList.add(cdt);
					}
					if (grade instanceof FastList) {
						FastList gradeList = (FastList) grade;
						for (Object o : gradeList) {
							if (!o.equals("")) {
								cdt = EntityCondition.makeCondition("partyClassificationGroupId", EntityOperator.EQUALS, ((String) o).trim());
								cdtList.add(cdt);
							}
						}
					}
					cdt = EntityCondition.makeCondition(cdtList, EntityOperator.OR);
					List<GenericValue> partyClassificationList;
					try {
						partyClassificationList = delegator.findList("PartyClassification", cdt, null, null, null, false);
					} catch (Exception e) {
						e.printStackTrace();
						toJsonObject(UtilMisc.toMap("statusCode", "300", "message", "范围发送查询party出错！"), response);
						return "success";
					}
					if (partyClassificationList != null && partyClassificationList.size() > 0) {
						for (GenericValue gv : partyClassificationList) {
							partyIdList.add(gv.get("partyId"));
						}
					}
				}
			} else if (chooseType.equals("advanced")) {
				if (null == chooseList || ((String) chooseList).trim().equals("")) {
					toJsonObject(UtilMisc.toMap("statusCode", "300", "message", "请选择要发送的会员！"), response);
					return "success";
				} else {
					String[] partyIdArr = ((String) chooseList).split(",");
					for (String s : partyIdArr) {
						partyIdList.add(s);
					}
				}
			} else {
				toJsonObject(UtilMisc.toMap("statusCode", "300", "message", "chooseType自动设置错误！"), response);
				return "success";
			}
		} else {
			toJsonObject(UtilMisc.toMap("statusCode", "300", "message", "chooseType不能为空！"), response);
			return "success";
		}
		if (null != mailType) {
			try {
				Map serviceContext = FastMap.newInstance();
				serviceContext.put("sendBatch", sendBatch);
				serviceContext.put("subject", subject);
				serviceContext.put("content", content);
				serviceContext.put("partyIdList", partyIdList);
				serviceContext.put("userLogin", request.getSession().getAttribute("userLogin"));

				Map result = null;
				if (mailType.equals("EMAIL")) {
					result = dispatcher.runSync("batchSendEmail", serviceContext);
				} else if (mailType.equals("NOTE")) {
					result = dispatcher.runSync("batchSendSMS", serviceContext);
				}
				if (result.get("responseMessage").equals("success")) {
					toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "发送完成！"), response);
					return "success";
				} else {
					toJsonObject(UtilMisc.toMap("statusCode", "300", "message", result.get("errorMessage")), response);
					return "success";
				}
			} catch (Exception e) {
				e.printStackTrace();
				toJsonObject(UtilMisc.toMap("statusCode", "300", "message", "发送信息失败！"), response);
				return "success";
			}
		} else {
			toJsonObject(UtilMisc.toMap("statusCode", "300", "message", "发送类型错误！"), response);
			return "success";
		}
	}

	public static String verifyRegister(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		String userLoginId = request.getParameter("uName");
		String verifyCode = request.getParameter("verifyCode");
		try {
			GenericValue userLogin = delegator.findOne("UserLogin", false, "userLoginId", userLoginId);
			if (verifyCode.equals(userLogin.get("externalAuthId"))) {
				userLogin.set("externalAuthId", null);
				userLogin.set("enabled", "Y");
				userLogin.store();
				request.setAttribute("USERNAME", userLogin.get("userLoginId"));
				request.setAttribute("PASSWORD", userLogin.get("currentPassword"));
			} else {
				return "error";
			}
		} catch (GenericEntityException e) {
			e.printStackTrace();
			return "error";
		}
		return "success";
	}

	public static String updatePaymentGatewayConfigAlipay(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		
		String paymentGatewayConfigId = request.getParameter("paymentGatewayConfigId");
		String partner = request.getParameter("partner");
		String partnerKey = request.getParameter("partnerKey");
		String sellerEmail = request.getParameter("sellerEmail");
		String notifyUrl = request.getParameter("notifyUrl");
		String returnUrl = request.getParameter("returnUrl");
		
		Map context = FastMap.newInstance();
		context.put("paymentGatewayConfigId", paymentGatewayConfigId);
		context.put("partner", partner);
		context.put("partnerKey", partnerKey);
		context.put("sellerEmail", sellerEmail);
		context.put("notifyUrl", notifyUrl);
		context.put("returnUrl", returnUrl);
		context.put("userLogin", userLogin);
		try{
		Map returnMap = dispatcher.runSync("updatePaymentGatewayConfigAlipay", context);
		if(ServiceUtil.isSuccess(returnMap)){
			toJsonObject(UtilMisc.toMap("statusCode", "200", "message","修改成功"),response);
			return "success";
		}
		}catch(Exception e){
			Debug.logError(e, "call service failure!");
			toJsonObject(UtilMisc.toMap("statusCode", "300", "message","修改失败"),response);
			return "error";
		}
		return "error";
	}
	
	public static String setCreditsReward(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		Delegator delegator = (Delegator)request.getAttribute("delegator");
		
		String productStoreId = ProductStoreWorker.getProductStoreId(request);
		String ifAvaliable = request.getParameter("ifAvaliable");
		String hasLimit = request.getParameter("hasLimit");
		String rewardAmountStr = request.getParameter("rewardAmount");
		String oneDayLimitStr = request.getParameter("oneDayLimit");
		String settingTypeId = request.getParameter("settingTypeId");
		String ratioStr = request.getParameter("ratio");
		String comment = request.getParameter("comment");
		Long rewardAmount = Long.valueOf("0");
		Long oneDayLimit = Long.valueOf("1");
		Double ratio = Double.valueOf("1");
		
		if(UtilValidate.isEmpty(ifAvaliable)){
			ifAvaliable = "N";
		}
		if(UtilValidate.isEmpty(hasLimit)){
			hasLimit = "N";
		}
		if(UtilValidate.isNotEmpty(rewardAmountStr)){
			 rewardAmount =Long.valueOf(rewardAmountStr);
		}
		if(UtilValidate.isNotEmpty(oneDayLimitStr)){
			oneDayLimit = Long.valueOf(oneDayLimitStr); 
		}
		if(UtilValidate.isEmpty(settingTypeId)){
			settingTypeId = "0";
		}
		if(UtilValidate.isNotEmpty(ratioStr)){
			ratio = Double.valueOf(ratioStr);
		}
		if(UtilValidate.isEmpty(comment)){
			comment = "";
		}
		
		try {
			GenericValue pscs = delegator.findOne("ProductStoreCreditsSetting", false, UtilMisc.toMap("productStoreId", productStoreId,"settingTypeId",settingTypeId));
			if(UtilValidate.isEmpty(pscs)){
				pscs = delegator.makeValue("ProductStoreCreditsSetting", UtilMisc.toMap("productStoreId", productStoreId, "settingTypeId", settingTypeId, "ifAvaliable", ifAvaliable, "hasLimit", hasLimit, "rewardAmount", rewardAmount,"oneDayLimit",oneDayLimit,"ratio",ratio,"comment",comment));
				pscs.create();
			}else{
				pscs.set("ifAvaliable", ifAvaliable);
				pscs.set("hasLimit", hasLimit);
				pscs.set( "rewardAmount", rewardAmount);
				pscs.set("oneDayLimit",oneDayLimit);
				pscs.set("ratio",ratio);
				pscs.set("comment",comment);
				pscs.store();
			}
			request.setAttribute("returnMSG", "设置成功");
		} catch (Exception e) {
			Debug.logError(e, module);
			request.setAttribute("returnMSG", "设置失败");
		}
		return "success";
	}
	
	
	public static String setPartyClasRatio(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		Delegator delegator = (Delegator)request.getAttribute("delegator");
		String productStoreId = ProductStoreWorker.getProductStoreId(request);
		try{
			List<GenericValue> partyClassificationGroup= getPartyClassificationGroup(delegator);
			String settingTypeId = null;
			Double ratio = 1.0;
			String ifAvaliable = request.getParameter("ifAvaliable");
			if(UtilValidate.isEmpty(ifAvaliable)){
				ifAvaliable = "N";
			}
			for(GenericValue partyClassification:partyClassificationGroup){
				settingTypeId = partyClassification.getString("partyClassificationGroupId");
				String ratioStr = request.getParameter(settingTypeId);
				if(UtilValidate.isEmpty(ratioStr)){
					Debug.logError("params transfer error!",module);
				}else{
					ratio = Double.valueOf(ratioStr);
					GenericValue pscs = delegator.findOne("ProductStoreCreditsSetting", false, UtilMisc.toMap("productStoreId", productStoreId,"settingTypeId",settingTypeId));
					if(UtilValidate.isEmpty(pscs)){
						GenericValue pscst = delegator.makeValue("PscSettingType", UtilMisc.toMap("typeId", settingTypeId,"parentTypeId","MEM_LEVEL_RATIO"));
						pscst.create();
						pscs = delegator.makeValue("ProductStoreCreditsSetting", UtilMisc.toMap("productStoreId", productStoreId, "settingTypeId", settingTypeId,"ifAvaliable",ifAvaliable,"ratio",ratio));
						pscs.create();
					}else{
						pscs.set("ratio",ratio);
						pscs.set("ifAvaliable",ifAvaliable);
						pscs.store();
					}
				}
			}
		}catch(Exception e){
			Debug.logError(e,module);
			request.setAttribute("returnMSG", "设置失败");
			return "success";
		}
		request.setAttribute("returnMSG", "设置成功");
		return "success";
	}
	
	public static String SetOrderRatio(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		Delegator delegator = (Delegator)request.getAttribute("delegator");
		String productStoreId = ProductStoreWorker.getProductStoreId(request);
		try{
			String ratioStr = request.getParameter("orderRatio");
			String ifAvaliable = request.getParameter("ifAvaliable");
			Double ratio = 1.0;
			if(UtilValidate.isNotEmpty(ratioStr)){
				ratio = Double.valueOf(ratioStr);
			}
			if(UtilValidate.isEmpty(ifAvaliable)){
				ifAvaliable = "N";
			}
			
			GenericValue orderRatioSetting = delegator.findOne("ProductStoreCreditsSetting", false, UtilMisc.toMap("productStoreId", productStoreId,"settingTypeId","ORDER_RATIO"));
			if(UtilValidate.isEmpty(orderRatioSetting)){
				orderRatioSetting = delegator.makeValue("ProductStoreCreditsSetting", UtilMisc.toMap("productStoreId", productStoreId,"settingTypeId","ORDER_RATIO", "ratio", ratio,"ifAvaliable",ifAvaliable));
				orderRatioSetting.create();
			}else{
				orderRatioSetting.set("ratio", ratio);
				orderRatioSetting.set("ifAvaliable", ifAvaliable);
				orderRatioSetting.store();
			}
		}catch(Exception e){
			Debug.logError(e,module);
			request.setAttribute("returnMSG", "设置失败");
			return "success";
		}
		request.setAttribute("returnMSG", "设置成功");
		return "success";
	}
	
	public static List<GenericValue> getPartyClassificationGroup(Delegator delegator){
		try {
			List<GenericValue> partyClassificationGroup = delegator.findByAnd("PartyClassificationGroup", UtilMisc.toMap("partyClassificationTypeId", "MEMBER_GRADE"));
			return partyClassificationGroup;
		} catch (GenericEntityException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static void toJsonObject(Map attrMap, HttpServletResponse response) {
		JSONObject json = JSONObject.fromObject(attrMap);
		String jsonStr = json.toString();
		if (jsonStr == null) {
			Debug.logError("JSON Object was empty; fatal error!", module);
		}
		// set the X-JSON content type
		// response.setContentType("application/json");
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

}
