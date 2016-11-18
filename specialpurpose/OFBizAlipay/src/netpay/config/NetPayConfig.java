package netpay.config;

import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.DelegatorFactory;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *版本：3.3
 *日期：2012-08-10
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。

 *提示：如何获取安全校验码和合作身份者ID
 *1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
 *2.点击“商家服务”(https://b.alipay.com/order/myOrder.htm)
 *3.点击“查询合作者身份(PID)”、“查询安全校验码(Key)”

 *安全校验码查看时，输入支付密码后，页面呈灰色的现象，怎么办？
 *解决方法：
 *1、检查浏览器配置，不让浏览器做弹框屏蔽设置
 *2、更换浏览器或电脑，重新登录查询。
 */

public class NetPayConfig {
	// ↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	public String partner = "";

	// ↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

	// 服务器异步通知路径
	public String notify_url = "";

	// 服务同步通知路径
	public String return_url = "";

	// 提交地址
	public String paymentUrl = "";

	// 货币类型
	public String currencyType = "";
	// 支付方式
	public String gatewayType = "";

	public String description = "";

	@SuppressWarnings("deprecation")
	public NetPayConfig() {
		Delegator delegator = DelegatorFactory.getDelegator("default");
		try {
			GenericValue payment = delegator.findByPrimaryKeyCache("PaymentGateway", UtilMisc.toMap("baseId", "NT"));
			this.paymentUrl = payment.getString("paymentUrl");
			this.partner = payment.getString("partnerId");
			this.notify_url = payment.getString("paymentNotifyUrl");
			this.return_url = payment.getString("paymentReturnUrl");
			this.currencyType = payment.getString("currencyType");
			this.gatewayType = payment.getString("gatewayType");
			this.description = payment.getString("description");
		} catch (GenericEntityException e) {
			e.printStackTrace();
		}
	}
}
