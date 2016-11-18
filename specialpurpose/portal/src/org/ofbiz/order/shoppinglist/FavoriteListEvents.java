package org.ofbiz.order.shoppinglist;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityUtil;
//import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.product.store.ProductStoreWorkerExt;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;


public class FavoriteListEvents{
	
	public static final String module = FavoriteListEvents.class.getName();
	
	public static final String PERSISTANT_LIST_TYPE_PS = "SLT_WISH_LIST_PS";  //店铺收藏
	public static final String PERSISTANT_LIST_NAME_PS = "MyFavoriteListPs";
	public static final String PERSISTANT_LIST_TYPE = "SLT_WISH_LIST";
	public static final String PERSISTANT_LIST_NAME = "MyFavoriteList";
	
	/**
	 * 产品加入收藏
	 * @param request
	 * @param response
	 * @return
	 */
	public static String addProductToFavoriteList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		if(UtilValidate.isEmpty(userLogin)){
			request.setAttribute("_ERROR_MESSAGE_", "用户未登录");
			request.setAttribute("resultType", "1");
	        return "error";
		}
		String productId = request.getParameter("productId");
		String productStoreId = ProductStoreWorkerExt.getSiteProductStoreId(request);
		String favoriteListId = getFavoriteListId(delegator, dispatcher, null, userLogin, productStoreId);
		
