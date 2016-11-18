import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.product.store.ProductStoreWorker;

import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;
import org.ofbiz.product.catalog.*;
import org.ofbiz.product.category.*;


//shoppingCartOutHistoryList = delegator.findList("ShoppingCartHistory", [statusId : "CART_CANCEL"], null, null, null, false);

println "--------ooooo[partyId : userLogin.partyId]------"+userLogin.partyId;
shoppingCartOutHistoryList = delegator.findByAnd("ShoppingCartOutHistoryGoods", [partyId : userLogin.partyId,statusId : "CART_CANCEL"], null, false);

if(shoppingCartOutHistoryList){
	context.shoppingCartOutHistoryList=shoppingCartOutHistoryList;
}








