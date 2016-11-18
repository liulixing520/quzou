package org.ofbiz.thirdparty.zjpay.publicService;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceAuthException;
import org.ofbiz.service.ServiceValidationException;

import payment.api.notice.Notice1118Request;
import payment.api.notice.NoticeRequest;

public class ZjpayPublicReturnServices{

	public static final String module = ZjpayPublicReturnServices.class.getName();
	public static final String resource = "FilmOrderUiLabels";
	public static String message="";
	/**
	 * 同步返回数据
	 * @param dctx
	 * @param context
	 */
	@SuppressWarnings({ "unused"})
	public static Map<String,Object> zjpayReturn(HttpServletRequest request,HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		LocalDispatcher dispatcher =(LocalDispatcher) request.getAttribute("dispatcher");
		String returnIsInfo ="success";
		String externalId = "";
		Map<String,Object> map = FastMap.newInstance();
		try {
				
			 	Debug.log("---------- Begin [ReceiveNoticePage] process......");
			 	GenericValue userLogin =delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId","admin"),false);
	            // 获得参数message和signature
	            String message = request.getParameter("message");
	            String signature = request.getParameter("signature");
	            // 定义变量
	            String txName = "";
	            // 生成交易结果对象
	            NoticeRequest noticeRequest = new NoticeRequest(message, signature);
	            
	            if ("1118".equals(noticeRequest.getTxCode())) {
	                Notice1118Request nr = new Notice1118Request(noticeRequest.getDocument());
	                externalId = nr.getPaymentNo();
	                // ！！！ 在这里添加商户处理逻辑！！！
	                // 以下为演示代码
	                txName = "商户订单支付状态变更通知";
	                Debug.log("[TxCode]       = [1118]");
	                Debug.log("[TxName]       = [商户订单支付状态变更通知]");
	                Debug.log("[InstitutionID]= [" + nr.getInstitutionID() + "]");
	                Debug.log("[PaymentNo]    = [" + nr.getPaymentNo() + "]");
	                Debug.log("[Amount]       = [" + nr.getAmount() + "]");
	                Debug.log("[Status]       = [" + nr.getStatus() + "]");
	                Debug.log("[BankNotificationTime]       = [" + nr.getBankNotificationTime() + "]");
                    //支付成功，修改状态。
                    Debug.log("trade_status======================"+nr.getStatus());
                    
	                if (20 == nr.getStatus()) {
	                	Debug.log("receive 1118 notification success");
	                	
	                	returnIsInfo = "success";
	                }
	            }
	   
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
		} catch (Exception e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		}
		map.put("orderId", externalId);
		map.put("returnIsInfo", returnIsInfo);	
		return map;
	}
	
}
