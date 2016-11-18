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
List<GenericValue> dimensionPartList=FastList.newInstance();
List<GenericValue> measureList=FastList.newInstance();
Map dimPartMap=FastMap.newInstance();
int dimCountNum=Integer.valueOf(parameters.get("dimCountNum"));
int startRowNum=Integer.valueOf(parameters.get("startRowNum"));
int startCellNum=Integer.valueOf(parameters.get("startCellNum"));
List measureIdList=StringUtil.split(parameters.get("measureIds"),",");
//List dimList=StringUtil.split(parameters.get("dimensionIds"),",");

for(int i=0;i<dimCountNum;i++){
	//dimPartMap.put(dimList.get(i),delegator.findByAnd("RawDimensionPart",UtilMisc.toMap("dimensionId",dimList.get(i))));
	System.out.println("****"+parameters.get("dimensionPartId_"+(i+1)));
	dimensionPartList=StringUtil.split(parameters.get("dimensionPartId_"+(i+1)),",");
	rowCond = EntityCondition.makeCondition("dimensionPartId", EntityOperator.IN, dimensionPartList);
	List<EntityCondition> andExprs = FastList.newInstance();
	andExprs.add(rowCond);
	dimPartMap.put(i,delegator.findList("RawDimensionPart",EntityCondition.makeCondition(andExprs, EntityOperator.AND), null,null, null, false));
	//dimPartMap.put(i,delegator.findByAnd("RawDimensionPart",UtilMisc.toMap("dimensionId",dimList.get(i))));
}

rowCond = EntityCondition.makeCondition("measureId", EntityOperator.IN, measureIdList);
List<EntityCondition> andExprs = FastList.newInstance();
andExprs.add(rowCond);
measureList=delegator.findList("RawMeasure",EntityCondition.makeCondition(andExprs, EntityOperator.AND), null,null, null, false);
//measureList=delegator.findByAnd("RawMeasure",UtilMisc.toMap("templateGroupId",parameters.get("templateGroupId")));
genericCrossDivStr.append("<tr class='bg_tr' height='20'>");
for(int i=0;i<dimCountNum;i++){
	genericCrossDivStr.append("<td class='border02'>维度"+(i+1)+"</td>");
}

