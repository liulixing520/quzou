package org.extErp.sysCommon.raw;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javolution.util.FastMap;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.extErp.sysCommon.content.UtilFileUpload;
import org.extErp.sysCommon.document.DocumentHelper;
import org.extErp.sysCommon.util.JsonUtil;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilFormatOut;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.transaction.GenericTransactionException;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;

public class RawEvents
{
    public static final String module = RawEvents.class.getName();
    public static final String DCT_PPS = "RawTemplateGroup";
    
	/**
	 * 创建模板以及指标配置
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
    public static String createRawTheme(HttpServletRequest request, HttpServletResponse response)
    {
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
        try
        {
            String IMAGE_FOLDER = request.getSession().getServletContext().getRealPath("/") + "/images/upload/";
            Map<String, Object> context = UtilFileUpload.uploadFile(IMAGE_FOLDER, request);
            context.put("excelPath", context.get("filePath"));
            context.put("userLogin", userLogin);
            ModelService pService = dispatcher.getDispatchContext().getModelService("createRawTheme");
            context = pService.makeValid(context, ModelService.IN_PARAM);
            dispatcher.runSync(pService.name, context);

			JsonUtil.toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功", "callbackType", "closeCurrent", "navTabId", "FindRawTheme"), response);

        } catch (Exception e)
        {
            Debug.logError(e.getMessage(), module);
			JsonUtil.toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作失败，请检查是否重复行列指标", "callbackType", "closeCurrent", "navTabId", "FindRawTheme"), response);

            return ModelService.RESPOND_ERROR;
        }
        return ModelService.RESPOND_SUCCESS;
    }

    /**
	 * 更新模板以及指标配置
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
    public static String updateRawTheme(HttpServletRequest request, HttpServletResponse response)
    {
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
        try
        {
            String IMAGE_FOLDER = request.getSession().getServletContext().getRealPath("/") + "/images/upload/";
            Map<String, Object> context = UtilFileUpload.uploadFile(IMAGE_FOLDER, request);
            context.put("excelPath", context.get("filePath"));
            context.put("userLogin", userLogin);
            ModelService pService = dispatcher.getDispatchContext().getModelService("updateRawTheme");
            context = pService.makeValid(context, ModelService.IN_PARAM);
            dispatcher.runSync(pService.name, context);

			JsonUtil.toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功", "callbackType", "closeCurrent", "navTabId", "FindRawTheme"), response);

        } catch (Exception e)
        {
            Debug.logError(e.getMessage(), module);
			JsonUtil.toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作失败，请检查是否重复行列指标", "callbackType", "closeCurrent", "navTabId", "FindRawTheme"), response);

            return ModelService.RESPOND_ERROR;
        }
        return ModelService.RESPOND_SUCCESS;
    }

    /**
	 * 二维上传excel并入库
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
    public static String importExcelToRawDb(HttpServletRequest request, HttpServletResponse response)
    {
        GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
        Delegator delegator = (GenericDelegator) request.getAttribute("delegator");
        String IMAGE_FOLDER = request.getSession().getServletContext().getRealPath("/") + "/images/upload/";

        try
        {
            Map<String, Object> context = uploadFile(IMAGE_FOLDER, request, delegator);
            context.put("excelPath", context.get("filePath"));
            context.put("userLogin", userLogin);
            // ModelService pService =
            // dispatcher.getDispatchContext().getModelService("createRawTheme");
            // context = pService.makeValid(context,
            // ModelService.IN_PARAM);
            // dispatcher.runSync(pService.name, context);
            if (context.get("dataMap") != null)
            {
                Map<String, String> dataMap = ((HashMap<String, String>) context.get("dataMap"));
                for (String cellKey : dataMap.keySet())
                {
                    GenericValue gv = delegator.makeValue("RawCrosstabData", UtilMisc.toMap("themeId", cellKey.substring(0, cellKey.indexOf("_")), "excelGrid",
                            cellKey.substring(cellKey.indexOf("_") + 1, cellKey.length()), "excelData", dataMap.get(cellKey)));
                    gv.create();
                }
            }
			JsonUtil.toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功", "callbackType", "closeCurrent", "navTabId", "FindRawTheme"), response);
        } catch (Exception e)
        {
            Debug.logError(e.getMessage(), module);
			JsonUtil.toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "上传失败", "callbackType", "closeCurrent", "navTabId", "FindRawTheme"), response);

            return ModelService.RESPOND_ERROR;
        }
        return ModelService.RESPOND_SUCCESS;
    }

    /**
	 * 多维上传excel并入库
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
    public static String importExcelToRawDataDb(HttpServletRequest request, HttpServletResponse response)
    {
        GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
        Delegator delegator = (GenericDelegator) request.getAttribute("delegator");
        String IMAGE_FOLDER = request.getSession().getServletContext().getRealPath("/") + "/images/upload/";

        try
        {
            Map<String, Object> context = getRawDataFile(IMAGE_FOLDER, request, delegator);
            context.put("excelPath", context.get("filePath"));
            context.put("userLogin", userLogin);
            String templateGroupId = context.get("templateGroupId").toString();
			// 创建新版本
            String newRevId = delegator.getNextSeqId("RawDataRev");
            GenericValue gv = delegator.makeValue("RawDataRev", "revId", newRevId, "detectionBillCode", context.get("detectionBillCode"), "templateGroupId", templateGroupId,
				"operUserLoginId", userLogin.get("userLoginId"), "importType", "文件上传");
            gv.create();
            if (context.get("dataMap") != null)
            {
                Map<String, String> dataMap = ((HashMap<String, String>) context.get("dataMap"));
                for (String cellKey : dataMap.keySet())
                {
                    GenericValue dataGv = delegator.makeValue(
                            "RawCrossData",
                            UtilMisc.toMap("revId", newRevId, "templateId", cellKey.substring(0, cellKey.indexOf("_")), "excelGrid",
                                    cellKey.substring(cellKey.indexOf("_") + 1, cellKey.length()), "excelData", dataMap.get(cellKey)));
                    dataGv.create();
                }
            }
            request.setAttribute("revId", newRevId);
            request.setAttribute("detectionBillCode", context.get("detectionBillCode"));
            // JsonUtil.toJsonObject(UtilMisc.toMap("statusCode",
			// "200", "message", "操作成功", "callbackType",
            // "closeCurrent", "navTabId", "FindRawTheme"), response);
        } catch (Exception e)
        {
            Debug.logError(e.getMessage(), module);
            // JsonUtil.toJsonObject(UtilMisc.toMap("statusCode",
			// "200", "message", "上传失败", "callbackType",
            // "closeCurrent", "navTabId", "FindRawTheme"), response);

            return ModelService.RESPOND_ERROR;
        }
        return ModelService.RESPOND_SUCCESS;
    }

    /**
	 * 前台页面编辑原始记录并保存
	 */
    public static String webToRawDb(HttpServletRequest request, HttpServletResponse response)
    {
        HttpSession session = request.getSession();
        Delegator delegator = (Delegator) request.getAttribute("delegator");
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
        Map<String, Object> paramMap = UtilHttp.getParameterMap(request);
        try
        {
            String revId = UtilFormatOut.safeToString(paramMap.get("revId"));
            String templateGroupId = paramMap.get("templateGroupId").toString();
			// 创建新版本
            String newRevId = delegator.getNextSeqId("RawDataRev");
            GenericValue gv = delegator.makeValue("RawDataRev", "revId", newRevId, "detectionBillCode", paramMap.get("detectionBillCode"), "templateGroupId", templateGroupId,
				"operUserLoginId", "admin", "importType", "web编辑");
            gv.create();
			// 保存从web页面填写的记录 key[templateId_crossId_measureId]
            List<GenericValue> templateList = delegator.findByAnd("RawTemplate", UtilMisc.toMap("templateGroupId", templateGroupId), null, false);
            for (GenericValue temGv : templateList)
            {
                List<GenericValue> crossConfigList = delegator.findByAnd("RawCrossConfig", UtilMisc.toMap("templateId", temGv.get("templateId")), null, false);
                for (GenericValue crossConfigGv : crossConfigList)
                {
                    GenericValue dataGv = delegator.makeValue(
                            "RawCrossData",
                            UtilMisc.toMap("templateId", temGv.get("templateId"), "revId", newRevId, "excelGrid", crossConfigGv.get("excelGrid"), "excelData",
                                    paramMap.get(temGv.get("templateId") + "_" + crossConfigGv.get("crossId") + "_" + crossConfigGv.get("measureId"))));
                    dataGv.create();
                }
            }

        } catch (Exception e)
        {
            e.printStackTrace();
        }
        return ModelService.RESPOND_SUCCESS;
    }

