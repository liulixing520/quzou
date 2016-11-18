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
List<String> rowIndex=FastList.newInstance();
List<String> cellIndex=FastList.newInstance();
List<GenericValue> rowIndexList=FastList.newInstance();
List<GenericValue> cellIndexList=FastList.newInstance();

for(GenericValue gv:rawCrosstabList){
	rowIndex.add(gv.get("rowIndexId"));
	cellIndex.add(gv.get("cellIndexId"));
}
rowCond = EntityCondition.makeCondition("indexId", EntityOperator.IN, rowIndex);
andExprs.add(rowCond);
EntityConditionList<EntityExpr> exprList = EntityCondition.makeCondition(andExprs, EntityOperator.AND);
rowIndexList=delegator.findList("RawIndex", exprList, null,UtilMisc.toList("sortNo"), null, false);
cellCond = EntityCondition.makeCondition("indexId", EntityOperator.IN, cellIndex);
andExprs.clear();
andExprs.add(cellCond);
EntityConditionList<EntityExpr> exprCellList = EntityCondition.makeCondition(andExprs, EntityOperator.AND);
cellIndexList=delegator.findList("RawIndex", exprCellList, null,UtilMisc.toList("sortNo"), null, false);
for(GenericValue gv:rawCrosstabDataIndexList){
	dataMap.put(gv.get("rowIndexId")+"_"+gv.get("cellIndexId"),gv.get("excelData"));
	
}
context.put("dataMap",dataMap);
context.put("rowIndexList",rowIndexList);
context.put("cellIndexList",cellIndexList);
