import org.ofbiz.entity.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import org.ofbiz.party.contact.*;
import org.ofbiz.base.util.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.inventory.*;
import java.util.List;
productIds = parameters.get("productIds");
System.out.println("**********"+productIds);
List<String> productIdsCond = FastList.newInstance();
productIdsArray=productIds.split(",");
for( int i=0;i<productIdsArray.length;i++){
	productIdsCond.add(productIdsArray[i]);
}
List<EntityExpr> exprs = FastList.newInstance();
exprs.add(EntityCondition.makeCondition("productId", EntityOperator.IN, productIdsCond));

productList=delegator.findList("Product", EntityCondition.makeCondition(exprs, EntityOperator.AND), null, null, null, false);
context.productList=productList;
//各库存实际库存和承诺总数
context.productInventoryMap=InventoryWorker.getInventoryByProductIds(delegator,productIds);
//request.setAttribute("postalAddressView",contactMeches);

