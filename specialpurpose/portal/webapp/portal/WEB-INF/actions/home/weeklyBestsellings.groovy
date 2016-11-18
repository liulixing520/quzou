
import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.EntityUtil;

productCategoryId = parameters.productCategoryId?:request.getAttribute("productCategoryId");

weeklyCategoryMembers = delegator.findList("ProductCategoryMember", EntityCondition.makeCondition("productCategoryId", EntityOperator.EQUALS, productCategoryId), null, null, null, false);

weeklyCategoryMembers = EntityUtil.filterByDate(weeklyCategoryMembers);

context.weeklyCategoryMembers = weeklyCategoryMembers;
