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

if(UtilValidate.isNotEmpty(fromDateStr) && UtilValidate.isNotEmpty(thruDateStr)){
	fromDate = Timestamp.valueOf(fromDateStr+" 00:00:00");
	thruDate = Timestamp.valueOf(thruDateStr+" 00:00:00");
	dayCal = Calendar.getInstance();
		dayCal.setTime(fromDate);
		int overDay = (thruDate.getTime()-fromDate.getTime())/(1000*60*60*24);
		dayResultList = FastList.newInstance();
		for(int currentDay = 0; currentDay <= overDay; currentDay++){
			dayBeginCal = Calendar.getInstance();
			dayBeginCal.setTimeInMillis(dayCal.getTimeInMillis());
			dayBeginCal.add(Calendar.DAY_OF_MONTH, currentDay);
			dayBeginCal.set(Calendar.HOUR_OF_DAY, dayBeginCal.getActualMinimum(Calendar.HOUR_OF_DAY));
			dayBeginCal.set(Calendar.MINUTE, dayBeginCal.getActualMinimum(Calendar.MINUTE));
			dayBeginCal.set(Calendar.SECOND, dayBeginCal.getActualMinimum(Calendar.SECOND));
			dayBeginCal.set(Calendar.MILLISECOND, dayBeginCal.getActualMinimum(Calendar.MILLISECOND));
			dayBegin = new java.sql.Timestamp(dayBeginCal.getTimeInMillis());dayBeginCal.DAY_OF_MONTH
			
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
			List<EntityCondition> filterConditions = FastList.newInstance();
			filterConditions.add(EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_REJECTED"));
			filterConditions.add(EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_CANCELLED"));
			dayHeadersCancles = EntityUtil.filterByCondition(dayHeaders, EntityCondition.makeCondition(filterConditions, EntityOperator.OR));
			cancleTotal = calcItemTotal(dayHeadersCancles);//总金额
			if(cancleTotal.compareTo(BigDecimal.ZERO)>0){
				resultMap = FastMap.newInstance();
				resultMap.put("dailydate", dayBegin.toString().substring(0,10));
				resultMap.put("cancleTotal", cancleTotal);
				cancleCount = dayHeadersCancles.size();//总订单数
				resultMap.put("cancleCount", cancleCount);
				dayResultList.add(resultMap);
			}
		}
	context.dayResultList = dayResultList;
}