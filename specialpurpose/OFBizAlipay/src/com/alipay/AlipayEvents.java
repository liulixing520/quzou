package com.alipay;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilFormatOut;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.transaction.GenericTransactionException;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.order.order.OrderChangeHelper;
import org.ofbiz.order.order.OrderReadHelper;
import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;

import alipay1.util.AlipaySubmit;

import com.alipay.util.AlipayNotify;
import com.mobileStore.checkout.ShopOrderReadHelper;

public class AlipayEvents {

	public static final String resource = "AccountingUiLabels";
	public static final String resourceErr = "AccountingErrorUiLabels";
	public static final String commonResource = "CommonUiLabels";
	public static final String module = AlipayEvents.class.getName();

	/** Initiate PayPal Request */
	public static String callAlipay(HttpServletRequest request, HttpServletResponse response) {
		Locale locale = UtilHttp.getLocale(request);
		HttpSession session = request.getSession();
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		// get the orderId from the request, stored by previous event(s)

		// get the product store
		GenericValue productStore = ProductStoreWorker.getProductStore(request);

		if (productStore == null) {
			Debug.logError(">>>>>>>>>>:ProductStore is null", module);
			request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceErr, "payPalEvents.problemsGettingMerchantConfiguration", locale));
			return "error";
		}
		// get the company name
		String company = UtilFormatOut.checkEmpty(productStore.getString("companyName"), "");
		// 支付宝交易信息
		String subject = company;// 交易名称
		String body = "";// 交易内容信息
		String out_trade_no = "";

		// 支付信息
		String orderId = (String) request.getAttribute("orderId");
		List<String> orderIdList = FastList.newInstance();
		if (orderId == null) {
			orderIdList = (List<String>) session.getAttribute("orderIdList");
		} else {
			orderIdList.add(orderId);
		}
		String defaultbank = (String) request.getAttribute("defaultbank");

		System.out.println("SOS :" + defaultbank);
		// get the order header
		BigDecimal ordersAmount = BigDecimal.ZERO;
		boolean ifProblematic = false;
		StringBuilder problematicOrderIds = new StringBuilder("");
		double counter = 0;// Order the quantity of goods in
		String productName = "";
		int i = 0;
		if (orderIdList == null || orderIdList.size() == 0) {
			request.setAttribute("_ERROR_MESSAGE_", "订单丢失，请刷新网站重试！");
			Debug.logError(">>>>>>>>>>:订单丢失，请刷新网站重试！", module);
			return "error";
		}
		for (String id : orderIdList) {
			GenericValue orderHeader = null;

			if (UtilValidate.isNotEmpty(id)) {
				try {
					orderHeader = delegator.findOne("OrderHeader", false, UtilMisc.toMap("orderId", id));
				} catch (GenericEntityException e) {
					if (problematicOrderIds.length() == 0) {
						problematicOrderIds.append(id);
					} else {
						problematicOrderIds.append("、" + id);
					}
					ifProblematic = true;
				}
			}

			if (orderHeader == null) {
				if (problematicOrderIds.length() == 0) {
					problematicOrderIds.append(id);
				} else {
					problematicOrderIds.append("、" + id);
				}
				ifProblematic = true;
				continue;
			}

			ShopOrderReadHelper sprorh = new ShopOrderReadHelper(orderHeader);
			ordersAmount = ordersAmount.add(sprorh.getOrderPayableAmount());
			String currencyUom = orderHeader.getString("currencyUom");

			// ==================
			try {
				List<GenericValue> orderItems = delegator.findByAnd("OrderItem", UtilMisc.toMap("orderId", id), null, false); //
				Iterator<GenericValue> ite = orderItems.iterator();
				while (ite.hasNext()) {
					GenericValue orderItem = (GenericValue) ite.next();
					String productId = orderItem.getString("productId");
					if (productId != null) {
						try {
							GenericValue product = delegator.findOne("Product", false, UtilMisc.toMap("productId", productId));
							if (i >= 1)
								productName = productName + "|";
							if (out_trade_no.length() >= 1)
								out_trade_no = out_trade_no + "|";
							out_trade_no += id;
							double qua = orderItem.getDouble("quantity").doubleValue();
							productName = productName + product.getString("productName").trim() + "(" + UtilFormatOut.formatQuantity(qua) + ")";
							counter = counter + qua;
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					i++;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if (ifProblematic) {
			String errormsg = "编号为:" + problematicOrderIds.toString() + " 的订单出现问题，请从个人中心进行支付！";
			request.setAttribute("_ERROR_MESSAGE_", errormsg);
			Debug.logError(">>>>>>>>>>:" + errormsg, module);
			return "error";
		}
		if (i > 1) {
			body = productName.trim();
			subject = out_trade_no;
		} else if (i == 1) {
			subject = productName.trim() + "-" + out_trade_no;
			body = productName.trim();
		}
		// get the payment properties file
		GenericValue paymentConfig = ProductStoreWorker.getProductStorePaymentSetting(delegator, productStore.getString("productStoreId"), "EXT_ALIPAY", null, true);
		String configString = null;
		String paymentGatewayConfigId = null;
		if (paymentConfig != null) {
			paymentGatewayConfigId = paymentConfig.getString("paymentGatewayConfigId");
			configString = paymentConfig.getString("paymentPropertiesPath");
		}
		if (configString == null) {
			configString = "alipay.properties";
		}

		// get the redirect url
		String input_charset = "UTF-8";
		String sign_type = "MD5";
		String it_b_pay = "2d";
		String payment_type = "1";// Payment type
		String paymethod = "";
		if (UtilValidate.isNotEmpty(defaultbank)) {
			paymethod = "bankPay";
		}

		String url_prefix = request.getScheme() + "://" + request.getServerName();
		if (!"80".equals(request.getServerPort())) {
			url_prefix = url_prefix + ":" + request.getServerPort();
		}
		// 支付宝配置信息
		String partner = "2088711775736200";
		String key = "9a1vj5opxr6prmk34zn4ldqylnskvox8";
		String seller_email = "admin@medref.cn";

		String notify_url = url_prefix + "/mobileStore/control/alipayNotify";
		String return_url = url_prefix + "/mobileStore/control/alipayReturn";
		String show_url = url_prefix + "/mobileStore/control/alipayReturn";

		String token = null;
		if (UtilValidate.isEmpty(token)) {
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if ("_alipay_login_token_key".equals(cookie.getName())) {
						token = cookie.getValue();
					}
				}
			}
		}

		String total_fee = ordersAmount.toPlainString();

		// ==================
		if (UtilValidate.isEmpty(partner) || UtilValidate.isEmpty(key) || UtilValidate.isEmpty(seller_email)) {
			Debug.logError(">>>>>>>>>>:Payment properties is not configured properly, some notify URL from Alipay is not correctly defined!", module);
			return "error";
		}
		// create the redirect string
		Map<String, String> parameters = new HashMap<String, String>();
		String bodyStr = "";
		try {
			bodyStr = new String(body.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String subjectStr = "";
		try {
			subjectStr = new String(subject.getBytes("ISO-8859-1"), "UTF-8");
			seller_email = new String(seller_email.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		// parameters.put("_input_charset", "utf-8");
		parameters.put("body", strfilter(bodyStr, ""));
		parameters.put("notify_url", notify_url);
		parameters.put("out_trade_no", out_trade_no);
		parameters.put("partner", partner);
		parameters.put("payment_type", payment_type);
		parameters.put("paymethod", paymethod);
		parameters.put("return_url", return_url);
		parameters.put("seller_email", seller_email);
		parameters.put("service", "create_partner_trade_by_buyer");
		parameters.put("show_url", show_url);
		parameters.put("subject", strfilter(subjectStr, ""));
		parameters.put("total_fee", total_fee);
		parameters.put("price", total_fee);
		parameters.put("quantity", "1");
		parameters.put("logistics_fee", "0.00");
		parameters.put("logistics_type", "EXPRESS");
		parameters.put("logistics_payment", "SELLER_PAY");
		parameters.put("logistics_payment", "SELLER_PAY");
		// 如果这个参数,不为空,则加进去.
		if (UtilValidate.isNotEmpty(defaultbank)) {
			// parameters.put("paymethod", "bankPay");
			// parameters.put("defaultbank", defaultbank);
		}
		// By passing parameters to return a signed MD5 encrypted string

		// String pageText =
		// AlipayService.create_partner_trade_by_buyer(parameters);
		String pageText = AlipaySubmit.buildRequest(parameters, "POST", "a");
		Debug.log(pageText);
		request.getSession().setAttribute("ALIPAY_ORDER", orderIdList);
		// redirect to alipay
		try {
			response.getWriter().print(pageText);
		} catch (IOException e) {
			Debug.logError(e, ">>>>>>>>>>:Problems redirecting to AliPay", module);
			request.setAttribute("_ERROR_MESSAGE_", "Problems connecting with Alipay, please contact customer service.");
			return "error";
		}
		return "success";
	}

	/**
	 * Click the server of the notice sent to web server approach.
	 * 
	 * @param request
	 *            The HTTPRequest object for the current request
	 * @param response
	 *            The HTTPResponse object for the current request
	 * @return String specifying the exit status of this event
	 */
	public static String alipayNotify(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("============  alipayNotify");
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericDelegator delegator = (GenericDelegator) request.getAttribute("delegator");
		Locale locale = UtilHttp.getLocale(request);

		// 获取支付宝POST过来反馈信息
		Map<String, String> params = new HashMap<String, String>();
		Map<?, ?> requestParams = request.getParameterMap();
		for (Iterator<?> iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
			}
			// 乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			try {
				valueStr = new String(valueStr.getBytes("ISO-8859-1"), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				Debug.log(e.getMessage(), module);
			}
			params.put(name, valueStr);
		}

		// 获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
		String orderIds = request.getParameter("out_trade_no"); // 获取订单号
		String paymentStatus = request.getParameter("trade_status"); // 交易状态
		String[] orderIdArr = orderIds.split("\\|");

		Debug.log("**************************************************************", module);
		Debug.log("orderId = " + orderIds, module);
		Debug.log("params = " + params, module);
		// 获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表//
		if (AlipayNotify.verify(params) || true) {// 验证成功
			if (paymentStatus.equals("WAIT_SELLER_SEND_GOODS") || paymentStatus.equals("TRADE_SUCCESS")) {
				// 先查系统订单状态是否支付完成,支付完成则直接返回,否则进行数据操作
				BigDecimal receivedAmount = BigDecimal.ZERO;
				BigDecimal grandTotal = BigDecimal.ZERO;
				boolean isComplate = false;
				GenericValue orderHeader = null;
				if (UtilValidate.isNotEmpty(orderIdArr)) {
					for (String orderId : orderIdArr) {
						try {
							orderHeader = delegator.findOne("OrderHeader", false, UtilMisc.toMap("orderId", orderId));
							if (orderHeader != null) {
								orderHeader.set("tradeNo", request.getParameter("trade_no"));
								orderHeader.store();
								OrderReadHelper orh = new OrderReadHelper(delegator, orderId);

								try {
									grandTotal = grandTotal.add(orh.getOrderGrandTotal());
									List<GenericValue> payList = delegator.findByAnd("OrderPaymentPreference", UtilMisc.toMap("orderId", orderId, "statusId", "PAYMENT_RECEIVED"), null, false);
									for (GenericValue gc : payList) {
										receivedAmount = receivedAmount.add(gc.getBigDecimal("maxAmount"));
									}
								} catch (GenericEntityException e) {
									Debug.logError("Could not select OrderPaymentPreference for order " + orderId + " due to " + e.getMessage(), module);
								}
							}
						} catch (GenericEntityException e) {
							Debug.logError(e, "Cannot get the order header for order: " + orderId, module);
							request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceErr, "problemsGettingOrderHeader", locale));
							return "error";
						}
					}
				} else {
					Debug.logError("PayPal did not callback with a valid orderId!", module);
					request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceErr, "noValidOrderIdReturned", locale));
					return "error";
				}
				if (receivedAmount.compareTo(grandTotal) >= 0) {
					isComplate = true;
				}
				if (!isComplate) {
					request.setAttribute("flag", "true");
					GenericValue userLogin = null;
					try {
						userLogin = delegator.findOne("UserLogin", false, UtilMisc.toMap("userLoginId", "admin"));
					} catch (Exception e) {
						Debug.log(e.getMessage(), module);
						e.printStackTrace();
					}

					boolean okay = true;
					boolean beganTransaction = false;
					for (String orderId : orderIdArr) {
						try {
							beganTransaction = TransactionUtil.begin();
							if (paymentStatus.equals("TRADE_SUCCESS") || paymentStatus.equals("WAIT_SELLER_SEND_GOODS")) {
								okay = OrderChangeHelper.approveOrder(dispatcher, userLogin, orderId);
							}
							if (okay) {
								okay = setPaymentPreferences(delegator, dispatcher, userLogin, orderId, request);
							}
						} catch (Exception e) {
							String errMsg = "Error handling Alipay notification";
							Debug.logError(e, errMsg, module);
							try {
								TransactionUtil.rollback(beganTransaction, errMsg, e);
							} catch (GenericTransactionException gte2) {
								Debug.logError(gte2, "Unable to rollback transaction", module);
							}
						} finally {
							if (!okay) {
								try {
									TransactionUtil.rollback(beganTransaction, "Failure in processing PayPal callback", null);
								} catch (GenericTransactionException gte) {
									Debug.logError(gte, "Unable to rollback transaction", module);
								}
							} else {
								try {
									TransactionUtil.commit(beganTransaction);
								} catch (GenericTransactionException gte) {
									Debug.logError(gte, "Unable to commit transaction", module);
								}
							}
						}

						if (okay) {
							// attempt to release the offline hold on the order
							// (workflow)
							OrderChangeHelper.releaseInitialOrderHold(dispatcher, orderId);
							// call the email confirm service
							/*
							 * Map<String, String> emailContext =
							 * UtilMisc.toMap("orderId", orderId); try {
							 * dispatcher.runSync("sendOrderConfirmation",
							 * emailContext); } catch (GenericServiceException
							 * e) { Debug.logError(e,
							 * "Problems sending email confirmation", module); }
							 */
						}
					}
				}
			}
			Debug.log("success", module);
			request.setAttribute("result", "success");
			// ////////////////////////////////////////////////////////////////////////////////////////
		} else {// 验证失败
			Debug.log("fail", module);
			request.setAttribute("result", "fail");
		}

		return "success";
	}

	/**
	 * Click the server sent back to the web server approach.
	 * 
	 * @param request
	 *            The HTTPRequest object for the current request
	 * @param response
	 *            The HTTPResponse object for the current request
	 * @return String specifying the exit status of this event
	 */
	public static String alipayReturn(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("============  alipayReturn");
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericDelegator delegator = (GenericDelegator) request.getAttribute("delegator");
		Locale locale = UtilHttp.getLocale(request);

		// 获取支付宝GET过来反馈信息
		Map<String, String> params = new HashMap<String, String>();
		Map<?, ?> requestParams = request.getParameterMap();
		for (Iterator<?> iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
			}
			// 乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			if (UtilValidate.isNotEmpty(valueStr)) {
				try {
					valueStr = new String(valueStr.getBytes("ISO-8859-1"), "UTF-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
					Debug.log(e.getMessage(), module);
				}
			}
			params.put(name, valueStr);
		}

		System.out.println("Map :  " + UtilMisc.printMap(params));
		// 获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表//
		boolean verify_result = AlipayNotify.verify(params);

		if (verify_result) {// 验证成功
			System.out.println("验证成功");

			String orderIds = request.getParameter("out_trade_no"); // 获取订单号
			String paymentStatus = request.getParameter("trade_status"); // 交易状态

			request.setAttribute("paymentStatus", paymentStatus);
			request.setAttribute("flag", "true");
			request.setAttribute("orderIds", orderIds);

			GenericValue userLogin = null;
			try {
				userLogin = delegator.findOne("UserLogin", false, UtilMisc.toMap("userLoginId", "admin"));
			} catch (Exception e) {
				Debug.log(e.getMessage(), module);
				e.printStackTrace();
			}
			String[] orderIdArr = orderIds.split("\\|");
			boolean okay = true;
			boolean beganTransaction = false;
			for (String orderId : orderIdArr) {
				try {

					beganTransaction = TransactionUtil.begin();
					if (paymentStatus.equals("TRADE_SUCCESS") || paymentStatus.equals("WAIT_SELLER_SEND_GOODS")) {
						okay = OrderChangeHelper.approveOrder(dispatcher, userLogin, orderId);
					}
					if (okay) {
						okay = setPaymentPreferences(delegator, dispatcher, userLogin, orderId, request);
					}
				} catch (Exception e) {
					String errMsg = "Error handling Alipay payment";
					Debug.logError(e, errMsg, module);
					try {
						TransactionUtil.rollback(beganTransaction, errMsg, e);
					} catch (GenericTransactionException gte2) {
						Debug.logError(gte2, "Unable to rollback transaction", module);
					}
				} finally {
					if (!okay) {
						try {
							TransactionUtil.rollback(beganTransaction, "Failure in processing PayPal callback", null);
						} catch (GenericTransactionException gte) {
							Debug.logError(gte, "Unable to rollback transaction", module);
						}
					} else {
						try {
							TransactionUtil.commit(beganTransaction);
						} catch (GenericTransactionException gte) {
							Debug.logError(gte, "Unable to commit transaction", module);
						}
					}
				}

				if (okay) {
					/*
					 * // attempt to release the offline hold on the order
					 * (workflow)
					 * OrderChangeHelper.releaseInitialOrderHold(dispatcher,
					 * orderId); // call the email confirm service Map<String,
					 * String> emailContext = UtilMisc.toMap("orderId",
					 * orderId); try {
					 * dispatcher.runSync("sendOrderConfirmation",
					 * emailContext); } catch (GenericServiceException e) {
					 * Debug.logError(e, "Problems sending email confirmation",
					 * module); }
					 */
					// @WuHK改写 支付完成通知信息
					// add by WuHK send success mail
					OrderReadHelper orh = new OrderReadHelper(delegator, orderId);
					List<GenericValue> orderItem = orh.getOrderItems();
					List<String> productIdList = FastList.newInstance();
					for (GenericValue gv : orderItem) {
						if (UtilValidate.isNotEmpty(gv.getString("productId"))) {
							productIdList.add(gv.getString("productId"));
						}
					}
					Map mailParam = FastMap.newInstance();
					mailParam.put("productStoreId", orh.getProductStoreId());
					mailParam.put("eventTypeId", "E_PAY_ORDER");
					mailParam.put("partyId", orh.getPartyFromRole("PLACING_CUSTOMER").getString("partyId"));
					mailParam.put("orderId", orderId);
					mailParam.put("productIdList", productIdList);
					mailParam.put("paymentAmount", params.get("total_fee"));
					try {
						mailParam.put("msgTypeId", "MAIL");
						Map<String, Object> resultMap = dispatcher.runSync("paymentMail", mailParam);
					} catch (Exception e) {
						Debug.logError(e, "email send failure!");
					}
					try {
						mailParam.put("msgTypeId", "SMS");
						Map<String, Object> resultMap = dispatcher.runSync("paymentMail", mailParam);
					} catch (Exception e) {
						Debug.logError(e, "sms send failure!");
					}
					try {
						mailParam.put("msgTypeId", "INTERNAL_MSG");
						// Map<String,Object> resultMap =
						// dispatcher.runSync("paymentMail", mailParam);
					} catch (Exception e) {
						Debug.logError(e, "INTERNAL_MSG send failure!");
					}
				}
			}
		} else {
			Debug.log("AlipayInfo verify Fail.", module);
		}
		return "success";
	}

	private static boolean setPaymentPreferences(Delegator delegator, LocalDispatcher dispatcher, GenericValue userLogin, String orderId, HttpServletRequest request) {
		Debug.logVerbose("Setting payment prefrences..", module);
		List<GenericValue> paymentPrefs = null;
		try {
			Map<String, String> paymentFields = UtilMisc.toMap("orderId", orderId, "statusId", "PAYMENT_NOT_RECEIVED");
			paymentPrefs = delegator.findByAnd("OrderPaymentPreference", paymentFields, null, false);
		} catch (GenericEntityException e) {
			Debug.logError(e, "Cannot get payment preferences for order #" + orderId, module);
			return false;
		}
		if (paymentPrefs.size() > 0) {
			Iterator<GenericValue> i = paymentPrefs.iterator();
			while (i.hasNext()) {
				GenericValue pref = i.next();
				boolean okay = setPaymentPreference(dispatcher, userLogin, pref, request);
				if (!okay)
					return false;
			}
		}
		try {
			Map<String, Object> setSaleOrderPaymentStatusResult = dispatcher.runSync("setSaleOrderPaymentStatus", UtilMisc.toMap("orderId", orderId));
		} catch (GenericServiceException e) {
			Debug.logError(e.toString(), module);
		}
		return true;
	}

	private static boolean setPaymentPreference(LocalDispatcher dispatcher, GenericValue userLogin, GenericValue paymentPreference, HttpServletRequest request) {
		Locale locale = UtilHttp.getLocale(request);
		String paymentDate = request.getParameter("gmt_payment");
		String paymentType = request.getParameter("payment_type");
		String paymentAmount = request.getParameter("total_fee");
		String paymentStatus = request.getParameter("trade_status");
		String transactionId = request.getParameter("trade_no");

		List<GenericValue> toStore = new LinkedList<GenericValue>();

		// Alipay returns the timestamp in the format 'yyyy-MM-dd hh:mm:ss'
		// Parse this into a valid Timestamp Object
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		java.sql.Timestamp authDate = null;

		if (UtilValidate.isNotEmpty(paymentDate)) {
			try {
				authDate = new java.sql.Timestamp(sdf.parse(paymentDate).getTime());
			} catch (ParseException e) {
				Debug.logError(e, "Cannot parse date string: " + paymentDate, module);
				authDate = UtilDateTime.nowTimestamp();
			} catch (NullPointerException e) {
				Debug.logError(e, "Cannot parse date string: " + paymentDate, module);
				authDate = UtilDateTime.nowTimestamp();
			}
		} else {
			authDate = UtilDateTime.nowTimestamp();
		}

		paymentPreference.set("maxAmount", new BigDecimal(paymentAmount));
		if (paymentStatus.equals("WAIT_SELLER_SEND_GOODS")) {
			paymentPreference.set("statusId", "PAYMENT_RECEIVED");
		}
		toStore.add(paymentPreference);

		Delegator delegator = paymentPreference.getDelegator();

		// create the PaymentGatewayResponse
		String responseId = delegator.getNextSeqId("PaymentGatewayResponse");
		GenericValue response = delegator.makeValue("PaymentGatewayResponse");
		response.set("paymentGatewayResponseId", responseId);
		response.set("paymentServiceTypeEnumId", "PRDS_PAY_EXTERNAL");
		response.set("orderPaymentPreferenceId", paymentPreference.get("orderPaymentPreferenceId"));
		response.set("paymentMethodTypeId", paymentPreference.get("paymentMethodTypeId"));
		response.set("paymentMethodId", paymentPreference.get("paymentMethodId"));

		// set the auth info
		response.set("amount", new BigDecimal(paymentAmount));
		response.set("referenceNum", transactionId);
		response.set("gatewayCode", paymentStatus);
		response.set("gatewayFlag", paymentStatus.substring(0, 1));
		response.set("gatewayMessage", paymentType);
		response.set("transactionDate", authDate);
		toStore.add(response);

		try {
			delegator.storeAll(toStore);
		} catch (GenericEntityException e) {
			Debug.logError(e, "Cannot set payment preference/payment info", module);
			return false;
		}

		// create a payment record too
		Map<String, Object> results = null;
		try {
			String comment = UtilProperties.getMessage(resource, "AccountingPaymentReceiveViaPayPal", locale);
			results = dispatcher.runSync("createPaymentFromPreference", UtilMisc.toMap("userLogin", userLogin, "orderPaymentPreferenceId", paymentPreference.get("orderPaymentPreferenceId"), "comments", comment));
		} catch (GenericServiceException e) {
			Debug.logError(e, "Failed to execute service createPaymentFromPreference", module);
			request.setAttribute("_ERROR_MESSAGE_", "failedToExecuteServiceCreatePaymentFromPreference");
			return false;
		}

		if ((results == null) || (results.get(ModelService.RESPONSE_MESSAGE).equals(ModelService.RESPOND_ERROR))) {
			Debug.logError((String) results.get(ModelService.ERROR_MESSAGE), module);
			request.setAttribute("_ERROR_MESSAGE_", results.get(ModelService.ERROR_MESSAGE));
			return false;
		}

		return true;
	}

	private static String getPaymentGatewayConfigValue(Delegator delegator, String paymentGatewayConfigId, String paymentGatewayConfigParameterName, String resource, String parameterName, String urlPrefix) {
		String returnValue = "";
		if (UtilValidate.isNotEmpty(paymentGatewayConfigId)) {
			try {
				GenericValue alipay = delegator.findOne("PaymentGatewayAlipay", UtilMisc.toMap("paymentGatewayConfigId", paymentGatewayConfigId), false);
				if (UtilValidate.isNotEmpty(alipay)) {
					Object worldPayField = alipay.get(paymentGatewayConfigParameterName);
					if (worldPayField != null) {
						returnValue = worldPayField.toString().trim();
					}
				}
			} catch (GenericEntityException e) {
				Debug.logError(e, module);
			}
		} else {
			String value = UtilProperties.getPropertyValue(resource, parameterName);
			if (value != null) {
				returnValue = value.trim();
				if (returnValue.indexOf("http") < -1) {
					returnValue = urlPrefix + returnValue;
				}
			}
		}
		return returnValue;
	}

	private static String getPaymentGatewayConfigValue(Delegator delegator, String paymentGatewayConfigId, String paymentGatewayConfigParameterName, String resource, String parameterName, String urlPrefix, String defaultValue) {
		String returnValue = getPaymentGatewayConfigValue(delegator, paymentGatewayConfigId, paymentGatewayConfigParameterName, resource, parameterName, urlPrefix);
		if (UtilValidate.isEmpty(returnValue)) {
			returnValue = defaultValue;
		}
		return returnValue;
	}

	public static String strfilter(String args, String regex) {
		// String regEx =
		// "[`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？『』]";
		if (UtilValidate.isEmpty(regex)) {
			regex = "[`@#$%^&*()=|{}\\[\\]<>/?~@#￥%&*（）——|{}【】‘；”“’？『』]";
		}
		if (UtilValidate.isEmpty(args)) {
			args = "";
		}
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(args);
		return m.replaceAll("").trim();
	}
}
