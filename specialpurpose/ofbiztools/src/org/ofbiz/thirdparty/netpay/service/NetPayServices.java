package org.ofbiz.thirdparty.netpay.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.thirdparty.netpay.config.NetPayConfig;

import chinapay.PrivateKey;
import chinapay.SecureLink;



public class NetPayServices {

	public static final String module = NetPayServices.class.getName();
	public static final String resource = "OfbizToolsUiLabels";
	
	@SuppressWarnings("deprecation")
	public static String NetPayApi(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		NetPayConfig netPayConfig = new NetPayConfig();
		String sHtmlText ="";
		try {
			System.out.println("===================begin======================");
			String orderId = (String) request.getAttribute("orderId");

			if (UtilValidate.isEmpty(orderId)) {
				orderId = request.getParameter("orderId");
			}
			GenericValue orderHeader = delegator.findByPrimaryKey("OrderHeader", UtilMisc.toMap("orderId", orderId));
			//加入16位数字 外部id
			String externalId = UtilDateTime.nowDateString("yyyyMMddhhmmss");
			long Temp; 
			Temp=Math.round(Math.random()*89+10);
			externalId = externalId+Temp;
			orderHeader.set("externalId",externalId);
			orderHeader.store();
			String totalFeeStr = orderHeader.getBigDecimal("grandTotal").toPlainString();
//			String orderName = orderHeader.getString("orderName");
			
			long longTotal = (long) (Double.valueOf(totalFeeStr)*100);
			long zLength = String.valueOf(longTotal).length();
			String totalFee = "";
			for(int i=0;i<12-zLength;i++){
				totalFee = totalFee+"0";
			}
			totalFee = totalFee+longTotal;
			
			String partner = netPayConfig.partner;	//商户号
			String return_url = netPayConfig.return_url;
			String notify_url = netPayConfig.notify_url;
			String currencyType = netPayConfig.currencyType;
			String gatewayType = netPayConfig.gatewayType;
			String description = netPayConfig.description;	//版本号
			String TransDate = UtilDateTime.nowDateString("yyyyMMdd");
			String priv1 = orderId;	//原路返回的信息
			String getId = "";	//网关
			PrivateKey key1=new PrivateKey();

			boolean flag;
			flag=key1.buildKey(partner,0,System.getProperty("ofbiz.home") +"/hot-deploy/ofbiztools/config/netPay/MerPrk1.key"); //注意要用哪一个商户号签名就要用对应的key文件。
			if (flag==false){
			    System.out.println("build key error!");
			    return "error";
			}
			
			SecureLink s1=new SecureLink(key1);
			//测试.目前金额固定为0.01
			totalFee = "000000000001";
			String CheckValue = s1.Sign(partner + externalId + totalFee + currencyType
					+ TransDate + gatewayType + priv1);
			Map<String,Object> map = FastMap.newInstance();
			map.put("MerId", partner);
			map.put("OrdId", externalId);
			map.put("TransAmt", totalFee);
			map.put("CuryId", currencyType);
			map.put("TransDate", TransDate);
			map.put("TransType", gatewayType);
			map.put("Version", description);
			map.put("BgRetUrl", notify_url);
			map.put("PageRetUrl", return_url);
			map.put("GetId", getId);
			map.put("Priv1", priv1);
			map.put("ChkValue", CheckValue);
			
			
			sHtmlText=buildRequest(map,"post");
			String redirectString = buildRequestParaUrl(netPayConfig.paymentUrl, map);
//			Debug.log("sHtmlText================="+sHtmlText);
			Debug.log("redirectString================="+redirectString);
			response.sendRedirect(redirectString);
			
			} catch (Exception e) {
				Debug.logError("跳转出错!",module);
				e.printStackTrace();
			}
	request.setAttribute("sHtmlText", sHtmlText);	
	return "success";
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
	public static String buildRequest(Map<String, Object> sParaTemp,
			String strMethod) {
		NetPayConfig netPayConfig = new NetPayConfig();
		// 待请求参数数组
		Map<String, Object> sPara = sParaTemp;
		List<String> keys = new ArrayList<String>(sPara.keySet());

		StringBuffer sbHtml = new StringBuffer();

		sbHtml.append("<form id=\"netPay\" name=\"netPay\" action=\""
				+ netPayConfig.paymentUrl + "\" method=\"" + strMethod
				+ "\">");
		for (int i = 0; i < keys.size(); i++) {
			String name = (String) keys.get(i);
			String value = (String) sPara.get(name);
			sbHtml.append("<input type=\"hidden\" name=\"" + name
					+ "\" value=\"" + value + "\"/>");
		}

		// submit按钮控件请不要含有name属性
		sbHtml.append("<input type=\"submit\" value=\"" + "确认"
				+ "\" style=\"display:none;\"></form>");
		sbHtml.append("<script>document.forms['netPay'].submit();</script>");

		return sbHtml.toString();
	}
	
	/**
	 * 建立请求String
	 * 
	 * @param gateWay
	 * @param parameters
	 * @return
	 */
	public static String buildRequestParaUrl(String gateWay, Map<String, Object> parameters) {
		StringBuffer buildUrl = new StringBuffer();
		buildUrl.append(gateWay + "?");
		for (Map.Entry<String, Object> entry : parameters.entrySet()) {
			buildUrl.append(entry.getKey());
			buildUrl.append("=");
			buildUrl.append(entry.getValue());
			buildUrl.append("&");
		}
		return buildUrl.toString().substring(0, buildUrl.length() - 1);
	}
	
	public static void main(String[] args){
		String externalId = UtilDateTime.nowDateString("yyyyMMddhhmmss");
		long Temp; 
		Temp=Math.round(Math.random()*8999+1000);
		System.out.println(externalId+Temp);
	}
}
