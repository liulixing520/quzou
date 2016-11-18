import org.ofbiz.product.catalog.*;
import org.ofbiz.product.category.*;

CategoryWorker.getRelatedCategories(request, "topLevelList", CatalogWorker.getCatalogTopCategoryId(request, EbizCatalogWorker.getNavMenuCatalogId(request)), true);

categoryList = request.getAttribute("topLevelList");

context.categoryList = categoryList;