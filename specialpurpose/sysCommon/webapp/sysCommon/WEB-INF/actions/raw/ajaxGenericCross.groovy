import org.ofbiz.entity.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import java.util.List;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.base.util.*;
import org.extErp.sysCommon.util.*;

StringBuffer genericCrossDivStr=new StringBuffer();
List<GenericValue> rowIndexList=FastList.newInstance();
List<GenericValue> cellIndexList=FastList.newInstance();
int startRowNum=Integer.valueOf(parameters.get("startRowNum"));
int startCellNum=Integer.valueOf(parameters.get("startCellNum"));
rowIndexList=delegator.findByAnd("RawIndex",UtilMisc.toMap("parentIndexId",parameters.get("parentIndexId"),"indexLocation","row"));
cellIndexList=delegator.findByAnd("RawIndex",UtilMisc.toMap("parentIndexId",parameters.get("parentIndexId"),"indexLocation","cell"));
for(int i=0;i<rowIndexList.size();i++){
	GenericValue rowGv=(GenericValue)rowIndexList.get(i);
	for(int j=0;j<cellIndexList.size();j++){
		GenericValue cellGv=(GenericValue)cellIndexList.get(j);
		genericCrossDivStr.append("<tr class='bg_tr' id='tr_"+i+"_"+j+"'><td class='border02'><select name='row_"+i+"_add' >");
		for(GenericValue rowIndex:rowIndexList){ 
			genericCrossDivStr.append("<option value='"+rowIndex.get("indexId")+"'   "+(rowGv.get("indexId").equals(rowIndex.get("indexId"))?"selected":"")+" >"+rowIndex.get("indexName")+"</option>");
		}
		genericCrossDivStr.append("</select></td>");
		genericCrossDivStr.append("<td class='border02'><select name='cell_"+i+"_add' >");
		for(GenericValue cellIndex:cellIndexList){
			genericCrossDivStr.append("<option value='"+cellIndex.get("indexId")+"'   "+(cellGv.get("indexId").equals(cellIndex.get("indexId"))?"selected":"")+" >"+cellIndex.get("indexName")+"</option>");
			
		}
		genericCrossDivStr.append("</select></td>");
		genericCrossDivStr.append("<td class='border02'><input type='text' name='excel_"+i+"_add' value='"+ExcelUitl.excelArray[(j-1+startCellNum)]+(i+startRowNum)+"'></td>");
		genericCrossDivStr.append("<td class='border02'><input type='button' value='删除' onclick=\"deleTr('tr_"+i+"_"+j+"')\"></td>");
		
		genericCrossDivStr.append("</tr>");
	}
}
request.setAttribute("genericCrossDivStr",genericCrossDivStr.toString());
