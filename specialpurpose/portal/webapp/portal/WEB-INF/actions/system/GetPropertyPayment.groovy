import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.product.store.ProductStoreWorker;



proList = delegator.findByAnd("PropertyCompany", null, null, false);
if(proList){
	context.proList=proList;
}
