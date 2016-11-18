import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.product.store.ProductStoreWorker;



treList = delegator.findByAnd("TrePerson", null, null, false);
if(treList){
	context.treList=treList;
}

println "--------treList-------"+treList;





