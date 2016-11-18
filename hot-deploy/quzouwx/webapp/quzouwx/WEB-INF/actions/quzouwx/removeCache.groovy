	import org.ofbiz.base.util.*
	import org.ofbiz.entity.*
	import org.ofbiz.entity.condition.*
	import org.ofbiz.entity.util.*
	import java.util.*
	import java.text.ParseException;
	import java.text.SimpleDateFormat;
	import java.sql.Timestamp;

	//清除缓存
	session.removeAttribute("customer");
	request.setAttribute("message", "清除缓存成功");