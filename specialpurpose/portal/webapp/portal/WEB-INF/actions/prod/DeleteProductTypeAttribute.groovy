import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.*;


attributeId = parameters.attributeId;
println "==========================  attributeId          =     "+attributeId
if(attributeId){
	println "--------- 进入  Delete 方法"
	delegator.removeByAnd("TypeAttribute",UtilMisc.toMap("attributeId",attributeId));
	return "success";
}
