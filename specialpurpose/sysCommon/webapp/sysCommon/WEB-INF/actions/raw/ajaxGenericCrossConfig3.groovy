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
List<GenericValue> dimension1PartList=FastList.newInstance();
List<GenericValue> dimension2PartList=FastList.newInstance();
List<GenericValue> dimension3PartList=FastList.newInstance();
List<GenericValue> measureList=FastList.newInstance();
int startRowNum=Integer.valueOf(parameters.get("startRowNum"));
int startCellNum=Integer.valueOf(parameters.get("startCellNum"));
String dimension1=parameters.get("dimension1");
String dimension2=parameters.get("dimension2");
String dimension3=parameters.get("dimension3");
String measureId=parameters.get("measureId");
if(dimension1!=null){
	dimension1PartList=delegator.findByAnd("RawDimensionPart",UtilMisc.toMap("dimensionId",dimension1));
}
if(dimension2!=null&&dimension2.length()>0){
	dimension2PartList=delegator.findByAnd("RawDimensionPart",UtilMisc.toMap("dimensionId",dimension2));
}
if(dimension3!=null&&dimension3.length()>0){
	dimension3PartList=delegator.findByAnd("RawDimensionPart",UtilMisc.toMap("dimensionId",dimension3));
}
measureList=delegator.findByAnd("RawMeasure",UtilMisc.toMap("templateGroupId",parameters.get("templateGroupId")));
System.out.println(dimension2PartList);
genericCrossDivStr.append("<tr class='bg_tr' height='20'><td class='border02'>维度1</td>");
if(dimension2!=null&&dimension2.length()>0)genericCrossDivStr.append("<td class='border02'>维度2</td>");
if(dimension3!=null&&dimension3.length()>0)genericCrossDivStr.append("<td class='border02'>维度3</td>");
genericCrossDivStr.append("<td class='border02'>度量</td><td class='border02'>excel格子</td><td>操作</td></tr>");
int rowNum=1;
int dimNum=0;
for(int i=0;i<dimension1PartList.size();i++){
	GenericValue rowGv=(GenericValue)dimension1PartList.get(i);
	if(dimension2PartList.size()>0){
		for(int d2=0;d2<dimension2PartList.size();d2++){
			GenericValue d2Gv=(GenericValue)dimension2PartList.get(d2);
			if(dimension3PartList.size()>0){
				for(int d3=0;d3<dimension3PartList.size();d3++){
					GenericValue d3Gv=(GenericValue)dimension3PartList.get(d3);
					for(int j=0;j<measureList.size();j++){
						GenericValue cellGv=(GenericValue)measureList.get(j);
						System.out.println((i+1)+"_"+(d2+1)+"_"+(d3+1)+"_"+(j+1));
						genericCrossDivStr.append("<tr class='bg_tr' id='tr_"+(rowNum)+"'>");
						genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim1_"+(rowNum)+"_add' value='"+rowGv.get("dimensionPartId")+"'>"+rowGv.get("dimensionPartName")+"</td>");
						genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim2_"+(rowNum)+"_add' value='"+d2Gv.get("dimensionPartId")+"'>"+d2Gv.get("dimensionPartName")+"</td>");
						genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim3_"+(rowNum)+"_add' value='"+d3Gv.get("dimensionPartId")+"'>"+d3Gv.get("dimensionPartName")+"</td>");
						genericCrossDivStr.append("<td class='border02'><input type='hidden' name='cell_"+(rowNum)+"_add' value='"+cellGv.get("measureId")+"'>"+cellGv.get("measureName")+"</td>");
						genericCrossDivStr.append("<td class='border02'><input type='text' name='excel_"+(rowNum)+"_add' value='"+ExcelUitl.excelArray[(j-1+startCellNum)]+(dimNum+startRowNum)+"'></td>");
						genericCrossDivStr.append("<td class='border02'><input type='button' value='删除' onclick=\"deleTr('tr_"+(rowNum)+"')\"></td>");
						genericCrossDivStr.append("</tr>");
						rowNum++;
					}	
					dimNum++;
				}
			}else{
					for(int j=0;j<measureList.size();j++){
						GenericValue cellGv=(GenericValue)measureList.get(j);
						genericCrossDivStr.append("<tr class='bg_tr' id='tr_"+(rowNum)+"'>");
						genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim1_"+(rowNum)+"_add' value='"+rowGv.get("dimensionPartId")+"'>"+rowGv.get("dimensionPartName")+"</td>");
						genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim2_"+(rowNum)+"_add' value='"+d2Gv.get("dimensionPartId")+"'>"+d2Gv.get("dimensionPartName")+"</td>");
						genericCrossDivStr.append("<td class='border02'><input type='hidden' name='cell_"+(rowNum)+"_add' value='"+cellGv.get("measureId")+"'>"+cellGv.get("measureName")+"</td>");
						genericCrossDivStr.append("<td class='border02'><input type='text' name='excel_"+(rowNum)+"_add' value='"+ExcelUitl.excelArray[(j-1+startCellNum)]+(dimNum+startRowNum)+"'></td>");
						genericCrossDivStr.append("<td class='border02'><input type='button' value='删除' onclick=\"deleTr('tr_"+(rowNum)+"')\"></td>");
						genericCrossDivStr.append("</tr>");
						rowNum++;
					}	
					dimNum++;
				}	
			}
		

	}else{
		for(int j=0;j<measureList.size();j++){
			GenericValue cellGv=(GenericValue)measureList.get(j);
			genericCrossDivStr.append("<tr class='bg_tr' id='tr_"+(rowNum)+"'>");
			genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim1_"+(rowNum)+"_add' value='"+rowGv.get("dimensionPartId")+"'>"+rowGv.get("dimensionPartName")+"</td>");
			genericCrossDivStr.append("<td class='border02'><input type='hidden' name='cell_"+(rowNum)+"_add' value='"+cellGv.get("measureId")+"'>"+cellGv.get("measureName")+"</td>");
			genericCrossDivStr.append("<td class='border02'><input type='text' name='excel_"+(rowNum)+"_add' value='"+ExcelUitl.excelArray[(j-1+startCellNum)]+(dimNum+startRowNum)+"'></td>");
			genericCrossDivStr.append("<td class='border02'><input type='button' value='删除' onclick=\"deleTr('tr_"+(rowNum)+"')\"></td>");
			genericCrossDivStr.append("</tr>");
			rowNum++;
		}	
		dimNum++;
	}
}
request.setAttribute("genericCrossDivStr",genericCrossDivStr.toString());