genericCrossDivStr.append("<td class='border02'>对应行数</td><td>操作</td></tr>");
int rowNum=1;
int dimNum=0;
List<GenericValue> dimension1PartList=FastList.newInstance();
List<GenericValue> dimension2PartList=FastList.newInstance();
List<GenericValue> dimension3PartList=FastList.newInstance();
List<GenericValue> dimension4PartList=FastList.newInstance();
List<GenericValue> dimension5PartList=FastList.newInstance();
dimension1PartList=(List<GenericValue>)dimPartMap.get(0);
dimension2PartList=(List<GenericValue>)dimPartMap.get(1);
dimension3PartList=(List<GenericValue>)dimPartMap.get(2);
dimension4PartList=(List<GenericValue>)dimPartMap.get(3);
dimension5PartList=(List<GenericValue>)dimPartMap.get(4);
for(int i=0;i<dimension1PartList.size();i++){
	GenericValue rowGv=(GenericValue)dimension1PartList.get(i);
	if(dimension2PartList!=null){
		for(int d2=0;d2<dimension2PartList.size();d2++){
			GenericValue d2Gv=(GenericValue)dimension2PartList.get(d2);
			if(dimension3PartList!=null){
				for(int d3=0;d3<dimension3PartList.size();d3++){
					GenericValue d3Gv=(GenericValue)dimension3PartList.get(d3);
					if(dimension4PartList!=null){	
						for(int d4=0;d4<dimension4PartList.size();d4++){
							GenericValue d4Gv=(GenericValue)dimension4PartList.get(d4);
							if(dimension5PartList!=null){	
								for(int d5=0;d5<dimension5PartList.size();d5++){
									GenericValue d5Gv=(GenericValue)dimension5PartList.get(d5);
									
										genericCrossDivStr.append("<tr class='bg_tr' id='tr_"+(rowNum)+"'>");
										genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim_1_"+(rowNum)+"_add' value='"+rowGv.get("dimensionPartId")+"'>"+rowGv.get("dimensionPartName")+"</td>");
										genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim_2_"+(rowNum)+"_add' value='"+d2Gv.get("dimensionPartId")+"'>"+d2Gv.get("dimensionPartName")+"</td>");
										genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim_3_"+(rowNum)+"_add' value='"+d3Gv.get("dimensionPartId")+"'>"+d3Gv.get("dimensionPartName")+"</td>");
										genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim_4_"+(rowNum)+"_add' value='"+d4Gv.get("dimensionPartId")+"'>"+d4Gv.get("dimensionPartName")+"</td>");
										genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim_5_"+(rowNum)+"_add' value='"+d5Gv.get("dimensionPartId")+"'>"+d5Gv.get("dimensionPartName")+"</td>");
										genericCrossDivStr.append("<td class='border02'><input type='text' name='excel_"+(rowNum)+"_add' value='"+ExcelUitl.excelArray[(j-1+startCellNum)]+(dimNum+startRowNum)+"'></td>");
										genericCrossDivStr.append("<td class='border02'><input type='button' value='删除' onclick=\"deleTr('tr_"+(rowNum)+"')\"></td>");
										genericCrossDivStr.append("</tr>");
										rowNum++;
									dimNum++;
								}
							}else{	
							
								genericCrossDivStr.append("<tr class='bg_tr' id='tr_"+(rowNum)+"'>");
								genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim_1_"+(rowNum)+"_add' value='"+rowGv.get("dimensionPartId")+"'>"+rowGv.get("dimensionPartName")+"</td>");
								genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim_2_"+(rowNum)+"_add' value='"+d2Gv.get("dimensionPartId")+"'>"+d2Gv.get("dimensionPartName")+"</td>");
								genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim_3_"+(rowNum)+"_add' value='"+d3Gv.get("dimensionPartId")+"'>"+d3Gv.get("dimensionPartName")+"</td>");
								genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim_4_"+(rowNum)+"_add' value='"+d4Gv.get("dimensionPartId")+"'>"+d4Gv.get("dimensionPartName")+"</td>");
								genericCrossDivStr.append("<td class='border02'><input type='text' name='excel_"+(rowNum)+"_add' value='"+(dimNum+startRowNum)+"'></td>");
								genericCrossDivStr.append("<td class='border02'><input type='button' value='删除' onclick=\"deleTr('tr_"+(rowNum)+"')\"></td>");
								genericCrossDivStr.append("</tr>");
								rowNum++;
							dimNum++;
						}
						}
					}else{
					
							
								genericCrossDivStr.append("<tr class='bg_tr' id='tr_"+(rowNum)+"'>");
								genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim_1_"+(rowNum)+"_add' value='"+rowGv.get("dimensionPartId")+"'>"+rowGv.get("dimensionPartName")+"</td>");
								genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim_2_"+(rowNum)+"_add' value='"+d2Gv.get("dimensionPartId")+"'>"+d2Gv.get("dimensionPartName")+"</td>");
								genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim_3_"+(rowNum)+"_add' value='"+d3Gv.get("dimensionPartId")+"'>"+d3Gv.get("dimensionPartName")+"</td>");
								genericCrossDivStr.append("<td class='border02'><input type='text' name='excel_"+(rowNum)+"_add' value='"+(dimNum+startRowNum)+"'></td>");
								genericCrossDivStr.append("<td class='border02'><input type='button' value='删除' onclick=\"deleTr('tr_"+(rowNum)+"')\"></td>");
								genericCrossDivStr.append("</tr>");
								rowNum++;
							dimNum++;
						}
				}	
			
			}else{
					
						genericCrossDivStr.append("<tr class='bg_tr' id='tr_"+(rowNum)+"'>");
						genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim_1_"+(rowNum)+"_add' value='"+rowGv.get("dimensionPartId")+"'>"+rowGv.get("dimensionPartName")+"</td>");
						genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim_2_"+(rowNum)+"_add' value='"+d2Gv.get("dimensionPartId")+"'>"+d2Gv.get("dimensionPartName")+"</td>");
						genericCrossDivStr.append("<td class='border02'><input type='text' name='excel_"+(rowNum)+"_add' value='"+(dimNum+startRowNum)+"'></td>");
						genericCrossDivStr.append("<td class='border02'><input type='button' value='删除' onclick=\"deleTr('tr_"+(rowNum)+"')\"></td>");
						genericCrossDivStr.append("</tr>");
						rowNum++;
					dimNum++;
				}	
			}
		

	}else{
		
			genericCrossDivStr.append("<tr class='bg_tr' id='tr_"+(rowNum)+"'>");
			genericCrossDivStr.append("<td class='border02'><input type='hidden' name='dim_1_"+(rowNum)+"_add' value='"+rowGv.get("dimensionPartId")+"'>"+rowGv.get("dimensionPartName")+"</td>");
			genericCrossDivStr.append("<td class='border02'><input type='text' name='excel_"+(rowNum)+"_add' value='"+(dimNum+startRowNum)+"'></td>");
			genericCrossDivStr.append("<td class='border02'><input type='button' value='删除' onclick=\"deleTr('tr_"+(rowNum)+"')\"></td>");
			genericCrossDivStr.append("</tr>");
			rowNum++;
		dimNum++;
	}
}
/**
 * 迭代器：循环当前维度时，获取是否有下一维度，如果有触发迭代
int rowNum=1;
//循环第一维度、循环第二维度。。。循环N维度，循环度量
for(int d=0;d<dimList.size();d++){
	List partList=dimPartMap.get(dimList.get(d));
	for(int p=0;p<partList.size();p++){
		GenericValue partGv=partList.get(p);
		
			genericCrossDivStr.append("<tr class='bg_tr' id='tr_"+(rowNum)+"'>");
			for(int c=0;c<dimCountNum;c++){
				List plist=dimPartMap.get(c);
				for(int i=0;i<plist.size();i++){
					GenericValue gv=plist.get(i);
					if(c==i){
						genericCrossDivStr.append("<td>"+gv.get("dimensionPartName")+"</td>");
					}
				
			}		
			
			genericCrossDivStr.append("</tr>");
		}
		
		rowNum++;
	}
}

**/

request.setAttribute("genericCrossDivStr",genericCrossDivStr.toString());
