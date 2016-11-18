package org.ofbiz.ofc.tools;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.base.util.cache.UtilCache;
import org.ofbiz.entity.Delegator;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.ServiceUtil;

public class FileCacheUtils {

	
	public static final String module = FileCacheUtils.class.getName();
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

	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		
		
	}
	
}
