import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.order.shoppingcart.*;
import java.util.List;
import java.util.ArrayList;
import org.ofbiz.base.util.UtilMisc;
import javolution.util.FastList;

cart = ShoppingCartEvents.getCartObject(request);
userLogin = session.getAttribute("userLogin");
productNum = parameters.productNum;
productName = parameters.productName;
List<EntityExpr> exprs = FastList.newInstance();
if(productNum){
	productNum=productNum.toString();
	exprs.add(EntityCondition.makeCondition("productId", EntityOperator.EQUALS, productNum));
}
if(productName){
	exprs.add(EntityCondition.makeCondition("productName", EntityOperator.LIKE, "%"+productName+"%"));
}
exprs.add(EntityCondition.makeCondition("primaryProductStoreId", EntityOperator.EQUALS, context.productStoreId));
productList = delegator.findList("Product", EntityCondition.makeCondition(exprs, EntityOperator.AND), null, null, null, false);
context.productList = productList;
println(context.productStoreId+"********************************************************************************************");
/**
cart = ShoppingCartEvents.getCartObject(request);
userLogin = session.getAttribute("userLogin");
def productMap=[:];
def products=[];
//TODO 查询某个店铺下的所有商品
productList = delegator.findList("Product", EntityCondition.makeCondition("createdByUserLogin", EntityOperator.EQUALS, userLogin.userLoginId), null, null, null, false);

for (product in productList) {
	priceContext = [product : product, currencyUomId : cart.getCurrency(),
                partyId : cart.getPartyId(), userLogin : userLogin];
	priceMap = dispatcher.runSync("calculatePurchasePrice", priceContext);
	println priceMap;
	productMap.product=product;
	productMap.price=priceMap;
	products.add(productMap);
}
context.productList = products;



**/