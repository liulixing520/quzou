package org.ofbiz.order.shoppinglist;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;

public class ShoppingListLookupServices {

	/**
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> findFavoriteStore(DispatchContext dctx, Map<String, ? extends Object> context) {
		LocalDispatcher dispatcher = dctx.getDispatcher();
        Delegator delegator = dctx.getDelegator();

        GenericValue userLogin = (GenericValue) context.get("userLogin");
        Locale locale = (Locale) context.get("locale");
		
		Map<String, String> inputFields = FastMap.newInstance();
		
		List<Map<String, Object>> tempResults = FastList.newInstance();
		Map<String, Object> result = null;
		try {
			result = dispatcher.runSync("performFindList", UtilMisc.<String, Object>toMap("entityName", "ShoppingList"
			        ,"inputFields", inputFields, "userLogin", userLogin));
		} catch (GenericServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Map retResult = ServiceUtil.returnSuccess();
		
		return retResult;
	}
}
