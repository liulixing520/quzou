package com.mobileStore.checkout;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javolution.util.FastList;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.GeneralException;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilHttpExt;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.marketing.tracking.TrackingCodeEvents;
import org.ofbiz.order.shoppingcart.CartItemModifyException;
import org.ofbiz.order.shoppingcart.CheckOutHelper;
import org.ofbiz.order.shoppingcart.MultiCheckOutEvents;
import org.ofbiz.order.shoppingcart.MultiShoppingCartEvents;
import org.ofbiz.order.shoppingcart.MultiShoppingCartMap;
import org.ofbiz.order.shoppingcart.ShoppingCart;
import org.ofbiz.order.shoppingcart.product.ProductPromoWorker;
import org.ofbiz.order.shoppingcart.shipping.MultiShippingEvents;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;
import org.ofbiz.webapp.stats.VisitHandler;
import org.ofbiz.webapp.website.WebSiteWorker;

public class MobileCheckOutEvents {
	public static final String module = MobileCheckOutEvents.class.getName();

	public static String prapareOoderOptions(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		HttpSession session = request.getSession();
		String shippingContactMechId = (String) session.getAttribute("defaultContactMechId");
		if (shippingContactMechId == null) {
			return "shipAdrrNotFound";
		}
		Map<String, Map<String, Object>> selectedPaymentMethods = MultiCheckOutEvents.getSelectedPaymentMethods(request);
		String[] paymentMethods = request.getParameterValues("checkOutPaymentId");
		String checkOutPaymentId = null;
		if (UtilValidate.isNotEmpty(paymentMethods)) {
			checkOutPaymentId = paymentMethods[0];
		}
		Object orderFrom = session.getAttribute("orderFrom");
		if (orderFrom != null && orderFrom.equals("QUICK_ORDER")) {
			ShoppingCart cart = (ShoppingCart) session.getAttribute("quickOrderCart");
			if (cart == null) {
				request.setAttribute("_ERROR_MESSAGE_", "商品被搞丢了！");
				Debug.logError("商品被搞丢了！", module);
				return "productLost";
			}
			String productStoreId = cart.getProductStoreId();
			String productStorePrefix = UtilHttpExt.getProductStorePrefix(request, productStoreId);
			CheckOutHelper checkOutHelper = new CheckOutHelper(dispatcher, delegator, cart);

			String billingAccountId = request.getParameter("billingAccountId");
			String shippingMethod = request.getParameter(productStorePrefix + "shipping_method");
			if (shippingMethod == null || shippingMethod.trim().equals(""))
				shippingMethod = "NO_SHIPPING@_NA_";
			String taxAuthPartyGeoIds = request.getParameter("taxAuthPartyGeoIds");
			String partyTaxId = request.getParameter("partyTaxId");
			String isExempt = request.getParameter("isExempt");

			String shippingInstructions = request.getParameter(productStorePrefix + "shipping_instructions");
			String orderAdditionalEmails = request.getParameter("order_additional_emails");
			String maySplit = request.getParameter("may_split");
			if (UtilValidate.isEmpty(maySplit)) {
				maySplit = "N";
			}
			String giftMessage = request.getParameter("gift_message");
			String isGift = request.getParameter("is_gift");
			if (UtilValidate.isEmpty(isGift)) {
				isGift = "false";
			}
			String internalCode = request.getParameter("internalCode");
			String shipBeforeDate = request.getParameter("shipBeforeDate");
			String shipAfterDate = request.getParameter("shipAfterDate");

			List<String> singleUsePayments = new ArrayList<String>();

			// get a request map of parameters
			Map<String, Object> params = UtilHttp.getParameterMap(request);

			// if taxAuthPartyGeoIds is not empty drop that into the database
			if (UtilValidate.isNotEmpty(taxAuthPartyGeoIds)) {
				try {
					Map<String, Object> createCustomerTaxAuthInfoResult = dispatcher.runSync("createCustomerTaxAuthInfo", UtilMisc.toMap("partyId", cart.getPartyId(), "taxAuthPartyGeoIds", taxAuthPartyGeoIds, "partyTaxId", partyTaxId, "isExempt", isExempt));
					ServiceUtil.getMessages(request, createCustomerTaxAuthInfoResult, null);
					if (ServiceUtil.isError(createCustomerTaxAuthInfoResult)) {
						request.setAttribute("_ERROR_MESSAGE_", "ServiceUtil.isError(createCustomerTaxAuthInfoResult)");
						Debug.logError("ServiceUtil.isError(createCustomerTaxAuthInfoResult)", module);
						return "error";
					}
				} catch (GenericServiceException e) {
					String errMsg = "Error setting customer tax info: " + e.toString();
					request.setAttribute("_ERROR_MESSAGE_", errMsg);
					Debug.logError(errMsg, module);
					return "error";
				}
			}

			// check for gift card not on file
			Map<String, Object> gcResult = checkOutHelper.checkGiftCard(params, selectedPaymentMethods);
			ServiceUtil.getMessages(request, gcResult, null);
			if (ServiceUtil.isError(gcResult)) {
				request.setAttribute("_ERROR_MESSAGE_", "checkOutHelper.checkGiftCard(params, selectedPaymentMethods)");
				Debug.logError("checkOutHelper.checkGiftCard(params, selectedPaymentMethods)", module);
				return "error";
			}

			String gcPaymentMethodId = (String) gcResult.get("paymentMethodId");
			BigDecimal gcAmount = (BigDecimal) gcResult.get("amount");
			if (gcPaymentMethodId != null) {
				selectedPaymentMethods.put(gcPaymentMethodId, UtilMisc.<String, Object> toMap("amount", gcAmount, "securityCode", null));
				if ("Y".equalsIgnoreCase(request.getParameter("singleUseGiftCard"))) {
					singleUsePayments.add(gcPaymentMethodId);
				}
			}

			Map<String, Object> optResult = checkOutHelper.setCheckOutOptions(shippingMethod, shippingContactMechId, selectedPaymentMethods, singleUsePayments, billingAccountId, shippingInstructions, orderAdditionalEmails, maySplit, giftMessage, isGift, internalCode, shipBeforeDate, shipAfterDate);

			ServiceUtil.getMessages(request, optResult, null);
			if (ServiceUtil.isError(optResult)) {
				request.setAttribute("_ERROR_MESSAGE_", optResult.get("errorMessage"));
				Debug.logError((String) optResult.get("errorMessage"), module);
				return "error";
			}
		} else {
			MultiShoppingCartMap shoppingCartMap = MultiShoppingCartEvents.getCartMap(request);
			shoppingCartMap.setShippingContactMechId(shippingContactMechId);
			shoppingCartMap.setCheckOutPaymentId(checkOutPaymentId);
			List<ShoppingCart> shoppingCartList = shoppingCartMap.getShoppingCartList();
			for (ShoppingCart cart : shoppingCartList) {
				String productStoreId = cart.getProductStoreId();
				String productStorePrefix = UtilHttpExt.getProductStorePrefix(request, productStoreId);
				CheckOutHelper checkOutHelper = new CheckOutHelper(dispatcher, delegator, cart);

				// get the billing account and amount
				String billingAccountId = request.getParameter("billingAccountId");
				String shippingMethod = request.getParameter(productStorePrefix + "shipping_method");
				if (shippingMethod == null || shippingMethod.trim().equals(""))
					shippingMethod = "NO_SHIPPING@_NA_";
				String taxAuthPartyGeoIds = request.getParameter("taxAuthPartyGeoIds");
				String partyTaxId = request.getParameter("partyTaxId");
				String isExempt = request.getParameter("isExempt");

				String shippingInstructions = request.getParameter(productStorePrefix + "shipping_instructions");
				String orderAdditionalEmails = request.getParameter("order_additional_emails");
				String maySplit = request.getParameter("may_split");
				if (UtilValidate.isEmpty(maySplit)) {
					maySplit = "N";
				}
				String giftMessage = request.getParameter("gift_message");
				String isGift = request.getParameter("is_gift");
				if (UtilValidate.isEmpty(isGift)) {
					isGift = "false";
				}
				String internalCode = request.getParameter("internalCode");
				String shipBeforeDate = request.getParameter("shipBeforeDate");
				String shipAfterDate = request.getParameter("shipAfterDate");

				List<String> singleUsePayments = new ArrayList<String>();

				// get a request map of parameters
				Map<String, Object> params = UtilHttp.getParameterMap(request);

				// if taxAuthPartyGeoIds is not empty drop that into the
				// database
				if (UtilValidate.isNotEmpty(taxAuthPartyGeoIds)) {
					try {
						Map<String, Object> createCustomerTaxAuthInfoResult = dispatcher.runSync("createCustomerTaxAuthInfo", UtilMisc.toMap("partyId", cart.getPartyId(), "taxAuthPartyGeoIds", taxAuthPartyGeoIds, "partyTaxId", partyTaxId, "isExempt", isExempt));
						ServiceUtil.getMessages(request, createCustomerTaxAuthInfoResult, null);
						if (ServiceUtil.isError(createCustomerTaxAuthInfoResult)) {
							return "error";
						}
					} catch (GenericServiceException e) {
						String errMsg = "Error setting customer tax info: " + e.toString();
						request.setAttribute("_ERROR_MESSAGE_", errMsg);
						return "error";
					}
				}

				// check for gift card not on file
				Map<String, Object> gcResult = checkOutHelper.checkGiftCard(params, selectedPaymentMethods);
				ServiceUtil.getMessages(request, gcResult, null);
				if (ServiceUtil.isError(gcResult)) {
					return "error";
				}

				String gcPaymentMethodId = (String) gcResult.get("paymentMethodId");
				BigDecimal gcAmount = (BigDecimal) gcResult.get("amount");
				if (gcPaymentMethodId != null) {
					selectedPaymentMethods.put(gcPaymentMethodId, UtilMisc.<String, Object> toMap("amount", gcAmount, "securityCode", null));
					if ("Y".equalsIgnoreCase(request.getParameter("singleUseGiftCard"))) {
						singleUsePayments.add(gcPaymentMethodId);
					}
				}

				Map<String, Object> optResult = checkOutHelper.setCheckOutOptions(shippingMethod, shippingContactMechId, selectedPaymentMethods, singleUsePayments, billingAccountId, shippingInstructions, orderAdditionalEmails, maySplit, giftMessage, isGift, internalCode, shipBeforeDate, shipAfterDate);

				ServiceUtil.getMessages(request, optResult, null);
				if (ServiceUtil.isError(optResult)) {
					return "error";
				}
			}
		}
		if (orderFrom != null && orderFrom.equals("QUICK_ORDER")) {
			return "success";
		} else {
			return "cartSuccess";
		}
	}

