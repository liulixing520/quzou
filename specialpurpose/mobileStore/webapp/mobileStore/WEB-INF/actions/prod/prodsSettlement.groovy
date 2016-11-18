import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.product.catalog.CatalogWorker;
import org.ofbiz.order.shoppingcart.product.ProductDisplayWorker;
import org.ofbiz.order.shoppingcart.MultiShoppingCartEvents;
import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.party.contact.ContactHelper;

Locale locale=org.ofbiz.base.util.UtilHttp.getLocale(session)
orderFrom = session.getAttribute("orderFrom")
totalPrice = BigDecimal.ZERO
totalShip = BigDecimal.ZERO
grandTotal = BigDecimal.ZERO
try{
if(orderFrom=='QUICK_ORDER'){
	cart = session.getAttribute("quickOrderCart")
	if(cart){
		totalPrice = cart.getSubTotal();
		grandTotal = cart.getGrandTotal();
		totalShip = cart.getTotalShipping();
	}
}else{
	shoppingCartMap = MultiShoppingCartEvents.getCartMap(request)
	if(shoppingCartMap){
		totalPrice = shoppingCartMap.getDisplaySubTotal()
		totalShip =  shoppingCartMap.getTotalShipping()
        grandTotal = shoppingCartMap.getGrandTotal() 
	}
}
}catch(Exception e){}
party = userLogin.getRelatedOne("Party", false)
shippingContactMechList = ContactHelper.getContactMech(party, "SHIPPING_LOCATION", "POSTAL_ADDRESS", false);
context.defaultContactMech = shippingContactMechList[0]
if(shippingContactMechList.size()>0){
	defaultContactMechId = session.getAttribute("defaultContactMechId")
	if(defaultContactMechId){
	 	shippingContactMechList = EntityUtil.filterByAnd(shippingContactMechList, ["contactMechId":defaultContactMechId])
	 	if(shippingContactMechList.size()>0){
	 		context.defaultContactMech = shippingContactMechList[0]
	 	}
 	}
}
context.totalPrice = totalPrice
context.totalShip = totalShip
context.grandTotal = grandTotal
