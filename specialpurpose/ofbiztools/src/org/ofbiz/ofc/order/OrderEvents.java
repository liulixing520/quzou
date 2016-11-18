package org.ofbiz.ofc.order;

import javolution.util.FastMap;

import org.ofbiz.base.util.*;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.ofc.tools.CommonUtils;
import org.ofbiz.order.order.OrderReadHelper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

/**
 * Created by apple on 14-12-10.
 */
public class OrderEvents {
    public static String module = CommonUtils.class.getName();
    public static final String resource = "YtCmUiLabels";

    /**
     * 获取 订单合同填充数据
     * @param request
     * @param orderId
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> getOrderAgreementData(HttpServletRequest request, String orderId) throws GenericEntityException {
        Map<String, Object> paddingMap = FastMap.newInstance();
        Delegator delegator = (Delegator) request.getAttribute("delegator");
        Locale locale = UtilHttp.getLocale(request);
        TimeZone timeZone = UtilHttp.getTimeZone(request);

        GenericValue order = delegator.findByPrimaryKey("OrderHeader", UtilMisc.toMap("orderId", orderId));
        OrderReadHelper orderReadHelper = new OrderReadHelper(order);

        GenericValue orderFromParty = orderReadHelper.getPartyFromRole("SHIP_TO_CUSTOMER");
        String fromUserName = "　　";
        if(UtilValidate.isNotEmpty(orderFromParty.get("firstName")) && UtilValidate.isNotEmpty(orderFromParty.get("lastName")) ){
            fromUserName = orderFromParty.getString("lastName") +" "+orderFromParty.getString("firstName");
        }
        paddingMap.put("fromUserName",fromUserName);//甲方名称, 客户

        GenericValue orderToParty = orderReadHelper.getPartyFromRole("BILL_FROM_VENDOR");
        String toUserName = "　　";
        if(UtilValidate.isNotEmpty(orderToParty.get("groupName"))){
            toUserName = orderToParty.getString("groupName");
        }
        paddingMap.put("toUserName",toUserName);//乙方名称, 供应商

        Timestamp orderDate = order.getTimestamp("orderDate");
        String orderDateStr = CommonUtils.DATE_FORMAT.format(orderDate);
        int orderDateYear = UtilDateTime.getYear(orderDate, timeZone, locale);
        int orderDateMonth = UtilDateTime.getMonth(orderDate, timeZone, locale)+1;
        int orderDateDay = UtilDateTime.getDayOfMonth(orderDate, timeZone, locale);
        paddingMap.put("orderDate",orderDateStr);//合同签订日期: 年    月   日
        paddingMap.put("orderDateYear",""+orderDateYear);//合同签订日期: 年
        paddingMap.put("orderDateMonth",""+orderDateMonth);//合同签订日期: 月
        paddingMap.put("orderDateDay",""+orderDateDay);//合同签订日期: 日

        String orderName = "　　";
        if(UtilValidate.isNotEmpty(order.get("orderName"))){
            orderName = order.getString("orderName");
        }
        paddingMap.put("orderName",orderName);//订单名称

        double grandTotal = 0;
        if(UtilValidate.isNotEmpty(order.get("grandTotal"))){
            grandTotal = order.getDouble("grandTotal");
        }
        paddingMap.put("grandTotal", CommonUtils.AMOUNT_FORMAT.format(grandTotal));//订单总金额
        paddingMap.put("grandTotalCn", CommonUtils.changeToBig(grandTotal));//订单总金额-大写

        paddingMap.put("advanceDays","　　");//预付款时限-天
        paddingMap.put("advancePercent","　　");//预付款百分比
        paddingMap.put("advanceAmount","　　");//预付金额
        paddingMap.put("advanceAmountCn","　　");//预付金额-大写

        paddingMap.put("receiveDays","　　");//开发票的验收时限-天
        paddingMap.put("invoiceDays","　　");//接收发票时限-天


        double remainingSubTotal = grandTotal;
        if(UtilValidate.isNotEmpty(order.get("remainingSubTotal"))){
            remainingSubTotal = order.getDouble("remainingSubTotal");
        }
        String surplusPercent = CommonUtils.getPercent(grandTotal, remainingSubTotal);
        surplusPercent = surplusPercent.substring(0, surplusPercent.length() - 1);
        paddingMap.put("surplusPercent",surplusPercent);//合同余款百分比
        paddingMap.put("surplusAmount", CommonUtils.AMOUNT_FORMAT.format(remainingSubTotal));//合同余款
        paddingMap.put("surplusAmountCn", CommonUtils.changeToBig(remainingSubTotal));//合同余款-大写

        paddingMap.put("toBankName","　　");//开户行名称
        paddingMap.put("toAccountName","　　");//户名
        paddingMap.put("toAccountNumber","　　");//账号

        paddingMap.put("deliveryDays","　　");//交货期限-天
        paddingMap.put("deliveryEndDateYear","　　");//交货期限-年
        paddingMap.put("deliveryEndDateMonth","　　");//交货期限-月
        paddingMap.put("deliveryEndDateDay","　　");//交货期限-日

        String deliveryDate = "　　";
        if(UtilValidate.isNotEmpty(order.get("pickSheetPrintedDate"))){
            deliveryDate = CommonUtils.DATE_FORMAT.format(order.getTimestamp("pickSheetPrintedDate"));
        }
        paddingMap.put("deliveryDate",deliveryDate);//交货日期

        GenericValue shippingAddress = EntityUtil.getFirst(orderReadHelper.getShippingLocations());
        Map<String, Object> stringMap = CommonUtils.getPostalAddressString(delegator, shippingAddress, locale, false);
        paddingMap.put("receiveAddress", stringMap.get("fullAddress"));//到货地点和接货单位(或接货人)

        paddingMap.put("shipmentAmounted","　　");//运费承担方: 甲 乙
        paddingMap.put("checkAcceptDays","　　");//验收时限-天
        paddingMap.put("agreementTotalPart","　　");//合同总份数
        paddingMap.put("agreementSharePart","　　");//双方各持份数

        return paddingMap;
    }

    /**
     * 订单合同导出.doc
     * @param request
     * @param response
     * @return
     */
    public static String exportOrderAgreementToDoc(HttpServletRequest request, HttpServletResponse response) {
        Delegator delegator = (Delegator) request.getAttribute("delegator");

        String orderId = request.getParameter("orderId");
        String content = "";
        String fileName = "订单合同["+orderId+"]["+UtilDateTime.nowDateString()+"].doc";

        try {
            Map<String, Object> dataMap = getOrderAgreementData(request,orderId);

            GenericValue templateGv = delegator.findOne("ElectronicText", UtilMisc.toMap("dataResourceId","OfcAgreeTemplBAS"),true);
            if(UtilValidate.isNotEmpty(templateGv.get("textData"))){
                content = templateGv.getString("textData");
            }
            if(UtilValidate.isEmpty(content)){
                response.setContentType("text/html;charset=GBK");
                response.getWriter().print("指定数据导出文件失败, 请稍后重试！");
                return "error";
            }

            //替换
            String replaceKeyBegin = "\\$\\{\\(paddingMap\\.";
            String replaceKeyEnd = "\\)\\!\\}";
            for (String key: dataMap.keySet()){
                String replaceKey = replaceKeyBegin + key + replaceKeyEnd;
                content = content.replaceAll(replaceKey, dataMap.get(key).toString());
            }

            CommonUtils.exportDataToDoc(request, response, content, fileName);
        } catch (GenericEntityException e) {
            Debug.logError(e, e.getMessage(), module);
        } catch (IOException e) {
            Debug.logError(e, e.getMessage(), module);
        }
        return "success";
    }
    
