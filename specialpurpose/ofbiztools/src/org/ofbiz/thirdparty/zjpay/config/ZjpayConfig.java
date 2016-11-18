package org.ofbiz.thirdparty.zjpay.config;

import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.DelegatorFactory;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;


public class ZjpayConfig {
	//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	// 合作身份者ID，以2088开头由16位纯数字组成的字符串
	public String partner = "";
	// 商户的私钥
	public String key = "";

	//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

	// 调试用，创建TXT日志文件夹路径
	public String log_path = "D:\\alipayLog";

	// 字符编码格式 目前支持 gbk 或 utf-8
	public String input_charset = "";
	
	// 签名方式 不需修改
	public String settlement_Flag = "";
	
	//服务器异步通知路径
	public String notify_url = "";
	
	//服务同步通知路径
	public String return_url="";
	
	//卖家帐号
	public String seller_email="";
	
	//提交地址
	public String paymentUrl = "";
	
	public String tx_code = "";
	
	public GenericValue config = null;
	public ZjpayConfig(){
		Delegator delegator = DelegatorFactory.getDelegator("default");
		try {
			GenericValue payment =delegator.findOne("PaymentGateway", UtilMisc.toMap("baseId","ZJpay"),false);
			this.paymentUrl=payment.getString("paymentUrl");
			this.partner=payment.getString("partnerId");
			this.key=payment.getString("paymentMerKey");
			this.input_charset=payment.getString("paymentLang");
			this.settlement_Flag=payment.getString("paymentEncodeType");
			this.notify_url=payment.getString("paymentNotifyUrl");
			this.return_url=payment.getString("paymentReturnUrl");
			this.seller_email=payment.getString("sellerUserLoginId");
			this.tx_code=payment.getString("paymentRetEncodeType");
			this.config = payment;
		} catch (GenericEntityException e) {
			e.printStackTrace();
		}
	}
}
