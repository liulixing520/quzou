import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.product.store.ProductStoreWorker;


//productStoreIdVal=userLogin.partyId?:null;
//println "---------------------------------"+productStoreIdVal;
//

//未完成    通过卖家的ID  找到卖家的店铺ID
productStoreIdVal=parameters.productStoreId;
println "-----------------productStoreId----------------"+productStoreId;
//productStoreIdVal="10200";   //卖家的ID 为productStoreId
curList = delegator.findByAnd("CustRequest", [productStoreId :productStoreIdVal], null, false);


if(curList){
	context.curList=curList;
}



curListItem = delegator.findByAnd("CustRequestItem", null, null, false);

if(curListItem){
	context.curListItem=curListItem;
}


perListItem = delegator.findByAnd("Person", null, null, false);

if(perListItem){
	context.perListItem=perListItem;
}





