import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.base.util.UtilMisc;
productCategoryId = parameters.productCategoryId?:request.getAttribute("productCategoryId");

weeklyCategoryMembers = delegator.findList("ProductCategoryMember", EntityCondition.makeCondition("productCategoryId", EntityOperator.EQUALS, productCategoryId), null, null, null, false);

weeklyCategoryMembers = EntityUtil.filterByDate(weeklyCategoryMembers);

context.weeklyCategoryMembers = weeklyCategoryMembers;

/*pli = delegator.find("ProductStore", null, null,null,null,null);
stores=pli.getPartialList(0, 10);
pli.close();
context.stores=stores;*/
//可用于分页,现在的功能是取前十个
//dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");

/*Map<String,Object> inputContext = UtilMisc.toMap("entityName", "ProductStore");
inputContext.put("viewSize",10);
returnResult=dispatcher.runSync("findPortalList", inputContext);*/
//context.stores=returnResult.list;
List list  = new ArrayList();
rslist = delegator.findList("RecommendedSeller", EntityCondition.makeCondition("status", EntityOperator.EQUALS, "0"), null, null, null, false);  
for(int i=0;i<rslist.size();i++){
	productStore = delegator.findOne("ProductStore", [productStoreId : rslist[i].productStoreId], false);
	list.add(productStore)
}
context.stores=list;
