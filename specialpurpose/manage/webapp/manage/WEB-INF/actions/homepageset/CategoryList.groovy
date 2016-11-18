

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
    List list = new ArrayList();
	condList = FastList.newInstance();
	condListTo = FastList.newInstance();
	if(parameters.productCategoryId){
		condList.add(EntityCondition.makeCondition("productCategoryId", EntityOperator.LIKE,"%"+parameters.productCategoryId+"%"));
		exprs.add(EntityCondition.makeCondition("productCategoryId", EntityOperator.LIKE, "%"+parameters.productCategoryId+"%"));
	}
/*	if(parameters.categoryName){
		condListTo.add(EntityCondition.makeCondition("categoryName", EntityOperator.LIKE,"%"+parameters.categoryName+"%"));
		productCategoryCondTo = EntityCondition.makeCondition(condListTo, EntityOperator.AND);
	    ProductCategoryListTo = delegator.findList("ProductCategory", productCategoryCondTo, null,null, null, false);
	    for(int i=0;i<ProductCategoryListTo.size();i++){
	    	
	    }
		condList.add(EntityCondition.makeCondition("productCategoryId", EntityOperator.LIKE,"%"+parameters.productCategoryId+"%"));
	}*/
	
    productCategoryCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
    ProductCategoryList = delegator.findList("ProductCategoryRollup", productCategoryCond, null,null, null, false);
    //目前先写成这样 以后需优化 获取下级分类 保留2级分类
/*    for(int i=0;i<ProductCategoryList.size();i++){
    	if(ProductCategoryList[i].parentProductCategoryId==ProductCategoryList.productCategoryId){
    	      categorylist = delegator.findOne("ProductCategoryRollup", [productCategoryId : ProductCategoryList.productCategoryId], false);
    	      println "----------------"+categorylist.productCategoryId
    		if(!categorylist.productCategoryId){
    		   list.add(ProductCategoryList[i]);
    		}
    	}
    }*/
	context.ProductCategoryList = ProductCategoryList;
	println "========================================== ProductCategoryList     =    "+context.ProductCategoryList;
	
	page = parameters.page?:0;
	dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	Map<String,Object> inputContext = UtilMisc.toMap("entityName", "ProductCategoryRollup");
	inputContext.put("viewSize",10);
	inputContext.put("viewIndex",page.toInteger());
	inputContext.put("mainCond",EntityCondition.makeCondition(exprs, EntityOperator.AND));
	returnResult=dispatcher.runSync("findPortalList", inputContext);
	context.orderHeaderList=returnResult.list;
	context.listSize=returnResult.listSize;
	context.viewIndex=page;
}