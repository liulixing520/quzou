import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;

import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.entity.util.*;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityFunction;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.condition.EntityFieldValue;
import org.ofbiz.entity.condition.EntityConditionList;
import org.ofbiz.entity.condition.EntityCondition;



parentGroupId=parameters.parentGroupId;
List<GenericValue> personList=new ArrayList<GenericValue>();
List<GenericValue> prlist = delegator.findByAnd("PartyRelationship", 
		UtilMisc.toMap("partyIdTo",parentGroupId,"partyRelationshipTypeId","CUSTOMER_CONTACT_REL"));
for(GenericValue gv:prlist){
	Map map=new HashMap();
	GenericValue pgv= delegator.findByPrimaryKey("Person", UtilMisc.toMap("partyId",gv.get("partyIdFrom")))
	map.put("partyId",pgv.get("partyId"));
	map.put("nickname",pgv.get("nickname"));
	personList.add(map);
}
request.setAttribute("person",personList);


