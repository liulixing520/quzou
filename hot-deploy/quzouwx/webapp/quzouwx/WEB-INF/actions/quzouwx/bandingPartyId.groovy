	import org.ofbiz.base.util.*
	import org.ofbiz.entity.*
	import org.ofbiz.entity.condition.*
	import org.ofbiz.entity.util.*
	import java.util.*
	import java.text.ParseException;
	import java.text.SimpleDateFormat;
	import java.sql.Timestamp;
	import org.ofbiz.service.ServiceUtil;
	
	userLoginId = parameters.userLoginId;
	customer = EntityUtil.getFirst(delegator.findByAnd("QzCustomer",[userLoginId:userLoginId]));
	result = [:];
	if(customer){
		if(UtilValidate.isNotEmpty(customer.openId)){
			request.setAttribute("errorMessage", "该用户名已被占用，请联系管理员");
		}else{
			userInfo = session.getAttribute("userInfo");
			openid = userInfo.get("openid");
			person = delegator.findOne("Person",[partyId:customer.partyId],false);
			person.openId = openid;
			person.nickname = userInfo.get("nickname");
			person.headimgurl = userInfo.get("headimgurl");
			person.store();
		}
	}else{
		request.setAttribute("errorMessage", "该用户名不存在,请联系管理员");
	}
