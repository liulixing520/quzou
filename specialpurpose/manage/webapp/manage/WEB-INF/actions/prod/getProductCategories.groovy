	import org.ofbiz.entity.util.EntityUtil;
	import org.ofbiz.entity.condition.*;
	
	productCategories = []		
	productCategorys = delegator.findByAnd("ProdCatalogCategory",["prodCatalogId":"ProductType"],null,false)
	if(productCategorys){
		productCategoryIds = org.ofbiz.entity.util.EntityUtil.getFieldListFromEntityList(productCategorys, "productCategoryId", true)
		productCategories = delegator.findList("ProductCategory",EntityCondition.makeCondition("productCategoryId",EntityOperator.IN,productCategoryIds),null,null,null,false)
	}
	context.productCategories=productCategories