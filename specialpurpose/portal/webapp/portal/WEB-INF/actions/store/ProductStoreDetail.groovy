

productStoreId = parameters.productStoreId ?: (request.getAttribute("optProductStoreId") ?: request.getAttribute("productStoreId") ?: (parameters.product_store_id ?: parameters.PRODUCT_STORE_ID ?: ""));

if(productStoreId){
	productStore = delegator.findOne("ProductStore", [productStoreId : productStoreId], false)
	context.productStore = productStore;
}

println "00000000000000000000 productStoreId  "+productStoreId;