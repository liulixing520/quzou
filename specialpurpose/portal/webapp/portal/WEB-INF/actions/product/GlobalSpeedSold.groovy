import org.ofbiz.base.util.*;
import org.ofbiz.product.catalog.*;
import org.ofbiz.product.feature.*;
import org.ofbiz.product.product.*;

module = "KeywordSearchSolr.groovy";

viewSize = parameters.VIEW_SIZE;
viewIndex = parameters.VIEW_INDEX;

queryLine ="";

SearchText = parameters.SEARCH_STRING?: "*";
//分类
categoryId = parameters.SEARCH_CATEGORY_ID ?: (request.getAttribute("optProductCategoryId") ?: request.getAttribute("productCategoryId") ?: (parameters.category_id ?: parameters.CATEGORY_ID ?: ""));
productStoreId = parameters.productStoreId?:null;
//附加分类
affixCategoryId = (request.getAttribute("optAffixProductCategoryId") ?: request.getParameter("affixProductCategoryId") ?:request.getAttribute("affixProductCategoryId") ?: (parameters.affix_category_id ?: parameters.AFFIX_CATEGORY_ID ?: ""));

queryLine += " text:"+SearchText+"";
if(UtilValidate.isNotEmpty(categoryId) && !"all".equals(categoryId)){
	queryLine += " AND cat:*"+categoryId+"*";
}

if(UtilValidate.isNotEmpty(affixCategoryId) && !"all".equals(affixCategoryId)){
	queryLine += " AND cat:*"+affixCategoryId+"*";
}

if(productStoreId){
	queryLine += " AND primaryProductStoreId:"+productStoreId+"";
}


orderByName = parameters.orderByName?: "";
sortByReverse = parameters.sortByReverse?: "false";
bSortByReverse = false;
if("true".equals(sortByReverse)){
	bSortByReverse = true;
}

println "-----affixCategoryId------"+affixCategoryId;

Debug.log("queryLine="+queryLine, "KeywordSearchSolr.groovy");

if(queryLine && queryLine.length() >0){
	queryContext =[query:queryLine, viewSize:viewSize, viewIndex:viewIndex, queryFilter:null,sortBy:orderByName,sortByReverse:bSortByReverse,returnFields:null,facetQuery:null];
	Debug.log("queryContext="+queryContext);
	queryResult = dispatcher.runSync("solrKeywordSearch", queryContext);
	context.productIds = queryResult.productIds;
	digViewIndex = queryResult.viewIndex;
	digViewSize = queryResult.viewSize;
	context.viewIndex = digViewIndex;
	context.viewSize = digViewSize;
	context.listSize = queryResult.listSize;
	
	context.lowIndex = digViewIndex * digViewSize;
	context.highIndex = (digViewIndex + 1) * digViewSize;
	context.facetFields = queryResult.facetFields;
}