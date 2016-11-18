
import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;

productStoreId = parameters.productStoreId?:request.getAttribute("productStoreId")?:request.getAttribute("optProductStoreId") ;
context.productStoreId = productStoreId;

condList = FastList.newInstance();
condList.add(EntityCondition.makeCondition("productStoreId", EntityOperator.EQUALS, productStoreId));
condList.add(EntityCondition.makeCondition("prodCatalogCategoryTypeId", EntityOperator.EQUALS, "PCCT_BROWSE_ROOT"));
condList.add(EntityCondition.makeCondition("parentProductCategoryId", EntityOperator.EQUALS, "_NA_"));
rolesCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
productStoreCategoryRollupList = delegator.findList("ProductStoreCategoryRollup", rolesCond, null, ["sequenceNum"], null, false);

if(UtilValidate.isNotEmpty(productStoreCategoryRollupList)){
	productStoreCategoryRollupList = EntityUtil.filterByDate(productStoreCategoryRollupList);
}
context.topStoreCategoryList = productStoreCategoryRollupList;