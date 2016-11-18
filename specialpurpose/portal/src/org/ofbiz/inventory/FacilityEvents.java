package org.ofbiz.inventory;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;


public class FacilityEvents {
	public static final String module = FacilityEvents.class.getName();
    public static final String resource = "FacilityUiLabels";
    public static final String resourceError = "FacilityErrorUiLabels";
    /**
     * Return success event. Used as a place holder for events.
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @return Response code string
     */
    public static String returnSuccess(HttpServletRequest request, HttpServletResponse response) {
        return "success";
    }

    /**
     * Return error event. Used as a place holder for events.
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @return Response code string
     */
    public static String returnError(HttpServletRequest request, HttpServletResponse response) {
        return "error";
    }
    /**
	 * 保存仓库-并新增仓库的发货地址-匹配默认店铺
	 * @param request
	 * @param response
	 * @return
	 */
	public static String createFacility(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        ServletContext application = session.getServletContext();
        Delegator delegator = (Delegator) request.getAttribute("delegator");
        GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        DispatchContext disContext=dispatcher.getDispatchContext();
        Map<String, Object> context = UtilHttp.getParameterMap(request);
        Map<String, Object> contextMap = FastMap.newInstance();
        Map<String, Object> storeFacilityMap = FastMap.newInstance();
        Map<String, Object> postalAddressMap = FastMap.newInstance();
        Map<String, Object> returnMap = FastMap.newInstance();
        String message="";
        boolean beganTransaction = false;
        boolean okay = true;
        try{
        	//beganTransaction = TransactionUtil.begin();
	    	contextMap.put("facilityTypeId", context.get("facilityTypeId"));
	    	contextMap.put("facilityName", context.get("facilityName"));
	    	contextMap.put("ownerPartyId", context.get("ownerPartyId"));
	    	contextMap.put("description", context.get("description"));
	    	contextMap.put("userLogin", userLogin);
	    	returnMap=dispatcher.runSync("createFacilityLt", contextMap);

	    	postalAddressMap.put("facilityId", returnMap.get("facilityId"));
	    	postalAddressMap.put("userLogin", userLogin);
	    	postalAddressMap.put("toName", context.get("toName"));
	    	postalAddressMap.put("stateProvinceGeoId", context.get("stateProvinceGeoId"));
	    	postalAddressMap.put("cityGeoId", context.get("cityGeoId"));
	    	postalAddressMap.put("countyGeoId", context.get("countyGeoId"));
	    	postalAddressMap.put("address1", context.get("address1"));
	    	postalAddressMap.put("postalCode", context.get("postalCode"));
	    	postalAddressMap.put("mobileExd", context.get("mobileExd"));
	    	postalAddressMap.put("phoneAreaExd", context.get("phoneAreaExd"));
	    	postalAddressMap.put("phoneExd", context.get("phoneExd"));
	    	postalAddressMap.put("contactMechPurposeTypeId", context.get("contactMechPurposeTypeId"));
	    	dispatcher.runSync("createFacilityPostalAddressLt", postalAddressMap);
	    	//仓库匹配默认店铺
	    	String productStoreId=ProductStoreWorker.getProductStoreId(request);
	    	storeFacilityMap.put("productStoreId",productStoreId);
	    	storeFacilityMap.put("facilityId",returnMap.get("facilityId"));
	    	storeFacilityMap.put("userLogin", userLogin);
	    	storeFacilityMap.put("fromDate", UtilDateTime.nowTimestamp());
	    	dispatcher.runSync("createProductStoreFacility", storeFacilityMap);
	    	//TransactionUtil.commit(beganTransaction);
	    	message="操作成功";
	    }catch(Exception e){
	    	message="操作失败";
	    	/*
            String errMsg = "Error updating quick admin shipping settings: " + e.toString();
            Debug.logError(e, errMsg, module);
            request.setAttribute("_ERROR_MESSAGE_", errMsg);
            try{
            	TransactionUtil.rollback(beganTransaction, errMsg, e);
            }catch (GenericTransactionException gte) {gte.printStackTrace();}
            return "error";
        	*/
        }
        request.setAttribute("message", message);
        return "success";
	}
	/**
	 * 修改仓库-并新增仓库的发货地址-匹配默认店铺
	 * @param request
	 * @param response
	 * @return
	 */
	public static String updateFacility(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ServletContext application = session.getServletContext();
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		DispatchContext disContext=dispatcher.getDispatchContext();
		Map<String, Object> context = UtilHttp.getParameterMap(request);
		Map<String, Object> contextMap = FastMap.newInstance();
		Map<String, Object> storeFacilityMap = FastMap.newInstance();
		Map<String, Object> postalAddressMap = FastMap.newInstance();
		Map<String, Object> returnMap = FastMap.newInstance();
		String message="";
		boolean beganTransaction = false;
		boolean okay = true;
		try{
			//beganTransaction = TransactionUtil.begin();
			contextMap.put("facilityId", context.get("facilityId"));
			contextMap.put("facilityTypeId", context.get("facilityTypeId"));
			contextMap.put("facilityName", context.get("facilityName"));
			contextMap.put("ownerPartyId", context.get("ownerPartyId"));
			contextMap.put("description", context.get("description"));
			contextMap.put("userLogin", userLogin);
			returnMap=dispatcher.runSync("updateFacilityLt", contextMap);
			
			postalAddressMap.put("contactMechId", context.get("contactMechId"));
			postalAddressMap.put("facilityId", context.get("facilityId"));
			postalAddressMap.put("userLogin", userLogin);
			postalAddressMap.put("toName", context.get("toName"));
			postalAddressMap.put("stateProvinceGeoId", context.get("stateProvinceGeoId"));
			postalAddressMap.put("cityGeoId", context.get("cityGeoId"));
			postalAddressMap.put("city", context.get("cityGeoId"));
			postalAddressMap.put("countyGeoId", context.get("countyGeoId"));
			postalAddressMap.put("address1", context.get("address1"));
			postalAddressMap.put("postalCode", context.get("postalCode"));
			postalAddressMap.put("mobileExd", context.get("mobileExd"));
			postalAddressMap.put("phoneAreaExd", context.get("phoneAreaExd"));
			postalAddressMap.put("phoneExd", context.get("phoneExd"));
			dispatcher.runSync("updateFacilityPostalAddressLt", postalAddressMap);
			//TransactionUtil.commit(beganTransaction);
			message="操作成功";
		}catch(Exception e){
			message="操作失败";
			/*
            String errMsg = "Error updating quick admin shipping settings: " + e.toString();
            Debug.logError(e, errMsg, module);
            request.setAttribute("_ERROR_MESSAGE_", errMsg);
            try{
            	TransactionUtil.rollback(beganTransaction, errMsg, e);
            }catch (GenericTransactionException gte) {gte.printStackTrace();}
            return "error";
			 */
		}
		request.setAttribute("message", message);
		return "success";
	}
	