    /**
     * 计算 信用值, 卖家评价买家
     * <br/>　　
     * <br/>　　
     * @param grandTotal
     * @param totalAppraise
     * @param paymentAppraise
     * @return
     */
    public static Long calcCreditValueForCustomer(BigDecimal grandTotal, 
    		BigDecimal totalAppraise, BigDecimal paymentAppraise){
    	//订单总金额, 总体评价, 付款速度
    	long value = 0;
    	
    	if(UtilValidate.isEmpty(totalAppraise) || UtilValidate.isEmpty(paymentAppraise)) return value;
    	
		/*
		        计算方式为：采购总价*（总体评价*50% + 付款速度*50%）(若三者皆为差评，则积分为0)
		if(x==-1 && y==-1 && z==-1) a=0
		else a =订单总价*(x*0.5 + y*0.5)*/   
    	
    	//if(x==-1 && y==-1 && z==-1) a=0
    	if(totalAppraise.longValue()==-1 && paymentAppraise.longValue()==-1){
    		return value;
    	}
    	//if(x==0 && y==0 && z==0) a=0
    	else if(totalAppraise.longValue()==0 && paymentAppraise.longValue()==0){
    		return value;
    	}
    	else{
    		value = grandTotal.multiply(
    				 totalAppraise.multiply(new BigDecimal(50).divide(new BigDecimal(100)))
    				.add(paymentAppraise.multiply(new BigDecimal(50).divide(new BigDecimal(100))))
    		).longValue();
    	}
    	
    	return value;
    }
    
    /**
     * 计算 信用值, 买家评价卖家
     * <br/>　　
     * <br/>　　
     * @param grandTotal
     * @param totalAppraise
     * @param productAppraise
     * @param shipAppraise
     * @return
     */
    public static Long calcCreditValueForSupplier(BigDecimal grandTotal, 
    		BigDecimal totalAppraise, BigDecimal productAppraise, BigDecimal shipAppraise){
    	//订单总金额, 总体评价, 产品质量, 发货速度
    	long value = 0;

    	if(UtilValidate.isEmpty(totalAppraise) || UtilValidate.isEmpty(productAppraise) || UtilValidate.isEmpty(shipAppraise)) return value;
		/*
		        计算方式为：采购总价*（总体评价*50% + 产品质量*%30 + 发货速度*20%）(若三者皆为差评，则积分为0)
		if(x==-1 && y==-1 && z==-1) a=0
		else a =订单总价*(x*0.5 + y*0.3 + z*0.2)*/   
    	
    	//if(x==-1 && y==-1 && z==-1) a=0
    	if(totalAppraise.longValue()==-1 && productAppraise.longValue()==-1 && shipAppraise.longValue()==-1){
    		return value;
    	}
    	//if(x==0 && y==0 && z==0) a=0
    	else if(totalAppraise.longValue()==0 && productAppraise.longValue()==0 && shipAppraise.longValue()==0){
    		return value;
    	}
    	else{
    		value = grandTotal.multiply(
    				 totalAppraise.multiply(new BigDecimal(50).divide(new BigDecimal(100)))
    				.add(productAppraise.multiply(new BigDecimal(30).divide(new BigDecimal(100))))
    				.add(shipAppraise.multiply(new BigDecimal(20).divide(new BigDecimal(100))))
    		).longValue();
    	}
    	return value;
    }
 
    
    public static void main(String[] args){
    	System.out.println(CommonUtils.changeToBig(0.02));;
    }
    
}
