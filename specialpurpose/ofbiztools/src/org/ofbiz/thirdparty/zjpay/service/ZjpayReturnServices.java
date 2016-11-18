package org.ofbiz.thirdparty.zjpay.service;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.ofc.tools.CommonUtils;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceAuthException;
import org.ofbiz.service.ServiceUtil;
import org.ofbiz.service.ServiceValidationException;
import org.ofbiz.thirdparty.zjpay.config.ZjpayConfig;

import payment.api.notice.Notice1118Request;
import payment.api.notice.Notice1138Request;
import payment.api.notice.Notice1318Request;
import payment.api.notice.Notice1348Request;
import payment.api.notice.NoticeRequest;
import payment.api.notice.NoticeResponse;
import payment.api.system.TxMessenger;
import payment.api.tx.marketorder.Tx1341Request;
import payment.api.tx.marketorder.Tx134xResponse;
import payment.api.vo.BankAccount;
import payment.tools.util.Base64;
import payment.tools.util.StringUtil;

public class ZjpayReturnServices{

	public static final String module = ZjpayReturnServices.class.getName();
	public static final String resource = "FilmOrderUiLabels";
	public static String message="";
	/**
	 * 同步返回数据
	 * @param dctx
	 * @param context
	 */
	/**
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings({ "unused", "deprecation"})
	public static String zjpayReturn(HttpServletRequest request,HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		LocalDispatcher dispatcher =(LocalDispatcher) request.getAttribute("dispatcher");
		ZjpayConfig zjpayConfig = new ZjpayConfig();
		String returnIsInfo ="success";
		
		try {
			 	Debug.log("---------- Begin [ReceiveNoticePage] process......");
			 	GenericValue userLogin =delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId","admin"),false);
	            // 获得参数message和signature
	            String message = request.getParameter("message");
	            String signature = request.getParameter("signature");
	            // 定义变量
	            String txName = "";
	            // 生成交易结果对象
	            NoticeRequest noticeRequest = new NoticeRequest(message, signature);
	            Debug.log("noticeRequest.getTxCode()==================="+noticeRequest.getTxCode());
	            if ("1318".equals(noticeRequest.getTxCode())) {
	                Notice1318Request nr = new Notice1318Request(noticeRequest.getDocument());
	                String externalId = nr.getPaymentNo();
	                
	                	
                        
	                	
	                	 // ！！！ 在这里添加商户处理逻辑！！！
	 	                // 以下为演示代码
	 	                txName = "商户订单支付状态变更通知";
	 	                Debug.log("[TxCode]       = [1318]");
	 	                Debug.log("[TxName]       = [商户订单支付状态变更通知]");
	 	                Debug.log("[InstitutionID]= [" + nr.getInstitutionID() + "]");
	 	                Debug.log("[PaymentNo]    = [" + nr.getPaymentNo() + "]");
	 	                Debug.log("[Amount]       = [" + nr.getAmount() + "]");
	 	                Debug.log("[Status]       = [" + nr.getStatus() + "]");
	 	                Debug.log("[BankNotificationTime]       = [" + nr.getBankNotificationTime() + "]");
	                     //支付成功，修改状态。
	                     Debug.log("trade_status======================"+nr.getStatus());
	                     
	 	                if (20 == nr.getStatus()) {
	 	                	Debug.log("receive 1118 notification success");
	 	                	 
	 	                	GenericValue finAccountLog = delegator.findOne("FinAccountLog", false, UtilMisc.toMap("baseId", externalId));
	 		                
	 	                	if(UtilValidate.isNotEmpty(finAccountLog)){
		                		String paymentStatusId = finAccountLog.getString("paymentStatusId");
		                		String statusId = finAccountLog.getString("statusId");
		                		
		                		String logType = finAccountLog.getString("logType"); 
		                		GenericValue systemUser = delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId", "system"), false);
		                		if(logType.equals("Auth")){
		                			if(statusId.equals("IM_PENDING")){
			        					finAccountLog.set("fromDate", UtilDateTime.nowTimestamp());
			        					Timestamp trueDate = Timestamp.valueOf(CommonUtils.getOneYearsLaterTime());
			        					finAccountLog.set("thruDate", trueDate);//1年后
			        					finAccountLog.set("statusId", "IM_APPROVED");
			        					finAccountLog.store();
			        					
			        					String productStoreId = finAccountLog.getString("productStoreId");
			        					
			        					GenericValue productStore = delegator.findOne("ProductStore", UtilMisc.toMap("productStoreId", productStoreId), false);
			        					productStore.set("paymentPercentage", finAccountLog.getBigDecimal("amount"));
			        					productStore.store();
			        					GenericValue account = EntityUtil.getFirst(delegator.findByAnd("FinAccount", UtilMisc.toMap("ownerPartyId", productStore.getString("payToPartyId"),
			        							"finAccountTypeId","RZ_AMOUNT")));
			        					account.set("fromDate", UtilDateTime.nowTimestamp());
			        					account.set("thruDate", trueDate);//1年后
			        					account.store();
			        					//给相应的卡充值
			        					dispatcher.runSync("createRecharge", UtilMisc.toMap("finAccountId", account.getString("finAccountId"),
			        							"ownerPartyId",productStore.getString("payToPartyId"),"productStoreId",productStoreId,
			        							"amount",finAccountLog.getBigDecimal("amount"),"userLogin",systemUser));
			        				}
		                		}else if(logType.equals("quote")){
		                			if(statusId.equals("IM_PENDING")){
		            					finAccountLog.set("statusId", "IM_APPROVED");
		            					finAccountLog.store();
		            					String productStoreId = finAccountLog.getString("productStoreId");
		            					GenericValue productStore = delegator.findOne("ProductStore", UtilMisc.toMap("productStoreId", productStoreId), false);
		            					BigDecimal maxQuoteAmount = productStore.getBigDecimal("maxQuoteAmount");
		            					if(UtilValidate.isNotEmpty(maxQuoteAmount)){
		            						maxQuoteAmount = maxQuoteAmount.add(finAccountLog.getBigDecimal("amount"));
		            					}else{
		            						maxQuoteAmount = finAccountLog.getBigDecimal("amount");
		            					}
		            					productStore.set("maxQuoteAmount",maxQuoteAmount);
		            					productStore.store();
		            					
		            					GenericValue account = EntityUtil.getFirst(delegator.findByAnd("FinAccount", UtilMisc.toMap("ownerPartyId", productStore.getString("payToPartyId"),
		            							"finAccountTypeId","RW_AMOUNT")));
		            					account.set("fromDate", UtilDateTime.nowTimestamp());
		            					Timestamp trueDate = Timestamp.valueOf(CommonUtils.getOneYearsLaterTime());
		            					account.set("thruDate", trueDate);//1年后
		            					account.store();
		            					//给相应的卡充值
		            					dispatcher.runSync("createRecharge", UtilMisc.toMap("finAccountId", account.getString("finAccountId"),
		            							"ownerPartyId",productStore.getString("payToPartyId"),"productStoreId",productStoreId,
		            							"amount",finAccountLog.getBigDecimal("amount"),"userLogin",systemUser));
		            				}
		                		}
		                		
		                		//String partyId = finAccountLog.getString("partyId");
		                		
		                		
		                		if(UtilValidate.isEmpty(paymentStatusId)){	//市场模式未经结算
		                			String serialNumber = UtilDateTime.nowDateString("yyyyMMddhhmmss");
			           			    long Temp; 
			           			    Temp=Math.round(Math.random()*89+10);
			           			    serialNumber = serialNumber+Temp;
				                	
				                	Tx1341Request tx1341Request = new Tx1341Request();
			                        tx1341Request.setInstitutionID(zjpayConfig.partner);
			                        tx1341Request.setSerialNumber(serialNumber);
			                        tx1341Request.setOrderNo(externalId);
			                        tx1341Request.setAmount(nr.getAmount());
			                        tx1341Request.setRemark(externalId);
			                        tx1341Request.setAccountType(12);		//此处是结算给云投   12
			                        	
			                        BankAccount bankAccount = new BankAccount();
			                        bankAccount.setBankID(UtilProperties.getPropertyValue("bank.properties", "bankId"));
			                        bankAccount.setAccountName(UtilProperties.getPropertyValue("bank.properties", "accountName"));
			                        bankAccount.setAccountNumber(UtilProperties.getPropertyValue("bank.properties", "accountNumber"));
			                        bankAccount.setBranchName(UtilProperties.getPropertyValue("bank.properties", "bankAddress"));
			                        bankAccount.setProvince(UtilProperties.getPropertyValue("bank.properties", "provinceId"));
			                        bankAccount.setCity(UtilProperties.getPropertyValue("bank.properties", "cityId"));
			                        tx1341Request.setBankAccount(bankAccount);
			                        
			                        // 3.执行报文处理
			                        tx1341Request.process();
			                        
			                        // 4.与支付平台进行通讯         
			                        TxMessenger txMessenger = new TxMessenger();         
			                        // 0:message; 1:signature  
			                        String[] respMsg = txMessenger.send(tx1341Request.getRequestMessage(), tx1341Request.getRequestSignature());         
			                        // 5.交易结果处理  0:message; 1:signature         
			                        Tx134xResponse tx134xResponse = new Tx134xResponse(respMsg[0], respMsg[1]);    
			                        Debug.log("=================tx134xResponse.getCode():"+tx134xResponse.getCode());
			                        // 6. 如果返回正常报文 
			                        if ("2000".equals(tx134xResponse.getCode())) {
			                        	//电文发送成功.
			                       	 Debug.log("[Message]=[" + tx134xResponse.getMessage()+ "]");                 
			                       	 //商户根据自己的业务要求编写相应的业务处理代码         
			                       	 finAccountLog.set("paymentStatusId", "Y");
			                       	 finAccountLog.set("serialNumber", serialNumber);
			                       	 finAccountLog.store();
			                         } 
		                		}
		                		
		                    	request.setAttribute("orderId", nr.getPaymentNo());
		                	}else{
		                		 GenericValue orderHeader = EntityUtil.getFirst(delegator.findByAnd("OrderHeader", UtilMisc.toMap("externalId", externalId)));
			 	    			 String out_trade_no = orderHeader.getString("orderId");
		 	                	 if(UtilValidate.isNotEmpty(orderHeader) && "ORDER_CREATED".equals(orderHeader.get("statusId"))){
		 	                         returnIsInfo="success";
		 	                         Map<String,Object> map = FastMap.newInstance();
		 	                         map.put("setItemStatus", "Y");
		 	                         map.put("statusId", "ORDER_APPROVED");
		 	                         map.put("orderId", out_trade_no);
		 	                         map.put("userLogin", userLogin);
		 	                         Map<String,Object> result = dispatcher.runSync("changeOrderStatus", map);
		 	                         Debug.log("message====="+result);
		 	                        
		 	                         //查询当前流水ID 
		 	                         GenericValue orderPayment = EntityUtil.getFirst(delegator.findByAnd("OrderPaymentPreference",
		 	                         		UtilMisc.toMap("orderId", out_trade_no,"paymentMethodTypeId","EXT_ZJPAY","statusId","PAYMENT_NOT_RECEIVED")));
		 	                         Map<String,Object> mapPayment = FastMap.newInstance();
		 	                         mapPayment.put("orderPaymentPreferenceId", orderPayment.getString("orderPaymentPreferenceId"));
		 	                         mapPayment.put("orderId", out_trade_no);
		 	                         mapPayment.put("paymentMethodTypeId", "EXT_ZJPAY");
		 	                         mapPayment.put("presentFlag", "N");
		 	                         mapPayment.put("swipedFlag", "N");
		 	                         mapPayment.put("overflowFlag", "N");
		 	                         mapPayment.put("createdDate", UtilDateTime.nowTimestamp());
		 	                         mapPayment.put("statusId", "PAYMENT_RECEIVED");
		 	                         mapPayment.put("maxAmount", orderHeader.getBigDecimal("grandTotal"));
		 	                         mapPayment.put("createdByUserLogin", orderHeader.getString("createdBy"));
		 	                         
		 	                         mapPayment.put("userLogin", userLogin);
		 	                         dispatcher.runSync("updateOrderPaymentPreference", mapPayment);
		 	                         
		 	                         if(!ServiceUtil.isSuccess(result)){}
		 	         				 
		 	                         GenericValue newOrder = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId",out_trade_no),false);
		 	                         newOrder.set("externalId", externalId);
		 	                         newOrder.set("receiptStatusId", "N");
		 	                         newOrder.store();
		 	                     }
		 	                	request.setAttribute("orderId", out_trade_no);
		                	}
	                }
	               
	                
	                
	             // 4 响应支付平台 特别说明：为避免重复发通知，必须要求商户给予响应，响应的内容是固定的new String(Base64.encode(new NoticeResponse().getMessage().getBytes("UTF-8")));
	                
	                String xmlString = new NoticeResponse().getMessage();

	                String base64String = new String(Base64.encode(xmlString.getBytes("UTF-8")));
	                Debug.log("base64String============="+base64String);
	                
	                PrintWriter out = response.getWriter();
	                out.print(base64String);
	                out.flush();
	                out.close();
	                
	               
	            }else if ("1348".equals(noticeRequest.getTxCode())) {
	    			// 2.创建通知对象
	    			Notice1348Request nr = new Notice1348Request(noticeRequest.getDocument());
	    			// 3.执行报文处理 logger.debug("[TxName]       = [市场订单结算状态变更通知]");
	    			Debug.log("[TxCode]       = [1348]");
	    			Debug.log("[InstitutionID]= [" + nr.getInstitutionID() + "]");
	    			Debug.log("[OrderNo]      = [" + nr.getOrderNo() + "]");
	    			Debug.log("[SerialNumber] = [" + nr.getSerialNumber() + "]");
	    			Debug.log("[Amount]       = [" + nr.getAmount() + "]");
	    			Debug.log("[Status]       = [" + nr.getStatus() + "]");
	    			Debug.log("[TransferTime]       = [" + nr.getTransferTime() + "]");
	    			Debug.log("[ErrorMessage]       = [" + nr.getErrorMessage() + "]");

	    			Debug.log("trade_status======================"+nr.getStatus());
	    			
	            	if (40 == nr.getStatus() || 50 == nr.getStatus()) {
	    				// 5.商户根据自己的业务要求编写相应的业务处理代码
	    				//报文中未标示出对应的结算交易为1341还是1343,需要商户根据SerialNumber自行判断         ……        
	    				//响应支付平台         
	            		//商户根据自己的业务要求编写相应的业务处理代码         
                      	 GenericValue newOrder = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId",nr.getOrderNo()),false);
	                         newOrder.set("receiptStatusId", "Y");
	                         newOrder.set("serialNumber", nr.getSerialNumber());
	                         newOrder.store();
                        }    
	    			
	    			String plainText = new NoticeResponse().getMessage();
	    			String base64Text = new String(Base64.encode(plainText.getBytes(StringUtil.DEFAULT_CHARSET)), StringUtil.DEFAULT_CHARSET); 
	    			
	    			Debug.log("base64String============="+base64Text);
	    			PrintWriter out = response.getWriter();
	    	        out.print(base64Text); 
	    	        out.flush();
	    	        out.close(); 
	            }else  if ("1118".equals(noticeRequest.getTxCode())) {
	                Notice1118Request nr = new Notice1118Request(noticeRequest.getDocument());
	                String externalId = nr.getPaymentNo();
	                // ！！！ 在这里添加商户处理逻辑！！！
	                // 以下为演示代码
	                txName = "商户订单支付状态变更通知";
	                Debug.log("[TxCode]       = [1118]");
	                Debug.log("[TxName]       = [商户订单支付状态变更通知]");
	                Debug.log("[InstitutionID]= [" + nr.getInstitutionID() + "]");
	                Debug.log("[PaymentNo]    = [" + nr.getPaymentNo() + "]");
	                Debug.log("[Amount]       = [" + nr.getAmount() + "]");
	                Debug.log("[Status]       = [" + nr.getStatus() + "]");
	                Debug.log("[BankNotificationTime]       = [" + nr.getBankNotificationTime() + "]");
                    //支付成功，修改状态。
                    Debug.log("trade_status======================"+nr.getStatus());
                    
	                if (20 == nr.getStatus()) {
	                	Debug.log("receive 1118 notification success");
	                	
	                	returnIsInfo = "success";
	                }
	                
	                String plainText = new NoticeResponse().getMessage();
	    			String base64Text = new String(Base64.encode(plainText.getBytes(StringUtil.DEFAULT_CHARSET)), StringUtil.DEFAULT_CHARSET); 
	    			
	    			Debug.log("base64String============="+base64Text);
	    			PrintWriter out = response.getWriter();
	    	        out.print(base64Text); 
	    	        out.flush();
	    	        out.close(); 
	            }else if ("1138".equals(noticeRequest.getTxCode())) {
	                Notice1138Request nr = new Notice1138Request(noticeRequest.getDocument());
	                // ！！！ 在这里添加商户处理逻辑！！！
	                // 以下为演示代码
	                Debug.log("[TxCode]       = [1138]");
	                Debug.log("[TxName]       = [商户订单退款结算状态变更通知]");
	                Debug.log("[InstitutionID]= [" + nr.getInstitutionID() + "]");
	                Debug.log("[SerialNumber] = [" + nr.getSerialNumber() + "]");
	                Debug.log("[PaymentNo] = [" + nr.getPaymentNo() + "]");
	                Debug.log("[Amount]       = [" + nr.getAmount() + "]");
	                Debug.log("[Status]       = [" + nr.getStatus() + "]");
	                Debug.log("[RefundTime]       = [" + nr.getRefundTime() + "]");
	                Debug.log("receive 1138 notification success");
	                
	                String plainText = new NoticeResponse().getMessage();
	    			String base64Text = new String(Base64.encode(plainText.getBytes(StringUtil.DEFAULT_CHARSET)), StringUtil.DEFAULT_CHARSET); 
	    			
	    			Debug.log("base64String============="+base64Text);
	    			PrintWriter out = response.getWriter();
	    	        out.print(base64Text); 
	    	        out.flush();
	    	        out.close(); 
	            }
			
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (UnsupportedEncodingException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (ServiceAuthException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (ServiceValidationException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (GenericServiceException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (Exception e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		}
		return returnIsInfo;
	}
	
	
	
	@SuppressWarnings("deprecation")
	public static String zjpayTBReturn(HttpServletRequest request,HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		LocalDispatcher dispatcher =(LocalDispatcher) request.getAttribute("dispatcher");
		ZjpayConfig zjpayConfig = new ZjpayConfig();
		String returnIsInfo ="success";
		
		try {
			 	Debug.log("---------- Begin [ReceiveNoticePage] process......");
			 	GenericValue userLogin =delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId","admin"),false);
	            // 获得参数message和signature
	            String message = request.getParameter("message");
	            String signature = request.getParameter("signature");
	            String txName = "";
	            // 生成交易结果对象
	            NoticeRequest noticeRequest = new NoticeRequest(message, signature);
	            Debug.log("noticeRequest.getTxCode()==================="+noticeRequest.getTxCode());
	            if ("1318".equals(noticeRequest.getTxCode())) {
	                Notice1318Request nr = new Notice1318Request(noticeRequest.getDocument());
	                String externalId = nr.getPaymentNo();
	 	                txName = "商户订单支付状态变更通知";
	 	                Debug.log("[TxCode]       = [1318]");
	 	                Debug.log("[TxName]       = [商户订单支付状态变更通知]");
	 	                Debug.log("[InstitutionID]= [" + nr.getInstitutionID() + "]");
	 	                Debug.log("[PaymentNo]    = [" + nr.getPaymentNo() + "]");
	 	                Debug.log("[Amount]       = [" + nr.getAmount() + "]");
	 	                Debug.log("[Status]       = [" + nr.getStatus() + "]");
	 	                Debug.log("[BankNotificationTime]       = [" + nr.getBankNotificationTime() + "]");
	                     //支付成功，修改状态。
	                    Debug.log("trade_status======================"+nr.getStatus());
	                     
	 	                if (20 == nr.getStatus()) {
	 	                	Debug.log("receive 1318 notification success");
	 	                	 
	 	                	GenericValue finAccountLog = delegator.findOne("FinAccountLog", false, UtilMisc.toMap("baseId", externalId));
	 		                
	 	                	//如果是后台支付.且已经处理过.(此处是结算.金额结算至云投账户)
	 	                	
		                	if(UtilValidate.isNotEmpty(finAccountLog)){
		                		String paymentStatusId = finAccountLog.getString("paymentStatusId");
		                		if(UtilValidate.isEmpty(paymentStatusId)){	//市场模式未经结算
		                			String serialNumber = UtilDateTime.nowDateString("yyyyMMddhhmmss");
			           			    long Temp; 
			           			    Temp=Math.round(Math.random()*89+10);
			           			    serialNumber = serialNumber+Temp;
				                	
				                	Tx1341Request tx1341Request = new Tx1341Request();
			                        tx1341Request.setInstitutionID(zjpayConfig.partner);
			                        tx1341Request.setSerialNumber(serialNumber);
			                        tx1341Request.setOrderNo(externalId);
			                        tx1341Request.setAmount(nr.getAmount());
			                        tx1341Request.setRemark(externalId);
			                        tx1341Request.setAccountType(12);		//此处结算给云投  指定 12  企业账户
			                        	
			                        BankAccount bankAccount = new BankAccount();
			                        bankAccount.setBankID(UtilProperties.getPropertyValue("bank.properties", "bankId"));
			                        bankAccount.setAccountName(UtilProperties.getPropertyValue("bank.properties", "accountName"));
			                        bankAccount.setAccountNumber(UtilProperties.getPropertyValue("bank.properties", "accountNumber"));
			                        bankAccount.setBranchName(UtilProperties.getPropertyValue("bank.properties", "bankAddress"));
			                        bankAccount.setProvince(UtilProperties.getPropertyValue("bank.properties", "provinceId"));
			                        bankAccount.setCity(UtilProperties.getPropertyValue("bank.properties", "cityId"));
			                        tx1341Request.setBankAccount(bankAccount);
			                        
			                        // 3.执行报文处理
			                        tx1341Request.process();
			                        
			                        // 4.与支付平台进行通讯         
			                        TxMessenger txMessenger = new TxMessenger();         
			                        // 0:message; 1:signature  
			                        String[] respMsg = txMessenger.send(tx1341Request.getRequestMessage(), tx1341Request.getRequestSignature());         
			                        // 5.交易结果处理  0:message; 1:signature         
			                        Tx134xResponse tx134xResponse = new Tx134xResponse(respMsg[0], respMsg[1]);    
			                        Debug.log("=================tx134xResponse.getCode():"+tx134xResponse.getCode());
			                        // 6. 如果返回正常报文 
			                        if ("2000".equals(tx134xResponse.getCode())) {
			                        	//电文发送成功.
			                       	 Debug.log("[Message]=[" + tx134xResponse.getMessage()+ "]");                 
			                       	 //商户根据自己的业务要求编写相应的业务处理代码         
			                       	 finAccountLog.set("paymentStatusId", "Y");
			                       	finAccountLog.set("serialNumber", serialNumber);
			                       	 finAccountLog.store();
			                         } 
		                		}
		                		
		                    	request.setAttribute("orderId", nr.getPaymentNo());
		                	}else{
		                		 GenericValue orderHeader = EntityUtil.getFirst(delegator.findByAnd("OrderHeader", UtilMisc.toMap("externalId", externalId)));
			 	    			 String out_trade_no = orderHeader.getString("orderId");
		 	                	 if(UtilValidate.isNotEmpty(orderHeader) && "ORDER_CREATED".equals(orderHeader.get("statusId"))){
		 	                         returnIsInfo="success";
		 	                         Map<String,Object> map = FastMap.newInstance();
		 	                         map.put("setItemStatus", "Y");
		 	                         map.put("statusId", "ORDER_APPROVED");
		 	                         map.put("orderId", out_trade_no);
		 	                         map.put("userLogin", userLogin);
		 	                         Map<String,Object> result = dispatcher.runSync("changeOrderStatus", map);
		 	                         Debug.log("message====="+result);
		 	                        
		 	                         //查询当前流水ID 
		 	                         GenericValue orderPayment = EntityUtil.getFirst(delegator.findByAnd("OrderPaymentPreference",
		 	                         		UtilMisc.toMap("orderId", out_trade_no,"paymentMethodTypeId","EXT_ZJPAY","statusId","PAYMENT_NOT_RECEIVED")));
		 	                         Map<String,Object> mapPayment = FastMap.newInstance();
		 	                         mapPayment.put("orderPaymentPreferenceId", orderPayment.getString("orderPaymentPreferenceId"));
		 	                         mapPayment.put("orderId", out_trade_no);
		 	                         mapPayment.put("paymentMethodTypeId", "EXT_ZJPAY");
		 	                         mapPayment.put("presentFlag", "N");
		 	                         mapPayment.put("swipedFlag", "N");
		 	                         mapPayment.put("overflowFlag", "N");
		 	                         mapPayment.put("createdDate", UtilDateTime.nowTimestamp());
		 	                         mapPayment.put("statusId", "PAYMENT_RECEIVED");
		 	                         mapPayment.put("maxAmount", orderHeader.getBigDecimal("grandTotal"));
		 	                         mapPayment.put("createdByUserLogin", orderHeader.getString("createdBy"));
		 	                         
		 	                         mapPayment.put("userLogin", userLogin);
		 	                         dispatcher.runSync("updateOrderPaymentPreference", mapPayment);
		 	                         
		 	                         if(!ServiceUtil.isSuccess(result)){}
		 	         				 
		 	                         GenericValue newOrder = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId",out_trade_no),false);
		 	                         newOrder.set("externalId", externalId);
		 	                         newOrder.set("receiptStatusId", "N");
		 	                         newOrder.store();
		 	                     }
		 	                	request.setAttribute("orderId", out_trade_no);
		                	}
	                }
	            }

		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (UnsupportedEncodingException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (ServiceAuthException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (ServiceValidationException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (GenericServiceException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (Exception e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		}
		return returnIsInfo;
	}
	
	/***
	 * public static String zjpayReturn(HttpServletRequest request,HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		LocalDispatcher dispatcher =(LocalDispatcher) request.getAttribute("dispatcher");
		String returnIsInfo ="success";
		
		try {
			 	Debug.log("---------- Begin [ReceiveNoticePage] process......");
			 	GenericValue userLogin =delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId","admin"),false);
	            // 获得参数message和signature
	            String message = request.getParameter("message");
	            String signature = request.getParameter("signature");
	            // 定义变量
	            String txName = "";
	            // 生成交易结果对象
	            NoticeRequest noticeRequest = new NoticeRequest(message, signature);
	            
	            if ("1118".equals(noticeRequest.getTxCode())) {
	                Notice1118Request nr = new Notice1118Request(noticeRequest.getDocument());
	                String externalId = nr.getPaymentNo();
	                GenericValue orderHeader = EntityUtil.getFirst(delegator.findByAnd("OrderHeader", UtilMisc.toMap("externalId", externalId)));
	    			String out_trade_no = orderHeader.getString("orderId");
	                // ！！！ 在这里添加商户处理逻辑！！！
	                // 以下为演示代码
	                txName = "商户订单支付状态变更通知";
	                Debug.log("[TxCode]       = [1118]");
	                Debug.log("[TxName]       = [商户订单支付状态变更通知]");
	                Debug.log("[InstitutionID]= [" + nr.getInstitutionID() + "]");
	                Debug.log("[PaymentNo]    = [" + nr.getPaymentNo() + "]");
	                Debug.log("[Amount]       = [" + nr.getAmount() + "]");
	                Debug.log("[Status]       = [" + nr.getStatus() + "]");
	                Debug.log("[BankNotificationTime]       = [" + nr.getBankNotificationTime() + "]");
                    //支付成功，修改状态。
                    Debug.log("trade_status======================"+nr.getStatus());
                    
	                if (20 == nr.getStatus()) {
	                	Debug.log("receive 1118 notification success");
	                	 if(UtilValidate.isNotEmpty(orderHeader) && "ORDER_CREATED".equals(orderHeader.get("statusId"))){
	                         returnIsInfo="success";
	                         Map<String,Object> map = FastMap.newInstance();
	                         map.put("setItemStatus", "Y");
	                         map.put("statusId", "ORDER_APPROVED");
	                         map.put("orderId", out_trade_no);
	                         map.put("userLogin", userLogin);
	                         Map<String,Object> result = dispatcher.runSync("changeOrderStatus", map);
	                         Debug.log("message====="+result);
	                         //发送电文.运用商户模式.把金额打入商户卡中
	                         //处理支付状态
	                         //查询当前流水ID 
	                         GenericValue orderPayment = EntityUtil.getFirst(delegator.findByAnd("OrderPaymentPreference",
	                         		UtilMisc.toMap("orderId", out_trade_no,"paymentMethodTypeId","EXT_ZJPAY","statusId","PAYMENT_NOT_RECEIVED")));
	                         Map<String,Object> mapPayment = FastMap.newInstance();
	                         mapPayment.put("orderPaymentPreferenceId", orderPayment.getString("orderPaymentPreferenceId"));
	                         mapPayment.put("orderId", out_trade_no);
	                         mapPayment.put("paymentMethodTypeId", "EXT_ZJPAY");
	                         mapPayment.put("presentFlag", "N");
	                         mapPayment.put("swipedFlag", "N");
	                         mapPayment.put("overflowFlag", "N");
	                         mapPayment.put("createdDate", UtilDateTime.nowTimestamp());
	                         mapPayment.put("statusId", "PAYMENT_RECEIVED");
	                         mapPayment.put("maxAmount", orderHeader.getBigDecimal("grandTotal"));
	                         mapPayment.put("createdByUserLogin", orderHeader.getString("createdBy"));
	                         
	                         mapPayment.put("userLogin", userLogin);
	                         dispatcher.runSync("updateOrderPaymentPreference", mapPayment);
	                         
	                         if(!ServiceUtil.isSuccess(result)){
	                         	//错误处理
	                         	//金额退还到买家账户中.
	                         }

	                         GenericValue newOrder = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId",out_trade_no),false);
	                         newOrder.set("externalId", externalId);
	                         newOrder.store();
	                     }
	                }
	                
	                request.setAttribute("orderId", out_trade_no);
	            }
			
			
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (UnsupportedEncodingException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (ServiceAuthException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (ServiceValidationException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (GenericServiceException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (Exception e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		}
		return returnIsInfo;
	}
	 */
}
