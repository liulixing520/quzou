package com.alipay;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.LocalDispatcher;

import com.alipay.config.AlipayConfig;
import com.alipay.util.AlipaySubmit;

public class AlipaySendGoodsEvents
{

	public static String module = AlipaySendGoodsEvents.class.getName();
    /**
     * 确认发货接口接入
     */
    public static String alipaySendGoods(HttpServletRequest request, HttpServletResponse response)
    {
	System.out.println("============send_goods_confirm_by_platform to alipay");
	LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	GenericDelegator delegator = (GenericDelegator) request.getAttribute("delegator");
	Locale locale = UtilHttp.getLocale(request);

	//物流公司名称
	String logistics_name = request.getParameter("logistics_name");
	if(logistics_name==null||logistics_name==""){
		logistics_name=request.getParameter("shipmentMethod");
	}
	// 物流发货单号
	String invoice_no = request.getParameter("trackingNumber");
	// 物流运输类型-三个值可选：POST（平邮）、EXPRESS（快递）、EMS（EMS）
	String transport_type = request.getParameter("transport_type");
	
	// 把请求参数打包成数组
	Map<String, String> sParaTemp = new HashMap<String, String>();
	sParaTemp.put("service", "send_goods_confirm_by_platform");
	sParaTemp.put("partner", AlipayConfig.partner);
	sParaTemp.put("_input_charset", AlipayConfig.input_charset);
	sParaTemp.put("logistics_name", logistics_name);
	sParaTemp.put("invoice_no", invoice_no);
	sParaTemp.put("transport_type", transport_type);
	try{
	    GenericValue gv = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId", request.getParameter("orderId")), false);
	    sParaTemp.put("trade_no", gv.getString("tradeNo"));// 支付宝交易码
	    // 建立请求
	    Debug.logInfo(sParaTemp.toString(), module);
	    String sHtmlText = AlipaySubmit.buildRequest("", "", sParaTemp);
	    Debug.logInfo(sHtmlText, module);
	} catch (Exception e)
	{
		Debug.log("AlipayInfo verify Fail.");
	}
	return "success";
    }
}
