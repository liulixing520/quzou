package org.ofbiz.quzou;

import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.StringUtil;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;

public class QzCustomerServices {
	public static final String module = QzCustomerServices.class.getName();
	public static final String resource = "quzouUiLabels";
	public static final String resourceError = "quzouErrorUiLabels";

	/**
	 * 创建数据
	 * 
	 * Create a MemberBase. If no memberId is specified a numeric memberId is
	 * retrieved from the MemberBase sequence.
	 *  
	 * @param dctx
	 *            The DispatchContext that this service is operating in.
	 * @param context
	 *            Map containing the input parameters.
	 * @return Map with the result of the service, the output parameters.
	 */
	public static Map<String, Object> createQzCustomer(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		GenericValue gv = null;

		if (result.size() > 0)
			return result;

		String customerId = null;
		try {
			if (UtilValidate.isNotEmpty(context.get("customerId"))) {
				customerId = context.get("customerId").toString();
			} else {
				customerId = delegator.getNextSeqId("QzCustomer");
			}
		} catch (IllegalArgumentException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCustomer.id_generation_failure", locale));
		}

		gv = delegator.makeValue("QzCustomer", UtilMisc.toMap("customerId", customerId));
		gv.setNonPKFields(context);
		try {
			gv.create();
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCustomer.create_failure", locale));
		}

		if (gv != null) {
			result.put("customerId", customerId);
		}
		result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
		return result;
	}

	/**
	 * 更新数据
	 * 
	 * update a MemberBase.
	 * 
	 * @param dctx
	 *            The DispatchContext that this service is operating in.
	 * @param context
	 *            Map containing the input parameters.
	 * @return Map with the result of the service, the output parameters.
	 */
	public static Map<String, Object> updateQzCustomer(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");

		String customerId = (String) context.get("customerId");
		GenericValue gv = null;

		try {
			gv = delegator.findOne("QzCustomer", false, UtilMisc.toMap("customerId", customerId));
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCustomer.find_failure", locale));
		}
		if (gv != null) {
			gv.setNonPKFields(context);
			try {
				gv.store();
				// result.put("memberId", memberId);
			} catch (GenericEntityException e) {
				Debug.logError(e, module);
				return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCustomer.update_failure", locale));
			}
		}

		result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
		return result;
	}

	/**
	 * 删除数据
	 * 
	 * delete a MemberBase.
	 * 
	 * @param dctx
	 *            The DispatchContext that this service is operating in.
	 * @param context
	 *            Map containing the input parameters.
	 * @return Map with the result of the service, the output parameters.
	 */
	public static Map<String, Object> deleteQzCustomer(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");

		String customerId = (String) context.get("customerId");
		GenericValue gv = null;

		try {
			gv = delegator.findOne("QzCustomer", false, UtilMisc.toMap("customerId", customerId));
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCustomer.find_failure", locale));
		}
		if (UtilValidate.isNotEmpty(gv)) {
			try {
				gv.put("thruDate", UtilDateTime.nowTimestamp());
				gv.store();
			} catch (GenericEntityException e) {
				Debug.logError(e, module);
				return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCustomer.delete_failure", locale));
			}
		}

		result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
		return result;
	}

	/**
	 * 批量删除数据
	 * 
	 * delete a MemberBase.
	 * 
	 * @param dctx
	 *            The DispatchContext that this service is operating in.
	 * @param context
	 *            Map containing the input parameters.
	 * @return Map with the result of the service, the output parameters.
	 */
	public static Map<String, Object> deleteAllQzCustomer(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = FastMap.newInstance();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Locale locale = (Locale) context.get("locale");
		GenericValue userLogin = (GenericValue) context.get("userLogin");
		try {
			List<String> idList = StringUtil.split((String) context.get("ids"), ",");
			for (int i = 0; i < idList.size(); i++) {
				dispatcher.runSync("deleteQzCustomer", UtilMisc.toMap("customerId", idList.get(i), "userLogin", userLogin));
			}
		} catch (Exception e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCustomer.delete_failure", locale));
		}

		result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
		return result;
	}
	
	public static Map<String, Object> setPartysStatus(DispatchContext dctx, Map<String, ? extends Object> context) {
		Delegator delegator = dctx.getDelegator();

		String partyIds = (String) context.get("partyIds");
		String partyStatusId = (String) context.get("partyStatusId");

		List<String> partyList = Arrays.asList(partyIds.split(","));
		List<GenericValue> list = FastList.newInstance();

		try {
			for (String partyId : partyList) {
				GenericValue party = delegator.findByPrimaryKey("Party", UtilMisc.toMap("partyId", partyId));
				party.setString("statusId", partyStatusId);
				list.add(party);

				List<GenericValue> ulList = delegator.findByAnd("UserLogin", UtilMisc.toMap("partyId", partyId));
				for (GenericValue genericValue : ulList) {
					if ("PARTY_DISABLED".equals(partyStatusId)) {
						genericValue.setString("enabled", "N");
					} else if ("PARTY_ENABLED".equals(partyStatusId)) {
						genericValue.setString("enabled", "Y");
					}
					list.add(genericValue);
				}
			}
			delegator.storeAll(list);
		} catch (GenericEntityException e) {
			e.printStackTrace();
		}

		return ServiceUtil.returnSuccess();
	}
}
