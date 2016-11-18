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
import net.sf.json.*;
def pid="root";
if(parameters.pid!=null&&parameters.pid.length>0){
	pid=parameters.pid;
}
Map allMap=new HashMap();
List hasViewModel=new ArrayList();
List allItems= delegator.findByAndCache("MenuTree", null,["rank"]);
List rootItems =  EntityUtil.filterByCondition(allItems,EntityCondition.makeCondition("parentItemId",EntityOperator.EQUALS,"root"));
for(GenericValue gv:rootItems){
	List secondItems=EntityUtil.filterByCondition(allItems,EntityCondition.makeCondition("parentItemId",EntityOperator.EQUALS,gv.id));
	List list2=new ArrayList();
	for(GenericValue gv2:secondItems){
	    Map secendMap=new HashMap();
	    secendMap.put("menuid",gv2.id);
	    secendMap.put("menuname",gv2.itemName);
	    secendMap.put("url",gv2.urlLocation);
	    secendMap.put("icon",gv2.icon!=null?gv2.icon:"ext_wtdgl");
	    List list3=new ArrayList();
	    List threadItems=EntityUtil.filterByCondition(allItems,EntityCondition.makeCondition("parentItemId",EntityOperator.EQUALS,gv2.id));
		for(GenericValue gv3:threadItems){
		    boolean hasPer=true;
		    //权限控制
		    if(gv3.permission!=null){
				if(gv3.permission.indexOf("_")!=-1){
				    hasPer=security.hasEntityPermission(gv3.permission.split("_")[0], "_" + gv3.permission.split("_")[1], userLogin);
				}else{
				    hasPer=security.hasPermission(gv3.permission,userLogin);
				}
		    } 
		    if(hasPer){
			list3.add(UtilMisc.toMap("menuid",gv3.id,"menuname",gv3.itemName,"url",gv3.urlLocation,"isInnerTab",gv3.isInnerTab));
		    }
		}
		secendMap.put("menus",list3);
        	if(list3.size()>0){
        	    list2.add(secendMap);
        	}
	}
	if(list2.size()>0){
	    hasViewModel.add(UtilMisc.toMap("id",gv.id,"itemName",gv.itemName));
	    allMap.put(gv.id,list2);
	}
}
JSONObject jsonArr= JSONObject.fromObject(allMap);
JSONArray hasViewModelArr= JSONArray.fromObject(hasViewModel);
context.map=jsonArr.toString();
context.hasViewModel=hasViewModelArr.toString();
//request.setAttribute("map",allMap);
//request.setAttribute("hasViewModel",hasViewModel);
