import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.product.store.ProductStoreWorker;


custRequestId=parameters.custRequestId?:null;


//comLists = delegator.findByAnd("CommunicationEvent", [parentCommEventId :custRequestId], null, false);

comLists = delegator.findByAnd("CommunicationEvent", [parentCommEventId :custRequestId], ["entryDate"], false);
if(comLists){
	context.comLists=comLists;
}

println "---------------------------------"+context.comLists;



curList = delegator.findByAnd("CustRequestItem", [custRequestId :custRequestId], null, false);

if(curList){
	context.curList=curList;
}

println "---------------------------------"+context.curList+curList.story;

perList = delegator.findByAnd("Person", null, null, false);

if(perList){
	context.perList=perList;
}





