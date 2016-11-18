package org.ofbiz.accounting.invoice;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.apache.commons.collections.CollectionUtils;
import org.ofbiz.accounting.invoice.InvoiceWorker;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilGenerics;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilNumber;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;

public class EbizInvoiceServices{
	
	public static String module = EbizInvoiceServices.class.getName();

    // set some BigDecimal properties
    private static final BigDecimal ZERO = BigDecimal.ZERO;
    private static final int DECIMALS = UtilNumber.getBigDecimalScale("invoice.decimals");
    private static final int ROUNDING = UtilNumber.getBigDecimalRoundingMode("invoice.rounding");
    private static final int TAX_DECIMALS = UtilNumber.getBigDecimalScale("salestax.calc.decimals");
    private static final int TAX_ROUNDING = UtilNumber.getBigDecimalRoundingMode("salestax.rounding");
    public static final int TAX_CALC_SCALE = UtilNumber.getBigDecimalScale("salestax.calc.decimals");
    private static final int INVOICE_ITEM_SEQUENCE_ID_DIGITS = 5; // this is the number of digits used for invoiceItemSeqId: 00001, 00002...

    public static final String resource = "AccountingUiLabels";
	
	// Service for creating commission invoices
    public static Map<String, Object> createCommissionInvoices(DispatchContext dctx, Map<String, Object> context) {
        Delegator delegator = dctx.getDelegator();
        LocalDispatcher dispatcher = dctx.getDispatcher();
        GenericValue userLogin = (GenericValue) context.get("userLogin");
        Locale locale = (Locale) context.get("locale");
        List<String> salesInvoiceIds = UtilGenerics.checkList(context.get("invoiceIds"));
        List<String> salesRepPartyIds = UtilGenerics.checkList(context.get("partyIds"));
        String invoiceItemTypeId = (String)context.get("invoiceItemTypeId");
        
        List<Map<String, String>> invoicesCreated = FastList.newInstance();
        Map<String, List<Map<String, Object>>> commissionParties = FastMap.newInstance();
        for (String salesInvoiceId : salesInvoiceIds) {
            
            BigDecimal amountTotal =  InvoiceWorker.getInvoiceTotal(delegator, salesInvoiceId);
            if (amountTotal.signum() == 0) {
                Debug.logWarning("Invoice [" + salesInvoiceId + "] has an amount total of [" + amountTotal + "], so no commission invoice will be created", module);
                return ServiceUtil.returnError(UtilProperties.getMessage(resource,
                        "AccountingInvoiceCommissionZeroInvoiceAmount", locale));
            }
            BigDecimal appliedFraction = amountTotal.divide(amountTotal, 12, ROUNDING);
            GenericValue invoice = null;
            boolean isReturn = false;
            List<String> billFromVendorInvoiceRoles = new ArrayList<String>();
            String partyIdFrom ="Company";
            //List<GenericValue> invoiceItems = new ArrayList<GenericValue>();
            try {
                List<EntityExpr> invoiceRoleConds = UtilMisc.toList(
                        EntityCondition.makeCondition("invoiceId", EntityOperator.EQUALS, salesInvoiceId),
                        EntityCondition.makeCondition("roleTypeId", EntityOperator.EQUALS, "BILL_FROM_VENDOR"));
                billFromVendorInvoiceRoles = EntityUtil.getFieldListFromEntityList(delegator.findList("InvoiceRole", EntityCondition.makeCondition(invoiceRoleConds, EntityOperator.AND), null, null, null, false), "partyId", true);
                if(UtilValidate.isNotEmpty(billFromVendorInvoiceRoles)){
                	partyIdFrom = billFromVendorInvoiceRoles.get(0);
                }
                invoiceRoleConds = UtilMisc.toList(
                        EntityCondition.makeCondition("invoiceId", EntityOperator.EQUALS, salesInvoiceId),
                        EntityCondition.makeCondition("roleTypeId", EntityOperator.EQUALS, "SALES_REP"));
                // if the receiving parties is empty then we will create commission invoices for all sales agent associated to sales invoice.
                if (UtilValidate.isEmpty(salesRepPartyIds)) {
                    salesRepPartyIds = EntityUtil.getFieldListFromEntityList(delegator.findList("InvoiceRole", EntityCondition.makeCondition(invoiceRoleConds, EntityOperator.AND), null, null, null, false), "partyId", true);
                    if (UtilValidate.isEmpty(salesRepPartyIds)) {
                        return ServiceUtil.returnError(UtilProperties.getMessage(resource,
                        "No party found with role sales representative for sales invoice "+ salesInvoiceId, locale));
                    }
                } else {
                    List<String> salesInvoiceRolePartyIds = EntityUtil.getFieldListFromEntityList(delegator.findList("InvoiceRole", EntityCondition.makeCondition(invoiceRoleConds, EntityOperator.AND), null, null, null, false), "partyId", true);
                    if (UtilValidate.isNotEmpty(salesInvoiceRolePartyIds)) {
                        salesRepPartyIds = UtilGenerics.checkList(CollectionUtils.intersection(salesRepPartyIds, salesInvoiceRolePartyIds));
                    }
                }
                invoice = delegator.findOne("Invoice", UtilMisc.toMap("invoiceId", salesInvoiceId), false);
                String invoiceTypeId = invoice.getString("invoiceTypeId");
                if ("CUST_RTN_INVOICE".equals(invoiceTypeId)) {
                    isReturn = true;
                } else if (!"SALES_INVOICE".equals(invoiceTypeId)) {
                    Debug.logWarning("This type of invoice has no commission; returning success", module);
                    return ServiceUtil.returnError(UtilProperties.getMessage(resource,
                            "AccountingInvoiceCommissionInvalid", locale));
                }
                //invoiceItems = delegator.findList("InvoiceItem", EntityCondition.makeCondition("invoiceId", EntityOperator.EQUALS, salesInvoiceId), null, null, null, false);
            } catch (GenericEntityException e) {
                return ServiceUtil.returnError(e.getMessage());
            }
            
            
            
            // Map of commission Lists (of Maps) for each party.
            // Determine commissions for various parties.
            for (String salesRepPartyId : salesRepPartyIds) {
                BigDecimal amount = amountTotal;
                BigDecimal quantity = ZERO;

                    Map<String, Object> resultMap = null;
                    try {
                        resultMap = dispatcher.runSync("getCommissionForParty", UtilMisc.<String, Object>toMap(
                        		"partyIdFrom",partyIdFrom,
                                "partyIdTo", salesRepPartyId,
                                "invoiceId", salesInvoiceId,
                                "invoiceItemTypeId", invoiceItemTypeId,
                                "amount", amount,
                                "quantity", quantity,
                                "userLogin", userLogin));
                    } catch (GenericServiceException e) {
                        return ServiceUtil.returnError(e.getMessage());
                    }
                    // build a Map of partyIds (both to and from) in a commission and the amounts
                    // Note that getCommissionForProduct returns a List of Maps with a lot values.  See services.xml definition for reference.
                    List<Map<String, Object>> itemCommissions = UtilGenerics.checkList(resultMap.get("commissions"));
                    if (UtilValidate.isNotEmpty(itemCommissions)) {
                        for (Map<String, Object> commissionMap : itemCommissions) {
                            commissionMap.put("invoice", invoice);
                            commissionMap.put("appliedFraction", appliedFraction);
                            if (!billFromVendorInvoiceRoles.contains(commissionMap.get("partyIdFrom")) || !salesRepPartyIds.contains(commissionMap.get("partyIdTo"))) {
                                continue;
                            }
                            String partyIdFromTo = (String) commissionMap.get("partyIdFrom") + (String) commissionMap.get("partyIdTo");
                            if (!commissionParties.containsKey(partyIdFromTo)) {
                                commissionParties.put(partyIdFromTo, UtilMisc.toList(commissionMap));
                            } else {
                                (commissionParties.get(partyIdFromTo)).add(commissionMap);
                            }
                        }
                    }
            }
        }
        
        Timestamp now = UtilDateTime.nowTimestamp();
        // Create invoice for each commission receiving party
        for (Map.Entry<String, List<Map<String, Object>>> commissionParty : commissionParties.entrySet()) {
            List<GenericValue> toStore = FastList.newInstance();
            List<Map<String, Object>> commList = commissionParty.getValue();
            // get the billing parties
            if (UtilValidate.isEmpty(commList)) {
                continue;
            }
            // From and To are reversed between commission and invoice
            String partyIdBillTo = (String) (commList.get(0)).get("partyIdFrom");
            String partyIdBillFrom = (String) (commList.get(0)).get("partyIdTo");
            GenericValue invoice = (GenericValue) (commList.get(0)).get("invoice");
            BigDecimal appliedFraction = (BigDecimal) (commList.get(0)).get("appliedFraction");
            Long days = (Long) (commList.get(0)).get("days");
            // create the invoice record
            // To and From are in commission's sense, opposite for invoice
            Map<String, Object> createInvoiceMap = FastMap.newInstance();
            createInvoiceMap.put("partyId", partyIdBillTo);
            createInvoiceMap.put("partyIdFrom", partyIdBillFrom);
            createInvoiceMap.put("invoiceDate", now);
            // if there were days associated with the commission agreement, then set a dueDate for the invoice.
            if (days != null) {
                createInvoiceMap.put("dueDate", UtilDateTime.getDayEnd(now, days));
            }
            createInvoiceMap.put("invoiceTypeId", "COMMISSION_INVOICE");
            // start with INVOICE_IN_PROCESS, in the INVOICE_READY we can't change the invoice (or shouldn't be able to...)
            createInvoiceMap.put("statusId", "INVOICE_IN_PROCESS");
            createInvoiceMap.put("currencyUomId", invoice.getString("currencyUomId"));
            createInvoiceMap.put("userLogin", userLogin);
            // store the invoice first
            Map<String, Object> createInvoiceResult = null;
            try {
                createInvoiceResult = dispatcher.runSync("createInvoice", createInvoiceMap);
            } catch (GenericServiceException e) {
                return ServiceUtil.returnError(UtilProperties.getMessage(resource,
                        "AccountingInvoiceCommissionError", locale), null, null, createInvoiceResult);
            }
            String invoiceId = (String) createInvoiceResult.get("invoiceId");
            // create the bill-from (or pay-to) contact mech as the primary PAYMENT_LOCATION of the party from the store
            List<EntityExpr> partyContactMechPurposeConds = UtilMisc.toList(
                    EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, partyIdBillTo),
                    EntityCondition.makeCondition("contactMechPurposeTypeId", EntityOperator.EQUALS, "BILLING_LOCATION"));
            List<GenericValue> partyContactMechPurposes = new ArrayList<GenericValue>();
            try {
                partyContactMechPurposes = delegator.findList("PartyContactMechPurpose",
                        EntityCondition.makeCondition(partyContactMechPurposeConds, EntityOperator.AND), null, null, null, false);
            } catch (GenericEntityException e) {
                return ServiceUtil.returnError(e.getMessage());
            }
            if (partyContactMechPurposes.size() > 0) {
                GenericValue address = partyContactMechPurposes.get(0);
                GenericValue invoiceContactMech = delegator.makeValue("InvoiceContactMech", UtilMisc.toMap(
                        "invoiceId", invoiceId,
                        "contactMechId", address.getString("contactMechId"),
                        "contactMechPurposeTypeId", "BILLING_LOCATION"));
                toStore.add(invoiceContactMech);
            }
            partyContactMechPurposeConds = UtilMisc.toList(
                    EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, partyIdBillTo),
                    EntityCondition.makeCondition("contactMechPurposeTypeId", EntityOperator.EQUALS, "PAYMENT_LOCATION"));
            try {
                partyContactMechPurposes = delegator.findList("PartyContactMechPurpose",
                        EntityCondition.makeCondition(partyContactMechPurposeConds, EntityOperator.AND), null, null, null, false);
            } catch (GenericEntityException e) {
                return ServiceUtil.returnError(e.getMessage());
            }
            if (partyContactMechPurposes.size() > 0) {
                GenericValue address = partyContactMechPurposes.get(0);
                GenericValue invoiceContactMech = delegator.makeValue("InvoiceContactMech", UtilMisc.toMap(
                        "invoiceId", invoiceId,
                        "contactMechId", address.getString("contactMechId"),
                        "contactMechPurposeTypeId", "PAYMENT_LOCATION"));
                toStore.add(invoiceContactMech);
            }
            // create the item records
            for (Map<String, Object> commissionMap : commList) {
                BigDecimal elemAmount = ((BigDecimal)commissionMap.get("commission")).multiply(appliedFraction);
                BigDecimal quantity = (BigDecimal)commissionMap.get("quantity");
                String invoiceIdFrom = (String)commissionMap.get("invoiceId");
                String invoiceItemSeqIdFrom = (String)commissionMap.get("invoiceItemSeqId");
                elemAmount = elemAmount.setScale(DECIMALS, ROUNDING);
                Map<String, Object> resMap = null;
                try {
                    resMap = dispatcher.runSync("createInvoiceItem", UtilMisc.toMap("invoiceId", invoiceId,
                            "productId", commissionMap.get("productId"),
                            "invoiceItemTypeId", "COMM_INV_ITEM",
                            "quantity",quantity,
                            "amount", elemAmount,
                            "userLogin", userLogin));
                    dispatcher.runSync("createInvoiceItemAssoc", UtilMisc.toMap("invoiceIdFrom", invoiceIdFrom,
                            "invoiceItemSeqIdFrom", invoiceItemSeqIdFrom,
                            "invoiceIdTo", invoiceId,
                            "invoiceItemSeqIdTo", resMap.get("invoiceItemSeqId"),
                            "invoiceItemAssocTypeId", "COMMISSION_INVOICE",
                            "partyIdFrom", partyIdBillFrom,
                            "partyIdTo", partyIdBillTo,
                            "quantity", quantity,
                            "amount", elemAmount,
                            "userLogin", userLogin));
                } catch (GenericServiceException e) {
                    return ServiceUtil.returnError(e.getMessage());
                }
                if (ServiceUtil.isError(resMap)) {
                    return ServiceUtil.returnError(UtilProperties.getMessage(resource,
                            "AccountingInvoiceCommissionErrorItem", locale), null, null, resMap);
                }
            }
            // store value objects
            try {
                delegator.storeAll(toStore);
            } catch (GenericEntityException e) {
                Debug.logError(e, "Entity/data problem creating commission invoice: " + e.toString(), module);
                return ServiceUtil.returnError(UtilProperties.getMessage(resource,
                        "AccountingInvoiceCommissionEntityDataProblem",
                        UtilMisc.toMap("reason", e.toString()), locale));
            }
            invoicesCreated.add(UtilMisc.<String, String>toMap("commissionInvoiceId",invoiceId, "salesRepresentative ",partyIdBillFrom));
        }
        String invCreated = new Integer(invoicesCreated.size()).toString();
        Map<String, Object> result = ServiceUtil.returnSuccess(UtilProperties.getMessage(resource, 
                "AccountingCommissionInvoicesCreated", 
                UtilMisc.toMap("invoicesCreated", invCreated), locale));
        Debug.logInfo("Created Commission invoices for each commission receiving parties " + 
                invCreated, module);
        result.put("invoicesCreated", invoicesCreated);
        return result;
    }
}