package org.ofbiz.ebiz.util;

import java.util.Map;

import javolution.util.FastMap;

import org.ofbiz.base.util.UtilValidate;

public class EbizStringUtil {

	public static Map strToMapWithDelim(String strInput, String strDelim) {
		Map mapReturn = FastMap.newInstance();
		if (UtilValidate.isNotEmpty(strInput)) {
			if (strInput.indexOf(strDelim) > 0) {
				String[] arrayIn = strInput.split(strDelim);
				for (int i = 0; i < arrayIn.length; i++) {
					mapReturn.put(arrayIn[i], arrayIn[i]);
				}
			} else {
				mapReturn.put(strInput, strInput);
			}
		}
		return mapReturn;
	}

	public static boolean compareStr(String a1, String a2) {

		a1 = a1.trim();
		a2 = a2.trim();
		if (a1.equals(a2))
			return true;
		return false;
	}
}
