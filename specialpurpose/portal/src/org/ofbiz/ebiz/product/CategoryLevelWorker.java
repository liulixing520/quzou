package org.ofbiz.ebiz.product;

import java.util.List;

import javax.servlet.ServletRequest;

import javolution.util.FastList;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.base.util.cache.UtilCache;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.product.catalog.CatalogWorker;
import org.ofbiz.product.catalog.EbizCatalogWorker;
import org.ofbiz.product.category.CategoryWorker;


public class CategoryLevelWorker{
	
	private static String module = CategoryLevelWorker.class.getName();
	
	private static final UtilCache<String, Object> categoryLevelCache = UtilCache.createUtilCache("CategoryLevelWorker", 0, 0);
	
	public static int getCatLevel(ServletRequest request,String productCategoryId){
		if(categoryLevelCache.containsKey(productCategoryId)){
			ProductCategoryWithLevel prodCatWithLevel = (ProductCategoryWithLevel)categoryLevelCache.get(productCategoryId);
			return prodCatWithLevel.getCatLevel();
		}
		return getCatLevel(request,null,productCategoryId);
	}
	
	public static ProductCategoryWithLevel getProductCategoryWithLevel(ServletRequest request,String productCategoryId){
		if(categoryLevelCache.containsKey(productCategoryId)){
			ProductCategoryWithLevel prodCatWithLevel = (ProductCategoryWithLevel)categoryLevelCache.get(productCategoryId);
			return prodCatWithLevel;
		}
		return null;
	}
	
	/**
	 * 得到分类的级
	 * @param request
	 * @param currentCatalogId
	 * @param productCategoryId
	 * @return
	 */
	public static int getCatLevel(ServletRequest request,String currentCatalogId,String productCategoryId){
		if(UtilValidate.isEmpty(currentCatalogId)){
			currentCatalogId = EbizCatalogWorker.getNavMenuCatalogId(request);
		}
		String topCategoryId = getCatalogTopCategoryId(request,currentCatalogId);
		List<ProductCategoryWithLevel> categories = getTopCategoryWithLevelList(request,topCategoryId);
		int catLevel =3;
		for (ProductCategoryWithLevel prodCatWithLevel: categories) {
			categoryLevelCache.put(prodCatWithLevel.getProductCategory().getString("productCategoryId"), prodCatWithLevel);
			if(prodCatWithLevel.equalsProductCategory(productCategoryId)){
				catLevel = prodCatWithLevel.getCatLevel();
			}
		}
		return catLevel;
	}
	
	/**
	 * 
	 * @param request
	 * @param currentCatalogId
	 * @param productCategoryId
	 * @return
	 */
	public static List<ProductCategoryWithLevel> getTopCategoryWithLevelList(ServletRequest request,String topProductCategoryId){
		getRelatedCategoriesRet(request,"topCategoryWithLevelList",0, topProductCategoryId, true, false, true);
		List<ProductCategoryWithLevel> categories = (List<ProductCategoryWithLevel>)request.getAttribute("topCategoryWithLevelList");
		return categories;
	}
	
	public static List<ProductCategoryWithLevel> getTopCategoryWithLevelListFromAttr(ServletRequest request){
		List<ProductCategoryWithLevel> categories = (List<ProductCategoryWithLevel>)request.getAttribute("topCategoryWithLevelList");
		return categories;
	}
	
	/**
	 * 目录下的顶级分类
	 * @param request
	 * @return
	 */
	public static String getCatalogTopCategoryId(ServletRequest request,String currentCatalogId){
		if(UtilValidate.isEmpty(currentCatalogId)){
			currentCatalogId = CatalogWorker.getCurrentCatalogId(request);
		}
		String catalogTopCategoryId = CatalogWorker.getCatalogTopCategoryId(request,currentCatalogId );
		return catalogTopCategoryId;
	}
	
	public static void getRelatedCategories(ServletRequest request, String attributeName,int catLevel, String parentId, boolean limitView) {
        getRelatedCategories(request, attributeName,catLevel, parentId, limitView, false);
    }
	