	public static String getShipEstimate(HttpServletRequest request, HttpServletResponse response) {
		ShoppingCart cart = (ShoppingCart) request.getSession().getAttribute("quickOrderCart");
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		Debug.logError(">>>>>>>>>>>>>>>>>>>>>>>>>>getShipEstimate", module);

		int shipGroups = cart.getShipGroupSize();

		for (int i = 0; i < shipGroups; i++) {
			String shipmentMethodTypeId = cart.getShipmentMethodTypeId(i);
			String carrierPartyId = cart.getCarrierPartyId(i);
			String productStoreShipMethId = cart.getProductStoreShipMethId(i);
			String supplierPartyId = cart.getSupplierPartyId(i);

			if (UtilValidate.isEmpty(shipmentMethodTypeId)) {
				continue;
			}

			Map<String, Object> result = MultiShippingEvents.getShipGroupEstimate(dispatcher, delegator, cart, i);
			ServiceUtil.getMessages(request, result, null, "", "", "", "", null, null);
			if (result.get(ModelService.RESPONSE_MESSAGE).equals(ModelService.RESPOND_ERROR)) {
				request.setAttribute("_ERROR_MESSAGE_", "getShipGroupEstimate出错了");
				return "error";
			}

			BigDecimal shippingTotal = (BigDecimal) result.get("shippingTotal");

			// BigDecimal shippingTotal = null;
			if (shippingTotal == null) {
				shippingTotal = BigDecimal.ZERO;
			}
			cart.setItemShipGroupEstimate(shippingTotal, i);
		}

		ProductPromoWorker.doPromotions(cart, dispatcher);
		// all done
		return "success";
	}

