import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.product.store.ProductStoreWorker;

import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;
import org.ofbiz.product.catalog.*;
import org.ofbiz.product.category.*;


shoppingCartHistoryList = delegator.findByAnd("ShoppingCartHistoryGoods", [partyId : userLogin.partyId], null, false);

if(shoppingCartHistoryList){
	context.shoppingCartHistoryList=shoppingCartHistoryList;
}

println  "11111"+context.shoppingCartHistoryList;




