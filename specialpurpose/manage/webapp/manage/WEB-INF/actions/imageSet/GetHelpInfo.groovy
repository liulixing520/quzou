
import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.EntityFindOptions;
import java.util.List;


//if(userLogin){
	    
        condList = FastList.newInstance();
        condList.add(EntityCondition.makeCondition("helpStatus", EntityOperator.EQUALS, "0"));
        List<String> orderBy = UtilMisc.toList("-lastUpdatedStamp");
	    helpInfoCont = EntityCondition.makeCondition(condList, EntityOperator.AND);
	    HelpInfoList = delegator.findList("HelpInformation", helpInfoCont, null,orderBy, null, false);
	    
	    context.HelpInfoList = HelpInfoList;
	    println "===================================================================="+context.HelpInfoList;
	    println "===================================================================="+context.HelpInfoList;
	    println "===================================================================="+context.HelpInfoList;
//}