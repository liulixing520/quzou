import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;

//if (userLogin) {
    
	if(helpPageInfoId){
		helpinformation = delegator.findOne("HelpInformation",[helpPageInfoId: helpPageInfoId], false);
    	context.helpinformation = helpinformation;
    }
    println "---------------------------------context.helpinformation  =  "+context.helpinformation
//}