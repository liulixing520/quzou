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


productStoreId = parameters.productStoreId;

if(productStoreId){
	condList = FastList.newInstance();	
	condListTo = FastList.newInstance();	
	condList.add(EntityCondition.makeCondition("productStoreId", EntityOperator.EQUALS,productStoreId));
	condList.add(EntityCondition.makeCondition("status", EntityOperator.EQUALS,"0"));
	condListTo.add(EntityCondition.makeCondition("status", EntityOperator.EQUALS,"0"));
    productStoreCont = EntityCondition.makeCondition(condList, EntityOperator.AND);
    productStoreContTo = EntityCondition.makeCondition(condListTo, EntityOperator.AND);
    RecommendSellersList = delegator.findList("RecommendedSeller", productStoreCont, null,null, null, false);
    RecommendSellersListTo = delegator.findList("RecommendedSeller", productStoreContTo, null,null, null, false);
    println "-======-----====--------------------------RecommendSellersList.size = "+RecommendSellersList.size();
    println "-======-----====--------------------------RecommendSellersListTo.size = "+RecommendSellersListTo.size();
    if((RecommendSellersList.size()<1)&&(RecommendSellersListTo.size()<10)){
    	
	//RecommendedSeller ID 值
	recommendedSellerId=delegator.getNextSeqId("RecommendedSeller");
	
	Map  map=UtilMisc.toMap("recommendedSellerId",recommendedSellerId,"productStoreId",productStoreId,"status","0");
	
	rs = delegator.makeValue("RecommendedSeller", map);
	
	delegator.create(rs);

    }
	return "success";
}

	