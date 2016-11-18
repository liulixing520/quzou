/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

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


Map<String, Object> context = UtilHttp.getParameterMap(request);
StringBuffer totalStr=new StringBuffer();
ShoppingCart shoppingCart = ShoppingCartEvents.getCartObject(request);

String shippingTotal="";
String currencyUomId = ShoppingCartEvents.getCartObject(request).getCurrency();
decimals = UtilNumber.getBigDecimalScale("order.decimals");
rounding = UtilNumber.getBigDecimalRoundingMode("order.rounding");
ZERO = BigDecimal.ZERO.setScale(decimals, rounding);
BigDecimal shippingAmount=ZERO;
BigDecimal payTotal=ZERO;
 try{
    if(shoppingCart!=null){
    	//shippingAmount = OrderReadHelper.getAllOrderItemsAdjustmentsTotal(shoppingCart.makeOrderItems(),shoppingCart.getAdjustments(), false, false, true);
        //shippingAmount = shippingAmount.add(OrderReadHelper.calcOrderAdjustments(shoppingCart.getAdjustments(), shoppingCart.getSubTotal(), false, false, true));
    	 Map shipCost = org.ofbiz.order.shoppingcart.shipping.ShippingEvents.getShipGroupEstimate(dispatcher, delegator, shoppingCart, 0);
    	 if(shipCost!=null){
    		 shippingAmount = (BigDecimal)shipCost.get("shippingTotal");
    	 }
    	 if(shippingAmount!=null&&shippingAmount.compareTo(ZERO)>0){
    		 shippingTotal = org.ofbiz.base.util.UtilFormatOut.formatCurrency(shippingAmount, currencyUomId, UtilHttp.getLocale(request));
    	 }
    	totalStr.append("<table id='proListTb' class='border04 overall_03' width='100%' border='0' cellspacing='0' cellpadding='0' >"+
    						 "<tr class='title02'><td colspan='6'>订单总额</td></tr>"
    						 );
    	totalStr.append("<tr><td colspan='5'></td><td colspan='right'>小计："+shoppingCart.getSubTotal().setScale(decimals, rounding)+" </td></tr>");
    	totalStr.append("<tr><td colspan='5'></td><td colspan='right'>促销优惠："+shoppingCart.getProductPromoTotal().setScale(decimals, rounding)+" </td></tr>");
    	//totalStr.append("<tr><td colspan='5'></td><td colspan='right'>运费："+shippingAmount.setScale(decimals, rounding)+"</td></tr>");
    	totalStr.append("<tr><td colspan='5'></td><td colspan='right'>运费："+shippingTotal+"</td></tr>");
    	totalStr.append("<tr><td colspan='5'></td><td colspan='right'>总额：<span id='payTotal'>"+shoppingCart.getGrandTotal().setScale(decimals, rounding)+"</span></td></tr>");
    	totalStr.append("</table>");
    	payTotal=shoppingCart.getGrandTotal().setScale(decimals, rounding);
    }
}catch(Exception e){
	e.printStackTrace();
}
//System.out.println("****"+totalStr.toString());
request.setAttribute("totalStr",totalStr.toString());
request.setAttribute("payTotal",payTotal);
