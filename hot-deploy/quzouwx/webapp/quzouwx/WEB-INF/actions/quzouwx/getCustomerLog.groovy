	import org.ofbiz.base.util.*
	import org.ofbiz.entity.*
	import org.ofbiz.entity.condition.*
	import org.ofbiz.entity.util.*
	import java.util.*
	import java.text.ParseException;
	import java.text.SimpleDateFormat;
	import java.sql.Timestamp;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
	stepDate = parameters.stepDate;
	Timestamp time = UtilDateTime.nowTimestamp();
	if(UtilValidate.isNotEmpty(stepDate)){
		Date date = (Date) sdf.parse(stepDate);
		time = UtilDateTime.toTimestamp(date);
	}else{
		stepDate = sdf.format(new Date());
	}
	
	def empCond = [
	           	EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, customer.partyId),
	           	EntityCondition.makeCondition("stepDate", EntityOperator.GREATER_THAN_EQUAL_TO, new java.sql.Date(UtilDateTime.getMonthStart(time).getTime())),
	           	EntityCondition.makeCondition("stepDate", EntityOperator.LESS_THAN_EQUAL_TO, new java.sql.Date(UtilDateTime.getMonthEnd(time,timeZone, locale).getTime()))
	           ];
	
	List<GenericValue> customerLogAndCustomerList=delegator.findList("CustomerLogAndCustomer",EntityCondition.makeCondition(empCond), null, ['-stepDate'], null, false);
	context.customerLogAndCustomerList = customerLogAndCustomerList;
	context.stepDate = stepDate;