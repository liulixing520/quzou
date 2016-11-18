/**
 * <b>项目名：</b>ofbiz<br/>
 * <b>包名：</b>org.ofbiz.sysCommon.document<br/>
 * <b>文件名：</b>DocumentEvents.java<br/>
 *
 */
package org.ofbiz.ebiz.product;

import static org.ofbiz.base.util.UtilGenerics.checkList;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeUtility;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.FileUtil;
import org.ofbiz.base.util.UtilGenerics;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.transaction.GenericTransactionException;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;


/**
 * 
 * <b>类名称：</b>DocumentEvents<br/>
 * <b>类描述：</b>〈一句话功能简述〉<br/>
 * <b>类详细描述：</b>〈功能详细描述〉<br/>
 * <b>创建人：</b>WangYi<br/>
 * <b>修改人：</b>WangYi<br/>
 * <b>修改时间：</b>2013-2-18 下午2:22:41<br/>
 * <b>修改备注：</b><br/>
 * 
 * @version 1.0<br/>
 * 
 */
public class DocumentEvents
{
    public static final String module = DocumentEvents.class.getName();
    public static final String LABEL_RESOURCE = "DocumentUiLabels";
    public static final String ENTITY_LABEL_RESOURCE = "DocumentEntityLabels";

   
    /**
     * 通用的附件上传方法
     * @param request
     * @param response
     * @return
     */
    public static String commonAjaxFileUpload(HttpServletRequest request, HttpServletResponse response)
    {

        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");

        String result = ModelService.RESPOND_ERROR;
        String returnFilePath = "";
        String returnFileName = "";
        String callBack = "";
        String fileId = request.getParameter("fileId");
        Debug.log("fileId---------------------"+fileId);
        Map<String, Object> jsonMap = FastMap.newInstance();
        boolean beganTransaction = false;
        try
        {
            beganTransaction = TransactionUtil.begin();
            Map<String, Object> paramMap = FastMap.newInstance();

            FileItem fileItem = null;
            FileItemFactory factory = new DiskFileItemFactory(10240, FileUtil.getFile("runtime/tmp"));
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> items = UtilGenerics.<FileItem> checkList(upload.parseRequest(request));
            Iterator<FileItem> it = items.iterator();
            while (it.hasNext())
            {
                FileItem item = it.next();
                if (item.isFormField())
                {
                    String fieldName = item.getFieldName();
                    Object fieldValue = item.getString("UTF-8");

                    if (!paramMap.containsKey(fieldName))
                    {
                        paramMap.put(fieldName, fieldValue);
                    } else if (paramMap.containsKey(fieldName))
                    {
                        Object mapValue = paramMap.get(fieldName);
                        if (mapValue instanceof List<?>)
                        {
                            checkList(mapValue, Object.class).add(fieldValue);
                        } else if (mapValue instanceof String)
                        {
                            List<String> newList = FastList.newInstance();
                            newList.add((String) mapValue);
                            newList.add((String) fieldValue);
                            paramMap.put(fieldName, newList);
                        } else
                        {
                            Debug.logWarning("Form field found [" + fieldName + "] which was not handled!", module);
                        }
                    }
                } else
                {
                    if (item.getSize() > 0)
                    {
                    	String folder = request.getSession().getServletContext().getRealPath("/") + "/images/upload";
                    	StringBuffer url = request.getRequestURL();
                    	String path = url.substring(0, url.indexOf("/control"))+ "/images/upload";;
                        returnFileName= item.getFieldName();
                        if(fileId.equals(returnFileName)){
                        	Debug.log("returnFileName==="+returnFileName);
                        	returnFilePath = path+UtilFileUpload.saveFileItemToFile(item, folder);
                        	Debug.log("returnFilePath==="+returnFilePath); 
                        }
                    }
                }
            }
            result = ModelService.RESPOND_SUCCESS;
        } catch (Exception e)
        {
            callBack="<script>alert('上传失败')</script>";
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
            } catch (final GenericTransactionException e)
            {
                e.printStackTrace();
            }
        }
        callBack="<script>parent.fileImport_callBack('"+returnFilePath+"','"+returnFileName+"','"+fileId+"')</script>";
        print(response, callBack);
        return result;
    }
    
   

    /**
     * 通用模板文件下载
     * 
     * @param request
     * @param response
     *            传参：filePath(服务器端文件名,templates下),contentType
     * @return
     */
    public static String commonDownLoad(HttpServletRequest request, HttpServletResponse response)
    {
	try
	{
	    String filePath = "/templates/" + request.getParameter("fileName");
	    String realpath = request.getSession().getServletContext().getRealPath("/");
	    String contentType = request.getParameter("contentType") != null ? request.getParameter("contentType") : "application/vnd.ms-excel";
	    String fileName = request.getParameter("fileName") != null ? request.getParameter("fileName") : "模板";
	    if (UtilValidate.isNotEmpty(filePath))
	    {
		File file = new File(realpath + filePath);
		if (file.exists() && file.isFile())
		{
		    String contentDisposition = getContentDisposition(fileName, request.getHeader("user-agent"));
		    response.setContentType(contentType);
		    response.setHeader("Content-Disposition", contentDisposition);

		    int length = (int) file.length();

		    FileInputStream in = new FileInputStream(file);
		    response.setContentLength(length);

		    if (length != 0)
		    {
			byte[] buf = new byte[4096];
			ServletOutputStream op = response.getOutputStream();
			while ((in != null) && ((length = in.read(buf)) != -1))
			{
			    op.write(buf, 0, length);
			}
			in.close();
			op.flush();
			op.close();
		    }
		}
	    }
	} catch (Exception e)
	{
	    Debug.logError(e, module);
	}
	return "success";
    }
    
    /**
     * 手机端上传头像
     * @param request
     * @param response
     * @return
     */
    public static String commonAjaxPicUpload(HttpServletRequest request, HttpServletResponse response)
    {

        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");

        String result = "";
        String returnFilePath = "";
        String returnFileName = "";
        Map<String, Object> resultMap = FastMap.newInstance();
        Map<String, Object> jsonMap = FastMap.newInstance();
        boolean beganTransaction = false;
        try
        {
            beganTransaction = TransactionUtil.begin();
            Map<String, Object> paramMap = FastMap.newInstance();

            FileItem fileItem = null;
            FileItemFactory factory = new DiskFileItemFactory(10240, FileUtil.getFile("runtime/tmp"));
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> items = UtilGenerics.<FileItem> checkList(upload.parseRequest(request));
            Iterator<FileItem> it = items.iterator();
            while (it.hasNext())
            {
                FileItem item = it.next();
                if (item.isFormField())
                {
                    String fieldName = item.getFieldName();
                    Object fieldValue = item.getString("UTF-8");

                    if (!paramMap.containsKey(fieldName))
                    {
                        paramMap.put(fieldName, fieldValue);
                    } else if (paramMap.containsKey(fieldName))
                    {
                        Object mapValue = paramMap.get(fieldName);
                        if (mapValue instanceof List<?>)
                        {
                            checkList(mapValue, Object.class).add(fieldValue);
                        } else if (mapValue instanceof String)
                        {
                            List<String> newList = FastList.newInstance();
                            newList.add((String) mapValue);
                            newList.add((String) fieldValue);
                            paramMap.put(fieldName, newList);
                        } else
                        {
                            Debug.logWarning("Form field found [" + fieldName + "] which was not handled!", module);
                        }
                    }
                } else
                {
                    if (item.getSize() > 0)
                    {
                    	String folder = request.getSession().getServletContext().getRealPath("/") + "/images/upload";
                    	StringBuffer url = request.getRequestURL();
                    	String path = url.substring(0, url.indexOf("/control"))+ "/images/upload";;
                        returnFileName= item.getFieldName();
                    	Debug.log("returnFileName==="+returnFileName);
                    	returnFilePath = path+UtilFileUpload.saveFileItemToFile(item, folder);
                    	Debug.log("returnFilePath==="+returnFilePath); 
                    }
                }
            }
            result = returnFilePath;
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
            return result;
        } finally
        {
            try
            {
                TransactionUtil.commit(beganTransaction);
            } catch (final GenericTransactionException e)
            {
                e.printStackTrace();
                return result;
            }
        }
        return result;
    }
    /**
     * 手机端批量上传图片
     * @param request
     * @param response
     * @return
     */
    public static String commonAjaxPicUploadBatch(HttpServletRequest request, HttpServletResponse response)
    {
    	
    	LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
    	GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
    	
    	String result = "";
    	String returnFilePath = "";
    	String returnFileName = "";
    	Map<String, Object> resultMap = FastMap.newInstance();
    	Map<String, Object> jsonMap = FastMap.newInstance();
    	boolean beganTransaction = false;
    	try
    	{
    		beganTransaction = TransactionUtil.begin();
    		Map<String, Object> paramMap = FastMap.newInstance();
    		
    		FileItem fileItem = null;
    		FileItemFactory factory = new DiskFileItemFactory(10240, FileUtil.getFile("runtime/tmp"));
    		ServletFileUpload upload = new ServletFileUpload(factory);
    		List<FileItem> items = UtilGenerics.<FileItem> checkList(upload.parseRequest(request));
    		Iterator<FileItem> it = items.iterator();
    		while (it.hasNext())
    		{
    			FileItem item = it.next();
    			if (item.isFormField())
    			{
    				String fieldName = item.getFieldName();
    				Object fieldValue = item.getString("UTF-8");
    				
    				if (!paramMap.containsKey(fieldName))
    				{
    					paramMap.put(fieldName, fieldValue);
    				} else if (paramMap.containsKey(fieldName))
    				{
    					Object mapValue = paramMap.get(fieldName);
    					if (mapValue instanceof List<?>)
    					{
    						checkList(mapValue, Object.class).add(fieldValue);
    					} else if (mapValue instanceof String)
    					{
    						List<String> newList = FastList.newInstance();
    						newList.add((String) mapValue);
    						newList.add((String) fieldValue);
    						paramMap.put(fieldName, newList);
    					} else
    					{
    						Debug.logWarning("Form field found [" + fieldName + "] which was not handled!", module);
    					}
    				}
    			} else
    			{
    				if (item.getSize() > 0)
    				{
    					String folder = request.getSession().getServletContext().getRealPath("/") + "/images/upload";
    					StringBuffer url = request.getRequestURL();
    					String path = url.substring(0, url.indexOf("/control"))+ "/images/upload";;
    					returnFileName = item.getFieldName();
    					Debug.log("returnFileName==="+returnFileName);
    					returnFilePath = returnFilePath+path+UtilFileUpload.saveFileItemToFile(item, folder)+",";
    					Debug.log("returnFilePath==="+returnFilePath); 
    				}
    			}
    		}
    		returnFilePath = returnFilePath.substring(0, returnFilePath.length()-1);
    		result = returnFilePath;
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
    		return result;
    	} finally
    	{
    		try
    		{
    			TransactionUtil.commit(beganTransaction);
    		} catch (final GenericTransactionException e)
    		{
    			e.printStackTrace();
    			return result;
    		}
    	}
    	return result;
    }
    public static void print(HttpServletResponse response, Object obj)
    {
	try
	{
	    PrintWriter pw = response.getWriter();
	    pw.print(obj);
	    pw.flush();
	    pw.close();
	} catch (IOException e)
	{
	    e.printStackTrace();
	}
    }
    /**
     * getContentDisposition<br/>
     * 根据浏览器agent返回Http报头Content Disposition<br/>
     * 
     * @param fileName
     *            文件名
     * @param agent
     *            浏览器agent
     * @return ContentDisposition
     */
    public static String getContentDisposition(String fileName, String agent)
    {
        String newFileName = null;
        String contentDisposition = null;
        try
        {
            newFileName = URLEncoder.encode(fileName, "UTF8");
            contentDisposition = "attachment;filename=" + newFileName;

            if (agent != null)
            {
                if (agent.toUpperCase().indexOf("MSIE") > -1)
                {
                    // Internet Explorer mode
                    contentDisposition = "attachment;filename=" + newFileName;
                } else if (agent.toUpperCase().indexOf("APPLEWEBKIT") > -1)
                {
                    // Chrome mode
                    newFileName = MimeUtility.encodeText(fileName, "UTF8", "B");
                    contentDisposition = "attachment;filename=" + newFileName;
                } else if (agent.toUpperCase().indexOf("OPERA") != -1)
                {
                    // Opera mode
                    newFileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1");
                    contentDisposition = "attachment;filename*=UTF-8''" + newFileName;
                } else if (agent.toUpperCase().indexOf("MOZILLA") != -1)
                {
                    // FireFox mode
                    contentDisposition = "attachment;filename*=UTF-8''" + newFileName;
                } else if (agent.toUpperCase().indexOf("SAFARI") != -1)
                {
                    // Safari mode
                    newFileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1");
                    contentDisposition = "attachment;filename=" + newFileName;
                }
            }
        } catch (UnsupportedEncodingException e)
        {
            Debug.logError(e.getMessage(), module);
        }
        return contentDisposition;
    }
}
