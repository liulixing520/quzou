package org.ofbiz.quzou.util;


/**
 * JXLExcelUtil.java
 * create date: 2011-6-17
 * update date: 2011-6-17
 * 
 * 利用JXL组件进行excel操作的组件
 * 
 */

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.ofbiz.base.util.UtilValidate;

/**
 * 
 * 类名称：jxlExcel导入类
 * 类描述：
 * 日期:  2015-08-28 上午9:50:53 
 *
 * @author：
 * @version 1.0.0
 */


public class JXLExcelUtil {
	
	/**
	 *  获取Excel工作薄
	 *  
	 * @param fileName Excel文件名称
	 * @return
	 * @throws BiffException
	 * @throws IOException
	 */
	public static Workbook getExcelWorkbook(String fileName) 
		throws BiffException, IOException {
		
		Workbook workbook = null;
		workbook = Workbook.getWorkbook(new File(fileName));
		return workbook;
	}
	
	/**
	 * 获取Excel指定序列号的工作表
	 * 
	 * @param fileName Excel文件名称
	 * @param index 工作表序列号
	 * @return
	 * @throws BiffException
	 * @throws IOException
	 */
	public static Sheet getExcelSheet(String fileName, int index) 
		throws BiffException, IOException {
		
		Sheet sheet = null;
		Workbook workbook = getExcelWorkbook(fileName);
		if(workbook.getNumberOfSheets() >0) {
			sheet = workbook.getSheet(index);
		}
		return sheet;
	}
	
	
	public static Sheet getExcelSheet(File fis,int index)throws BiffException, IOException {
		Sheet sheet = null;
		   Workbook book = Workbook.getWorkbook(fis); 
		if(book.getNumberOfSheets() >0) {
			sheet = book.getSheet(index);
		}
		return sheet;
	}
	
	/**
	 * 获取Excel指定名称的工作表
	 * 
	 * @param fileName Excel文件名称
	 * @param sheetName 工作表名称
	 * @return
	 * @throws BiffException
	 * @throws IOException
	 */
	public static Sheet getExcelSheet(String fileName, String sheetName) 
		throws BiffException, IOException {
		
		Sheet sheet = null;
		Workbook workbook = getExcelWorkbook(fileName);
		sheet = workbook.getSheet(sheetName);
		return sheet;
	}
	
	/**
	 * 将Excel工作表转化成列表
	 * 
	 * @param sheet Excel工作表对象
	 * @param index 数据起始行序号
	 * @return 存放数据表的列表
	 * @throws Exception
	 */
	public static List<HashMap<String, String>> excelToList(Sheet sheet, int index)
		throws Exception {
		
		List<HashMap<String, String>> returnList = new ArrayList<HashMap<String, String>>();
		
		int rowCount = sheet.getRows();
		while(index <= (rowCount-1)) {
			Cell[] rowCells = sheet.getRow(index);
			HashMap<String, String> returnMap = 
				new HashMap<String, String>();
			
			for (int i = 0; i < rowCells.length; i++) {
				if(UtilValidate.isNotEmpty(rowCells[i].getContents())){
					returnMap.put(String.valueOf(i), rowCells[i].getContents());
				}
			}
			if(UtilValidate.isNotEmpty(returnMap)){
				returnList.add(returnMap);
			}
			index ++;
		}
		return returnList;
	}
	
	/**
	 * 获取Excel读取转换后的list列表
	 * 
	 * @param fileName Excel文件名称
	 * @param sheetIndex 工作表序列号
	 * @param dataIndex 数据起始行序号
	 * @return 存放数据表的列表
	 * @throws Exception
	 */
	public static List<HashMap<String, String>> getExcleList(String fileName, 
			int sheetIndex, int dataIndex) throws Exception {
		return excelToList(getExcelSheet(fileName, sheetIndex), dataIndex);
	}
	
	/**
	 * 获取Excel读取转换后的list列表
	 * 
	 * @param File fis 文件
	 * @param sheetIndex 工作表序列号
	 * @param dataIndex 数据起始行序号
	 * @return 存放数据表的列表
	 * @throws Exception
	 */
	public static List<HashMap<String, String>> getExcleList(File fis, 
			int sheetIndex, int dataIndex) throws Exception {
		return excelToList(getExcelSheet(fis, sheetIndex), dataIndex);
	}
}
