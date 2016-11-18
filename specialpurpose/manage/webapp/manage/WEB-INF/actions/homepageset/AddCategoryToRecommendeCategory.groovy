import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.*;
import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.EntityFindOptions;
import java.util.List;


productCategoryId = parameters.productCategoryId;

if(productCategoryId){
	condList = FastList.newInstance();
	condListTo = FastList.newInstance();
	condList.add(EntityCondition.makeCondition("productCategoryId", EntityOperator.EQUALS,productCategoryId));
	condList.add(EntityCondition.makeCondition("status", EntityOperator.EQUALS,"0"));
	condListTo.add(EntityCondition.makeCondition("status", EntityOperator.EQUALS,"0"));
    categoryCont = EntityCondition.makeCondition(condList, EntityOperator.AND);
    categoryContTo = EntityCondition.makeCondition(condListTo, EntityOperator.AND);
    RecommendCategorysList = delegator.findList("RecommendedCategory", categoryCont, null,null, null, false);
    RecommendCategorysListTo = delegator.findList("RecommendedCategory", categoryContTo, null,null, null, false);
    println "-======-----====--------------------------RecommendCategorysList.size = "+RecommendCategorysList.size();
    println "-======-----====--------------------------RecommendCategorysListTo.size = "+RecommendCategorysListTo.size();
    if((RecommendCategorysList.size()<1)&&(RecommendCategorysListTo.size()<5)){
    	
	//RecommendedSeller ID 值
	recommendedCategoryId=delegator.getNextSeqId("RecommendedCategory");
	
	Map  map=UtilMisc.toMap("recommendedCategoryId",recommendedCategoryId,"productCategoryId",productCategoryId,"status","0");
	
	rc = delegator.makeValue("RecommendedCategory", map);
	
	delegator.create(rc);

    }
	return "success";
}

	