import org.ofbiz.order.shoppingcart.shipping.*;
import org.ofbiz.order.shoppingcart.ShoppingCartEvents;

shoppingCart = session.getAttribute("shoppingCart");
shippingEstWpr = null;
if (shoppingCart) {
	context.shoppingCart = shoppingCart;
	shippingEstWpr = new ShippingEstimateWrapper(dispatcher, shoppingCart, 0);
	context.shippingEstWpr = shippingEstWpr;
	context.carrierShipmentMethodList = shippingEstWpr.getShippingMethods();
}