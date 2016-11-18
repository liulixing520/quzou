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

if(yearStr){
   int year = Integer.parseInt(yearStr);
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
}