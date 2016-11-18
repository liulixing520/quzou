package org.extErp.sysCommon.upload;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.Locale;
import java.util.Map;

import org.ofbiz.base.util.Base64;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.ServiceUtil;

public class UploadUtils {
    public static final String module = UploadUtils.class.getName();
    public static final String resource = "CommonUiLabels";
    private static final String OFBIZ_HOME = System.getProperty("ofbiz.home");

    public static void createFile(String filePath, String imagePath, ByteBuffer imageDataBytes, String newImageFolder)
            throws IOException {
        byte[] imageBytes = imageDataBytes.array();
        String imageFolder = "";
        if (UtilValidate.isNotEmpty(newImageFolder)) {
            imageFolder = newImageFolder;
        } else {
            imageFolder = "/hot-deploy/quzou/webapp/quzou/upload/";
        }
        String fullFilePath = OFBIZ_HOME + imageFolder + filePath;
        File saveFilePath = new File(fullFilePath);
        synchronized(UploadUtils.class){
            if (!saveFilePath.exists()) {
                boolean m = saveFilePath.mkdirs();
            }
        }
        String path = fullFilePath + "/" + imagePath;
        FileOutputStream fos = new FileOutputStream(path);
        fos.write(imageBytes);
        fos.close();
    }

    /**
     * 上传
     */
    public static Map<String, Object> uploadedFile(DispatchContext dctx, Map<String, ? extends Object> context) {
        Locale locale = (Locale) context.get("locale");
        Map<String, Object> result = ServiceUtil.returnSuccess();
        String imageFolder = (String) context.get("imageFolder");
        try {

            ByteBuffer imageDataBytes = (ByteBuffer) context.get("uploadedFile");
            String base64str =  (String) context.get("mediumFileBase64");
            // 没有传入图片数据，但传入了base64的字符串，尝试base64解码
            if (UtilValidate.isEmpty(imageDataBytes) && UtilValidate.isNotEmpty(base64str)){
                imageDataBytes =  ByteBuffer.wrap(Base64.base64Decode(base64str.getBytes()));
            }
            String _uploadedFile_fileName = (String) context.get("_uploadedFile_fileName");

            if (UtilValidate.isNotEmpty(imageDataBytes) && UtilValidate.isNotEmpty(_uploadedFile_fileName)) {
                String extendName = _uploadedFile_fileName.substring(_uploadedFile_fileName.lastIndexOf("."));
                String uuid = UtilUUID.uuidTomini();
                String imagePath = uuid + extendName.toLowerCase();

                String filePath = UtilDateTime.nowDateString("yyyyMMdd");

                createFile(filePath, imagePath, imageDataBytes, imageFolder);
                result.put("imagePath", filePath + "/" + imagePath);
                result.put("imageName", imagePath);
            }

        } catch (IOException e) {
            Debug.logError(e, e.getMessage(), module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resource, "upload.image.error",
                    new Object[] { e.getMessage() }, locale));

        }

        return result;

    }

    /**
     * 上传
     */
    public static Map<String, Object> uploadedFileToFile(DispatchContext dctx, Map<String, ? extends Object> context) {
        Locale locale = (Locale) context.get("locale");
        Map<String, Object> result = ServiceUtil.returnSuccess();
        String id = (String) context.get("projectId");
        try {
            ByteBuffer imageDataBytes = (ByteBuffer) context.get("uploadedFile");
            String _uploadedFile_fileName = (String) context.get("_uploadedFile_fileName");

            if (UtilValidate.isNotEmpty(imageDataBytes) && UtilValidate.isNotEmpty(_uploadedFile_fileName)) {
                String extendName = _uploadedFile_fileName.substring(_uploadedFile_fileName.lastIndexOf("."));
                String uuid = UtilUUID.uuidTomini();
                String imagePath = uuid + extendName.toLowerCase(); // 文件名称

                String filePath = id.substring(0, id.length() - 3); // 文件存放目录
                createFile(filePath, imagePath, imageDataBytes, null);

                String imagePathThumil = imagePath;

                result.put("imagePath", filePath + "/" + imagePathThumil);
                result.put("imageName", imagePathThumil);
            }

        } catch (IOException e) {
            Debug.logError(e, e.getMessage(), module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resource, "upload.image.error",
                    new Object[] { e.getMessage() }, locale));

        }

        return result;

    }
}
