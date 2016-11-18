import org.ofbiz.base.util.*;

productCategoryId = request.getAttribute("optProductCategoryId");

optCurrentCategory = delegator.findOne("ProductCategory", UtilMisc.toMap("productCategoryId", productCategoryId), true);

context.optCurrentCategory = optCurrentCategory;