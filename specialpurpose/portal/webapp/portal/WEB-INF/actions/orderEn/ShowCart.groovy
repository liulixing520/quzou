import java.math.BigDecimal;
 import java.util.Iterator;
 import java.util.List;
 import java.util.Locale;
 import java.util.Map;

 import javax.servlet.ServletContext;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 import javax.servlet.http.HttpSession;

 import javolution.util.FastList;
 import javolution.util.FastMap;

 import org.ofbiz.base.util.Debug;
 import org.ofbiz.base.util.GeneralException;
 import org.ofbiz.base.util.ObjectType;
 import org.ofbiz.base.util.UtilDateTime;
 import org.ofbiz.base.util.UtilHttp;
 import org.ofbiz.base.util.UtilMisc;
 import org.ofbiz.base.util.UtilNumber;
 import org.ofbiz.base.util.UtilProperties;
 import org.ofbiz.base.util.UtilValidate;
 import org.ofbiz.entity.Delegator;
 import org.ofbiz.entity.GenericEntityException;
 import org.ofbiz.entity.GenericValue;
 import org.ofbiz.entity.condition.EntityCondition;
 import org.ofbiz.entity.condition.EntityConditionList;
 import org.ofbiz.entity.condition.EntityExpr;
 import org.ofbiz.entity.condition.EntityOperator;
 import org.ofbiz.entity.util.EntityUtil;
 import org.ofbiz.order.order.OrderChangeHelper;
 import org.ofbiz.order.shoppingcart.CheckOutHelper;
 import org.ofbiz.order.shoppingcart.ShoppingCart;
 import org.ofbiz.order.shoppingcart.ShoppingCartEvents;
 import org.ofbiz.order.shoppingcart.ShoppingCartItem;
 import org.ofbiz.order.shoppingcart.shipping.ShippingEstimateWrapper;
 import org.ofbiz.product.store.ProductStoreWorker;
 import org.ofbiz.service.GenericServiceException;
 import org.ofbiz.service.LocalDispatcher;
 import org.ofbiz.service.ModelService;
 import org.ofbiz.service.ServiceUtil;
 import org.ofbiz.itea.content.LongtuoUtil;
 import org.ofbiz.iteamgr.order.OrderServices;
