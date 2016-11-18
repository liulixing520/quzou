
import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;
import org.ofbiz.product.catalog.*;
import org.ofbiz.product.category.*;

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
        productStore = delegator.findOne("ProductStore", [productStoreId : productStoreRole.productStoreId], false)
        context.productStore = productStore;
        println "---------------------------------" + context.productStoreId
    }
}else{
	context.productStoreId = parameters.productStoreId;
}

if(userLogin){
/*	  condList = FastList.newInstance();
	    condList.add(EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, userLogin.partyId));
	    condList.add(EntityCondition.makeCondition("roleTypeId", EntityOperator.EQUALS, "OWNER"));
	    rolesCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
	    productStoreRoleList = delegator.findList("ProductStoreRole", rolesCond, null, ["-sequenceNum"], null, false);

	    productStoreRoleList = EntityUtil.filterByDate(productStoreRoleList);
	    if (UtilValidate.isNotEmpty(productStoreRoleList)) {
	        productStoreRole = EntityUtil.getFirst(productStoreRoleList);
	        context.productStoreId = productStoreRole.productStoreId;
	        productStore = delegator.findOne("ProductStore", [productStoreId : productStoreRole.productStoreId], false)
	        context.productStore = productStore;
	        println "---------------------------------" + context.productStoreId
	        
	        condList = FastList.newInstance();
	        condList.add(EntityCondition.makeCondition("productStoreId", EntityOperator.EQUALS, context.productStoreId));
	        condList.add(EntityCondition.makeCondition("status", EntityOperator.EQUALS, "0"));
	        if(parameters.brandName){
		        condList.add(EntityCondition.makeCondition("brandName", EntityOperator.LIKE,"%"+parameters.brandName+"%"));
		        context.brandName=parameters.brandName;
	        }
	        brandCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
	        productStoreBrandList = delegator.findList("ProductStoreBrand", brandCond, null,null, null, false);
	        context.productStoreBrandList = productStoreBrandList;
	        println "--------------------------------------productStoreBrandList="+productStoreBrandList;
	    }*/
	    productStoreId2=context.productStoreId;
	    condList = FastList.newInstance();
	    condList.add(EntityCondition.makeCondition("primaryProductStoreId", EntityOperator.EQUALS, productStoreId2));
	    brandCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
	    mySalseVolumeGoods = delegator.findList("SalesVolumeGoods", brandCond, null,null, null, false);
	    if(mySalseVolumeGoods){
	    	birtParameters = [:];
	    	birtParameters.mySalseVolumeGoods=mySalseVolumeGoods;
	    	request.setAttribute("birtParameters", birtParameters);
	    }
	    
	    return "success";
}