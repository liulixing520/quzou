package org.ofbiz.ebiz.order;

import static org.ofbiz.base.util.UtilGenerics.checkMap;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityComparisonOperator;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.model.DynamicViewEntity;
import org.ofbiz.entity.model.ModelKeyMap;
import org.ofbiz.entity.util.EntityFindOptions;
import org.ofbiz.entity.util.EntityListIterator;
import org.ofbiz.security.Security;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;

/**
 * ReturnOrderServices
 */
public class ReturnOrderServices {

	public static final String module = ReturnOrderServices.class.getName();

	public static Map<String, Object> findReturnOrders(DispatchContext dctx, Map<String, ? extends Object> context) {
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();
		Security security = dctx.getSecurity();

		GenericValue userLogin = (GenericValue) context.get("userLogin");
		Integer viewIndex = (Integer) context.get("viewIndex");
		Integer viewSize = (Integer) context.get("viewSize");
		Map<String, ?> inputFields = checkMap(context.get("inputFields"), String.class, Object.class); // Input
		String orderId = (String) inputFields.get("orderId");
		String returnId = (String) inputFields.get("returnId");
		String statusId = (String) inputFields.get("statusId");
		String returnTypeId = (String) inputFields.get("returnTypeId");

		// list of fields to select (initial list)
		List<String> fieldsToSelect = FastList.newInstance();
		fieldsToSelect.add("orderId");
		fieldsToSelect.add("returnId");
		fieldsToSelect.add("entryDate");
		fieldsToSelect.add("fromPartyId");
		fieldsToSelect.add("destinationFacilityId");
		fieldsToSelect.add("statusId");
		fieldsToSelect.add("returnTypeId");

		// sorting by order date newest first
		List<String> orderBy = UtilMisc.toList("-returnId");

		// list to hold the parameters
		List<String> paramList = FastList.newInstance();

		// list of conditions
		List<EntityCondition> conditions = FastList.newInstance();

		// dynamic view entity
		DynamicViewEntity dve = new DynamicViewEntity();
		dve.addMemberEntity("RH", "ReturnHeader");
		dve.addAliasAll("RH", ""); // no prefix

		dve.addMemberEntity("RI", "ReturnItem");
		dve.addViewLink("RH", "RI", Boolean.FALSE, ModelKeyMap.makeKeyMapList("returnId"));
		dve.addAlias("RI", "orderId");
		if (UtilValidate.isNotEmpty(orderId)) {
			conditions.add(makeExpr("orderId", orderId, true));
		}
		if (UtilValidate.isNotEmpty(returnId)) {
			conditions.add(makeExpr("returnId", returnId, true));
		}
		if (UtilValidate.isNotEmpty(statusId)) {
			conditions.add(makeExpr("statusId", statusId, true));
		}
		if (UtilValidate.isNotEmpty(returnTypeId)) {
			conditions.add(makeExpr("returnTypeId", returnTypeId, true));
		}
		// set distinct on so we only get one row per order
		EntityFindOptions findOpts = new EntityFindOptions(true, EntityFindOptions.TYPE_SCROLL_INSENSITIVE, EntityFindOptions.CONCUR_READ_ONLY, true);

		EntityCondition cond = null;
		if (conditions.size() > 0) {
			cond = EntityCondition.makeCondition(conditions, EntityOperator.AND);
		}

		List<GenericValue> orderList = FastList.newInstance();
		int orderCount = 0;

		// get the index for the partial list
		int lowIndex = (((viewIndex.intValue()) * viewSize.intValue()) + 1);
		int highIndex = (viewIndex.intValue() + 1) * viewSize.intValue();
		findOpts.setMaxRows(highIndex);

		EntityListIterator eli = null;
		try {
			// do the lookup
			eli = delegator.findListIteratorByCondition(dve, cond, null, fieldsToSelect, orderBy, findOpts);

			orderCount = eli.getResultsSizeAfterPartialList();

			// get the partial list for this page
			eli.beforeFirst();
			if (orderCount > viewSize.intValue()) {
				orderList = eli.getPartialList(lowIndex, viewSize.intValue());
			} else if (orderCount > 0) {
				orderList = eli.getCompleteList();
			}

			if (highIndex > orderCount) {
				highIndex = orderCount;
			}
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(e.getMessage());
		} finally {
			if (eli != null) {
				try {
					eli.close();
				} catch (GenericEntityException e) {
					Debug.logWarning(e, e.getMessage(), module);
				}
			}
		}

		// create the result map
		Map<String, Object> result = ServiceUtil.returnSuccess();

		result.put("viewIndex", viewIndex);
		result.put("viewSize", viewSize);
		result.put("listIt", orderList);
		result.put("listSize", Integer.valueOf(orderCount));

		return result;
	}

