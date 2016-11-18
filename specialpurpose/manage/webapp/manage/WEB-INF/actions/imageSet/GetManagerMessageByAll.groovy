import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;

if (userLogin) {
	    condList = FastList.newInstance();
	    condList.add(EntityCondition.makeCondition("status",EntityOperator.EQUALS,"0"));
	    condList.add(EntityCondition.makeCondition("releases",EntityOperator.EQUALS,"-Y-"));
	    messageCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
	    messageList = delegator.findList("MessageSet", messageCond, null,null, null, false);
	    context.messageList = messageList;
}