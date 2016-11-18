package org.ofbiz.accounting.thirdparty.payease;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.FileUtil;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;

import com.capinfo.crypt.RSA_MD5;

public class UtilPayease {
	private static String module = UtilPayease.class.getName();

	private static final String Public1024keyPath="component://portal/script/org/ofbiz/accounting/payment/Public1024.key";
	private static String fullFilePath=null;
	static{
		File keyFile = FileUtil.getFile(Public1024keyPath);
		fullFilePath = keyFile.getAbsolutePath();
	}
	
	public static String md5(String md5Source,String strKey){

		Md5 md5 = new Md5("") ;
		try {
			md5.hmac_Md5(md5Source,strKey) ;
			byte b[]= md5.getDigest();
			String digestString = md5.stringify(b) ;
			return digestString;
		} catch (IOException e) {
			Debug.logError(e, module);
		}
		return null;
	}
	
	public static boolean verifyMd5(String md5Source,String strKey,String v_mac){
		String v_md5 = md5(md5Source,strKey);
		if(v_md5!=null && v_md5.equals(v_mac)){
			return true;
		}else{
			return false;
		}
	}
	
	public static boolean verifyResp(String v_source,String v_sign){
		RSA_MD5 rsaMD5 = new RSA_MD5();
		int verifyStatus= rsaMD5.PublicVerifyMD5(fullFilePath,v_sign,v_source);
		if(verifyStatus ==0){
			return true;
		}else{
			return false;
		}
	}
	
	public static String getOrderPaymentGroupId(String v_oid){
		String orderPaymentGroupId = v_oid;
		if(v_oid!=null && v_oid.lastIndexOf("-")>0){
			orderPaymentGroupId = v_oid.substring(v_oid.lastIndexOf("-")+1);
		}
		return orderPaymentGroupId;
	}
	
	public static String getProductStoreId(Delegator delegator,String orderId){
		return "9000";
	}
	
	public static String getOid(String v_ymd,String v_mid,String orderPaymentGroupId){
		String v_oid = v_ymd+"-"+v_mid+"-"+orderPaymentGroupId;
		return v_oid;
	}
	
	public static String getPaymentGatewayConfigValue(Delegator delegator,
			String paymentGatewayConfigId,
			String paymentGatewayConfigParameterName, String resource,
			String parameterName) {
		String returnValue = "";
		if (UtilValidate.isNotEmpty(paymentGatewayConfigId)) {
			try {
				GenericValue payease = delegator.findOne(
						"PaymentGatewayPayease", UtilMisc.toMap(
								"paymentGatewayConfigId",
								paymentGatewayConfigId), false);
				if (UtilValidate.isNotEmpty(payease)) {
					Object payeaseField = payease
							.get(paymentGatewayConfigParameterName);
					if (payeaseField != null) {
						returnValue = payeaseField.toString().trim();
					}
				}
			} catch (GenericEntityException e) {
				Debug.logError(e, module);
			}
		} else {
			String value = UtilProperties.getPropertyValue(resource,
					parameterName);
			if (value != null) {
				returnValue = value.trim();
			}
		}
		return returnValue;
	}
	
	public static void streamContentToBrowser(HttpServletRequest request, HttpServletResponse response,String strContent,String contentType){
		try {
			UtilHttp.streamContentToBrowser(response, strContent.getBytes(), contentType);
		} catch (IOException e) {
			Debug.log(e, module);
		}
	}
	
	public static String decodeReqParam(String strInput,String reqMethod){
		String strTemp = strInput;
		
		
		try {
			strTemp = java.net.URLDecoder.decode(strInput.trim(),"UTF-8");
		} catch (Exception ex) {
			Debug.log(ex, module);
		}
		
		try {
			if("POST".equals(reqMethod)){
				strTemp = new String(strInput.getBytes("iso-8859-1"),"gb2312");
			}else{
				strTemp = new String(strTemp.getBytes("UTF-8"),"gb2312");
			}
			//strTemp = java.net.URLEncoder.encode(strTemp, "UTF-8");
		} catch (Exception ex) {
			Debug.log(ex, module);
		}
		
		return strTemp;
	}
	
	public static void main(String[] args){
		String strInput = "%D6%A7%B8%B6%CD%EA%B3%C9";
		try {
			String strTemp = java.net.URLDecoder.decode(strInput,"gb2312");
			System.out.print(strTemp);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
