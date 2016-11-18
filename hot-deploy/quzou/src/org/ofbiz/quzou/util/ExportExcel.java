package org.ofbiz.quzou.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;
import org.extErp.sysCommon.document.DocumentUtils;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.StringUtil;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;

public class ExportExcel {

	public static final String module = ExportExcel.class.getName();

	/**
	 * 
	 * exportExcel(通用导出excel)<br/>
	 * 
	 * @param request
	 * @param response
	 * @param resultList
	 * @param filedNames
	 *            :实体字段名称","隔开
	 * @param fileName
	 *            ：下载的文件名称
	 * @return
	 * @throws IOException
	 * @throws GenericEntityException 
	 */
	public static String exportExcel(HttpServletRequest request,HttpServletResponse response, List<Map<String, Object>> resultList, String filedNames,List<Map<String, Object>> resultList2, String filedNames2,String fileName) throws IOException, GenericEntityException {
			Delegator delegator = (Delegator) request.getAttribute("delegator");
			String cId = request.getParameter("cId");
			GenericValue gv = delegator.findOne("QzCompetition", UtilMisc.toMap("cId",cId), false);
			String cName = (String)gv.get("cName");
			
			String  startDate = (String)request.getParameter("startDate");
			String  endDate = (String)request.getParameter("endDate");
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String start = startDate;
			String end = endDate;
			List<String> filedNameList = StringUtil.split(filedNames, ",");
			List<String> filedNameList2 = StringUtil.split(filedNames2, ",");
		try {
			String fullFilePath = request.getSession().getServletContext()
					.getRealPath("/")
					+ "template/template.xls";
			InputStream fis = new FileInputStream(fullFilePath);
			// 写excel开始
			HSSFWorkbook wb = new HSSFWorkbook(fis);

			// 创建sheet
			HSSFSheet sheet = wb.getSheet("个人");
			HSSFSheet sheet2 = wb.getSheet("团队");

			// 样式
			//创建单元格样式  
	        HSSFCellStyle style = wb.createCellStyle();  
	        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中  
	        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平居中 
	        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
	        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
	        style.setBottomBorderColor(HSSFColor.BLACK.index);
	        style.setRightBorderColor(HSSFColor.BLACK.index);
	        
	        HSSFCellStyle style_title = wb.createCellStyle();  
	        style_title.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中  
	        style_title.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平居中
	        // 指定单元格自动换行
		    style_title.setWrapText(true);
		    // 设置单元格字体
		    HSSFFont font = wb.createFont();
		    font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		    font.setFontName("黑体");
		    font.setFontHeight((short) 220);
		    style_title.setFont(font);
	          
	        HSSFCellStyle style_right = wb.createCellStyle();  
	        style_right.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中  
	        style_right.setAlignment(HSSFCellStyle.ALIGN_RIGHT);//水平靠右  
	          
	        HSSFCellStyle style_left = wb.createCellStyle();  
	        style_left.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);  
	        style_left.setAlignment(HSSFCellStyle.ALIGN_LEFT);//水平靠左
	        
	        HSSFCellStyle style_time = wb.createCellStyle();  
	        style_time.setVerticalAlignment(HSSFCellStyle.VERTICAL_BOTTOM);//垂直居下
	        style_time.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平居中
	        HSSFFont font_time = wb.createFont();
	        font_time.setFontName("黑体");
	        font_time.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
	        style_time.setFont(font_time);
		    HSSFRow row = null;
		    // 创建一个单元格
		    HSSFCell cell = null;
		    row = sheet.getRow(0);
		    row.setHeight((short) (25 * 20)); 
		    cell = row.getCell(0);
		    cell.setCellValue(cName+"——个人成绩");//标题
		    cell.setCellStyle(style_title);
		    row = sheet.getRow(2);
		    cell = row.getCell(2);
		    cell.setCellValue(start);//起期
		    cell.setCellStyle(style_time);
		    row = sheet.getRow(2);
		    cell = row.getCell(3);
		    cell.setCellValue(end);//止期
		    cell.setCellStyle(style_time);
		    row = sheet.getRow(2);
		    cell = row.getCell(4);
		    cell.setCellValue(sdf.format(new java.util.Date()));//打印时间
		    cell.setCellStyle(style_time);
		    for (int i = 0; i < resultList.size(); i++)
		    {
				Map dataValue = (Map) resultList.get(i);
				row = sheet.createRow(i + 4);// 创建数据行
				cell = row.createCell(0);
				cell.setCellValue(i + 1);
				cell.setCellStyle(style);
				for (int f = 0; f < filedNameList.size(); f++)
				{
				    cell = row.createCell(f+1);
				    Object o = dataValue.get(filedNameList.get(f));
					cell.setCellValue(o != null ? o.toString() : "");
					cell.setCellStyle(style);
				}
		    }
		    //////单位成绩
		    row = sheet2.getRow(0);
		    row.setHeight((short) (25 * 20)); 
		    cell = row.getCell(0);
		    cell.setCellValue(cName+"——团队成绩");//标题
		    cell.setCellStyle(style_title);
		    row = sheet2.getRow(2);
		    cell = row.getCell(1);
		    cell.setCellValue(start);//起期
		    cell.setCellStyle(style_time);
		    row = sheet2.getRow(2);
		    cell = row.getCell(2);
		    cell.setCellValue(end);//止期
		    cell.setCellStyle(style_time);
		    row = sheet2.getRow(2);
		    cell = row.getCell(3);
		    cell.setCellValue(sdf.format(new java.util.Date()));//打印时间
		    cell.setCellStyle(style_time);
		    for (int i = 0; i < resultList2.size(); i++)
		    {
				Map dataValue = (Map) resultList2.get(i);
				row = sheet2.createRow(i + 4);// 创建数据行
				cell = row.createCell(0);
				cell.setCellValue(i + 1);
				cell.setCellStyle(style);
				for (int f = 0; f < filedNameList2.size(); f++)
				{
				    cell = row.createCell(f+1);
				    Object o = dataValue.get(filedNameList2.get(f));
					cell.setCellValue(o != null ? o.toString() : "");
					cell.setCellStyle(style);
				}
		    }
			
			OutputStream os = response.getOutputStream();
			response.setContentType("application/vnd.ms-excel");
			String contentDisposition = DocumentUtils.getContentDisposition((fileName != null ? fileName : "导出列表") + ".xls",request.getHeader("user-agent"));
			response.setHeader("Content-Disposition", contentDisposition);

			wb.write(os);
			os.flush();
			os.close();
			os = null;
			response.flushBuffer();

		} catch (Exception e) {
			e.printStackTrace();
			Debug.logError(e, module);
			return "error";
		}
		return "success";
	}

	/**
	 * @param request
	 * @param response
	 * @param resultList
	 * @param filedNames
	 * @param resultList2
	 * @param filedNames2
	 * @param fileName
	 * @return
	 * @throws IOException
	 * @throws GenericEntityException
	 */
	public static String exportLog(HttpServletRequest request,HttpServletResponse response, List<GenericValue> resultList, String filedNames,String fileName) throws IOException, GenericEntityException {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		
		String  startDate = (String)request.getParameter("startDate");
		String  endDate = (String)request.getParameter("endDate");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String start = startDate;
		String end = endDate;
		List<String> filedNameList = StringUtil.split(filedNames, ",");
	try {
		String fullFilePath = request.getSession().getServletContext()
				.getRealPath("/")
				+ "template/template2.xls";
		InputStream fis = new FileInputStream(fullFilePath);
		// 写excel开始
		HSSFWorkbook wb = new HSSFWorkbook(fis);

		// 创建sheet
		HSSFSheet sheet = wb.getSheet("sheet");

		// 样式
		//创建单元格样式  
        HSSFCellStyle style = wb.createCellStyle();  
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平居中 
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style.setBottomBorderColor(HSSFColor.BLACK.index);
        style.setRightBorderColor(HSSFColor.BLACK.index);
        
        HSSFCellStyle style_title = wb.createCellStyle();  
        style_title.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中  
        style_title.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平居中
        // 指定单元格自动换行
	    style_title.setWrapText(true);
	    // 设置单元格字体
	    HSSFFont font = wb.createFont();
	    font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    font.setFontName("黑体");
	    font.setFontHeight((short) 220);
	    style_title.setFont(font);
          
        HSSFCellStyle style_right = wb.createCellStyle();  
        style_right.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中  
        style_right.setAlignment(HSSFCellStyle.ALIGN_RIGHT);//水平靠右  
          
        HSSFCellStyle style_left = wb.createCellStyle();  
        style_left.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);  
        style_left.setAlignment(HSSFCellStyle.ALIGN_LEFT);//水平靠左
        
        HSSFCellStyle style_time = wb.createCellStyle();  
        style_time.setVerticalAlignment(HSSFCellStyle.VERTICAL_BOTTOM);//垂直居下
        style_time.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平居中
        HSSFFont font_time = wb.createFont();
        font_time.setFontName("黑体");
        font_time.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        style_time.setFont(font_time);
	    HSSFRow row = null;
	    // 创建一个单元格
	    HSSFCell cell = null;
	    row = sheet.getRow(0);
	    row.setHeight((short) (25 * 20)); 
	    cell = row.getCell(0);
	    cell.setCellValue("健走日志导出表");//标题
	    cell.setCellStyle(style_title);
	    row = sheet.getRow(2);
	    cell = row.getCell(3);
	    cell.setCellValue(start);//起期
	    cell.setCellStyle(style_time);
	    cell = row.getCell(4);
	    cell.setCellValue(end);//止期
	    cell.setCellStyle(style_time);
	    cell = row.getCell(5);
	    cell.setCellValue(sdf.format(new java.util.Date()));//打印时间
	    cell.setCellStyle(style_time);
	    for (int i = 0; i < resultList.size(); i++)
	    {
			Map dataValue = (Map) resultList.get(i);
			row = sheet.createRow(i + 4);// 创建数据行
			cell = row.createCell(0);
			cell.setCellValue(i + 1);
			cell.setCellStyle(style);
			for (int f = 0; f < filedNameList.size(); f++)
			{
			    cell = row.createCell(f+1);
			    Object o = dataValue.get(filedNameList.get(f));
				cell.setCellValue(o != null ? o.toString() : "");
				cell.setCellStyle(style);
			}
	    }
		
		OutputStream os = response.getOutputStream();
		response.setContentType("application/vnd.ms-excel");
		String contentDisposition = DocumentUtils.getContentDisposition((fileName != null ? fileName : "导出列表") + ".xls",request.getHeader("user-agent"));
		response.setHeader("Content-Disposition", contentDisposition);

		wb.write(os);
		os.flush();
		os.close();
		os = null;
		response.flushBuffer();

	} catch (Exception e) {
		e.printStackTrace();
		Debug.logError(e, module);
		return "error";
	}
	return "success";
}


	
}
