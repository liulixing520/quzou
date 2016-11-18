import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilValidate;

productIdTo = parameters.productIdTo;
productId = parameters.productId;

result = [:];
if(UtilValidate.isEmpty(productIdTo)){
	result = dispatcher.runSync("findOrders", [productId: productId,userLogin:userLogin,viewIndex:0,viewSize:20]);

}
else{
	result = dispatcher.runSync("findOrders", [productId: productIdTo,userLogin:userLogin,viewIndex:0,viewSize:20]);

}
if (result) {
            orderList = (List)result.get("orderList");
}
if(orderList.size()>0){
	request.setAttribute("num",orderList.size());
	request.setAttribute("status",'no');
	}
else{
	if(UtilValidate.isEmpty(productIdTo))
		productAssocs = delegator.findByAnd("ProductAssoc", [productId:productId,productAssocTypeId:'PRODUCT_VARIANT']);
	else
		productAssocs = delegator.findByAnd("ProductAssoc", [productId:productId,productIdTo:productIdTo,productAssocTypeId:'PRODUCT_VARIANT']);
	for(productAssoc in productAssocs){
		productAssoc.set("thruDate",UtilDateTime.nowTimestamp());
		productAssoc.store();
	}
	request.setAttribute("status",'ok');
	}