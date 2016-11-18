/*
/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

/*
 * This script is also referenced by the ecommerce's screens and
 * should not contain order component's specific code.
 */

import java.util.Map;

import org.ofbiz.base.util.*;
import org.ofbiz.product.catalog.*;
import org.ofbiz.product.feature.*;
import org.ofbiz.product.product.*;
import java.lang.Math;
import javolution.util.*;

import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;

module = "KeywordSearchSolr.groovy";

paramMap = UtilHttp.getParameterMap(request);

viewSize = parameters.VIEW_SIZE?:"10";
viewIndex = parameters.VIEW_INDEX?:"1";


queryLine ="";

//关键词
SearchText = parameters.SearchText?:parameters.SEARCH_STRING?: "*";
queryLine += " -isVariant:true";
if(SearchText && !"*".equals(SearchText)){
	queryLine +=" AND (text:"+SearchText+" OR text_zh:"+SearchText+" OR text_ru:"+SearchText+") ";
}

// 获取用户所属小区进行过滤
if(userLogin) {
	party = userLogin.getRelatedOne("Party", false);
	if ("PERSON".equals(party.partyTypeId)) {
		person = delegator.findOne("Person", [partyId : party.partyId], false);
		if(UtilValidate.isNotEmpty(person) && UtilValidate.isNotEmpty(person.geoId)){
				queryLine += " AND saleAreas:*" + person.geoId + "* ";
		}else{
			//queryLine += " AND saleAreas:NONE "
		}
	}else{
		//queryLine += " AND saleAreas:NONE "
	}
}

//分类，附加分类
categoryId = request.getAttribute("optProductCategoryId")?: ( parameters.SEARCH_CATEGORY_ID ?: request.getAttribute("productCategoryId") ?: (parameters.category_id ?: parameters.CATEGORY_ID ?: ""));
affixCategoryId = (request.getAttribute("optAffixProductCategoryId") ?: request.getParameter("affixProductCategoryId") ?:request.getAttribute("affixProductCategoryId") ?: (parameters.affix_category_id ?: parameters.AFFIX_CATEGORY_ID ?: ""));
if(UtilValidate.isNotEmpty(categoryId) && !"all".equals(categoryId)){
	queryLine += " AND cat:*"+categoryId+"* ";
}
if(UtilValidate.isNotEmpty(affixCategoryId) && !"all".equals(affixCategoryId)){
	queryLine += " AND cat:*"+affixCategoryId+"* ";
}
//产品特征
productFeatureId=null;
prodFeatureParamsMap = UtilHttp.makeParamMapWithPrefix(request,"productFeatureId_",null);
if(UtilValidate.isNotEmpty(productFeatureId) && !"all".equals(productFeatureId)){
	queryLine += " AND productFeatures:*featureId="+productFeatureId+"* ";
}
if(prodFeatureParamsMap){
	for (Map.Entry<String, Object> entry: prodFeatureParamsMap.entrySet()) {
		String prodFeatureTypeId = entry.getKey();
		String prodFeatureId = (String) entry.getValue();
		queryLine += " AND productFeatures:*featureId="+prodFeatureId+"* ";
	}
}

//价格区间
minPrice = paramMap.minPrice?paramMap.minPrice.toString():null;
maxPrice = paramMap.maxPrice?paramMap.maxPrice.toString():null;
context.minPrice = minPrice;
context.maxPrice = maxPrice;
if(maxPrice||minPrice){
	maxPrice = maxPrice!=null?maxPrice:"*";
	minPrice = minPrice!=null?minPrice:"*";
	keyword += " AND defaultPrice:["+minPrice+" TO "+maxPrice+"] ";
}

//所属店铺
productStoreId = request.getAttribute("optProductStoreId")?: parameters.productStoreId?:null;
excludeProductStoreId = request.getAttribute("optExcludeProductStoreId")?: parameters.excludeProductStoreId?:null;

if(productStoreId){
	if(!excludeProductStoreId || !excludeProductStoreId.equals(productStoreId)){
		queryLine += " AND primaryProductStoreId:"+productStoreId+" ";
	}
}
if(excludeProductStoreId){
	queryLine += " NOT primaryProductStoreId:"+excludeProductStoreId+" ";
}

/**
 * 排序
 * totalQuantityOrdered 销量
 * introductionDate 上架时间
 * defaultPrice 价格
 */
orderByName = parameters.orderByName?: "";
sortByReverse = parameters.sortByReverse?: "false";
bSortByReverse = false;
if(sortByReverse==true || "true".equals(sortByReverse)){
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
	digListSize = queryResult.listSize;
	context.viewIndex = digViewIndex;
	context.viewSize = digViewSize;
	context.listSize = digListSize;
	
	totalPage = 1;
	
	if(digViewSize>0){
		totalPage = Math.ceil( digListSize / digViewSize) ;
	}
	context.totalPage = totalPage;
	
	context.lowIndex = digViewIndex * digViewSize;
	context.highIndex = (digViewIndex + 1) * digViewSize;
	context.facetFields = queryResult.facetFields;
	
	
	println "product=================================产品ID    =     "+queryResult.productIds
/*	for(String productId:queryResult.productIds){
		List productAttributes = delegator.findOne("ProductAttribute",[productId:productId],true);
	}
	context.productAttributes = productAttributes;*/
}


if(parameters.getProductStoreIds == true){
	productStoreIdMap = FastMap.newInstance();
	for(String productId:context.productIds){
		product = delegator.findOne("Product",[productId:productId],true);
		if(UtilValidate.isNotEmpty(product.getString("primaryProductStoreId"))){
			productStoreIdMap.put(product.getString("primaryProductStoreId"), productId)
		}
		
	}
	productStoreIds = productStoreIdMap.keySet();
	context.productStoreIds = productStoreIds;
	println "productStoreIds===============================产品分类ID   =     "+productStoreIds
	Debug.log("productStoreIds="+productStoreIds, module);
}


condList = FastList.newInstance();
condImgTwoList = FastList.newInstance();
condList.add(EntityCondition.makeCondition("status", EntityOperator.EQUALS, "0"));
condList.add(EntityCondition.makeCondition("gradingType", EntityOperator.EQUALS, "2"));
condList.add(EntityCondition.makeCondition("advertisingPosition", EntityOperator.EQUALS, "1"));
pagesetterCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
PageSetterList = delegator.findList("PageSetting", pagesetterCond, null,null, null, false);
context.PageSetterList = PageSetterList;
println context.PageSetterList;

condImgTwoList.add(EntityCondition.makeCondition("status", EntityOperator.EQUALS, "0"));
condImgTwoList.add(EntityCondition.makeCondition("gradingType", EntityOperator.EQUALS, "2"));
condImgTwoList.add(EntityCondition.makeCondition("advertisingPosition", EntityOperator.EQUALS, "2"));
pagesetterTwoCond = EntityCondition.makeCondition(condImgTwoList, EntityOperator.AND);
PageSetterTwoList = delegator.findList("PageSetting", pagesetterTwoCond, null,null, null, false);
context.PageSetterTwoList = PageSetterTwoList;
println context.PageSetterTwoList;


