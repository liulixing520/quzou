import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.product.store.ProductStoreWorker;

sId=parameters.sctId?:null;

schtList = delegator.findByAnd("Schedulingtime", [sctId : sId], null, false);
if(schtList){
	context.schtList=schtList;
}






