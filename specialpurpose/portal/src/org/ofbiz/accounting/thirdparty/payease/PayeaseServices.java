package org.ofbiz.accounting.thirdparty.payease;



import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.math.BigDecimal;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.jdom.xpath.XPath;
import org.ofbiz.accounting.payment.PaymentGatewayServices;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.ebiz.util.UtilHttpClient;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.order.order.OrderReadHelper;
import org.ofbiz.order.shoppingcart.ShoppingCart;
import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;
import org.xml.sax.InputSource;


public class PayeaseServices {

	private static final String URL_RefAckSubmit="https://api.yizhifubj.com/merchant/refund/ref_ack_submit.jsp";
	private static final String URL_RefAckOidList="https://api.yizhifubj.com/merchant/refund/ref_ack_oid_list_utf8.jsp";
	private static final String URL_RefAckDayList="https://api.yizhifubj.com/merchant/refund/ref_ack_day_list_utf8.jsp";
	
	private static final String URL_OrderAckOidList="https://api.yizhifubj.com/merchant/order/order_ack_oid_list.jsp";
	
	private final static String module = PayeaseServices.class.getName();
	public final static String resource = "AccountingErrorUiLabels";
	
	/*
	public static Map<String, Object> doRefund (DispatchContext dctx, Map<String, Object> context) {
		Delegator delegator = dctx.getDelegator();
        LocalDispatcher dispatcher = dctx.getDispatcher();
        GenericValue userLogin = (GenericValue) context.get("userLogin");
        Locale locale = (Locale) context.get("locale");
        GenericValue payeaseConfig = getPaymentMethodGatewayPayease(dctx, context, null);
        if (payeaseConfig == null) {
            return ServiceUtil.returnError(UtilProperties.getMessage(resource, 
                    "AccountingPayPalPaymentGatewayConfigCannotFind", locale));
        }
        GenericValue orderPaymentPreference = (GenericValue) context.get("orderPaymentPreference");
        GenericValue captureTrans = PaymentGatewayServices.getCaptureTransaction(orderPaymentPreference);
        BigDecimal refundAmount = (BigDecimal) context.get("refundAmount");
        Map encoder = FastMap.newInstance();
        encoder.put("METHOD", "RefundTransaction");
        encoder.put("TRANSACTIONID", captureTrans.getString("referenceNum"));
        encoder.put("REFUNDTYPE", "Partial");
        encoder.put("CURRENCYCODE", captureTrans.getString("currencyUomId"));
        encoder.put("AMT", refundAmount.setScale(2, BigDecimal.ROUND_HALF_UP).toPlainString());
        encoder.put("NOTE", "Order #" + orderPaymentPreference.getString("orderId"));
        Map decoder = null;
        try {
            decoder = dispatcher.runSync("", encoder);
        } catch (Exception e) {
            Debug.logError(e, module);
            return ServiceUtil.returnError(e.getMessage());
        }

        if (decoder == null) {
            return ServiceUtil.returnError(UtilProperties.getMessage(resource, 
                    "AccountingPayPalUnknownError", locale));
        }

        Map<String, Object> result = ServiceUtil.returnSuccess();

        if (ServiceUtil.isError(decoder) {
            result.put("refundResult", false);
            result.put("refundRefNum", captureTrans.getString("referenceNum"));
            result.put("refundAmount", BigDecimal.ZERO);
            if (errors.size() == 1) {
                Map.Entry<String, String> error = errors.entrySet().iterator().next();
                result.put("refundCode", error.getKey());
                result.put("refundMessage", error.getValue());
            } else {
                result.put("refundMessage", "Multiple errors occurred, please refer to the gateway response messages");
                result.put("internalRespMsgs", errors);
            }
        } else {
            result.put("refundResult", true);
            result.put("refundAmount", new BigDecimal(decoder.get("GROSSREFUNDAMT")));
            result.put("refundRefNum", decoder.get("REFUNDTRANSACTIONID"));
        }
        return result;
    }
	*/
	
