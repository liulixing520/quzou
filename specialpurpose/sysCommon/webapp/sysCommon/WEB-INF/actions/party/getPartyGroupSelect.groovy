/**
 * 下列列表中-用到用--区分层级
 */
import org.ofbiz.entity.util.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.base.util.*;
import org.ofbiz.base.json.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import org.ofbiz.entity.*;
import java.util.List;
import org.extErp.sysCommon.util.*;
String pid="root";
String roleTypeId="DEPARTMENT";
if(parameters.pid!=null&&parameters.pid.length>0){
	pid=parameters.pid;
}
List allParty= delegator.findByAnd("PartyGroupAndParent",  ["roleTypeId":roleTypeId],["sortNum"],false);
rootItems = EntityUtil.filterByCondition(allParty,EntityCondition.makeCondition("parentPartyId",EntityOperator.EQUALS,null));

List list =new ArrayList();
for(GenericValue gv:rootItems){
	Map map=new HashMap();
	
	map.put("partyId",gv.partyId);
	map.put("groupName",gv.groupName);
	list.add(map);
	
	List secondItems= EntityUtil.filterByCondition(allParty,EntityCondition.makeCondition("parentPartyId",EntityOperator.EQUALS,gv.partyId));
	for(GenericValue gv2:secondItems){
		Map map2=new HashMap();
		map2.put("partyId",gv2.partyId);

		map2.put("groupName","--"+gv2.groupName);
		list.add(map2);
            	List threeItems=EntityUtil.filterByCondition(allParty,EntityCondition.makeCondition("parentPartyId",EntityOperator.EQUALS,gv2.partyId));
            	for(GenericValue gv3:threeItems){
            		Map map3=new HashMap();
            		map3.put("partyId",gv3.partyId);
            		map3.put("groupName","----"+gv3.groupName);
			list.add(map3);
            	}
	}
}
context.departments=list;