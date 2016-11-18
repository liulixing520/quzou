import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;

if (userLogin) {
	partyId2=parameters.partyId?:null;
    condList = FastList.newInstance();
    condList.add(EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, partyId2));
    condList.add(EntityCondition.makeCondition("roleTypeId", EntityOperator.EQUALS, "OWNER"));
    rolesCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
    productStoreRoleList = delegator.findList("ProductStoreRole", rolesCond, null, ["-sequenceNum"], null, false);

    productStoreRoleList = EntityUtil.filterByDate(productStoreRoleList);
    
    productStoreRole=null;
    if (UtilValidate.isNotEmpty(productStoreRoleList)) {
        productStoreRole = EntityUtil.getFirst(productStoreRoleList);
        context.productStoreId = productStoreRole.productStoreId;
        productStore = delegator.findOne("ProductStore", [productStoreId : productStoreRole.productStoreId], false)
		productStoreCompany=delegator.findOne("ProductStoreCompany", [productStoreId : productStoreRole.productStoreId], false)
        context.productStore = productStore;
    }
    if(productStoreRole){
    	ProductStoreCompany = delegator.findOne("ProductStoreCompany",[productStoreId: productStoreRole.productStoreId], false);
    	context.ProductStoreCompany = ProductStoreCompany;				
    }
    println "---------------------------------context.ProductStoreCompany="+context.ProductStoreCompany+"   productStoreRole==="+productStoreRole;
    
}