	private static GenericValue getPaymentMethodGatewayPayease(DispatchContext dctx, Map<String, ? extends Object> context, String paymentServiceTypeEnumId) {
        Delegator delegator = dctx.getDelegator();
        String paymentGatewayConfigId = (String) context.get("paymentGatewayConfigId");
        GenericValue payeaseGatewayConfig = null;

        if (paymentGatewayConfigId == null) {
            String productStoreId = null;
            GenericValue orderPaymentPreference = (GenericValue) context.get("orderPaymentPreference");
            if (orderPaymentPreference != null) {
                productStoreId = UtilPayease.getProductStoreId(delegator, orderPaymentPreference.getString("orderId"));
            } else {
                productStoreId = UtilPayease.getProductStoreId(delegator, null);
            }
            if (productStoreId != null) {
                GenericValue payPalPaymentSetting = ProductStoreWorker.getProductStorePaymentSetting(delegator, productStoreId, "EXT_PAYEASE", paymentServiceTypeEnumId, true);
                if (payPalPaymentSetting != null) {
                    paymentGatewayConfigId = payPalPaymentSetting.getString("paymentGatewayConfigId");
                }
            }
        }
        if (paymentGatewayConfigId != null) {
            try {
                payeaseGatewayConfig = delegator.findOne("PaymentGatewayPayease", true, "paymentGatewayConfigId", paymentGatewayConfigId);
            } catch (GenericEntityException e) {
                Debug.logError(e, module);
            }
        }
        return payeaseGatewayConfig;
    }
	
