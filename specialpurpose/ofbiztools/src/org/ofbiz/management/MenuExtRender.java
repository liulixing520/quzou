package org.ofbiz.management;





import java.util.List;
import java.util.Map;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.security.Security;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;


public class MenuExtRender {

	
	private static String module = MenuExtRender.class.getName();
	
	
	
		
//		public static List getWorkBenchMenus(HttpServletRequest request, HttpServletResponse response) {
//			List result =FastList.newInstance();
//			
//			Delegator delegator = (Delegator) request.getAttribute("delegator");
//			Security security = (Security) request.getAttribute("security");
//			GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
//			
//			try {
//				if(null == security){
//					security = SecurityFactory.getInstance(delegator);
//					request.setAttribute("security", security);
//				}
//				
//				List<GenericValue> categoryList = delegator.findByAnd("GlobalTreeItem", UtilMisc.toMap("isLeaf", "CATEGORY","parentItemId","ROOT_GBSM"), UtilMisc.toList("rank"));
//				
//				for(GenericValue gv1:categoryList){
//					String permission = gv1.getString("itemPermission");
//					if(security.hasPermission(permission, userLogin)){
//						Map newMap = FastMap.newInstance();
//						newMap.putAll(gv1);
//						List newList2 = getChildItem2List(gv1, security, userLogin, delegator);
//						newMap.put("childItemList", newList2);
//						result.add(newMap);
//					}
//				}	
//			} catch (GenericEntityException e) {
//				Debug.logError(e,e.getMessage(), module);
//				
//			} catch (SecurityConfigurationException e) {
//				Debug.logError(e,e.getMessage(), module);
//			}
//	       
//	        return result;
//	    }
//		
//
//		private static List getChildItem2List(GenericValue gv, Security security, GenericValue userLogin, Delegator delegator) throws GenericEntityException{
//			List newList = FastList.newInstance();
//			
//			List<GenericValue> childItemList = delegator.findByAnd("GlobalTreeItem", 
//					UtilMisc.toMap("parentItemId", gv.get("id")),
//					UtilMisc.toList("rank"));
//			
//			for(GenericValue childItem:childItemList){
//				String permission =childItem.getString("itemPermission");
//		       	if(security.hasPermission(permission, userLogin)){
//		       		//newList.add(childItem);
//		       		Map newMap = FastMap.newInstance();
//					newMap.putAll(childItem);
//					List newList2 = getChildItem2List(childItem, security, userLogin, delegator);
//					newMap.put("childItemList", newList2);
//					newList.add(newMap);
//				}	
//			}
//
//			return newList;
//
//		}
		

		public static Map<String, Object> getGlobalTreeItemMenu(DispatchContext dctx, Map<String, ? extends Object> context) {
		  	  Map result = ServiceUtil.returnSuccess();

		  	  LocalDispatcher dispatcher = dctx.getDispatcher();
		        Delegator delegator = dctx.getDelegator();
		        GenericValue userLogin = (GenericValue) context.get("userLogin");
		        Security security = dctx.getSecurity();
		        String parentItemId = (String)context.get("parentItemId");
		        
		        List productCategoryList = FastList.newInstance();
				try {
					
					List<GenericValue> itemList = delegator.findByAnd("GlobalTreeItem", UtilMisc.toMap("isLeaf", "CATEGORY","parentItemId", parentItemId), UtilMisc.toList("rank"));
					
					
					List list = FastList.newInstance();
					for(GenericValue item: itemList){
						Map childMap = getChildGlobalTreeItem(delegator,item);
						list.add(childMap);
					}
					result.put("childList", list);
			        return result;
				} catch (GenericEntityException e) {
					 Debug.logError(e, module);
					 return ServiceUtil.returnError(e.getMessage());
				
				}
		  }
			private static Map getChildGlobalTreeItem(Delegator delegator,GenericValue gv) throws GenericEntityException {
				Map result = FastMap.newInstance();

				result.putAll(gv);
				List list = FastList.newInstance();
				List<GenericValue> itemList = delegator.findByAnd("GlobalTreeItem", UtilMisc.toMap("parentItemId", gv.getString("id")), UtilMisc.toList("rank"));
				for (GenericValue item : itemList) {
					//Debug.log("item.Id=========="+item.getString("id"));
					Map childMap = getChildGlobalTreeItem(delegator,item);
					list.add(childMap);
				}
				result.put("childList", list);
				return result;
			}
		
//		public static Map<String, Object> getChildItemListByAjax(DispatchContext dctx,Map context) throws GenericEntityException {
//			Security security = dctx.getSecurity();
//			Delegator delegator = dctx.getDelegator();
//			GenericValue userLogin = (GenericValue) context.get("userLogin");
//
//			String id= (String) context.get("id");
//			Map result = FastMap.newInstance();
//	        List newList = FastList.newInstance();
//			
//	        List<GenericValue> oldList = delegator.findByAnd("GlobalTreeItem", UtilMisc.toMap("parentItemId", id),UtilMisc.toList("rank"));
//			for(GenericValue gv1:oldList){
//			String permission =gv1.getString("itemPermission");
//			       if(security.hasPermission(permission, userLogin)){
//						newList.add(gv1);
//					}	
//			}
//
//			result.put("list", newList);
//			return result;
//
//		}
		
		
	
	


}
