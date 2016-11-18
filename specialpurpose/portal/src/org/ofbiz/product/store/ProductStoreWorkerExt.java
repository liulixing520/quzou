package org.ofbiz.product.store;

import java.util.List;
import java.util.Locale;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import javolution.util.FastList;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.product.catalog.CatalogWorker;
import org.ofbiz.webapp.website.WebSiteWorker;

public class ProductStoreWorkerExt{

	public static final String module = ProductStoreWorkerExt.class.getName();
	
	/**
	 * 得到站点下的店铺id列表
	 * @param request
	 * @return
	 */
	public static List<String> getProductStoreIds(ServletRequest request) {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        Delegator delegator = (Delegator) request.getAttribute("delegator");
        HttpSession session = httpRequest.getSession(false);
        if (session != null && session.getAttribute("productStoreIds") != null) {
            return (List) session.getAttribute("productStoreIds");
        } else {
            GenericValue webSite = CatalogWorker.getWebSite(request);
            if (webSite != null) {
                String productStoreId = webSite.getString("productStoreId");
                // might be nice to do this, but not needed and has a problem with dependencies: setSessionProductStore(productStoreId, httpRequest);
                String isMultiStore = webSite.getString("isMultiStore");
                if("Y".equalsIgnoreCase(isMultiStore)){
                	List<GenericValue> listWebSiteProductStores = null;
                	try{
                		listWebSiteProductStores = delegator.findByAnd("WebSiteProductStore", UtilMisc.toMap("webSiteId", webSite.getString("webSiteId")));
                	}catch(Exception ex){
                		Debug.log(ex,module);
                	}
                	if(UtilValidate.isNotEmpty(listWebSiteProductStores)){
                		listWebSiteProductStores = EntityUtil.filterByDate(listWebSiteProductStores);
	                	List<String> productStoreIds = FastList.<String>newInstance();
	                	for(GenericValue gv:listWebSiteProductStores){
	                		productStoreIds.add(gv.getString("productStoreId"));
	                	}
	                	return productStoreIds;
                	}else{
                		return UtilMisc.toList(productStoreId);
                	}
                }else{
                	return UtilMisc.toList(productStoreId);
                }
            }
        }
        return null;
    }
	
	/**
	 * 
	 * @param request
	 * @param productStoreId
	 * @return
	 */
	public static String getProductStoreId(ServletRequest request,String productStoreId) {
		if(UtilValidate.isNotEmpty(productStoreId)){
			return productStoreId;
		}else{
			if(UtilValidate.isEmpty(productStoreId)){
				productStoreId =request.getParameter("productStoreId");
			}
			if(UtilValidate.isEmpty(productStoreId)){
				productStoreId =(String)request.getAttribute("productStoreId");
			}
			if(UtilValidate.isNotEmpty(productStoreId)){
				return productStoreId;
			}else{
				return ProductStoreWorker.getProductStoreId(request);
			}
		}
    }
	
	/**
	 * 
	 * @param request
	 * @param productStoreId
	 * @return
	 */
	public static Locale getStoreLocale(HttpServletRequest request,String productStoreId) {
	    Delegator delegator = (Delegator) request.getAttribute("delegator");
        GenericValue productStore = ProductStoreWorker.getProductStore(productStoreId, delegator);
	    if (UtilValidate.isEmpty(productStore)) {
	        Debug.logError(
	                "No product store found in request, cannot set locale!", module);
	        return null;
	    } else {
	        return UtilHttp.getLocale(request, request.getSession(), productStore.getString("defaultLocaleString"));
	    }
	}

