import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.base.util.*;
import org.ofbiz.base.json.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import org.ofbiz.entity.*;
import java.util.List;
import com.yuanh.lims.util.*;
//admintreeItems = delegator.findByAnd("AdminTreeItem", ["parentItemId":"ProductProductsMgr"]);
String pid="root";
if(parameters.pid!=null&&parameters.pid.length()>0){
	pid=parameters.pid;
}
admintreeItems = delegator.findByAnd("MenuTree",["parentItemId":pid], ["rank"]);
securityGroupPermList=delegator.findByAnd("SecurityGroupPermission",["groupId":parameters.groupId], null);
List list =new ArrayList();
for(GenericValue gv:admintreeItems){
	Map map=new HashMap();
	map.put("pid",gv.parentItemId);
	map.put("pname",null);
	map.put("id",gv.permission);

	map.put("attributes",UtilMisc.toMap("url",gv.urlLocation.toString().replace("lims/control/","")));
	map.put("name",gv.itemName);
	map.put("iconCls","icon-tip");
	map.put("seq",gv.rank);
	List list2=new ArrayList();
	List secondItems=delegator.findByAnd("MenuTree", ["parentItemId":gv.id],["rank"]);
	for(GenericValue gv2:secondItems){
		Map map2=new HashMap();
		map2.put("pid",gv2.parentItemId);
		map2.put("pname",null);
		map2.put("id",gv2.permission);

		map2.put("attributes",UtilMisc.toMap("url",gv2.urlLocation.toString().replace("lims/control/","")));
		map2.put("name",gv2.itemName);
		map2.put("iconCls","icon-tip");
		map2.put("seq",gv2.rank);
		list2.add(map2);
		//获取二级模块下的权限
		List threadItems=delegator.findByAnd("SecurityPermission", ["modelId":gv2.id],null);
		List list3=new ArrayList();
		for(GenericValue gv3:threadItems){
			Map map3=new HashMap();
			map3.put("pid",gv2.id);
			map3.put("pname",null);
			map3.put("id",gv3.permissionId);
			
			if(securityGroupPermList!=null&&securityGroupPermList.size()>0){
			    for(GenericValue seq:securityGroupPermList){
					if(gv3.permissionId==seq.permissionId){
					    map3.put("checked","true");
					    break;
					}
			    }
			}
			map3.put("name",gv3.description);
			map3.put("iconCls","icon-tip");
			list3.add(map3);
		}
		map2.put("children",list3);
	
	}
	map.put("children",list2);
	list.add(map);
}
println "==============list==============>>"+list;
org.extErp.sysCommon.util.JsonUtil.toJsonObjectList(list, response);
//request.setAttribute("node",list);