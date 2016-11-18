import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;


if (userLogin) {
	context.productStoreId = parameters.productStoreId;
    condList = FastList.newInstance();
    condList.add(EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, userLogin.partyId));
    condList.add(EntityCondition.makeCondition("roleTypeId", EntityOperator.EQUALS, "OWNER"));
    rolesCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
    productStoreRoleList = delegator.findList("ProductStoreRole", rolesCond, null, ["-sequenceNum"], null, false);
    productStoreRoleList = EntityUtil.filterByDate(productStoreRoleList);
    if (UtilValidate.isNotEmpty(productStoreRoleList)) {
        productStoreRole = EntityUtil.getFirst(productStoreRoleList);
        pid=parameters.productStoreId;
        if(pid){
        	productStoreRole.productStoreId=pid;
        }else{
        	parameters.productStoreId=productStoreRole.productStoreId;
        }
        context.productStoreId = productStoreRole.productStoreId;
    }
}else{
	context.productStoreId = parameters.productStoreId;
}

 	productStore = delegator.findOne("ProductStore", [productStoreId : parameters.productStoreId], false)
	context.productStore = productStore;
