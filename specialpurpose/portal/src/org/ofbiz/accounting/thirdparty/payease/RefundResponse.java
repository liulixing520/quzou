package org.ofbiz.accounting.thirdparty.payease;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.ofbiz.base.util.FileUtil;

import com.capinfo.crypt.*;

public class RefundResponse implements java.io.Serializable {
	
	private static final String Public1024keyPath="component://portal/script/org/ofbiz/accounting/payment/Public1024.key";
	private static String fullFilePath=null;
	static{
		File keyFile = FileUtil.getFile(Public1024keyPath);
		fullFilePath = keyFile.getAbsolutePath();
	}
	
	private String orderPaymentGroupId;
	private String v_mid;
	private String v_oid;
	private String v_refamount;   //总金额
	private String v_refreason;
	private String v_refoprt;
	private String v_mac;
	
	private String v_status;
	private String v_desc;
	private String v_refid;
	private String v_sign;
	
	public String getV_mid() {
		return v_mid;
	}

	public void setV_mid(String v_mid) {
		this.v_mid = v_mid;
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

	public String getV_status() {
		return v_status;
	}

	public void setV_status(String v_status) {
		this.v_status = v_status;
	}

	public String getV_desc() {
		return v_desc;
	}

	public void setV_desc(String v_desc) {
		this.v_desc = v_desc;
	}

	public String getV_refid() {
		return v_refid;
	}

	public void setV_refid(String v_refid) {
		this.v_refid = v_refid;
	}

	public String getOrderPaymentGroupId() {
		return orderPaymentGroupId;
	}

	public void setOrderPaymentGroupId(String orderPaymentGroupId) {
		this.orderPaymentGroupId = orderPaymentGroupId;
	}


	public String getV_oid() {
		return v_oid;
	}

	public void setV_oid(String v_oid) {
		this.v_oid = v_oid;
		if(v_oid.lastIndexOf("-")>0){
			this.orderPaymentGroupId = v_oid.substring(v_oid.lastIndexOf("-")+1);
		}
	}



	public String getV_sign() {
		return v_sign;
	}

	public void setV_sign(String v_sign) {
		this.v_sign = v_sign;
	}

	public void parseRequest(HttpServletRequest request){
		
		
		this.v_status = request.getParameter("v_status");
		this.v_desc = request.getParameter("v_desc");
		try{
			this.v_desc = java.net.URLDecoder.decode(this.v_desc, "GB2312");
		}catch(Exception ex){
			ex.printStackTrace();
		}
		this.v_mid = request.getParameter("v_mid");
		this.setV_oid(request.getParameter("v_oid"));
		this.v_refamount = request.getParameter("v_refamount");

		this.v_refoprt = request.getParameter("v_refoprt");
		this.v_refid = request.getParameter("v_refid");
		this.v_sign = request.getParameter("v_sign");
	}
	
	public void parseParametersMap(Map <String, Object> parametersMap){
		this.v_status = (String)parametersMap.get("v_status");
		this.v_desc = (String)parametersMap.get("v_desc");
		this.v_mid = (String)parametersMap.get("v_mid");
		this.setV_oid((String)parametersMap.get("v_oid"));
		this.v_refamount = (String)parametersMap.get("v_refamount");
		this.v_refoprt = (String)parametersMap.get("v_refoprt");
		this.v_refid = (String)parametersMap.get("v_refid");
		this.v_sign = (String)parametersMap.get("v_sign");
	}
	
	
	public boolean verifyResp(){
		RSA_MD5 rsaMD5 = new RSA_MD5();
		String source= v_status+v_mid+v_oid+v_refamount+v_refoprt+v_refid;
		int verifyStatus= rsaMD5.PublicVerifyMD5(fullFilePath,v_sign,source);
		if(verifyStatus ==0){
			return true;
		}else{
			return false;
		}
	}
	
	public boolean paySuccess(){
		if("0".equals(this.getV_status())){
			return true;
		}else{
			return false;
		}
		
	}
}
