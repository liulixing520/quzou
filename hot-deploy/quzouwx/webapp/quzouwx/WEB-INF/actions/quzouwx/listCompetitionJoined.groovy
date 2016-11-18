	import org.ofbiz.base.util.*
	import org.ofbiz.entity.*
	import org.ofbiz.entity.condition.*
	import org.ofbiz.entity.util.*
	import java.util.*
	import org.ofbiz.security.*
	
	listIt = [];
	listIt = delegator.findByAnd("QzCompetiAndCustomerView",[customerId:customer.partyId],["-publishDate"]);
		//日期类型转换
		outputList = org.extErp.sysCommon.util.JsonUtil.jsonFromGenericValueList(listIt);
		for(Map<String,Object> result:outputList){
			result.publishDate = result.publishDate.toString().substring(0,11);
		}
	context.listIt = outputList; 
