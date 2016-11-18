package com.alipay.services;

import java.util.Map;

import com.alipay.config.AlipayConfig;
import com.alipay.util.AlipaySubmit;

/* *
 *类名：AlipayService
 *功能：支付宝各接口构造类
 *详细：构造支付宝各接口请求参数
 *版本：3.2
 *修改日期：2011-03-17
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayService {

	/**
	 * 支付宝提供给商户的服务接入网关URL(新)
	 */
	private static final String ALIPAY_GATEWAY_NEW = "https://mapi.alipay.com/gateway.do?";

	/**
	 * 构造即时到帐接口
	 * 
	 * @param sParaTemp
	 *            请求参数集合
	 * @return 表单提交HTML信息
	 */
	public static String create_direct_pay_by_user(Map<String, String> sParaTemp) {
		// 增加基本配置
		if (!sParaTemp.containsKey("service")) {
			sParaTemp.put("service", "create_direct_pay_by_user");
		}
		if (!sParaTemp.containsKey("partner")) {
			sParaTemp.put("partner", AlipayConfig.partner);
		}
		if (!sParaTemp.containsKey("return_url")) {
			// sParaTemp.put("return_url", AlipayConfig.return_url);
		}
		if (!sParaTemp.containsKey("notify_url")) {
			// sParaTemp.put("notify_url", AlipayConfig.notify_url);
		}
		if (!sParaTemp.containsKey("seller_email")) {
			sParaTemp.put("seller_email", AlipayConfig.key);
		}
		if (!sParaTemp.containsKey("_input_charset")) {
			sParaTemp.put("_input_charset", AlipayConfig.input_charset);
		}

		String strButtonName = "确认";
		return AlipaySubmit.buildRequest(sParaTemp, "get", strButtonName);
	}

	/**
	 * 构造担保交易接口
	 * 
	 * @param sParaTemp
	 *            请求参数集合
	 * @return 表单提交HTML信息
	 */
	public static String create_partner_trade_by_buyer(Map<String, String> sParaTemp) {
		// 增加基本配置
		if (!sParaTemp.containsKey("service")) {
			sParaTemp.put("service", "create_partner_trade_by_buyer");
		}
		if (!sParaTemp.containsKey("partner")) {
			sParaTemp.put("partner", AlipayConfig.partner);
		}
		if (!sParaTemp.containsKey("return_url")) {
			// sParaTemp.put("return_url", AlipayConfig.return_url);
		}
		if (!sParaTemp.containsKey("notify_url")) {
			// sParaTemp.put("notify_url", AlipayConfig.notify_url);
		}
		if (!sParaTemp.containsKey("seller_email")) {
			sParaTemp.put("seller_email", AlipayConfig.key);
		}
		if (!sParaTemp.containsKey("_input_charset")) {
			sParaTemp.put("_input_charset", AlipayConfig.input_charset);
		}

		String strButtonName = "确认";
		return AlipaySubmit.buildRequest(sParaTemp, "get", strButtonName);
	}
}
