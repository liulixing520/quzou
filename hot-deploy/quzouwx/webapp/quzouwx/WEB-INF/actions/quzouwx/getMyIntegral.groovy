	import org.ofbiz.base.util.*
	import org.ofbiz.entity.*
	import org.ofbiz.entity.condition.*
	import org.ofbiz.entity.util.*
	import java.util.*

	if(customer){
		customerStatic = EntityUtil.getFirst(delegator.findByAnd("QzStatisticsTotal",[customerId:customer.partyId]));
		context.customerStatic = customerStatic;
	}
