import org.ofbiz.order.order.OrderReadHelper;
import org.ofbiz.party.contact.*

orderId = parameters.orderId;

if(orderId){
	orderReadHelper = new OrderReadHelper(delegator,orderId);
	productStore = orderReadHelper.getProductStore();
	facilityId = productStore.inventoryFacilityId;
	context.contactMeches = ContactMechWorker.getFacilityContactMechValueMaps(delegator, facilityId, false, null);
}
