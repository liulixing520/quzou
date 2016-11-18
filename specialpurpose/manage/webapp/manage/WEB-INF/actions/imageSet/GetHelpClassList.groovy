
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
	    helpCont = EntityCondition.makeCondition(condList, EntityOperator.AND);
	    HelpInformationList = delegator.findList("HelpInformation", helpCont, null,orderBy, null, false);
	    
	    context.HelpInformationList = HelpInformationList;
	    println "----------------------------========================="+context.HelpInformationList;
	
	    
        condListOne = FastList.newInstance();
        condListOne.add(EntityCondition.makeCondition("classificationDelete", EntityOperator.EQUALS, "0"));
        List<String> orderByOne = UtilMisc.toList("-lastUpdatedStamp");
	    helpContOne = EntityCondition.makeCondition(condListOne, EntityOperator.AND);
	    HelpClassList = delegator.findList("HelpClassification", helpContOne, null,orderByOne, null, false);
	    
	    context.HelpClassList = HelpClassList;
	    println "----------------------------========================="+context.HelpClassList;
	    
	    /*    informationTitleName = parameters.informationTitleName;
	    println "====================================================="+informationTitleName
        condList = FastList.newInstance();
        condList.add(EntityCondition.makeCondition("informationTitleName", EntityOperator.EQUALS, informationTitleName));
	    helpCont = EntityCondition.makeCondition(condList, EntityOperator.AND);
	    HelpInfoList = delegator.findList("InformationForHelp", helpCont, null,null, null, false);
	    
	    context.HelpInfoList = HelpInfoList[0];
	    println "----------------------------========================= context.HelpInfoList;  "+context.HelpInfoList;*/
//}