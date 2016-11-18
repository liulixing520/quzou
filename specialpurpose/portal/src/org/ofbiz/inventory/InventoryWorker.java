package org.ofbiz.inventory;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;


public class InventoryWorker {
	public static final String module = InventoryWorker.class.getName();
    public static final String resource = "FacilityUiLabels";
    public static final String resourceError = "FacilityErrorUiLabels";
   
    /**
	 * 根据所传入商品IDS获取商品库存
	 * @param delegator
	 * @param productIds
	 * @return Map<String, Object>
	 * 返回值格式key(productId_facilityId)
	 * value值为MAP map中key有两个   quantityOnHandTotal、availableToPromiseTotal
	 */
	public static  Map<String, Object> getInventoryByProductIds(Delegator delegator, String productIds) {
		Map<String, Object> resultMap =FastMap.newInstance();
		List<EntityExpr> exprs = FastList.newInstance();
		try{
			List<GenericValue>  facilityList = delegator.findList("Facility", null, null, null, null, false);
			List<String> productIdsCond = FastList.newInstance();
			String productIdsArray[]=productIds.split(",");
			for( int i=0;i<productIdsArray.length;i++){
				productIdsCond.add(productIdsArray[i]);
			}
			exprs.add(EntityCondition.makeCondition("productId", EntityOperator.IN, productIdsCond));
			List<GenericValue>  inventoryList = delegator.findList("InventoryItem", EntityCondition.makeCondition(exprs, EntityOperator.AND), null, null, null, false);
			for(GenericValue fgv:  facilityList){
				
					for( int i=0;i<productIdsArray.length;i++){
						BigDecimal quantityOnHandTotal=BigDecimal.ZERO;
						BigDecimal availableToPromiseTotal=BigDecimal.ZERO;
						Map totalMap=FastMap.newInstance();
							for(GenericValue ingv:  inventoryList){
								if(ingv.get("productId").equals(productIdsArray[i])&&ingv.get("facilityId").equals(fgv.get("facilityId"))){
									System.out.println(ingv.getBigDecimal("quantityOnHandTotal").setScale(0, 0));
									quantityOnHandTotal=quantityOnHandTotal.add(ingv.getBigDecimal("quantityOnHandTotal").setScale(0, 0));
									availableToPromiseTotal=availableToPromiseTotal.add(ingv.getBigDecimal("availableToPromiseTotal").setScale(0, 0));
								}
						}
						totalMap.put("quantityOnHandTotal", quantityOnHandTotal);
						totalMap.put("availableToPromiseTotal", availableToPromiseTotal);
					resultMap.put(productIdsArray[i]+"_"+fgv.get("facilityId"), totalMap);
				}
				
			}
		}catch(Exception e){
		e.printStackTrace();
	}
		return resultMap;
	}
	
	/**
	 * 查询店铺的仓库列表-默认web.xml当前店铺
	 * @param request
	 * @return
	 */
	public static   List<GenericValue> getStoreFacility(HttpServletRequest request) {
        HttpSession session = request.getSession();
        ServletContext application = session.getServletContext();
        Delegator delegator = (Delegator) request.getAttribute("delegator");
        GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        DispatchContext disContext=dispatcher.getDispatchContext();
        String message="";
        List<GenericValue> facilityList=FastList.newInstance();
        try{
        	String productStoreId=request.getParameter("productStoreId");
        	if(productStoreId==null||productStoreId.length()==0){
        		productStoreId=ProductStoreWorker.getProductStoreId(request);
        	}
        	facilityList= getStoreFacility(delegator,productStoreId);
        	
        }catch(Exception e){ }
        return facilityList;
	}
	/**
	 * 获取默认仓库id
	 **/
	public static   String getStoreFacilityId(Delegator delegator, String productStoreId) {
		String facilityId="";
		List<GenericValue> list=getStoreFacility(delegator,productStoreId);
		if(UtilValidate.isNotEmpty(list)){
			GenericValue gv=list.get(0);
			facilityId=gv.getString("faclityId");
		}
		 return facilityId; 
	}
	/**
	 * 查询店铺的仓库列表根据所传入店铺ID
	 * @param request
	 * @return
	 */
	public static List<GenericValue> getStoreFacility(Delegator delegator, String productStoreId) {
       
        List<GenericValue> facilityList=FastList.newInstance();
        try{
        	facilityList=delegator.findByAnd("Facility");
        	
        }catch(Exception e){ }
        return facilityList;
	}
}	
