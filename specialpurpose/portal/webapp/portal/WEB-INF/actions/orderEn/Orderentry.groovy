import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.product.catalog.CatalogWorker;
import org.ofbiz.order.shoppingcart.product.ProductDisplayWorker;
import org.ofbiz.order.shoppingcart.ShoppingCartEvents;
import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.order.shoppingcart.shipping.*;
import org.ofbiz.product.store.*;
//获取当前站点店铺
productStore = ProductStoreWorker.getProductStore(request);

productStorePaymentMethodTypeIdMap = new HashMap();
if(productStore!=null){
	productStorePaymentSettingList = productStore.getRelatedCache("ProductStorePaymentSetting");
	context.productStorePaymentSettingList=productStorePaymentSettingList;
}
/*
shippingEstWpr = null;
if (shoppingCart) {
    shippingEstWpr = new ShippingEstimateWrapper(dispatcher, shoppingCart, 0);
    context.shippingEstWpr = shippingEstWpr;
    context.carrierShipmentMethodList = shippingEstWpr.getShippingMethods();
}
*/
context.orderInvoiceContentList=delegator.findByAnd("Enumeration", ["enumTypeId": "ORDER_INVOICE_TYPE"]);
context.orderShipDateList=delegator.findByAnd("Enumeration", ["enumTypeId": "ORDER_SHIPDATE_TYPE"]);