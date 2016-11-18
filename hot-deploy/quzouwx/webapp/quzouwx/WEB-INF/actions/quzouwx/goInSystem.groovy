	import org.ofbiz.base.util.*
	import org.ofbiz.entity.*
	import org.ofbiz.entity.condition.*
	import org.ofbiz.entity.util.*
	import java.util.*
	import java.text.ParseException;
	import java.text.SimpleDateFormat;
	import java.sql.Timestamp;

	customer = EntityUtil.getFirst(delegator.findByAnd("QzCustomer",[partyId:"system"]));
	userLogin = delegator.findOne("UserLogin",[userLoginId:"system"],false);
	session.setAttribute("customer",customer);
	session.setAttribute("userLogin",userLogin);
