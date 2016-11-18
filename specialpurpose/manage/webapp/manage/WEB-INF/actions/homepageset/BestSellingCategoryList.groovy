
import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.EntityFindOptions;
import java.util.List;


if(userLogin){
	condList = FastList.newInstance();
	condList.add(EntityCondition.makeCondition("productCategoryId", EntityOperator.EQUALS,"WEEKLY_BEST_SELL"));
    categoryCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
    RecomBestSellingCategoryList = delegator.findList("ProductCategoryMember", categoryCond, null,null, null, false);
	context.RecomBestSellingCategoryList = RecomBestSellingCategoryList;
	println "==========================================BestSell ProductCategoryMember     =    "+context.RecomBestSellingCategoryList;
}