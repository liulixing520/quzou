import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.entity.util.*;
import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.*;
import javolution.util.FastList;


roleList = delegator.findByAnd("ProductStoreRole", [partyId :userLogin.partyId,roleTypeId:"AGENT"], null, false);
List andExprs = FastList.newInstance();
if(parameters.agent){
	if(roleList){
		andExprs.add(EntityCondition.makeCondition("productStoreId", EntityOperator.IN,EntityUtil.getFieldListFromEntityList(roleList,"productStoreId",false)));
	}else{
		andExprs.add(EntityCondition.makeCondition("productStoreId", EntityOperator.EQUALS, "1"));
	}
}else{
	if(roleList){
		andExprs.add(EntityCondition.makeCondition("productStoreId", EntityOperator.NOT_IN,EntityUtil.getFieldListFromEntityList(roleList,"productStoreId",false)));
	}
}
storeList=select("productStoreId","storeName").from("ProductStore")
	.where(andExprs).queryList();
	
if(storeList){
	context.storeList=storeList;
}





