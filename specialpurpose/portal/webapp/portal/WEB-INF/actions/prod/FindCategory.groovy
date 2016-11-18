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
completedTree = FastList.newInstance();
void separateRootType(roots,level,catCodeL) {
    if(roots) {
		level++;
        roots.each { root ->
	        catCodeL1= catCodeL + root.productCategoryId;
            prodCateMap = FastMap.newInstance();
			prodCateMap.put("productCategory", root);
			prodCateMap.put("lev", level);
			prodCateMap.put("catCode", catCodeL1);
			productCategorys = delegator.findByAnd("ProdCatalogCategoryView" ,UtilMisc.toMap("primaryParentCategoryId",root.productCategoryId), ["sequenceNum ASC"]);
			if (productCategorys) {prodCateMap.put("childCount", productCategorys.size());}else prodCateMap.put("childCount", 0);
            completedTree.add(prodCateMap);
			if (productCategorys) {
				separateRootType(productCategorys,level,catCodeL1);
			}
        }
    }
}
try{
	categoryAndExprs = FastList.newInstance();
	categoryAndExprs.add(EntityCondition.makeCondition("primaryParentCategoryId", EntityOperator.EQUALS, null));
	categoryAndExprs.add(EntityCondition.makeCondition("prodCatalogId", EntityOperator.EQUALS, "ProductCategory"));
	prodCategoryList = delegator.find("ProdCatalogCategoryView", EntityCondition.makeCondition(categoryAndExprs, EntityOperator.AND), null, null, ["sequenceNum ASC"], null);
	while ((prodCategory = prodCategoryList.next())) {
		lev = 1;
	    prodCatalogMap = FastMap.newInstance();
	    productCategoryId = prodCategory.productCategoryId;
	    prodCatalogMap.put("productCategory", prodCategory);
	    prodCatalogMap.put("lev", lev);
	    prodCatalogMap.put("catCode", productCategoryId);
	    prodCatalogCategories = delegator.findByAnd("ProdCatalogCategoryView", ["primaryParentCategoryId" : productCategoryId], ["sequenceNum ASC"]);
	    if (prodCatalogCategories) {prodCatalogMap.put("childCount", prodCatalogCategories.size());}else prodCatalogMap.put("childCount", 0);
	    completedTree.add(prodCatalogMap);
	    if (prodCatalogCategories) {
	    	separateRootType(prodCatalogCategories,lev,productCategoryId);
	    }
	}
}catch(Exception e){
	
}
finally{
	
	prodCategoryList.close();
}
// The complete tree list for the category tree
context.productCategoryList = completedTree;