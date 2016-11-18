/**
 * 下列列表中-用户
 */
import javolution.util.FastList.*

import org.extErp.sysCommon.util.*
import org.ofbiz.base.json.*
import org.ofbiz.base.util.*
import org.ofbiz.entity.*
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.*

String roleTypeId="EMPLOYEE";

List allParty= delegator.findByAnd("PersonAndUserLoginAndRoleAndRelationship",  ["roleTypeId":roleTypeId],["userLoginId"],false);

List list =new ArrayList();
for(GenericValue gv:allParty){
	Map map=new HashMap();
	
	map.put("partyId",gv.partyId);
	map.put("personName",gv.firstName);
	map.put("userLoginId",gv.userLoginId);
	list.add(map);
	
	
}
context.partyPersons=list;