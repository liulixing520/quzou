package org.ofbiz.ebiz.product;

import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import javolution.util.FastMap;

import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.ebiz.util.EbizStringUtil;

/**
 * 产品分类专用
 * @author hongs
 *
 */
public class ProductCategoryCondFilter {

	public static StringBuffer getFullRequestUrl(HttpServletRequest request,String productCategoryId,String excludeParam) {
        StringBuffer requestUrl = getPartRequestUrl(request);
        if (request.getQueryString() != null) {
            requestUrl.append("?" + getQueryStringExcludeParam(request.getQueryString(),excludeParam));
            if(requestUrl.toString().indexOf("category_id")<0){
            	requestUrl.append("&category_id=").append(productCategoryId);
            }
        }else{
        	requestUrl.append("?category_id=").append(productCategoryId);
        }
        return requestUrl;
    }
	
	public static StringBuffer getPartRequestUrl(HttpServletRequest request){
		StringBuffer requestUrl =new StringBuffer( UtilHttp.getServerRootUrl(request));
        requestUrl.append(request.getRequestURI());
        return requestUrl;
	}
	
	public static String getQueryStringExcludeParam(String queryString,String excludeParam) {
		StringBuffer sbfQueryString= new StringBuffer();
        //Map<String, Object> paramMap = FastMap.newInstance();
        if (UtilValidate.isNotEmpty(queryString)) {
            StringTokenizer queryTokens = new StringTokenizer(queryString, "&");
            Map excludeParamMap = EbizStringUtil.strToMapWithDelim(excludeParam, ",");
            while (queryTokens.hasMoreTokens()) {
                String token = queryTokens.nextToken();
                if (token.startsWith("amp;")) {
                    // this is most likely a split value that had an &amp; in it, so don't consider this a name; note that some old code just stripped the "amp;" and went with it
                    //token = token.substring(4);
                    continue;
                }
                int equalsIndex = token.indexOf("=");
                String name = token;
                String value="";
                if (equalsIndex > 0) {
                    name = token.substring(0, equalsIndex);
                    value=token.substring(equalsIndex + 1);
                    //if(!excludeParam.equals(name)){
                    if(!excludeParamMap.containsKey(name)){
                    	sbfQueryString.append("&").append(name).append("=").append(value);
                    }
                }
            }
        }
        return sbfQueryString.toString();
    }
	
	
}
