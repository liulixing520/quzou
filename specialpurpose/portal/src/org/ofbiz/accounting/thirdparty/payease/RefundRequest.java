package org.ofbiz.accounting.thirdparty.payease;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import org.ofbiz.base.util.Debug;

public class RefundRequest implements java.io.Serializable {
	
	private static final String module = RefundRequest.class.getName();
	
	private String refundUrl ="https://api.yizhifubj.com/merchant/refund/ref_ack_submit.jsp";
	
	private String orderPaymentGroupId;
	private String redirectUrl;
	private String redirectBankUrl;
	private String v_mid;
	private String v_oid;
	private String v_refamount;   //总金额
	private String v_refreason;
	private String v_refoprt;
	private String v_mac;
	

	
	public String getOrderPaymentGroupId() {
		return orderPaymentGroupId;
	}
	public void setOrderPaymentGroupId(String orderPaymentGroupId) {
		this.orderPaymentGroupId = orderPaymentGroupId;
	}
	
	public String getV_mid() {
		return v_mid;
	}
	public void setV_mid(String v_mid) {
		this.v_mid = v_mid;
	}
	
	public String getV_oid() {
		return this.v_oid;
	}
	public void setV_oid(String v_oid) {

		this.v_oid = v_oid;
	}

	public String getV_refamount() {
		return v_refamount;
	}
	public void setV_refamount(String v_refamount) {
		this.v_refamount = v_refamount;
	}
	
	public String getV_refreason() {
		return v_refreason;
	}
	public void setV_refreason(String v_refreason) {
		this.v_refreason = v_refreason;
	}
	
	public String getV_refoprt() {
		return v_refoprt;
	}
	public void setV_refoprt(String v_refoprt) {
		this.v_refoprt = v_refoprt;
	}
	
	public String getV_mac() {
		return v_mac;
	}
	public void setV_mac(String v_mac) {
		this.v_mac = v_mac;
	}
	
	public void md5(String strKey){
		String md5Source = v_mid+this.getV_oid()+v_refamount+v_refoprt;
		Md5 md5 = new Md5("") ;
		try {
			md5.hmac_Md5(md5Source,strKey) ;
			byte b[]= md5.getDigest();
			String digestString = md5.stringify(b) ;
			this.setV_mac(digestString);
		} catch (IOException e) {
			Debug.logError(e, module);
		}
	}
	
	public Map getMaps(){
		Map <String, Object> parameters = new LinkedHashMap <String, Object>();
		parameters.put("v_refamount", this.getV_refamount());
		parameters.put("v_mac", this.getV_mac());
		parameters.put("v_mid", this.getV_mid());
		parameters.put("v_oid", this.getV_oid());
		parameters.put("v_refreason", this.getV_refreason());
		parameters.put("v_refoprt", this.getV_refoprt());
		return parameters;
	}
	public String getRedirectUrl() {
		return redirectUrl;
	}
	public void setRedirectUrl(String redirectUrl) {
		this.redirectUrl = redirectUrl;
	}
	public String getRedirectBankUrl() {
		return redirectBankUrl;
	}
	public void setRedirectBankUrl(String redirectBankUrl) {
		this.redirectBankUrl = redirectBankUrl;
	}
	public String getRefundUrl() {
		return refundUrl;
	}
	public void setRefundUrl(String refundUrl) {
		this.refundUrl = refundUrl;
	}
}
