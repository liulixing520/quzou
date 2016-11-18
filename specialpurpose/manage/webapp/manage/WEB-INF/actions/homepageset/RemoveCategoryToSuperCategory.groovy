import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.*;


productId = parameters.productId;

if(productId){
	println "-----------------"+productId
	delegator.removeByAnd("ProductCategoryMember",UtilMisc.toMap("productCategoryId",'SUPER_DEALS',"productId",productId));
	return "success";
}

	