	/**
	 * 提交退款申请
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> refundAckSubmit(DispatchContext dctx, Map<String, Object> context) {
		Delegator delegator = dctx.getDelegator();
        LocalDispatcher dispatcher = dctx.getDispatcher();
        String productStoreId = (String) context.get("productStoreId");
        
		String v_mid = (String)context.get("v_mid");
		String v_oid = (String)context.get("v_oid");
		String v_refamount = (String)context.get("v_refamount");
		String v_refreason = (String)context.get("v_refreason");
		String v_refoprt = (String)context.get("v_refoprt");
		String v_mac = (String)context.get("v_mac");
		
		// get the payment properties file
        GenericValue paymentConfig = ProductStoreWorker.getProductStorePaymentSetting(delegator, productStoreId, "EXT_PAYEASE", null, true);
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
		String refundOperator = UtilPayease.getPaymentGatewayConfigValue(delegator, paymentGatewayConfigId, "refundOperator", configString, "payment.payease.refundOperator");
		
		String md5Source = v_mid+v_oid+v_refamount+v_refoprt;
		v_mac = UtilPayease.md5(md5Source, apiSignature);
		
		Map<String,Object> params = FastMap.newInstance();
		params.put("v_mid", v_mid);
		params.put("v_oid", v_oid);
		params.put("v_refamount", v_refamount);
		params.put("v_refreason", v_refreason);
		params.put("v_refoprt", refundOperator);
		params.put("v_mac", v_mac);
		Map ret = UtilHttpClient.doPost(URL_RefAckSubmit, params, null);
		
		Map<String, Object> result = ServiceUtil.returnSuccess();
		result.putAll(ret);
		
		if(result.get("content")!=null){
			Map refmessage =FastMap.newInstance();
			SAXBuilder builder = new SAXBuilder();
			Document doc;
			try {
				//创建一个新的字符串
		        StringReader read = new StringReader((String)result.get("content"));
		        //创建新的输入源SAX 解析器将使用 InputSource 对象来确定如何读取 XML 输入
		        InputSource source = new InputSource(read);
				doc = builder.build(source);
				Element rootEl = doc.getRootElement();
				refmessage.put("status", rootEl.getChildText("status"));
				refmessage.put("statusdesc", rootEl.getChildText("statusdesc"));
				refmessage.put("mid", rootEl.getChildText("mid"));
				refmessage.put("oid", rootEl.getChildText("oid"));
				refmessage.put("refamount", rootEl.getChildText("refamount"));
				refmessage.put("refoprt", rootEl.getChildText("refoprt"));
				refmessage.put("refid", rootEl.getChildText("refid"));
				refmessage.put("sign", rootEl.getChildText("sign"));
			} catch (JDOMException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        result.put("refmessage", refmessage);
		}
        return result;
	}
	
	/**
	 * 退款订单查询
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> refundAckOidList(DispatchContext dctx, Map<String, Object> context) {
		
		Delegator delegator = dctx.getDelegator();
        LocalDispatcher dispatcher = dctx.getDispatcher();
        String productStoreId = (String) context.get("productStoreId");
        
		String v_mid = (String)context.get("v_mid");
		String v_oid = (String)context.get("v_oid");
		String v_version = (String)context.get("v_version");
		String v_mac = (String)context.get("v_mac");
		
		// get the payment properties file
        GenericValue paymentConfig = ProductStoreWorker.getProductStorePaymentSetting(delegator, productStoreId, "EXT_PAYEASE", null, true);
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
		
		String md5Source = v_mid+v_oid;
		v_mac = UtilPayease.md5(md5Source, apiSignature);
		
		Map<String,Object> params = FastMap.newInstance();
		params.put("v_mid", v_mid);
		params.put("v_oid", v_oid);
		params.put("v_mac", v_mac);
		params.put("v_version", v_version);
		Map ret = UtilHttpClient.doPost(URL_RefAckOidList, params, null);
		
		Map<String, Object> result = ServiceUtil.returnSuccess();
		result.putAll(ret);
		
		if(result.get("content")!=null){
			Map refmessage =FastMap.newInstance();
			SAXBuilder builder = new SAXBuilder();
			Document doc;
			try {
				//创建一个新的字符串
		        StringReader read = new StringReader((String)result.get("content"));
		        //创建新的输入源SAX 解析器将使用 InputSource 对象来确定如何读取 XML 输入
		        InputSource source = new InputSource(read);
				doc = builder.build(source);
				Element rootEl = doc.getRootElement();
				Element messagehead = rootEl.getChild("messagehead");
				refmessage.put("status", rootEl.getChildText("status"));
				refmessage.put("statusdesc", rootEl.getChildText("statusdesc"));
				refmessage.put("mid", rootEl.getChildText("mid"));
				refmessage.put("oid", rootEl.getChildText("oid"));
				refmessage.put("version", rootEl.getChildText("version"));
				refmessage.put("amount", rootEl.getChildText("amount"));
				refmessage.put("moneytype", rootEl.getChildText("moneytype"));
				
				Element elMessagebody = rootEl.getChild("messagebody");
				List<Element> list = elMessagebody.getChildren("refund");//返回的是List集合
				if(UtilValidate.isNotEmpty(list)){
					List<Map> refundList = FastList.newInstance();
					for (Element ele : list) {
						Map refundMap = FastMap.newInstance();
						refundMap.put("refundindex", ele.getChildText("refundindex"));
						refundMap.put("refid", ele.getChildText("refid"));
						refundMap.put("refamount", ele.getChildText("refamount"));
						refundMap.put("refmoneytype", ele.getChildText("refmoneytype"));
						refundMap.put("refdate", ele.getChildText("refdate"));
						refundMap.put("refstatus", ele.getChildText("refstatus"));
						refundMap.put("reftype", ele.getChildText("reftype"));
						refundMap.put("offline_ref_status", ele.getChildText("offline_ref_status"));
						refundMap.put("refreason", ele.getChildText("refreason"));
						refundMap.put("sign", ele.getChildText("sign"));
						refundList.add(refundMap);
		            }
					result.put("refundList", refundList);
				}
				
			} catch (JDOMException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        result.put("messagehead", refmessage);
		}
		
        return result;
	}
	
	/**
	 * 退款日期查询
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> refundAckDayList(DispatchContext dctx, Map<String, Object> context) {
		
		Delegator delegator = dctx.getDelegator();
        LocalDispatcher dispatcher = dctx.getDispatcher();
        String productStoreId = (String) context.get("productStoreId");
        
		String v_mid = (String)context.get("v_mid");
		String v_ymd = (String)context.get("v_ymd");
		String v_version = (String)context.get("v_version");
		String v_mac = (String)context.get("v_mac");
		
		// get the payment properties file
        GenericValue paymentConfig = ProductStoreWorker.getProductStorePaymentSetting(delegator, productStoreId, "EXT_PAYEASE", null, true);
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
		
		String md5Source = v_mid+v_ymd;
		v_mac = UtilPayease.md5(md5Source, apiSignature);
		
		Map<String,Object> params = FastMap.newInstance();
		params.put("v_mid", v_mid);
		params.put("v_ymd", v_ymd);
		params.put("v_mac", v_mac);
		params.put("v_version", v_version);
		Map ret = UtilHttpClient.doPost(URL_RefAckDayList, params, null);
		
		Map<String, Object> result = ServiceUtil.returnSuccess();
		result.putAll(ret);
		
		if(result.get("content")!=null){
			Map refmessage =FastMap.newInstance();
			SAXBuilder builder = new SAXBuilder();
			Document doc;
			try {
				//创建一个新的字符串
		        StringReader read = new StringReader((String)result.get("content"));
		        //创建新的输入源SAX 解析器将使用 InputSource 对象来确定如何读取 XML 输入
		        InputSource source = new InputSource(read);
				doc = builder.build(source);
				Element rootEl = doc.getRootElement();
				Element messagehead = rootEl.getChild("messagehead");
				refmessage.put("status", rootEl.getChildText("status"));
				refmessage.put("statusdesc", rootEl.getChildText("statusdesc"));
				refmessage.put("mid", rootEl.getChildText("mid"));
				refmessage.put("ymd", rootEl.getChildText("ymd"));
				refmessage.put("version", rootEl.getChildText("version"));
				
				Element elMessagebody = rootEl.getChild("messagebody");
				List<Element> list = elMessagebody.getChildren("refund");//返回的是List集合
				if(UtilValidate.isNotEmpty(list)){
					List<Map> refundList = FastList.newInstance();
					for (Element ele : list) {
						Map refundMap = FastMap.newInstance();
						refundMap.put("refundindex", ele.getChildText("refundindex"));
						refundMap.put("oid", ele.getChildText("oid"));
						refundMap.put("amount", ele.getChildText("amount"));
						refundMap.put("moneytype", ele.getChildText("moneytype"));
						refundMap.put("refid", ele.getChildText("refid"));
						refundMap.put("refamount", ele.getChildText("refamount"));
						refundMap.put("refmoneytype", ele.getChildText("refmoneytype"));
						refundMap.put("refdate", ele.getChildText("refdate"));
						refundMap.put("refstatus", ele.getChildText("refstatus"));
						refundMap.put("reftype", ele.getChildText("reftype"));
						refundMap.put("offline_ref_status", ele.getChildText("offline_ref_status"));
						refundMap.put("refreason", ele.getChildText("refreason"));
						refundMap.put("sign", ele.getChildText("sign"));
						refundList.add(refundMap);
		            }
					result.put("refundList", refundList);
				}
				
			} catch (JDOMException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        result.put("messagehead", refmessage);
		}
		
        return result;
	}
	
	/**
	 * 单笔订单查询
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> orderAckOidList(DispatchContext dctx, Map<String, Object> context) {
		
		Delegator delegator = dctx.getDelegator();
        LocalDispatcher dispatcher = dctx.getDispatcher();
        String productStoreId = (String) context.get("productStoreId");
        
		String v_mid = (String)context.get("v_mid");
		String v_oid = (String)context.get("v_oid");
		//String v_version = (String)context.get("v_version");
		String v_mac = (String)context.get("v_mac");
		
		// get the payment properties file
        GenericValue paymentConfig = ProductStoreWorker.getProductStorePaymentSetting(delegator, productStoreId, "EXT_PAYEASE", null, true);
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
		
		String md5Source = v_mid+v_oid;
		v_mac = UtilPayease.md5(md5Source, apiSignature);
		
		Map<String,Object> params = FastMap.newInstance();
		params.put("v_mid", v_mid);
		params.put("v_oid", v_oid);
		params.put("v_mac", v_mac);
		//params.put("v_version", v_version);
		Map ret = UtilHttpClient.doPost(URL_OrderAckOidList, params, null);
		
		Map<String, Object> result = ServiceUtil.returnSuccess();
		result.putAll(ret);
		
		if(result.get("content")!=null){
			Map messagehead =FastMap.newInstance();
			SAXBuilder builder = new SAXBuilder();
			Document doc;
			try {
				//创建一个新的字符串
		        StringReader read = new StringReader((String)result.get("content"));
		        //创建新的输入源SAX 解析器将使用 InputSource 对象来确定如何读取 XML 输入
		        InputSource source = new InputSource(read);
				doc = builder.build(source);
				Element rootEl = doc.getRootElement();
				Element elMessagehead = rootEl.getChild("messagehead");
				messagehead.put("status", elMessagehead.getChildText("status"));
				messagehead.put("statusdesc", elMessagehead.getChildText("statusdesc"));
				messagehead.put("mid", elMessagehead.getChildText("mid"));
				messagehead.put("oid", elMessagehead.getChildText("oid"));

				
				Element elMessagebody = rootEl.getChild("messagebody");
				List<Element> list = elMessagebody.getChildren("order");//返回的是List集合
				if(UtilValidate.isNotEmpty(list)){
					List<Map> orderList = FastList.newInstance();
					for (Element ele : list) {
						Map orderMap = FastMap.newInstance();
						orderMap.put("orderindex", ele.getChildText("orderindex"));
						orderMap.put("oid", ele.getChildText("oid"));
						orderMap.put("pmode", ele.getChildText("pmode"));
						orderMap.put("pstatus", ele.getChildText("pstatus"));
						orderMap.put("pstring", ele.getChildText("pstring"));
						orderMap.put("amount", ele.getChildText("amount"));
						orderMap.put("moneytype", ele.getChildText("moneytype"));
						orderMap.put("isvirement", ele.getChildText("isvirement"));
						orderMap.put("sign", ele.getChildText("sign"));
						orderList.add(orderMap);
		            }
					result.put("orderList", orderList);
				}
				
			} catch (JDOMException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        result.put("messagehead", messagehead);
		}
		
        return result;
	}
}
