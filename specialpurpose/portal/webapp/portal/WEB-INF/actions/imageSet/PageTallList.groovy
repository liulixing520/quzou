
import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.EntityFindOptions;
import java.util.List;


if(userLogin){
	    
/*	condList = FastList.newInstance();
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
        println "--------------------------------------productStoreBrandList="+productStoreBrandList;*/
	
        condList = FastList.newInstance();
        condList.add(EntityCondition.makeCondition("status", EntityOperator.EQUALS, "0"));
        println "             parameters.gradingType ======  "+parameters.gradingType;
        if(parameters.gradingType&&parameters.gradingType!="0"){
        	condList.add(EntityCondition.makeCondition("gradingType",EntityOperator.EQUALS,parameters.gradingType));
        }
	    if(parameters.advertisingName!=null){
	    	condList.add(EntityCondition.makeCondition("advertisingName", EntityOperator.LIKE,"%"+parameters.advertisingName+"%"));
	    }
        List<String> orderBy = UtilMisc.toList("-lastUpdatedStamp");
	    pagesetterCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
	    PageSetterList = delegator.findList("PageSetting", pagesetterCond, null,orderBy, null, false);
	    
	    context.PageSetterList = PageSetterList;
	    println context.PageSetterList;
	    
	    
	    condMessageList = FastList.newInstance();
	    condMessageList.add(EntityCondition.makeCondition("status",EntityOperator.EQUALS,"0"));
	    if(parameters.messageTitle){
	    	condMessageList.add(EntityCondition.makeCondition("messageTitle", EntityOperator.LIKE,"%"+parameters.messageTitle+"%"));
	    }
        List<String> orderByForMessage = UtilMisc.toList("-lastUpdatedStamp");
	    messageCond = EntityCondition.makeCondition(condMessageList, EntityOperator.AND);
	    MessageSetList = delegator.findList("MessageSet", messageCond, null,orderByForMessage, null, false);
	    context.MessageSetList = MessageSetList;
	    println context.MessageSetList;
	    
}