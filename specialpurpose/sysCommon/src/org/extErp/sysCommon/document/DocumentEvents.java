/**
 * <b>项目名：</b>ofbiz_lims<br/>
 * <b>包名：</b>org.ofbiz.sysCommon.document<br/>
 * <b>文件名：</b>DocumentEvents.java<br/>
 * <b>日期：</b>2013-2-18-下午2:22:41<br/>
 * <b>Copyright 2012-2015 北京远航科峰软件技术有限公司. All Rights Reserved.<br/>
 *
 */
package org.extErp.sysCommon.document;

import static org.ofbiz.base.util.UtilGenerics.checkList;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.extErp.sysCommon.content.UtilFileUpload;
import org.extErp.sysCommon.util.JsonUtil;
import org.extErp.sysCommon.util.PrintWriterUtil;
import org.extErp.sysCommon.util.VideoCutUtil;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.FileUtil;
import org.ofbiz.base.util.UtilGenerics;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.transaction.GenericTransactionException;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.service.GenericServiceException;
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
    public static final String imageFolder = UtilProperties.getPropertyValue("commonconf.properties", "pcpos.toux");

    /**
     * 文档下载<br/>
     * 以二进制流的形式下载文档<br/>
     * 
     * @param request
     * @param response
     * @return
     */
    public static String downloadSysDoc(HttpServletRequest request, HttpServletResponse response)
    {
        try
        {
            GenericDelegator delegator = (GenericDelegator) request.getAttribute("delegator");
            String sysDocPurposeId = request.getParameter("sysDocPurposeId");
            String relatedIdValue = request.getParameter("relatedIdValue");

            GenericValue docRef = DocumentWorkers.findSysDocRef(sysDocPurposeId, relatedIdValue, delegator);
            if (docRef != null)
            {
                String objectInfo = docRef.getString("objectInfo");
                String suffix = objectInfo.substring(objectInfo.lastIndexOf("."));
                String fileName = docRef.getString("docName") + suffix;

                String path = docRef.getString("path");
                if (UtilValidate.isEmpty(path))
                {
                    path = docRef.getString("sysDocPurposeId");
                }

                String inApp = docRef.getString("inApp");
                String filePath = DocumentUtils.getFilePath(request, "sysCommon", "temp.file.relative.path", path, inApp) + objectInfo;

                String mimeTypeId = docRef.getString("mimeTypeId");
                File file = new File(filePath);
                if (file.exists() && file.isFile())
                {
                    String contentType = UtilValidate.isEmpty(mimeTypeId) ? "application/octet-stream" : mimeTypeId;
                    String contentDisposition = DocumentUtils.getContentDisposition(fileName, request.getHeader("user-agent"));
                    int length = (int) file.length();

                    FileInputStream in = new FileInputStream(file);
                    response.setContentType(contentType);
                    response.setHeader("Content-Disposition", contentDisposition);
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
        } catch (FileNotFoundException e)
        {
            Debug.logError(e.getMessage(), module);
        } catch (IOException e)
        {
            Debug.logError(e.getMessage(), module);
        }
        return "success";
    }

    /**
     * 文档下载-<br/>
     * 以word控件打开文档<br/>
     * 
     * @param request
     * @param response
     * @return
     */
    public static String downloadSysDocWord(HttpServletRequest request, HttpServletResponse response)
    {
        try
        {
            GenericDelegator delegator = (GenericDelegator) request.getAttribute("delegator");
            String sysDocPurposeId = request.getParameter("sysDocPurposeId");
            String relatedIdValue = request.getParameter("relatedIdValue");

            GenericValue docRef = DocumentWorkers.findSysDocRef(sysDocPurposeId, relatedIdValue, delegator);
            if (docRef != null)
            {
                String objectInfo = docRef.getString("objectInfo");
                String suffix = objectInfo.substring(objectInfo.lastIndexOf("."));
                String fileName = docRef.getString("docName") + suffix;

                String path = docRef.getString("path");
                if (UtilValidate.isEmpty(path))
                {
                    path = docRef.getString("sysDocPurposeId");
                }

                String inApp = docRef.getString("inApp");
                String filePath = DocumentUtils.getFilePath(request, "sysCommon", "temp.file.relative.path", path, inApp) + objectInfo;

                String mimeTypeId = docRef.getString("mimeTypeId");
                File file = new File(filePath);
                if (file.exists() && file.isFile())
                {
                    String contentType = UtilValidate.isEmpty(mimeTypeId) ? "application/octet-stream" : mimeTypeId;
                    String contentDisposition = DocumentUtils.getContentDisposition(fileName, request.getHeader("user-agent"));
                    response.setContentType(contentType);
                    response.setHeader("Content-Disposition", contentDisposition);

                    PrintWriter out = response.getWriter();
                    out.print(file.length());
                }
            }
        } catch (FileNotFoundException e)
        {
            Debug.logError(e.getMessage(), module);
        } catch (IOException e)
        {
            Debug.logError(e.getMessage(), module);
        }
        return "success";
    }

    /**
     * downloadDocById<br/>
     * 直接根据资源ID和坐在的目录到OFBiz的ROOT下下载文件<br/>
     * 
     * @param request
     * @param response
     * @return
     */
    public static String downloadDocById(HttpServletRequest request, HttpServletResponse response)
    {
        try
        {
            GenericDelegator delegator = (GenericDelegator) request.getAttribute("delegator");
            String sysDocId = request.getParameter("id");
            String path = request.getParameter("path");

            GenericValue doc = delegator.findOne("SysDocSource", UtilMisc.toMap("sysDocSourceId", sysDocId), false);
            if (doc != null)
            {
                String objectInfo = doc.getString("objectInfo");
                String suffix = objectInfo.substring(objectInfo.lastIndexOf("."));
                String fileName = doc.getString("docName") + suffix;

                String filePath = System.getProperty("ofbiz.home") + "/" + path;
                if (!filePath.endsWith("/"))
                {
                    filePath += "/";
                }
                filePath += objectInfo;

                String mimeTypeId = doc.getString("mimeTypeId");
                File file = new File(filePath);
                if (file.exists() && file.isFile())
                {
                    String contentType = UtilValidate.isEmpty(mimeTypeId) ? "application/octet-stream" : mimeTypeId;
                    String contentDisposition = DocumentUtils.getContentDisposition(fileName, request.getHeader("user-agent"));
                    int length = (int) file.length();

                    FileInputStream in = new FileInputStream(file);
                    response.setContentType(contentType);
                    response.setHeader("Content-Disposition", contentDisposition);
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
        } catch (FileNotFoundException e)
        {
            Debug.logError(e.getMessage(), module);
        } catch (IOException e)
        {
            Debug.logError(e.getMessage(), module);
        } catch (GenericEntityException e)
        {
            Debug.logError(e.getMessage(), module);
        }
        return "success";
    }

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

    		FileItemFactory factory = new DiskFileItemFactory();
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
                        returnFileName= item.getFieldName();
                        if(fileId.equals(returnFileName)){
                        	InputStream input = item.getInputStream();
                        	ByteArrayOutputStream swapStream = new ByteArrayOutputStream(); 
                        	byte[] buff = new byte[100]; //buff用于存放循环读取的临时数据 
                        	int rc = 0; 
                        	while ((rc = input.read(buff, 0, 100)) > 0) { 
                        		swapStream.write(buff, 0, rc); 
                        	} 
                        	ByteBuffer uploadedFile = ByteBuffer.wrap(swapStream.toByteArray());
                        	Map servicMap = FastMap.newInstance();
                        	servicMap.put("uploadedFile", uploadedFile);
                        	servicMap.put("_uploadedFile_fileName", item.getName().replaceAll("&", ""));
                        	Map resultMap = dispatcher.runSync("uploadedFileAliyun", servicMap);
                        	returnFileName = imageFolder+(String) resultMap.get("fileName");
                        	returnFilePath = imageFolder+(String) resultMap.get("filePath");
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
        PrintWriterUtil.print(response, callBack);
        return result;
    }
    /**
     * 微信端附件上传方法
     * @param request
     * @param response
     * @return
     */
    public static String commonAjaxFileUploadWeChat(HttpServletRequest request, HttpServletResponse response)
    {
    	
    	LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
    	GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
    	
    	String result = ModelService.RESPOND_ERROR;
    	String returnFilePath = "";
    	String returnFileName = "";
    	String callBack = "";
    	String type = "";
    	String media_id = "";
    	String created_at = "";
    	String fileId = request.getParameter("fileId");
    	Debug.log("fileId---------------------"+fileId);
    	Map<String, Object> jsonMap = FastMap.newInstance();
    	boolean beganTransaction = false;
    	try
    	{
    		beganTransaction = TransactionUtil.begin();
    		Map<String, Object> paramMap = FastMap.newInstance();
    		
    		FileItemFactory factory = new DiskFileItemFactory();
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
    					returnFileName= item.getFieldName();
    					if(fileId.equals(returnFileName)){
    						InputStream input = item.getInputStream();
    						ByteArrayOutputStream swapStream = new ByteArrayOutputStream(); 
    						byte[] buff = new byte[100]; //buff用于存放循环读取的临时数据 
    						int rc = 0; 
    						while ((rc = input.read(buff, 0, 100)) > 0) { 
    							swapStream.write(buff, 0, rc); 
    						} 
    						ByteBuffer uploadedFile = ByteBuffer.wrap(swapStream.toByteArray());
    						Map servicMap = FastMap.newInstance();
    						String uploadedFileName = item.getName().replaceAll("&", "");
    						servicMap.put("uploadedFile", uploadedFile);
                        	servicMap.put("_uploadedFile_fileName", uploadedFileName);
                        	Map resultMap = dispatcher.runSync("uploadedFileAliyun", servicMap);
                        	returnFileName = imageFolder+(String) resultMap.get("fileName");
                        	returnFilePath = imageFolder+(String) resultMap.get("filePath");
                        	
                        	Map servicWechatMap = FastMap.newInstance();
    						Path path = Paths.get(uploadedFileName);
    						String contentType = Files.probeContentType(path);
    						servicWechatMap.put("uploadedFile", uploadedFile);
    						servicWechatMap.put("filename", item.getName());
    						servicWechatMap.put("filePath", returnFilePath);
    						servicWechatMap.put("type", "image");
    						servicWechatMap.put("contentType", contentType);
    						Map resultWechatMap = dispatcher.runSync("wechatUpload", servicWechatMap);
    						if(UtilValidate.isNotEmpty(resultWechatMap)){
    							created_at = (String) resultWechatMap.get("created_at");
    							media_id = (String) resultWechatMap.get("media_id");
    							type = (String) resultWechatMap.get("type");
    						}
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
    	callBack="<script>parent.fileImport_callBack('"+returnFilePath+"','"+returnFileName+"','"+fileId+"','"+type+"','"+media_id+"','"+created_at+"')</script>";
    	PrintWriterUtil.print(response, callBack);
    	return result;
    }
    /**
     * 通用的视频文件上传方法，添加解析缩略图功能
     * @param request
     * @param response
     * @return
     */
    public static String commonAjaxVideoUpload(HttpServletRequest request, HttpServletResponse response)
    {
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        String fileId = request.getParameter("fileId");
        String videoPath = null;
        String videoName = null;
        String imgPath = null;
        String imgName = null;
        String errorInfo = null;
        File tempoVideoFile = null;
        File tempoImgFile = null;
    	try{
	    	String temporaryPath = System.getProperty("ofbiz.home")+"/specialpurpose/sysCommon/webapp/sysCommon/images/temporaryFiles/";
	    	String ffmpegPath = System.getProperty("ofbiz.home")+"/specialpurpose/sysCommon/webapp/sysCommon/images/ffmpeg/ffmpeg.exe";
	    	String tempoImgPath = temporaryPath+"videoImg.jpg";
	    	Map<String, Object> context = UtilFileUpload.uploadFile(temporaryPath, request);
			String filePath = temporaryPath + context.get("filePath");
			String fileName = (String)context.get("fileName");
			//生成图片
			VideoCutUtil.processImg(ffmpegPath, filePath, tempoImgPath);
			
			//上传video
			//InputStream input = item.getInputStream();
			tempoVideoFile = new File(filePath);
			if(tempoVideoFile.exists()){
				InputStream input = new FileInputStream(tempoVideoFile);
	        	ByteArrayOutputStream swapStream = new ByteArrayOutputStream(); 
	        	byte[] buff = new byte[100]; //buff用于存放循环读取的临时数据 
	        	int rc = 0; 
	        	while ((rc = input.read(buff, 0, 100)) > 0) { 
	        		swapStream.write(buff, 0, rc); 
	        	} 
	        	ByteBuffer uploadedFile = ByteBuffer.wrap(swapStream.toByteArray());
	        	Map servicMap = FastMap.newInstance();
	        	servicMap.put("uploadedFile", uploadedFile);
	        	servicMap.put("_uploadedFile_fileName", fileName);
	        	Map resultMap = dispatcher.runSync("uploadedFileAliyun", servicMap);
	        	videoName = imageFolder+(String) resultMap.get("fileName");
	        	videoPath = imageFolder+(String) resultMap.get("filePath");
	        	input.close();
	        	swapStream.close();
			}
        	//上传img
			tempoImgFile = new File(tempoImgPath);
			if(tempoImgFile.exists()){
				InputStream input = new FileInputStream(tempoImgFile);
				ByteArrayOutputStream swapStream = new ByteArrayOutputStream();
				byte[] buff = new byte[100]; //buff用于存放循环读取的临时数据 
				int rc = 0; 
	        	while ((rc = input.read(buff, 0, 100)) > 0) { 
	        		swapStream.write(buff, 0, rc); 
	        	} 
	        	ByteBuffer uploadedFile = ByteBuffer.wrap(swapStream.toByteArray());
	        	Map servicMap = FastMap.newInstance();
	        	servicMap.put("uploadedFile", uploadedFile);
	        	servicMap.put("_uploadedFile_fileName", "videoImg.jpg");
	        	Map resultMap = dispatcher.runSync("uploadedFileAliyun", servicMap);
	        	imgName = imageFolder+(String) resultMap.get("fileName");
	        	imgPath = imageFolder+(String) resultMap.get("filePath");
	        	input.close();
	        	swapStream.close();
			}
    	}catch(Exception e){
    		Debug.logError(e, module);
    		errorInfo = e.getMessage();
    	}finally{
    		if(tempoImgFile!=null && tempoImgFile.exists())tempoImgFile.delete();
			if(tempoVideoFile!=null && tempoVideoFile.exists())tempoVideoFile.delete();
    	}
    	String callBack="<script>parent.fileImport_callBack('"+videoPath+"','"+videoName+"','"+imgPath+"','"+imgName+"','"+fileId+"','"+(errorInfo!=null?errorInfo:"")+"')</script>";
        PrintWriterUtil.print(response, callBack);
    	return "success";
    }
    
    /**
     * doAjaxFileUpload<br/>
     * Ajax 上传文件并和给定资源按照资源使用目的新建或者重建关联<br/>
     * 
     * @param request
     * @param response
     * @return
     */
    public static String doAjaxFileUpload(HttpServletRequest request, HttpServletResponse response)
    {

        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");

        String result = ModelService.RESPOND_ERROR;
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
                    if ("uploadFile".equals(item.getFieldName()) && item.getSize() > 0)
                    {
                        fileItem = item;
                    }
                }
            }

            if (UtilValidate.isNotEmpty(fileItem))
            {
                Map<String, Object> uploadResult = paramMap;
                Object sysDocPurposeId = paramMap.get("sysDocPurposeId");
                Object relatedIdValue = paramMap.get("relatedIdValue");
                Object oldSysDocRefId = paramMap.get("oldSysDocRefId");
                Object update = paramMap.get("update");

                boolean toUpdate = false;
                if (UtilValidate.isNotEmpty(update) && "Y".equals(update))
                {
                    toUpdate = true;
                }

                uploadResult.put("userLogin", userLogin);
                uploadResult.put("folder", DocumentUtils.getPurposeBaseFolderPath(request, (String) sysDocPurposeId));
                uploadResult.put("fileItem", fileItem);

                ModelService uploadAndCreateSysDocSourceService = dispatcher.getDispatchContext().getModelService("uploadAndCreateSysDocSource");
                Map<String, Object> resultMap = dispatcher
                        .runSync("uploadAndCreateSysDocSource", uploadAndCreateSysDocSourceService.makeValid(uploadResult, ModelService.IN_PARAM));
                if (ServiceUtil.isSuccess(resultMap))
                {
                    String sysDocSourceId = ((GenericValue) resultMap.get("sysDocSource")).getString("sysDocSourceId");
                    if (toUpdate && UtilValidate.isNotEmpty(oldSysDocRefId))
                    {
                        dispatcher.runSync("deactivateSysDocRef", UtilMisc.toMap("sysDocRefId", oldSysDocRefId, "userLogin", userLogin));
                    }
                    dispatcher.runSync("createSysDocRef",
                            UtilMisc.toMap("sysDocSourceId", sysDocSourceId, "sysDocPurposeId", sysDocPurposeId, "relatedIdValue", relatedIdValue, "userLogin", userLogin));
                }
            }
            result = ModelService.RESPOND_SUCCESS;

            jsonMap.put("msg", "上传成功!");
        } catch (Exception e)
        {
            jsonMap.put("error", "上传失败!");
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
        JsonUtil.toJsonObject(jsonMap, response);

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
		    String contentDisposition = DocumentUtils.getContentDisposition(fileName, request.getHeader("user-agent"));
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
        String imageFolder = UtilProperties.getPropertyValue("commonconf.properties", "pcpos.toux");
        String result = "";
        String returnFilePath = "";
        String returnFileName = "";
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
                    	returnFileName= item.getFieldName();
                    	InputStream input = item.getInputStream();
                    	ByteArrayOutputStream swapStream = new ByteArrayOutputStream(); 
                    	byte[] buff = new byte[100]; //buff用于存放循环读取的临时数据 
                    	int rc = 0; 
                    	while ((rc = input.read(buff, 0, 100)) > 0) { 
                    		swapStream.write(buff, 0, rc); 
                    	} 
                    	ByteBuffer uploadedFile = ByteBuffer.wrap(swapStream.toByteArray());
                    	Map servicMap = FastMap.newInstance();
                    	servicMap.put("uploadedFile", uploadedFile);
                    	servicMap.put("_uploadedFile_fileName", item.getName());
                    	Map resultMap = dispatcher.runSync("uploadedFileAliyun", servicMap);
                    	returnFileName = imageFolder+(String) resultMap.get("fileName");
                    	returnFilePath = imageFolder+(String) resultMap.get("filePath");
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
    public static Map<String, Object> commonAjaxPicUploadBatch(HttpServletRequest request, HttpServletResponse response)
    {
    	
    	LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
    	GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
    	String imageFolder = UtilProperties.getPropertyValue("commonconf.properties", "pcpos.toux");
    	Map<String, Object> paramMap = FastMap.newInstance();
    	String returnFilePath = "";
    	String returnFileName = "";
    	Map<String, Object> jsonMap = FastMap.newInstance();
    	boolean beganTransaction = false;
    	try
    	{
    		beganTransaction = TransactionUtil.begin();
    		
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
    					returnFileName= item.getFieldName();
                    	InputStream input = item.getInputStream();
                    	ByteArrayOutputStream swapStream = new ByteArrayOutputStream(); 
                    	byte[] buff = new byte[100]; //buff用于存放循环读取的临时数据 
                    	int rc = 0; 
                    	while ((rc = input.read(buff, 0, 100)) > 0) { 
                    		swapStream.write(buff, 0, rc); 
                    	} 
                    	ByteBuffer uploadedFile = ByteBuffer.wrap(swapStream.toByteArray());
                    	Map servicMap = FastMap.newInstance();
                    	servicMap.put("uploadedFile", uploadedFile);
                    	servicMap.put("_uploadedFile_fileName", item.getName());
                    	Map resultMap = dispatcher.runSync("uploadedFileAliyun", servicMap);
                    	returnFileName = returnFileName+(String) resultMap.get("fileName")+",";
                    	returnFilePath = returnFilePath+imageFolder+(String) resultMap.get("filePath")+",";
                    	Debug.log("returnFileName==="+returnFileName);
                    	Debug.log("returnFilePath==="+returnFilePath); 
                    	
    				}
    			}
    		}
    		returnFilePath = returnFilePath.substring(0, returnFilePath.length()-1);
    		returnFileName = returnFileName.substring(0, returnFileName.length()-1);
    		paramMap.put("returnFilePath",returnFilePath);
    		paramMap.put("returnFileName",returnFileName);
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
    		} catch (final GenericTransactionException e)
    		{
    			e.printStackTrace();
    		}
    	}
    	return paramMap;
    }
    /**
     * rest图片上传
     * @param request
     * @param response
     * @return
     */
    public static String commonAjaxPicUploadRest(List<Map> uploadedFileList,LocalDispatcher dispatcher){
    	String imageFolder = UtilProperties.getPropertyValue("commonconf.properties", "pcpos.toux");
    	String pathStr = "";
    	try {
	    	if(UtilValidate.isNotEmpty(uploadedFileList)){
	    		for (Map map : uploadedFileList) {
	    			Map servicMap = FastMap.newInstance();
                	servicMap.put("uploadedFile", map.get("uploadedFile"));
                	servicMap.put("_uploadedFile_fileName", map.get("_uploadedFile_fileName"));
                	servicMap.put("_uploadedFile_contentType", map.get("_uploadedFile_contentType"));
                	Map resultMap = dispatcher.runSync("uploadedFileAliyun", servicMap);
                	
					if(UtilValidate.isNotEmpty(resultMap)){
						pathStr = pathStr + imageFolder +resultMap.get("filePath") +",";
					}
				}
	    	}
	    	if(UtilValidate.isNotEmpty(pathStr)){
	    		pathStr = pathStr.substring(0, pathStr.length()-1);
	    	}
    	} catch (GenericServiceException e) {
    		// TODO Auto-generated catch block
    		e.printStackTrace();
    	}
    	return pathStr;
    }
    
    
    
}
