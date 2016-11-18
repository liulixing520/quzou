package com.mobileStore.product;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Locale;

import javolution.util.FastList;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilFormatOut;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityUtil;

public class ProductHelper {
	private static final String module = ProductHelper.class.getName();

	public static String getProductShowPrice(Delegator delegator, String productId, String currencyUomId) {
		if (productId == null || productId.equals(""))
			return "暂无报价";
		try {
			List<GenericValue> priceList = EntityUtil.filterByDate(delegator.findByAnd("ProductPrice", UtilMisc.toMap("productId", productId, "currencyUomId", currencyUomId, "productPriceTypeId", "DEFAULT_PRICE"), null, false));
			if (priceList.size() > 0) {
				BigDecimal price = priceList.get(0).getBigDecimal("price");
				return UtilFormatOut.formatCurrency(price, currencyUomId, Locale.getDefault());
			} else {
				List<GenericValue> productAssocs = delegator.findByAnd("ProductAssoc", UtilMisc.toMap("productId", productId, "productAssocTypeId", "PRODUCT_VARIANT"), null, false);
				BigDecimal lowPrice = null;
				BigDecimal highPrice = null;
				for (GenericValue productAssoc : productAssocs) {
					List<GenericValue> prices = EntityUtil.filterByDate(delegator.findByAnd("ProductPrice", UtilMisc.toMap("productId", productAssoc.getString("productIdTo"), "currencyUomId", currencyUomId, "productPriceTypeId", "DEFAULT_PRICE"), null, false));
					if (prices.size() > 0) {
						BigDecimal price = prices.get(0).getBigDecimal("price");
						if (lowPrice == null)
							lowPrice = price;
						else if (lowPrice.compareTo(price) > 0)
							lowPrice = price;
						if (highPrice == null)
							highPrice = price;
						else if (highPrice.compareTo(price) < 0)
							highPrice = price;
					}
				}
				if (lowPrice != null && highPrice != null) {
					String lowStr = UtilFormatOut.formatCurrency(lowPrice, currencyUomId, Locale.getDefault());
					String highStr = UtilFormatOut.formatCurrency(highPrice, currencyUomId, Locale.getDefault());
					return lowStr + " -- " + highStr;
				} else {
					return "暂无报价";
				}
			}

		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return "暂无报价";
		}
	}

	public static List<GenericValue> getOnSaleProducts(Delegator delegator) {
		List<GenericValue> returnMap = FastList.newInstance();
		try {
			Timestamp now = UtilDateTime.nowTimestamp();
			List<EntityCondition> cdtList = FastList.newInstance();
			cdtList.add(EntityCondition.makeCondition("isVariant", "N"));
			cdtList.add(EntityCondition.makeCondition("introductionDate", EntityOperator.LESS_THAN_EQUAL_TO, now));
			cdtList.add(EntityCondition.makeCondition(UtilMisc.toList(EntityCondition.makeCondition("salesDiscontinuationDate", EntityOperator.EQUALS, null), EntityCondition.makeCondition("salesDiscontinuationDate", EntityOperator.GREATER_THAN, now)), EntityOperator.OR));
			returnMap = delegator.findList("Product", EntityCondition.makeCondition(cdtList), null, null, null, false);
		} catch (Exception e) {
			Debug.logError(e, module);
			return returnMap;
		}
		return returnMap;
	}
}
