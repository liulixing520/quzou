
import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;
import org.ofbiz.product.catalog.*;
import org.ofbiz.product.category.*;
import java.util.HashMap;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;
if(userLogin){
	if(UtilValidate.isNotEmpty(parameters.productStoreId)){
			Map<String, Object> roleContextMap = new HashMap<String, Object>();
			roleContextMap.put("userLogin", userLogin);
			roleContextMap.put("partyId", userLogin.partyId);
			roleContextMap.put("roleTypeId", "AGENT");
			roleContextMap.put("productStoreId", parameters.productStoreId);
			pService = dispatcher.getDispatchContext().getModelService("createProductStoreRole");
			roleContextMap = pService.makeValid(roleContextMap, ModelService.IN_PARAM);
			result = dispatcher.runSync(pService.name, roleContextMap);
		}
}