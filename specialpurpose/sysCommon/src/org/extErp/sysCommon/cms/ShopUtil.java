package org.extErp.sysCommon.cms;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javolution.util.FastList;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilValidate;

public class ShopUtil{
	public static final String module = ShopUtil.class.getName();
	//need i18n
	private final static String saveSuccess="保存成功";
	private final static String deleteSuccess="删除成功";
	private final static String updateSuccess="更新成功";
	private final static String saveError="保存失败";
	private final static String deleteError="删除失败";
	private final static String updateError="更新失败";
	private final static String operError="操作失败";
	private final static String operSuccess="操作成功";
 public static void returnAjaxInfo(Map  outputMap, Map<String, ? extends Object> context) {
	 outputMap.put("navTabId", ShopUtil.notEmpt(context.get("navTabId")));
	 outputMap.put("callbackType", ShopUtil.notEmpt(context.get("callbackType")));
    }
 public static void returnTitleMessage(Map<String, String> outputMap,Boolean isSuccess,String oper) {
	 String returnMessage="";
	 if(isSuccess&&oper.endsWith("save")){
		 returnMessage=saveSuccess;
	 }else if(isSuccess&&oper.endsWith("delete")){
		 returnMessage=deleteSuccess;
	 }else if(isSuccess&&oper.endsWith("update")){
		 returnMessage=updateSuccess;
	 }else if(!isSuccess&&oper.endsWith("save")){
		 returnMessage=saveError;
	 }else if(!isSuccess&&oper.endsWith("delete")){
		 returnMessage=deleteError;
	 }else if(!isSuccess&&oper.endsWith("update")){
		 returnMessage=updateError;
	 }else{
		 returnMessage=operSuccess;
	 }
	 outputMap.put("successMessage", returnMessage);
	 //outputMap.put("statusCode", "200");
    }
 public static String notEmpt(Object obj){
	 if(obj!=null&&obj.toString().length()>0){
		 return obj.toString();
	 }else{
		 return "";
	 }
 }
 public static String operSuccess(){
	 return operSuccess;
 }
 /**
  * 英汉字符串按照英文长度截取
  * @param inputStr
  * @param keepLengthInEN
  * @return
  */
 public static String cutStringWithGiveLength(String inputStr,int keepLengthInEN){
	 if(UtilValidate.isNotEmpty(inputStr)){
		 int length = 0;
		 List<Character> returnCharList = FastList.newInstance();
		 for(int i = 0 ; i < inputStr.length(); i++){
			 char c = inputStr.charAt(i); 
			 if(c>255){
				 length+=2;
			 }else{
				 length+=1;
			 }
			 if(length<=keepLengthInEN){
				 returnCharList.add(c);
			 }else{
				 break;
			 }
		 }
		 char[] returnChar = new char[returnCharList.size()];
		 for(int j = 0;j<returnChar.length; j++){
			 returnChar[j] = returnCharList.get(j);
		 }
		 inputStr = new String(returnChar);
	 }else{
		 return "";
	 }
	 
	 return inputStr;
 }

 public static int getStringLength(String inputStr){
	 if(UtilValidate.isNotEmpty(inputStr)){
		 try {
			inputStr=new String(inputStr.getBytes("gb2312"),"iso-8859-1");
		} catch (UnsupportedEncodingException e) {
			Debug.logError(e, module);
		}
	 }else{
		 return 0;
	 }
	 return inputStr.length();
 }
} 