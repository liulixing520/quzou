package org.ofbiz.quzou;

import java.math.BigDecimal;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
import java.util.Map;

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
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.transaction.GenericTransactionException;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;


public class QzCustomerLogServices {
	public static final String module = QzCustomerLogServices.class.getName();
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
	public static Map<String, Object> createQzCustomerLog(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		GenericValue gv = null;

		if (result.size() > 0)
			return result;

		String logId = null;
		try {
			if (UtilValidate.isNotEmpty(context.get("logId"))) {
				logId = context.get("logId").toString();
			} else {
				logId = delegator.getNextSeqId("QzCustomerLog");
			}
		} catch (IllegalArgumentException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCustomerLog.id_generation_failure", locale));
		}

		gv = delegator.makeValue("QzCustomerLog", UtilMisc.toMap("logId", logId));
		gv.setNonPKFields(context);
		gv.set("uploadDate", UtilDateTime.nowTimestamp());
		try {
			gv.create();
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCustomerLog.create_failure", locale));
		}

		if (gv != null) {
			result.put("logId", logId);
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
	public static Map<String, Object> updateQzCustomerLog(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String logId = (String) context.get("logId");
		GenericValue gv = null;

		try {
			gv = delegator.findOne("QzCustomerLog", false, UtilMisc.toMap("logId", logId));
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCustomerLog.find_failure", locale));
		}
		if (gv != null) {
			gv.setNonPKFields(context);
			try {
				gv.store();
				// result.put("memberId", memberId);
			} catch (GenericEntityException e) {
				Debug.logError(e, module);
				return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCustomerLog.update_failure", locale));
			}
		}
		result.put("earlyDate", sdf.format(gv.get("stepDate")));
		result.put("lastDate", sdf.format(gv.get("stepDate")));
		result.put("listIds", gv.get("cardId"));
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
	public static Map<String, Object> deleteQzCustomerLog(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String logId = (String) context.get("logId");
		GenericValue gv = null;

		try {
			gv = delegator.findOne("QzCustomerLog", false, UtilMisc.toMap("logId", logId));
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCustomerLog.find_failure", locale));
		}
		if (UtilValidate.isNotEmpty(gv)) {
			try {
				gv.put("thruDate", UtilDateTime.nowTimestamp());
				gv.store();
			} catch (GenericEntityException e) {
				Debug.logError(e, module);
				return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCustomerLog.delete_failure", locale));
			}
		}
		result.put("earlyDate", sdf.format(gv.get("stepDate")));
		result.put("lastDate", sdf.format(gv.get("stepDate")));
		result.put("listIds", gv.get("cardId"));
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
	public static Map<String, Object> deleteAllQzCustomerLog(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = FastMap.newInstance();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Locale locale = (Locale) context.get("locale");
		GenericValue userLogin = (GenericValue) context.get("userLogin");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String listIds ="";
		String earlyDate ="";
		String lastDate ="";
		try {
			List<String> idList = StringUtil.split((String) context.get("ids"), ",");
			for (int i = 0; i < idList.size(); i++) {
				Map<String, Object> restultMap = dispatcher.runSync("deleteQzCustomerLog", UtilMisc.toMap("logId", idList.get(i), "userLogin", userLogin));
				String ids = (String) restultMap.get("listIds");
				if(UtilValidate.isEmpty(earlyDate)){
					earlyDate = (String) restultMap.get("earlyDate");
					lastDate = (String) restultMap.get("lastDate");
				}else {
					java.util.Date date1 = sdf.parse(earlyDate);
					java.util.Date date2 = sdf.parse((String)restultMap.get("earlyDate"));
					if(date2.before(date1)){
						earlyDate = (String)restultMap.get("earlyDate");
					}
					
					java.util.Date date3 = sdf.parse(lastDate);
					java.util.Date date4 = sdf.parse((String)restultMap.get("lastDate"));
					if(date3.before(date4)){
						lastDate = (String)restultMap.get("lastDate");
					}
				}
				if(!listIds.contains(ids)){
					if (UtilValidate.isNotEmpty(listIds)) {listIds +=",";}
					listIds += ids;
				}
			}
		} catch (Exception e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCustomerLog.delete_failure", locale));
		}
		result.put("listIds", listIds);
		result.put("earlyDate", earlyDate);
		result.put("lastDate", lastDate);
		Debug.log("result_______"+result);
		result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
		return result;
	}
	
	/**
	 * 上传数据（app端接口调用）
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> uploadDaTa(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = dctx.getDelegator();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Locale locale = (Locale) context.get("locale");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<Map<String, Object>> list = (List<Map<String, Object>>) context.get("customerLogList");
		String listIds = "";
		java.util.Date earlyDate = new java.util.Date();
		java.util.Date lastDate = new java.util.Date();
		String earlyDateStr ="";
		String lastDateStr ="";
		try {
			TransactionUtil.begin();
				if(UtilValidate.isNotEmpty(list)){
					for (Map<String, Object> map : list) {
						if(UtilValidate.isNotEmpty(map)){
							String cardId = (String) map.get("cardId");
							if(!listIds.contains(cardId)){
								if (UtilValidate.isNotEmpty(listIds)) {listIds +=",";}
								listIds += cardId;
							}
							String stepNumber = (String) map.get("stepNumber");
							String stepDate = (String) map.get("stepDate");
							Map<String, Object> inMap = FastMap.newInstance();
							try {
								java.util.Date newDate = sdf.parse(stepDate);
								if(UtilValidate.isEmpty(earlyDateStr)){
									earlyDate = newDate;
									earlyDateStr = sdf.format(earlyDate);
								}else {
									if(newDate.before(earlyDate)){
										earlyDate = newDate; 
										earlyDateStr = sdf.format(earlyDate);
									}
								}
								
								if(UtilValidate.isEmpty(lastDateStr)){
									lastDate = newDate;
									lastDateStr = sdf.format(lastDate);
								}else {
									if(lastDate.before(newDate)){
										lastDate = newDate; 
										lastDateStr = sdf.format(lastDate);
									}
								}
								
								Date sqlStepDate = new java.sql.Date(newDate.getTime());
								List<GenericValue> logList = delegator.findByAnd("QzCustomerLog", UtilMisc.toMap("cardId",cardId,"stepDate",sqlStepDate));
								if(UtilValidate.isEmpty(logList)){
									inMap.put("cardId", cardId);
									inMap.put("stepNumber", new Long(stepNumber));
									inMap.put("stepDate", sqlStepDate);
									Map<String,Object> resultMap = dispatcher.runSync("createQzCustomerLog", inMap);
								}else {
									GenericValue logGv = logList.get(0);
									logGv.set("stepNumber", new Long(stepNumber));
									logGv.set("uploadDate", UtilDateTime.nowTimestamp());
									logGv.store();
								}
							} catch (GenericEntityException e) {
								e.printStackTrace();
								return ServiceUtil.returnError("查询失败，请确认数据是否正确");
							} catch (GenericServiceException e) {
								e.printStackTrace();
								return ServiceUtil.returnError("生成数据失败，请确认数据是否正确");
							} catch (ParseException e) {
								e.printStackTrace();
								return ServiceUtil.returnError("日期格式不正确");
							}
						}
					}
				}else{
					return ServiceUtil.returnError("数据异常，请确认数据是否正确");
				}
			result.put("listIds", listIds);
			result.put("earlyDate", sdf.format(earlyDate));
			result.put("lastDate", sdf.format(lastDate));
			TransactionUtil.commit();
		} catch (GenericTransactionException e1) {
			e1.printStackTrace();
			try {
                TransactionUtil.rollback();
            } catch (GenericTransactionException e2) {
            	return ServiceUtil.returnError("提交失败，已回滚");
            }
		}
		result.put("nowDateString", UtilDateTime.nowDateString("yyyy-MM-dd HH:mm:ss"));
		result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
		return result;
	}
	
	/**
	 * 统计积分、步数
	 * TODO 未完成
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> ReportStat(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = dctx.getDelegator();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Locale locale = (Locale) context.get("locale");
		String listIds = (String)context.get("listIds");
		String[] ids = listIds.split(",");
		for (String id : ids) {
			try {
				GenericValue person = EntityUtil.getFirst(delegator.findByAnd("Person", UtilMisc.toMap("cardId",id)));
				List<GenericValue> competitionList = delegator.findByAnd("QzCompetiAndCustomerView",UtilMisc.toMap("customerId",person.get("partyId")));
				List<GenericValue> customerLogList = delegator.findByAnd("CustomerLogAndCustomer",UtilMisc.toMap("partyId",person.get("partyId")));
				Long totalIntegral = new Long("0");
				Long totalStepNumber = new Long("0");
				for(GenericValue gv : competitionList){
					String minStep = (String) gv.get("minStep");
					String maxStep = (String) gv.get("maxStep");
					String stepCoefficient = (String) gv.get("stepCoefficient");
					List<GenericValue> logList = EntityUtil.filterByCondition(customerLogList,
						EntityCondition.makeCondition(
				                EntityCondition.makeCondition("stepDate", EntityOperator.GREATER_THAN_EQUAL_TO, gv.get("startDate")),
				                EntityCondition.makeCondition("stepDate", EntityOperator.LESS_THAN_EQUAL_TO, gv.get("endDate")))
						);
					Long cIntegral = new Long("0");
					for(GenericValue logGv : logList){
						String stepNum = (String) logGv.get("stepNumber");
						totalStepNumber += Long.valueOf("stepNum");
						if((Long.valueOf(stepNum) >= Long.valueOf(minStep)) && (Long.valueOf(stepNum) < Long.valueOf(maxStep))){
							cIntegral = Long.valueOf(stepNum) / (Long.valueOf(stepCoefficient) * 100);
						}else if((Long.valueOf(stepNum) >= Long.valueOf(maxStep))){
							cIntegral = Long.valueOf(maxStep) / (Long.valueOf(stepCoefficient) * 100);
						}
					}
					totalIntegral +=cIntegral;
				}
			} catch (GenericEntityException e) {
				e.printStackTrace();
			}
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<Map<String, Object>> list = (List<Map<String, Object>>) context.get("customerLogList");
		return result;
		
	}
	
}
