package org.ofbiz.thirdparty.alipay.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.ofbiz.thirdparty.alipay.config.AlipayConfig;
import org.ofbiz.thirdparty.alipay.util.AlipaySubmit;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericValue;

public class AlipayServices {

	public static final String module = AlipayServices.class.getName();
	public static final String resource = "FilmOrderUiLabels";
	
	public static String alipayApi(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		//String orderId,String orderName,String totalFee,String orderDesc,String orderIrl
		AlipayConfig alipayConfig = new AlipayConfig();
		String sHtmlText ="";
		try {
			
			System.out.println("===================begin======================");
			String orderId = (String) request.getAttribute("orderId");

			if (UtilValidate.isEmpty(orderId)) {
				orderId = request.getParameter("orderId");
			}
			GenericValue orderHeader = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId", orderId),false);
			String totalFee = orderHeader.getBigDecimal("grandTotal").toPlainString();
//			String orderName = orderHeader.getString("orderName");
			//支付类型
			String payment_type = "1";
			//服务器异步通知页面路径
			String notify_url = alipayConfig.notify_url;
			//需http://格式的完整路径，不能加?id=123这类自定义参数
			//页面跳转同步通知页面路径
			String return_url = alipayConfig.return_url;
			//需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/
			//卖家支付宝帐户
			String seller_email = new String(alipayConfig.seller_email);
			//商户订单号
			String out_trade_no = new String(orderId);
			//订单名称
			String subject = new String(orderId);
			//付款金额
			String total_fee = new String(totalFee);
			//订单描述
			String body = new String(orderId);//.getBytes("ISO-8859-1"),"UTF-8"
			//默认支付方式
			String paymethod = "bankPay";
			//必填
			//默认网银
			String defaultbank="";
//			String defaultbank = new String(String.valueOf(context.get("WIDdefaultbank")).getBytes("ISO-8859-1"),"UTF-8");
			//商品展示地址
			String show_url = new String("");
			//需以http://开头的完整路径，例如：http://www.xxx.com/myorder.html
			//防钓鱼时间戳
			String anti_phishing_key = "";
			//客户端的IP地址
			String exter_invoke_ip = "";
			//把请求参数打包成数组
			Map<String, String> sParaTemp = new HashMap<String, String>();
			sParaTemp.put("service", "create_direct_pay_by_user");
	        sParaTemp.put("partner", alipayConfig.partner);
	        sParaTemp.put("_input_charset", alipayConfig.input_charset);
			sParaTemp.put("payment_type", payment_type);
			sParaTemp.put("notify_url", notify_url);
			sParaTemp.put("return_url", return_url);
			sParaTemp.put("seller_email", seller_email);
			sParaTemp.put("out_trade_no", out_trade_no);
			sParaTemp.put("subject", subject);
			sParaTemp.put("total_fee", total_fee);
			sParaTemp.put("body", body);
			sParaTemp.put("paymethod", paymethod);
			sParaTemp.put("defaultbank", defaultbank);
			sParaTemp.put("show_url", show_url);
			sParaTemp.put("anti_phishing_key", anti_phishing_key);
			sParaTemp.put("exter_invoke_ip", exter_invoke_ip);
			sHtmlText = AlipaySubmit.buildRequest(sParaTemp,"get","确认");
			} catch (Exception e) {
				Debug.log("跳转出错!");
				e.printStackTrace();
			}
		request.setAttribute("sHtmlText", sHtmlText);	
		return "success";
	}
}
