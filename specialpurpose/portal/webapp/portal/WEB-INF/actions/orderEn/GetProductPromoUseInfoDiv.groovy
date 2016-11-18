import org.ofbiz.order.shoppingcart.shipping.*;
import org.ofbiz.order.shoppingcart.ShoppingCartEvents;

shoppingCart = session.getAttribute("shoppingCart");
if (shoppingCart) {
	context.shoppingCart = shoppingCart;
}