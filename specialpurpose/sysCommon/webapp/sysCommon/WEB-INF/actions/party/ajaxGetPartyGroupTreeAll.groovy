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
//admintreeItems = delegator.findByAnd("AdminTreeItem", ["parentItemId":"ProductProductsMgr"]);
String pid="root";
String roleTypeId="DEPARTMENT";
String partyRelationshipTypeId="PARENT";
if(parameters.pid!=null&&parameters.pid.length>0){
	pid=parameters.pid;
}
List allParty=  delegator.findByAnd("PartyGroupAndParent",  ["roleTypeId":roleTypeId],["sortNum"]);
rootItems  = EntityUtil.filterByCondition(allParty,EntityCondition.makeCondition("parentPartyId",EntityOperator.EQUALS,null));

List list =new ArrayList();
for(GenericValue gv:rootItems){
	Map map=new HashMap();
	map.put("pid","root");
	map.put("pname",null);
	map.put("id",gv.partyId);
	map.put("id",gv.partyId);
	
	map.put("text",gv.groupName);
	map.put("iconCls","icon-tip");
	map.put("barCode",gv.barCode);
	map.put("sortNum",gv.sortNum);
	map.put("remark",gv.remark);
	map.put("statusId",delegator.findOne("StatusItem",[statusId : gv.statusId], false).description);
	List list2=new ArrayList();
	List secondItems=EntityUtil.filterByCondition(allParty,EntityCondition.makeCondition("parentPartyId",EntityOperator.EQUALS,gv.partyId));
	for(GenericValue gv2:secondItems){
		Map map2=new HashMap();
		map2.put("pid",gv.partyId);
		map2.put("pname",gv2.parentGroupName);
		map2.put("id",gv2.partyId);

		map2.put("text",gv2.groupName);
		map2.put("iconCls","icon-tip");
		map2.put("barCode",gv2.barCode);
		map2.put("sortNum",gv2.sortNum);
		map2.put("remark",gv2.remark);
		map2.put("statusId",delegator.findOne("StatusItem",[statusId : gv2.statusId], false).description);
		
		List list3=new ArrayList();
            	List threeItems=EntityUtil.filterByCondition(allParty,EntityCondition.makeCondition("parentPartyId",EntityOperator.EQUALS,gv2.partyId));
            	for(GenericValue gv3:threeItems){
            		Map map3=new HashMap();
            		map3.put("pid",gv.partyId);
            		map3.put("pname",gv3.parentGroupName);
            		map3.put("id",gv3.partyId);
			map3.put("barCode",gv3.barCode);
			map3.put("sortNum",gv3.sortNum);
			map3.put("remark",gv3.remark);
            		map3.put("text",gv3.groupName);
            		map3.put("iconCls","icon-tip");
            		map3.put("statusId",delegator.findOne("StatusItem",[statusId : gv3.statusId], false).description);
            		list3.add(map3);
            	}
		map2.put("children",list3);
		list2.add(map2);
		    
	}
	map.put("children",list2);
	list.add(map);
}
//request.setAttribute("node",list);
JsonUtil.toJsonObjectList(list, response);
//request.setAttribute("node",list);