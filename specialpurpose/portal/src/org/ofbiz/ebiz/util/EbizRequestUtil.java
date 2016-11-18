package org.ofbiz.ebiz.util;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import org.ofbiz.entity.GenericValue;

import javolution.util.FastMap;

public class EbizRequestUtil {

	private Map<String,Object> attrMap = null;
	
	public EbizRequestUtil(){
		attrMap= FastMap.newInstance();
	}
	
	/**
	 * 
	 * @param request
	 * @param attributeKey
	 * @param attributeValue
	 * @return
	 */
	public Object setReqAttrValue(ServletRequest request,String attrKey,Object attrValue){
		Object retValue = (Object)request.getAttribute(attrKey);
		attrMap.put(attrKey, retValue);
		request.setAttribute(attrKey, attrValue);
		return retValue;
	}
	
	/**
	 * 
	 * @param request
	 * @param attrKey
	 * @return
	 */
	public Object restoreReqAttrValue(ServletRequest request,String attrKey){
		Object retValue = null;
		if(attrMap.containsKey(attrKey)){
			retValue = attrMap.get(attrKey);
			request.setAttribute(attrKey, retValue);
		}
		return retValue;
	}
	
	/**
	 * 
	 * @param request
	 * @return
	 */
	public Object restoreReqAttrValue(ServletRequest request){
		for (Map.Entry<String, Object> entry : attrMap.entrySet()) {
            String attrKey = entry.getKey();
            Object attrValue = entry.getValue();
            request.setAttribute(attrKey, attrValue);
		}
		return "";
	}
			
	public static EbizRequestUtil getEbizRequestUtil(ServletRequest request){
		return new EbizRequestUtil();
	}
}
