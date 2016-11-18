/**
 * 通用查询返回json数据LIST
 */
import org.ofbiz.base.util.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import org.ofbiz.entity.*;
import java.util.List;
import java.util.*;
import org.ofbiz.entity.condition.*;
import java.io.Writer;


entityName=parameters.entityName;
filterFields=parameters.filterFields;
filterValues=parameters.filterValues;

toSelectFields=parameters.toSelectFields;
Map filterMap=new HashMap();
List eventExprs = FastList.newInstance();
if(filterFields){
    List fieldList= StringUtil.split(filterFields,",");
    List valueList= StringUtil.split(filterValues,",");
    for(int i=0;i<fieldList.size();i++){
		expr = EntityCondition.makeCondition(fieldList.get(i), EntityOperator.EQUALS, valueList.get(i));
		eventExprs.add(expr);
    }
}
List toSelectFieldList=new ArrayList();
if(toSelectFields!=null){
    toSelectFieldList=StringUtil.split(toSelectFields,",");
}
List<GenericValue>resultList=delegator.findList(entityName, EntityCondition.makeCondition(eventExprs, EntityOperator.AND), (Set)toSelectFieldList, null, null,false);

request.setAttribute("resultData",resultList);