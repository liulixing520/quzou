package org.ofbiz.thirdparty.alipay.service;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastMap;

import org.ofbiz.thirdparty.alipay.util.AlipayNotify;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceAuthException;
import org.ofbiz.service.ServiceUtil;
import org.ofbiz.service.ServiceValidationException;

public class AlipayReturnServices{

	public static final String module = AlipayReturnServices.class.getName();
	public static final String resource = "FilmOrderUiLabels";
	public static String message="";
	/**
	 * 同步返回数据
	 * @param dctx
	 * @param context
	 */
	@SuppressWarnings({ "rawtypes", "unused", "deprecation" })
	public static String alipayReturn(HttpServletRequest request,HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		LocalDispatcher dispatcher =(LocalDispatcher) request.getAttribute("dispatcher");
		String returnIsInfo ="";
		//交易状态
		String trade_status;
		//计算得出通知验证结果
		boolean verify_result;
		try {
			GenericValue userLogin =delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId","admin"),false);
			Map<String,String> params = new HashMap<String,String>();
			Map requestParams = request.getParameterMap();
			for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
				String name = (String) iter.next();
				String[] values = (String[]) requestParams.get(name);
				String valueStr = "";
				for (int i = 0; i < values.length; i++) {
					valueStr = (i == values.length - 1) ? valueStr + values[i]
							: valueStr + values[i] + ",";
				}
				//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
//				valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
				params.put(name, valueStr);
			}
			Debug.log("request.getParameterMap()=========="+request.getParameterMap());
			//订单号
			String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
			//支付宝订单号
			String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
			//支付宝的支付状态
			trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");
			//付款方帐号
			String buyer_email = new String(request.getParameter("buyer_email").getBytes("ISO-8859-1"),"UTF-8");
			verify_result = AlipayNotify.verify(params);
			Debug.log("verify_result==================="+verify_result);
			GenericValue orderHeader = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId",out_trade_no),false);
			if(verify_result && (trade_status.equals("TRADE_FINISHED") || trade_status.equals("TRADE_SUCCESS"))){//验证成功
			    if(UtilValidate.isNotEmpty(orderHeader) && "ORDER_CREATED".equals(orderHeader.get("statusId"))){
                   
                    returnIsInfo="success";
                    //支付成功，修改状态。
                    Debug.log("trade_status======================"+trade_status);
                   
                    Map<String,Object> map = FastMap.newInstance();
                    map.put("setItemStatus", "Y");
                    map.put("statusId", "ORDER_APPROVED");
                    map.put("orderId", out_trade_no);
                    map.put("userLogin", userLogin);
                    Map<String,Object> result = dispatcher.runSync("changeOrderStatus", map);
                    Debug.log("message====="+result);
                    
                    //处理支付状态
                    //查询当前流水ID 
                    GenericValue orderPayment = EntityUtil.getFirst(delegator.findByAnd("OrderPaymentPreference",
                    		UtilMisc.toMap("orderId", out_trade_no,"paymentMethodTypeId","EXT_ALIPAY","statusId","PAYMENT_NOT_RECEIVED")));
                    Map<String,Object> mapPayment = FastMap.newInstance();
                    mapPayment.put("orderPaymentPreferenceId", orderPayment.getString("orderPaymentPreferenceId"));
                    mapPayment.put("orderId", out_trade_no);
                    mapPayment.put("paymentMethodTypeId", "EXT_ALIPAY");
                    mapPayment.put("presentFlag", "N");
                    mapPayment.put("swipedFlag", "N");
                    mapPayment.put("overflowFlag", "N");
                    mapPayment.put("createdDate", UtilDateTime.nowTimestamp());
                    mapPayment.put("statusId", "PAYMENT_RECEIVED");
                    mapPayment.put("maxAmount", orderHeader.getBigDecimal("grandTotal"));
                    mapPayment.put("createdByUserLogin", orderHeader.getString("createdBy"));
                    
                    mapPayment.put("userLogin", userLogin);
                    dispatcher.runSync("updateOrderPaymentPreference", mapPayment);
                    
                    if(!ServiceUtil.isSuccess(result)){
                    	//错误处理
                    	//金额退还到买家账户中.
                    }

                    GenericValue newOrder = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId",out_trade_no),false);
                    newOrder.set("externalId", trade_no);
                    newOrder.store();
                }
               
			}else{
				returnIsInfo = "error";
			}
			request.setAttribute("orderId", out_trade_no);
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (UnsupportedEncodingException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (ServiceAuthException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (ServiceValidationException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (GenericServiceException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		}
		return returnIsInfo;
	}
	
}
