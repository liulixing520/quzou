package org.ofbiz.ebiz.order;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilNumber;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityConditionList;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.order.order.OrderChangeHelper;
import org.ofbiz.order.order.OrderReadHelper;
import org.ofbiz.security.Security;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;


/**
	重写部分订单处理功能
 */
public class OrderServices {
	public static final String module = OrderServices.class.getName();
    public static final String resource = "OrderUiLabels";
    public static final String resource_error = "OrderErrorUiLabels";
    public static final String resourceProduct = "ProductUiLabels";
    public static final int decimals = UtilNumber.getBigDecimalScale("order.decimals");
    public static final int rounding = UtilNumber.getBigDecimalRoundingMode("order.rounding");
    public static final BigDecimal ZERO = BigDecimal.ZERO.setScale(decimals, rounding);
    public static Map payStatuMap=new HashMap();
    	static {
    		payStatuMap.put(1,"未支付");
    		payStatuMap.put(2,"部分支付");
    		payStatuMap.put(3,"已支付");
    	}
    public static Map payTypeMap=new HashMap();
    	static{
    	payTypeMap.put("EXT_COD","货到付款");
    	payTypeMap.put("CASH","现金支付");
    	payTypeMap.put("FINACT_USERACCT","站内余额");
    	payTypeMap.put("FINACT_USERCARD","会员卡");
    	payTypeMap.put("FINACT_VOUCHER","提货卡");
    	payTypeMap.put("EXT_ALIPAY","支付宝");
    	payTypeMap.put("GIFT_CARD","礼品卡");
    	payTypeMap.put("EXT_REWARD_ACCOUNT","积分抵现");
    	payTypeMap.put("OTHER","其他");
    	}
    public static Map shipmentStatuMap=new HashMap();
    	static{
    		shipmentStatuMap.put("SHIPMENT_SHIPPED","已发货");
    		shipmentStatuMap.put("SHIPMENT_DELIVERED","已签收");
    		shipmentStatuMap.put("SHIPMENT_INPUT","待捡货");
    		shipmentStatuMap.put("SHIPMENT_SCHEDULED","已计划");
    		shipmentStatuMap.put("SHIPMENT_PICKED","已分拣");
    		shipmentStatuMap.put("SHIPMENT_PACKED","已包装");
    		shipmentStatuMap.put("SHIPMENT_CANCELLED","已拒收");
    		
    		shipmentStatuMap.put("OTHER","其他");
    	
    	} 	
	/** Service for changing the status on an order header */
    public static Map<String, Object> setOrderStatus(DispatchContext ctx, Map<String, ? extends Object> context) {
        LocalDispatcher dispatcher = ctx.getDispatcher();
        Delegator delegator = ctx.getDelegator();
        GenericValue userLogin = (GenericValue) context.get("userLogin");
        String orderId = (String) context.get("orderId");
        String statusId = (String) context.get("statusId");
        Map<String, Object> successResult = ServiceUtil.returnSuccess();
        Locale locale = (Locale) context.get("locale");

        // check and make sure we have permission to change the order
        Security security = ctx.getSecurity();
        boolean hasPermission = hasPermission(orderId, userLogin, "UPDATE", security, delegator);
        //if (!hasPermission) {
        //    return ServiceUtil.returnError(UtilProperties.getMessage(resource_error,
        //            "OrderYouDoNotHavePermissionToChangeThisOrdersStatus",locale));
        //}

        try {
            GenericValue orderHeader = delegator.findByPrimaryKey("OrderHeader", UtilMisc.toMap("orderId", orderId));

            if (orderHeader == null) {
                return ServiceUtil.returnError(UtilProperties.getMessage(resource_error,
                        "OrderErrorCouldNotChangeOrderStatusOrderCannotBeFound", locale));
            }
            // first save off the old status
            successResult.put("oldStatusId", orderHeader.get("statusId"));
            successResult.put("orderTypeId", orderHeader.get("orderTypeId"));

            if (Debug.verboseOn()) Debug.logVerbose("[OrderServices.setOrderStatus] : From Status : " + orderHeader.getString("statusId"), module);
            if (Debug.verboseOn()) Debug.logVerbose("[OrderServices.setOrderStatus] : To Status : " + statusId, module);

            if (orderHeader.getString("statusId").equals(statusId)) {
                Debug.logWarning(UtilProperties.getMessage(resource_error,
                        "OrderTriedToSetOrderStatusWithTheSameStatusIdforOrderWithId", UtilMisc.toMap("statusId",statusId,"orderId",orderId),locale),module);
                return successResult;
            }
            try {
                Map<String, String> statusFields = UtilMisc.<String, String>toMap("statusId", orderHeader.getString("statusId"), "statusIdTo", statusId);
                GenericValue statusChange = delegator.findByPrimaryKeyCache("StatusValidChange", statusFields);
                if (statusChange == null) {
                    return ServiceUtil.returnError(UtilProperties.getMessage(resource_error, 
                            "OrderErrorCouldNotChangeOrderStatusStatusIsNotAValidChange", locale) + ": [" + statusFields.get("statusId") + "] -> [" + statusFields.get("statusIdTo") + "]");
                }
            } catch (GenericEntityException e) {
                return ServiceUtil.returnError(UtilProperties.getMessage(resource_error,
                        "OrderErrorCouldNotChangeOrderStatus",locale) + e.getMessage() + ").");
            }

            // update the current status
            orderHeader.set("statusId", statusId);

            // now create a status change
            GenericValue orderStatus = delegator.makeValue("OrderStatus");
            orderStatus.put("orderStatusId", delegator.getNextSeqId("OrderStatus"));
            orderStatus.put("statusId", statusId);
            orderStatus.put("orderId", orderId);
            orderStatus.put("statusDatetime", UtilDateTime.nowTimestamp());
            orderStatus.put("statusUserLogin", userLogin.getString("userLoginId"));
            orderStatus.put("changeReason", context.get("changeReason"));

            orderHeader.store();
            orderStatus.create();

            successResult.put("needsInventoryIssuance", orderHeader.get("needsInventoryIssuance"));
            successResult.put("grandTotal", orderHeader.get("grandTotal"));
            //Debug.logInfo("For setOrderStatus orderHeader is " + orderHeader, module);
        } catch (GenericEntityException e) {
            return ServiceUtil.returnError(UtilProperties.getMessage(resource_error,
                    "OrderErrorCouldNotChangeOrderStatus",locale) + e.getMessage() + ").");
        }

        // release the inital hold if we are cancelled or approved
        if ("ORDER_CANCELLED".equals(statusId) || "ORDER_APPROVED".equals(statusId)) {
            OrderChangeHelper.releaseInitialOrderHold(ctx.getDispatcher(), orderId);

            // cancel any order processing if we are cancelled
            if ("ORDER_CANCELLED".equals(statusId)) {
                OrderChangeHelper.abortOrderProcessing(ctx.getDispatcher(), orderId);
            }
        }

        if ("Y".equals(context.get("setItemStatus"))) {
            String newItemStatusId = null;
            if ("ORDER_APPROVED".equals(statusId)) {
                newItemStatusId = "ITEM_APPROVED";
            } else if ("ORDER_COMPLETED".equals(statusId)) {
                newItemStatusId = "ITEM_COMPLETED";
            } else if ("ORDER_CANCELLED".equals(statusId)) {
                newItemStatusId = "ITEM_CANCELLED";
            }

            if (newItemStatusId != null) {
                try {
                    Map<String, Object> resp = dispatcher.runSync("changeOrderItemStatus", UtilMisc.<String, Object>toMap("orderId", orderId, "statusId", newItemStatusId, "userLogin", userLogin));
                    if (ServiceUtil.isError(resp)) {
                        return ServiceUtil.returnError(UtilProperties.getMessage(resource_error,
                                "OrderErrorCouldNotChangeItemStatus", locale) + newItemStatusId, null, null, resp);
                    }
                } catch (GenericServiceException e) {
                    Debug.logError(e, "Error changing item status to " + newItemStatusId + ": " + e.toString(), module);
                    return ServiceUtil.returnError(UtilProperties.getMessage(resource_error,
                            "OrderErrorCouldNotChangeItemStatus", locale) + newItemStatusId + ": " + e.toString());
                }
            }
        }
        //订单取消发送信息确认 @add by WuHK
        
        if(statusId.equals("ORDER_CANCELLED")&&context.get("setItemStatus").equals("ORDER_CANCELLED")){
        	Map<String,Object> emailContext = FastMap.newInstance();
    		OrderReadHelper orh = new OrderReadHelper(delegator, orderId);
    		List<String> productIdList = FastList.newInstance();
    		List<GenericValue> itemList = orh.getOrderItems();
    		if(itemList.size()>0){
	    		for(GenericValue item:itemList){
	    			productIdList.add(item.getString("productId"));
	    		}
	    		
	    		emailContext.put("productStoreId", orh.getProductStoreId());
	    		emailContext.put("eventTypeId", "E_CANCEL_ORDER");
	    		emailContext.put("orderId", orderId);
	    		emailContext.put("partyId", userLogin.getString("partyId"));
	    		emailContext.put("productIdList", productIdList);
	    		try{
	    			emailContext.put("msgTypeId", "MAIL");
	    			Map<String,Object> resultMap = dispatcher.runSync("cancelOrderMail", emailContext);
	    		}catch(Exception e){
	    			Debug.logError(e, "email send failure!");
	    		}
	    		try{
	    			emailContext.put("msgTypeId", "SMS");
	    			Map<String,Object> resultMap = dispatcher.runSync("cancelOrderMail", emailContext);
	    		}catch(Exception e){
	    			Debug.logError(e, "sms send failure!");
	    		}
	    		try{
	    			emailContext.put("msgTypeId", "INTERNAL_MSG");
	    			Map<String,Object> resultMap = dispatcher.runSync("cancelOrderMail", emailContext);
	    		}catch(Exception e){
	    			Debug.logError(e, "INTERNAL_MSG send failure!");
	    		} 
    		}
    	}
        //订单取消发送信息确认结束
        
        successResult.put("orderStatusId", statusId);
        //Debug.logInfo("For setOrderStatus successResult is " + successResult, module);
        return successResult;
    }
    /*
     * 获取整个订单支付状态-非ofbiz自带支付状态
     * 1.未支付、2.部分支付、3.支付完成
     * -获取OrderPaymentPreference订单下的支付信息，statusId、maxAmount、paymentMethodTypeId
     */
    public static String getOrderPayStatusCn(Delegator delegator,String orderId) {
    	int state=getOrderPayStatus(delegator,orderId);
    	if(state!=0){
    		return payStatuMap.get(state).toString();
    	}else{
    		return "";
    	}
    	
    }
    
