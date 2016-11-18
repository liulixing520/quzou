package org.ofbiz.ebiz.order;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.ofbiz.order.shoppingcart.ShoppingCart;
import org.ofbiz.order.shoppingcart.ShoppingCartEvents;
import org.ofbiz.order.shoppingcart.ShoppingCartItem;
import org.ofbiz.order.shoppingcart.shipping.ShippingEstimateWrapper;
import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;

public class OrderEvents {
	public static final String module = OrderEvents.class.getName();
	public static final String resource = "OrderUiLabels";
	public static final String resourceError = "OrderErrorUiLabels";
	public static final int decimals = UtilNumber.getBigDecimalScale("order.decimals");
	public static final int rounding = UtilNumber.getBigDecimalRoundingMode("order.rounding");
	public static final BigDecimal ZERO = BigDecimal.ZERO.setScale(decimals, rounding);

	/**
	 * Return success event. Used as a place holder for events.
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @param response
	 *            HttpServletResponse
	 * @return Response code string
	 */
	public static String returnSuccess(HttpServletRequest request, HttpServletResponse response) {
		return "success";
	}

	/**
	 * Return error event. Used as a place holder for events.
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @param response
	 *            HttpServletResponse
	 * @return Response code string
	 */
	public static String returnError(HttpServletRequest request, HttpServletResponse response) {
		return "error";
	}

