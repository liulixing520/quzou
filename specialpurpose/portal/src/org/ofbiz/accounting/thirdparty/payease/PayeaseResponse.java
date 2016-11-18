package org.ofbiz.accounting.thirdparty.payease;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.FileUtil;

import com.capinfo.crypt.*;

public class PayeaseResponse implements java.io.Serializable {
	private static final String module = PayeaseResponse.class.getName();
	
	private static final String Public1024keyPath="component://portal/script/org/ofbiz/accounting/payment/Public1024.key";
	private static String fullFilePath=null;
	static{
		File keyFile = FileUtil.getFile(Public1024keyPath);
		fullFilePath = keyFile.getAbsolutePath();
	}
	
	private String orderPaymentGroupId;
	private String v_url;
	private String v_oid;
	private String v_pmode;
	private String v_pstatus;
	private String v_pstring;
	private String v_md5info;
	private String v_amount;
	private String v_moneytype;
	private String v_md5money;
	private String v_sign;
	
	public String getOrderPaymentGroupId() {
		return orderPaymentGroupId;
	}

	public void setOrderPaymentGroupId(String orderPaymentGroupId) {
		this.orderPaymentGroupId = orderPaymentGroupId;
	}
	public String getV_url() {
		return v_url;
	}

	public void setV_url(String v_url) {
		this.v_url = v_url;
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

	public String getV_pmode() {
		return v_pmode;
	}

	public void setV_pmode(String v_pmode) {
		this.v_pmode = v_pmode;
	}

	public String getV_pstatus() {
		return v_pstatus;
	}

	public void setV_pstatus(String v_pstatus) {
		this.v_pstatus = v_pstatus;
	}

	public String getV_pstring() {
		return v_pstring;
	}

	public void setV_pstring(String v_pstring) {
		this.v_pstring = v_pstring;
	}

	public String getV_md5info() {
		return v_md5info;
	}

	public void setV_md5info(String v_md5info) {
		this.v_md5info = v_md5info;
	}

	public String getV_amount() {
		return v_amount;
	}

	public void setV_amount(String v_amount) {
		this.v_amount = v_amount;
	}

	public String getV_moneytype() {
		return v_moneytype;
	}

	public void setV_moneytype(String v_moneytype) {
		this.v_moneytype = v_moneytype;
	}

	public String getV_md5money() {
		return v_md5money;
	}

	public void setV_md5money(String v_md5money) {
		this.v_md5money = v_md5money;
	}

	public String getV_sign() {
		return v_sign;
	}

	public void setV_sign(String v_sign) {
		this.v_sign = v_sign;
	}

	public void parseRequest(HttpServletRequest request){
		
		this.v_url = request.getParameter("v_url");
		this.setV_oid(request.getParameter("v_oid"));
		this.v_pmode = request.getParameter("v_pmode");
		try{
			this.v_pmode = java.net.URLDecoder.decode(this.v_pmode, "GB2312");
		}catch(Exception ex){
			Debug.log(ex, module);
		}
		this.v_pstatus = request.getParameter("v_pstatus");
		this.v_pstring = request.getParameter("v_pstring");
		try{
			this.v_pstring = java.net.URLDecoder.decode(this.v_pstring, "GB2312");
		}catch(Exception ex){
			Debug.log(ex, module);
		}
		this.v_md5info = request.getParameter("v_md5info");
		this.v_amount = request.getParameter("v_amount");
		this.v_moneytype = request.getParameter("v_moneytype");
		this.v_md5money = request.getParameter("v_md5money");
		this.v_sign = request.getParameter("v_sign");
	}
	
	public void parseParametersMap(Map <String, Object> parametersMap){
		
		this.v_url = (String)parametersMap.get("v_url");
		this.setV_oid((String)parametersMap.get("v_oid"));
		this.v_pmode = (String)parametersMap.get("v_pmode");
		this.v_pstatus = (String)parametersMap.get("v_pstatus");
		this.v_pstring = (String)parametersMap.get("v_pstring");
		this.v_md5info = (String)parametersMap.get("v_md5info");
		this.v_amount = (String)parametersMap.get("v_amount");
		this.v_moneytype = (String)parametersMap.get("v_moneytype");
		this.v_md5money = (String)parametersMap.get("v_md5money");
		this.v_sign = (String)parametersMap.get("v_sign");
	}
	
	
	public boolean verifyResp(){
		RSA_MD5 rsaMD5 = new RSA_MD5();
		String source=v_oid + v_pstatus + v_amount + v_moneytype;
		int verifyStatus= rsaMD5.PublicVerifyMD5(fullFilePath,v_sign,source);
		if(verifyStatus ==0){
			return true;
		}else{
			return false;
		}
	}
	
	public boolean paySuccess(){
		if("20".equals(this.getV_pstatus())){
			return true;
		}else{
			return false;
		}
		
	}
}
