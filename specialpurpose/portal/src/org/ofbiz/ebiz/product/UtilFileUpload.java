package org.ofbiz.ebiz.product;

import static org.ofbiz.base.util.UtilGenerics.checkList;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.FileUtil;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilGenerics;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;

/**
 * 附件保存至指定目录下contentUpload.properties
 * 
 * @author Administrator
 * 
 */
public class UtilFileUpload
{

    public static final String module = UtilFileUpload.class.getName();

    public static final String DATE_FOLDER_FORMAT = "yyyyMMdd";

    public static final Boolean useDebug = UtilProperties.getPropertyAsBoolean("contentUpload.properties", "isable.debug.config", false);

    /**
     * 附件上传处理<br/>
     * 上传文件处理,不进行文件类型过滤<br/>
     * 
     * @param folder
     * @param request
     * @return
     * @throws Exception
     */
    public static Map<String, Object> uploadFile(String folder, HttpServletRequest request) throws Exception
    {
	return uploadFile(null, folder, request);
    }

    /**
     * uploadFile 上传文件处理<br/>
     * 上传文件处理,支持文件类型过滤<br/>
     * 
     * @param folder
     *            默认目录
     * @param mimeTypeId
     *            文件类型
     * @param request
     * @return
     * @throws Exception
     */
    public static Map<String, Object> uploadFile(String mimeTypeId, String folder, HttpServletRequest request) throws Exception
    {
	Map<String, Object> context = FastMap.newInstance();
	FileItemFactory factory = new DiskFileItemFactory(10240, FileUtil.getFile("runtime/tmp"));
	// 默认上传文件是10240, 不够可以修改这个参数为下面这种,可以指定缓存大小.new
	// DiskFileItemFactory(10240,FileUtil.getFile("runtime/tmp"));
	ServletFileUpload upload = new ServletFileUpload(factory);

	try
	{
	    List<FileItem> items = UtilGenerics.<FileItem> checkList(upload.parseRequest(request));

	    Iterator<FileItem> it = items.iterator();
	    while (it.hasNext())
	    {
		FileItem fileItem = it.next();
		if (fileItem.isFormField())
		{
		    String fieldName = fileItem.getFieldName();
		    Object fieldValue = fileItem.getString("UTF-8");

		    if (!context.containsKey(fieldName))
		    {
			context.put(fieldName, fieldValue);
		    } else if (context.containsKey(fieldName))
		    {
			Object mapValue = context.get(fieldName);
			if (mapValue instanceof List<?>)
			{
			    checkList(mapValue, Object.class).add(fieldValue);
			} else if (mapValue instanceof String)
			{
			    List<String> newList = FastList.newInstance();
			    newList.add((String) mapValue);
			    newList.add((String) fieldValue);
			    context.put(fieldName, newList);
			} else
			{
			    Debug.logWarning("Form field found [" + fieldName + "] which was not handled!", module);
			}
		    }
		} else
		{
		    if (fileItem.getSize() > 0)
		    {
			String mimeTypeCheckIsOn = UtilProperties.getPropertyValue("sysCommon", "mimeTypeCheckIsOn", "Y");
			if (mimeTypeCheckIsOn.equals("Y") && UtilValidate.isNotEmpty(mimeTypeId))// 注释限制文件类型上传的代码.
			{
			    String contentType = fileItem.getContentType();
			    if (UtilValidate.isNotEmpty(contentType) && !mimeTypeId.equalsIgnoreCase(contentType))
			    {
				Debug.logError("上传文件类型不匹配", module);
				throw new Exception("上传文件类型不匹配");
			    }
			}

			String filePath = saveFileItemToFile(fileItem, folder);
			context.put("fileName", FilenameUtils.getBaseName(fileItem.getName()));
			context.put("contentType", fileItem.getContentType());
			context.put("filePath", filePath);
			context.put(fileItem.getFieldName(), filePath);
		    }
		}
	    }
	} catch (Exception e)
	{
	    Debug.logError(e.getMessage(), module);
	    if (useDebug)
	    {
		throw e;
	    }
	}
	return context;
    }

    /**
     * 
     * download(附件下载)<br/>
     * 
     * @param filePath
     *            附件绝对路径
     * @param oldName
     *            原文件名
     * @return
     */
    public static boolean downloadFile(String filePath, String oldName, HttpServletResponse response)
    {
	boolean result = false;
	InputStream in = null;
	OutputStream os = null;

	try
	{
	    File file = new File(filePath);
	    if (file.length() > 0)
	    {
		result = true;
	    }
	    in = new FileInputStream(file);
	    os = response.getOutputStream();
	    response.addHeader("Content-Disposition", "attachment;filename=" + new String(oldName.getBytes("gbk"), "iso-8859-1"));
	    response.addHeader("Content-Length", file.length() + "");
	    response.setCharacterEncoding("gbk");
	    response.setContentType("application/octet-stream");
	    int data = 0;
	    while ((data = in.read()) != -1)
	    {
		os.write(data);
	    }

	} catch (Exception e)
	{
	    e.printStackTrace();
	} finally
	{
	    try
	    {
		if (os != null)
		    os.close();
	    } catch (IOException e1)
	    {
		e1.printStackTrace();
	    } finally
	    {
		try
		{
		    if (in != null)
		    {
			in.close();
		    }
		} catch (IOException e)
		{
		    e.printStackTrace();
		}
	    }
	}

	return result;
    }

    /**
     * saveFileItemToFile<br/>
     * 将每个文件的 FileItem存储到指定的文件夹下,存储的时候在指定文件夹下按照日期时间归档存储<br/>
     * 
     * @param fileItem
     * @param folder
     * @return 存储以后的文件路径
     * @throws Exception
     */
    public static String saveFileItemToFile(FileItem fileItem, String folder) throws Exception
    {
	String uuid = UtilUUID.uuidTomini();
	String extension = FilenameUtils.getExtension(fileItem.getName());

	String filePath = UtilDateTime.nowDateString(DATE_FOLDER_FORMAT);
	File saveFilePath = new File(folder + filePath);
	if (!saveFilePath.exists())
	{
	    saveFilePath.mkdirs();
	}

	filePath = filePath + "/" + uuid + FilenameUtils.EXTENSION_SEPARATOR_STR + extension.toLowerCase();
	File saveFile = new File(folder + filePath);
	if (!saveFile.exists())
	{
	    saveFile.createNewFile();
	}

	fileItem.write(saveFile);

	return filePath;
    }
}
