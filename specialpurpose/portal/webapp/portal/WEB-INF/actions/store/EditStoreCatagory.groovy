
import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;
import org.ofbiz.product.catalog.*;
import org.ofbiz.product.category.*;

println "----------------------------------------------------------"

if(userLogin){
	condList = FastList.newInstance();
	condList.add(EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, userLogin.partyId));
	condList.add(EntityCondition.makeCondition("roleTypeId", EntityOperator.EQUALS, "OWNER"));
	rolesCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
	productStoreRoleList = delegator.findList("ProductStoreRole", rolesCond, null, ["-sequenceNum"], null, false);
	println "-------------------------------------------" + productStoreRoleList
	productStoreRoleList = EntityUtil.filterByDate(productStoreRoleList);
	if(UtilValidate.isNotEmpty(productStoreRoleList)){
		productStoreRole = EntityUtil.getFirst(productStoreRoleList);
		context.productStoreId = productStoreRole.productStoreId;

        productStoreId = productStoreRole.productStoreId;
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
    }
}