	import org.ofbiz.base.util.*
	import org.ofbiz.entity.*
	import org.ofbiz.entity.condition.*
	import org.ofbiz.entity.util.*
	import java.util.*
	import java.text.ParseException;
	import java.text.SimpleDateFormat;
	import java.sql.Timestamp;

	userInfo = session.getAttribute("userInfo");
	customer = session.getAttribute("customer");
	if(UtilValidate.isEmpty(customer)){//session中如果有值则直接跳转，没有则判断是否存在
		openid = userInfo.get("openid");
		customer = EntityUtil.getFirst(delegator.findByAnd("QzCustomer",[openId:openid]));
		if(UtilValidate.isNotEmpty(customer)){
			session.setAttribute("customer",customer);
			return "success";
		}else{
			return "error";
		}
	}else{
		return "success";
	}
		
