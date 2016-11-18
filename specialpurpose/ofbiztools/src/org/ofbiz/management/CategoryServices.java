package org.ofbiz.management;

import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilGenerics;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.ServiceUtil;

public class CategoryServices {

	public static final String module = CategoryServices.class.getName();
	public static final String resource = "ManagementUiLabels";

	public static List getAllEcommerceCategoryList(String prodCatalogId, Map<String, Object> context) {
        List categoryList = FastList.newInstance();
        if (UtilValidate.isNotEmpty(prodCatalogId)) {
        	Delegator delegator = (Delegator) context.get("delegator");
            try {
            	List<String> orderBy = UtilMisc.toList("sequenceId");
    			List<GenericValue> categoryyRollupList = delegator.findByAnd("ProdCatalogCategoryAndSeq", UtilMisc.toMap("prodCatalogId",prodCatalogId), orderBy, true);
    			for (GenericValue categoryRollup : categoryyRollupList) {
    				GenericValue category = delegator.findOne("ProductCategory", UtilMisc.toMap("productCategoryId", categoryRollup.getString("productCategoryId")), true);
    				Map<String, Object> map = FastMap.newInstance();
    				map.put("productCategoryId", category.getString("productCategoryId"));
    				map.put("categoryName", category.getString("categoryName"));
    				// 计算他的下级。放入集合中，然后递归查找下级的下级
    				map.put("childList", getChildCategory(category.getString("productCategoryId"), delegator));
    				categoryList.add(map);

    			}
                
            } catch (GenericEntityException e) {
                Debug.logError("Could not retrieve portalpages:" + e.getMessage(), module);
            }
        }
        return categoryList;
    }
	/**
	 * 获取全部分类，放置到一个集合中
	 */
	/**
	public static Map<String, Object> getAllEcommerceCategory(DispatchContext dctx, Map<String, ? extends Object> context) {
		Delegator delegator = dctx.getDelegator();
		String prodCatalogId = (String) context.get("prodCatalogId");
		List<Map<String, Object>> mapList = FastList.newInstance();
		Map<String, Object> result = ServiceUtil.returnSuccess();
		try {
			List<String> orderBy = UtilMisc.toList("sequenceId");
			List<GenericValue> categoryyRollupList = delegator.findByAnd("ProdCatalogCategoryAndSeq", UtilMisc.toMap("prodCatalogId",prodCatalogId), orderBy, true);
			for (GenericValue categoryRollup : categoryyRollupList) {
				GenericValue category = delegator.findOne("ProductCategory", UtilMisc.toMap("productCategoryId", categoryRollup.getString("productCategoryId")), true);
				Map<String, Object> map = FastMap.newInstance();
				map.put("productCategoryId", category.getString("productCategoryId"));
				map.put("categoryName", category.getString("categoryName"));
				// 计算他的下级。放入集合中，然后递归查找下级的下级
				map.put("childList", getChildCategory(category.getString("productCategoryId"), delegator));
				mapList.add(map);

			}
			result.put("categoryList", mapList);
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
		}
		return result;
	}
*/
	public static List<Map<String, Object>> getChildCategory(String productCategoryId, Delegator delegator) throws GenericEntityException {
		List<Map<String, Object>> mapList = FastList.newInstance();
		List<String> orderBy = UtilMisc.toList("sequenceId");
		List<GenericValue> categoryList = delegator.findByAnd("ProductCategoryRollupAndChild", UtilMisc.toMap("parentProductCategoryId", productCategoryId), orderBy, true);
		for (GenericValue category : categoryList) {
			Map<String, Object> map = FastMap.newInstance();
			map.put("productCategoryId", category.getString("productCategoryId"));
			map.put("categoryName", category.getString("categoryName"));
			// 计算他的下级。放入集合中，然后递归查找下级的下级
			map.put("childList", getChildCategory(category.getString("productCategoryId"), delegator));
			map.put("primaryParentCategoryId", category.getString("primaryParentCategoryId"));
			mapList.add(map);

		}
		return mapList;
	}

	public static <T> List<T> getFieldListFromList(List<Map<String, Object>> list, String fieldName, boolean distinct) {
		if (list == null || fieldName == null) {
			return null;
		}
		List<T> fieldList = new LinkedList<T>();
		Set<T> distinctSet = null;
		if (distinct) {
			distinctSet = new HashSet<T>();
		}

		for (Map<String, Object> value : list) {
			T fieldValue = UtilGenerics.<T> cast(value.get(fieldName));
			if (fieldValue != null) {
				if (distinct) {
					if (!distinctSet.contains(fieldValue)) {
						fieldList.add(fieldValue);
						distinctSet.add(fieldValue);
					}
				} else {
					fieldList.add(fieldValue);
				}
			}
		}

		return fieldList;
	}

}