	public static String calcTax(HttpServletRequest request, HttpServletResponse response) throws GeneralException {
		Debug.logError(">>>>>>>>>>>>>>>>>>>>>>>>>>calcTax", module);
	
		try {
			LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
			Delegator delegator = (Delegator) request.getAttribute("delegator");
			ShoppingCart cart = (ShoppingCart) request.getSession().getAttribute("quickOrderCart");
			CheckOutHelper checkOutHelper = new CheckOutHelper(dispatcher, delegator, cart);
			// Calculate and add the tax adjustments
			checkOutHelper.calcAndAddTax();
		} catch (GeneralException e) {
			request.setAttribute("_ERROR_MESSAGE_", e.getMessage());
			Debug.logError(e.getMessage(), module);
			return "error";
		}
		return "success";
	}

	public static String createOrder(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ShoppingCart cart = (ShoppingCart) session.getAttribute("quickOrderCart");
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");

		String distributorId = (String) session.getAttribute("_DISTRIBUTOR_ID_");
		String affiliateId = (String) session.getAttribute("_AFFILIATE_ID_");
		String visitId = VisitHandler.getVisitId(session);
		String webSiteId = WebSiteWorker.getWebSiteId(request);

		if (cart.size() > 0) {
			CheckOutHelper checkOutHelper = new CheckOutHelper(dispatcher, delegator, cart);
			Map<String, Object> callResult;

			if (UtilValidate.isEmpty(userLogin)) {
				userLogin = cart.getUserLogin();
				session.setAttribute("userLogin", userLogin);
			}

			if (UtilValidate.isEmpty(cart.getUserLogin())) {
				try {
					cart.setUserLogin(userLogin, dispatcher);
				} catch (CartItemModifyException e) {
					e.printStackTrace();
				}
			}
			// remove this whenever creating an order so quick reorder cache
			// will refresh/recalc
			session.removeAttribute("_QUICK_REORDER_PRODUCTS_");

			boolean areOrderItemsExploded = MultiCheckOutEvents.explodeOrderItems(delegator, cart);

			// get the TrackingCodeOrder List
			List<GenericValue> trackingCodeOrders = TrackingCodeEvents.makeTrackingCodeOrders(request);

			callResult = checkOutHelper.createOrder(userLogin, distributorId, affiliateId, trackingCodeOrders, areOrderItemsExploded, visitId, webSiteId);
			if (callResult != null) {
				ServiceUtil.getMessages(request, callResult, null);
				if (ServiceUtil.isError(callResult)) {
					// messages already setup with the getMessages call,
					// just return the error response code
					request.setAttribute("_ERROR_MESSAGE_", callResult.get("errorMessage"));
					Debug.logError((String) callResult.get("errorMessage"), module);
					return "error";
				}
				if (callResult.get(ModelService.RESPONSE_MESSAGE).equals(ModelService.RESPOND_SUCCESS)) {
					// set the orderId for use by chained events
					String orderId = cart.getOrderId();
					request.setAttribute("orderId", orderId);
					session.setAttribute("orderId", orderId);
					session.removeAttribute("orderIdList");
					request.setAttribute("orderAdditionalEmails", cart.getOrderAdditionalEmails());
				}
			}

			String issuerId = request.getParameter("issuerId");
			if (UtilValidate.isNotEmpty(issuerId)) {
				request.setAttribute("issuerId", issuerId);
			}
		}
		return "success";
	}