Map<String, Object> context = UtilHttp.getParameterMap(request);
StringBuffer proListStr=new StringBuffer();
StringBuffer payMethodStr=new StringBuffer();
StringBuffer shippingStr=new StringBuffer();
ShoppingCart shoppingCart = ShoppingCartEvents.getCartObject(request);
List<GenericValue> productStorePaymentSettingList = null;
ShippingEstimateWrapper shippingEstWpr=null;
List<GenericValue> carrierShipmentMethodList= null;
decimals = UtilNumber.getBigDecimalScale("order.decimals");
rounding = UtilNumber.getBigDecimalRoundingMode("order.rounding");
ZERO = BigDecimal.ZERO.setScale(decimals, rounding);
productStorePaymentMethodTypeIdMap = new HashMap();//added by dongyc 2012-06-26
try{
    if(shoppingCart!=null){
    	List<ShoppingCartItem> shoppingCartItems =shoppingCart.items();
    	GenericValue productStore = ProductStoreWorker.getProductStore(request);
    	productStorePaymentSettingList = productStore.getRelatedCache("ProductStorePaymentSetting");
    	System.out.println("-----productStorePaymentSettingList-------->>"+productStorePaymentSettingList);
    	//------------支付方式过滤---------------
    	productStorePaymentSettingIter = productStorePaymentSettingList.iterator();
		while (productStorePaymentSettingIter.hasNext()) {
		    productStorePaymentSetting = productStorePaymentSettingIter.next();
		    productStorePaymentMethodTypeIdMap.put(productStorePaymentSetting.get("paymentMethodTypeId"), true);
		}
		//-------------支付方式过滤---------------
		System.out.println("-----productStorePaymentMethodTypeIdMap-------->>"+productStorePaymentMethodTypeIdMap);
    	shippingEstWpr = new ShippingEstimateWrapper(dispatcher, shoppingCart, 0);
    	carrierShipmentMethodList = shippingEstWpr.getShippingMethods();
    	payMethodStr.append("<option value=''>"+"请选择"+"</option>");
    	shippingStr.append("<option></option>");
    	proListStr.append("<table id='proListTb' class='border04 overall_03' width='100%' border='0' cellspacing='0' cellpadding='0' >"+
    						 "<tr class='title02'><td colspan='8'>商品信息</td><td width='72px'>"+
    						 "<a class='button'  close='closeProdialog' width='580' height='380'  param='{}'"+
    						 " href=\"LookupBulkAddProducts?partyId="+shoppingCart.getPartyId()+"\" target='dialog' mask='true' title='添加商品'><span>添加商品</span></a>"+
    						 "</td></tr><tr class='background_tr'><td class='border06 width5'>序号</td><td class='border07 width15'>商品编号</td>"+
    						 "<td class='border07 width22'>商品名称</td><td class='border07 width10'>单价</td><td class='border07 width10'>积分</td><td class='border07 width5'>数量</td>"+
    						 "<td class='border07 width5'>调整</td><td class='border07 width7'>小计</td><td class='border07 width7'>操作</td> </tr>"
    						 );
    	for(ShoppingCartItem  cartLine : shoppingCartItems   ){
    		int cartLineIndex = shoppingCart.getItemIndex(cartLine);
			if(cartLine.getProduct().get("isSaleReward")=="Y" && cartLine.getProduct().get("saleReward")!=null){
				sr = cartLine.getQuantity().setScale(0, 0)*+cartLine.getProduct().get("saleReward").setScale(0,BigDecimal.ROUND_DOWN);
				proListStr.append(
    				"<tr class='background_tr'><td class='border06'>"+(cartLineIndex+1)+"</td>" +
    				"<td class='border06'>"+cartLine.getProduct().get("productId")+"</td>" +
    				"<td class='border06'>"+cartLine.getProduct().get("productName")+"</td>" +
    				"<td class='border06'><input type='text' size='10' onblur='changePrice(this)' name='price_"+cartLineIndex+"' readonly value='"+cartLine.getDisplayPrice().setScale(decimals, rounding)+"'></td>" +
					"<td class='border06'>"+cartLine.getProduct().get("saleReward").setScale(0,BigDecimal.ROUND_DOWN)+"</td>" +
    				"<td class='border06'><img width='9' height='9' onclick=\"decreaseProductNum('update_"+cartLineIndex+"')\" src='/images/decrease.gif' style='cursor: pointer;'>&nbsp;"+
    				"<input type='text' size='10' name='update_"+cartLineIndex+"' size=''  id='update_"+cartLineIndex+"' readonly value='"+cartLine.getQuantity().setScale(0, 0)+"'>"+
    				"&nbsp;<img width='9' height='9' onclick=\"addProductNum('update_"+cartLineIndex+"')\" src='/images/adding.gif' style='cursor: pointer;'></td>" +
    				"<td class='border06'>"+cartLine.getOtherAdjustments().setScale(decimals, rounding)+"</td>" +
    				"<td class='border06'>"+cartLine.getDisplayItemSubTotal().setScale(decimals, rounding)+" + "+sr+"积分</td>" +
    				"<td class='border06'><a href=\"javascript:deleteProd('update_"+cartLineIndex+"')\">删除</a></td>" +
    				"</tr>");
			}
			else{
				proListStr.append(
    				"<tr class='background_tr'><td class='border06'>"+(cartLineIndex+1)+"</td>" +
    						"<td class='border06'>"+cartLine.getProduct().get("productId")+"</td>" +
    						"<td class='border06'>"+cartLine.getProduct().get("productName")+"</td>" +
    						"<td class='border06'><input type='text' size='10' onblur='changePrice(this)' name='price_"+cartLineIndex+"' readonly value='"+cartLine.getDisplayPrice().setScale(decimals, rounding)+"'></td>" +
							"<td class='border06'></td>" +
    				"<td class='border06'><img width='9' height='9' onclick=\"decreaseProductNum('update_"+cartLineIndex+"')\" src='/images/decrease.gif' style='cursor: pointer;'>&nbsp;"+
    				"<input type='text' size='10' name='update_"+cartLineIndex+"' size=''  id='update_"+cartLineIndex+"' readonly value='"+cartLine.getQuantity().setScale(0, 0)+"'>"+
    				"&nbsp;<img width='9' height='9' onclick=\"addProductNum('update_"+cartLineIndex+"')\" src='/images/adding.gif' style='cursor: pointer;'></td>" +
    				"<td class='border06'>"+cartLine.getOtherAdjustments().setScale(decimals, rounding)+"</td>" +
    				"<td class='border06'>"+cartLine.getDisplayItemSubTotal().setScale(decimals, rounding)+"</td>" +
    				"<td class='border06'><a href=\"javascript:deleteProd('update_"+cartLineIndex+"')\">删除</a></td>" +
    				"</tr>");
			}
    	}
    	proListStr.append("</table>");
    			//----------added by dongyc 2012-06-28-------支付方式选项------------
    			if(productStorePaymentMethodTypeIdMap.EXT_USER_ACCOUNT==true){
    				payMethodStr.append("<option value='EXT_USER_ACCOUNT'>"+OrderServices.payTypeMap.get("EXT_USER_ACCOUNT")+"</option>");
    			}
    			if(productStorePaymentMethodTypeIdMap.CREDIT_CARD==true){
    				payMethodStr.append("<option value='CREDIT_CARD'>"+OrderServices.payTypeMap.get("CREDIT_CARD")+"</option>");
    			}
    			if(productStorePaymentMethodTypeIdMap.EXT_OFFLINE==true){
    				payMethodStr.append("<option value='EXT_OFFLINE'>"+OrderServices.payTypeMap.get("EXT_OFFLINE")+"</option>");
    			}
    			if(productStorePaymentMethodTypeIdMap.EXT_COD==true){
    				payMethodStr.append("<option value='EXT_COD'>"+OrderServices.payTypeMap.get("EXT_COD")+"</option>");
    			}
    			if(productStorePaymentMethodTypeIdMap.EXT_WORLDPAY==true){
    				payMethodStr.append("<option value='EXT_WORLDPAY'>"+OrderServices.payTypeMap.get("EXT_WORLDPAY")+"</option>");
    			}
    			if(productStorePaymentMethodTypeIdMap.EXT_PAYPAL==true){
    				payMethodStr.append("<option value='EXT_PAYPAL'>"+OrderServices.payTypeMap.get("EXT_PAYPAL")+"</option>");
    			}
    			if(productStorePaymentMethodTypeIdMap.CASH==true){
    				payMethodStr.append("<option value='CASH'>"+OrderServices.payTypeMap.get("CASH")+"</option>");
    			}
    			//----------added by dongyc 2012-06-28-------支付方式选项------------
    	for(GenericValue  carrierShipmentMethod : carrierShipmentMethodList   ){
    		 String shippingMethod = carrierShipmentMethod.get("shipmentMethodTypeId") + "@" + carrierShipmentMethod.get("partyId");
    		 BigDecimal shippingEst = shippingEstWpr.getShippingEstimate(carrierShipmentMethod);
    		 if(shippingEst!=null){
    			 shippingStr.append("<option value='"+shippingMethod+"'>"+LongtuoUtil.notEmpt(carrierShipmentMethod.get("description"))+"=="+shippingEst.setScale(decimals, rounding)+"</option>");
    		 }
    		 }
    }
}catch(Exception e){
	e.printStackTrace();
}
request.setAttribute("proListStr",proListStr.toString());
request.setAttribute("payMethodStr",payMethodStr.toString());
request.setAttribute("shippingStr",shippingStr.toString());
