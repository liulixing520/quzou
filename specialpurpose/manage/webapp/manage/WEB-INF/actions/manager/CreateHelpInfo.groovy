import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.*;


productStoreId = parameters.productStoreId;
informationTitleName = parameters.informationTitleName;
longInfomation = parameters.longInfomation;

/*println "----------------------------------------------------------------informationId   "+informationId
println "----------------------------------------------------------------informationTitleName   "+informationTitleName
println "----------------------------------------------------------------longInfomation   "+longInfomation

if(parameters.informationId){
	Map  map=UtilMisc.toMap("informationId",informationId,"informationTitleName",informationTitleName,"longInfomation",longInfomation);

	Hif = delegator.makeValue("InformationForHelp", map);

	delegator.store(Hif);
}else{
	//获取TrePerson实体的 ID 值
	informationId=delegator.getNextSeqId("InformationForHelp");
	
	Map  map=UtilMisc.toMap("informationId",informationId,"informationTitleName",informationTitleName,"longInfomation",longInfomation);
	
	Hif = delegator.makeValue("InformationForHelp", map);
	
	delegator.create(Hif);
}

	return "success";*/




helpTitleName = parameters.helpTitleName;
longHelpInfo = parameters.longHelpInfo;

if(parameters.helpPageInfoId){
	Map  map=UtilMisc.toMap("helpPageInfoId",parameters.helpPageInfoId,"helpClassId",parameters.helpClassId,"helpTitleName",helpTitleName,"longHelpInfo",longHelpInfo,"helpStatus","0");

	Hif = delegator.makeValue("HelpInformation", map);

	delegator.store(Hif);
}else{
	//获取TrePerson实体的 ID 值
	helpPageInfoId=delegator.getNextSeqId("HelpInformation");
	
	Map  map=UtilMisc.toMap("helpPageInfoId",helpPageInfoId,"helpClassId",parameters.helpClassId,"helpTitleName",helpTitleName,"longHelpInfo",longHelpInfo,"helpStatus","0");
	
	Hif = delegator.makeValue("HelpInformation", map);
	
	delegator.create(Hif);
}

	return "success";



	