	public static String checkExternalPayment_(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		List<String> orderIdList = (List<String>) session.getAttribute("orderIdList");
		if (orderIdList == null || orderIdList.size() < 1) {
			return "error";
		}
		return "success";
	}

	public static String paySingleOrder(HttpServletRequest request, HttpServletResponse response) {
		String orderId = request.getParameter("orderId");
		if (orderId == null) {
			return "error";
		}
		request.setAttribute("orderId", orderId);
		return "success";
	}

	public static String checkExternalPayment(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		String result;

		String orderId = (String) request.getAttribute("orderId");

		String paymentTypeId = (String) request.getAttribute("paymentTypeId");
		// 取得最新的支付方式
		if (paymentTypeId != "" && paymentTypeId != null) {
			changeExternalPaymentTpye(delegator, orderId, paymentTypeId);
		}
		Map<String, Object> callResult = checkExternalPayment(delegator, orderId);

		// Generate any messages required
		ServiceUtil.getMessages(request, callResult, null);

		// any error messages have prepared for display, return the type
		// ('error' if failed)
		result = (String) callResult.get("type");
		return result;
	}

	public static Map<String, Object> changeExternalPaymentTpye(Delegator delegator, String orderId, String paymentMethodTypeId) {
		Map<String, Object> result;
		String errMsg = null;
		GenericValue orderHeader = null;
		try {
			orderHeader = delegator.findOne("OrderHeader", false, UtilMisc.toMap("orderId", orderId));
		} catch (GenericEntityException e) {
			Debug.logError(e, "Problems getting order header", module);
			errMsg = "订单获取错误";
			result = ServiceUtil.returnError(errMsg);
			return result;
		}
		if (orderHeader != null) {
			List<GenericValue> paymentPrefs = null;
			try {
				paymentPrefs = orderHeader.getRelated("OrderPaymentPreference", null, null, false);
			} catch (GenericEntityException e) {
				Debug.logError(e, "Problems getting order payments", module);
				errMsg = "获取订单支付方式错误";
				result = ServiceUtil.returnError(errMsg);
				return result;
			}
			if (UtilValidate.isNotEmpty(paymentPrefs)) {
				if (paymentPrefs.size() > 1) {
					Debug.logError("Too many payment preferences, you cannot have more then one when using external gateways", module);
				}
				GenericValue paymentPreference = EntityUtil.getFirst(paymentPrefs);
				if (paymentMethodTypeId.startsWith("EXT_")) {
					paymentPreference.put("paymentMethodTypeId", paymentMethodTypeId);
					// PayPal with a PaymentMethod is not an external payment
					// method
					if (!(paymentMethodTypeId.equals("EXT_PAYPAL") && UtilValidate.isNotEmpty(paymentPreference.getString("paymentMethodId")))) {
						try {
							paymentPreference.store();
						} catch (GenericEntityException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						result = ServiceUtil.returnSuccess();
						return result;
					}
				}
			}
			result = ServiceUtil.returnSuccess();
			result.put("type", "none");
			return result;
		} else {
			errMsg = "订单信息丢失！";
			result = ServiceUtil.returnError(errMsg);
			result.put("type", "error");
			return result;
		}
	}

	public static Map<String, Object> checkExternalPayment(Delegator delegator, String orderId) {
		Map<String, Object> result;
		String errMsg = null;
		// warning there can only be ONE payment preference for this to work
		// you cannot accept multiple payment type when using an external
		// gateway
		GenericValue orderHeader = null;
		try {
			orderHeader = delegator.findOne("OrderHeader", false, UtilMisc.toMap("orderId", orderId));
		} catch (GenericEntityException e) {
			Debug.logError(e, "Problems getting order header", module);
			errMsg = "Problems getting order header";
			result = ServiceUtil.returnError(errMsg);
			return result;
		}
		if (orderHeader != null) {
			List<GenericValue> paymentPrefs = null;
			try {
				paymentPrefs = orderHeader.getRelated("OrderPaymentPreference", null, null, false);
			} catch (GenericEntityException e) {
				Debug.logError(e, "Problems getting order payments", module);
				errMsg = "Problems getting order payments";
				result = ServiceUtil.returnError(errMsg);
				return result;
			}
			paymentPrefs = getExternalPaymentPrefs(paymentPrefs);
			if (UtilValidate.isNotEmpty(paymentPrefs)) {
				if (paymentPrefs.size() > 1) {
					Debug.logError("Too many payment preferences, you cannot have more then one when using external gateways", module);
				}
				GenericValue paymentPreference = EntityUtil.getFirst(paymentPrefs);
				String paymentMethodTypeId = paymentPreference.getString("paymentMethodTypeId");
				if (paymentMethodTypeId.startsWith("EXT_")) {
					// PayPal with a PaymentMethod is not an external payment
					// method
					if (!(paymentMethodTypeId.equals("EXT_PAYPAL") && UtilValidate.isNotEmpty(paymentPreference.getString("paymentMethodId")))) {
						String type = paymentMethodTypeId.substring(4);
						result = ServiceUtil.returnSuccess();
						result.put("type", type.toLowerCase());
						return result;
					}
				}
			}
			result = ServiceUtil.returnSuccess();
			result.put("type", "none");
			return result;
		} else {
			errMsg = "";
			result = ServiceUtil.returnError(errMsg);
			result.put("type", "error");
			return result;
		}
	}

	private static List<GenericValue> getExternalPaymentPrefs(List<GenericValue> paymentPrefs) {
		List<GenericValue> externalPaymentPrefs = FastList.newInstance();
		for (GenericValue paymentPref : paymentPrefs) {
			String paymentMethodTypeId = paymentPref.getString("paymentMethodTypeId");
			if (paymentMethodTypeId.startsWith("EXT_")) {
				externalPaymentPrefs.add(paymentPref);
			}
		}
		return externalPaymentPrefs;
	}
}
