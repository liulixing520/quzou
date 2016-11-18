package org.ofbiz.management;

import java.util.List;

import javolution.util.FastList;

import org.ofbiz.base.util.StringUtil;
import org.ofbiz.base.util.UtilValidate;

public class Utils {


	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static List splitStringToList(String inputString) {
		List result = FastList.newInstance();
		if(UtilValidate.isEmpty(inputString)){
			return result;
		}
		String[] array =inputString.split(";");
		for(int i=0;i<array.length;i++){
			if(UtilValidate.isNotEmpty(array[i])){
				result.add(array[i].trim());
			}
		}
        return result;
    }
	
	/**
	 * 分割字符串 自定义的分隔符
	 * @param inputString
	 * @param splitChar
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static List splitStringToList(String inputString,String splitChar) {
		List result = FastList.newInstance();
		if(UtilValidate.isEmpty(inputString)){
			return result;
		}
		String[] array =inputString.split(splitChar);
		for(int i=0;i<array.length;i++){
			if(UtilValidate.isNotEmpty(array[i])){
				result.add(array[i]);
			}
		}
        return result;
    }
	
	
	 public static Object wrapString(Object theString) {
		 if (theString instanceof String) {
			    String s = (String) theString;
			    return StringUtil.wrapString(s);
			}
        return theString;
    }

	 
}