    public static int getOrderPayStatus(Delegator delegator,String orderId) {
        OrderReadHelper orh = new OrderReadHelper(delegator, orderId);
        String orderTypeId = orh.getOrderTypeId();
        int payStatue = 0;
        BigDecimal receivedAmount =ZERO;
        BigDecimal grandTotal =ZERO;
        try {
        	grandTotal=orh.getOrderGrandTotal();
//        	List<GenericValue> payList=delegator.findByAnd("OrderPaymentPreference", UtilMisc.toMap("orderId",orderId,"statusId","PAYMENT_RECEIVED"));
        	//update dby dongyc PAYMENT_RECEIVED和PAYMENT_AUTHORIZED两种状态都算支付
        	EntityConditionList<EntityExpr> ecl = EntityCondition.makeCondition(UtilMisc.toList(
        			 EntityCondition.makeCondition("orderId",orderId),
        			 EntityCondition.makeCondition("statusId", EntityOperator.IN, UtilMisc.toList("PAYMENT_RECEIVED", "PAYMENT_AUTHORIZED", "PAYMENT_SETTLED"))
                     ), EntityOperator.AND);
        	 List<GenericValue> payList=delegator.findList("OrderPaymentPreference",  ecl, null, null, null, false);
        	for(GenericValue gc: payList){
        		receivedAmount=receivedAmount.add(gc.getBigDecimal("maxAmount"));
        	}
        }catch (GenericEntityException e) {
            Debug.logError("Could not select OrderPaymentPreference for order " + orderId + " due to " + e.getMessage(), module);
        }
        if(receivedAmount==ZERO){
        	payStatue=1;
        }else if(receivedAmount.compareTo(grandTotal)>=0){
        	payStatue=3;
        }else{
        	payStatue=2;
        } 
        return payStatue;
    }
    /*
     * 获取整个订单支付方式-只取一种在线支付方式-若全部为站内余额支付（金融账户），则显示余额支付
     * 1.货到付款EXT_COD、2.余额支付FIN_ACCOUNT、3.支付宝EXT_ALIPAY
     * -获取OrderPaymentPreference订单下的支付信息，paymentMethodTypeId
     */
    public static String getOrderPayTypeCn(Delegator delegator,String orderId) {
    	String state=getOrderPayType(delegator,orderId);
    	if(state!=null&&state.length()>0){
    		return payTypeMap.get(state)==null?state:payTypeMap.get(state).toString();
    	}else{
    		return "OTHER";
    	}
    	
    }
    public static String getOrderPayType(Delegator delegator,String orderId) {
        String payStatue = "";
        try {
        	List<GenericValue> payList=delegator.findByAnd("OrderPaymentPreference", UtilMisc.toMap("orderId",orderId));
        	for(GenericValue gc: payList){
        		if(gc.getString("paymentMethodTypeId").equals("EXT_COD")||gc.getString("paymentMethodTypeId").equals("EXT_ALIPAY")){
        			payStatue=gc.getString("paymentMethodTypeId");
        			break;
        		}else if(gc.getString("paymentMethodTypeId").equals("FINACT_USERACCT")||gc.getString("paymentMethodTypeId").equals("EXT_REWARD_ACCOUNT")||gc.getString("paymentMethodTypeId").equals("FINACT_USERCARD")||gc.getString("paymentMethodTypeId").equals("FINACT_VOUCHER")||gc.getString("paymentMethodTypeId").equals("CASH")){
        			payStatue=gc.getString("paymentMethodTypeId");
        			break;
        		}else{
        			payStatue="OTHER";
        		}
        	}
        }catch (GenericEntityException e) {
            Debug.logError("Could not select OrderPaymentPreference for order " + orderId + " due to " + e.getMessage(), module);
        }
        
        return payStatue;
    }
    /**
     * 获取整个订单货运状态
     * @param delegator
     * @param orderId
     * @return
     */
    public static String getOrderShipmentStateCn(Delegator delegator,String orderId) {
    	String state=getOrderShipmentState(delegator,orderId);
    	if(state!=null&&state.length()>0){
    		return shipmentStatuMap.get(state).toString();
    	}else{
    		return "";
    	}
    	
    }
    
    
    /**
     * 设置订单-货运状态
     * @param delegator
     * @param orderId
     * @return
     */
    public static Map<String, Object> setOrderShipmentState(DispatchContext ctx, Map<String, ? extends Object> context) {
        Delegator delegator = ctx.getDelegator();
        String orderId = context.get("orderId").toString();
    	String shipmentStatue = context.get("shipmentState").toString();
    	Map<String, Object> successResult = ServiceUtil.returnSuccess();
        try {
        	GenericValue shipment = delegator.create("Shipment", UtilMisc.toMap("orderId",orderId,"statusId",shipmentStatue ));
        	shipment.create();
        }catch (GenericEntityException e) {
            Debug.logError("获取发货状态出错" + e.getMessage(), module);
        }
        return successResult;
    }
    
    
    /**
     * 设置订单-货运状态
     * @param delegator
     * @param orderId
     * @return
     */
    public static Map<String, Object> getOrderShipmentInfo(DispatchContext ctx, Map<String, ? extends Object> context) {
        Delegator delegator = ctx.getDelegator();
        String orderId = context.get("orderId").toString();
    	Map<String, Object> shipmentInfo = ServiceUtil.returnSuccess();
        try {
        	GenericValue orderItemShipGroup = EntityUtil.getFirst ( delegator.findByAnd("OrderItemShipGroup", UtilMisc.toMap("orderId",orderId)) );
        	String carryPartyId = orderItemShipGroup.getString("carrierPartyId");
        	// TODO 单条货运信息 
        	GenericValue carryPartyGroup = delegator.findOne("PartyGroup", false, UtilMisc.toMap("partyId",carryPartyId));
        	GenericValue carryPerson = delegator.findOne("Person", false, UtilMisc.toMap("partyId",carryPartyId));
        	if(carryPartyGroup !=null){
	        	shipmentInfo.put("carrierName", carryPartyGroup.getString("groupName"));
	        	shipmentInfo.put("carrierSiteName", carryPartyGroup.getString("officeSiteName"));
	        	shipmentInfo.put("carrierSymbol", carryPartyGroup.getString("tickerSymbol"));
        	}
        	if(carryPerson !=null){
        		shipmentInfo.put("carrierName", carryPerson.getString("firstName"));
	        	shipmentInfo.put("carrierSiteName", carryPerson.getString("lastName"));
        	}
        	shipmentInfo.put("trackingNumber", orderItemShipGroup.getString("trackingNumber"));
        			
        }catch (GenericEntityException e) {
            Debug.logError("获取发货状态出错" + e.getMessage(), module);
        }
        return shipmentInfo;
    }
     /**
     * 获取订单-货运状态
     * @param delegator
     * @param orderId
     * @return
     */
    public static String getOrderShipmentState(Delegator delegator,String orderId) {
        String shipmentStatue = "";
        try {
        	
        	GenericValue shipment=EntityUtil.getFirst(delegator.findByAnd("Shipment", UtilMisc.toMap("primaryOrderId",orderId)));
        	if(shipment!=null){
        		shipmentStatue=shipment.get("statusId").toString();
        	}
        }catch (GenericEntityException e) {
            Debug.logError("获取发货状态出错" + e.getMessage(), module);
        }
        
        return shipmentStatue;
    }
    

