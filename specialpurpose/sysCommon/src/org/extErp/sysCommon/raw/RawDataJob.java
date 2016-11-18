package org.extErp.sysCommon.raw;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimerTask;

import jxl.Sheet;
import jxl.Workbook;

import org.apache.commons.httpclient.util.DateUtil;
import org.ofbiz.base.util.FileUtil;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.DelegatorFactory;
import org.ofbiz.entity.GenericValue;

public class RawDataJob extends TimerTask
{

    @Override
    public void run()
    {
	System.out.println("start data job ===" + DateUtil.formatDate(new Date()));
	String rootFolder = "E:\\work\\workspace\\lims_102\\specialpurpose\\lims\\webapp\\lims\\images\\upload";
	run2(rootFolder);
	System.out.println("end data job ===" + DateUtil.formatDate(new Date()));
    }

    public void run2(String rootFolder)
    {
	Map<String, String> dataMap = new HashMap();
	Workbook wb = null;
	Delegator delegator = null;
	try
	{
	    List<File> excelFiles = FileUtil.findFiles("xls", rootFolder, null, null);
	    Iterator<File> it = excelFiles.iterator();
	    String templateGroupId = "";
	    String revId = "";
			String detectionBillCode = "";// 检测单唯一编码
	    while (it.hasNext())
	    {
		File file = it.next();
		wb = Workbook.getWorkbook(new FileInputStream(file));
				// 得到excel 所有工作表
		delegator = DelegatorFactory.getDelegator(null);
		Sheet[] sheets = wb.getSheets();

		List<GenericValue> templateList = new ArrayList();
                templateList = delegator.findByAnd("RawTemplate", null, null, false);
                List<GenericValue> templateGroupList = delegator.findByAnd("RawTemplateGroup", null, null, false);
		String fileName=file.getName().trim();
		if (fileName.indexOf("_") != -1)
		{
					// 从文件名中截取检测单编码
		    detectionBillCode = fileName.substring(fileName.lastIndexOf("_") + 1, fileName.indexOf("."));
		}
		for (GenericValue templateGroup : templateGroupList)
		{
		    if (fileName.indexOf(templateGroup.get("templateGroupName").toString()) != -1)
		    {
			templateGroupId = templateGroup.get("templateGroupId").toString();

			revId = delegator.getNextSeqId("RawDataRev");
						GenericValue gv = delegator.makeValue("RawDataRev", "revId", revId, "templateGroupId", templateGroupId, "operUserLoginId", "admin", "importType", "系统抓取",
				"detectionBillCode", detectionBillCode);
			gv.create();

			if (sheets != null && sheets.length > 0)
			{
			    for (int i = 0; i < sheets.length; i++)
			    {
				Sheet sheet = sheets[i];
				for (GenericValue template : templateList)
				{
				    if (sheet.getName().trim().equals(template.get("templateName")))
				    {
					List<GenericValue> rawCrosstabList = new ArrayList();
                                        rawCrosstabList = delegator.findByAnd("RawCrossConfig", UtilMisc.toMap("templateId", template.get("templateId")), null, false);
										// 临时处理方法，提交时先删除该模板已经上传的数据，以后需改为有版本信息
					// delegator.removeByAnd("RawCrossData",
					// UtilMisc.toMap("templateId",
					// template.get("templateId")));
					for (GenericValue crossGv : rawCrosstabList)
					{
					    GenericValue dataGv = delegator.makeValue("RawCrossData", UtilMisc.toMap("templateId", template.get("templateId"), "revId", revId,
						    "excelGrid", crossGv.get("excelGrid"), "excelData", sheet.getCell(crossGv.get("excelGrid").toString()).getContents()));
					    dataGv.create();
					}
				    }
				}
			    }
			}
		    }
		}
	    }

	} catch (Exception e)
	{
	    e.printStackTrace();
	}
    }

    public void run1(String rootFolder)
    {
	Map<String, String> dataMap = new HashMap();
	Workbook wb = null;
	Delegator delegator = null;
	try
	{
	    List<File> excelFiles = FileUtil.findFiles("xls", rootFolder, null, null);
	    Iterator<File> it = excelFiles.iterator();
	    while (it.hasNext())
	    {
		File file = it.next();
		wb = Workbook.getWorkbook(new FileInputStream(file));
				// 得到excel 所有工作表
		delegator = DelegatorFactory.getDelegator(null);
		Sheet[] sheets = wb.getSheets();
		List<GenericValue> rawCrosstabList = new ArrayList();
		List<GenericValue> themeList = new ArrayList();
                themeList = delegator.findByAnd("RawTheme", null, null, false);
		if (sheets != null && sheets.length > 0)
		{
		    for (int i = 0; i < sheets.length; i++)
		    {
			Sheet sheet = sheets[i];
			for (GenericValue theme : themeList)
			{
			    if (sheet.getName().trim().equals(theme.get("themeName")))
			    {
                                rawCrosstabList = delegator.findByAnd("RawCrosstab", UtilMisc.toMap("themeId", theme.get("themeId")), null, false);
								// 临时处理方法，提交时先删除该模板已经上传的数据，以后需改为有版本信息
				delegator.removeByAnd("RawCrosstabData", UtilMisc.toMap("themeId", theme.get("themeId")));
				for (GenericValue gv : rawCrosstabList)
				{
				    dataMap.put(theme.get("themeId") + "_" + gv.get("excelGrid"), sheet.getCell(gv.get("excelGrid").toString()).getContents());
				}
			    }
			}
		    }
		}
	    }
	    for (String cellKey : dataMap.keySet())
	    {
		GenericValue gv = delegator.makeValue("RawCrosstabData", UtilMisc.toMap("themeId", cellKey.substring(0, cellKey.indexOf("_")), "excelGrid",
			cellKey.substring(cellKey.indexOf("_") + 1, cellKey.length()), "excelData", dataMap.get(cellKey)));
		gv.create();
	    }
	} catch (Exception e)
	{
	    e.printStackTrace();
	}
    }

}
