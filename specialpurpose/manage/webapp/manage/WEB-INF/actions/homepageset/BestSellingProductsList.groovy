

import javolution.util.FastList;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.EntityFindOptions;
import java.util.List;

import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.entity.util.*;
import org.ofbiz.entity.condition.*;
import java.util.Locale;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.service.LocalDispatcher;


if(userLogin){
	List<EntityExpr> exprs = FastList.newInstance();
	condList = FastList.newInstance();
	if(parameters.internalName){
		condList.add(EntityCondition.makeCondition("productId", EntityOperator.LIKE,"%"+parameters.productId+"%"));
		exprs.add(EntityCondition.makeCondition("internalName", EntityOperator.LIKE, "%"+parameters.internalName+"%"));
	}
	//condList.add(EntityCondition.makeCondition("productCategoryId", EntityOperator.EQUALS,'WEEKLY_BEST_SELL'));
    productCategoryCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
    ProductCategoryList = delegator.findList("Product", productCategoryCond, null,null, null, false);
	context.ProductCategoryMemberList = ProductCategoryList;
	println "========================================== ProductCategoryMemberList     =    "+context.ProductCategoryMemberList;
	page = parameters.page?:0;
	dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	Map<String,Object> inputContext = UtilMisc.toMap("entityName", "Product");
	inputContext.put("viewSize",10);
	inputContext.put("viewIndex",page.toInteger());
	inputContext.put("mainCond",EntityCondition.makeCondition(exprs, EntityOperator.AND));
	returnResult=dispatcher.runSync("findPortalList", inputContext);
	context.orderHeaderList=returnResult.list;
	context.listSize=returnResult.listSize;
	context.viewIndex=page;
}