package org.ofbiz.ofc.tools;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.base.util.cache.UtilCache;
import org.ofbiz.entity.Delegator;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.ServiceUtil;

public class Html5Events {

	public static String module = Html5Events.class.getName();
    
	
	 public static String html5EventSourceResponseFromRequestAttributes(HttpServletRequest request, HttpServletResponse response) {
	        // pull out the service response from the request attribute
	        Map<String, Object> attrMap = UtilHttp.getJSONAttributeMap(request);

	        // create a JSON Object for return
//	        JSONObject json = JSONObject.fromObject(attrMap);
//	        String jsonStr = json.toString();
	        
	        String jsonStr = "data: "+UtilDateTime.nowDateString("yyyy-MM-dd HH:mm:ss")+"\n\n";
	        
	        if (jsonStr == null) {
	            Debug.logError("JSON Object was empty; fatal error!", module);
	            return "error";
	        }
	        // set the  content type
	        response.setContentType("text/event-stream");
	     // 这里必须设置 Content-Type 为 text/event-stream 
//	        response.setHeader("Content-Type", "text/event-stream"); 
//	        response.setHeader("Cache-Control", "no-cache"); 
	        //response.setCharacterEncoding ("UTF-8"); 
	       
	        
	        // jsonStr.length is not reliable for unicode characters
	        try {
	            response.setContentLength(jsonStr.getBytes("UTF8").length);
	        } catch (UnsupportedEncodingException e) {
	            Debug.logError("Problems with Json encoding: " + e, module);
	        }

	        // return the JSON String
	        Writer out;
	        try {
	            out = response.getWriter();
	            out.write(jsonStr);
	            
	            //out.println("data: " + str);
	            
	            out.flush();
	        } catch (IOException e) {
	            Debug.logError(e, module);
	        }

	        return "success";
	    }

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	
	public static Map<String, Object> saveOfcFileCache(DispatchContext dctx,Map<String, ? extends Object> context) {
		Locale locale = (Locale) context.get("locale");
		Map<String, Object> result = ServiceUtil.returnSuccess();
		Delegator delegator = dctx.getDelegator();

		
		String ofcinput =(String) context.get("ofcinput");

		
		try {
			String names="distributed";
			UtilCache cache =UtilCache.getOrCreateUtilCache("fileCache", 0, 0,0,  false, true,names);
			
			cache.put("s001", "36");
			String s002="40";
			cache.put("s002", s002);
			Debug.log(s002);
			
			Map map =new HashMap();
			map.put("ss004", "22");
			if(UtilValidate.isNotEmpty(ofcinput)){
				map.put("ss0041", ofcinput);
			}
			cache.put("map004", map);
			
			Map map004 =(Map) cache.get("map004");
			String ss0041 =(String) map004.get("ss0041");
			String ss0042 =(String) map004.get("ss0042");
			Debug.log("ss0041 =="+ss0041);
			Debug.log("ss0042 =="+ss0042);
			
			
			String s003 =(String) cache.get("s003");
			Debug.log(s003);
			
			if(UtilValidate.isNotEmpty(ofcinput)){
				cache.clear();
			}
			
			
			result.put("ofcout", "s002="+s002+"s003="+s003+  "map004="+map004 +"ss0041="+ss0041+ "ss0042="+ss0042);
		} catch (Exception e) {
			Debug.logError(e, e.getMessage(), module);
			
		}
		
		return result;
	}

}
