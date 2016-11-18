package org.ofbiz.base.util;

import java.nio.ByteBuffer;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class UtilHttpExt {

	public static String getProductStorePrefix(HttpServletRequest request,String productStoreId){
		StringBuffer sbf = new StringBuffer();
		sbf.append("PS").append(productStoreId).append("_");
		return sbf.toString();
	}
	
	public static Map<String, Object> makeParamMapWithoutPrefix(HttpServletRequest request, String prefix, String suffix) {
        return makeParamMapWithoutPrefix(request, null, prefix, suffix);
    }

    public static Map<String, Object> makeParamMapWithoutPrefix(HttpServletRequest request, Map<String, ? extends Object> additionalFields, String prefix, String suffix) {
        return makeParamMapWithoutPrefix(UtilHttp.getParameterMap(request), additionalFields, prefix, suffix);
    }

    public static Map<String, Object> makeParamMapWithoutPrefix(Map<String, ? extends Object> context, Map<String, ? extends Object> additionalFields, String prefix, String suffix) {
        Map<String, Object> paramMap = new HashMap<String, Object>();
        for (Map.Entry<String, ? extends Object> entry: context.entrySet()) {
            String parameterName = entry.getKey();
            if (!parameterName.startsWith(prefix)) {
                if (UtilValidate.isNotEmpty(suffix)) {
                    if (!parameterName.endsWith(suffix)) {
                        String key = parameterName;
                        if (entry.getValue() instanceof ByteBuffer) {
                            ByteBuffer value = (ByteBuffer) entry.getValue();
                            paramMap.put(key, value);
                        } else {
                            String value = (String) entry.getValue();
                            paramMap.put(key, value);
                        }
                    }
                } else {
                    String key = parameterName;
                    if (context.get(parameterName) instanceof ByteBuffer) {
                        ByteBuffer value = (ByteBuffer) entry.getValue();
                        paramMap.put(key, value);
                    } else {
                        String value = (String) entry.getValue();
                        paramMap.put(key, value);
                    }
                }
            }
        }
        if (additionalFields != null) {
            for (Map.Entry<String, ? extends Object> entry: additionalFields.entrySet()) {
                String fieldName = entry.getKey();
                if (!fieldName.startsWith(prefix)) {
                    if (UtilValidate.isNotEmpty(suffix)) {
                        if (!fieldName.endsWith(suffix)) {
                            String key = fieldName;
                            Object value = entry.getValue();
                            paramMap.put(key, value);

                            // check for image upload data
                            if (!(value instanceof String)) {
                                String nameKey = "_" + key + "_fileName";
                                Object nameVal = additionalFields.get("_" + fieldName + "_fileName");
                                if (nameVal != null) {
                                    paramMap.put(nameKey, nameVal);
                                }

                                String typeKey = "_" + key + "_contentType";
                                Object typeVal = additionalFields.get("_" + fieldName + "_contentType");
                                if (typeVal != null) {
                                    paramMap.put(typeKey, typeVal);
                                }

                                String sizeKey = "_" + key + "_size";
                                Object sizeVal = additionalFields.get("_" + fieldName + "_size");
                                if (sizeVal != null) {
                                    paramMap.put(sizeKey, sizeVal);
                                }
                            }
                        }
                    } else {
                        String key = fieldName;
                        Object value = entry.getValue();
                        paramMap.put(key, value);

                        // check for image upload data
                        if (!(value instanceof String)) {
                            String nameKey = "_" + key + "_fileName";
                            Object nameVal = additionalFields.get("_" + fieldName + "_fileName");
                            if (nameVal != null) {
                                paramMap.put(nameKey, nameVal);
                            }

                            String typeKey = "_" + key + "_contentType";
                            Object typeVal = additionalFields.get("_" + fieldName + "_contentType");
                            if (typeVal != null) {
                                paramMap.put(typeKey, typeVal);
                            }

                            String sizeKey = "_" + key + "_size";
                            Object sizeVal = additionalFields.get("_" + fieldName + "_size");
                            if (sizeVal != null) {
                                paramMap.put(sizeKey, sizeVal);
                            }
                        }
                    }
                }
            }
        }
        return paramMap;
    }
}
