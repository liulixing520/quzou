package org.ofbiz.account;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;


public class CardBaseServices {

	public static final String module = CardBaseServices.class.getName();
	public static final String resource = "CardAccountUiLabels";
	
	
	/**
	 * 新增个人账户 同时建立party
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> createCustomerAccount(DispatchContext dctx,Map<String,Object> context) {
		GenericValue userLogin = (GenericValue) context.get("userLogin");
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		Map<String, Object> result = ServiceUtil.returnSuccess();
	
		Timestamp fromDate = (Timestamp)context.get("fromDate");
		Timestamp thruDate = (Timestamp)context.get("thruDate");
		                               
		String productStoreId = (String)context.get("productStoreId");
		
		String currencyUomId =  (String)context.get("currencyUomId");if(UtilValidate.isEmpty(currencyUomId)){currencyUomId="CNY";}
		String finAccountTypeId =  (String)context.get("finAccountTypeId");if(UtilValidate.isEmpty(finAccountTypeId)){finAccountTypeId="FA_AMOUNT";}//斑点卡
		String statusId =  (String)context.get("statusId");if(UtilValidate.isEmpty(statusId)){statusId="FNACT_ACTIVE";}//有效
		String isRefundable =  (String)context.get("isRefundable");if(UtilValidate.isEmpty(isRefundable)){isRefundable="Y";}
		     
		List<GenericValue> toBeStore =FastList.newInstance();
		try {
			String partyId =delegator.getNextSeqId("Party");
			GenericValue productStore =delegator.findOne("ProductStore", UtilMisc.toMap("productStoreId", productStoreId), true);
			String orderNumberPrefix =(String) productStore.get("orderNumberPrefix");
			if(UtilValidate.isNotEmpty(orderNumberPrefix)){
				partyId=orderNumberPrefix+partyId;
			}
			
			GenericValue party =delegator.makeValue("Party", UtilMisc.toMap("partyId",partyId,"partyTypeId","PERSON"));
			toBeStore.add(party);
			
			GenericValue person =delegator.makeValue("Person", UtilMisc.toMap("partyId",partyId));
			person.setNonPKFields(context);
			toBeStore.add(person);
			GenericValue partyRole =delegator.makeValue("PartyRole", UtilMisc.toMap("partyId",partyId,"roleTypeId","CUSTOMER"));
			toBeStore.add(partyRole);
			
			delegator.storeAll(toBeStore);
			Map service_context = UtilMisc.toMap("userLogin",userLogin,"currencyUomId", currencyUomId,"finAccountTypeId", finAccountTypeId,"isRefundable", isRefundable,"statusId", statusId);
			service_context.put("ownerPartyId", partyId);
			service_context.put("organizationPartyId", productStore.getString("payToPartyId"));
			
				if(UtilValidate.isEmpty(fromDate)){
					fromDate = UtilDateTime.nowTimestamp();
				}
				service_context.put("fromDate", fromDate);
				if(UtilValidate.isNotEmpty(thruDate)){
					service_context.put("thruDate", thruDate);
				}
			
			Map service_result =dispatcher.runSync("createFinAccount", service_context);
			String finAccountId =(String) service_result.get("finAccountId");
		
			result.put("finAccountId", finAccountId);
			result.put("customerId", partyId);
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resource,"not.find.finAccount", new Object[] { e.getMessage() },locale));
		} catch (GenericServiceException e) {
			Debug.logError(e.getMessage(), module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resource,"create.FinAccount.Auth.error", new Object[] { e.getMessage() },locale));
		}
	return result;
	}
	
	
	
	/**
	 * 新增客户的一张卡金融账户
	 * @param dctx
	 * @param context
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static Map<String, Object> createCustomerCardAccount(DispatchContext dctx,Map<String,Object> context) {
		GenericValue userLogin = (GenericValue) context.get("userLogin");
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		Map<String, Object> result = ServiceUtil.returnSuccess();
		String ownerPartyId = (String)context.get("ownerPartyId");
		                               
		String productStoreId = (String)context.get("productStoreId");
		
		String currencyUomId =  (String)context.get("currencyUomId");if(UtilValidate.isEmpty(currencyUomId)){currencyUomId="CNY";}
		String finAccountTypeId =  (String)context.get("finAccountTypeId");if(UtilValidate.isEmpty(finAccountTypeId)){finAccountTypeId="FA_AMOUNT";}//通用金融帐户卡
		String statusId =  (String)context.get("statusId");if(UtilValidate.isEmpty(statusId)){statusId="FNACT_ACTIVE";}//有效
		String isRefundable =  (String)context.get("isRefundable");if(UtilValidate.isEmpty(isRefundable)){isRefundable="Y";}
		     
		try {
			GenericValue productStore =delegator.findOne("ProductStore", UtilMisc.toMap("productStoreId", productStoreId), true);
			
			Map service_context = UtilMisc.toMap("userLogin",userLogin,"currencyUomId", currencyUomId,"finAccountTypeId", finAccountTypeId,"isRefundable", isRefundable,"statusId", statusId);
			service_context.put("ownerPartyId", ownerPartyId);
			service_context.put("organizationPartyId", productStore.getString("payToPartyId"));
				
			GenericValue finAccountType = delegator.findOne("FinAccountType", UtilMisc.toMap("finAccountTypeId",finAccountTypeId),false);
			service_context.put("finAccountName",finAccountType.getString("description"));
				
			Map service_result =dispatcher.runSync("createFinAccount", service_context);
			String finAccountId =(String) service_result.get("finAccountId");
		
			result.put("finAccountId", finAccountId);
			result.put("ownerPartyId", ownerPartyId);
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resource,"not.find.finAccount", new Object[] { e.getMessage() },locale));
		} catch (GenericServiceException e) {
			Debug.logError(e.getMessage(), module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resource,"create.FinAccount.Auth.error", new Object[] { e.getMessage() },locale));
		}
	return result;
	}
	/**
	 * 充值
	 */
	public static Map<String, Object> createRecharge(DispatchContext dctx,Map<String,Object> context) {
		GenericValue userLogin = (GenericValue) context.get("userLogin");
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		Map<String, Object> result = ServiceUtil.returnSuccess();
		String productStoreId = (String)context.get("productStoreId");
		String ownerPartyId = (String)context.get("ownerPartyId");
		BigDecimal amount = (BigDecimal) context.get("amount");
		String amountString = (String)context.get("amountString");
		
		String finAccountId = (String)context.get("finAccountId");
		
		try {
			
			if(UtilValidate.isEmpty(amount)){
				amount = new BigDecimal(amountString);
			}
			Map service_context = UtilMisc.toMap("userLogin",userLogin,"finAccountId", finAccountId,"amount", amount,"partyId",ownerPartyId,"productStoreId",productStoreId);
			Map service_result =dispatcher.runSync("finAccountDeposit", service_context);//comments
			BigDecimal balance =(BigDecimal) service_result.get("balance");
			BigDecimal previousBalance =(BigDecimal) service_result.get("previousBalance");
			String refNum = (String)service_result.get("referenceNum");
	        //yangpeng  处理payment的transId
	        if(UtilValidate.isNotEmpty(refNum)){
	        	GenericValue finAccountTrans = delegator.findByPrimaryKey("FinAccountTrans", UtilMisc.toMap("finAccountTransId", refNum));
		        if(UtilValidate.isNotEmpty(finAccountTrans)){
		        	String paymentId = finAccountTrans.getString("paymentId");
			        GenericValue payment = delegator.findByPrimaryKey("Payment", UtilMisc.toMap("paymentId", paymentId));
			        payment.set("finAccountTransId", refNum);
			        payment.store();
			        
			        result.put("paymentId", paymentId);
		        }
	        }
			
			
			result.put("previousBalance", previousBalance);
			result.put("balance", balance);
			result.put("ownerPartyId", ownerPartyId);
		} catch (GenericServiceException e) {
			Debug.logError(e.getMessage(), module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resource,"create.Recharge.error", new Object[] { e.getMessage() },locale));
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resource,"create.Recharge.error", new Object[] { e.getMessage() },locale));
		}
	return result;
	}
	
	/**
	 * 消费
	 */
	public static Map<String, Object> createConsume(DispatchContext dctx,Map<String,Object> context) {
		GenericValue userLogin = (GenericValue) context.get("userLogin");
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		Map<String, Object> result = ServiceUtil.returnSuccess();
		
		//收银店铺
		String productStoreId = (String)context.get("productStoreId");
		//消费者
		String ownerPartyId = (String)context.get("ownerPartyId");
		//金额
		BigDecimal amount = (BigDecimal) context.get("amount");
		String amountString = (String)context.get("amountString");
		//订单
		String externalId = (String)context.get("externalId");
		//实操或者产品，供薪资计算用
		String paymentEnumId = (String)context.get("paymentEnumId");
		
		//帐户id
		String finAccountId = (String)context.get("finAccountId");
		if(UtilValidate.isEmpty(amount)){
			amount = new BigDecimal(amountString);
		}
		
		//备注说明
		String comments = (String)context.get("comments");
		try {

			GenericValue finAccount =delegator.findOne("FinAccount", UtilMisc.toMap("finAccountId", finAccountId),false);
			
			if(UtilValidate.isEmpty(finAccount)||UtilValidate.isEmpty(finAccount.get("finAccountId"))){
				return ServiceUtil.returnError(UtilProperties.getMessage(resource,"not.find.finAccount", new Object[] { },locale));
			}
			
			/**判断消费金额小于帐户余额*/
			BigDecimal balance =BigDecimal.ZERO;
			if(UtilValidate.isNotEmpty(finAccount.getBigDecimal("availableBalance"))){
				balance =finAccount.getBigDecimal("availableBalance");
			}
			if(amount.compareTo(balance)==1){
				return ServiceUtil.returnError(UtilProperties.getMessage(resource,"amount > balance", new Object[] { },locale));
			}
			
			Map service_context = UtilMisc.toMap("userLogin",userLogin,"finAccountId", finAccountId,"amount", amount,"partyId",ownerPartyId,"productStoreId",productStoreId);
			
			Map service_result =dispatcher.runSync("finAccountWithdraw", service_context);
			BigDecimal result_balance =(BigDecimal) service_result.get("balance");
			BigDecimal previousBalance =(BigDecimal) service_result.get("previousBalance");
			String referenceNum =(String) service_result.get("referenceNum");
			Boolean processResult =(Boolean) service_result.get("processResult");
			
	        if(processResult&&UtilValidate.isNotEmpty(externalId)){
	        	GenericValue finAccountTrans =delegator.findOne("FinAccountTrans", UtilMisc.toMap("finAccountTransId", referenceNum), false);
	        	String paymentId =finAccountTrans.getString("paymentId");
	        	if(UtilValidate.isNotEmpty(paymentId)){
	        		GenericValue payment =delegator.findOne("Payment", UtilMisc.toMap("paymentId", paymentId), false);
		        	payment.put("externalId", externalId);
		        	if(UtilValidate.isEmpty(paymentEnumId)){
		        		paymentEnumId =finAccount.getString("finAccountTypeId");
		    		}
		        	payment.put("paymentEnumId", paymentEnumId);
		        	payment.put("comments", comments);
		        	delegator.store(payment);
	        	}
	        }
	        
	        
	        GenericValue finAccountTrans =delegator.findOne("FinAccountTrans", UtilMisc.toMap("finAccountTransId", referenceNum), false);
        	String paymentId =finAccountTrans.getString("paymentId");
        	result.put("paymentId", paymentId);
        	GenericValue payment = delegator.findByPrimaryKey("Payment", UtilMisc.toMap("paymentId", paymentId));
	        payment.set("finAccountTransId", referenceNum);
	        payment.store();
	        
//			BigDecimal result_amount =(BigDecimal) service_result.get("amount");
			
			result.put("previousBalance", previousBalance);
			result.put("balance", result_balance);
//			result.put("amount", result_amount);
			result.put("ownerPartyId", ownerPartyId);
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resource,"not.find.finAccount", new Object[] { e.getMessage() },locale));
		} catch (GenericServiceException e) {
			Debug.logError(e.getMessage(), module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resource,"create.createConsume.error", new Object[] { e.getMessage() },locale));
		}
	return result;
	}
	
	
	/**
	 * 获取用户账户
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> getCustomerAccountInfo(DispatchContext dctx,Map<String,Object> context) {
		GenericValue userLogin = (GenericValue) context.get("userLogin");
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		Map<String, Object> result = ServiceUtil.returnSuccess();
		String customerId = (String)context.get("customerId");
		try {
			List finAccountInfo = delegator.findByAnd("FinAccount", UtilMisc.toMap("ownerPartyId", customerId,"finAccountTypeId","FA_AMOUNT"));
			GenericValue finAccount =EntityUtil.getFirst(finAccountInfo);
			if(UtilValidate.isEmpty(finAccount)||UtilValidate.isEmpty(finAccount.get("finAccountId"))){
				return ServiceUtil.returnError(UtilProperties.getMessage(resource,"not.find.finAccount", new Object[] { },locale));
			}
			result= finAccount;
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resource,"not.find.finAccount", new Object[] { e.getMessage() },locale));
		}
	    return result;
	}
	
	/**
	 * 列出客户所有帐号
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> listCustomerAccount(DispatchContext dctx,Map<String,Object> context) {
		GenericValue userLogin = (GenericValue) context.get("userLogin");
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		Map<String, Object> result = ServiceUtil.returnSuccess();
		String customerId = (String)context.get("customerId");
		try {
			List customerAccountList = delegator.findByAnd("FinAccount", UtilMisc.toMap("ownerPartyId", customerId));
			result.put("customerAccountList", customerAccountList);
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resource,"not.find.finAccount", new Object[] { e.getMessage() },locale));
		}
	    return result;
	}
	
	/**
	 * 获取客户充值列表
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> listCustomerPaymentReceipt(DispatchContext dctx,Map<String,Object> context) {
		GenericValue userLogin = (GenericValue) context.get("userLogin");
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		Map<String, Object> result = ServiceUtil.returnSuccess();
		List resultList=FastList.newInstance();
		String productStoreId = (String)context.get("productStoreId");
		String customerId = (String)context.get("customerId");
		try {
			GenericValue productStore= delegator.findOne("ProductStore", UtilMisc.toMap("productStoreId", productStoreId), true);
			
			
			
			List<GenericValue> paymentList = delegator.findByAnd("Payment", UtilMisc.toMap("partyIdFrom", customerId,"partyIdTo",productStore.getString("payToPartyId")),UtilMisc.toList("effectiveDate"));
			
			for(GenericValue payment:paymentList){
				Map map =FastMap.newInstance();
				map.put("amount", payment.getBigDecimal("amount"));
				map.put("currencyUomId", payment.getString("currencyUomId"));
				map.put("partyIdFrom", payment.getString("partyIdFrom"));
				map.put("partyIdTo", payment.getString("partyIdTo"));
				map.put("paymentId", payment.getString("paymentId"));
				map.put("paymentMethodTypeId", payment.getString("paymentMethodTypeId"));
				map.put("paymentRefNum", payment.getString("paymentRefNum"));
				
				map.put("paymentTypeId", payment.getString("paymentTypeId"));
				map.put("statusId", payment.getString("statusId"));
				map.put("effectiveDate", payment.getTimestamp("effectiveDate"));
				resultList.add(map);
			}
			result.put("paymentList", resultList);
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resource,"listCustomerPaymentReceipt", new Object[] { e.getMessage() },locale));
		}
	    return result;
	}
   
       
       
      /**
       * 获取客户消费列表
       * @param dctx
       * @param context
       * @return
       */
   @SuppressWarnings({ "rawtypes", "unchecked" })
   public static Map<String, Object> listCustomerPaymentDisbursement(DispatchContext dctx,Map<String,Object> context) {
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		Map<String, Object> result = ServiceUtil.returnSuccess();
		List resultList=FastList.newInstance();
		String productStoreId = (String)context.get("productStoreId");
		String customerId = (String)context.get("customerId");
		try {
			GenericValue productStore= delegator.findOne("ProductStore", UtilMisc.toMap("productStoreId", productStoreId), true);
			List<GenericValue> paymentList = delegator.findByAnd("Payment", UtilMisc.toMap("partyIdFrom",productStore.getString("payToPartyId") ,"partyIdTo",customerId),UtilMisc.toList("effectiveDate"));
			
			for(GenericValue payment:paymentList){
				Map map =FastMap.newInstance();
				map.put("amount", payment.getBigDecimal("amount"));
				map.put("currencyUomId", payment.getString("currencyUomId"));
				map.put("partyIdFrom", payment.getString("partyIdFrom"));
				map.put("partyIdTo", payment.getString("partyIdTo"));
				map.put("paymentId", payment.getString("paymentId"));
				map.put("paymentMethodTypeId", payment.getString("paymentMethodTypeId"));
				map.put("paymentRefNum", payment.getString("paymentRefNum"));
				
				map.put("paymentTypeId", payment.getString("paymentTypeId"));
				map.put("statusId", payment.getString("statusId"));
			    map.put("effectiveDate", payment.getTimestamp("effectiveDate"));
				resultList.add(map);
			}
			result.put("paymentList", resultList);
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resource,"listCustomerPaymentDisbursement", new Object[] { e.getMessage() },locale));
		}
	    return result;
	}
}