	/**
	 * 返回购物车中商品列表、以及根据店铺获取到的支付方式和配送方式
	 * 
	 * @param request
	 * @param response
	 * @return
	 * 
	 *         public static String changeShipMethod(HttpServletRequest request,
	 *         HttpServletResponse response) { HttpSession session =
	 *         request.getSession(); ServletContext application =
	 *         session.getServletContext(); Delegator delegator = (Delegator)
	 *         request.getAttribute("delegator"); GenericValue userLogin =
	 *         (GenericValue) session.getAttribute("userLogin"); LocalDispatcher
	 *         dispatcher = (LocalDispatcher)
	 *         request.getAttribute("dispatcher"); Map<String, Object> context =
	 *         UtilHttp.getParameterMap(request);
	 * 
	 *         ShoppingCart shoppingCart =
	 *         ShoppingCartEvents.getCartObject(request); List<GenericValue>
	 *         productStorePaymentSettingList = null; ShippingEstimateWrapper
	 *         shippingEstWpr = null; List<GenericValue>
	 *         carrierShipmentMethodList = null; String shippingMethod = null;
	 *         BigDecimal shipEstimate = null; String shippingInstructions =
	 *         null; String shipDateEnumId = null; String maySplit = null;
	 *         String giftMessage = null; String isGift = null; String
	 *         internalCode = null; int shipGroupIndex = 0; String methodType =
	 *         null; String shipBeforeDate = null; String shipAfterDate = null;
	 *         String internalOrderNotes = null; String shippingNotes = null;
	 *         Map<String, Object> callResult = ServiceUtil.returnSuccess(); try
	 *         { if (shoppingCart != null) { CheckOutHelper checkOutHelper = new
	 *         CheckOutHelper(dispatcher, delegator, shoppingCart);
	 *         shippingMethod = request.getParameter(shipGroupIndex +
	 *         "_shipping_method"); if (UtilValidate.isEmpty(shippingMethod)) {
	 *         shippingMethod = request.getParameter("shipping_method"); }
	 *         shippingInstructions = request.getParameter(shipGroupIndex +
	 *         "_shipping_instructions"); if
	 *         (UtilValidate.isEmpty(shippingInstructions)) shippingInstructions
	 *         = request.getParameter("shipping_instructions"); maySplit =
	 *         request.getParameter(shipGroupIndex + "_may_split"); if
	 *         (UtilValidate.isEmpty(maySplit)) maySplit =
	 *         request.getParameter("may_split"); giftMessage =
	 *         request.getParameter(shipGroupIndex + "_gift_message"); isGift =
	 *         request.getParameter(shipGroupIndex + "_is_gift"); internalCode =
	 *         request.getParameter("internalCode"); // FIXME shipBeforeDate =
	 *         request.getParameter("sgi" + shipGroupIndex + "_shipBeforeDate");
	 *         shipAfterDate = request.getParameter("sgi" + shipGroupIndex +
	 *         "_shipAfterDate"); internalOrderNotes =
	 *         request.getParameter("internal_order_notes"); shippingNotes =
	 *         request.getParameter("shippingNotes"); if
	 *         (UtilValidate.isNotEmpty(request.getParameter( shipGroupIndex +
	 *         "_ship_estimate"))) { shipEstimate = new
	 *         BigDecimal(request.getParameter(shipGroupIndex +
	 *         "_ship_estimate")); }
	 * 
	 *         if (shipEstimate == null) { // allow ship estimate to be set
	 *         manually if a // purchase order callResult = checkOutHelper
	 *         .finalizeOrderEntryOptions(shipGroupIndex, shippingMethod,
	 *         shippingInstructions, shipDateEnumId, maySplit, giftMessage,
	 *         isGift, internalCode, shipBeforeDate, shipAfterDate,
	 *         internalOrderNotes, shippingNotes); } else { callResult =
	 *         checkOutHelper.finalizeOrderEntryOptions (shipGroupIndex,
	 *         shippingMethod, shippingInstructions, shipDateEnumId, maySplit,
	 *         giftMessage, isGift, internalCode, shipBeforeDate, shipAfterDate,
	 *         internalOrderNotes, shippingNotes, shipEstimate); }
	 * 
	 *         } } catch (Exception e) { e.printStackTrace(); }
	 * 
	 *         return "success"; }
	 */
	/**
	 * 返回购物车中商品列表、以及根据店铺获取到的支付方式和配送方式（放弃使用-已放入groovy）
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static String showCart(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ServletContext application = session.getServletContext();
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		Map<String, Object> context = UtilHttp.getParameterMap(request);
		StringBuffer proListStr = new StringBuffer();
		StringBuffer payMethodStr = new StringBuffer();
		StringBuffer shippingStr = new StringBuffer();
		ShoppingCart shoppingCart = ShoppingCartEvents.getCartObject(request);
		List<GenericValue> productStorePaymentSettingList = null;
		ShippingEstimateWrapper shippingEstWpr = null;
		List<GenericValue> carrierShipmentMethodList = null;
		try {
			if (shoppingCart != null) {
				List<ShoppingCartItem> shoppingCartItems = shoppingCart.items();
				GenericValue productStore = ProductStoreWorker.getProductStore(request);
				productStorePaymentSettingList = productStore.getRelatedCache("ProductStorePaymentSetting");
				shippingEstWpr = new ShippingEstimateWrapper(dispatcher, shoppingCart, 0);
				carrierShipmentMethodList = shippingEstWpr.getShippingMethods();
				payMethodStr.append("<option></option>");
				shippingStr.append("<option></option>");
				proListStr.append("<table id='proListTb' class='border04 overall_03' width='100%' border='0' cellspacing='0' cellpadding='0' >" + "<tr class='title02'><td colspan='6'>商品信息</td><td colspan='2' align='right'><label>" + "<a class='button'  close='closeProdialog' width='580' height='380'  param='{}'" + " href=\"LookupBulkAddProducts?partyId=" + shoppingCart.getPartyId() + "\" target='dialog' mask='true' title='添加商品'><span>添加商品</span></a>" + "</label></td></tr><tr class='background_tr'><td class='border06 width5'>序号</td><td class='border07 width15'>商品编号</td>"
						+ "<td class='border07 width22'>商品名称</td><td class='border07 width10'>单价</td><td class='border07 width5'>数量</td>" + "<td class='border07 width5'>调整</td><td class='border07 width7'>小计</td><td class='border07 width7'>操作</td> </tr>");
				for (ShoppingCartItem cartLine : shoppingCartItems) {
					int cartLineIndex = shoppingCart.getItemIndex(cartLine);
					proListStr.append("<tr class='background_tr'><td class='border06'>" + (cartLineIndex + 1) + "</td>" + "<td class='border06'>" + cartLine.getProduct().get("productId") + "</td>" + "<td class='border06'>" + cartLine.getProduct().get("productName") + "</td>" + "<td class='border06'><input type='text' onblur='changePrice(this)' name='price_" + cartLineIndex + "' readonly value='" + cartLine.getDisplayPrice().setScale(decimals, rounding) + "'></td>" + "<td class='border06'><img width='9' height='9' onclick=\"decreaseProductNum('update_" + cartLineIndex
							+ "')\" src='/images/decrease.gif' style='cursor: pointer;'>&nbsp;" + "<input type='text' name='update_" + cartLineIndex + "' size=''  id='update_" + cartLineIndex + "' readonly value='" + cartLine.getQuantity().setScale(0, 0) + "'>" + "&nbsp;<img width='9' height='9' onclick=\"addProductNum('update_" + cartLineIndex + "')\" src='/images/adding.gif' style='cursor: pointer;'></td>" + "<td class='border06'>" + cartLine.getOtherAdjustments().setScale(decimals, rounding) + "</td>" + "<td class='border06'>"
							+ cartLine.getDisplayItemSubTotal().setScale(decimals, rounding) + "</td>" + "<td class='border06'><a href=\"javascript:deleteProd('update_" + cartLineIndex + "')\">删除</a></td>" + "</tr>");
				}
				proListStr.append("</table>");
				for (GenericValue payMethod : productStorePaymentSettingList) {
					payMethodStr.append("<option value='" + payMethod.get("paymentMethodTypeId") + "'>" + OrderServices.payTypeMap.get(payMethod.get("paymentMethodTypeId")) + "</option>");
				}
				for (GenericValue carrierShipmentMethod : carrierShipmentMethodList) {
					String shippingMethod = carrierShipmentMethod.get("shipmentMethodTypeId") + "@" + carrierShipmentMethod.get("partyId");
					BigDecimal shippingEst = shippingEstWpr.getShippingEstimate(carrierShipmentMethod);
					if (shippingEst != null) {
						shippingStr.append("<option value='" + shippingMethod + "'>" + carrierShipmentMethod.get("description") + "==" + shippingEst.setScale(decimals, rounding) + "</option>");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("proListStr", proListStr.toString());
		request.setAttribute("payMethodStr", payMethodStr.toString());
		request.setAttribute("shippingStr", shippingStr.toString());
		return "success";
	}

	/**
	 * 返回购物车中订单总额、促销优惠、运费等信息（放弃使用-已放入groovy）
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static String getOrderTotal(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ServletContext application = session.getServletContext();
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		Map<String, Object> context = UtilHttp.getParameterMap(request);
		StringBuffer totalStr = new StringBuffer();
		ShoppingCart shoppingCart = ShoppingCartEvents.getCartObject(request);
		BigDecimal shippingAmount = ZERO;
		String shippingTotal = "";
		String currencyUomId = ShoppingCartEvents.getCartObject(request).getCurrency();
		try {
			if (shoppingCart != null) {
				// shippingAmount =
				// OrderReadHelper.getAllOrderItemsAdjustmentsTotal(shoppingCart.makeOrderItems(),shoppingCart.getAdjustments(),
				// false, false, true);
				// shippingAmount =
				// shippingAmount.add(OrderReadHelper.calcOrderAdjustments(shoppingCart.getAdjustments(),
				// shoppingCart.getSubTotal(), false, false, true));
				Map shipCost = org.ofbiz.order.shoppingcart.shipping.ShippingEvents.getShipGroupEstimate(dispatcher, delegator, shoppingCart, 0);
				if (shipCost != null) {
					shippingAmount = (BigDecimal) shipCost.get("shippingTotal");
				}
				if (shippingAmount.compareTo(ZERO) > 0)
					shippingTotal = org.ofbiz.base.util.UtilFormatOut.formatCurrency(shippingAmount, currencyUomId, UtilHttp.getLocale(request));
				totalStr.append("<table id='proListTb' class='border04 overall_03' width='100%' border='0' cellspacing='0' cellpadding='0' >" + "<tr class='title02'><td colspan='6'>订单总额</td></tr>");
				totalStr.append("<tr><td colspan='5'></td><td colspan='right'>小计：" + shoppingCart.getSubTotal().setScale(decimals, rounding) + "</td></tr>");
				totalStr.append("<tr><td colspan='5'></td><td colspan='right'>促销优惠：" + shoppingCart.getProductPromoTotal().setScale(decimals, rounding) + "</td></tr>");
				// totalStr.append("<tr><td colspan='5'></td><td colspan='right'>运费："+shippingAmount.setScale(decimals,
				// rounding)+"</td></tr>");
				totalStr.append("<tr><td colspan='5'></td><td colspan='right'>运费：" + shippingTotal + "</td></tr>");
				totalStr.append("<tr><td colspan='5'></td><td colspan='right'>总额：<span id='payTotal'>" + shoppingCart.getGrandTotal().setScale(decimals, rounding) + "</span></td></tr>");
				totalStr.append("</table>");

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("totalStr", totalStr.toString());
		return "success";
	}

	/**
	 * 快速添加返回处理-关闭或刷新列表页- 若有余额支付或积分抵现则进行支付（相当于ofbiz订单详情里支付-金融账户-授权操作）
	 * 记录属性信息-发票内容-发货时间等保存至order_attribute
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static String returnQuick(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
		String orderId = null;
		String invoiceTitle = "";
		String invoiceText = "";
		String shippmentDateType = "";
		String noteString = "";
		try {
			orderId = request.getAttribute("orderId") != null ? request.getAttribute("orderId").toString() : orderId;
			invoiceTitle = request.getParameter("invoiceTitle");
			GenericValue gv = delegator.makeValue("OrderAttribute", UtilMisc.toMap("orderId", orderId, "attrName", "invoiceTitle", "attrValue", invoiceTitle));
			gv.create();
			invoiceText = request.getParameter("invoiceText");
			GenericValue gvt = delegator.makeValue("OrderAttribute", UtilMisc.toMap("orderId", orderId, "attrName", "invoiceText", "attrValue", invoiceText));
			gvt.create();
			shippmentDateType = request.getParameter("shippmentDateType");
			GenericValue gvd = delegator.makeValue("OrderAttribute", UtilMisc.toMap("orderId", orderId, "attrName", "shippmentDateType", "attrValue", shippmentDateType));
			gvd.create();
			noteString = request.getParameter("noteString");
			Map<String, Object> noteCtx = UtilMisc.<String, Object> toMap("note", noteString, "userLogin", userLogin, "noteName", "orderNote");

			Map<String, Object> noteRes = dispatcher.runSync("createNote", noteCtx);
			Map<String, String> fields = UtilMisc.<String, String> toMap("orderId", orderId, "noteId", (String) noteRes.get("noteId"), "internalNote", "Y");
			GenericValue v = delegator.makeValue("OrderHeaderNote", fields);
			delegator.create(v);

			// 余额支付和积分抵现执行金融账户捕捉操作
			GenericValue ogv = EntityUtil.getFirst(delegator.findByAnd("OrderPaymentPreference", UtilMisc.toMap("orderId", orderId, "paymentMethodTypeId", "EXT_USER_ACCOUNT")));

			Map<String, Object> authMap = FastMap.newInstance();
			Map<String, Object> captureMap = FastMap.newInstance();

			authMap.put("orderPaymentPreferenceId", ogv.get("orderPaymentPreferenceId"));
			authMap.put("overrideAmount", ogv.get("maxAmount"));
			authMap.put("userLogin", userLogin);
			dispatcher.runSync("authOrderPaymentPreference", authMap);

			captureMap.put("orderId", ogv.get("orderId"));
			captureMap.put("captureAmount", ogv.get("maxAmount"));
			// captureMap.put("paymentMethodTypeId", "EXT_USER_ACCOUNT");
			// captureMap.put("paymentTypeId", "CUSTOMER_DEPOSIT");
			captureMap.put("userLogin", userLogin);
			dispatcher.runSync("captureOrderPayments", captureMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("callbackType", request.getParameter("callbackType"));
		request.setAttribute("navTabId", request.getParameter("navTabId"));

		return "success";
	}

	/**
	 * 订单修改 记录属性信息-发票内容-发货时间等保存至order_attribute
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static String updateOrderOther(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
		String orderId = null;
		String noteId = null;
		String invoiceTitle = "";
		String invoiceText = "";
		String shippmentDateType = "";
		String noteString = "";
		try {
			orderId = request.getParameter("orderId");
			invoiceTitle = request.getParameter("invoiceTitle");
			GenericValue gv = EntityUtil.getFirst(delegator.findByAnd("OrderAttribute", UtilMisc.toMap("orderId", orderId, "attrName", "invoiceTitle")));
			gv.set("attrValue", invoiceTitle);
			gv.store();
			invoiceText = request.getParameter("invoiceText");
			GenericValue gvt = EntityUtil.getFirst(delegator.findByAnd("OrderAttribute", UtilMisc.toMap("orderId", orderId, "attrName", "invoiceText")));
			gvt.set("attrValue", invoiceText);
			gvt.store();
			shippmentDateType = request.getParameter("shippmentDateType");
			GenericValue gvd = EntityUtil.getFirst(delegator.findByAnd("OrderAttribute", UtilMisc.toMap("orderId", orderId, "attrName", "shippmentDateType")));
			gvd.set("attrValue", shippmentDateType);
			gvd.store();
			noteString = request.getParameter("noteString");
			noteId = request.getParameter("noteId");
			Map<String, Object> noteCtx = UtilMisc.<String, Object> toMap("noteId", noteId, "noteInfo", noteString, "userLogin", userLogin, "noteName", "orderNote");

			Map<String, Object> noteRes = dispatcher.runSync("updateNote", noteCtx);

		} catch (Exception e) {
			e.printStackTrace();
		}
		// request.setAttribute("callbackType",request.getParameter("callbackType"));
		// request.setAttribute("navTabId",request.getParameter("navTabId"));

		return "success";
	}

	/**
	 * 批量处理退货单
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static String updateReturnAll(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
		String returnIds = null;
		String message = "";
		try {
			returnIds = request.getParameter("orderIndexs");
			String returnIdsArray[] = returnIds.split(",");
			for (int i = 0; i < returnIdsArray.length; i++) {
				Map<String, Object> contextMap = FastMap.newInstance();
				contextMap.put("returnId", returnIdsArray[i]);

				// contextMap.put("userLogin", userLogin);
				dispatcher.runSync("updateReturnHeader", contextMap);
				message = "操作成功";
			}
		} catch (Exception e) {
			message = "操作失败";
			e.printStackTrace();
		}
		request.setAttribute("message", message);
		// request.setAttribute("callbackType",request.getParameter("callbackType"));
		// request.setAttribute("navTabId",request.getParameter("navTabId"));

		return "success";
	}

	/**
	 * 后台支付
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static String backPaymentOrder(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
		Locale locale = UtilHttp.getLocale(request);
		String message = "操作成功";
		String orderId = request.getParameter("orderId");
		// add by wsz
		try {
			// get the order header & payment preferences
			GenericValue orderHeader = null;
			try {
				orderHeader = delegator.findByPrimaryKey("OrderHeader", UtilMisc.toMap("orderId", orderId));
			} catch (GenericEntityException e) {
				Debug.logError(e, "Problems reading order header from datasource.", module);
				request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceError, "OrderProblemsReadingOrderHeaderInformation", locale));
				return "error";
			}

			BigDecimal grandTotal = BigDecimal.ZERO;
			if (orderHeader != null) {
				grandTotal = orderHeader.getBigDecimal("grandTotal");
			}

			// get the payment types to receive
			List<GenericValue> paymentMethodTypes = null;

			try {
				EntityExpr ee = EntityCondition.makeCondition("paymentMethodTypeId", EntityOperator.NOT_EQUAL, "EXT_OFFLINE");
				paymentMethodTypes = delegator.findList("PaymentMethodType", ee, null, null, null, false);
			} catch (GenericEntityException e) {
				Debug.logError(e, "Problems getting payment types", module);
				request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceError, "OrderProblemsWithPaymentTypeLookup", locale));
				return "error";
			}

			if (paymentMethodTypes == null) {
				request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceError, "OrderProblemsWithPaymentTypeLookup", locale));
				return "error";
			}

			List<GenericValue> toBeStored = FastList.newInstance();
			GenericValue placingCustomer = null;
			try {
				List<GenericValue> pRoles = delegator.findByAnd("OrderRole", UtilMisc.toMap("orderId", orderId, "roleTypeId", "PLACING_CUSTOMER"));
				if (UtilValidate.isNotEmpty(pRoles))
					placingCustomer = EntityUtil.getFirst(pRoles);
			} catch (GenericEntityException e) {
				Debug.logError(e, "Problems looking up order payment preferences", module);
				request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceError, "OrderErrorProcessingOfflinePayments", locale));
				return "error";
			}

			Iterator<GenericValue> pmti = paymentMethodTypes.iterator();
			while (pmti.hasNext()) {
				GenericValue paymentMethodType = pmti.next();
				String paymentMethodTypeId = paymentMethodType.getString("paymentMethodTypeId");
				String amountStr = request.getParameter(paymentMethodTypeId + "_amount");
				String paymentReference = request.getParameter(paymentMethodTypeId + "_reference");
				if (!UtilValidate.isEmpty(amountStr)) {
					BigDecimal paymentTypeAmount = BigDecimal.ZERO;
					try {
						paymentTypeAmount = (BigDecimal) ObjectType.simpleTypeConvert(amountStr, "BigDecimal", null, locale);
					} catch (GeneralException e) {
						request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceError, "OrderProblemsPaymentParsingAmount", locale));
						return "error";
					}
					if (paymentTypeAmount.compareTo(BigDecimal.ZERO) > 0) {

						// create the OrderPaymentPreference
						// TODO: this should be done with a service
						Map<String, String> prefFields = UtilMisc.<String, String> toMap("orderPaymentPreferenceId", delegator.getNextSeqId("OrderPaymentPreference"));
						GenericValue paymentPreference = delegator.makeValue("OrderPaymentPreference", prefFields);
						paymentPreference.set("paymentMethodTypeId", paymentMethodType.getString("paymentMethodTypeId"));
						paymentPreference.set("maxAmount", paymentTypeAmount);
						paymentPreference.set("statusId", "PAYMENT_RECEIVED");
						paymentPreference.set("orderId", orderId);
						paymentPreference.set("createdDate", UtilDateTime.nowTimestamp());
						if (userLogin != null) {
							paymentPreference.set("createdByUserLogin", userLogin.getString("userLoginId"));
						}

						try {
							delegator.create(paymentPreference);
						} catch (GenericEntityException ex) {
							Debug.logError(ex, "Cannot create a new OrderPaymentPreference", module);
							request.setAttribute("_ERROR_MESSAGE_", ex.getMessage());
							return "error";
						}

						// create a payment record
						Map<String, Object> results = null;
						try {
							results = dispatcher.runSync("createPaymentFromPreference", UtilMisc.toMap("userLogin", userLogin, "orderPaymentPreferenceId", paymentPreference.get("orderPaymentPreferenceId"), "paymentRefNum", paymentReference, "paymentFromId", placingCustomer.getString("partyId"), "comments", "Payment received offline and manually entered."));
						} catch (GenericServiceException e) {
							Debug.logError(e, "Failed to execute service createPaymentFromPreference", module);
							request.setAttribute("_ERROR_MESSAGE_", e.getMessage());
							return "error";
						}

						if ((results == null) || (results.get(ModelService.RESPONSE_MESSAGE).equals(ModelService.RESPOND_ERROR))) {
							Debug.logError((String) results.get(ModelService.ERROR_MESSAGE), module);
							request.setAttribute("_ERROR_MESSAGE_", results.get(ModelService.ERROR_MESSAGE));
							return "error";
						}
					}
				}
			}

			// get the current payment prefs
			GenericValue offlineValue = null;
			List<GenericValue> currentPrefs = null;
			BigDecimal paymentTally = BigDecimal.ZERO;
			try {
				EntityConditionList<EntityExpr> ecl = EntityCondition.makeCondition(UtilMisc.toList(EntityCondition.makeCondition("orderId", EntityOperator.EQUALS, orderId), EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "PAYMENT_CANCELLED")), EntityOperator.AND);
				currentPrefs = delegator.findList("OrderPaymentPreference", ecl, null, null, null, false);
			} catch (GenericEntityException e) {
				Debug.logError(e, "ERROR: Unable to get existing payment preferences from order", module);
			}
			if (UtilValidate.isNotEmpty(currentPrefs)) {
				Iterator<GenericValue> cpi = currentPrefs.iterator();
				while (cpi.hasNext()) {
					GenericValue cp = cpi.next();
					String paymentMethodType = cp.getString("paymentMethodTypeId");
					if ("EXT_OFFLINE".equals(paymentMethodType)) {
						offlineValue = cp;
					} else {
						BigDecimal cpAmt = cp.getBigDecimal("maxAmount");
						if (cpAmt != null) {
							paymentTally = paymentTally.add(cpAmt);
						}
					}
				}
			}

			// now finish up
			boolean okayToApprove = false;
			if (paymentTally.compareTo(grandTotal) >= 0) {
				// cancel the offline preference
				okayToApprove = true;
				if (offlineValue != null) {
					offlineValue.set("statusId", "PAYMENT_CANCELLED");
					toBeStored.add(offlineValue);
				}
			}

			// store the status changes and the newly created payment
			// preferences
			// and payments
			// TODO: updating order payment preference should be done with a
			// service
			try {
				delegator.storeAll(toBeStored);
			} catch (GenericEntityException e) {
				Debug.logError(e, "Problems storing payment information", module);
				request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceError, "OrderProblemStoringReceivedPaymentInformation", locale));
				return "error";
			}

			if (okayToApprove) {
				// update the status of the order and items
				OrderChangeHelper.approveOrder(dispatcher, userLogin, orderId);
			}

		} catch (Exception e) {
			Debug.logError(e.toString(), module);
		} finally {
			try {
				Map<String, Object> setSaleOrderPaymentStatusResult = dispatcher.runSync("setSaleOrderPaymentStatus", UtilMisc.toMap("orderId", orderId));
			} catch (GenericServiceException e) {
				Debug.logError(e.toString(), module);
			}
		}

		request.setAttribute("message", message);
		return "success";
	}

	/**
	 * 后台退款
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static String cancelPaymentOrder(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
		Locale locale = UtilHttp.getLocale(request);
		String message = "操作成功";
		String orderId = request.getParameter("orderId");

		// get the order header & payment preferences
		GenericValue orderHeader = null;
		try {
			orderHeader = delegator.findByPrimaryKey("OrderHeader", UtilMisc.toMap("orderId", orderId));
		} catch (GenericEntityException e) {
			Debug.logError(e, "Problems reading order header from datasource.", module);
			request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceError, "OrderProblemsReadingOrderHeaderInformation", locale));
			return "error";
		}

		BigDecimal grandTotal = BigDecimal.ZERO;
		if (orderHeader != null) {
			grandTotal = orderHeader.getBigDecimal("grandTotal");
		}

		List<GenericValue> toBeStored = FastList.newInstance();
		GenericValue placingCustomer = null;
		try {
			List<GenericValue> pRoles = delegator.findByAnd("OrderRole", UtilMisc.toMap("orderId", orderId, "roleTypeId", "PLACING_CUSTOMER"));
			if (UtilValidate.isNotEmpty(pRoles))
				placingCustomer = EntityUtil.getFirst(pRoles);
		} catch (GenericEntityException e) {
			Debug.logError(e, "Problems looking up order payment preferences", module);
			request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceError, "OrderErrorProcessingOfflinePayments", locale));
			return "error";
		}
		/*
		 * boolean beganTransaction = false; try { beganTransaction =
		 * TransactionUtil.begin();
		 */
		// get the current payment prefs
		List<GenericValue> currentPrefs = null;
		try {
			EntityConditionList<EntityExpr> ecl = EntityCondition.makeCondition(UtilMisc.toList(EntityCondition.makeCondition("orderId", EntityOperator.EQUALS, orderId), EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "PAYMENT_CANCELLED")), EntityOperator.AND);
			currentPrefs = delegator.findList("OrderPaymentPreference", ecl, null, null, null, false);
		} catch (GenericEntityException e) {
			Debug.logError(e, "ERROR: Unable to get existing payment preferences from order", module);
		}
		if (UtilValidate.isNotEmpty(currentPrefs)) {
			Iterator<GenericValue> cpi = currentPrefs.iterator();
			while (cpi.hasNext()) {
				GenericValue cp = cpi.next();
				// 取消支付，返回相应地账户
				try {
					Map<String, Object> payCtx = FastMap.newInstance();
					payCtx.put("orderPaymentPreferenceId", cp.getString("orderPaymentPreferenceId"));
					payCtx.put("statusId", "PAYMENT_CANCELLED");
					payCtx.put("orderId", orderId);
					payCtx.put("userLogin", userLogin);
					Map<String, Object> updateOrderPaymentPreferenceResult = dispatcher.runSync("updateOrderPaymentPreference", payCtx);
				} catch (GenericServiceException e) {
					Debug.logError(e.toString(), module);
				}
				BigDecimal amount = cp.getBigDecimal("maxAmount");
				String paymentMethodType = cp.getString("paymentMethodTypeId");
				String finAccountId = cp.getString("finAccountId");
				if ("FINACT_USERCARD".equals(paymentMethodType)) {// 会员卡
					// call the deposit service
					Map<String, Object> depositCtx = FastMap.newInstance();
					depositCtx.put("finAccountId", finAccountId);
					// depositCtx.put("productStoreId",
					// orderHeader.getString("productStoreId"));
					// depositCtx.put("isRefund", Boolean.TRUE);
					// depositCtx.put("currency",
					// orderHeader.getString("currencyUOM"));
					// depositCtx.put("partyId",
					// placingCustomer.getString("partyId"));
					// depositCtx.put("orderId", orderId);
					depositCtx.put("amount", amount);
					// depositCtx.put("reasonEnumId", "FATR_REFUND");
					depositCtx.put("userLogin", userLogin);

					Map<String, Object> depositResp;
					try {
						depositResp = dispatcher.runSync("finAccountDeposit", depositCtx);
					} catch (GenericServiceException e) {
						Debug.logError(e, module);
						return "error";
					}
					if (ServiceUtil.isError(depositResp)) {
						return "error";
					}

				} else if ("CASH".equals(paymentMethodType) || "FINACT_USERACCT".equals(paymentMethodType) || "EXT_ALIPAY_DIRECT".equals(paymentMethodType)) {
					if (UtilValidate.isEmpty(finAccountId)) {
						finAccountId = getFinAccountByParty(delegator, placingCustomer.getString("partyId"));
					}
					String statusId = "FINACT_TRNS_APPROVED";
					String finAccountTransTypeId = "DEPOSIT";
					String comments = request.getParameter("comments");
					Map context = FastMap.newInstance();
					context.put("finAccountId", finAccountId);
					context.put("statusId", statusId);
					context.put("finAccountTransTypeId", finAccountTransTypeId);
					context.put("partyId", placingCustomer.getString("partyId"));
					context.put("amount", amount);
					context.put("comments", comments);
					context.put("userLogin", userLogin);
					try {
						dispatcher.runSync("createFinAccountTransLt", context);
					} catch (GenericServiceException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						return "error";
					}
				}
			}
		}

		// 改订单的支付状态为已退款
		if (orderHeader != null) {
			orderHeader.set("paymentStatus", "4");
			toBeStored.add(orderHeader);
		}
		// store the status changes and the newly created payment preferences
		// and payments
		// TODO: updating order payment preference should be done with a service
		try {
			delegator.storeAll(toBeStored);
		} catch (GenericEntityException e) {
			Debug.logError(e, "Problems storing payment information", module);
			request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceError, "OrderProblemStoringReceivedPaymentInformation", locale));
			return "error";
		}
		// 礼券部分退回
		// OrderProductPromoCode
		// 会员减积分操作
		try {
			Map<String, Object> redeemRewardPointsFromByOrderResult = dispatcher.runSync("redeemRewardPointsFromByOrder", UtilMisc.toMap("orderId", orderId, "userLogin", userLogin));
		} catch (GenericServiceException e) {
			Debug.logError("会员减积分出错：" + e.toString(), module);
		}
		/*
		 * } catch (GenericTransactionException e1) { try { // only rollback the
		 * transaction if we started one...
		 * TransactionUtil.rollback(beganTransaction,
		 * "Error looking up entity values in WebTools Entity Data Maintenance",
		 * e1); } catch (GenericEntityException e2) { Debug.logError(e2,
		 * "Could not rollback transaction: " + e2.toString(), module); } }
		 */
		request.setAttribute("message", message);
		return "success";
	}

	public static String editPostalAddress(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
		Locale locale = UtilHttp.getLocale(request);

		Map context = FastMap.newInstance();
		context.put("toName", request.getParameter("toName"));
		context.put("address1", request.getParameter("address1"));
		context.put("stateProvinceGeoId", request.getParameter("stateProvinceGeoId"));
		context.put("cityGeoId", request.getParameter("cityGeoId"));
		context.put("countyGeoId", request.getParameter("countyGeoId"));
		context.put("postalCode", request.getParameter("postalCode"));
		context.put("mobileExd", request.getParameter("mobileExd"));
		context.put("phoneExd", request.getParameter("phoneExd"));
		context.put("contactMechId", request.getParameter("contactMechId"));
		context.put("userLogin", userLogin);
		try {
			dispatcher.runSync("updatePostalAddr", context);
			return "success";
		} catch (GenericServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "error";
	}

	/*
	 * 根据partyId获取金融账户ID
	 */
	public static String getFinAccountByParty(Delegator delegator, String partyId) {
		String finAccountId = getFinAccountByParty(delegator, partyId, "STORE_USER_ACCT");
		if (UtilValidate.isEmpty(finAccountId)) {
			finAccountId = "100";
		}
		return finAccountId;

	}

	/*
	 * 根据partyId获取金融账户ID
	 */
	public static String getFinAccountByParty(Delegator delegator, String partyId, String finAccountTypeId) {
		String finAccountId = null;
		List list = new ArrayList();
		try {
			list = delegator.findByAnd("FinAccount", UtilMisc.toMap("ownerPartyId", partyId, "finAccountTypeId", finAccountTypeId));
			list = EntityUtil.filterByDate(list);
			if (list != null && list.size() > 0) {
				finAccountId = ((Map) list.get(0)).get("finAccountId").toString();
			}
		} catch (GenericEntityException e) {
			Debug.logError(e, "Error finding PartyNameView in getPartyName", module);
		}
		return finAccountId;

	}

	/*
	 * 存储参数准备支付
	 */
	public static String prapareUserPayOrder(HttpServletRequest request, HttpServletResponse response) {
		String orderId = request.getParameter("orderId");
		if (orderId != null) {
			request.getSession().setAttribute("orderIdList", UtilMisc.toList(orderId));
			return "success";
		} else {
			return "error";
		}
	}

	public static String doSendOrder(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		String trackingNumber = request.getParameter("trackingNumber");
		String contactMecheId = request.getParameter("contactMecheId");
		String orderId = request.getParameter("orderId");

		HttpSession session = request.getSession();
		Locale locale = UtilHttp.getLocale(request);

		GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");

		if (orderId == null || orderId.trim().equals("")) {
			request.setAttribute("_ERROR_MESSAGE_", "订单信息丢失！");
			return "success";
		}
		if (trackingNumber == null || trackingNumber.trim().equals("")) {
			request.setAttribute("_ERROR_MESSAGE_", "请输入快递单号！");
			return "success";
		}
		try {
			GenericValue order = delegator.findOne("OrderHeader", false, UtilMisc.toMap("orderId", orderId));
			if (order != null) {
				GenericValue orderItemShipGroup = EntityUtil.getFirst(delegator.findByAnd("OrderItemShipGroup", UtilMisc.toMap("orderId", orderId), null, false));
				if (orderItemShipGroup == null) {
					request.setAttribute("_ERROR_MESSAGE_", "订单快递信息丢失！");
					return "success";
				} else {
					// 设置默认仓库
					GenericValue gv = EntityUtil.getFirst(delegator.findByAnd("Facility", UtilMisc.toMap("ownerPartyId", order.get("productStoreId"))));
					if (UtilValidate.isNotEmpty(gv)) {
						orderItemShipGroup.set("facilityId", gv.getString("facilityId"));
					}
					orderItemShipGroup.set("trackingNumber", trackingNumber);
					orderItemShipGroup.store();
				}
				if (contactMecheId != null && !contactMecheId.trim().equals("")) {
					delegator.create("OrderContactMech", UtilMisc.toMap("orderId", orderId, "contactMechId", contactMecheId, "contactMechPurposeTypeId", "SHIP_ORIG_LOCATION"));
				}

				// order.set("statusId", "ORDER_SENT");
				// order.store();

				Map<String, ? extends Object> statusCtx = UtilMisc.toMap("userLogin", userLogin, "orderId", orderId, "statusId", "ORDER_SENT", "setItemStatus", "Y");
				Map<String, Object> statusResp;
				try {
					statusResp = dispatcher.runSync("changeOrderStatusLt", statusCtx);
				} catch (GenericServiceException e) {
					Debug.logError(e, module);
					request.setAttribute("_ERROR_MESSAGE_", e.getMessage());
					return "success";
				}

				Map<String, ? extends Object> permSvcCtx = UtilMisc.toMap("userLogin", userLogin, "orderId", orderId);
				Map<String, Object> permSvcResp;
				try {
					permSvcResp = dispatcher.runSync("quickShipEntireOrder", permSvcCtx);
				} catch (GenericServiceException e) {
					Debug.logError(e, module);
					request.setAttribute("_ERROR_MESSAGE_", e.getMessage());
					return "success";
				}

			}
		} catch (Exception e) {
			Debug.logError(e, module);
			request.setAttribute("_ERROR_MESSAGE_", e.getMessage());
			return "success";
		}
		return "success";
	}

	public static String checkPaymentMethod(HttpServletRequest request, HttpServletResponse response) {
		Object checkOutPaymentId = request.getAttribute("checkOutPaymentId");
		if (checkOutPaymentId == null) {
			checkOutPaymentId = request.getSession().getAttribute("checkOutPaymentId");
		}
		if (checkOutPaymentId == null) {
			return "error";
		}
		return (String) checkOutPaymentId;
	}

	public static String checkPaymentStatus(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		HttpSession session = request.getSession();
		String orderIdListStr = request.getParameter("orderIdList");

		if (orderIdListStr == null || orderIdListStr.equals("")) {
			request.setAttribute("info", "没有待支付的订单！");
			return "success";
		}
		List<String> orderIdList = Arrays.asList(orderIdListStr.split(","));
		boolean allBeanPaid = true;
		try {
			List<GenericValue> orderList = delegator.findList("OrderHeader", EntityCondition.makeCondition("orderId", EntityOperator.IN, orderIdList), null, null, null, false);
			for (GenericValue order : orderList) {
				String statusId = order.getString("statusId");
				if(statusId.equals("ORDER_CREATED")){
					allBeanPaid = false;
				}
			}
			if(allBeanPaid){
				return "success";
			}
			request.setAttribute("info", "订单未完成支付！");
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			request.setAttribute("info", e.getMessage());
			return "success";
		}
		return "success";
	}

}