	protected static EntityExpr makeExpr(String fieldName, String value) {
		return makeExpr(fieldName, value, false);
	}

	protected static EntityExpr makeExpr(String fieldName, String value, boolean forceLike) {
		EntityComparisonOperator<?, ?> op = forceLike ? EntityOperator.LIKE : EntityOperator.EQUALS;

		if (value.startsWith("*")) {
			op = EntityOperator.LIKE;
			value = "%" + value.substring(1);
		}
		else if (value.startsWith("%")) {
			op = EntityOperator.LIKE;
		}

		if (value.endsWith("*")) {
			op = EntityOperator.LIKE;
			value = value.substring(0, value.length() - 1) + "%";
		}
		else if (value.endsWith("%")) {
			op = EntityOperator.LIKE;
		}

		if (forceLike) {
			if (!value.startsWith("%")) {
				value = "%" + value;
			}
			if (!value.endsWith("%")) {
				value = value + "%";
			}
		}

		return EntityCondition.makeCondition(fieldName, op, value);
	}

	public static Map<String, Object> delDeliveryAddress(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map result = FastMap.newInstance();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();

		Object contactMechIdObj = context.get("contactMechId");
		Object userLogin = context.get("userLogin");
		String contactMechId = null;
		String partyId = null;
		if (UtilValidate.isNotEmpty(contactMechIdObj)) {
			contactMechId = (String) contactMechIdObj;
		}
		if (UtilValidate.isNotEmpty(userLogin)) {
			partyId = ((GenericValue) userLogin).getString("partyId");
		}
		if (UtilValidate.isNotEmpty(partyId) && UtilValidate.isNotEmpty(contactMechId)) {
			try {
				List<GenericValue> pcmList = delegator.findByAnd("PartyContactMech", UtilMisc.toMap("partyId", partyId, "contactMechId", contactMechId));
//				GenericValue cm = delegator.findByPrimaryKey("ContactMech", UtilMisc.toMap("contactMechId", contactMechId));
//				GenericValue pa = delegator.findByPrimaryKey("PostalAddress", UtilMisc.toMap("contactMechId", contactMechId));
				Timestamp now = UtilDateTime.nowTimestamp();
				if (UtilValidate.isNotEmpty(pcmList)) {
					for (GenericValue gv : pcmList) {
						gv.set("thruDate", now);
						gv.store();
					}
				}
				/*
				if (UtilValidate.isNotEmpty(cm)) {
					cm.set("thruDate", now);
					cm.store();
				}
				if (UtilValidate.isNotEmpty(pa)) {
					pa.set("thruDate", now);
					pa.store();
				}
				*/
			} catch (GenericEntityException e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	public static Map<String, Object> updatePostalAddr(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map result = FastMap.newInstance();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();

		Object toName = context.get("toName");
		Object address1 = context.get("address1");
		Object stateProvinceGeoId = context.get("stateProvinceGeoId");
		Object cityGeoId = context.get("cityGeoId");
		Object countyGeoId = context.get("countyGeoId");
		Object postalCode = context.get("postalCode");
		Object mobileExd = context.get("mobileExd");
		Object phoneExd = context.get("phoneExd");
		Object contactMechId = context.get("contactMechId");
		String flag = "1";
		if (UtilValidate.isEmpty(contactMechId)) {
			flag = "0";
		} else {
			try {
				GenericValue postalAddress = delegator.findByPrimaryKey("PostalAddress", UtilMisc.toMap("contactMechId", (String) contactMechId));
				if (UtilValidate.isEmpty(postalAddress)) {
					flag = "0";
				} else {
					if (UtilValidate.isNotEmpty(toName)) {
						postalAddress.put("toName", toName);
					}
					if (UtilValidate.isNotEmpty(address1)) {
						postalAddress.put("address1", address1);
					}
					if (UtilValidate.isNotEmpty(stateProvinceGeoId)) {
						postalAddress.put("stateProvinceGeoId", stateProvinceGeoId);
					}
					if (UtilValidate.isNotEmpty(cityGeoId)) {
						postalAddress.put("cityGeoId", cityGeoId);
					}
					if (UtilValidate.isNotEmpty(countyGeoId)) {
						postalAddress.put("countyGeoId", countyGeoId);
					}
					if (UtilValidate.isNotEmpty(postalCode)) {
						postalAddress.put("postalCode", postalCode);
					}
					if (UtilValidate.isNotEmpty(mobileExd)) {
						postalAddress.put("mobileExd", mobileExd);
					}
					if (UtilValidate.isNotEmpty(phoneExd)) {
						postalAddress.put("phoneExd", phoneExd);
					}
					postalAddress.store();
					result.put("flag", flag);
					return result;
				}
			} catch (GenericEntityException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		result.put("flag", flag);
		return result;
	}

}