	/**
	 * 获取店铺币种
	 * @param request
	 * @param productStoreId
	 * @return
	 */
	public static String getStoreCurrencyUomId(HttpServletRequest request,String productStoreId) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
        GenericValue productStore = ProductStoreWorker.getProductStore(productStoreId, delegator);
        if (UtilValidate.isEmpty(productStore)) {
            Debug.logError(
                    "No product store found in request, cannot set CurrencyUomId!", module);
            return null;
        } else {
            return UtilHttp.getCurrencyUom(request.getSession(), productStore.getString("defaultCurrencyUomId"));
        }
    }
	
	/**
	 * 得到产品所属店铺
	 * @param request
	 * @param productId
	 * @return
	 */
	public static String getProductCurrentStoreId(HttpServletRequest request,String productId) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		try{
			GenericValue product = delegator.findOne("Product", UtilMisc.toMap("productId",productId), true);
			if( UtilValidate.isNotEmpty(product.getString("primaryProductStoreId")) ){
				return product.getString("primaryProductStoreId");
			}
			List<GenericValue> productProductStoreList = product.getRelated("ProductProductStore");
			if(productProductStoreList!=null){
				productProductStoreList = EntityUtil.filterByDate(productProductStoreList);
				if( UtilValidate.isNotEmpty(productProductStoreList) ){
					GenericValue productProductStore = EntityUtil.getFirst(productProductStoreList);
					return productProductStore.getString("productStoreId");
				}
			}
		}catch(Exception ex){
			
		}
		return ProductStoreWorker.getProductStoreId(request);
	}
	
	/**
	 * 会员拥有的店铺标识
	 * @param request
	 * @param partyId
	 * @return
	 */
	public static String getPartyCurrentStoreId(HttpServletRequest request,String partyId){
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		try{
			List condList = FastList.newInstance();
			condList.add(EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, partyId));
			condList.add(EntityCondition.makeCondition("roleTypeId", EntityOperator.EQUALS, "OWNER"));
			EntityCondition rolesCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
			List productStoreRoleList = delegator.findList("ProductStoreRole", rolesCond, null, UtilMisc.toList("-sequenceNum"), null, false);
			
			productStoreRoleList = EntityUtil.filterByDate(productStoreRoleList);
			if(UtilValidate.isNotEmpty(productStoreRoleList)){
				GenericValue productStoreRole = EntityUtil.getFirst(productStoreRoleList);
				return productStoreRole.getString("productStoreId");
				
			}
		}catch(Exception ex){
			
		}
		return null;
	}
	/**
	 * 会员拥有的店铺标识
	 * @param request
	 * @param partyId
	 * @return
	 */
	public static String getPartyCurrentStoreId(Delegator delegator,String partyId){
		try{
			List condList = FastList.newInstance();
			condList.add(EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, partyId));
			condList.add(EntityCondition.makeCondition("roleTypeId", EntityOperator.EQUALS, "OWNER"));
			EntityCondition rolesCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
			List productStoreRoleList = delegator.findList("ProductStoreRole", rolesCond, null, UtilMisc.toList("-sequenceNum"), null, false);
			
			productStoreRoleList = EntityUtil.filterByDate(productStoreRoleList);
			if(UtilValidate.isNotEmpty(productStoreRoleList)){
				GenericValue productStoreRole = EntityUtil.getFirst(productStoreRoleList);
				return productStoreRole.getString("productStoreId");
				
			}
		}catch(Exception ex){
			
		}
		return null;
	}
	
	/**
	 * 
	 * @param request
	 * @return
	 */
	public static String getSiteProductStoreId(ServletRequest request) {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        GenericValue webSite = WebSiteWorker.getWebSite(httpRequest);
        if (webSite != null) {
            String productStoreId = webSite.getString("productStoreId");
            // might be nice to do this, but not needed and has a problem with dependencies: setSessionProductStore(productStoreId, httpRequest);
            return productStoreId;
        }
        return null;
    }
	
	public static GenericValue getSiteProductStore(ServletRequest request) {
        Delegator delegator = (Delegator) request.getAttribute("delegator");
        String productStoreId = ProductStoreWorkerExt.getSiteProductStoreId(request);
        return ProductStoreWorker.getProductStore(productStoreId, delegator);
    }
}