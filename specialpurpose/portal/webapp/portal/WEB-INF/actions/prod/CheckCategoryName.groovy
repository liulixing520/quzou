import java.util.*;
import javolution.util.FastMap;

import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.*;

productCategoryId = parameters.get("productCategoryId");
categoryName = parameters.get("categoryName");
List<EntityCondition> conditions = FastList.newInstance();
if(categoryName){
	conditions.add(EntityCondition.makeCondition("categoryName", EntityOperator.EQUALS, categoryName));
}
if(productCategoryId){
	conditions.add(EntityCondition.makeCondition("productCategoryId", EntityOperator.NOT_EQUAL, productCategoryId));
}
productCategorys = delegator.findList("ProductCategory", EntityCondition.makeCondition(conditions, EntityOperator.AND), null, null, null, false);

if(UtilValidate.isNotEmpty(productCategorys) && productCategorys.size()>0){
	request.setAttribute("result","error");
}
else{
	request.setAttribute("result","success");
}