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
import org.ofbiz.base.util.UtilDateTime;

productId = parameters.productId;

if(productId){
	condList = FastList.newInstance();
	condListTo = FastList.newInstance();
	condList.add(EntityCondition.makeCondition("productId", EntityOperator.EQUALS,productId));
	condList.add(EntityCondition.makeCondition("productCategoryId", EntityOperator.EQUALS,"SUPER_DEALS"));
    categoryCont = EntityCondition.makeCondition(condList, EntityOperator.AND);
    RecomSuperDealCategoryList = delegator.findList("ProductCategoryMember", categoryCont, null,null, null, false);
	condListTo.add(EntityCondition.makeCondition("productCategoryId", EntityOperator.EQUALS,"SUPER_DEALS"));
    categoryContTo = EntityCondition.makeCondition(condListTo, EntityOperator.AND);
    RecomSuperDealCategoryListTo = delegator.findList("ProductCategoryMember",categoryContTo , null,null, null, false);
    if((RecomSuperDealCategoryList.size()<1)&&(RecomSuperDealCategoryListTo.size()<5)){
	Map  map=UtilMisc.toMap("productCategoryId","SUPER_DEALS","productId",productId,"fromDate",UtilDateTime.nowTimestamp());
	rc = delegator.makeValue("ProductCategoryMember", map);
	delegator.create(rc);
    }
	
}
return "success";
	