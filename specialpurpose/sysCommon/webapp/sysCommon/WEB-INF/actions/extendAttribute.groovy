
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;



List<GenericValue> extendAttributeList= delegator.findByAnd("ExtendAttribute", UtilMisc.toMap("relEntityName", relEntityName));
Map extendValueMap=new HashMap();
Map extendEnumMap=new HashMap();
for(GenericValue gv:extendAttributeList){
	if(relEntityId){
		GenericValue gvaule=delegator.findByPrimaryKey("ExtendAttributeValue",
				UtilMisc.toMap("extendAttributeId",gv.get("extendAttributeId"),"relEntityName",relEntityName,"relEntityId",relEntityId));
		if(gvaule){
			extendValueMap.put(gv.get("extendAttributeId"),gvaule.get("extendAttributeValue"));
		}
	}
	//针对枚举项-枚举select存放
	if(gv.get("extendAttributeType").equals("enum")){
		extendEnumMap.put(gv.get("extendAttributeId"),delegator.findByAnd("Enumeration", 
				UtilMisc.toMap("enumTypeId", gv.get("extendAttributeEnum"))));
	}
	
}
context.extendAttributeList=extendAttributeList;
context.extendValueMap=extendValueMap;
context.extendEnumMap=extendEnumMap;