package org.ofbiz.product.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.DelegatorFactory;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityFindOptions;
import org.ofbiz.entity.util.EntityListIterator;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;
import org.ofbiz.webapp.stats.VisitHandler;

import java.util.List;


public class ProductVisitWorker{
	
	private static final String module = ProductVisitWorker.class.getName();
	
	/**
	 * 保存产品访问
	 * @param request
	 * @param productId
	 * @return
	 */
	public static String saveProductVisit(HttpServletRequest request,String productId){
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	    Delegator delegator = (Delegator) request.getAttribute("delegator");
	    
	    HttpSession session = ((HttpServletRequest) request).getSession();
        GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
        
		String visitId = VisitHandler.getVisitId(session);
		GenericValue visitor = VisitHandler.getVisitor(request, null);
		
		Map<String, Object> productVisitCtx = FastMap.newInstance();
		productVisitCtx.put("productId", productId);
		productVisitCtx.put("visitId", visitId);
		if(UtilValidate.isNotEmpty(userLogin)){
			productVisitCtx.put("partyId", userLogin.getString("partyId"));
		}
		if(UtilValidate.isNotEmpty(visitor)){
			productVisitCtx.put("visitorId", visitor.getString("visitorId"));
		}
		productVisitCtx.put("sessionId", session.getId());
		Map<String, Object> result = FastMap.newInstance();
		try {
			productVisitCtx.put("userLogin", delegator.findByPrimaryKey("UserLogin", UtilMisc.toMap("userLoginId", "system")));
			result = dispatcher.runSync("createProductVisit", productVisitCtx);
		}catch (GenericServiceException gse) {
            Debug.logError(gse, module);
            return null;
        } catch (GenericEntityException gee) {
        	Debug.logError(gee, module);
            return null;
		}
		if(ServiceUtil.isSuccess(result)){
			return (String)result.get("productVisitId");
		}else{
			return null;
		}
	}
	
	/**
	 * 更新产品访问
	 * @param request
	 * 登录后调用
	 *  <after-login>
        <event name="updateProductVisit" type="java" path="org.ofbiz.product.product.ProductVisitWorker" invoke="updateProductVisit"/>
        </after-login>
	 */
	public static String updateProductVisit(HttpServletRequest request, HttpServletResponse response){
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	    Delegator delegator = (Delegator) request.getAttribute("delegator");
	    
	    HttpSession session = ((HttpServletRequest) request).getSession();
        GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
        if(UtilValidate.isEmpty(userLogin)){
        	return "success";
        }
        
        GenericValue visitor = VisitHandler.getVisitor(request, null);
        
        EntityCondition cond = EntityCondition.makeCondition(UtilMisc.toList(
                EntityCondition.makeCondition("partyId",EntityOperator.EQUALS,null),
                EntityCondition.makeCondition("visitorId",EntityOperator.EQUALS, visitor.getString("visitorId"))
       ),EntityOperator.AND);
        try {
            delegator.storeByCondition("ProductVisit", UtilMisc.toMap("partyId", userLogin.getString("partyId")), cond);
        } catch (GenericEntityException e) {
            Debug.logError(e, module);
        }
        return "success";
	}
	
	/**
	 * 
	 * @param request
	 * @param inParams
	 * @return Map
	 * 		productIdList
	 */
	public static Map findOtherProductVisit(HttpServletRequest request, Map inParams){
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	    Delegator delegator = (Delegator) request.getAttribute("delegator");
	    
	    HttpSession session = ((HttpServletRequest) request).getSession();
        GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
        
        String excludeProductId = (String)inParams.get("excludeProductId");

        String excludePartyId = (String)inParams.get("excludePartyId");
        if(UtilValidate.isEmpty(excludePartyId) && userLogin!=null){
        	excludePartyId = userLogin.getString("partyId");
        }
        String excludeVistorId = (String)inParams.get("excludeVistorId");
        if(UtilValidate.isEmpty(excludePartyId)){
        	GenericValue visitor = VisitHandler.getVisitor(request, null);
        	if(UtilValidate.isNotEmpty(visitor)){
        		excludeVistorId = visitor.getString("visitorId");
    		}
        }
        
        int defaultViewSize = 10;
        int viewIndex = 0;
        try {
            viewIndex = Integer.valueOf((String) inParams.get("viewIndexString")).intValue();
        } catch (Exception e) {
            viewIndex = 0;
        }

        int viewSize = defaultViewSize;
        try {
            viewSize = Integer.valueOf((String) inParams.get("viewSizeString")).intValue();
        } catch (Exception e) {
            viewSize = defaultViewSize;
        }
        int listSize = 0;
        int lowIndex = 0;
        int highIndex = 0;


        // get the indexes for the partial list
        lowIndex = ((viewIndex * viewSize) + 1);
        highIndex = (viewIndex + 1) * viewSize;

        
        Map result = FastMap.newInstance();
        
        List conds = FastList.newInstance();
        if(UtilValidate.isNotEmpty(excludePartyId)){
        	conds.add(EntityCondition.makeCondition("partyId",EntityOperator.NOT_EQUAL,excludePartyId));
        }
        if(UtilValidate.isNotEmpty(excludeVistorId)){
        	conds.add(EntityCondition.makeCondition("visitorId",EntityOperator.NOT_EQUAL,excludeVistorId));
        }
        if(UtilValidate.isNotEmpty(excludeProductId)){
        	conds.add(EntityCondition.makeCondition("productId",EntityOperator.NOT_EQUAL,excludeProductId));
        }
        EntityCondition cond = EntityCondition.makeCondition(conds,EntityOperator.AND);
        EntityFindOptions findOpts = new EntityFindOptions(true, EntityFindOptions.TYPE_SCROLL_INSENSITIVE, EntityFindOptions.CONCUR_READ_ONLY, true);
        findOpts.setMaxRows(highIndex);
        List<String> orderBy = UtilMisc.toList("-fromDate");
        EntityListIterator pli = null;
        try {
            pli = delegator.find("ProductVisit", cond, null, UtilMisc.toSet("productId"), orderBy, findOpts);
            List<GenericValue> productVisits = pli.getPartialList(lowIndex, viewSize);
            List<String> productIdList = FastList.newInstance();
            for(GenericValue productVisit:productVisits){
            	productIdList.add(productVisit.getString("productId"));
            }
            result.put("productIdList", productIdList);
            listSize = pli.getResultsSizeAfterPartialList();
        } catch (GenericEntityException e) {
            Debug.logError(e, module);
        }finally{
        	try {
				pli.close();
			} catch (GenericEntityException e) {
				Debug.logError(e, module);
			}
        }
        
        return result;
	}
}