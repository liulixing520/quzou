import org.ofbiz.order.order.OrderReadHelper;
import org.ofbiz.party.contact.*
import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;
	/*
	orderReadHelper = new OrderReadHelper(delegator,orderId);
	productStore = orderReadHelper.getProductStore();
	facilityId = productStore.inventoryFacilityId;
	context.contactMeches = ContactMechWorker.getFacilityContactMechValueMaps(delegator, facilityId, false, null);
	
	productStore = delegator.findOne("ProductStore", [payToPartyId : parameters.partyId], false)
	facilityId = productStore.inventoryFacilityId;
	println  "-----------facilityId------"+facilityId
	*/
	
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
    		productStoreCompany=delegator.findOne("ProductStoreCompany", [productStoreId : productStoreRole.productStoreId], false)
            context.productStore = productStore;
            context.productStoreCompany = productStoreCompany
         context.facilityId = productStore.inventoryFacilityId;
         parameters.facilityId=productStore.inventoryFacilityId;
        }
    }else{
    	context.productStoreId = parameters.productStoreId;
    }
    
    
	
	