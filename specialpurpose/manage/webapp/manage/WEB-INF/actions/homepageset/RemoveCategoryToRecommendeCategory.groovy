import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.*;


recommendedCategoryId = parameters.recommendedCategoryId;

if(recommendedCategoryId){
	
	Map  map=UtilMisc.toMap("recommendedCategoryId",recommendedCategoryId,"status","1");
	
	rc = delegator.makeValue("RecommendedCategory", map);
	
	delegator.store(rc);
	return "success";
}

	