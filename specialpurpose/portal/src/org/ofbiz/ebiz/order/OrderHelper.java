package org.ofbiz.ebiz.order;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityUtil;

public class OrderHelper {
	public static final String module = OrderHelper.class.getName();

	public static boolean cancelRefundOrder(Delegator delegator, String orderId) {
		if (delegator == null || orderId == null)
			return false;
		else {
			try {
				GenericValue order = delegator.findOne("OrderHeader", false, UtilMisc.toMap("orderId", orderId));
				if (order == null) {
					return false;
				} else {
					order.set("applyForRefund", null);
					order.set("refundReason", null);
					order.set("ifRefuse", null);
					order.set("refuseReason", null);
					order.store();
					return true;
				}
			} catch (Exception e) {
				Debug.logError(e, module);
				return false;
			}
		}
	}

	public static boolean updateTrackingNumber(Delegator delegator, String orderId, String trackingNumber) {
		if (delegator == null || orderId == null || trackingNumber == null)
			return false;
		else {
			try {
				GenericValue orderItemShipGroup = EntityUtil.getFirst(delegator.findByAnd("OrderItemShipGroup", UtilMisc.toMap("orderId", orderId)));
				if (orderItemShipGroup == null) {
					return false;
				} else {
					orderItemShipGroup.set("trackingNumber", trackingNumber);
					orderItemShipGroup.store();
					return true;
				}
			} catch (Exception e) {
				Debug.logError(e, module);
				return false;
			}
		}
	}
}
