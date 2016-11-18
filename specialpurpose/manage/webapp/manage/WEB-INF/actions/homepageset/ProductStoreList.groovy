

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
	if(parameters.storeName){
		condList.add(EntityCondition.makeCondition("storeName", EntityOperator.LIKE,"%"+parameters.storeName+"%"));
		exprs.add(EntityCondition.makeCondition("storeName", EntityOperator.LIKE, "%"+parameters.storeName+"%"));
	}
    productStoreCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
    ProductStoresList = delegator.findList("ProductStore", productStoreCond, null,null, null, false);
	context.ProductStoresList = ProductStoresList;
	println "========================================== ProductStoresList     =    "+context.ProductStoresList;
	page = parameters.page?:0;
	dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	Map<String,Object> inputContext = UtilMisc.toMap("entityName", "ProductStore");
	inputContext.put("viewSize",10);
	inputContext.put("viewIndex",page.toInteger());
	inputContext.put("mainCond",EntityCondition.makeCondition(exprs, EntityOperator.AND));
	returnResult=dispatcher.runSync("findPortalList", inputContext);
	context.orderHeaderList=returnResult.list;
	context.listSize=returnResult.listSize;
	context.viewIndex=page;
}