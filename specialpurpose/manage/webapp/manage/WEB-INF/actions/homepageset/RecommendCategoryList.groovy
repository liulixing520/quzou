
import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.EntityFindOptions;
import java.util.List;


if(userLogin){
	condList = FastList.newInstance();
	condList.add(EntityCondition.makeCondition("status", EntityOperator.EQUALS,"0"));
    categoryCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
    RecommendedCategoryList = delegator.findList("RecommendedCategory", categoryCond, null,null, null, false);
	context.RecommendedCategoryList = RecommendedCategoryList;
	println "========================================== RecommendedCategoryList     =    "+context.RecommendedCategoryList;
}