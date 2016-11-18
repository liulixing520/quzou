import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;

if (userLogin) {
    if(messageId){
    	messageByOne = delegator.findOne("MessageSet",[messageId: messageId], false);
    	context.messageByOne = messageByOne;
    }
    println "-----------------------------------------messageByOne   "+messageByOne;
}