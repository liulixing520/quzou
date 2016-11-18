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

Map allMap=new HashMap();
List hasViewModel=new ArrayList();
List allItems= delegator.findByAndCache("MenuTree", null,["rank"]);
def parentId="";
if(parameters.parentId!=null){
	parentId=parameters.parentId;
}else{
	List<EntityCondition> filterConditions = FastList.newInstance();
	filterConditions.add(EntityCondition.makeCondition("parentItemId",EntityOperator.EQUALS,"root"));
	filterConditions.add(EntityCondition.makeCondition("webSiteId",webSiteId));
	GenericValue firstGv= EntityUtil.getFirst(EntityUtil.filterByCondition(allItems,EntityCondition.makeCondition(filterConditions, EntityOperator.AND)));
	if(firstGv)   
	parentId=firstGv.id;
}
	List secondItems=EntityUtil.filterByCondition(allItems,EntityCondition.makeCondition("parentItemId",EntityOperator.EQUALS,parentId));
	List list2=new ArrayList();
	for(GenericValue gv2:secondItems){
	    Map secendMap=new HashMap();
	    secendMap.put("menuid",gv2.id);
	    secendMap.put("menuname",gv2.itemName);
	    secendMap.put("url",gv2.urlLocation);
	    secendMap.put("icon",gv2.icon!=null?gv2.icon:"icon-home");
	    List list3=new ArrayList();
	    List threadItems=EntityUtil.filterByCondition(allItems,EntityCondition.makeCondition("parentItemId",EntityOperator.EQUALS,gv2.id));
		for(GenericValue gv3:threadItems){
		    boolean hasPer=true;  
		    //权限控制
		    if(gv3.permission!=null){
				if(gv3.permission.indexOf("_")!=-1){
				    hasPer=security.hasEntityPermission(gv3.permission.substring(0,gv3.permission.lastIndexOf("_")), "_" + gv3.permission.substring(gv3.permission.lastIndexOf("_")+1,gv3.permission.length()), userLogin);
				}else{
				    hasPer=security.hasPermission(gv3.permission,userLogin)
				}
		    } 
		    if(hasPer){
				list3.add(UtilMisc.toMap("menuid",gv3.id,"menuname",gv3.itemName,"url",gv3.urlLocation,"icon",gv3.icon));
		    }
		}
		secendMap.put("menus",list3);
        	if(list3.size()>0){
        	    list2.add(secendMap);
        	}
	}
	context.childList=list2;
