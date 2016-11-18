import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.product.store.ProductStoreWorker;



productStoreId=parameters.productStoreId;
println "--------productStoreId-------"+productStoreId;
proList = delegator.findByAnd("ProductStore", [productStoreId : productStoreId], null, false);

if(proList){
	context.proList=proList;
}

println "--------proList-------"+proList;