    /**
	 * 多维指标 excel数据处理 获取excel行列键值对-数据
	 * 
	 * @param imageFolder
	 * @param request
	 * @return
	 * @throws Exception
	 */
    public static Map<String, Object> getRawDataFile(String imageFolder, HttpServletRequest request, Delegator delegator) throws Exception
    {

        Map<String, Object> context = FastMap.newInstance();
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        Map<Object, String> dataMap = new HashMap<Object, String>();
        Workbook wb = null;
        List<GenericValue> rawCrosstabList = new ArrayList<GenericValue>();
        List<GenericValue> templateList = new ArrayList<GenericValue>();
        try
        {
            templateList = delegator.findByAnd("RawTemplate", null, null, false);

            List<FileItem> parseRequest = upload.parseRequest(request);
            List<FileItem> items = parseRequest;
            Iterator<FileItem> it = items.iterator();
            while (it.hasNext())
            {
                FileItem fileItem = it.next();
                if (fileItem.isFormField())
                {
                    String fieldName = fileItem.getFieldName();
                    String fieldValue = fileItem.getString("UTF-8");

                    if (!context.containsKey(fieldName))
                    {
                        context.put(fieldName, fieldValue);
                    } else
                    {
                        String old = (String) context.get(fieldName);
                        context.put(fieldName, old + ";" + fieldValue);
                    }

                } else
                {
                    if (fileItem.getSize() > 0)
                    {
						String fileName = fileItem.getName(); // 在这里可以记录用户和文件信息
                        wb = Workbook.getWorkbook(fileItem.getInputStream());
						// 得到excel 所有工作表
                        Sheet[] sheets = wb.getSheets();
                        if (sheets != null && sheets.length > 0)
                        {
                            for (int i = 0; i < sheets.length; i++)
                            {
                                Sheet sheet = sheets[i];
                                for (GenericValue template : templateList)
                                {
                                    if (sheet.getName().trim().equals(template.get("templateName")))
                                    {
                                        rawCrosstabList = delegator.findByAnd("RawCrossConfig", UtilMisc.toMap("templateId", template.get("templateId")), null, false);
										// 临时处理方法，提交时先删除该模板已经上传的数据，以后需改为有版本信息
                                        // delegator.removeByAnd("RawCrossData",
                                        // UtilMisc.toMap("templateId",
                                        // template.get("templateId")));
                                        for (GenericValue gv : rawCrosstabList)
                                        {
                                            Cell cell=null;
					    try
					    {
						cell=sheet.getCell(gv.get("excelGrid").toString());
					    } catch (ArrayIndexOutOfBoundsException e)
					    {
												Debug.logError("超出范围", module);
					    }
					    if (cell != null)
					    dataMap.put(template.get("templateId") + "_" + gv.get("excelGrid"), cell.getContents());
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
            Debug.log("" + e.getMessage(), module);

        }
        context.put("dataMap", dataMap);
        return context;
    }

    /**
	 * 二维指标 excel数据处理 获取excel行列键值对-数据
	 * 
	 * @param imageFolder
	 * @param request
	 * @return
	 * @throws Exception
	 */
    public static Map<String, Object> uploadFile(String imageFolder, HttpServletRequest request, Delegator delegator) throws Exception
    {

        Map<String, Object> context = FastMap.newInstance();
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        Map dataMap = new HashMap();
        Workbook wb = null;
        List<GenericValue> rawCrosstabList = new ArrayList();
        List<GenericValue> themeList = new ArrayList();
        try
        {
            themeList = delegator.findByAnd("RawTheme", null, null, false);

            List<FileItem> items = upload.parseRequest(request);
            Iterator<FileItem> it = items.iterator();
            while (it.hasNext())
            {
                FileItem fileItem = it.next();
                if (fileItem.isFormField())
                {
                    String fieldName = fileItem.getFieldName();
                    String fieldValue = fileItem.getString("UTF-8");

                    if (!context.containsKey(fieldName))
                    {
                        context.put(fieldName, fieldValue);
                    } else
                    {
                        String old = (String) context.get(fieldName);
                        context.put(fieldName, old + ";" + fieldValue);
                    }

                } else
                {
                    if (fileItem.getSize() > 0)
                    {
						String fileName = fileItem.getName(); // 在这里可以记录用户和文件信息
                        wb = Workbook.getWorkbook(fileItem.getInputStream());
						// 得到excel 所有工作表
                        Sheet[] sheets = wb.getSheets();
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
                }
            }

        } catch (Exception e)
        {
            e.printStackTrace();
            Debug.log("" + e.getMessage(), module);

        }
        context.put("dataMap", dataMap);
        return context;
    }

    /**
	 * 创建模板组
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
    public static String createRawTemplateGroup(HttpServletRequest request, HttpServletResponse response)
    {
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
	Delegator delegator = (Delegator) request.getAttribute("delegator");

	boolean beganTransaction = false;
        try
	{
	    beganTransaction = TransactionUtil.begin();
	    Map<String, Object> context = FastMap.newInstance();
            context.put("userLogin", userLogin);

	    String relatedIdValue = delegator.getNextSeqId("RawTemplateGroup");

			// 上传资源并生成关联
	    Map<String, Object> uploadResult = DocumentHelper.uploadSysDocByPurpose(request, DCT_PPS, relatedIdValue);
	    if (ServiceUtil.isError(uploadResult))
	    {
		throw new Exception(ServiceUtil.getErrorMessage(uploadResult));
	    }
			// 回写到模板
	    ModelService modelService = dispatcher.getDispatchContext().getModelService("createRawTemplateGroup");
	    uploadResult.put("userLogin", userLogin);
	    uploadResult.put("templateGroupId", relatedIdValue);
	    Map<String, Object> entitylMap = modelService.makeValid(uploadResult, ModelService.IN_PARAM);
			dispatcher.runSync("createRawTemplateGroup", entitylMap);// 调用服务pk=INOUT
        } catch (Exception e)
        {
	    try
	    {
		TransactionUtil.rollback(beganTransaction, e.getLocalizedMessage(), e);
	    } catch (GenericTransactionException e1)
	    {
		e1.printStackTrace();
	    }
	    Debug.logError(e, e.getLocalizedMessage(), module);
	} finally
	{
	    try
	    {
		TransactionUtil.commit(beganTransaction);
	    } catch (GenericTransactionException e)
	    {
		e.printStackTrace();
	    }
	}

        return ModelService.RESPOND_SUCCESS;
    }

    /**
	 * 
	 * updateRawTemplateGroup(附件上传)<br/>
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
    public static String updateRawTemplateGroup(HttpServletRequest request, HttpServletResponse response)
    {

	LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");

	boolean beganTransaction = false;
	try
	{
	    beganTransaction = TransactionUtil.begin();

			Map<String, Object> uploadResult = DocumentHelper.uploadSysDocByPurpose(request, DCT_PPS, null);// 更新的时候,不需要当前实体主键传入,会从表单中自动获取
	    if (UtilValidate.isEmpty(uploadResult))
	    {
				Debug.logError("上传文件失败", module);
		return "error";
	    }

	    uploadResult.put("userLogin", userLogin);
	    ModelService pService = dispatcher.getDispatchContext().getModelService("updateRawTemplateGroup");
	    uploadResult = pService.makeValid(uploadResult, ModelService.IN_PARAM);
	    dispatcher.runSync(pService.name, uploadResult);
	} catch (Exception e)
	{
	    try
	    {
		TransactionUtil.rollback(beganTransaction, e.getLocalizedMessage(), e);
	    } catch (GenericTransactionException e1)
	    {
		e1.printStackTrace();
	    }
	    Debug.logError(e, e.getLocalizedMessage(), module);
	} finally
	{
	    try
	    {
		TransactionUtil.commit(beganTransaction);
	    } catch (GenericTransactionException e)
	    {
		e.printStackTrace();
	    }
	}
	return ModelService.RESPOND_SUCCESS;
    }
}
