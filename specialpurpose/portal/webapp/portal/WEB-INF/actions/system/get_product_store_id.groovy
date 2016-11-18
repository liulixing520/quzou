import org.ofbiz.product.store.*;
String productStoreId=ProductStoreWorker.getProductStoreId(request);
if(!productStoreId){
	productStoreId="10000";
}
parameters.productStoreId = productStoreId;