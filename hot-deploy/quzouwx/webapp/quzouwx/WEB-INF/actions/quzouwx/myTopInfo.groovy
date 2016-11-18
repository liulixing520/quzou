	import org.ofbiz.base.util.*
	import org.ofbiz.entity.*
	import org.ofbiz.entity.condition.*
	import org.ofbiz.entity.util.*
	import java.util.*

	
	userInfo = session.getAttribute("userInfo");
	customer = session.getAttribute("customer");
	openid = "";
//	if(UtilValidate.isEmpty(userInfo)){
//		openid = 'oOPc7twpTTnpiZ2HffmMdffIGxV4';
//		userInfo = runService('getUserByOpenId', [openid : openid]);	
//		session.setAttribute("userInfo",userInfo);
//	}else{
		openid = userInfo.get("openid");
//	}
		
	
	if(UtilValidate.isEmpty(customer)){
		customer = EntityUtil.getFirst(delegator.findByAnd("QzCustomer",[openId:openid]));
		session.setAttribute("customer",customer);
	}
	userLogin = EntityUtil.getFirst(delegator.findByAnd("UserLogin",[partyId:customer.partyId]));
	session.setAttribute("userLogin",userLogin);
	context.customer = customer; 
	context.userInfo = userInfo; 