	public static void getRelatedCategories(ServletRequest request, String attributeName,int catLevel, String parentId, boolean limitView, boolean excludeEmpty) {
        getRelatedCategoriesRet(request, attributeName,catLevel, parentId, limitView, excludeEmpty);


    }
	
	public static void getRelatedCategoriesRet(ServletRequest request, String attributeName,int catLevel, String parentId, boolean limitView, boolean excludeEmpty) {
        getRelatedCategoriesRet(request, attributeName,catLevel, parentId, limitView, excludeEmpty, false);
    }

	/**
	 * 
	 * @param request
	 * @param attributeName
	 * @param catLevel
	 * @param parentId
	 * @param limitView
	 * @param excludeEmpty
	 * @param recursive
	 */
    public static void getRelatedCategoriesRet(ServletRequest request, String attributeName,int catLevel, String parentId, boolean limitView, boolean excludeEmpty, boolean recursive) {
      Delegator delegator = (Delegator) request.getAttribute("delegator");

      List<ProductCategoryWithLevel> categories = getRelatedCategoriesRet(delegator, catLevel, parentId, limitView, excludeEmpty, recursive);
      if (!categories.isEmpty())  request.setAttribute(attributeName, categories);
    }
	
    /**
     * 
     * @param delegator
     * @param catLevel
     * @param parentId
     * @param limitView
     * @param excludeEmpty
     * @param recursive
     * @return
     */
	public static List<ProductCategoryWithLevel> getRelatedCategoriesRet(Delegator delegator, int catLevel, String parentId, boolean limitView, boolean excludeEmpty, boolean recursive) {
        List<ProductCategoryWithLevel> categories = FastList.newInstance();
        GenericValue parentProductCategory = null;
        try {
			parentProductCategory = delegator.findByPrimaryKeyCache("ProductCategory", UtilMisc.toMap("productCategoryId",parentId));
		} catch (GenericEntityException e1) {
			Debug.logWarning(e1.getMessage(), module);
		}
        catLevel++;
        if (Debug.verboseOn()) Debug.logVerbose("[CategoryWorker.getRelatedCategories] ParentID: " + parentId, module);

        List<GenericValue> rollups = null;

        try {
            rollups = delegator.findByAndCache("ProductCategoryRollup",
                        UtilMisc.toMap("parentProductCategoryId", parentId),
                        UtilMisc.toList("sequenceNum"));
            if (limitView) {
                rollups = EntityUtil.filterByDate(rollups, true);
            }
        } catch (GenericEntityException e) {
            Debug.logWarning(e.getMessage(), module);
        }
        if (rollups != null) {
            // Debug.logInfo("Rollup size: " + rollups.size(), module);
            for (GenericValue parent: rollups) {
                // Debug.logInfo("Adding child of: " + parent.getString("parentProductCategoryId"), module);
                GenericValue cv = null;

                try {
                    cv = parent.getRelatedOneCache("CurrentProductCategory");
                } catch (GenericEntityException e) {
                    Debug.logWarning(e.getMessage(), module);
                }
                if (cv != null) {
                    if (excludeEmpty) {
                        if (!CategoryWorker.isCategoryEmpty(cv)) {
                            //Debug.logInfo("Child : " + cv.getString("productCategoryId") + " is not empty.", module);
                            categories.add(new ProductCategoryWithLevel(cv,parentProductCategory,catLevel));
                            if (recursive) {
                                categories.addAll(getRelatedCategoriesRet(delegator, catLevel, cv.getString("productCategoryId"), limitView, excludeEmpty, recursive));
                            }
                        }
                    } else {
                        categories.add(new ProductCategoryWithLevel(cv,parentProductCategory,catLevel));
                        if (recursive) {
                            categories.addAll(getRelatedCategoriesRet(delegator, catLevel, cv.getString("productCategoryId"), limitView, excludeEmpty, recursive));
                        }
                    }
                }
            }
        }
        return categories;
    }
	
	
}