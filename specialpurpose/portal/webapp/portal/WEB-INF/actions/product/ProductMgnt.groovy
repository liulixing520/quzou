import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.order.shoppingcart.*;

cart = ShoppingCartEvents.getCartObject(request);
userLogin = session.getAttribute("userLogin");

//TODO 查询某个店铺下的所有商品
productList = delegator.findList("Product", EntityCondition.makeCondition("createdByUserLogin", EntityOperator.EQUALS, userLogin.userLoginId), null, null, null, false);

for (product in productList) {
	priceContext = [product : product, currencyUomId : cart.getCurrency(),
                partyId : cart.getPartyId(), userLogin : userLogin];
	priceMap = dispatcher.runSync("calculatePurchasePrice", priceContext);
}

context.productList = productList;
