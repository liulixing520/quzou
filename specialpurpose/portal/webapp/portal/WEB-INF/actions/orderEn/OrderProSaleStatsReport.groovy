import java.math.BigDecimal;
import java.sql.Timestamp;
import javolution.util.FastList;
import javolution.util.FastMap;
import java.util.*;

import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.*;
import org.ofbiz.base.util.*;

Map calcItemQuantityAndTotal(List items) {
	resultMap = FastMap.newInstance();
	BigDecimal quantity = BigDecimal.ZERO;
	BigDecimal total = BigDecimal.ZERO;
	items.each { item ->
		quantity = quantity.plus(item.quantity ?: BigDecimal.ZERO);
		total = total.plus((item.quantity.multiply(item.unitPrice ?: BigDecimal.ZERO)).setScale(2, BigDecimal.ROUND_HALF_UP));
	}
	resultMap.putAt("quantity", quantity);
	resultMap.putAt("total", total);
	return resultMap;
}
nowTime = UtilDateTime.nowTimestamp();
if("ok".equals(selectType)){
	def resultList = FastList.newInstance();
	List<EntityCondition> filterConds = FastList.newInstance();
	//filterConds.add(EntityCondition.makeCondition("productTypeId", EntityOperator.EQUALS, "GOOD"));
	//primaryProductCategoryId = (String)parameters.get("primaryProductCategoryId");
	if(primaryProductCategoryId){
		filterConds.add(EntityCondition.makeCondition("primaryProductCategoryId", EntityOperator.EQUALS, primaryProductCategoryId));
	}
	//productTypeCategoryId = (String)parameters.get("productTypeCategoryId");
	if(productTypeCategoryId){
		filterConds.add(EntityCondition.makeCondition("productTypeCategoryId", EntityOperator.EQUALS, productTypeCategoryId));
	}
	//brandName = (String)parameters.get("brandName");
	if(brandName){
		filterConds.add(EntityCondition.makeCondition("brandName", EntityOperator.EQUALS, brandName));
	}
	// all product	
	products = delegator.findList("Product", EntityCondition.makeCondition(filterConds, EntityOperator.AND), null, null, null, false);
	// filter by date
	List<EntityCondition> filterConditions = FastList.newInstance();
	filterConditions.add(EntityCondition.makeCondition("salesDiscontinuationDate", EntityOperator.GREATER_THAN_EQUAL_TO, nowTime));
	filterConditions.add(EntityCondition.makeCondition("salesDiscontinuationDate", EntityOperator.EQUALS, null));
	productList = EntityUtil.filterByCondition(products, EntityCondition.makeCondition(filterConditions, EntityOperator.OR));
	for(product in productList){
        productId = product.productId;
		fromDate = Timestamp.valueOf(fromDateStr+" 00:00:00");
		thruDate = Timestamp.valueOf(thruDateStr+" 00:00:00");
		dayCal = Calendar.getInstance();
		dayCal.setTime(fromDate);
		dayBeginCal = Calendar.getInstance();
		dayBeginCal.setTimeInMillis(dayCal.getTimeInMillis());
		dayBeginCal.set(Calendar.HOUR_OF_DAY, dayBeginCal.getActualMinimum(Calendar.HOUR_OF_DAY));
		dayBeginCal.set(Calendar.MINUTE, dayBeginCal.getActualMinimum(Calendar.MINUTE));
		dayBeginCal.set(Calendar.SECOND, dayBeginCal.getActualMinimum(Calendar.SECOND));
		dayBeginCal.set(Calendar.MILLISECOND, dayBeginCal.getActualMinimum(Calendar.MILLISECOND));
		dayBegin = new java.sql.Timestamp(dayBeginCal.getTimeInMillis());
		//println(dayBegin);
		dayEndCal = Calendar.getInstance();
		dayEndCal.setTime(thruDate);
		dayEndCal.set(Calendar.HOUR_OF_DAY, dayEndCal.getActualMaximum(Calendar.HOUR_OF_DAY));
		dayEndCal.set(Calendar.MINUTE, dayEndCal.getActualMaximum(Calendar.MINUTE));
		dayEndCal.set(Calendar.SECOND, dayEndCal.getActualMaximum(Calendar.SECOND));
		dayEndCal.set(Calendar.MILLISECOND, dayEndCal.getActualMaximum(Calendar.MILLISECOND));
		dayEnd = new java.sql.Timestamp(dayEndCal.getTimeInMillis());
		//println(dayEnd);
		List<EntityCondition> conditions = FastList.newInstance();
		if(productStoreId){
			EntityCondition.makeCondition("productStoreId", EntityOperator.EQUALS, productStoreId)
			conditions.add(EntityCondition.makeCondition("productStoreId", EntityOperator.EQUALS, productStoreId));
		}
		conditions.add(EntityCondition.makeCondition("orderDate", EntityOperator.GREATER_THAN_EQUAL_TO, dayBegin));
		conditions.add(EntityCondition.makeCondition("orderDate", EntityOperator.LESS_THAN_EQUAL_TO, dayEnd));
		conditions.add(EntityCondition.makeCondition("productId", EntityOperator.EQUALS, productId));
		conditions.add(EntityCondition.makeCondition("itemStatusId", EntityOperator.EQUALS, "ITEM_COMPLETED"));
		conditions.add(EntityCondition.makeCondition("orderTypeId", EntityOperator.EQUALS, "SALES_ORDER"));
	    List productItems = delegator.findList("OrderHeaderAndItems", EntityCondition.makeCondition(conditions, EntityOperator.AND), null, null, null, false);
		quantity = BigDecimal.ZERO;
		total = BigDecimal.ZERO;
		productResultMap = FastMap.newInstance();
		productResultMap.put("productId", productId);
		proGV = delegator.findByPrimaryKey("Product", [productId : productId]);
		productResultMap.put("productName", proGV.productName);
		productResultMap.put("goodsNo", proGV.goodsNo);
		itemMap = null;
		if(UtilValidate.isNotEmpty(productItems)){
			itemMap = calcItemQuantityAndTotal(productItems);
			productResultMap.put("quantity", itemMap.get("quantity"));
			productResultMap.put("total", itemMap.get("total"));
			total = new BigDecimal(itemMap.get("total")).setScale(2, BigDecimal.ROUND_HALF_UP);
			quantity = new BigDecimal(itemMap.get("quantity")).setScale(2, BigDecimal.ROUND_HALF_UP);
			if(quantity.compareTo(BigDecimal.ZERO)>0 && total.compareTo(BigDecimal.ZERO)>0){
				BigDecimal avgePrice = total.divide(quantity).setScale(2, BigDecimal.ROUND_HALF_UP);
				productResultMap.put("avgePrice", avgePrice);
			}
			else{
				productResultMap.put("avgePrice", BigDecimal.ZERO);
			}
		}else{
			productResultMap.put("quantity", BigDecimal.ZERO);
			productResultMap.put("total", BigDecimal.ZERO);
			productResultMap.put("avgePrice", BigDecimal.ZERO);
		}
		resultList.add(productResultMap);
    }
	Collections.sort(resultList, [compare: {l1, l2 -> l2.quantity.compareTo(l1.quantity)}] as Comparator);
	
	context.resultList = resultList;
}

