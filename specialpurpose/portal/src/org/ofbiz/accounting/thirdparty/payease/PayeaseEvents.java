/*******************************************************************************
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
 *******************************************************************************/
package org.ofbiz.accounting.thirdparty.payease;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLConnection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilFormatOut;
import org.ofbiz.base.util.UtilGenerics;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.ebiz.order.EbizOrderReadHelper;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.transaction.GenericTransactionException;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.order.order.OrderChangeHelper;
import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.product.store.ProductStoreWorkerExt;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;

public class PayeaseEvents {

    public static final String resource = "AccountingUiLabels";
    public static final String resourceErr = "AccountingErrorUiLabels";
    public static final String commonResource = "CommonUiLabels";
    public static final String module = PayeaseEvents.class.getName();

    /** Initiate Payease Request */
    public static String callPayease(HttpServletRequest request, HttpServletResponse response) {
	Locale locale = UtilHttp.getLocale(request);
	Delegator delegator = (Delegator) request.getAttribute("delegator");
	LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
	HttpSession session =request.getSession(true);
	List<String> orderIdList = null;

	String[] orderIds = request.getParameterValues("orderId");
	if (UtilValidate.isNotEmpty(orderIds)) {
	    orderIdList = UtilMisc.toListArray(orderIds);
	}
	// get the orderId
	// String orderId = (String) request.getAttribute("orderId");
	if (UtilValidate.isEmpty(orderIdList)) {
	    orderIdList = UtilGenerics.checkList(request.getAttribute("orderIdList"));
	}

	if (UtilValidate.isEmpty(orderIdList)) {
	    orderIdList = UtilGenerics.checkList(session.getAttribute("orderIdList"));
	}

	// get the product store
	GenericValue productStore = ProductStoreWorkerExt.getSiteProductStore(request);
	String currencyUom = productStore.getString("defaultCurrencyUomId");

	if (productStore == null) {
	    Debug.logError("ProductStore is null", module);
	    request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceErr, "payeaseEvents.problemsGettingMerchantConfiguration", locale));
	    return "error";
	}

	// get the payment properties file
	GenericValue paymentConfig = ProductStoreWorker.getProductStorePaymentSetting(delegator, productStore.getString("productStoreId"), "EXT_PAYEASE", null, true);
	String configString = null;
	String paymentGatewayConfigId = null;
	if (paymentConfig != null) {
	    paymentGatewayConfigId = paymentConfig.getString("paymentGatewayConfigId");
	    configString = paymentConfig.getString("paymentPropertiesPath");
	}

	if (configString == null) {
	    configString = "payment.properties";
	}

	String v_ymd = UtilDateTime.toDateString(new java.util.Date(), "yyyyMMdd");
	// get the payease account
	String payeaseAccount = UtilPayease.getPaymentGatewayConfigValue(delegator, paymentGatewayConfigId, "merchantId", configString, "payment.payease.business");

	Map<String, Object> inContext = UtilMisc.toMap("orderIds", orderIdList, "userLogin", userLogin);
	String orderPaymentGroupId = delegator.getNextSeqId("OrderPaymentGroup");

	String oid = UtilPayease.getOid(v_ymd, payeaseAccount, orderPaymentGroupId);
	inContext.put("orderPaymentGroupId", orderPaymentGroupId);
	inContext.put("oid", oid);
	session.setAttribute("v_oid", oid);
	try {
	    Map retMap = dispatcher.runSync("createOrderPaymentGroupAndMember", inContext);
	    orderPaymentGroupId = (String) retMap.get("orderPaymentGroupId");
	} catch (GenericServiceException e) {
	    Debug.logError(e, "Problems sending email confirmation", module);
	}

	BigDecimal orderListTotal = BigDecimal.ZERO;

	for (String orderId : orderIdList) {
	    // get the order header
	    GenericValue orderHeader = null;
	    try {
		orderHeader = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId", orderId), false);
	    } catch (GenericEntityException e) {
		Debug.logError(e, "Cannot get the order header for order: " + orderId, module);
		request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceErr, "payeaseEvents.problemsGettingOrderHeader", locale));
		return "error";
	    }
	    EbizOrderReadHelper ebizOrderReadHelper = new EbizOrderReadHelper(orderHeader);
	    orderListTotal = orderListTotal.add(ebizOrderReadHelper.getOrderPayableAmount());
	}

	// get the order total
	String orderTotal = orderListTotal.toPlainString();
	// String currencyUom = orderHeader.getString("currencyUom");

	session.setAttribute("v_orderTotal", orderTotal);
	
	// get the company name
	String company = UtilFormatOut.checkEmpty(productStore.getString("companyName"), "");

	// create the item name
	String itemName = UtilProperties.getMessage(resource, "AccountingOrderNr", locale) + orderPaymentGroupId + " " + (company != null ? UtilProperties.getMessage(commonResource, "CommonFrom", locale) + " " + company : "");
	String itemNumber = "0";

	// get the redirect url
	String redirectUrl = UtilPayease.getPaymentGatewayConfigValue(delegator, paymentGatewayConfigId, "redirectUrl", configString, "payment.payease.redirectUrl");
	String redirectBankUrl = UtilPayease.getPaymentGatewayConfigValue(delegator, paymentGatewayConfigId, "redirectBankUrl", configString, "payment.payease.redirectBankUrl");

	// get the return urls
	String returnUrl = UtilPayease.getPaymentGatewayConfigValue(delegator, paymentGatewayConfigId, "returnUrl", configString, "payment.payease.return");

	String apiSignature = UtilPayease.getPaymentGatewayConfigValue(delegator, paymentGatewayConfigId, "apiSignature", configString, "payment.payease.apiSignature");

	String moneyType = UtilPayease.getPaymentGatewayConfigValue(delegator, paymentGatewayConfigId, "moneyType", configString, "payment.payease.moneyType");

	if (UtilValidate.isEmpty(redirectUrl) || UtilValidate.isEmpty(returnUrl) || UtilValidate.isEmpty(payeaseAccount)) {
	    Debug.logError("Payment properties is not configured properly, some notify URL from Payease is not correctly defined!", module);
	    request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceErr, "payeaseEvents.problemsGettingMerchantConfiguration", locale));
	    return "error";
	}

	PayeaseRequest payeaseRequest = new PayeaseRequest();
	payeaseRequest.setV_mid(payeaseAccount);
	payeaseRequest.setOrderPaymentGroupId(orderPaymentGroupId);
	payeaseRequest.setRedirectUrl(redirectUrl);
	payeaseRequest.setRedirectBankUrl(redirectBankUrl);
	payeaseRequest.setV_amount(orderTotal);
	payeaseRequest.setV_ymd(v_ymd);
	payeaseRequest.setV_rcvname(payeaseAccount);
	payeaseRequest.setV_rcvaddr(payeaseAccount);
	payeaseRequest.setV_rcvtel(payeaseAccount);
	payeaseRequest.setV_rcvpost(payeaseAccount);
	payeaseRequest.setV_ordername(payeaseAccount);
	payeaseRequest.setV_moneytype(moneyType);
	payeaseRequest.setV_url(returnUrl);
	payeaseRequest.setV_orderstatus("1");
	payeaseRequest.setV_oid(null);
	payeaseRequest.md5(apiSignature);

	request.setAttribute("payeaseRequest", payeaseRequest);

	// set the order in the session for cancelled orders
	request.getSession().setAttribute("PAYEASE_ORDER", orderPaymentGroupId);

	return "success";
    }

    /** Payease return Event */
    public static String payeaseReturn(HttpServletRequest request, HttpServletResponse response) {
	Locale locale = UtilHttp.getLocale(request);
	Delegator delegator = (Delegator) request.getAttribute("delegator");
	LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");

	// get the product store
	GenericValue productStore = ProductStoreWorkerExt.getSiteProductStore(request);
	if (productStore == null) {
	    Debug.logError("ProductStore is null", module);
	    request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceErr, "payeaseEvents.problemsGettingMerchantConfiguration", locale));
	    return "error";
	}

	// get the payment properties file
	GenericValue paymentConfig = ProductStoreWorker.getProductStorePaymentSetting(delegator, productStore.getString("productStoreId"), "EXT_PAYEASE", null, true);

	// first verify this is valid from payease
	// Map <String, Object> parametersMap =
	// UtilHttp.getParameterMap(request);

	PayeaseResponse payeaseResponse = new PayeaseResponse();
	payeaseResponse.parseRequest(request);
	// payeaseResponse.parseParametersMap(parametersMap);

	boolean verified = payeaseResponse.verifyResp();

	if (!verified) {
	    Debug.logError("###### payease did not verify this request, need investigation!", module);
	}

	// get the system user
	GenericValue systemUserLogin = null;
	try {
	    systemUserLogin = delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId", "system"), false);
	} catch (GenericEntityException e) {
	    Debug.logError(e, "Cannot get UserLogin for: system; cannot continue", module);
	    request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceErr, "payeaseEvents.problemsGettingAuthenticationUser", locale));
	    return "error";
	}

	List<GenericValue> paymentGroupMembers = null;
	try {
	    Map<String, String> paymentFields = UtilMisc.toMap("orderPaymentGroupId", payeaseResponse.getOrderPaymentGroupId());
	    paymentGroupMembers = delegator.findByAnd("OrderPaymentGroupMember", paymentFields, null, false);
	} catch (GenericEntityException e) {
	    Debug.logError(e, "Cannot get OrderPaymentGroupMember #" + payeaseResponse.getOrderPaymentGroupId(), module);
	    return "";
	}

	for (GenericValue paymentGroupMember : paymentGroupMembers) {
	    // get the orderId
	    String orderId = paymentGroupMember.getString("orderId");

	    // get the order header
	    GenericValue orderHeader = null;
	    if (UtilValidate.isNotEmpty(orderId)) {
		try {
		    orderHeader = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId", orderId), false);
		} catch (GenericEntityException e) {
		    Debug.logError(e, "Cannot get the order header for order: " + orderId, module);
		    request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceErr, "payeaseEvents.problemsGettingOrderHeader", locale));
		    return "error";
		}
	    } else {
		Debug.logError("payease did not callback with a valid orderId!", module);
		request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceErr, "payeaseEvents.noValidOrderIdReturned", locale));
		return "error";
	    }

	    if (orderHeader == null) {
		Debug.logError("Cannot get the order header for order: " + orderId, module);
		request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceErr, "payeaseEvents.problemsGettingOrderHeader", locale));
		return "error";
	    }

	    // get the transaction status
	    // String paymentStatus = request.getParameter("payment_status");

	    // attempt to start a transaction
	    boolean okay = true;
	    boolean beganTransaction = false;
	    try {
		beganTransaction = TransactionUtil.begin();

		if (payeaseResponse.paySuccess()) {
		    okay = OrderChangeHelper.approveOrder(dispatcher, systemUserLogin, orderId);
		} else {
		    okay = OrderChangeHelper.cancelOrder(dispatcher, systemUserLogin, orderId);
		}

		if (okay) {
		    // set the payment preference
		    okay = setPaymentPreferences(delegator, dispatcher, systemUserLogin, orderId, request);
		}
	    } catch (Exception e) {
		String errMsg = "Error handling payease notification";
		Debug.logError(e, errMsg, module);
		try {
		    TransactionUtil.rollback(beganTransaction, errMsg, e);
		} catch (GenericTransactionException gte2) {
		    Debug.logError(gte2, "Unable to rollback transaction", module);
		}
	    } finally {
		if (!okay) {
		    try {
			TransactionUtil.rollback(beganTransaction, "Failure in processing payease callback", null);
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
		// attempt to release the offline hold on the order (workflow)
		OrderChangeHelper.releaseInitialOrderHold(dispatcher, orderId);

		// call the email confirm service
		/*
		 * Map <String, String> emailContext = UtilMisc.toMap("orderId",
		 * orderId); try { dispatcher.runSync("sendOrderConfirmation",
		 * emailContext); } catch (GenericServiceException e) {
		 * Debug.logError(e, "Problems sending email confirmation",
		 * module); }
		 */
	    }

	}

	return "success";
    }

    /** Payease Call-Back Event */
    public static String payeaseNotify(HttpServletRequest request, HttpServletResponse response) {

	try {
	    String reqMethod = request.getMethod();

	    Locale locale = UtilHttp.getLocale(request);
	    Delegator delegator = (Delegator) request.getAttribute("delegator");
	    LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");

	    // get the product store
	    GenericValue productStore = ProductStoreWorkerExt.getSiteProductStore(request);
	    if (productStore == null) {
		Debug.logError("ProductStore is null", module);
		// request.setAttribute("_ERROR_MESSAGE_",
		// UtilProperties.getMessage(resourceErr,
		// "payeaseEvents.problemsGettingMerchantConfiguration",
		// locale));
		UtilPayease.streamContentToBrowser(request, response, "error", null);
		return "error";
	    }

	    // get the payment properties file
	    GenericValue paymentConfig = ProductStoreWorker.getProductStorePaymentSetting(delegator, productStore.getString("productStoreId"), "EXT_PAYEASE", null, true);

	    String configString = null;
	    String paymentGatewayConfigId = null;
	    if (paymentConfig != null) {
		paymentGatewayConfigId = paymentConfig.getString("paymentGatewayConfigId");
		configString = paymentConfig.getString("paymentPropertiesPath");
	    }

	    if (configString == null) {
		configString = "payment.properties";
	    }
	    String apiSignature = UtilPayease.getPaymentGatewayConfigValue(delegator, paymentGatewayConfigId, "apiSignature", configString, "payment.payease.apiSignature");
	    // first verify this is valid from payease

	    Map paraMap = UtilHttp.getParameterMap(request);

	    Map gatewayResponse = FastMap.newInstance();

	    String v_count = request.getParameter("v_count"); // 订单个数
	    String v_oid = request.getParameter("v_oid"); // 订单编号组
	    String v_pmode = request.getParameter("v_pmode"); // 支付方式组
	    try {
		v_pmode = UtilPayease.decodeReqParam(v_pmode, reqMethod);
		;
	    } catch (Exception ex) {
		Debug.log(ex, module);
	    }
	    String v_pstatus = request.getParameter("v_pstatus"); // 支付状态组
	    String v_pstring = request.getParameter("v_pstring"); // 支付结果信息组
	    v_pstring = UtilPayease.decodeReqParam(v_pstring, reqMethod);

	    String v_amount = request.getParameter("v_amount"); // 订单实际支付金额组
	    String v_moneytype = request.getParameter("v_moneytype"); // 订单实际支付币种
	    String v_mac = request.getParameter("v_mac"); // 数字签名
	    String v_md5money = request.getParameter("v_md5money"); // 数字指纹
	    String v_sign = request.getParameter("v_sign"); // 商城数据签名

	    String v_macSource = v_oid + v_pmode + v_pstatus + v_pstring + v_count;
	    if (!UtilPayease.verifyMd5(v_macSource, apiSignature, v_mac)) {
		Debug.logError("###### payease v_mac did not verify this request, need investigation!", module);
	    }

	    String v_md5moneySource = v_amount + v_moneytype;
	    if (!UtilPayease.verifyMd5(v_md5moneySource, apiSignature, v_md5money)) {
		Debug.logError("###### payease v_md5money did not verify this request, need investigation!", module);
	    }

	    String v_signSource = v_oid + v_pstatus + v_amount + v_moneytype + v_count;
	    boolean verified = false;
	    try {
		verified = UtilPayease.verifyResp(v_signSource, v_sign);
	    } catch (Exception ex) {
		Debug.logError(ex, module);
	    }
	    if (!verified) {
		Debug.logError("###### payease v_sign did not verify this request, need investigation!", module);
	    }

	    gatewayResponse.put("amount", v_amount);
	    gatewayResponse.put("oid", v_oid);
	    gatewayResponse.put("pmode", v_pmode);
	    gatewayResponse.put("pstatus", v_pstatus);
	    gatewayResponse.put("pstring", v_pstring);
	    
	    
	    String orderPaymentGroupId = UtilPayease.getOrderPaymentGroupId(v_oid);
	    if (orderPaymentGroupId == null || orderPaymentGroupId.length() == 0) {
		UtilPayease.streamContentToBrowser(request, response, "error", null);
		return "error";
	    }

	    boolean paySuccess = true;
	    if (!"1".equals(v_pstatus)) {
		paySuccess = false;
	    }

	    // get the system user
	    GenericValue systemUserLogin = null;
	    try {
		systemUserLogin = delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId", "system"), false);
	    } catch (GenericEntityException e) {
		Debug.logError(e, "Cannot get UserLogin for: system; cannot continue", module);
		// request.setAttribute("_ERROR_MESSAGE_",
		// UtilProperties.getMessage(resourceErr,
		// "payeaseEvents.problemsGettingAuthenticationUser", locale));
		UtilPayease.streamContentToBrowser(request, response, "error", null);
		return "error";
	    }

	    List<GenericValue> paymentGroupMembers = null;
	    try {
		Map<String, String> paymentFields = UtilMisc.toMap("orderPaymentGroupId", orderPaymentGroupId);
		paymentGroupMembers = delegator.findByAnd("OrderPaymentGroupMember", paymentFields, null, false);
	    } catch (GenericEntityException e) {
		Debug.logError(e, "Cannot get OrderPaymentGroupMember #" + orderPaymentGroupId, module);
		UtilPayease.streamContentToBrowser(request, response, "error", null);
		return "";
	    }

	    for (GenericValue paymentGroupMember : paymentGroupMembers) {
		// get the orderId
		String orderId = paymentGroupMember.getString("orderId");

		// get the order header
		GenericValue orderHeader = null;
		if (UtilValidate.isNotEmpty(orderId)) {
		    try {
			orderHeader = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId", orderId), false);
		    } catch (GenericEntityException e) {
			Debug.logError(e, "Cannot get the order header for order: " + orderId, module);
			// request.setAttribute("_ERROR_MESSAGE_",
			// UtilProperties.getMessage(resourceErr,
			// "payeaseEvents.problemsGettingOrderHeader", locale));
			UtilPayease.streamContentToBrowser(request, response, "error", null);
			return "error";
		    }
		} else {
		    Debug.logError("payease did not callback with a valid orderId!", module);
		    // request.setAttribute("_ERROR_MESSAGE_",
		    // UtilProperties.getMessage(resourceErr,
		    // "payeaseEvents.noValidOrderIdReturned", locale));
		    UtilPayease.streamContentToBrowser(request, response, "error", null);
		    return "error";
		}

		if (orderHeader == null) {
		    Debug.logError("Cannot get the order header for order: " + orderId, module);
		    // request.setAttribute("_ERROR_MESSAGE_",
		    // UtilProperties.getMessage(resourceErr,
		    // "payeaseEvents.problemsGettingOrderHeader", locale));
		    UtilPayease.streamContentToBrowser(request, response, "error", null);
		    return "error";
		}

		// get the transaction status
		// String paymentStatus =
		// request.getParameter("payment_status");

		// attempt to start a transaction
		boolean okay = true;
		boolean beganTransaction = false;
		try {
		    beganTransaction = TransactionUtil.begin();

		    if (paySuccess) {
			okay = OrderChangeHelper.approveOrder(dispatcher, systemUserLogin, orderId);
		    } else {
			okay = OrderChangeHelper.cancelOrder(dispatcher, systemUserLogin, orderId);
		    }

		    if (okay) {
			// set the payment preference
			okay = setPaymentPreferencesNotify(delegator, dispatcher, systemUserLogin, orderId, request, gatewayResponse);
		    }
		} catch (Exception e) {
		    String errMsg = "Error handling payease notification";
		    Debug.logError(e, errMsg, module);
		    try {
			TransactionUtil.rollback(beganTransaction, errMsg, e);
		    } catch (GenericTransactionException gte2) {
			Debug.logError(gte2, "Unable to rollback transaction", module);
		    }
		} finally {
		    if (!okay) {
			try {
			    TransactionUtil.rollback(beganTransaction, "Failure in processing payease callback", null);
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
		     * Map <String, String> emailContext =
		     * UtilMisc.toMap("orderId", orderId); try {
		     * dispatcher.runSync("sendOrderConfirmation",
		     * emailContext); } catch (GenericServiceException e) {
		     * Debug.logError(e, "Problems sending email confirmation",
		     * module); }
		     */
		}

	    }

	    UtilPayease.streamContentToBrowser(request, response, "sent", null);
	    return "success";

	} catch (Exception ex) {
	    Debug.logError(ex, module);
	    UtilPayease.streamContentToBrowser(request, response, "error", null);
	    return "error";
	}
    }
    
    /** Payease Call-Back Event */
    public static String payeaseCheck(HttpServletRequest request, HttpServletResponse response) {
	LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	Delegator delegator = (Delegator) request.getAttribute("delegator");
	HttpSession session =request.getSession(true);
	GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
	try {
	    String reqMethod = request.getMethod();

	    Locale locale = UtilHttp.getLocale(request);

	    // get the product store
	    GenericValue productStore = ProductStoreWorkerExt.getSiteProductStore(request);
	    if (productStore == null) {
		Debug.logError("ProductStore is null", module);
		// request.setAttribute("_ERROR_MESSAGE_",
		// UtilProperties.getMessage(resourceErr,
		// "payeaseEvents.problemsGettingMerchantConfiguration",
		// locale));
		//UtilPayease.streamContentToBrowser(request, response, "error", null);
		request.setAttribute("retStatus", "error");
		return "error";
	    }

	    // get the payment properties file
	    GenericValue paymentConfig = ProductStoreWorker.getProductStorePaymentSetting(delegator, productStore.getString("productStoreId"), "EXT_PAYEASE", null, true);

	    String configString = null;
	    String paymentGatewayConfigId = null;
	    if (paymentConfig != null) {
		paymentGatewayConfigId = paymentConfig.getString("paymentGatewayConfigId");
		configString = paymentConfig.getString("paymentPropertiesPath");
	    }

	    if (configString == null) {
		configString = "payment.properties";
	    }
	    // get the payease account
	    String payeaseAccount = UtilPayease.getPaymentGatewayConfigValue(delegator, paymentGatewayConfigId, "merchantId", configString, "payment.payease.business");
	    String apiSignature = UtilPayease.getPaymentGatewayConfigValue(delegator, paymentGatewayConfigId, "apiSignature", configString, "payment.payease.apiSignature");
	    // first verify this is valid from payease

	    Map paraMap = UtilHttp.getParameterMap(request);

	    Map gatewayResponse = FastMap.newInstance();


	    String v_oid = request.getParameter("v_oid"); // 订单编号组
	    if(UtilValidate.isEmpty(v_oid)){
		v_oid = (String)session.getAttribute("v_oid");
	    }
	    Map orderAckOidListCtx = UtilMisc.toMap("v_oid",v_oid,"userLogin",userLogin);
	    orderAckOidListCtx.put("v_mid", payeaseAccount);
	    orderAckOidListCtx.put("productStoreId", productStore.getString("productStoreId"));
	    
	    
	    Map result = dispatcher.runSync("payeaseOrderAckOidList", orderAckOidListCtx);

	    if(ServiceUtil.isError(result)){
		request.setAttribute("retStatus", "error");
		return "error";
	    }
	    
	    Map messagehead =(Map)result.get("messagehead");
	    String v_pstatus = (String)messagehead.get("status");
	    List orderList = (List)result.get("orderList");
	    Map orderMap = (Map)orderList.get(0);
	    gatewayResponse.put("amount", orderMap.get("amount"));
	    gatewayResponse.put("oid", orderMap.get("oid"));
	    gatewayResponse.put("pmode", orderMap.get("pmode"));
	    gatewayResponse.put("pstatus", orderMap.get("pstatus"));
	    gatewayResponse.put("pstring", orderMap.get("pstring"));
	    
	    
	    String orderPaymentGroupId = UtilPayease.getOrderPaymentGroupId(v_oid);
	    if (orderPaymentGroupId == null || orderPaymentGroupId.length() == 0) {
		//UtilPayease.streamContentToBrowser(request, response, "error", null);
		request.setAttribute("retStatus", "error");
		return "error";
	    }

	    boolean paySuccess = true;
	    if (!"0".equals(v_pstatus)) {
		paySuccess = false;
	    }

	    // get the system user
	    GenericValue systemUserLogin = null;
	    try {
		systemUserLogin = delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId", "system"), false);
	    } catch (GenericEntityException e) {
		Debug.logError(e, "Cannot get UserLogin for: system; cannot continue", module);
		// request.setAttribute("_ERROR_MESSAGE_",
		// UtilProperties.getMessage(resourceErr,
		// "payeaseEvents.problemsGettingAuthenticationUser", locale));
		//UtilPayease.streamContentToBrowser(request, response, "error", null);
		request.setAttribute("retStatus", "error");
		return "error";
	    }

	    List<GenericValue> paymentGroupMembers = null;
	    try {
		Map<String, String> paymentFields = UtilMisc.toMap("orderPaymentGroupId", orderPaymentGroupId);
		paymentGroupMembers = delegator.findByAnd("OrderPaymentGroupMember", paymentFields, null, false);
	    } catch (GenericEntityException e) {
		Debug.logError(e, "Cannot get OrderPaymentGroupMember #" + orderPaymentGroupId, module);
		//UtilPayease.streamContentToBrowser(request, response, "error", null);
		request.setAttribute("retStatus", "error");
		return "error";
	    }

	    for (GenericValue paymentGroupMember : paymentGroupMembers) {
		// get the orderId
		String orderId = paymentGroupMember.getString("orderId");

		// get the order header
		GenericValue orderHeader = null;
		if (UtilValidate.isNotEmpty(orderId)) {
		    try {
			orderHeader = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId", orderId), false);
		    } catch (GenericEntityException e) {
			Debug.logError(e, "Cannot get the order header for order: " + orderId, module);
			// request.setAttribute("_ERROR_MESSAGE_",
			// UtilProperties.getMessage(resourceErr,
			// "payeaseEvents.problemsGettingOrderHeader", locale));
			//UtilPayease.streamContentToBrowser(request, response, "error", null);
			request.setAttribute("retStatus", "error");
			return "error";
		    }
		} else {
		    Debug.logError("payease did not callback with a valid orderId!", module);
		    // request.setAttribute("_ERROR_MESSAGE_",
		    // UtilProperties.getMessage(resourceErr,
		    // "payeaseEvents.noValidOrderIdReturned", locale));
		    //UtilPayease.streamContentToBrowser(request, response, "error", null);
		    request.setAttribute("retStatus", "error");
		    return "error";
		}

		if (orderHeader == null) {
		    Debug.logError("Cannot get the order header for order: " + orderId, module);
		    // request.setAttribute("_ERROR_MESSAGE_",
		    // UtilProperties.getMessage(resourceErr,
		    // "payeaseEvents.problemsGettingOrderHeader", locale));
		    //UtilPayease.streamContentToBrowser(request, response, "error", null);
		    request.setAttribute("retStatus", "error");
		    return "error";
		}

		// get the transaction status
		// String paymentStatus =
		// request.getParameter("payment_status");

		// attempt to start a transaction
		boolean okay = true;
		boolean beganTransaction = false;
		try {
		    beganTransaction = TransactionUtil.begin();

		    if (paySuccess) {
			okay = OrderChangeHelper.approveOrder(dispatcher, systemUserLogin, orderId);
		    } else {
			okay = OrderChangeHelper.cancelOrder(dispatcher, systemUserLogin, orderId);
		    }

		    if (okay) {
			// set the payment preference
			okay = setPaymentPreferencesNotify(delegator, dispatcher, systemUserLogin, orderId, request, gatewayResponse);
		    }
		} catch (Exception e) {
		    String errMsg = "Error handling payease notification";
		    Debug.logError(e, errMsg, module);
		    try {
			TransactionUtil.rollback(beganTransaction, errMsg, e);
		    } catch (GenericTransactionException gte2) {
			Debug.logError(gte2, "Unable to rollback transaction", module);
		    }
		    request.setAttribute("retStatus", "error");
		    return "error";
		} finally {
		    if (!okay) {
			try {
			    TransactionUtil.rollback(beganTransaction, "Failure in processing payease callback", null);
			} catch (GenericTransactionException gte) {
			    Debug.logError(gte, "Unable to rollback transaction", module);
			}
			request.setAttribute("retStatus", "error");
			return "error";
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
		     * Map <String, String> emailContext =
		     * UtilMisc.toMap("orderId", orderId); try {
		     * dispatcher.runSync("sendOrderConfirmation",
		     * emailContext); } catch (GenericServiceException e) {
		     * Debug.logError(e, "Problems sending email confirmation",
		     * module); }
		     */
		}

	    }

	    //UtilPayease.streamContentToBrowser(request, response, "sent", null);
	    request.setAttribute("retStatus", "success");
	    return "success";

	} catch (Exception ex) {
	    Debug.logError(ex, module);
	    //UtilPayease.streamContentToBrowser(request, response, "error", null);
	    request.setAttribute("retStatus", "error");
	    return "error";
	}
    }
    
    
    /** Payease Call-Back Event */
    public static String payeaseCheckForDemo(HttpServletRequest request, HttpServletResponse response) {
	LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	Delegator delegator = (Delegator) request.getAttribute("delegator");
	HttpSession session =request.getSession(true);
	GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
	try {
	    String reqMethod = request.getMethod();

	    Locale locale = UtilHttp.getLocale(request);

	    // get the product store
	    GenericValue productStore = ProductStoreWorkerExt.getSiteProductStore(request);
	    if (productStore == null) {
		Debug.logError("ProductStore is null", module);
		// request.setAttribute("_ERROR_MESSAGE_",
		// UtilProperties.getMessage(resourceErr,
		// "payeaseEvents.problemsGettingMerchantConfiguration",
		// locale));
		//UtilPayease.streamContentToBrowser(request, response, "error", null);
		request.setAttribute("retStatus", "error");
		return "error";
	    }

	    // get the payment properties file
	    GenericValue paymentConfig = ProductStoreWorker.getProductStorePaymentSetting(delegator, productStore.getString("productStoreId"), "EXT_PAYEASE", null, true);

	    String configString = null;
	    String paymentGatewayConfigId = null;
	    if (paymentConfig != null) {
		paymentGatewayConfigId = paymentConfig.getString("paymentGatewayConfigId");
		configString = paymentConfig.getString("paymentPropertiesPath");
	    }

	    if (configString == null) {
		configString = "payment.properties";
	    }
	    // get the payease account
	    String payeaseAccount = UtilPayease.getPaymentGatewayConfigValue(delegator, paymentGatewayConfigId, "merchantId", configString, "payment.payease.business");
	    String apiSignature = UtilPayease.getPaymentGatewayConfigValue(delegator, paymentGatewayConfigId, "apiSignature", configString, "payment.payease.apiSignature");
	    // first verify this is valid from payease

	    Map paraMap = UtilHttp.getParameterMap(request);

	    Map gatewayResponse = FastMap.newInstance();


	    String v_oid = request.getParameter("v_oid"); // 订单编号组
	    if(UtilValidate.isEmpty(v_oid)){
		v_oid = (String)session.getAttribute("v_oid");
	    }
	    String v_orderTotal = request.getParameter("v_orderTotal"); 
	    if(UtilValidate.isEmpty(v_orderTotal)){
		v_orderTotal = (String)session.getAttribute("v_orderTotal");
	    }
	    
	    
	    Map orderAckOidListCtx = UtilMisc.toMap("v_oid",v_oid,"userLogin",userLogin);
	    orderAckOidListCtx.put("v_mid", payeaseAccount);
	    orderAckOidListCtx.put("productStoreId", productStore.getString("productStoreId"));
	    
	    /*
	    Map result = dispatcher.runSync("payeaseOrderAckOidList", orderAckOidListCtx);

	    if(ServiceUtil.isError(result)){
		request.setAttribute("retStatus", "error");
		return "error";
	    }
	    
	    Map messagehead =(Map)result.get("messagehead");
	    String v_pstatus = (String)messagehead.get("status");
	    List orderList = (List)result.get("orderList");
	    Map orderMap = (Map)orderList.get(0);
	    */
	    
	    String v_pstatus = "0";
	    gatewayResponse.put("amount", v_orderTotal);
	    gatewayResponse.put("oid", v_oid);
	    gatewayResponse.put("pmode", "实时外卡YD");
	    gatewayResponse.put("pstatus", "1");
	    gatewayResponse.put("pstring", "success");
	    
	    
	    String orderPaymentGroupId = UtilPayease.getOrderPaymentGroupId(v_oid);
	    if (orderPaymentGroupId == null || orderPaymentGroupId.length() == 0) {
		//UtilPayease.streamContentToBrowser(request, response, "error", null);
		request.setAttribute("retStatus", "error");
		return "error";
	    }

	    boolean paySuccess = true;
	    if (!"0".equals(v_pstatus)) {
		paySuccess = false;
	    }

	    // get the system user
	    GenericValue systemUserLogin = null;
	    try {
		systemUserLogin = delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId", "system"), false);
	    } catch (GenericEntityException e) {
		Debug.logError(e, "Cannot get UserLogin for: system; cannot continue", module);
		// request.setAttribute("_ERROR_MESSAGE_",
		// UtilProperties.getMessage(resourceErr,
		// "payeaseEvents.problemsGettingAuthenticationUser", locale));
		//UtilPayease.streamContentToBrowser(request, response, "error", null);
		request.setAttribute("retStatus", "error");
		return "error";
	    }

	    List<GenericValue> paymentGroupMembers = null;
	    try {
		Map<String, String> paymentFields = UtilMisc.toMap("orderPaymentGroupId", orderPaymentGroupId);
		paymentGroupMembers = delegator.findByAnd("OrderPaymentGroupMember", paymentFields, null, false);
	    } catch (GenericEntityException e) {
		Debug.logError(e, "Cannot get OrderPaymentGroupMember #" + orderPaymentGroupId, module);
		//UtilPayease.streamContentToBrowser(request, response, "error", null);
		request.setAttribute("retStatus", "error");
		return "error";
	    }

	    for (GenericValue paymentGroupMember : paymentGroupMembers) {
		// get the orderId
		String orderId = paymentGroupMember.getString("orderId");

		// get the order header
		GenericValue orderHeader = null;
		if (UtilValidate.isNotEmpty(orderId)) {
		    try {
			orderHeader = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId", orderId), false);
		    } catch (GenericEntityException e) {
			Debug.logError(e, "Cannot get the order header for order: " + orderId, module);
			// request.setAttribute("_ERROR_MESSAGE_",
			// UtilProperties.getMessage(resourceErr,
			// "payeaseEvents.problemsGettingOrderHeader", locale));
			//UtilPayease.streamContentToBrowser(request, response, "error", null);
			request.setAttribute("retStatus", "error");
			return "error";
		    }
		} else {
		    Debug.logError("payease did not callback with a valid orderId!", module);
		    // request.setAttribute("_ERROR_MESSAGE_",
		    // UtilProperties.getMessage(resourceErr,
		    // "payeaseEvents.noValidOrderIdReturned", locale));
		    //UtilPayease.streamContentToBrowser(request, response, "error", null);
		    request.setAttribute("retStatus", "error");
		    return "error";
		}

		if (orderHeader == null) {
		    Debug.logError("Cannot get the order header for order: " + orderId, module);
		    // request.setAttribute("_ERROR_MESSAGE_",
		    // UtilProperties.getMessage(resourceErr,
		    // "payeaseEvents.problemsGettingOrderHeader", locale));
		    //UtilPayease.streamContentToBrowser(request, response, "error", null);
		    request.setAttribute("retStatus", "error");
		    return "error";
		}

		// get the transaction status
		// String paymentStatus =
		// request.getParameter("payment_status");

		// attempt to start a transaction
		boolean okay = true;
		boolean beganTransaction = false;
		try {
		    beganTransaction = TransactionUtil.begin();

		    if (paySuccess) {
			okay = OrderChangeHelper.approveOrder(dispatcher, systemUserLogin, orderId);
		    } else {
			okay = OrderChangeHelper.cancelOrder(dispatcher, systemUserLogin, orderId);
		    }

		    if (okay) {
			// set the payment preference
			okay = setPaymentPreferencesNotify(delegator, dispatcher, systemUserLogin, orderId, request, gatewayResponse);
		    }
		} catch (Exception e) {
		    String errMsg = "Error handling payease notification";
		    Debug.logError(e, errMsg, module);
		    try {
			TransactionUtil.rollback(beganTransaction, errMsg, e);
		    } catch (GenericTransactionException gte2) {
			Debug.logError(gte2, "Unable to rollback transaction", module);
		    }
		    request.setAttribute("retStatus", "error");
		    return "error";
		} finally {
		    if (!okay) {
			try {
			    TransactionUtil.rollback(beganTransaction, "Failure in processing payease callback", null);
			} catch (GenericTransactionException gte) {
			    Debug.logError(gte, "Unable to rollback transaction", module);
			}
			request.setAttribute("retStatus", "error");
			return "error";
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
		     * Map <String, String> emailContext =
		     * UtilMisc.toMap("orderId", orderId); try {
		     * dispatcher.runSync("sendOrderConfirmation",
		     * emailContext); } catch (GenericServiceException e) {
		     * Debug.logError(e, "Problems sending email confirmation",
		     * module); }
		     */
		}

	    }

	    //UtilPayease.streamContentToBrowser(request, response, "sent", null);
	    request.setAttribute("retStatus", "success");
	    return "success";

	} catch (Exception ex) {
	    Debug.logError(ex, module);
	    //UtilPayease.streamContentToBrowser(request, response, "error", null);
	    request.setAttribute("retStatus", "error");
	    return "error";
	}
    }

    /** Event called when customer cancels a payease order */
    public static String cancelPayeaseOrder(HttpServletRequest request, HttpServletResponse response) {
	Locale locale = UtilHttp.getLocale(request);
	LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");

	// get the stored order id from the session
	String orderId = (String) request.getSession().getAttribute("PAYEASE_ORDER");

	// attempt to start a transaction
	boolean beganTransaction = false;
	try {
	    beganTransaction = TransactionUtil.begin();
	} catch (GenericTransactionException gte) {
	    Debug.logError(gte, "Unable to begin transaction", module);
	}

	// cancel the order
	boolean okay = OrderChangeHelper.cancelOrder(dispatcher, userLogin, orderId);

	if (okay) {
	    try {
		TransactionUtil.commit(beganTransaction);
	    } catch (GenericTransactionException gte) {
		Debug.logError(gte, "Unable to commit transaction", module);
	    }
	} else {
	    try {
		TransactionUtil.rollback(beganTransaction, "Failure in processing payease cancel callback", null);
	    } catch (GenericTransactionException gte) {
		Debug.logError(gte, "Unable to rollback transaction", module);
	    }
	}

	// attempt to release the offline hold on the order (workflow)
	if (okay)
	    OrderChangeHelper.releaseInitialOrderHold(dispatcher, orderId);

	request.setAttribute("_EVENT_MESSAGE_", UtilProperties.getMessage(resourceErr, "payeaseEvents.previouspayeaseOrderHasBeenCancelled", locale));
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
	    for (GenericValue pref : paymentPrefs) {
		boolean okay = setPaymentPreference(dispatcher, userLogin, pref, request);
		if (!okay)
		    return false;
	    }
	}
	return true;
    }

    private static boolean setPaymentPreference(LocalDispatcher dispatcher, GenericValue userLogin, GenericValue paymentPreference, HttpServletRequest request) {
	Locale locale = UtilHttp.getLocale(request);
	String paymentDate = request.getParameter("payment_date");
	String paymentType = request.getParameter("payment_type");

	PayeaseResponse payeaseResponse = new PayeaseResponse();
	payeaseResponse.parseRequest(request);

	String paymentAmount = payeaseResponse.getV_amount();
	String paymentStatus = payeaseResponse.getV_pstatus();
	String transactionId = payeaseResponse.getV_oid();

	List<GenericValue> toStore = new LinkedList<GenericValue>();

	// payease returns the timestamp in the format 'hh:mm:ss Jan 1, 2000
	// PST'
	// Parse this into a valid Timestamp Object
	SimpleDateFormat sdf = new SimpleDateFormat("hh:mm:ss MMM d, yyyy z");
	java.sql.Timestamp authDate = null;
	try {
	    authDate = new java.sql.Timestamp(sdf.parse(paymentDate).getTime());
	} catch (ParseException e) {
	    Debug.logError(e, "Cannot parse date string: " + paymentDate, module);
	    authDate = UtilDateTime.nowTimestamp();
	} catch (NullPointerException e) {
	    Debug.logError(e, "Cannot parse date string: " + paymentDate, module);
	    authDate = UtilDateTime.nowTimestamp();
	}

	//paymentPreference.set("maxAmount", new BigDecimal(paymentAmount));
	if (payeaseResponse.paySuccess()) {
	    paymentPreference.set("statusId", "PAYMENT_RECEIVED");
	} else {
	    paymentPreference.set("statusId", "PAYMENT_NOT_RECEIVED");
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
	response.set("amount", paymentPreference.getBigDecimal("maxAmount"));
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
	    String comment = UtilProperties.getMessage(resource, "AccountingPaymentReceiveViapayease", locale);
	    results = dispatcher.runSync("createPaymentFromPreference", UtilMisc.toMap("userLogin", userLogin, "orderPaymentPreferenceId", paymentPreference.get("orderPaymentPreferenceId"), "comments", comment));
	} catch (GenericServiceException e) {
	    Debug.logError(e, "Failed to execute service createPaymentFromPreference", module);
	    request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceErr, "payeaseEvents.failedToExecuteServiceCreatePaymentFromPreference", locale));
	    return false;
	}

	if ((results == null) || (results.get(ModelService.RESPONSE_MESSAGE).equals(ModelService.RESPOND_ERROR))) {
	    Debug.logError((String) results.get(ModelService.ERROR_MESSAGE), module);
	    request.setAttribute("_ERROR_MESSAGE_", results.get(ModelService.ERROR_MESSAGE));
	    return false;
	}

	return true;
    }

    private static boolean setPaymentPreferencesNotify(Delegator delegator, LocalDispatcher dispatcher, GenericValue userLogin, String orderId, HttpServletRequest request, Map gatewayResponse) {
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
	    for (GenericValue pref : paymentPrefs) {
		boolean okay = setPaymentPreferenceNotify(dispatcher, userLogin, pref, request, gatewayResponse);
		if (!okay)
		    return false;
	    }
	}
	return true;
    }

    private static boolean setPaymentPreferenceNotify(LocalDispatcher dispatcher, GenericValue userLogin, GenericValue paymentPreference, HttpServletRequest request, Map gatewayResponse) {
	Locale locale = UtilHttp.getLocale(request);
	


	String paymentAmount = (String) gatewayResponse.get("amount");
	String paymentStatus = (String) gatewayResponse.get("pstatus");
	String transactionId = (String) gatewayResponse.get("oid");
	String gatewayMessage = (String) gatewayResponse.get("pstring");
	String pmode = (String) gatewayResponse.get("pmode");

	boolean paySuccess = true;
	if (!"1".equals(paymentStatus)) {
	    paySuccess = false;
	}
	
	Delegator delegator = paymentPreference.getDelegator();
	
	List<GenericValue> toStore = new LinkedList<GenericValue>();

	String orderId = paymentPreference.getString("orderId");
	GenericValue orderHeader = null;
	try {
	    orderHeader = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId",orderId), false);
	} catch (GenericEntityException e1) {
	    // TODO Auto-generated catch block
	    e1.printStackTrace();
	}
	

	//paymentPreference.set("maxAmount", new BigDecimal(paymentAmount));
	if (paySuccess) {
	    paymentPreference.set("statusId", "PAYMENT_RECEIVED");
	    orderHeader.put("paymentStatus", "PAYMENT_RECEIVED");
	} else {
	    paymentPreference.set("statusId", "PAYMENT_NOT_RECEIVED");
	    orderHeader.put("paymentStatus", "PAYMENT_NOT_RECEIVED");
	}
	toStore.add(paymentPreference);
	toStore.add(orderHeader);
	

	// create the PaymentGatewayResponse
	String responseId = delegator.getNextSeqId("PaymentGatewayResponse");
	GenericValue response = delegator.makeValue("PaymentGatewayResponse");
	response.set("paymentGatewayResponseId", responseId);
	response.set("paymentServiceTypeEnumId", "PRDS_PAY_EXTERNAL");
	response.set("orderPaymentPreferenceId", paymentPreference.get("orderPaymentPreferenceId"));
	response.set("paymentMethodTypeId", paymentPreference.get("paymentMethodTypeId"));
	response.set("paymentMethodId", paymentPreference.get("paymentMethodId"));

	// set the auth info
	response.set("amount", paymentPreference.getBigDecimal("maxAmount"));
	response.set("referenceNum", transactionId);
	response.set("altReference", pmode);
	response.set("subReference", paymentAmount);
	response.set("gatewayCode", paymentStatus);
	response.set("gatewayFlag", paymentStatus.substring(0, 1));
	response.set("gatewayMessage", gatewayMessage);
	response.set("transactionDate", UtilDateTime.nowTimestamp());
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
	    String comment = UtilProperties.getMessage(resource, "AccountingPaymentReceiveViapayease", locale);
	    results = dispatcher.runSync("createPaymentFromPreference", UtilMisc.toMap("userLogin", userLogin, "orderPaymentPreferenceId", paymentPreference.get("orderPaymentPreferenceId"), "comments", comment));
	} catch (GenericServiceException e) {
	    Debug.logError(e, "Failed to execute service createPaymentFromPreference", module);
	    request.setAttribute("_ERROR_MESSAGE_", UtilProperties.getMessage(resourceErr, "payeaseEvents.failedToExecuteServiceCreatePaymentFromPreference", locale));
	    return false;
	}

	if ((results == null) || (results.get(ModelService.RESPONSE_MESSAGE).equals(ModelService.RESPOND_ERROR))) {
	    Debug.logError((String) results.get(ModelService.ERROR_MESSAGE), module);
	    request.setAttribute("_ERROR_MESSAGE_", results.get(ModelService.ERROR_MESSAGE));
	    return false;
	}

	return true;
    }
}
