import java.util.List;

import javolution.util.FastList;

import org.ofbiz.base.util.UtilGenerics;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.condition.EntityCon
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityFindOptions;
import org.ofbiz.entity.util.EntityListIterator;

productCategoryId = requestAttributes.optProductCategoryId;

List<String> orderByFields = UtilMisc.toList(request.getParameter("orderByFields"));
if (orderByFields == null) orderByFields = FastList.newInstance();

int defaultViewSize = 4;
int viewIndex = 0;
try {
	viewIndex = Integer.valueOf((String) context.get("viewIndexString")).intValue();
} catch (Exception e) {
	viewIndex = 0;
}

int viewSize = defaultViewSize;
try {
	viewSize = Integer.valueOf((String) context.get("viewSizeString")).intValue();
} catch (Exception e) {
	viewSize = defaultViewSize;
}

int listSize = 0;
int lowIndex = 0;
int highIndex = 0;

if (limitView) {
	// get the indexes for the partial list
	lowIndex = ((viewIndex * viewSize) + 1);
	highIndex = (viewIndex + 1) * viewSize;
} else {
	lowIndex = 0;
	highIndex = 0;
}

List<EntityCondition> mainCondList = FastList.newInstance();
mainCondList.add(EntityCondition.makeCondition("productCategoryId", EntityOperator.EQUALS, productCategoryId));
mainCondList.add(EntityCondition.makeCondition("productStoreId", EntityOperator.EQUALS, productStoreId));
EntityCondition mainCond = EntityCondition.makeCondition(mainCondList, EntityOperator.AND);

// set distinct on
EntityFindOptions findOpts = new EntityFindOptions(true, EntityFindOptions.TYPE_SCROLL_INSENSITIVE, EntityFindOptions.CONCUR_READ_ONLY, false);
findOpts.setMaxRows(highIndex);
// using list iterator
EntityListIterator pli = delegator.find("ProductAndCategoryMember", mainCond, null, null, orderByFields, findOpts);

productCategoryMembers = pli.getPartialList(lowIndex, viewSize);

							listSize = pli.getResultsSizeAfterPartialList();
							
context.productCategoryMembers = productCategoryMembers;							