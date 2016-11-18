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
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastMap;
import javolution.util.FastList;
import org.ofbiz.entity.condition.*;
import org.ofbiz.base.util.UtilMisc;
// Put the result of CategoryWorker.getRelatedCategories into the separateRootType function as attribute.
// The separateRootType function will return the list of category of given catalog.
// PLEASE NOTE : The structure of the list of separateRootType function is according to the JSON_DATA plugin of the jsTree.

List separateRootType(roots) {
    if(roots) {
        prodRootTypeTree = [];
        roots.each { root ->
            prodCateMap = [:];
            productCategory = delegator.findByPrimaryKey("ProductCategory" ,UtilMisc.toMap("productCategoryId",root.productCategoryId));
            prodCateMap.productCategoryId = productCategory.getString("productCategoryId");
            prodCateMap.categoryName = productCategory.getString("categoryName");
            prodCateMap.isCatalog = false;
            prodCateMap.isCategoryType = true;
            prodRootTypeTree.add(prodCateMap);
        }
        return prodRootTypeTree;
    }
}

completedTree =  [];
EntityCondition condition = EntityCondition.makeCondition("primaryParentCategoryId", EntityOperator.EQUALS, null);
prodCategoryList = delegator.find("ProductCategory", condition, null, null, null, null);
while ((prodCategory = prodCategoryList.next())) {
		ProdCatalogs = EntityUtil.filterByDate(delegator.findByAnd("ProdCatalogCategory", ["prodCatalogId" : "NavMenuCatalog","productCategoryId" : prodCategory.productCategoryId]));
        if(ProdCatalogs.size()>0){
	        prodCatalogMap = FastMap.newInstance();
	        productCategoryId = prodCategory.productCategoryId;
	        prodCatalogMap.put("productCategoryId", productCategoryId);
	        prodCatalogMap.put("categoryName", prodCategory.categoryName);
	        prodCatalogMap.put("isCatalog", false);
	        prodCatalogMap.put("isCategoryType", true);
	        prodCatalogCategories = EntityUtil.filterByDate(delegator.findByAnd("ProductCategoryRollup", ["parentProductCategoryId" : prodCategory.productCategoryId]));
	        if (prodCatalogCategories) {
	            prodCatalogMap.child = separateRootType(prodCatalogCategories);
	        }
	        completedTree.add(prodCatalogMap);
        }
}
prodCategoryList.close();
// The complete tree list for the category tree
context.completedTree = completedTree;
System.out.println("****"+completedTree);
stillInCatalogManager = true;
productCategoryId = null;
prodCatalogId = null;
showProductCategoryId = null;

// Reset tree condition check. Are we still in the Catalog Manager ?. If not , then reset the tree.
if ((parameters.productCategoryId != null) || (parameters.showProductCategoryId != null)) {
    stillInCatalogManager = false;
    productCategoryId = parameters.productCategoryId;
    showProductCategoryId = parameters.showProductCategoryId;
} else if (parameters.prodCatalogId != null) {
    stillInCatalogManager = false;
    prodCatalogId = parameters.prodCatalogId;
}
context.stillInCatalogManager = stillInCatalogManager;
context.productCategoryId = productCategoryId;
context.prodCatalogId = prodCatalogId;
context.showProductCategoryId = showProductCategoryId;

