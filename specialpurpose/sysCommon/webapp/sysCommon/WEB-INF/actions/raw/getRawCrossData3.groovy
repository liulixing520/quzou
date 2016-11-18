import org.ofbiz.entity.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import java.util.List;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.base.util.*;

Map<String, Object> dataMap = FastMap.newInstance();
EntityCondition rowCond = null;
EntityCondition cellCond = null;
List<EntityCondition> andExprs = FastList.newInstance();
List<String> dim1=FastList.newInstance();
List<String> dim2=FastList.newInstance();
List<String> dim3=FastList.newInstance();
List<String> measure=FastList.newInstance();
List<GenericValue> dimensionPart1List=FastList.newInstance();
List<GenericValue> dimensionPart2List=FastList.newInstance();
List<GenericValue> dimensionPart3List=FastList.newInstance();
List<GenericValue> measureList=FastList.newInstance();
for(GenericValue gv:rawCrossList){
	if(gv.get("dimensionPart1Id")!=null)dim1.add(gv.get("dimensionPart1Id"));
	if(gv.get("dimensionPart2Id")!=null)dim2.add(gv.get("dimensionPart2Id"));
	if(gv.get("dimensionPart3Id")!=null)dim3.add(gv.get("dimensionPart3Id"));
	measure.add(gv.get("measureId"));
}
rowCond = EntityCondition.makeCondition("dimensionPartId", EntityOperator.IN, dim1);
andExprs.add(rowCond);
dimensionPart1List=delegator.findList("RawDimensionPart", EntityCondition.makeCondition(andExprs, EntityOperator.AND), null,UtilMisc.toList("sortNo"), null, false);
andExprs.clear();
if(dim2.size()>0){
	rowCond= EntityCondition.makeCondition("dimensionPartId", EntityOperator.IN, dim2);
	andExprs.add(rowCond);
	dimensionPart2List=delegator.findList("RawDimensionPart", EntityCondition.makeCondition(andExprs, EntityOperator.AND), null,UtilMisc.toList("sortNo"), null, false);
	andExprs.clear();
}
if(dim3.size()>0){
	rowCond= EntityCondition.makeCondition("dimensionPartId", EntityOperator.IN, dim3);
	andExprs.add(rowCond);
	dimensionPart3List=delegator.findList("RawDimensionPart", EntityCondition.makeCondition(andExprs, EntityOperator.AND), null,UtilMisc.toList("sortNo"), null, false);
}
cellCond = EntityCondition.makeCondition("measureId", EntityOperator.IN, measure);
andExprs.clear();
andExprs.add(cellCond);
EntityConditionList<EntityExpr> exprCellList = EntityCondition.makeCondition(andExprs, EntityOperator.AND);
measureList=delegator.findList("RawMeasure", exprCellList, null,UtilMisc.toList("sortNo"), null, false);
for(GenericValue gv:rawCrosstabDataIndexList){
	dataMap.put(gv.get("dimensionPart1Id")+"_"+(gv.get("dimensionPart2Id")!=null?(gv.get("dimensionPart2Id")+"_"):"")+(gv.get("dimensionPart3Id")!=null?(gv.get("dimensionPart3Id")+"_"):"")+gv.get("measureId"),gv.get("excelData"));
	
}
context.put("dataMap",dataMap);
context.put("dimensionPart1List",dimensionPart1List);
context.put("dimensionPart2List",dimensionPart2List);
context.put("dimensionPart3List",dimensionPart3List);
context.put("measureList",measureList);
