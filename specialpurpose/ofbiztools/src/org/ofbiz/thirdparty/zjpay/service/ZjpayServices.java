package org.ofbiz.thirdparty.zjpay.service;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.DelegatorFactory;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.ServiceAuthException;
import org.ofbiz.service.ServiceValidationException;
import org.ofbiz.thirdparty.zjpay.config.ZjpayConfig;

import payment.api.system.PaymentEnvironment;
import payment.api.system.TxMessenger;
import payment.api.tx.marketorder.Tx1311Request;
import payment.api.tx.marketorder.Tx1333Request;
import payment.api.tx.marketorder.Tx1333Response;
import payment.api.tx.marketorder.Tx1341Request;
import payment.api.tx.marketorder.Tx134xResponse;
import payment.api.vo.BankAccount;
import payment.tools.util.XmlUtil;

public class ZjpayServices {

	public static final String module = ZjpayServices.class.getName();
	public static final String resource = "FilmOrderUiLabels";
	
	public static String zjpayApi(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		ZjpayConfig zjpayConfig = new ZjpayConfig();
		String sHtmlText ="";
		try {
			System.out.println("===================begin======================");
			String orderId = (String) request.getAttribute("orderId");
			if (UtilValidate.isEmpty(orderId)) {
				orderId = request.getParameter("orderId");
			}
			GenericValue orderHeader = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId", orderId),false);
			String bankId = orderHeader.getString("transactionId");
			
			//加入16位数字 外部id
			String externalId = UtilDateTime.nowDateString("yyyyMMddhhmmss");
			long Temp; 
			Temp=Math.round(Math.random()*89+10);
			externalId = externalId+Temp;
			orderHeader.set("externalId",externalId);
			orderHeader.store();
			//服务器同步通知页面路径
			String return_url = zjpayConfig.notify_url;
			//商户订单号
			String out_trade_no = new String(orderId);
			//付款金额
			
			String total_fee = String.valueOf(orderHeader.getBigDecimal("grandTotal").doubleValue()*100);
			long amount = Long.valueOf(total_fee.substring(0, total_fee.indexOf(".")));
			
			 	Tx1311Request tx1311Request = new Tx1311Request();
	            tx1311Request.setInstitutionID(zjpayConfig.partner);
	            tx1311Request.setOrderNo(orderId);
	            tx1311Request.setPaymentNo(externalId);
	            tx1311Request.setAmount(amount);
	            tx1311Request.setFee(0);
	            tx1311Request.setPayerID("");
	            tx1311Request.setPayerName("");
	            tx1311Request.setUsage(out_trade_no);
	            tx1311Request.setRemark(out_trade_no);
	            tx1311Request.setNotificationURL(return_url);
	            tx1311Request.setBankID(bankId);
	            
	            Map map = FastMap.newInstance();
	            
	            GenericValue orderRole = EntityUtil.getFirst(delegator.findByAnd("OrderRole", UtilMisc.toMap("orderId", orderId,
	            		"roleTypeId","BILL_TO_CUSTOMER")));
	            String partyId = orderRole.getString("partyId");
	            GenericValue person = delegator.findOne("Person", UtilMisc.toMap("partyId", partyId), false);
	            String customerType = person.getString("customerType");
	            if(customerType.equals("PERSONAL_BUYER")){
	            	tx1311Request.setAccountType(11);
	            }else if(customerType.equals("ENTERPRISE_BUYER")){
	            	tx1311Request.setAccountType(12);
	            }
	            
	           

	            // 3.执行报文处理
	            tx1311Request.process();
			
			
			
			//把请求参数打包成数组
			Map<String, Object> sParaTemp = new HashMap<String, Object>();
			
			
			String prettyPlainText = XmlUtil.createPrettyFormat(XmlUtil.createDocument(tx1311Request.getRequestPlainText()));
	        
			sParaTemp.put("plainText", prettyPlainText);
	        sParaTemp.put("message", tx1311Request.getRequestMessage());
			sParaTemp.put("signature", tx1311Request.getRequestSignature());
			sParaTemp.put("txCode", "1311");
			sParaTemp.put("txName", "商户订单支付（直通车）");
			sParaTemp.put("Flag", "");
			Debug.log("========end========="+PaymentEnvironment.paymentURL);
			
			sHtmlText = buildRequest(PaymentEnvironment.paymentURL,sParaTemp,"post");
			} catch (Exception e) {
				Debug.log("跳转出错!");
				e.printStackTrace();
			}
		request.setAttribute("sHtmlText", sHtmlText);	
		return "success";
	}
	
	
	/**
	 * 市场模式结算
	 * @param request
	 * @param response
	 * @return
	 */
	public static String updateOrderReceipt(HttpServletRequest request,HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		String orderId = request.getParameter("orderId");
			try {
	                GenericValue orderHeader = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId",orderId),false);
	                String receiptStatusId = orderHeader.getString("receiptStatusId");
	                if(!receiptStatusId.equals("Y")){
	                	GenericValue productStore = delegator.findOne("ProductStore", UtilMisc.toMap("productStoreId", orderHeader.getString("productStoreId")), false);
                        String partyId = productStore.getString("payToPartyId");
                        GenericValue partyGroup = delegator.findOne("PartyGroup", UtilMisc.toMap("partyId", partyId), false);
                        String bankId = partyGroup.getString("bankId");
                        GenericValue bank = delegator.findOne("PayToBank", UtilMisc.toMap("payId", "ZJpay","bankId",bankId), false);
                        GenericValue province = delegator.findOne("Province", UtilMisc.toMap("provinceId", partyGroup.getString("bankProvince")), false);
                        GenericValue city = delegator.findOne("City", UtilMisc.toMap("cityId", partyGroup.getString("bankCity")), false);
                        
                        String bankCode = bank.getString("bankCode");
                        //发送电文.运用商户模式.把金额打入商户卡中
                        //执行1341
                        
                        
                        //扣除佣金    百分比 或者固定金额
           			 
           			 	 GenericValue gv = delegator.findOne("Enumeration", UtilMisc.toMap("enumId", "AMOUNT_YJ"), false);
                         String yjType = gv.getString("enumCode");
                         String yjAmount = gv.getString("description");
           			 	 double grandTotal = orderHeader.getBigDecimal("grandTotal").doubleValue();
                         //百分比模式
                         if(yjType.equals("1")){
                        	 grandTotal = grandTotal-grandTotal*(Double.valueOf(yjAmount)/100);
                         //固定金额模式
                         }else if(yjType.equals("0")){
                        	 grandTotal = grandTotal-Double.valueOf(yjAmount);
                         }
           			 	 
           			 	 
            			 String total_fee = String.valueOf(grandTotal*100);
            			 long amount = Long.valueOf(total_fee.substring(0, total_fee.indexOf(".")));
            			 
            			
            			 
                        ZjpayConfig zjpayConfig = new ZjpayConfig();
                        String serialNumber = UtilDateTime.nowDateString("yyyyMMddhhmmss");
            			 long Temp; 
            			 Temp=Math.round(Math.random()*89+10);
            			 serialNumber = serialNumber+Temp;
                        
                        Tx1341Request tx1341Request = new Tx1341Request();
                        tx1341Request.setInstitutionID(zjpayConfig.partner);
                        tx1341Request.setSerialNumber(serialNumber);
                        tx1341Request.setOrderNo(orderId);
                        tx1341Request.setAmount(amount);
                        tx1341Request.setRemark(orderId);
                        
                        String sellerType = partyGroup.getString("sellerType");
                        
                        if(sellerType.equals("PERSONAL_SELLER")){
                        	tx1341Request.setAccountType(11);	//判定卖家类型.  11个人  12 公司
                        }else if(sellerType.equals("ENTERPRISE_SELLER")){
                        	tx1341Request.setAccountType(12);	//判定卖家类型.  11个人  12 公司
                        }
                        
//                        tx1341Request.setPaymentAccountName(paymentAccountName);
//                        tx1341Request.setPaymentAccountNumber(paymentAccountNumber);
                        
//                        if(paymentNos != null && paymentNos.length > 0){
//                            List<String> paymentNoList = new ArrayList<String>(); 
//                            for(int i = 0;i < paymentNos.length;i ++){
//                                if(StringUtil.isNotEmpty(paymentNos[i])){
//                                    paymentNoList.add(paymentNos[i]);
//                                }
//                            }
//                            tx1341Request.setPaymentNoList(paymentNoList);
//                        }

                        BankAccount bankAccount = new BankAccount();
                        bankAccount.setBankID(bankCode);
                        bankAccount.setAccountName(partyGroup.getString("bankUserName"));
                        bankAccount.setAccountNumber(partyGroup.getString("bankCode"));
                        bankAccount.setBranchName(partyGroup.getString("bankAddress"));
                        bankAccount.setProvince(province.getString("provinceName"));
                        bankAccount.setCity(city.getString("cityName"));
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
                       	 GenericValue newOrder = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId",orderId),false);
	                         newOrder.set("receiptStatusId", "Y");
	                         newOrder.set("serialNumber", serialNumber);
	                         newOrder.store();
                         }         
	                }
	                request.setAttribute("orderId", orderId);
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
		} catch (UnsupportedEncodingException e) {
			Debug.logError(e.getMessage(), module);
		} catch (ServiceAuthException e) {
			Debug.logError(e.getMessage(), module);
		} catch (ServiceValidationException e) {
			Debug.logError(e.getMessage(), module);
		} catch (GenericServiceException e) {
			Debug.logError(e.getMessage(), module);
		} catch (Exception e) {
			Debug.logError(e.getMessage(), module);
		}
		return "success";
	}
	
	
	/**
	 * 退款请求
	 */
	
	
	public static String zjpayRefund(String orderId) {
		Delegator delegator = DelegatorFactory.getDelegator("default");
		ZjpayConfig zjpayConfig = new ZjpayConfig();
		String code ="0000";
		try {
			System.out.println("===================begin======================");
			GenericValue orderHeader = delegator.findOne("OrderHeader", UtilMisc.toMap("orderId", orderId),false);
			//交易流水号
			String externalId = orderHeader.getString("externalId");
			//加入16位数字 外部id
			String serialNumber = UtilDateTime.nowDateString("yyyyMMddhhmmss");
			long Temp; 
			Temp=Math.round(Math.random()*89+10);
			serialNumber = serialNumber+Temp;
			String total_fee = String.valueOf(orderHeader.getBigDecimal("grandTotal").doubleValue()*100);
			long amount = Long.valueOf(total_fee.substring(0, total_fee.indexOf(".")));
			
			// 2.创建交易请求对象
            Tx1333Request tx1333Request = new Tx1333Request();
            tx1333Request.setInstitutionID(zjpayConfig.partner);
            tx1333Request.setSerialNumber(serialNumber);
            tx1333Request.setOrderNo(orderId);
            tx1333Request.setPaymentNo(externalId);	//原支付流水号
            tx1333Request.setAmount(amount);
            tx1333Request.setRemark("");

            // 3.执行报文处理
            tx1333Request.process();
            
            // 4.与支付平台进行通讯         
            TxMessenger txMessenger = new TxMessenger();         
            // 0:message; 1:signature  
            String[] respMsg = txMessenger.send(tx1333Request.getRequestMessage(), tx1333Request.getRequestSignature());         
            // 5.交易结果处理  0:message; 1:signature         
            Tx1333Response tx1333Response = new Tx1333Response(respMsg[0], respMsg[1]);    
            Debug.log("=================tx1333Response.getCode():"+tx1333Response.getCode());
            // 6. 如果返回正常报文 
            code = tx1333Response.getCode();
            if ("2000".equals(tx1333Response.getCode())) {
            	
            	//电文发送成功.
           	 Debug.log("[Message]=[" + tx1333Response.getMessage()+ "],没有问题.退款成功.");                 
           	 //商户根据自己的业务要求编写相应的业务处理代码       
           	 
           	 
             } 
			} catch (Exception e) {
				Debug.log("跳转出错!");
				e.printStackTrace();
			}
		return code;
	}
	
	
	/**
	 * 建立请求，以表单HTML形式构造（默认）
	 * 
	 * @param sParaTemp
	 *            请求参数数组
	 * @param strMethod
	 *            提交方式。两个值可选：post、get
	 * @param strButtonName
	 *            确认按钮显示文字
	 * @return 提交表单HTML文本
	 */
	public static String buildRequest(String action,Map<String, Object> sParaTemp,
			String strMethod) {
		// 待请求参数数组
		Map<String, Object> sPara = sParaTemp;
		List<String> keys = new ArrayList<String>(sPara.keySet());

		StringBuffer sbHtml = new StringBuffer();

		sbHtml.append("<form id=\"zjPay\" name=\"zjPay\" action=\""
				+ action + "\" method=\"" + strMethod
				+ "\">");
		for (int i = 0; i < keys.size(); i++) {
			String name = (String) keys.get(i);
			String value = (String) sPara.get(name);
			if(name.equals("plainText")){
				sbHtml.append("<textarea name=\""+name+"\" style='display:none;'>"+value+"</textarea>");
			}else{
				sbHtml.append("<input type=\"hidden\" name=\"" + name
						+ "\" value=\"" + value + "\"/>");
			}
			
		}

		// submit按钮控件请不要含有name属性
		sbHtml.append("<input type=\"submit\" value=\"" + "确认"
				+ "\" style=\"display:none;\"></form>");
		sbHtml.append("<script>document.forms['zjPay'].submit();</script>");

		return sbHtml.toString();
	}
}
