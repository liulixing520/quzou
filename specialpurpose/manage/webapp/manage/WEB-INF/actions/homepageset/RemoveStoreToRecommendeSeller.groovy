import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.*;


recommendedSellerId = parameters.recommendedSellerId;

if(recommendedSellerId){
	
	Map  map=UtilMisc.toMap("recommendedSellerId",recommendedSellerId,"status","1");
	
	rs = delegator.makeValue("RecommendedSeller", map);
	
	delegator.store(rs);
	return "success";
}

	