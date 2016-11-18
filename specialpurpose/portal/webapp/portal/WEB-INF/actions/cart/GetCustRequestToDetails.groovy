import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.product.store.ProductStoreWorker;


parentCommEventId=parameters.custRequestId?:null;

println "---------------------------------"+parentCommEventId;

comLists = delegator.findByAnd("CommunicationEvent", [parentCommEventId :parentCommEventId], ["entryDate"], false);

if(comLists){
	context.comLists=comLists;
}

println "---------------------------------"+comLists.size();


curList = delegator.findByAnd("CustRequestItem", [custRequestId :parentCommEventId], null, false);

if(curList){
	context.curList=curList;
}

println "---------------------------------"+context.curList+curList.story;






