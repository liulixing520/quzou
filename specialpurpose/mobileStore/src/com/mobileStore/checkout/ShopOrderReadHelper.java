package com.mobileStore.checkout;

import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.order.order.OrderReadHelper;

public class ShopOrderReadHelper extends OrderReadHelper {

	public ShopOrderReadHelper(GenericValue orderHeader) {
		super(orderHeader);
	}

	/**
	 * 
	 * @param orderHeader
	 * @return
	 */
	public static ShopOrderReadHelper getShopHelper(GenericValue orderHeader) {
		return new ShopOrderReadHelper(orderHeader);
	}

	/**
	 * 获取此订单的客户应付金额
	 * 
	 * @return
	 * @throws GenericEntityException
	 */
	public BigDecimal getOrderPayableAmount() {
		BigDecimal payableAmount = BigDecimal.ZERO;
		BigDecimal total = getOrderGrandTotal();
		BigDecimal receivedAmount = BigDecimal.ZERO;
		List<GenericValue> prefs = getPaymentPreferences();

		// add up the covered amount
		for (Iterator<GenericValue> iter = prefs.iterator(); iter.hasNext();) {
			GenericValue pref = iter.next();
			if ("PAYMENT_AUTHORIZED".equals(pref.get("statusId")) || "PAYMENT_RECEIVED".equals(pref.get("statusId"))) {
				BigDecimal maxAmount = pref.getBigDecimal("maxAmount");
				if (maxAmount != null) {
					receivedAmount = receivedAmount.add(maxAmount);
				}
			} else if ("PAYMENT_SETTLED".equals(pref.get("statusId"))) {
				List<GenericValue> responses = null;
				try {
					responses = pref.getRelatedByAnd("PaymentGatewayResponse", UtilMisc.toMap("transCodeEnumId", "PGT_CAPTURE"));
					for (Iterator<GenericValue> respIter = responses.iterator(); respIter.hasNext();) {
						GenericValue response = respIter.next();
						BigDecimal amount = response.getBigDecimal("amount");
						if (amount != null) {
							receivedAmount = receivedAmount.add(amount);
						}
					}
				} catch (GenericEntityException e) {
					Debug.logWarning(e, module);
				}

				try {
					responses = pref.getRelatedByAnd("PaymentGatewayResponse", UtilMisc.toMap("transCodeEnumId", "PGT_REFUND"));
					for (Iterator<GenericValue> respIter = responses.iterator(); respIter.hasNext();) {
						GenericValue response = respIter.next();
						BigDecimal amount = response.getBigDecimal("amount");
						if (amount != null) {
							receivedAmount = receivedAmount.subtract(amount);
						}
					}
				} catch (GenericEntityException e) {
					Debug.logWarning(e, module);
				}

			}
		}
		payableAmount = total.subtract(receivedAmount).setScale(scale, rounding);
		// return either a positive amount or positive zero
		return payableAmount.compareTo(BigDecimal.ZERO) > 0 ? payableAmount : BigDecimal.ZERO;
	}

	/**
	 * 获得第一个订单项货运组
	 * 
	 * @return
	 */
	public GenericValue getFirstOrderItemShipGroup() {
		List<GenericValue> listShipGroups = this.getOrderItemShipGroups();
		if (UtilValidate.isNotEmpty(listShipGroups)) {
			return listShipGroups.get(0);
		}
		return null;
	}

	/**
	 * 发货时间描述
	 * 
	 * @return
	 */
	public String getShipDateEnumDesc() {
		String shipDateEnumDesc = null;
		GenericValue orderItemShipGroup = this.getFirstOrderItemShipGroup();
		if (orderItemShipGroup != null) {
			GenericValue gvEnum = null;
			try {
				gvEnum = orderHeader.getDelegator().findByPrimaryKey("Enumeration", UtilMisc.toMap("enumId", orderItemShipGroup.getString("shipDateEnumId")));
			} catch (GenericEntityException e) {
				Debug.logWarning(e, module);
			}
			if (gvEnum != null) {
				shipDateEnumDesc = gvEnum.getString("description");
			}
		}
		return shipDateEnumDesc;
	}
}