    /**
     * 获取订单-货运状态明细
     * @param delegator
     * @param orderId
     * @return
     */
    public static List<GenericValue>  getOrderShipmentStateHistory(Delegator delegator,String orderId) {
    	List<GenericValue> shipmentStateHistory = FastList.newInstance();
        try {
        	
        	GenericValue shipment=EntityUtil.getFirst(delegator.findByAnd("Shipment", UtilMisc.toMap("primaryOrderId",orderId)));
        	if(shipment!=null){
        		
        		shipmentStateHistory=delegator.findByAnd("ShipmentStatus", UtilMisc.toMap("shipmentId",shipment.get("shipmentId")), UtilMisc.toList("-statusDate"));
        	}
        }catch (GenericEntityException e) {
            Debug.logError("获取发货状态出错" + e.getMessage(), module);
        }
        
        return shipmentStateHistory;
    }
    /**
     * 获取订单-会员信息
     * @param delegator
     * @param orderId
     * @return
     */
    public static String getOrderParty(Delegator delegator,String orderId,String roleTypeId) {
        String partyId = "";
        try {
        	
        	GenericValue orderRole=EntityUtil.getFirst(delegator.findByAnd("OrderRole", UtilMisc.toMap("orderId",orderId,"roleTypeId",roleTypeId)));
        	if(orderRole!=null){
        		partyId=orderRole.get("partyId").toString();
        	}
        }catch (GenericEntityException e) {
            Debug.logError("获取出错" + e.getMessage(), module);
        }
        
        return partyId;
    }
    /**
     * 获取订单-用户名信息
     * @param delegator
     * @param orderId
     * @return
     */
    public static String getOrderUserLoginIdFromParty(Delegator delegator,String orderId,String roleTypeId) {
    	String userLoginId = "";
    	try {
    		
    		GenericValue orderRole = EntityUtil.getFirst(delegator.findByAnd("OrderRole", UtilMisc.toMap("orderId",orderId,"roleTypeId",roleTypeId)));
    		if(orderRole!=null){
    			String partyId=orderRole.get("partyId").toString();
    			GenericValue userLogin = EntityUtil.getFirst(delegator.findByAnd("UserLogin", UtilMisc.toMap("partyId",partyId)));
    			if(userLogin!=null)
    				userLoginId = userLogin.getString("userLoginId");
    			else
    				userLoginId = partyId;
    		}
    	}catch (GenericEntityException e) {
    		Debug.logError("获取出错" + e.getMessage(), module);
    	}
    	
    	return userLoginId;
    }
    /**
     * 获取退货单ID
     * @param delegator
     * @param orderId
     * @return
     */
    public static String getReturnOrderByOrderId(Delegator delegator,String orderId) {
        String returnId = "";
        try {
        	
        	GenericValue returnItem=EntityUtil.getFirst(delegator.findByAnd("ReturnItem", UtilMisc.toMap("orderId",orderId)));
        	if(returnItem!=null){
        		returnId=returnItem.get("returnId").toString();
        	}
        }catch (GenericEntityException e) {
            Debug.logError("获取出错" + e.getMessage(), module);
        }
        
        return returnId;
    }
    /**
     * 获取退货单状态
     * @param delegator
     * @param orderId
     * @return
     */
    public static  List<GenericValue> getReturnStatus(Delegator delegator,String returnId) {
    	List<GenericValue> status = FastList.newInstance();
        try {
        	
        	 status=delegator.findByAnd("ReturnStatus", UtilMisc.toMap("returnId",returnId,"returnItemSeqId",null));
        	
        }catch (GenericEntityException e) {
            Debug.logError("获取出错" + e.getMessage(), module);
        }
        
        return status;
    }
    private static boolean hasPermission(String orderId, GenericValue userLogin, String action, Security security, Delegator delegator) {
        OrderReadHelper orh = new OrderReadHelper(delegator, orderId);
        String orderTypeId = orh.getOrderTypeId();
        String partyId = null;
        GenericValue orderParty = orh.getEndUserParty();
        if (UtilValidate.isEmpty(orderParty)) {
            orderParty = orh.getPlacingParty();
        }
        if (UtilValidate.isNotEmpty(orderParty)) {
            partyId = orderParty.getString("partyId");
        }
        boolean hasPermission = hasPermission(orderTypeId, partyId, userLogin, action, security);
        if (!hasPermission) {
            GenericValue placingCustomer = null;
            try {
                Map<String, Object> placingCustomerFields = UtilMisc.<String, Object>toMap("orderId", orderId, "partyId", userLogin.getString("partyId"), "roleTypeId", "PLACING_CUSTOMER");
                placingCustomer = delegator.findByPrimaryKey("OrderRole", placingCustomerFields);
            } catch (GenericEntityException e) {
                Debug.logError("Could not select OrderRoles for order " + orderId + " due to " + e.getMessage(), module);
            }
            hasPermission = (placingCustomer != null);
        }
        return hasPermission;
    }
    private static boolean hasPermission(String orderTypeId, String partyId, GenericValue userLogin, String action, Security security) {
        boolean hasPermission = security.hasEntityPermission("ORDERMGR", "_" + action, userLogin);
        if (!hasPermission) {
            if (orderTypeId.equals("SALES_ORDER")) {
                if (security.hasEntityPermission("ORDERMGR", "_SALES_" + action, userLogin)) {
                    hasPermission = true;
                } else {
                    // check sales agent/customer relationship
                    List<GenericValue> repsCustomers = new LinkedList<GenericValue>();
                    try {
                        repsCustomers = EntityUtil.filterByDate(userLogin.getRelatedOne("Party").getRelatedByAnd("FromPartyRelationship",
                                UtilMisc.toMap("roleTypeIdFrom", "AGENT", "roleTypeIdTo", "CUSTOMER", "partyIdTo", partyId)));
                    } catch (GenericEntityException ex) {
                        Debug.logError("Could not determine if " + partyId + " is a customer of user " + userLogin.getString("userLoginId") + " due to " + ex.getMessage(), module);
                    }
                    if ((repsCustomers != null) && (repsCustomers.size() > 0) && (security.hasEntityPermission("ORDERMGR", "_ROLE_" + action, userLogin))) {
                        hasPermission = true;
                    }
                    if (!hasPermission) {
                        // check sales sales rep/customer relationship
                        try {
                            repsCustomers = EntityUtil.filterByDate(userLogin.getRelatedOne("Party").getRelatedByAnd("FromPartyRelationship",
                                    UtilMisc.toMap("roleTypeIdFrom", "SALES_REP", "roleTypeIdTo", "CUSTOMER", "partyIdTo", partyId)));
                        } catch (GenericEntityException ex) {
                            Debug.logError("Could not determine if " + partyId + " is a customer of user " + userLogin.getString("userLoginId") + " due to " + ex.getMessage(), module);
                        }
                        if ((repsCustomers != null) && (repsCustomers.size() > 0) && (security.hasEntityPermission("ORDERMGR", "_ROLE_" + action, userLogin))) {
                            hasPermission = true;
                        }
                    }
                }
            } else if ((orderTypeId.equals("PURCHASE_ORDER") && (security.hasEntityPermission("ORDERMGR", "_PURCHASE_" + action, userLogin)))) {
                hasPermission = true;
            }
        }
        return hasPermission;
    }
}
