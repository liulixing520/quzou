package org.ofbiz.accounting.thirdparty.payease;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

public class PayeaseRequest implements java.io.Serializable {
	
	private String orderPaymentGroupId;
	private String redirectUrl;
	private String redirectBankUrl;
	private String v_mid;
	private String v_oid;
	private String v_rcvname;
	private String v_rcvaddr;
	private String v_rcvtel;
	private String v_rcvpost;  //收货人邮政编码
	private String v_amount;   //订单总金额
	private String v_ymd;      //
	private String v_orderstatus;  //
	private String v_ordername;
	private String v_moneytype;
	
	public String getOrderPaymentGroupId() {
		return orderPaymentGroupId;
	}
	public void setOrderPaymentGroupId(String orderPaymentGroupId) {
		this.orderPaymentGroupId = orderPaymentGroupId;
	}

	private String v_url;
	private String v_md5info;
	
	
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
		if(v_oid==null){
			this.v_oid = UtilPayease.getOid(v_ymd, v_mid, orderPaymentGroupId);
		}else{
			this.v_oid = v_oid;
		}
	}
	public String getV_rcvname() {
		return v_rcvname;
	}
	public void setV_rcvname(String v_rcvname) {
		this.v_rcvname = v_rcvname;
	}
	public String getV_rcvaddr() {
		return v_rcvaddr;
	}
	public void setV_rcvaddr(String v_rcvaddr) {
		this.v_rcvaddr = v_rcvaddr;
	}
	public String getV_rcvtel() {
		return v_rcvtel;
	}
	public void setV_rcvtel(String v_rcvtel) {
		this.v_rcvtel = v_rcvtel;
	}
	public String getV_rcvpost() {
		return v_rcvpost;
	}
	public void setV_rcvpost(String v_rcvpost) {
		this.v_rcvpost = v_rcvpost;
	}
	public String getV_amount() {
		return v_amount;
	}
	public void setV_amount(String v_amount) {
		this.v_amount = v_amount;
	}
	public String getV_ymd() {
		return v_ymd;
	}
	public void setV_ymd(String v_ymd) {
		this.v_ymd = v_ymd;
	}
	public String getV_orderstatus() {
		return v_orderstatus;
	}
	public void setV_orderstatus(String v_orderstatus) {
		this.v_orderstatus = v_orderstatus;
	}
	public String getV_ordername() {
		return v_ordername;
	}
	public void setV_ordername(String v_ordername) {
		this.v_ordername = v_ordername;
	}
	public String getV_moneytype() {
		return v_moneytype;
	}
	public void setV_moneytype(String v_moneytype) {
		this.v_moneytype = v_moneytype;
	}
	public String getV_url() {
		return v_url;
	}
	public void setV_url(String v_url) {
		this.v_url = v_url;
	}
	public String getV_md5info() {
		return v_md5info;
	}
	public void setV_md5info(String v_md5info) {
		this.v_md5info = v_md5info;
	}
	
	public void md5(String strKey){
		String md5Source = v_moneytype+v_ymd+v_amount+v_rcvname+this.getV_oid()+v_mid+v_url;
		Md5 md5 = new Md5("") ;
		try {
			md5.hmac_Md5(md5Source,strKey) ;
			byte b[]= md5.getDigest();
			String digestString = md5.stringify(b) ;
			this.setV_md5info(digestString);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public Map getMaps(){
		Map <String, Object> parameters = new LinkedHashMap <String, Object>();
		parameters.put("v_amount", this.getV_amount());
		parameters.put("v_md5info", this.getV_md5info());
		parameters.put("v_mid", this.getV_mid());
		parameters.put("v_oid", this.getV_oid());
		parameters.put("v_ordername", this.getV_ordername());
		parameters.put("v_orderstatus", this.getV_orderstatus());
		parameters.put("v_rcvaddr", this.getV_rcvaddr());
		parameters.put("v_rcvname", this.getV_rcvname());
		parameters.put("v_rcvtel", this.getV_rcvpost());
		parameters.put("v_rcvtel", this.getV_rcvtel());
		parameters.put("v_url", this.getV_url());
		parameters.put("v_ymd", this.getV_ymd());
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
}
