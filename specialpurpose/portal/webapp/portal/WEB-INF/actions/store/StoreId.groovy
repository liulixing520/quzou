
import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.product.catalog.*;
import org.ofbiz.ebiz.product.*;

categoryId = parameters.SEARCH_CATEGORY_ID ?: (request.getAttribute("optProductStoreId") ?: request.getAttribute("productCategoryId") ?: (parameters.category_id ?: parameters.CATEGORY_ID ?: ""));
context.productCategoryId = categoryId;



