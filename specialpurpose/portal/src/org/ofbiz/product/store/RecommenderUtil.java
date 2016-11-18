package org.ofbiz.product.store;

import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityListIterator;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;
import org.ofbiz.webapp.stats.VisitHandler;

public class RecommenderUtil{

	private static final String module = RecommenderUtil.class.getName();
			
	public static List<String> youMayLike(HttpServletRequest request){
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		HttpSession session = request.getSession();
        Locale locale = UtilHttp.getLocale(request);
        GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
        String optProductCategoryId =(String)request.getAttribute("optProductCategoryId");
        String excludeProductId = (String)request.getAttribute("optExcludeProductId");
        String optViewSize =(String)request.getAttribute("optViewSize");
        if(UtilValidate.isEmpty(optViewSize)){
        	optViewSize = "20";
        }
        
        List<String> productCategoryIdList = FastList.newInstance();
        
        if(UtilValidate.isNotEmpty(optProductCategoryId)){
        	productCategoryIdList.add(optProductCategoryId);
        }else{
	        //找出看过的产品分类
	        Map<String,Object> inputContext =FastMap.newInstance();
	        inputContext.put("entityName", "ProductVisitAndProduct");
	        Map<String,Object> inputFields = FastMap.newInstance();
	        GenericValue visitor = VisitHandler.getVisitor(request, null);
	        if(UtilValidate.isNotEmpty(userLogin)){
	        	inputFields.put("partyId", userLogin.getString("partyId"));
	        }else{
	        	inputFields.put("visitorId", visitor.getString("visitorId"));
	        }
	        inputContext.put("inputFields", inputFields);
	        inputContext.put("viewSize", Integer.valueOf(5));
	        inputContext.put("orderBy", "-fromDate");
	        inputContext.put("distinct", "Y");
	        inputContext.put("fieldList", UtilMisc.toList("primaryProductCategoryId"));
	        Map<String,Object> returnResult = null;
	        try {
				returnResult = dispatcher.runSync("performFind", inputContext);
			} catch (GenericServiceException e) {
				Debug.logError(e.getMessage(), module);
			}
	        if(ServiceUtil.isSuccess(returnResult)){
	        	EntityListIterator listIt = (EntityListIterator) returnResult.get("listIt");
	        	try {
					listIt.beforeFirst();
				} catch (GenericEntityException e1) {
					Debug.logError(e1.getMessage(), module);
				}
	        	GenericValue pv = null;
	        	while ( (pv = (GenericValue)listIt.next()) != null ) {
	        		productCategoryIdList.add(pv.getString("primaryProductCategoryId"));
	        	}
	        	try {
	        		listIt.close();
                } catch (GenericEntityException e) {
                    Debug.logError(e, "Error closing list form render EntityListIterator: " + e.toString(), module);
                }
	        }
        }
        
        //根据产品分类查产品
        StringBuffer queryLine =new StringBuffer();
        queryLine.append("text:* ");
        if(UtilValidate.isNotEmpty(productCategoryIdList)){
        	queryLine.append(" AND ( ");
        	for(int i=0;i<productCategoryIdList.size();i++){
        		if(i>0){
        			queryLine.append(" OR ");
        		}
        		queryLine.append(" cat:*").append(productCategoryIdList.get(i)).append("* ");
        	}
        	queryLine.append(" ) ");
        }
        if(UtilValidate.isNotEmpty(excludeProductId)){
        	queryLine.append(" NOT productId:").append(excludeProductId);
        }
        
		Map<String,Object> queryContext = FastMap.newInstance();
		queryContext.put("query",queryLine.toString());
		queryContext.put("viewSize", optViewSize);
		queryContext.put("sortBy", "totalQuantityOrdered");
		queryContext.put("sortByReverse", true);
        Map<String,Object> queryResult = null;
        
        try {
			queryResult = dispatcher.runSync("solrKeywordSearch", queryContext);
		} catch (GenericServiceException e) {
			Debug.logError(e.getMessage(), module);
		}
        
        if(ServiceUtil.isSuccess(queryResult)){
	        List<String> productIds = (List<String>)queryResult.get("productIds");
	        
	        request.setAttribute("youLikeProductIds", productIds);
	        return productIds;
        }else{
        	return null;
        }
	}
}