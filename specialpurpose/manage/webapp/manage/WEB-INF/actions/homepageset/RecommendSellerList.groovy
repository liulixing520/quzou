
import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.EntityFindOptions;
import java.util.List;


if(userLogin){
	condList = FastList.newInstance();
	/*if(parameters.storeName){
		condList.add(EntityCondition.makeCondition("storeName", EntityOperator.LIKE,"%"+parameters.storeName+"%"));
	}*/
	condList.add(EntityCondition.makeCondition("status", EntityOperator.EQUALS,"0"));
    productStoreCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
    RecommendSellersList = delegator.findList("RecommendedSeller", productStoreCond, null,null, null, false);
	context.RecommendSellersList = RecommendSellersList;
	println "========================================== RecommendSellersList     =    "+context.RecommendSellersList;
}