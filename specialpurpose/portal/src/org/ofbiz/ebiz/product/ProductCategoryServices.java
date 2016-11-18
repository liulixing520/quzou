package org.ofbiz.ebiz.product;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javolution.util.FastList;
import javolution.util.FastMap;
import net.sf.json.JSONObject;

import org.apache.commons.collections.MapUtils;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.product.catalog.CatalogWorker;
import org.ofbiz.product.category.CategoryContentWrapper;
import org.ofbiz.product.category.CategoryWorker;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;



public class ProductCategoryServices {
	public static final String  module         = ProductCategoryServices.class.getName();
    public static final String  LABEL_RESOURCE = "ShopMgrUiLabels";
    /**
     * 创建商品分类
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> createProductCategoryTree(DispatchContext dctx, Map<String, ? extends Object> context){
        Delegator delegator = dctx.getDelegator();
        LocalDispatcher dispatcher = dctx.getDispatcher();
        Map result = new HashMap();
        Map<String, Object> productCategoryResult;
        String primaryParentCategoryId = (String) context.get("primaryParentCategoryId");
        String  navTabId = (String) context.get("navTabId");
        String  callbackType = (String) context.get("callbackType");
        String prodCatalogId = (String)context.get("prodCatalogId");
    	String prodCatalogCategoryTypeId = (String)context.get("prodCatalogCategoryTypeId");
    	Long sequenceNum = (Long)context.get("sequenceNum");
        try {
        	Map<String, ? extends Object> contextMap = context;
        	contextMap.remove("navTabId");
        	contextMap.remove("callbackType");
        	contextMap.remove("prodCatalogId");
        	contextMap.remove("prodCatalogCategoryTypeId");
        	contextMap.remove("sequenceNum");
        	productCategoryResult =  dispatcher.runSync("createProductCategory", contextMap);
        } catch (GenericServiceException e) {
            Debug.logError(e, module);
            return ServiceUtil.returnError(e.getMessage());
        }
        if (productCategoryResult == null) {
            String errMsg = ServiceUtil.getErrorMessage(productCategoryResult);
            Debug.logError(errMsg, module);
            return ServiceUtil.returnError(errMsg);
        }
        if (ServiceUtil.isError(productCategoryResult)) {
            String errMsg = ServiceUtil.getErrorMessage(productCategoryResult);
            Debug.logError( errMsg, module);
            return ServiceUtil.returnError(errMsg);
        }
        String productCategoryId = (String) productCategoryResult.get("productCategoryId");
        try {
        	GenericValue prodCatalogCategory = delegator.makeValue("ProdCatalogCategory");
        	prodCatalogCategory.set("productCategoryId",productCategoryId);
        	prodCatalogCategory.set("prodCatalogId",prodCatalogId);
        	prodCatalogCategory.set("prodCatalogCategoryTypeId",prodCatalogCategoryTypeId);
        	prodCatalogCategory.set("fromDate",UtilDateTime.nowTimestamp());
        	prodCatalogCategory.set("sequenceNum",sequenceNum);
        	prodCatalogCategory.create();
	        if(UtilValidate.isNotEmpty(primaryParentCategoryId)){
	            GenericValue productCategoryRollup = delegator.makeValue("ProductCategoryRollup");
	            productCategoryRollup.set("productCategoryId",productCategoryId);
	            productCategoryRollup.set("parentProductCategoryId",primaryParentCategoryId);
	            productCategoryRollup.set("fromDate",UtilDateTime.nowTimestamp());
	            productCategoryRollup.create();
	        }
        }catch (GenericEntityException e) {
        	String errMsg = "Error creating new virtual product from variant products: " + e.toString();
        	Debug.logError(e, errMsg, module);
        	
        }
        result.put("navTabId",navTabId);
        result.put("callbackType",callbackType);
        return result;
    }
    /**
     * 编辑商品分类
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> updateProductCategoryTree(DispatchContext dctx, Map<String, ? extends Object> context){
    	Delegator delegator = dctx.getDelegator();
    	LocalDispatcher dispatcher = dctx.getDispatcher();
    	Map result = new HashMap();
    	String primaryParentCategoryId = (String) context.get("primaryParentCategoryId");
    	String productCategoryId = (String) context.get("productCategoryId");
    	String prodCatalogId = (String) context.get("prodCatalogId");
    	Long sequenceNum = (Long) context.get("sequenceNum");
    	try {
    		GenericValue gv = delegator.findByPrimaryKey("ProductCategory", UtilMisc.toMap("productCategoryId", productCategoryId));
    		if(UtilValidate.isNotEmpty(primaryParentCategoryId)){
    			List productCategoryRollupList = EntityUtil.filterByDate(delegator.findByAnd("ProductCategoryRollup", UtilMisc.toMap("productCategoryId", productCategoryId,"parentProductCategoryId",primaryParentCategoryId)));
    			if(UtilValidate.isEmpty(productCategoryRollupList)){
        			GenericValue productCategoryRollup = delegator.makeValue("ProductCategoryRollup");
        			productCategoryRollup.set("productCategoryId",productCategoryId);
        			productCategoryRollup.set("parentProductCategoryId",primaryParentCategoryId);
        			productCategoryRollup.set("fromDate",UtilDateTime.nowTimestamp());
        			productCategoryRollup.create();
        		}
    		}else{
    			List<GenericValue>  productCategoryRollups = EntityUtil.filterByDate(delegator.findByAnd("ProductCategoryRollup", UtilMisc.toMap("productCategoryId", productCategoryId,"parentProductCategoryId",gv.getString("primaryParentCategoryId"))));
    			for (GenericValue productCategoryRollup : productCategoryRollups) {
    				productCategoryRollup.set("thruDate", UtilDateTime.nowTimestamp());
    				productCategoryRollup.store();
    	        }
    		}
    		gv.setNonPKFields(context);
    		gv.store();
    		
    		List<GenericValue>  prodCatalogCategorys = EntityUtil.filterByDate(delegator.findByAnd("ProdCatalogCategory", UtilMisc.toMap("productCategoryId", productCategoryId,"prodCatalogId",prodCatalogId)));
			for (GenericValue prodCatalogCategory : prodCatalogCategorys) {
				prodCatalogCategory.set("sequenceNum",sequenceNum);
				prodCatalogCategory.store();
	        }
    		
    	}catch (GenericEntityException e) {
    		String errMsg = "Error creating new virtual product from variant products: " + e.toString();
    		Debug.logError(e, errMsg, module);
    	}
        return result;
    }
    // Please note : the structure of map in this function is according to the JSON data map of the jsTree
    @SuppressWarnings("unchecked")
    public static void getChildCategoryTree(HttpServletRequest request, HttpServletResponse response){
        Delegator delegator = (Delegator) request.getAttribute("delegator");
        String productCategoryId = request.getParameter("productCategoryId");
        String isCatalog = request.getParameter("isCatalog");
        String isCategoryType = request.getParameter("isCategoryType");
        String entityName = null;
        String primaryKeyName = null;
        
        if (isCatalog.equals("true")) {
            entityName = "ProdCatalog";
            primaryKeyName = "prodCatalogId";
        } else {
            entityName = "ProductCategory";
            primaryKeyName = "productCategoryId";
        }
        
        List categoryList = FastList.newInstance();
        List<GenericValue> childOfCats;
        List<String> sortList = org.ofbiz.base.util.UtilMisc.toList("sequenceNum", "id");
        
        try {
            GenericValue category = delegator.findByPrimaryKey(entityName ,UtilMisc.toMap(primaryKeyName, productCategoryId));
            if (UtilValidate.isNotEmpty(category)) {
                if (isCatalog.equals("true") && isCategoryType.equals("false")) {
                    CategoryWorker.getRelatedCategories(request, "ChildCatalogList", CatalogWorker.getCatalogTopCategoryId(request, productCategoryId), true);
                    childOfCats = EntityUtil.filterByDate((List<GenericValue>) request.getAttribute("ChildCatalogList"));
                    
                } else if(isCatalog.equals("false") && isCategoryType.equals("false")){
                    childOfCats = EntityUtil.filterByDate(delegator.findByAnd("ProductCategoryRollupAndChild", UtilMisc.toMap(
                            "parentProductCategoryId", productCategoryId )));
                } else {
                    childOfCats = EntityUtil.filterByDate(delegator.findByAnd("ProdCatalogCategory", UtilMisc.toMap("prodCatalogId", productCategoryId)));
                }
                if (UtilValidate.isNotEmpty(childOfCats)) {
                	
                    for (GenericValue childOfCat : childOfCats ) {
                        
                        Object catId = null;
                        String catNameField = null;
                        
                        catId = childOfCat.get("productCategoryId");
                        catNameField = "CATEGORY_NAME";
                        
                        Map josonMap = FastMap.newInstance();
                        List<GenericValue> childList = null;
                        
                        // Get the child list of chosen category
                        childList = EntityUtil.filterByDate(delegator.findByAnd("ProductCategoryRollup", UtilMisc.toMap(
                                    "parentProductCategoryId", catId)));
                        
                        // Get the chosen category information for the categoryContentWrapper
                        GenericValue cate = delegator.findByPrimaryKey("ProductCategory" ,UtilMisc.toMap("productCategoryId",catId));
                        
                        // If chosen category's child exists, then put the arrow before category icon
                        if (UtilValidate.isNotEmpty(childList)) {
                            josonMap.put("state", "closed");
                        }
                        Map dataMap = FastMap.newInstance();
                        Map dataAttrMap = FastMap.newInstance();
                        CategoryContentWrapper categoryContentWrapper = new CategoryContentWrapper(cate, request);
                        
                        String title = null;
                        if (UtilValidate.isNotEmpty(categoryContentWrapper.get(catNameField))) {
                            title = categoryContentWrapper.get(catNameField)+" "+"["+catId+"]";
                            dataMap.put("title", title);
                        } else {
                            title = catId.toString();
                            dataMap.put("title", catId);
                        }
                        //dataAttrMap.put("onClick","window.location.href='EditCategory?productCategoryId="+catId+"'; return false;");
                        
                        dataMap.put("attr", dataAttrMap);
                        josonMap.put("data", dataMap);
                        Map attrMap = FastMap.newInstance();
                        attrMap.put("id", catId);
                        attrMap.put("isCatalog", false);
                        attrMap.put("rel", "CATEGORY");
                        josonMap.put("attr",attrMap);
                        josonMap.put("sequenceNum",childOfCat.get("sequenceNum"));
                        josonMap.put("title",title);
                        
                        categoryList.add(josonMap);
                    }
                    List<Map<Object, Object>> sortedCategoryList = UtilMisc.sortMaps(categoryList, sortList);
                    toJsonObjectList(sortedCategoryList,response);
                }
            }
        } catch (GenericEntityException e) {
            e.printStackTrace();
        }
    }
    @SuppressWarnings("unchecked")
    public static void toJsonObjectList(List attrList, HttpServletResponse response){
        String jsonStr = "[";
        for (Object attrMap : attrList) {
            JSONObject json = JSONObject.fromObject(attrMap);
            jsonStr = jsonStr + json.toString() + ',';
        }
        jsonStr = jsonStr + "{ } ]";
        if (UtilValidate.isEmpty(jsonStr)) {
            Debug.logError("JSON Object was empty; fatal error!",module);
        }
        // set the X-JSON content type
        response.setContentType("application/json");
        // jsonStr.length is not reliable for unicode characters
        try {
            response.setContentLength(jsonStr.getBytes("UTF8").length);
        } catch (UnsupportedEncodingException e) {
            Debug.logError("Problems with Json encoding",module);
        }
        // return the JSON String
        Writer out;
        try {
            out = response.getWriter();
            out.write(jsonStr);
            out.flush();
        } catch (IOException e) {
            Debug.logError("Unable to get response writer",module);
        }
    }
    /**
     * 删除商品品牌
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> deleteProductCategoryTree(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
        Delegator delegator = dctx.getDelegator();
        Map result = ServiceUtil.returnSuccess();
        String productCategoryId = (String) context.get("productCategoryId");
        String prodCatalogCategoryTypeId = (String) context.get("prodCatalogCategoryTypeId");
    	String prodCatalogId = (String) context.get("prodCatalogId");
    	Timestamp fromDate = (Timestamp) context.get("fromDate");
        GenericValue gv = delegator.findByPrimaryKey("ProdCatalogCategory", UtilMisc.toMap("productCategoryId", productCategoryId,"prodCatalogCategoryTypeId",prodCatalogCategoryTypeId,"prodCatalogId",prodCatalogId,"fromDate",fromDate));
        if(UtilValidate.isDateBeforeNow(gv.getTimestamp("thruDate"))){
        	gv.set("thruDate",null);
        }else{
        	gv.set("thruDate",UtilDateTime.nowTimestamp());
        }
        if (UtilValidate.isNotEmpty(gv)) {
        	gv.store();
        }
        return result;
    }
    /**
     * 批量匹配分类和特征
     * @param request
     * @param response
     * @return
     */
	public static String setProductFeatureCategoryApplMutil(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
		Locale locale = UtilHttp.getLocale(request);
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		Map<String, Object> context = UtilHttp.getParameterMap(request);
		String productCategoryId=(String)context.get("productCategoryId");
		List productFeatureList=FastList.newInstance(); 
		if(context.get("productFeatureId")instanceof String){
			productFeatureList.add(context.get("productFeatureId"));
		}else{
			productFeatureList=(List)context.get("productFeatureId");
		}
		try {
				delegator.removeByAnd("ProductFeatureCategoryAppl", UtilMisc.toMap("productCategoryId",productCategoryId));
				for(int i=0;i<productFeatureList.size();i++){
				 	GenericValue productFeatureCategoryAppl = delegator.makeValue("ProductFeatureCategoryAppl");
				 	productFeatureCategoryAppl.set("productCategoryId",productCategoryId);
				 	productFeatureCategoryAppl.set("productFeatureCategoryId",productFeatureList.get(i));
				 	productFeatureCategoryAppl.set("fromDate",UtilDateTime.nowTimestamp());
				 	productFeatureCategoryAppl.create();
				}
			return "success";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "error";
	}
	/**
	 * 批量匹配分类和属性组
	 * @param request
	 * @param response
	 * @return
	 */
	public static String setCategoryRefAttributeGroupMutil(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
		Locale locale = UtilHttp.getLocale(request);
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		Map<String, Object> context = UtilHttp.getParameterMap(request);
		String productCategoryId=(String)context.get("productCategoryId");
		List attributeGroupList=FastList.newInstance(); 
		attributeGroupList.add(context.get("attributeGroupId"));
		try {
			delegator.removeByAnd("CategoryRefAttributeGroup", UtilMisc.toMap("productCategoryId",productCategoryId));
			for(int i=0;i<attributeGroupList.size();i++){
				GenericValue categoryRefAttributeGroup = delegator.makeValue("CategoryRefAttributeGroup");
				categoryRefAttributeGroup.set("productCategoryId",productCategoryId);
				categoryRefAttributeGroup.set("attributeGroupId",attributeGroupList.get(i));
				categoryRefAttributeGroup.create();
			}
			return "success";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "error";
	}
	/**
	 * 批量匹配分类和属性
	 * @param request
	 * @param response
	 * @return
	 */
	public static String setCategoryRefTypeAttributeMutil(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
		Locale locale = UtilHttp.getLocale(request);
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		Map<String, Object> context = UtilHttp.getParameterMap(request);
		String productCategoryId=(String)context.get("productCategoryId");
		List attributeList=FastList.newInstance(); 
		if(context.get("attributeId")instanceof String){
			attributeList.add(context.get("attributeId"));
		}else{
			attributeList=(List)context.get("attributeId");
		}
		try {
			delegator.removeByAnd("CategoryRefTypeAttribute", UtilMisc.toMap("productCategoryId",productCategoryId));
			for(int i=0;i<attributeList.size();i++){
				GenericValue categoryRefAttribute = delegator.makeValue("CategoryRefTypeAttribute");
				categoryRefAttribute.set("productCategoryId",productCategoryId);
				categoryRefAttribute.set("attributeId",attributeList.get(i));
				categoryRefAttribute.create();
			}
			return "success";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "error";
	}
}
