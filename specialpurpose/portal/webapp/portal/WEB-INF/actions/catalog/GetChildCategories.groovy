import javolution.util.FastSet
import org.ofbiz.entity.condition.EntityCondition
import org.ofbiz.entity.util.EntityUtil;

import org.ofbiz.base.util.*;
import org.ofbiz.product.catalog.*;
import org.ofbiz.product.category.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import org.ofbiz.entity.*
import org.ofbiz.product.product.ProductSearch
import org.ofbiz.product.product.ProductSearchSession;


/*List fillTree(rootCat ,CatLvl, parentCategoryId) {
    if(rootCat) {
        rootCat.sort{ it.productCategoryId }
        def listTree = FastList.newInstance();
        for(root in rootCat) {
            preCatChilds = delegator.findByAnd("ProductCategoryRollup", ["parentProductCategoryId": root.productCategoryId], null, false);
            catChilds = EntityUtil.getRelated("CurrentProductCategory",null,preCatChilds,false);
            def childList = FastList.newInstance();

            // CatLvl uses for identify the Category level for display different css class
            if(catChilds) {
                if(CatLvl==2)
                    childList = fillTree(catChilds,CatLvl+1, parentCategoryId.replaceAll("/", "")+'/'+root.productCategoryId);
                // replaceAll and '/' uses for fix bug in the breadcrum for href of category
                else if(CatLvl==1)
                    childList = fillTree(catChilds,CatLvl+1, parentCategoryId.replaceAll("/", "")+root.productCategoryId);
                else
                    childList = fillTree(catChilds,CatLvl+1, parentCategoryId+'/'+root.productCategoryId);
            }

            productsInCat  = delegator.findByAnd("ProductCategoryAndMember", ["productCategoryId": root.productCategoryId], null, false);

            // Display the category if this category containing products or contain the category that's containing products
            if(productsInCat || childList) {
                def rootMap = FastMap.newInstance();
                category = delegator.findOne("ProductCategory", ["productCategoryId": root.productCategoryId], false);
                categoryContentWrapper = new CategoryContentWrapper(category, request);
                context.title = categoryContentWrapper.CATEGORY_NAME;
                categoryDescription = categoryContentWrapper.DESCRIPTION;

                if(categoryContentWrapper.CATEGORY_NAME)
                    rootMap["categoryName"] = categoryContentWrapper.CATEGORY_NAME;
                else
                    rootMap["categoryName"] = root.categoryName;

                if(categoryContentWrapper.DESCRIPTION)
                    rootMap["categoryDescription"] = categoryContentWrapper.DESCRIPTION;
                else
                    rootMap["categoryDescription"] = root.description;

                rootMap["productCategoryId"] = root.productCategoryId;
                rootMap["parentCategoryId"] = parentCategoryId;
                rootMap["child"] = childList;

                listTree.add(rootMap);
            }
        }
        return listTree;
    }
}

CategoryWorker.getRelatedCategories(request, "topLevelList", CatalogWorker.getCatalogTopCategoryId(request, EbizCatalogWorker.getNavMenuCatalogId(request)), true);
curCategoryId = parameters.category_id ?: parameters.CATEGORY_ID ?: "";
request.setAttribute("curCategoryId", curCategoryId);
CategoryWorker.setTrail(request, curCategoryId);

categoryList = request.getAttribute("topLevelList");
if (categoryList) {
    catContentWrappers = FastMap.newInstance();
    CategoryWorker.getCategoryContentWrappers(catContentWrappers, categoryList, request);
    context.catContentWrappers = catContentWrappers;
    completedTree = fillTree(categoryList,1,"");
    context.completedTree = completedTree;
}*/

productCategoryId = request.getAttribute("productCategoryId")

List getParentCategoryList(def productCatetoryId){
    List parentCategoryList = FastList.newInstance();
    String parentProductCategoryId = productCategoryId;
    while (UtilValidate.isNotEmpty(parentProductCategoryId)) {
        try {
            productCategoryRollups = delegator.findByAnd("ProductCategoryRollup", [productCategoryId: productCategoryId], null, false);
            if (UtilValidate.isNotEmpty(productCategoryRollups)) {
                for (GenericValue productCategoryRollup : productCategoryRollups) {
                    parentCategory = delegator.findOne("ProductCategory", [productCategoryId : categoryRollup.parentProductCategoryId], true);
                    if(parentCategory){
                        parentProductCategoryId = parentCategory.productCategoryId
                        parentCategoryList.add(parentCategory);
                    }else{
                        parentProductCategoryId = null;
                    }
                }
            } else {
                parentProductCategoryId = null;
            }
        } catch (GenericEntityException e) {
            Debug.logError(e, "Cannot get parent category", module);
        }
    }
}

//println "------------------------------" + getParentCategoryList

productCategoryRollups = delegator.findByAnd("ProductCategoryRollup", [productCategoryId: productCategoryId], null, false);
productCategoryRollups = EntityUtil.filterByDate(productCategoryRollups);
if(productCategoryRollups){
    for (GenericValue categoryRollup : productCategoryRollups) {
        parentCategory = delegator.findOne("ProductCategory", [productCategoryId : categoryRollup.parentProductCategoryId], true);
        if(parentCategory && parentCategory.productCategoryTypeId == "CATALOG_CATEGORY"){
            context.parentCategory = parentCategory
            context.parentCategoryName = parentCategory.categoryName
            context.parentCategoryId = parentCategory.productCategoryId
        }
    }
}
categoryCount = ProductSearchSession.getCountForProductCategory(productCategoryId, session, delegator);
println "----------------------------" + categoryCount

category = delegator.findOne("ProductCategory", [productCategoryId : productCategoryId], true);
if(category){
    categoryContentWrapper = new CategoryContentWrapper(category, request);
    context.productCategoryId = productCategoryId
    context.catalogName = categoryContentWrapper.CATEGORY_NAME
}
