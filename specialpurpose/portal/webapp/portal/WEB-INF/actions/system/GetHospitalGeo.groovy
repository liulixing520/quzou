import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.product.store.ProductStoreWorker;



geoList = delegator.findByAnd("HospitalGeo", [geoType : "PROVINCE"], null, false);
if(geoList){
	context.geoList=geoList;
}






