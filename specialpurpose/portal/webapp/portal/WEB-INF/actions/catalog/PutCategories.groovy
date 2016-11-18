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

import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.product.catalog.*;

import org.ofbiz.ebiz.product.*;

import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.EntityFindOptions;
import java.util.List;

def list=[];
//productCategoryRoleId = parameters.putcategorys?:request.getAttribute("putcategorys");
//preCatChilds = delegator.findByAnd("ProductCategoryRollup", ["parentProductCategoryId": productCategoryRoleId], null, false);
	condList = FastList.newInstance();
	condList.add(EntityCondition.makeCondition("status", EntityOperator.EQUALS,"0"));
    productCategoryCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
    RecommendCategoryList = delegator.findList("RecommendedCategory", productCategoryCond, null,null, null, false);
	context.RecommendCategoryList = RecommendCategoryList;

if(RecommendCategoryList){
	 for(pcr in RecommendCategoryList) {	
		 category = delegator.findOne("ProductCategory", ["productCategoryId": pcr.productCategoryId], true);
		 if(category){
			 def map=[:];
			 map.parentCategory=category;
			 categorys = delegator.findByAnd("ProductCategory", ["primaryParentCategoryId": category.productCategoryId], null, false);
			 if(categorys){
				 map.categoryList=categorys[0..2]; 
			 }
			 list.add(map);
		 }
		 
	 }
}
context.list=list;
/*if(preCatChilds){
	 for(pcr in preCatChilds) {	
		 category = delegator.findOne("ProductCategory", ["productCategoryId": pcr.productCategoryId], true);
		 if(category){
			 def map=[:];
			 map.parentCategory=category;
			 categorys = delegator.findByAnd("ProductCategory", ["primaryParentCategoryId": category.productCategoryId], null, false);
			 if(categorys){
				 map.categoryList=categorys[0..2]; 
			 }
			 list.add(map);
		 }
		 
	 }
}
context.list=list;*/
/*detailScreen = "categorydetail";
catalogName = CatalogWorker.getCatalogName(request);

productCategoryId = request.getAttribute("productCategoryId") ?: parameters.category_id;
context.productCategoryId = productCategoryId;

context.productStore = ProductStoreWorker.getProductStore(request);

pageTitle = null;
metaDescription = null;
metaKeywords = null;*/

/* NOTE DEJ20070220: this is a weird way to do this and caused unacceptable side effects as described in the related
 * comment in the Main.groovy file
 *
 * NOTE JLR 20070221 this should be done using the same method than in add to cart. I will do it like that and remove all this after.
 *
if (productCategoryId) {
    session.setAttribute("productCategoryId", productCategoryId);// for language change
    previousParams = session.getAttribute("_PREVIOUS_PARAMS_");
    if (previousParams) {
        previousParams = UtilHttp.stripNamedParamsFromQueryString(previousParams, ["category_id"]);
        previousParams += "&category_id=" + productCategoryId;
    } else {
        previousParams = "category_id=" + productCategoryId;
    }
    session.setAttribute("_PREVIOUS_PARAMS_", previousParams);    // for login
    context.previousParams = previousParams;
}
 */

/*category = delegator.findOne("ProductCategory", [productCategoryId : productCategoryId], true);
if (category) {
    if (category.detailScreen) {
        detailScreen = category.detailScreen;
    }
    categoryPageTitle = delegator.findByAnd("ProductCategoryContentAndInfo", [productCategoryId : productCategoryId, prodCatContentTypeId : "PAGE_TITLE"], null, true);
    if (categoryPageTitle) {
        pageTitle = delegator.findOne("ElectronicText", [dataResourceId : categoryPageTitle.get(0).dataResourceId], true);
    }
    categoryMetaDescription = delegator.findByAnd("ProductCategoryContentAndInfo", [productCategoryId : productCategoryId, prodCatContentTypeId : "META_DESCRIPTION"], null, true);
    if (categoryMetaDescription) {
        metaDescription = delegator.findOne("ElectronicText", [dataResourceId : categoryMetaDescription.get(0).dataResourceId], true);
    }
    categoryMetaKeywords = delegator.findByAnd("ProductCategoryContentAndInfo", [productCategoryId : productCategoryId, prodCatContentTypeId : "META_KEYWORD"], null, true);
    if (categoryMetaKeywords) {
        metaKeywords = delegator.findOne("ElectronicText", [dataResourceId : categoryMetaKeywords.get(0).dataResourceId], true);
    }
    categoryContentWrapper = new CategoryContentWrapper(category, request);
	context.put("categoryContentWrapper", categoryContentWrapper);
    categoryDescription = categoryContentWrapper.DESCRIPTION;

    if (pageTitle) {
        context.title = pageTitle.textData;
    } else {
        context.title = categoryContentWrapper.CATEGORY_NAME;
    }

    if (metaDescription) {
        context.metaDescription = metaDescription.textData;
    } else {
        if (categoryDescription) {
            context.metaDescription = categoryDescription;
        }
    }

    if (metaKeywords) {
        context.metaKeywords = metaKeywords.textData;
    } else {
        if (categoryDescription) {
            context.metaKeywords = categoryDescription + ", " + catalogName;
        } else {
            context.metaKeywords = catalogName;
        }
    }
    context.productCategory = category;
}*/

// check the catalogs template path and update
/*templatePathPrefix = CatalogWorker.getTemplatePathPrefix(request);
if (templatePathPrefix) {
    detailScreen = templatePathPrefix + detailScreen;
}
context.detailScreen = detailScreen;

catLevel = CategoryLevelWorker.getCatLevel(request, null, productCategoryId);

if(catLevel>=3){
	context.detailScreen = "category-include-third";
}
//request.setAttribute("productCategoryId", productCategoryId);
request.setAttribute("defaultViewSize", 10);
request.setAttribute("limitView", true);*/
