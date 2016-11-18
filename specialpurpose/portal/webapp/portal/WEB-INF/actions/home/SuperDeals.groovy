
import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.*;
import org.ofbiz.service.*;
import org.ofbiz.product.catalog.*;
import org.ofbiz.product.category.CategoryContentWrapper;
import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.product.feature.*;






//productCategoryId = request.getAttribute("productCategoryId");
productCategoryId = "SUPER_DEALS";
context.productCategoryId = productCategoryId;

viewSize = parameters.VIEW_SIZE?:"20";
viewIndex = parameters.VIEW_INDEX?:"0";
currentCatalogId = CatalogWorker.getCurrentCatalogId(request);

// set the default view size
defaultViewSize = request.getAttribute("defaultViewSize") ?: UtilProperties.getPropertyValue("widget", "widget.form.defaultViewSize", "20");
context.defaultViewSize = defaultViewSize;
// set the limit view
limitView = request.getAttribute("limitView") ?: true;
context.limitView = limitView;



// get the product category & members
andMap = [productCategoryId : productCategoryId,
        viewIndexString : viewIndex,
        viewSizeString : viewSize,
        defaultViewSize : Integer.parseInt(defaultViewSize),
        limitView : limitView];
andMap.put("prodCatalogId", currentCatalogId);
andMap.put("checkViewAllow", true);
if (context.orderByFields) {
    andMap.put("orderByFields", context.orderByFields);
} else {
    andMap.put("orderByFields", ["sequenceNum", "productId"]);
}
catResult = dispatcher.runSync("getProductCategoryAndLimitedMembers", andMap);

productCategory = catResult.productCategory;
productCategoryMembers = catResult.productCategoryMembers;

weeklyCategoryMembers = delegator.findList("ProductCategoryMember", EntityCondition.makeCondition("productCategoryId", EntityOperator.EQUALS, "SUPER_DEALS"), null, null, null, false);

weeklyCategoryMembers = EntityUtil.filterByDate(weeklyCategoryMembers);

context.weeklyCategoryMembers = catResult.productCategoryMembers;

//digViewIndex = catResult.viewIndex;
//digViewSize = catResult.viewSize;
//context.viewIndex = digViewIndex;
//context.viewSize = digViewSize;
//context.listSize = catResult.listSize;
//
//context.lowIndex = digViewIndex * digViewSize;
//context.highIndex = (digViewIndex + 1) * digViewSize;
//context.facetFields = catResult.facetFields;



context.viewIndex = catResult.viewIndex;
context.viewSize = catResult.viewSize;
context.lowIndex = catResult.lowIndex;
context.highIndex = catResult.highIndex;
context.listSize = catResult.listSize;
