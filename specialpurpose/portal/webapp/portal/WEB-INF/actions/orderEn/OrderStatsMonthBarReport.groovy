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

if(monthStr){
	int month = Integer.parseInt(monthStr);
	def dayResultList = FastList.newInstance();
	dayCal = Calendar.getInstance();
	dayCal.setTime(new Date());
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
		dayResultMap.put("currentDay", dayBegin.toString().substring(0, 10));
		dayResultList.add(dayResultMap);
	}
	context.dayResultList = dayResultList;
}