	/**
	 * 批量更新商品库存
	 * 本次接受库存数=前台传入用户所输入库存数-原库存数
	 * @param request
	 * @param response
	 * @return
	 * 
	 */
	public static String updateProductInventory(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        ServletContext application = session.getServletContext();
        Delegator delegator = (Delegator) request.getAttribute("delegator");
        GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        DispatchContext disContext=dispatcher.getDispatchContext();
        String message="";
        List<GenericValue> facilityList=FastList.newInstance();
        String productIdArray[]=request.getParameter("productIds").split(",");
        try{
        	facilityList=delegator.findByAnd("Facility");
        	Map  InventoryMap=InventoryWorker.getInventoryByProductIds(delegator, request.getParameter("productIds"));
        	for(GenericValue fgv: facilityList){
        		for(int p=0; p<productIdArray.length;p++){
        			String inventory=request.getParameter(productIdArray[p]+"_"+fgv.get("facilityId"));
        			if(inventory != null){
        				if(InventoryMap.get(productIdArray[p]+"_"+fgv.get("facilityId"))!=null){
        					Map map=(Map)InventoryMap.get(productIdArray[p]+"_"+fgv.get("facilityId"));
        					BigDecimal invBg=(map!=null)?(BigDecimal)map.get("quantityOnHandTotal"):BigDecimal.ZERO;
        					inventory=(new BigDecimal(inventory).subtract(invBg)).toString();
        				}
        				Map pMap=FastMap.newInstance();
        				pMap.put("facilityId", fgv.get("facilityId"));
        				pMap.put("productId", productIdArray[p]);
        				pMap.put("purchaseOrderId", "");
        				pMap.put("ownerPartyId", "Company");
        				pMap.put("inventoryItemTypeId", "NON_SERIAL_INV_ITEM");
        				pMap.put("quantityRejected", "0");
        				pMap.put("unitCost", "0");
        				pMap.put("quantityAccepted", inventory);
        				pMap.put("userLogin", userLogin);
        				dispatcher.runSync("receiveInventoryProduct", pMap);
        			}
        		}
        	}
        	message="操作成功";
        }catch(Exception e){
	    	message="操作失败";
        }
        request.setAttribute("message", message);
        return "success";
	}
	

	
}	
