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
import java.util.Date;
import java.sql.*;

productId = parameters.productId;

if(productId){
	condList = FastList.newInstance();
	condListTo = FastList.newInstance();
	condList.add(EntityCondition.makeCondition("productId", EntityOperator.EQUALS,productId));
	condList.add(EntityCondition.makeCondition("productCategoryId", EntityOperator.EQUALS,"WEEKLY_BEST_SELL"));
    categoryCont = EntityCondition.makeCondition(condList, EntityOperator.AND);
    RecomBestSellingCategoryList = delegator.findList("ProductCategoryMember", categoryCont, null,null, null, false);
	condListTo.add(EntityCondition.makeCondition("productCategoryId", EntityOperator.EQUALS,"WEEKLY_BEST_SELL"));
    categoryContTo = EntityCondition.makeCondition(condListTo, EntityOperator.AND);
    RecomBestSellingCategoryListTo = delegator.findList("ProductCategoryMember",categoryContTo , null,null, null, false);
    println "-======-----====--------------------------RecommendCategorysList.size = "+RecomBestSellingCategoryList.size();
    println "-======-----====--------------------------RecommendCategorysListTo.size = "+RecomBestSellingCategoryListTo.size();
    if((RecomBestSellingCategoryList.size()<1)&&(RecomBestSellingCategoryListTo.size()<10)){
    //	UtilDateTime.nowTimestamp()
	Map  map=UtilMisc.toMap("productCategoryId","WEEKLY_BEST_SELL","productId",productId,"fromDate",new java.sql.Timestamp(new Date().getTime()));
	rc = delegator.makeValue("ProductCategoryMember", map);
	println "--------------------------------------------map      "+map
	delegator.create(rc);
    }
	return "success";
}

	