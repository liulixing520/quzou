import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javolution.util.FastList;
import javolution.util.FastMap;
import jxl.Sheet;
import jxl.Workbook;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.GenericValue;
import org.extErp.sysCommon.document.DocumentUtils;
import org.ofbiz.entity.util.EntityUtil;

module = "exportRawTemplateGroup.groovy"

// 写Excel文件
wb = new HSSFWorkbook();
// 样式
cellStyle = wb.createCellStyle();
// 设定单元格样式 指定单元格居中对齐
cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
// 指定单元格自动换行
cellStyle.setWrapText(true);
// 设置单元格字体
font = wb.createFont();
font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
font.setFontName("宋体");
font.setFontHeight((short) 220);
cellStyle.setFont(font);

templateGroupId = request.getParameter("templateGroupId")
RawTemplateGroup = delegator.findOne("RawTemplateGroup",[templateGroupId:templateGroupId],false)
RawTemplateList = delegator.findByAnd("RawTemplate",[templateGroupId:templateGroupId],null,false)

if(RawTemplateList){

	for(GenericValue RawTemplate:RawTemplateList){
		templateName = RawTemplate.templateName
		templateId = RawTemplate.templateId
		if(!templateName){
			templateName="未命名模板"
		}
		
		//创建sheet
		sheet = wb.createSheet(templateName);
		// 创建行
        row = null;
		// 创建单元格
        cell = null;
        
        try{
        	//筹备数据
			rawCrossList = delegator.findByAnd("RawCrossConfig",[templateId:templateId],["rowNum"],false)
			rawTemplateRefdimList = delegator.findByAnd("RawTemplateRefdimAndDim",[templateId:templateId],null,false)
			rawCrosstabDataIndexList = delegator.findByAnd("RawCrossDataAndConfig",[templateId:templateId],null,false)
			
			dataMap = FastMap.newInstance();
			dimMap = FastMap.newInstance();
			rowCond = null;
			cellCond = null;
			
			dimCountNum = RawTemplate.dimCountNum
			andExprs = FastList.newInstance();
			measure=FastList.newInstance()
			crossIdList=FastList.newInstance()
			
			crossRefdimPartList=FastList.newInstance()
			measureList=FastList.newInstance()
			for(GenericValue gv:rawCrossList){
				measure.add(gv.measureId);
				if(!crossIdList.contains(gv.crossId)){
					crossIdList.add(gv.crossId);
				}
			}
			
			rowCond = EntityCondition.makeCondition("crossId", EntityOperator.IN, crossIdList)
			andExprs.add(rowCond)
			
			crossRefdimPartList=delegator.findList("RawCrossRefdimPartAndName", EntityCondition.makeCondition(andExprs, EntityOperator.AND), null,null, null, false)
			andExprs.clear()
			
			cellCond = EntityCondition.makeCondition("measureId", EntityOperator.IN, measure)
			andExprs.clear()
			andExprs.add(cellCond)
			
			exprCellList = EntityCondition.makeCondition(andExprs, EntityOperator.AND)
			
			measureList=delegator.findList("RawMeasure", exprCellList, null,UtilMisc.toList("sortNo"), null, false)
			
			for (int i=1;i<dimCountNum+1;i++) {
				dimMap.put(i,EntityUtil.filterByCondition(crossRefdimPartList,EntityCondition.makeCondition("dimPartNum",new Long(i))));
			}
			
			for(GenericValue gv:rawCrosstabDataIndexList){
				dataMap.put(gv.get("crossId")+"_"+gv.get("measureId"),gv.get("excelData"));
			}
			
			// 写表头行
			try{
	        	row = sheet.createRow(0);
	        	row.setHeight((short) 550);// 设置行高
	        	
	        	dimCount = rawTemplateRefdimList.size()
	        	measureCount = measureList.size()
	        	
	        	for(int a=0;a<dimCount;a++){
					cell = row.createCell(a);
					cell.setCellValue(rawTemplateRefdimList[a].dimensionName);
		            cell.setCellStyle(cellStyle);
	            }
	            for(int a=0;a<measureCount;a++){
	            	cell = row.createCell(dimCount+a);
					cell.setCellValue(measureList[a].measureName);
		            cell.setCellStyle(cellStyle);
	            }
            }catch(Exception e2){
            	Debug.logError(e2,module)
            }
            
            rawCrossCount = crossIdList.size()
            for(int a=0;a<rawCrossCount;a++){
            	try{
	            	row = sheet.createRow(a+1);
	            	row.setHeight((short) 550);// 设置行高
            		
            		for(int b=0;b<dimCountNum;b++){
            			partList = dimMap[b+1]
            			for(GenericValue dimPart:partList){
            				if(dimPart.dimPartNum==b+1 && crossIdList[a]==dimPart.crossId){
            					cell = row.createCell(b);
								cell.setCellValue(dimPart.dimensionPartName);
					            cell.setCellStyle(cellStyle);
            				}
            			}
            		}
            		for(int b=0;b<measureCount;b++){
            			cell = row.createCell(dimCount+b);
						cell.setCellValue("");
			            cell.setCellStyle(cellStyle);
            		}
            	}catch(Exception e3){
            		Debug.logError(e3,module)
            	}
            }
            
		}catch(Exception e1){
			Debug.logError(e1,module)
		}
		
	}
}

templateGroupName = RawTemplateGroup.templateGroupName
if(!templateGroupName){
	templateGroupName = "未命名模板组"
}
response.setContentType("application/vnd.ms-excel")
contentDisposition = DocumentUtils.getContentDisposition(templateGroupName+".xls", request.getHeader("user-agent"))
response.setHeader("Content-Disposition", contentDisposition)
wb.write(response.getOutputStream())

return "success"