		Map<String, Object> serviceResult = null;
		try {
            Map<String, Object> ctx = UtilMisc.<String, Object>toMap("userLogin", userLogin, "shoppingListId", favoriteListId, "productId", productId);
            serviceResult = dispatcher.runSync("createShoppingListItem", ctx);
        } catch (GenericServiceException e) {
            Debug.logError(e, "Problems creating ShoppingList item entity", module);
            throw e;
        }
		// check for errors
        if (ServiceUtil.isError(serviceResult)) {
        	request.setAttribute("_ERROR_MESSAGE_", ServiceUtil.getErrorMessage(serviceResult));
            throw new IllegalArgumentException(ServiceUtil.getErrorMessage(serviceResult));
        }
        request.setAttribute("resultType", "0");
        return "success";
	}
	
	/**
	 * 把产品从收藏中移除
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public static String removeProductFromFavoriteList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		if(UtilValidate.isEmpty(userLogin)){
			request.setAttribute("_ERROR_MESSAGE_", "用户未登录");
			request.setAttribute("resultType", "1");
	        return "error";
		}
		String productId = request.getParameter("productId");
		String productStoreId = ProductStoreWorkerExt.getSiteProductStoreId(request);
		String favoriteListId = getFavoriteListId(delegator, dispatcher, null, userLogin, productStoreId);
		
		Map<String, Object> serviceResult = null;
		try {
			List<GenericValue> shoppingListItems=delegator.findByAnd("ShoppingListItem",  UtilMisc.<String, Object>toMap("shoppingListId", favoriteListId, "productId", productId));
			if(UtilValidate.isNotEmpty(shoppingListItems)){
				GenericValue shoppingListItem =EntityUtil.getFirst(shoppingListItems);
	            Map<String, Object> ctx = UtilMisc.<String, Object>toMap("userLogin", userLogin, "shoppingListId", favoriteListId, "shoppingListItemSeqId", shoppingListItem.getString("shoppingListItemSeqId"));
	            serviceResult = dispatcher.runSync("removeShoppingListItem", ctx);
			}else{
				request.setAttribute("resultType", "2");
				return "error";
			}
        } catch (GenericServiceException e) {
            Debug.logError(e, "Problems removing ShoppingList item entity", module);
            throw e;
        }
		// check for errors
        if (ServiceUtil.isError(serviceResult)) {
        	request.setAttribute("_ERROR_MESSAGE_", ServiceUtil.getErrorMessage(serviceResult));
            throw new IllegalArgumentException(ServiceUtil.getErrorMessage(serviceResult));
        }
        request.setAttribute("resultType", "0");
        return "success";
	}
	
	/**
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static String getFavoriteListId(HttpServletRequest request) throws Exception{
		Delegator delegator = (Delegator) request.getAttribute("delegator");
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		String productStoreId = ProductStoreWorkerExt.getSiteProductStoreId(request);
		return getFavoriteListId(delegator, dispatcher, null, userLogin, productStoreId);
	}
	
	/**
     * Finds or creates a specialized (auto-save) shopping list used to record shopping bag contents between user visits.
     */
    public static String getFavoriteListId(Delegator delegator, LocalDispatcher dispatcher, String partyId, GenericValue userLogin, String productStoreId) throws GenericEntityException, GenericServiceException {
        if (partyId == null && userLogin != null) {
            partyId = userLogin.getString("partyId");
        }

        String favoriteListId = null;
        GenericValue list = null;
        // TODO: add sorting, just in case there are multiple...
        if (partyId != null) {
            Map<String, Object> findMap = UtilMisc.<String, Object>toMap("partyId", partyId, "productStoreId", productStoreId, "shoppingListTypeId", PERSISTANT_LIST_TYPE, "listName", PERSISTANT_LIST_NAME);
            List<GenericValue> existingLists = delegator.findByAnd("ShoppingList", findMap);
            Debug.logInfo("Finding existing auto-save shopping list with:  \nfindMap: " + findMap + "\nlists: " + existingLists, module);
    
            if (UtilValidate.isNotEmpty(existingLists)) {
                list = EntityUtil.getFirst(existingLists);
                favoriteListId = list.getString("shoppingListId");
            }
        }
        if (list == null && dispatcher != null) {
            Map<String, Object> listFields = UtilMisc.<String, Object>toMap("userLogin", userLogin, "productStoreId", productStoreId, "shoppingListTypeId", PERSISTANT_LIST_TYPE, "listName", PERSISTANT_LIST_NAME);
            Map<String, Object> newListResult = dispatcher.runSync("createShoppingList", listFields);

            if (newListResult != null) {
            	favoriteListId = (String) newListResult.get("shoppingListId");
            }
        }

        return favoriteListId;
    }
    
    /**
     * 
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public static String addProductStoreToFavoriteList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		if(UtilValidate.isEmpty(userLogin)){
			request.setAttribute("_ERROR_MESSAGE_", "用户未登录");
			request.setAttribute("resultType", "1");
	        return "error";
		}
		String productStoreId = request.getParameter("productStoreId");
		
		Map<String, Object> serviceResult = null;
		try {
            Map<String, Object> ctx = UtilMisc.<String, Object>toMap("partyId", userLogin.getString("partyId"), "productStoreId", productStoreId, "shoppingListTypeId", PERSISTANT_LIST_TYPE_PS, "listName", PERSISTANT_LIST_NAME_PS);;
            List<GenericValue> shoppingLists=delegator.findByAnd("ShoppingList",  ctx);
            if(shoppingLists!=null && shoppingLists.size()>0){
            	request.setAttribute("_ERROR_MESSAGE_", "店铺已收藏");
    			request.setAttribute("resultType", "1");
    	        return "error";
            }
            serviceResult = dispatcher.runSync("createShoppingList", ctx);
        } catch (GenericServiceException e) {
            Debug.logError(e, "Problems creating ShoppingList item entity", module);
            throw e;
        }
		// check for errors
        if (ServiceUtil.isError(serviceResult)) {
        	request.setAttribute("_ERROR_MESSAGE_", ServiceUtil.getErrorMessage(serviceResult));
            throw new IllegalArgumentException(ServiceUtil.getErrorMessage(serviceResult));
        }
        request.setAttribute("resultType", "0");
        return "success";
	}
	
	/**
	 * 把店铺从收藏中移除
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public static String removeProductStoreFromFavoriteList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		if(UtilValidate.isEmpty(userLogin)){
			request.setAttribute("_ERROR_MESSAGE_", "用户未登录");
			request.setAttribute("resultType", "1");
	        return "error";
		}
		String productStoreId = request.getParameter("productStoreId");
		
		Map<String, Object> serviceResult = null;
		try {
			Map<String, Object> findMap = UtilMisc.<String, Object>toMap("partyId", userLogin.getString("partyId"), "productStoreId", productStoreId, "shoppingListTypeId", PERSISTANT_LIST_TYPE_PS, "listName", PERSISTANT_LIST_NAME_PS);
			List<GenericValue> shoppingLists=delegator.findByAnd("ShoppingList",  findMap);
			if(UtilValidate.isNotEmpty(shoppingLists)){
				GenericValue shoppingList =EntityUtil.getFirst(shoppingLists);
				shoppingList.remove();
			}else{
				request.setAttribute("resultType", "2");
				return "error";
			}
        } catch (Exception e) {
            Debug.logError(e, "Problems removing ShoppingList entity", module);
            throw e;
        }
        request.setAttribute("resultType", "0");
        return "success";
	}
}