import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;

if (userLogin) {
    
	if(helpClassId){
		helpClassification = delegator.findOne("HelpClassification",[helpClassId: helpClassId], false);
    	context.helpClassification = helpClassification;
    }
    println "---------------------------------context.helpClassification  =  "+context.helpClassification
}