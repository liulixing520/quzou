package org.ofbiz.thirdparty.zjpay.publicService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.DelegatorFactory;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.thirdparty.zjpay.config.ZjpayConfig;

import payment.api.system.PaymentEnvironment;
import payment.api.tx.marketorder.Tx1311Request;
import payment.tools.util.XmlUtil;

public class ZjpayPublicServices {

	public static final String module = ZjpayPublicServices.class.getName();
	public static final String resource = "FilmOrderUiLabels";
	
	
	/**
	 * 返回form对象
	 * @param request
	 * @param orderId
	 * @param bankId
	 * @param total_fee
	 * @return
	 */
	public static String zjpayApi(String orderId,String bankId,String total_fee,String returnUrl) {
		Delegator delegator = DelegatorFactory.getDelegator("default");
		ZjpayConfig zjpayConfig = new ZjpayConfig();
		String sHtmlText ="";
		try {
			GenericValue config = zjpayConfig.config;
			//服务器异步通知页面路径
			String notify_url = config.getString(returnUrl);
			Debug.log("notify_url================"+notify_url);
			//商户订单号
			String out_trade_no = new String(orderId);
			total_fee = String.valueOf(Double.valueOf(total_fee)*100);
			//付款金额
			long amount = Long.valueOf(total_fee.substring(0, total_fee.indexOf(".")));
			// 2.创建交易请求对象
			Tx1311Request tx1311Request = new Tx1311Request();
            tx1311Request.setInstitutionID(zjpayConfig.partner);
            tx1311Request.setOrderNo(orderId);
            tx1311Request.setPaymentNo(orderId);
            tx1311Request.setAmount(amount);
            tx1311Request.setFee(0);
            tx1311Request.setPayerID("");
            tx1311Request.setPayerName("");
            tx1311Request.setUsage(out_trade_no);
            tx1311Request.setRemark(out_trade_no);
            tx1311Request.setNotificationURL(notify_url);
            tx1311Request.setBankID(bankId);
            
            GenericValue orderRole = EntityUtil.getFirst(delegator.findByAnd("OrderRole", UtilMisc.toMap("orderId", orderId,"roleTypeId","BILL_TO_CUSTOMER")));
            String partyId = orderRole.getString("partyId");
            GenericValue person = delegator.findOne("Person", UtilMisc.toMap("partyId", partyId), false);
            String customerType = person.getString("customerType");
            if(customerType.equals("PERSONAL_BUYER")){
            	tx1311Request.setAccountType(11);
            }else if(customerType.equals("ENTERPRISE_BUYER")){
            	tx1311Request.setAccountType(12);
            }
            tx1311Request.setRemark("houtai");
            // 3.执行报文处理
            tx1311Request.process();
			//把请求参数打包成数组
			Map<String, Object> sParaTemp = new HashMap<String, Object>();
			String prettyPlainText = XmlUtil.createPrettyFormat(XmlUtil.createDocument(tx1311Request.getRequestPlainText()));
			sParaTemp.put("RequestPlainText", prettyPlainText);
	        sParaTemp.put("message", tx1311Request.getRequestMessage());
			sParaTemp.put("signature", tx1311Request.getRequestSignature());
			sParaTemp.put("txCode", "1311");
			sParaTemp.put("txName", "市场订单支付（直通车）");
			sParaTemp.put("Flag", "");
			Debug.log("========end========="+PaymentEnvironment.paymentURL);
			sHtmlText = buildRequest(PaymentEnvironment.paymentURL,sParaTemp,"post");
			} catch (Exception e) {
				Debug.log("跳转出错!");
				e.printStackTrace();
			}
		return sHtmlText;
	}
	
	
	/**
	 * 建立请求，以表单HTML形式构造（默认）
	 * 
	 * @param sParaTemp
	 *            请求参数数组
	 * @param strMethod
	 *            提交方式。两个值可选：post、get
	 * @param strButtonName
	 *            确认按钮显示文字
	 * @return 提交表单HTML文本
	 */
	public static String buildRequest(String action,Map<String, Object> sParaTemp,
			String strMethod) {
		// 待请求参数数组
		Map<String, Object> sPara = sParaTemp;
		List<String> keys = new ArrayList<String>(sPara.keySet());

		StringBuffer sbHtml = new StringBuffer();

		sbHtml.append("<form id=\"zjPay\" name=\"zjPay\" action=\""
				+ action + "\" method=\"" + strMethod
				+ "\">");
		for (int i = 0; i < keys.size(); i++) {
			String name = (String) keys.get(i);
			String value = (String) sPara.get(name);
			if(name.equals("RequestPlainText")){
				sbHtml.append("<textarea name=\""+name+"\" style='display:none;'>"+value+"</textarea>");
			}else{
				sbHtml.append("<input type=\"hidden\" name=\"" + name
						+ "\" value=\"" + value + "\"/>");
			}
			
		}

		// submit按钮控件请不要含有name属性
		sbHtml.append("<input type=\"submit\" value=\"" + "确认"
				+ "\" style=\"display:none;\"></form>");
		sbHtml.append("<script>document.forms['zjPay'].submit();</script>");

		return sbHtml.toString();
	}
	
	public static void main(String[] args){
		 String ss = String.valueOf(0.03*100);
		 long s = Long.valueOf(ss.substring(0, ss.indexOf(".")));
		 System.out.println(s);
	}
}
