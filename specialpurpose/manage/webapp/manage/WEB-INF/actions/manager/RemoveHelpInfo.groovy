import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.*;

if(parameters.helpPageInfoId){
	Map  map=UtilMisc.toMap("helpPageInfoId",parameters.helpPageInfoId,"helpStatus","1");

	Hif = delegator.makeValue("HelpInformation", map);

	delegator.store(Hif);r
}
return "success";



	












