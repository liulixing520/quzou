	import org.ofbiz.base.util.*
	import org.ofbiz.entity.*
	import org.ofbiz.entity.condition.*
	import org.ofbiz.entity.util.*
	import java.util.*
	import org.ofbiz.security.*
	import org.extErp.sysCommon.util.OfbizExtUtil;
	
	GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
	Debug.log("userLogin..............._"+userLogin);
	QUZOU_ADMIN = security.hasPermission("QUZOU_ADMIN", session);
	listIt = [];
	Debug.log("QUZOU_ADMIN---"+QUZOU_ADMIN);
	listIt = delegator.findByAnd("QzCompetition",[isShow:"1"],["-publishDate"]);
		//日期类型转换
		outputList = org.extErp.sysCommon.util.JsonUtil.jsonFromGenericValueList(listIt);
		for(Map<String,Object> result:outputList){
			compeCustomer = delegator.findOne("QzCompetiAndCustomer",[cId:result.cId,customerId:customer.partyId],false);
			if(UtilValidate.isNotEmpty(compeCustomer)){
				result.isIn = "Y";
			}else{
				result.isIn = "N";
			}
			result.publishDate = result.publishDate.toString().substring(0,11);
		}
	outputList = OfbizExtUtil.reloadOrder(outputList,"isIn");
	context.listIt = outputList;
	context.hasPermission = QUZOU_ADMIN; 
