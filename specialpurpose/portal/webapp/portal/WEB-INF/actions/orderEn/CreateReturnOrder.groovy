import java.util.Map;

import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.service.ModelService;

import java.math.BigDecimal;
import java.util.Map;

import javolution.util.FastMap;

import org.ofbiz.base.util.*;
import org.ofbiz.entity.transaction.GenericTransactionException;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.service.ServiceUtil;

module = "CreateReturnOrder.groovy";

boolean beganTransaction = false;
try {
	beganTransaction = TransactionUtil.begin();
	Map paramMap = UtilHttp.getParameterMap(request);
	returnHeaderTypeId = "CUSTOMER_RETURN";
	if (paramMap.containsKey("returnHeaderTypeId")) {
		returnHeaderTypeId = (String) paramMap.remove("returnHeaderTypeId");
	}
	returnTypeId = "RTN_REFUND";
	if (paramMap.containsKey("returnTypeId")) {
		returnTypeId = (String) paramMap.remove("returnTypeId");
	}
	currencyUomId = "CNY";
	if (paramMap.containsKey("currencyUomId")) {
		currencyUomId = (String) paramMap.remove("currencyUomId");
	}
	fromPartyId = "";
	if (paramMap.containsKey("fromPartyId")) {
		fromPartyId = (String) paramMap.remove("fromPartyId");
	}
	toPartyId = "";
	if (paramMap.containsKey("toPartyId")) {
		toPartyId = (String) paramMap.remove("toPartyId");
	}
	originContactMechId = null;
	if (paramMap.containsKey("originContactMechId")) {
		originContactMechId = (String) paramMap.remove("originContactMechId");
	}
	Map<String, Object> rhCtx = UtilMisc.toMap("returnHeaderTypeId", returnHeaderTypeId, "returnTypeId",  returnTypeId, "currencyUomId",  currencyUomId, "fromPartyId",  fromPartyId, "toPartyId", toPartyId, "userLogin", userLogin);
	if(UtilValidate.isNotEmpty(originContactMechId)){
		rhCtx.put("originContactMechId", originContactMechId);
	}
	Map<String, Object> rhResp = dispatcher.runSync("createReturnHeader", rhCtx);
	String returnId = (String) rhResp.get("returnId");
	rowCount = UtilHttp.getMultiFormRowCount(request);
	for (int i=0; i < rowCount; i++) {
		String thisSuffix = UtilHttp.MULTI_ROW_DELIMITER + i; 
		orderId = "";
		if (paramMap.containsKey("orderId" + thisSuffix)) {
			orderId = (String) paramMap.remove("orderId" + thisSuffix);
		}
		productId = "";
		if (paramMap.containsKey("productId" + thisSuffix)) {
			productId = (String) paramMap.remove("productId" + thisSuffix);
		}
		description = "";
		if (paramMap.containsKey("description" + thisSuffix)) {
			description = (String) paramMap.remove("description" + thisSuffix);
		}
		returnReasonId = "";
		if (paramMap.containsKey("returnReasonId" + thisSuffix)) {
			returnReasonId = (String) paramMap.remove("returnReasonId" + thisSuffix);
		}
		orderItemSeqId = "";
		if (paramMap.containsKey("orderItemSeqId" + thisSuffix)) {
			orderItemSeqId = (String) paramMap.remove("orderItemSeqId" + thisSuffix);
		}
		returnPriceStr = null;
		if (paramMap.containsKey("returnPrice" + thisSuffix)) {
			returnPriceStr = (String) paramMap.remove("returnPrice" + thisSuffix);
		}
		if ((returnPriceStr == null) || (returnPriceStr.equals(""))) {    // otherwise, every empty value causes an exception and makes the log ugly
			returnPriceStr = "0";  // default quantity is 0, so without a quantity input, this field will not be added
		}
		
		// parse the returnPrice
		returnPrice = BigDecimal.ZERO;
		try {
			returnPrice = new BigDecimal(returnPriceStr);
		} catch (Exception e) {
			Debug.logWarning(e, "Problems parsing returnPrice string: " + returnPriceStr, module);
			returnPrice = BigDecimal.ZERO;
		}
		returnQuantity = BigDecimal.ZERO;
		quantityStr = null;
		if (paramMap.containsKey("returnQuantity" + thisSuffix)) {
			quantityStr = (String) paramMap.remove("returnQuantity" + thisSuffix);
		}
		if ((quantityStr == null) || (quantityStr.equals(""))) {    // otherwise, every empty value causes an exception and makes the log ugly
			quantityStr = "0";  // default quantity is 0, so without a quantity input, this field will not be added
		}
		
		// parse the quantity
		try {
			returnQuantity = new BigDecimal(quantityStr);
		} catch (Exception e) {
			Debug.logWarning(e, "Problems parsing quantity string: " + quantityStr, module);
			returnQuantity = BigDecimal.ZERO;
		}
		
		returnItemTypeId = null;
		if (paramMap.containsKey("returnItemTypeId" + thisSuffix)) {
			returnItemTypeId = (String) paramMap.remove("returnItemTypeId" + thisSuffix);
		}
		comments = null;
		if (paramMap.containsKey("comments" + thisSuffix)) {
			comments = (String) paramMap.remove("comments" + thisSuffix);
		}
		
		Map<String, Object> returnItemCtx = FastMap.newInstance();
		returnItemCtx.put("returnId", returnId);
		returnItemCtx.put("orderId", orderId);
		returnItemCtx.put("productId", productId);
		returnItemCtx.put("description", description);
		returnItemCtx.put("comments", comments);
		returnItemCtx.put("returnReasonId", returnReasonId);
		returnItemCtx.put("orderItemSeqId", orderItemSeqId);
		returnItemCtx.put("returnQuantity", returnQuantity);
		returnItemCtx.put("returnPrice", returnPrice);
		returnItemCtx.put("returnTypeId", returnTypeId); // refund return
		returnItemCtx.put("returnItemTypeId", returnItemTypeId);
		returnItemCtx.put("userLogin", userLogin);
		
		Map<String, Object> retItResp = dispatcher.runSync("createReturnItem", returnItemCtx);
		if (ServiceUtil.isError(retItResp)) {
			throw new GeneralException(ServiceUtil.getErrorMessage(retItResp));
		}
	}
	Map<String, Object> appRet = UtilMisc.toMap("statusId", "RETURN_ACCEPTED", "returnId", returnId, "userLogin", userLogin);
	Map<String, Object> appResp = dispatcher.runSync("updateReturnHeader", appRet);
	if (ServiceUtil.isError(appResp)) {
		throw new GeneralException(ServiceUtil.getErrorMessage(appResp));
	}
			
} catch (Exception e) {
	try {
        // only rollback the transaction if we started one...
        TransactionUtil.rollback(beganTransaction, "Error looking up entity values in WebTools Entity Data Maintenance", e);
    } catch (GenericEntityException e2) {
        Debug.logError(e2, "Could not rollback transaction: " + e2.toString(), module);
    }
	Debug.logError(e.getMessage(), module);
	request.setAttribute("_ERROR_MESSAGE_",e.getMessage());
	return ModelService.RESPOND_ERROR;
}
finally {
    // only commit the transaction if we started one... this will throw an exception if it fails
	try {
        TransactionUtil.commit(beganTransaction);
    } catch (GenericEntityException e2) {
        Debug.logError(e2, "Could not commit transaction: " + e2.toString(), module);
        return ModelService.RESPOND_ERROR;
    }
}
return ModelService.RESPOND_SUCCESS;
