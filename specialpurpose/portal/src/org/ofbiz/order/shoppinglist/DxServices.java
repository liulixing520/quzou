package org.ofbiz.order.shoppinglist;

import java.math.BigDecimal;
import java.util.Map;

import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.order.order.OrderReadHelper;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.product.config.ProductConfigWrapper;
import org.ofbiz.product.product.ProductContentWrapper;
import org.ofbiz.product.product.ProductWorker;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;

public class DxServices {

	/**
	 * 获取代销订单的佣金和供应商成本
	 * 订单中总和（订单项的售价-供应商定价）*商品数量
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> getSupplierSaleTotalMap(DispatchContext dctx, Map<String, Object> context) {
		 GenericValue orderHeader=(GenericValue)context.get("orderHeader");
		 OrderReadHelper orh=OrderReadHelper.getHelper(orderHeader);
		 GenericDelegator delegator = (GenericDelegator) dctx.getDelegator();
		 LocalDispatcher dispatcher = dctx.getDispatcher();
		 Map retResult = ServiceUtil.returnSuccess();
		 try{
			 BigDecimal supplierSaleTotal=BigDecimal.ZERO;
			 BigDecimal itmesTotal= orh.getOrderItemsTotal();
			 List<GenericValue> orderItem=orh.getOrderItems();
				for (GenericValue gv : orderItem) {
					if (UtilValidate.isNotEmpty(gv.getString("productId"))) {
						GenericValue product=delegator.findOne("Product",UtilMisc.toMap("productId", gv.getString("productId")),false);
						Map<String, GenericValue> priceContext = UtilMisc.toMap("product", product);
						Map<String, Object> priceMap = dispatcher.runSync("calculateProductPrice", priceContext);
						 if (priceMap.get("defaultPrice") != null) {
							 BigDecimal defaultPrice = ((BigDecimal) priceMap.get("defaultPrice")).setScale(2, BigDecimal.ROUND_HALF_DOWN);
		                        supplierSaleTotal.add(defaultPrice.multiply(gv.getBigDecimal("quantity")));
						 }
					}
				}
		 
        
				
				retResult.put("supplierSaleTotal", supplierSaleTotal);
				retResult.put("yjSaleTotal", itmesTotal.subtract(supplierSaleTotal));
		 }catch (Exception e){
			 
		 }
		return retResult;
	}
}
