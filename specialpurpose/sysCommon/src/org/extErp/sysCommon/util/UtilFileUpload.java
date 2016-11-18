package org.extErp.sysCommon.util;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import javolution.util.FastMap;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.extErp.sysCommon.content.UtilUUID;
import org.ofbiz.base.location.FlexibleLocation;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.ServiceUtil;

import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.ObjectMetadata;

/**
 * 头像图片上传帮助类
 */
public class UtilFileUpload {
	
	public static String module = UtilFileUpload.class.getName();
	private static final String ACCESS_ID = UtilProperties.getPropertyValue("commonconf.properties","accessId");
	private static final String ACCESS_KEY = UtilProperties.getPropertyValue("commonconf.properties","accessKey");
	private static final String bucketName = UtilProperties.getPropertyValue("commonconf.properties", "bucketName");
	private static final String endPoint = UtilProperties.getPropertyValue("commonconf.properties", "endPoint");
	/**
	 * 上传文件，并返回图片路径及图片名称
	 * @param imageFolder
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static Map<String, Object> uploadFile(HttpServletRequest request) throws Exception {
		
		Map<String, Object> context = FastMap.newInstance();
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			//获取文件项List 
			@SuppressWarnings("unchecked")
			List<FileItem> list = upload.parseRequest(request);
			//建立文件项的迭代器
			Iterator<FileItem> it = list.iterator();
			while (it.hasNext()) {
				FileItem fileItem = (FileItem) it.next();
				//判断是否为表单域，false则是file文件 
				if (fileItem.isFormField()) {
					//取文件的各个属lla
					String fileName = fileItem.getFieldName();
					String fileValue = fileItem.getString("UTF-8");
					
					if (!context.containsKey(fileName)) {
						context.put(fileName, fileValue);
					} else {
						String oldValue = (String) context.get(fileName);
						context.put(fileName, oldValue + ";" + fileValue);
					}
				} else {
					if (fileItem.getSize() > 0) {
						InputStream inputStream= null;
						byte[] data = new byte[1024];
					       int len = 0;
					       FileOutputStream fileOutputStream = null;
					       String fullFilePath = System.getProperty("ofbiz.home")+"/hot-deploy/quzou/webapp/quzou";
					       String  returnfilePath = "/upload_file/"+UtilDateTime.nowDateString("yyyyMMdd");
					       fullFilePath = fullFilePath+returnfilePath;
					       File saveFilePath = new File(fullFilePath);
					        if (!saveFilePath.exists()) {
					            boolean m =saveFilePath.mkdirs();
					        }
					       String uuid =UtilUUID.uuidTomini();
					       String filePath = fullFilePath+"/"+uuid+".jpg";
					       Debug.log("filePath=="+filePath);
					       try {
					    	  File file = new File(filePath);
					           fileOutputStream = new FileOutputStream(file);
					           while ((len = inputStream.read(data)) != -1) {
					               fileOutputStream.write(data, 0, len);
					           }
					       } catch (IOException e) {
					           e.printStackTrace();
					       } finally {
					           if (inputStream != null) {
					               try {
					                   inputStream.close();
					               } catch (IOException e) {
					                   e.printStackTrace();
					               }
					           }
					           if (fileOutputStream != null) {
					               try {
					                   fileOutputStream.close();
					               } catch (IOException e) {
					                   e.printStackTrace();
					               }
					           }
					       }
						context.put("filePath", filePath);
					}
				}
			}
		} catch (Exception e) {
			Debug.logError(e.getMessage(),module);
		}
		return context;
	}
	
	/**
     * 上传
     */
    public static Map<String, Object> uploadedFile(DispatchContext dctx, Map<String, ? extends Object> context) throws IOException {
        Map<String, Object> result = ServiceUtil.returnSuccess();
        Delegator delegator = dctx.getDelegator();
        ByteBuffer imageDataBytes = (ByteBuffer) context.get("uploadedFile");
		String _uploadedFile_fileName = (String) context.get("_uploadedFile_fileName");
		String contentType = "image/jpeg";
		try{
			int index = _uploadedFile_fileName.lastIndexOf(".");
			String fileSuffix  = null;
			if(index!=-1)
				fileSuffix = _uploadedFile_fileName.substring(index+1);
			if(fileSuffix!=null && !fileSuffix.equals("")){
				GenericValue gv = delegator.findOne("FileExtension",true,UtilMisc.toMap("fileExtensionId", fileSuffix.toLowerCase()));
				if(gv!=null)contentType = gv.getString("mimeTypeId");
			}
		}catch(Exception e){
			
		}

		if (UtilValidate.isNotEmpty(imageDataBytes) && UtilValidate.isNotEmpty(_uploadedFile_fileName)) {
		    InputStream input = new ByteArrayInputStream(imageDataBytes.array());  
		    OSSClient client = new OSSClient(endPoint,ACCESS_ID, ACCESS_KEY);
		    ObjectMetadata objectMeta = new ObjectMetadata();
		    objectMeta.setContentLength(imageDataBytes.array().length);
		    objectMeta.setContentEncoding("UTF-8");

		    // 可以在metadata中标记文件类型
		    objectMeta.setContentType(contentType);
		    String key = UUID.randomUUID()+_uploadedFile_fileName;
//		    String key = UUID.randomUUID()+"";
		    client.putObject(bucketName, key, input, objectMeta);
		    result.put("fileName", key);
		    result.put("filePath", key);
		}

        return result;

    }
	
	/**
	 * 删除oss上的文件
	 * @param key
	 */
	public static void delFile(String key){
		/*updatePersonAvatar*/
		if(UtilValidate.isNotEmpty(key)){
			OSSClient client = new OSSClient(endPoint,ACCESS_ID, ACCESS_KEY);
			client.deleteObject(bucketName, key);
		}
	}
	/**
	 * 根据配置文件名称及属性名称得到相应的属性值（路径）
	 * @param confFileName	配置文件名称
	 * @param attributeName	属性名称
	 * @return	属性值（路径）
	 */
	public static String getPath(String confFileName, String attributeName){
		String imageSite = null;
		String path = UtilProperties.getPropertyValue(confFileName, attributeName);
		try {
			URL url = FlexibleLocation.resolveLocation(path);
			imageSite = url.getPath();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
		
		return imageSite;
	}
}
