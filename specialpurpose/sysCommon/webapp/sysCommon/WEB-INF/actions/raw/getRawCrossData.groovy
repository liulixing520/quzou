import org.ofbiz.entity.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import java.util.List;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.base.util.*;
import org.ofbiz.entity.util.*;

/**
 * 多维数据构造：模板总维度数如4
 * map(1/2/3/4,dimList);
 */

Map<String, Object> dataMap = FastMap.newInstance();
Map<String, Object> dimMap = FastMap.newInstance();
EntityCondition rowCond = null;
EntityCondition cellCond = null;
int dimCountNum=entity.get("dimCountNum");
List<EntityCondition> andExprs = FastList.newInstance();

List<String> measure=FastList.newInstance();
List<String> crossIdList=FastList.newInstance();
List<GenericValue> crossRefdimPartList=FastList.newInstance();

List<GenericValue> measureList=FastList.newInstance();
for(GenericValue gv:rawCrossList){
	measure.add(gv.get("measureId"));
	if(!crossIdList.contains(gv.get("crossId"))){
		crossIdList.add(gv.get("crossId"));
	}
}
rowCond = EntityCondition.makeCondition("crossId", EntityOperator.IN, crossIdList);
andExprs.add(rowCond);

crossRefdimPartList=delegator.findList("RawCrossRefdimPartAndName", EntityCondition.makeCondition(andExprs, EntityOperator.AND), null,null, null, false);
andExprs.clear();

cellCond = EntityCondition.makeCondition("measureId", EntityOperator.IN, measure);
andExprs.clear();
andExprs.add(cellCond);
EntityConditionList<EntityExpr> exprCellList = EntityCondition.makeCondition(andExprs, EntityOperator.AND);
measureList=delegator.findList("RawMeasure", exprCellList, null,UtilMisc.toList("sortNo"), null, false);

//
for (int i=1;i<dimCountNum+1;i++) {
	dimMap.put(i,EntityUtil.filterByCondition(crossRefdimPartList,EntityCondition.makeCondition("dimPartNum",new Long(i))));
}

//获取数据和配置，放入map，key为各维度
for(GenericValue gv:rawCrosstabDataIndexList){
	dataMap.put(gv.get("crossId")+"_"+gv.get("measureId"),gv.get("excelData"));
}
context.put("dimMap",dimMap);
context.put("dimCountNum",dimCountNum);
context.put("dataMap",dataMap);
context.put("measureList",measureList);
context.put("crossIdList",crossIdList);
