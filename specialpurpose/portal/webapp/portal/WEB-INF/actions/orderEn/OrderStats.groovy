/*
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
 */

import java.math.BigDecimal;
import java.util.*;
import java.sql.Timestamp;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.*;
import org.ofbiz.base.util.*;

BigDecimal calcItemTotal(List headers) {
    BigDecimal total = BigDecimal.ZERO;
    headers.each { header ->
        total = total.plus(header.grandTotal ?: BigDecimal.ZERO);
    }
    return total;
}
BigDecimal calcItemShippingTotal(List headers) {
	BigDecimal total = BigDecimal.ZERO;
	headers.each { header ->
		adjustments = header.getRelated("OrderAdjustment");
		shippingAdjustments = EntityUtil.filterByAnd(adjustments, [orderAdjustmentTypeId : "SHIPPING_CHARGES"]);
		GenericEntity shippingAdjustment = null;
		if (shippingAdjustments.size() > 0) {
			shippingAdjustment = EntityUtil.getFirst(shippingAdjustments);
		}
		if(shippingAdjustment)
			total = total.plus(shippingAdjustment.amount ?: BigDecimal.ZERO);
	}
	return total;
}

//start
nowYear = UtilDateTime.getYear(UtilDateTime.nowTimestamp(), timeZone, locale);
context.nowYear = nowYear;
nowMonth = UtilDateTime.getMonth(UtilDateTime.nowTimestamp(), timeZone, locale) + 1;
context.nowMonth = nowMonth;
productStoreId = (String)parameters.get("productStoreId");
yearStr = (String)parameters.get("year");
if(yearStr){
	int year = Integer.parseInt(yearStr);
	context.year = year;
	def yearResultList = FastList.newInstance();
	for(int currentMonth = 1; currentMonth <= 12; currentMonth++){
		monthCal = Calendar.getInstance();
		monthCal.set(Calendar.YEAR, year);
		monthCal.set(Calendar.MONTH, currentMonth-1);
		monthCal.set(Calendar.DAY_OF_MONTH, monthCal.getActualMinimum(Calendar.DAY_OF_MONTH));
		monthCal.set(Calendar.HOUR_OF_DAY, monthCal.getActualMinimum(Calendar.HOUR_OF_DAY));
		monthCal.set(Calendar.MINUTE, monthCal.getActualMinimum(Calendar.MINUTE));
		monthCal.set(Calendar.SECOND, monthCal.getActualMinimum(Calendar.SECOND));
		monthCal.set(Calendar.MILLISECOND, monthCal.getActualMinimum(Calendar.MILLISECOND));
		monthBegin = new java.sql.Timestamp(monthCal.getTimeInMillis());
		nextMonthCal = Calendar.getInstance();
		nextMonthCal.setTimeInMillis(monthCal.getTimeInMillis());
		nextMonthCal.set(Calendar.DAY_OF_MONTH, nextMonthCal.getActualMaximum(Calendar.DAY_OF_MONTH));
		nextMonthCal.set(Calendar.HOUR_OF_DAY, nextMonthCal.getActualMaximum(Calendar.HOUR_OF_DAY));
		nextMonthCal.set(Calendar.MINUTE, nextMonthCal.getActualMaximum(Calendar.MINUTE));
		nextMonthCal.set(Calendar.SECOND, nextMonthCal.getActualMaximum(Calendar.SECOND));
		nextMonthCal.set(Calendar.MILLISECOND, nextMonthCal.getActualMaximum(Calendar.MILLISECOND));
		monthEnd = new java.sql.Timestamp(nextMonthCal.getTimeInMillis());
		
		List<EntityCondition> conditions = FastList.newInstance();
		if(productStoreId){
			conditions.add(EntityCondition.makeCondition("productStoreId", EntityOperator.EQUALS, productStoreId));
			context.productStoreId = productStoreId;
		}
		conditions.add(EntityCondition.makeCondition("orderDate", EntityOperator.GREATER_THAN_EQUAL_TO, monthBegin));
		conditions.add(EntityCondition.makeCondition("orderDate", EntityOperator.LESS_THAN_EQUAL_TO, monthEnd));
		conditions.add(EntityCondition.makeCondition("orderTypeId", EntityOperator.EQUALS, "SALES_ORDER"));
		monthHeaders = delegator.findList("OrderHeader", EntityCondition.makeCondition(conditions, EntityOperator.AND), null, null, null, false);
		monthResultMap = FastMap.newInstance();
		//成功订单
		monthHeadersCompleteds = EntityUtil.filterByAnd(monthHeaders, [statusId : "ORDER_COMPLETED"]);
		monthItemCompletedTotal = calcItemTotal(monthHeadersCompleteds);//总金额
		monthResultMap.put("monthItemCompletedTotal", monthItemCompletedTotal);
		monthItemCompletedCount = monthHeadersCompleteds.size();//总订单数
		monthResultMap.put("monthItemCompletedCount", monthItemCompletedCount);
		BigDecimal monthItemCompletedShippingTotal = calcItemShippingTotal(monthHeadersCompleteds);//总货运
		monthResultMap.put("monthItemCompletedShippingTotal", monthItemCompletedShippingTotal);
		//有效订单
		List<EntityCondition> filterConds = FastList.newInstance();
		filterConds.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "ORDER_REJECTED"));
		filterConds.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "ORDER_CANCELLED"));
		filterConds.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "ORDER_COMPLETED"));
		monthHeadersValids = EntityUtil.filterByCondition(monthHeaders, EntityCondition.makeCondition(filterConds, EntityOperator.AND));
		monthItemValidTotal = calcItemTotal(monthHeadersValids);//总金额
		monthResultMap.put("monthItemValidTotal", monthItemValidTotal);
		monthItemValidCount = monthHeadersValids.size();//总订单数
		monthResultMap.put("monthItemValidCount", monthItemValidCount);
		BigDecimal monthItemValidShippingTotal = calcItemShippingTotal(monthHeadersValids);//总货运
		monthResultMap.put("monthItemValidShippingTotal", monthItemValidShippingTotal);
		//无效订单
		List<EntityCondition> filterConditions = FastList.newInstance();
		filterConditions.add(EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_REJECTED"));
		filterConditions.add(EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_CANCELLED"));
		monthHeadersCancles = EntityUtil.filterByCondition(monthHeaders, EntityCondition.makeCondition(filterConditions, EntityOperator.OR));
		monthItemCancleTotal = calcItemTotal(monthHeadersCancles);//总金额
		monthResultMap.put("monthItemCancleTotal", monthItemCancleTotal);
		monthItemCancleCount = monthHeadersCancles.size();//总订单数
		monthResultMap.put("monthItemCancleCount", monthItemCancleCount);
		BigDecimal monthItemCancleShippingTotal = calcItemShippingTotal(monthHeadersCancles);//总货运
		monthResultMap.put("monthItemCancleShippingTotal", monthItemCancleShippingTotal);
		//总订单
		monthItemTotal = calcItemTotal(monthHeaders);//总金额
		monthResultMap.put("monthItemTotal", monthItemTotal);
		monthItemCount = monthHeaders.size();//总订单数
		monthResultMap.put("monthItemCount", monthItemCount);
		BigDecimal monthItemShippingTotal = monthItemCompletedShippingTotal.plus(monthItemValidShippingTotal ?: BigDecimal.ZERO).plus(monthItemCancleShippingTotal ?: BigDecimal.ZERO);//总货运
		monthResultMap.put("monthItemShippingTotal", monthItemShippingTotal);
		monthResultMap.put("currentMonth", monthBegin.toString().substring(0, 7));
		yearResultList.add(monthResultMap);
	}
	context.yearResultList = yearResultList;
	context.reportType = "year";
}
monthStr = (String)parameters.get("month");
if(monthStr){
	int month = Integer.parseInt(monthStr);
	context.month = month;
	dayResultList = FastList.newInstance();
	dayCal = Calendar.getInstance();
	dayCal.set(Calendar.YEAR, nowYear);
	dayCal.set(Calendar.MONTH, month-1);
	for(int currentDay = dayCal.getActualMinimum(Calendar.DAY_OF_MONTH); currentDay <= dayCal.getActualMaximum(Calendar.DAY_OF_MONTH); currentDay++){
		dayBeginCal = Calendar.getInstance();
		dayBeginCal.setTimeInMillis(dayCal.getTimeInMillis());
		dayBeginCal.set(Calendar.DAY_OF_MONTH, currentDay);
		dayBeginCal.set(Calendar.HOUR_OF_DAY, dayBeginCal.getActualMinimum(Calendar.HOUR_OF_DAY));
		dayBeginCal.set(Calendar.MINUTE, dayBeginCal.getActualMinimum(Calendar.MINUTE));
		dayBeginCal.set(Calendar.SECOND, dayBeginCal.getActualMinimum(Calendar.SECOND));
		dayBeginCal.set(Calendar.MILLISECOND, dayBeginCal.getActualMinimum(Calendar.MILLISECOND));
		dayBegin = new java.sql.Timestamp(dayBeginCal.getTimeInMillis());
		dayEndCal = Calendar.getInstance();
		dayEndCal.setTimeInMillis(dayCal.getTimeInMillis());
		dayEndCal.set(Calendar.DAY_OF_MONTH, currentDay);
		dayEndCal.set(Calendar.HOUR_OF_DAY, dayEndCal.getActualMaximum(Calendar.HOUR_OF_DAY));
		dayEndCal.set(Calendar.MINUTE, dayEndCal.getActualMaximum(Calendar.MINUTE));
		dayEndCal.set(Calendar.SECOND, dayEndCal.getActualMaximum(Calendar.SECOND));
		dayEndCal.set(Calendar.MILLISECOND, dayEndCal.getActualMaximum(Calendar.MILLISECOND));
		dayEnd = new java.sql.Timestamp(dayEndCal.getTimeInMillis());
		
		List<EntityCondition> conditions = FastList.newInstance();
		if(productStoreId){
			conditions.add(EntityCondition.makeCondition("productStoreId", EntityOperator.EQUALS, productStoreId));
			context.productStoreId = productStoreId;
		}
		conditions.add(EntityCondition.makeCondition("orderDate", EntityOperator.GREATER_THAN_EQUAL_TO, dayBegin));
		conditions.add(EntityCondition.makeCondition("orderDate", EntityOperator.LESS_THAN_EQUAL_TO, dayEnd));
		conditions.add(EntityCondition.makeCondition("orderTypeId", EntityOperator.EQUALS, "SALES_ORDER"));
		dayHeaders = delegator.findList("OrderHeader", EntityCondition.makeCondition(conditions, EntityOperator.AND), null, null, null, false);
		dayResultMap = FastMap.newInstance();
		//成功订单
		dayHeadersCompleteds = EntityUtil.filterByAnd(dayHeaders, [statusId : "ORDER_COMPLETED"]);
		dayItemCompletedTotal = calcItemTotal(dayHeadersCompleteds);//总金额
		dayResultMap.put("dayItemCompletedTotal", dayItemCompletedTotal);
		dayItemCompletedCount = dayHeadersCompleteds.size();//总订单数
		dayResultMap.put("dayItemCompletedCount", dayItemCompletedCount);
		BigDecimal dayItemCompletedShippingTotal = calcItemShippingTotal(dayHeadersCompleteds);//总货运
		dayResultMap.put("dayItemCompletedShippingTotal", dayItemCompletedShippingTotal);
		//有效订单
		List<EntityCondition> filterConds = FastList.newInstance();
		filterConds.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "ORDER_REJECTED"));
		filterConds.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "ORDER_CANCELLED"));
		filterConds.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "ORDER_COMPLETED"));
		dayHeadersValids = EntityUtil.filterByCondition(dayHeaders, EntityCondition.makeCondition(filterConds, EntityOperator.AND));
		dayItemValidTotal = calcItemTotal(dayHeadersValids);//总金额
		dayResultMap.put("dayItemValidTotal", dayItemValidTotal);
		dayItemValidCount = dayHeadersValids.size();//总订单数
		dayResultMap.put("dayItemValidCount", dayItemValidCount);
		BigDecimal dayItemValidShippingTotal = calcItemShippingTotal(dayHeadersValids);//总货运
		dayResultMap.put("dayItemValidShippingTotal", dayItemValidShippingTotal);
		//无效订单
		List<EntityCondition> filterConditions = FastList.newInstance();
		filterConditions.add(EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_REJECTED"));
		filterConditions.add(EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_CANCELLED"));
		dayHeadersCancles = EntityUtil.filterByCondition(dayHeaders, EntityCondition.makeCondition(filterConditions, EntityOperator.OR));
		dayItemCancleTotal = calcItemTotal(dayHeadersCancles);//总金额
		dayResultMap.put("dayItemCancleTotal", dayItemCancleTotal);
		dayItemCancleCount = dayHeadersCancles.size();//总订单数
		dayResultMap.put("dayItemCancleCount", dayItemCancleCount);
		BigDecimal dayItemCancleShippingTotal = calcItemShippingTotal(dayHeadersCancles);//总货运
		dayResultMap.put("dayItemCancleShippingTotal", dayItemCancleShippingTotal);
		//总订单
		dayItemTotal = calcItemTotal(dayHeaders);//总金额
		dayResultMap.put("dayItemTotal", dayItemTotal);
		dayItemCount = dayHeaders.size();//总订单数
		dayResultMap.put("dayItemCount", dayItemCount);
		BigDecimal dayItemShippingTotal = dayItemCompletedShippingTotal.plus(dayItemValidShippingTotal ?: BigDecimal.ZERO).plus(dayItemCancleShippingTotal ?: BigDecimal.ZERO);//总货运
		dayResultMap.put("dayItemShippingTotal", dayItemShippingTotal);
		dayResultMap.put("currentDay", dayBegin.toString().substring(0,10));
		dayResultList.add(dayResultMap);
	}
	context.dayResultList = dayResultList;
	context.reportType = "day";
}
customType = (String)parameters.get("customType");
if(customType){
	fromDateStr = (String)parameters.get("fromDate");
	thruDateStr = (String)parameters.get("thruDate");
	context.fromDate = fromDateStr;
	context.thruDate = thruDateStr;
	println("==============thruDateStr=================" + thruDateStr);
	context.customType = customType;
	if("day".equals(customType)){
		fromDate = Timestamp.valueOf(fromDateStr+" 00:00:00");
		thruDate = Timestamp.valueOf(thruDateStr+" 00:00:00");
		dayCal = Calendar.getInstance();
		dayCal.setTime(fromDate);
		int overDay = (thruDate.getTime()-fromDate.getTime())/(1000*60*60*24);
		dayCustomResultList = FastList.newInstance();
		for(int currentDay = 0; currentDay <= overDay; currentDay++){
			dayBeginCal = Calendar.getInstance();
			dayBeginCal.setTimeInMillis(dayCal.getTimeInMillis());
			dayBeginCal.add(Calendar.DAY_OF_MONTH, currentDay);
			dayBeginCal.set(Calendar.HOUR_OF_DAY, dayBeginCal.getActualMinimum(Calendar.HOUR_OF_DAY));
			dayBeginCal.set(Calendar.MINUTE, dayBeginCal.getActualMinimum(Calendar.MINUTE));
			dayBeginCal.set(Calendar.SECOND, dayBeginCal.getActualMinimum(Calendar.SECOND));
			dayBeginCal.set(Calendar.MILLISECOND, dayBeginCal.getActualMinimum(Calendar.MILLISECOND));
			dayBegin = new java.sql.Timestamp(dayBeginCal.getTimeInMillis());
			
			dayEndCal = Calendar.getInstance();
			dayEndCal.setTimeInMillis(dayCal.getTimeInMillis());
			dayEndCal.add(Calendar.DAY_OF_MONTH, currentDay);
			dayEndCal.set(Calendar.HOUR_OF_DAY, dayEndCal.getActualMaximum(Calendar.HOUR_OF_DAY));
			dayEndCal.set(Calendar.MINUTE, dayEndCal.getActualMaximum(Calendar.MINUTE));
			dayEndCal.set(Calendar.SECOND, dayEndCal.getActualMaximum(Calendar.SECOND));
			dayEndCal.set(Calendar.MILLISECOND, dayEndCal.getActualMaximum(Calendar.MILLISECOND));
			dayEnd = new java.sql.Timestamp(dayEndCal.getTimeInMillis());
			List<EntityCondition> conditions = FastList.newInstance();
			if(productStoreId){
				conditions.add(EntityCondition.makeCondition("productStoreId", EntityOperator.EQUALS, productStoreId));
				context.productStoreId = productStoreId;
			}
			conditions.add(EntityCondition.makeCondition("orderDate", EntityOperator.GREATER_THAN_EQUAL_TO, dayBegin));
			conditions.add(EntityCondition.makeCondition("orderDate", EntityOperator.LESS_THAN_EQUAL_TO, dayEnd));
			conditions.add(EntityCondition.makeCondition("orderTypeId", EntityOperator.EQUALS, "SALES_ORDER"));
			dayHeaders = delegator.findList("OrderHeader", EntityCondition.makeCondition(conditions, EntityOperator.AND), null, null, null, false);
			dayResultMap = FastMap.newInstance();
			//成功订单
			dayHeadersCompleteds = EntityUtil.filterByAnd(dayHeaders, [statusId : "ORDER_COMPLETED"]);
			dayItemCompletedTotal = calcItemTotal(dayHeadersCompleteds);//总金额
			dayResultMap.put("dayItemCompletedTotal", dayItemCompletedTotal);
			dayItemCompletedCount = dayHeadersCompleteds.size();//总订单数
			dayResultMap.put("dayItemCompletedCount", dayItemCompletedCount);
			BigDecimal dayItemCompletedShippingTotal = calcItemShippingTotal(dayHeadersCompleteds);//总货运
			dayResultMap.put("dayItemCompletedShippingTotal", dayItemCompletedShippingTotal);
			//有效订单
			List<EntityCondition> filterConds = FastList.newInstance();
			filterConds.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "ORDER_REJECTED"));
			filterConds.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "ORDER_CANCELLED"));
			filterConds.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "ORDER_COMPLETED"));
			dayHeadersValids = EntityUtil.filterByCondition(dayHeaders, EntityCondition.makeCondition(filterConds, EntityOperator.AND));
			dayItemValidTotal = calcItemTotal(dayHeadersValids);//总金额
			dayResultMap.put("dayItemValidTotal", dayItemValidTotal);
			dayItemValidCount = dayHeadersValids.size();//总订单数
			dayResultMap.put("dayItemValidCount", dayItemValidCount);
			BigDecimal dayItemValidShippingTotal = calcItemShippingTotal(dayHeadersValids);//总货运
			dayResultMap.put("dayItemValidShippingTotal", dayItemValidShippingTotal);
			//无效订单
			List<EntityCondition> filterConditions = FastList.newInstance();
			filterConditions.add(EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_REJECTED"));
			filterConditions.add(EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_CANCELLED"));
			dayHeadersCancles = EntityUtil.filterByCondition(dayHeaders, EntityCondition.makeCondition(filterConditions, EntityOperator.OR));
			dayItemCancleTotal = calcItemTotal(dayHeadersCancles);//总金额
			dayResultMap.put("dayItemCancleTotal", dayItemCancleTotal);
			dayItemCancleCount = dayHeadersCancles.size();//总订单数
			dayResultMap.put("dayItemCancleCount", dayItemCancleCount);
			BigDecimal dayItemCancleShippingTotal = calcItemShippingTotal(dayHeadersCancles);//总货运
			dayResultMap.put("dayItemCancleShippingTotal", dayItemCancleShippingTotal);
			//总订单
			dayItemTotal = calcItemTotal(dayHeaders);//总金额
			dayResultMap.put("dayItemTotal", dayItemTotal);
			dayItemCount = dayHeaders.size();//总订单数
			dayResultMap.put("dayItemCount", dayItemCount);
			BigDecimal dayItemShippingTotal = dayItemCompletedShippingTotal.plus(dayItemValidShippingTotal ?: BigDecimal.ZERO).plus(dayItemCancleShippingTotal ?: BigDecimal.ZERO);//总货运
			dayResultMap.put("dayItemShippingTotal", dayItemShippingTotal);
			dayResultMap.put("currentDay", dayBegin.toString().substring(0, 10));
			dayCustomResultList.add(dayResultMap);
		}
		context.dayCustomResultList = dayCustomResultList;
		context.reportType = "dayCustom";
	}
	else if("month".equals(customType)){
		fromDate = Timestamp.valueOf(fromDateStr+" 00:00:00");
		thruDate = Timestamp.valueOf(thruDateStr+" 00:00:00");
		dayCal = Calendar.getInstance();
		dayCal.setTime(fromDate);
		yearCustomResultList = FastList.newInstance();
		def overEnd = fromDate;
		
		for(int i =1;thruDate.compareTo(overEnd)>0;i++){//while(thruDate.compareTo(overEnd));
			monthCal = Calendar.getInstance();
			monthCal.setTimeInMillis(dayCal.getTimeInMillis());
			monthCal.add(Calendar.MONTH, i-1);
			if(i!=1)
				monthCal.set(Calendar.DAY_OF_MONTH, monthCal.getActualMinimum(Calendar.DAY_OF_MONTH));
			monthCal.set(Calendar.HOUR_OF_DAY, monthCal.getActualMinimum(Calendar.HOUR_OF_DAY));
			monthCal.set(Calendar.MINUTE, monthCal.getActualMinimum(Calendar.MINUTE));
			monthCal.set(Calendar.SECOND, monthCal.getActualMinimum(Calendar.SECOND));
			monthCal.set(Calendar.MILLISECOND, monthCal.getActualMinimum(Calendar.MILLISECOND));
			monthBegin = new java.sql.Timestamp(monthCal.getTimeInMillis());
			nextMonthCal = Calendar.getInstance();
			if(overEnd.compareTo(thruDate)>0){
				nextMonthCal.setTime(thruDate);
			}
			else{
				nextMonthCal.setTimeInMillis(monthCal.getTimeInMillis());
				nextMonthCal.set(Calendar.DAY_OF_MONTH, monthCal.getActualMaximum(Calendar.DAY_OF_MONTH));
			}
			nextMonthCal.set(Calendar.HOUR_OF_DAY, nextMonthCal.getActualMaximum(Calendar.HOUR_OF_DAY));
			nextMonthCal.set(Calendar.MINUTE, nextMonthCal.getActualMaximum(Calendar.MINUTE));
			nextMonthCal.set(Calendar.SECOND, nextMonthCal.getActualMaximum(Calendar.SECOND));
			nextMonthCal.set(Calendar.MILLISECOND, nextMonthCal.getActualMaximum(Calendar.MILLISECOND));
			monthEnd = new java.sql.Timestamp(nextMonthCal.getTimeInMillis());
			overEnd = monthEnd;
			if(overEnd.compareTo(thruDate)>0)
				monthEnd= thruDate;
			List<EntityCondition> conditions = FastList.newInstance();
			if(productStoreId){
				conditions.add(EntityCondition.makeCondition("productStoreId", EntityOperator.EQUALS, productStoreId));
				context.productStoreId = productStoreId;
				println("1111111111111productStoreId111111111111111= " + productStoreId);
			}
			conditions.add(EntityCondition.makeCondition("orderDate", EntityOperator.GREATER_THAN_EQUAL_TO, monthBegin));
			conditions.add(EntityCondition.makeCondition("orderDate", EntityOperator.LESS_THAN_EQUAL_TO, monthEnd));
			conditions.add(EntityCondition.makeCondition("orderTypeId", EntityOperator.EQUALS, "SALES_ORDER"));
			monthHeaders = delegator.findList("OrderHeader", EntityCondition.makeCondition(conditions, EntityOperator.AND), null, null, null, false);
			monthResultMap = FastMap.newInstance();
			//成功订单
			monthHeadersCompleteds = EntityUtil.filterByAnd(monthHeaders, [statusId : "ORDER_COMPLETED"]);
			monthItemCompletedTotal = calcItemTotal(monthHeadersCompleteds);//总金额
			monthResultMap.put("monthItemCompletedTotal", monthItemCompletedTotal);
			monthItemCompletedCount = monthHeadersCompleteds.size();//总订单数
			monthResultMap.put("monthItemCompletedCount", monthItemCompletedCount);
			BigDecimal monthItemCompletedShippingTotal = calcItemShippingTotal(monthHeadersCompleteds);//总货运
			monthResultMap.put("monthItemCompletedShippingTotal", monthItemCompletedShippingTotal);
			//有效订单
			List<EntityCondition> filterConds = FastList.newInstance();
			filterConds.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "ORDER_REJECTED"));
			filterConds.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "ORDER_CANCELLED"));
			filterConds.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "ORDER_COMPLETED"));
			monthHeadersValids = EntityUtil.filterByCondition(monthHeaders, EntityCondition.makeCondition(filterConds, EntityOperator.AND));
			monthItemValidTotal = calcItemTotal(monthHeadersValids);//总金额
			monthResultMap.put("monthItemValidTotal", monthItemValidTotal);
			monthItemValidCount = monthHeadersValids.size();//总订单数
			monthResultMap.put("monthItemValidCount", monthItemValidCount);
			BigDecimal monthItemValidShippingTotal = calcItemShippingTotal(monthHeadersValids);//总货运
			monthResultMap.put("monthItemValidShippingTotal", monthItemValidShippingTotal);
			//无效订单
			List<EntityCondition> filterConditions = FastList.newInstance();
			filterConditions.add(EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_REJECTED"));
			filterConditions.add(EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_CANCELLED"));
			monthHeadersCancles = EntityUtil.filterByCondition(monthHeaders, EntityCondition.makeCondition(filterConditions, EntityOperator.OR));
			monthItemCancleTotal = calcItemTotal(monthHeadersCancles);//总金额
			monthResultMap.put("monthItemCancleTotal", monthItemCancleTotal);
			monthItemCancleCount = monthHeadersCancles.size();//总订单数
			monthResultMap.put("monthItemCancleCount", monthItemCancleCount);
			BigDecimal monthItemCancleShippingTotal = calcItemShippingTotal(monthHeadersCancles);//总货运
			monthResultMap.put("monthItemCancleShippingTotal", monthItemCancleShippingTotal);
			//总订单
			monthItemTotal = calcItemTotal(monthHeaders);//总金额
			monthResultMap.put("monthItemTotal", monthItemTotal);
			monthItemCount = monthHeaders.size();//总订单数
			monthResultMap.put("monthItemCount", monthItemCount);
			BigDecimal monthItemShippingTotal = monthItemCompletedShippingTotal.plus(monthItemValidShippingTotal ?: BigDecimal.ZERO).plus(monthItemCancleShippingTotal ?: BigDecimal.ZERO);//总货运
			monthResultMap.put("monthItemShippingTotal", monthItemShippingTotal);
			monthResultMap.put("currentMonth", monthBegin.toString().substring(0, 7));
			yearCustomResultList.add(monthResultMap);
		}
		context.yearCustomResultList = yearCustomResultList;
		context.reportType = "yearCustom";
	}
}
monthSelStr = (String)parameters.get("monthSel");
yearSelStr = (String)parameters.get("yearSel");
if(monthSelStr && yearSelStr){
	int month = Integer.parseInt(monthSelStr);
	int yearSel = Integer.parseInt(yearSelStr);
	context.monthSel = month;
	context.yearSel = yearSel;
	dayCustomResultList = FastList.newInstance();
	dayCal = Calendar.getInstance();
	dayCal.set(Calendar.YEAR, yearSel);
	dayCal.set(Calendar.MONTH, month-1);
	for(int currentDay = dayCal.getActualMinimum(Calendar.DAY_OF_MONTH); currentDay <= dayCal.getActualMaximum(Calendar.DAY_OF_MONTH); currentDay++){
		dayBeginCal = Calendar.getInstance();
		dayBeginCal.setTimeInMillis(dayCal.getTimeInMillis());
		dayBeginCal.set(Calendar.DAY_OF_MONTH, currentDay);
		dayBeginCal.set(Calendar.HOUR_OF_DAY, dayBeginCal.getActualMinimum(Calendar.HOUR_OF_DAY));
		dayBeginCal.set(Calendar.MINUTE, dayBeginCal.getActualMinimum(Calendar.MINUTE));
		dayBeginCal.set(Calendar.SECOND, dayBeginCal.getActualMinimum(Calendar.SECOND));
		dayBeginCal.set(Calendar.MILLISECOND, dayBeginCal.getActualMinimum(Calendar.MILLISECOND));
		dayBegin = new java.sql.Timestamp(dayBeginCal.getTimeInMillis());
		dayEndCal = Calendar.getInstance();
		dayEndCal.setTimeInMillis(dayCal.getTimeInMillis());
		dayEndCal.set(Calendar.DAY_OF_MONTH, currentDay);
		dayEndCal.set(Calendar.HOUR_OF_DAY, dayEndCal.getActualMaximum(Calendar.HOUR_OF_DAY));
		dayEndCal.set(Calendar.MINUTE, dayEndCal.getActualMaximum(Calendar.MINUTE));
		dayEndCal.set(Calendar.SECOND, dayEndCal.getActualMaximum(Calendar.SECOND));
		dayEndCal.set(Calendar.MILLISECOND, dayEndCal.getActualMaximum(Calendar.MILLISECOND));
		dayEnd = new java.sql.Timestamp(dayEndCal.getTimeInMillis());
		
		List<EntityCondition> conditions = FastList.newInstance();
		if(productStoreId){
			conditions.add(EntityCondition.makeCondition("productStoreId", EntityOperator.EQUALS, productStoreId));
			context.productStoreId = productStoreId;
		}
		conditions.add(EntityCondition.makeCondition("orderDate", EntityOperator.GREATER_THAN_EQUAL_TO, dayBegin));
		conditions.add(EntityCondition.makeCondition("orderDate", EntityOperator.LESS_THAN_EQUAL_TO, dayEnd));
		conditions.add(EntityCondition.makeCondition("orderTypeId", EntityOperator.EQUALS, "SALES_ORDER"));
		dayHeaders = delegator.findList("OrderHeader", EntityCondition.makeCondition(conditions, EntityOperator.AND), null, null, null, false);
		dayResultMap = FastMap.newInstance();
		//成功订单
		dayHeadersCompleteds = EntityUtil.filterByAnd(dayHeaders, [statusId : "ORDER_COMPLETED"]);
		dayItemCompletedTotal = calcItemTotal(dayHeadersCompleteds);//总金额
		dayResultMap.put("dayItemCompletedTotal", dayItemCompletedTotal);
		dayItemCompletedCount = dayHeadersCompleteds.size();//总订单数
		dayResultMap.put("dayItemCompletedCount", dayItemCompletedCount);
		BigDecimal dayItemCompletedShippingTotal = calcItemShippingTotal(dayHeadersCompleteds);//总货运
		dayResultMap.put("dayItemCompletedShippingTotal", dayItemCompletedShippingTotal);
		//有效订单
		List<EntityCondition> filterConds = FastList.newInstance();
		filterConds.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "ORDER_REJECTED"));
		filterConds.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "ORDER_CANCELLED"));
		filterConds.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "ORDER_COMPLETED"));
		dayHeadersValids = EntityUtil.filterByCondition(dayHeaders, EntityCondition.makeCondition(filterConds, EntityOperator.AND));
		dayItemValidTotal = calcItemTotal(dayHeadersValids);//总金额
		dayResultMap.put("dayItemValidTotal", dayItemValidTotal);
		dayItemValidCount = dayHeadersValids.size();//总订单数
		dayResultMap.put("dayItemValidCount", dayItemValidCount);
		BigDecimal dayItemValidShippingTotal = calcItemShippingTotal(dayHeadersValids);//总货运
		dayResultMap.put("dayItemValidShippingTotal", dayItemValidShippingTotal);
		//无效订单
		List<EntityCondition> filterConditions = FastList.newInstance();
		filterConditions.add(EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_REJECTED"));
		filterConditions.add(EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_CANCELLED"));
		dayHeadersCancles = EntityUtil.filterByCondition(dayHeaders, EntityCondition.makeCondition(filterConditions, EntityOperator.OR));
		dayItemCancleTotal = calcItemTotal(dayHeadersCancles);//总金额
		dayResultMap.put("dayItemCancleTotal", dayItemCancleTotal);
		dayItemCancleCount = dayHeadersCancles.size();//总订单数
		dayResultMap.put("dayItemCancleCount", dayItemCancleCount);
		BigDecimal dayItemCancleShippingTotal = calcItemShippingTotal(dayHeadersCancles);//总货运
		dayResultMap.put("dayItemCancleShippingTotal", dayItemCancleShippingTotal);
		//总订单
		dayItemTotal = calcItemTotal(dayHeaders);//总金额
		dayResultMap.put("dayItemTotal", dayItemTotal);
		dayItemCount = dayHeaders.size();//总订单数
		dayResultMap.put("dayItemCount", dayItemCount);
		BigDecimal dayItemShippingTotal = dayItemCompletedShippingTotal.plus(dayItemValidShippingTotal ?: BigDecimal.ZERO).plus(dayItemCancleShippingTotal ?: BigDecimal.ZERO);//总货运
		dayResultMap.put("dayItemShippingTotal", dayItemShippingTotal);
		dayResultMap.put("currentDay", dayBegin.toString().substring(0, 10));
		dayCustomResultList.add(dayResultMap);
	}
	context.dayCustomResultList = dayCustomResultList;
	context.reportType = "yearMonthSel";
}