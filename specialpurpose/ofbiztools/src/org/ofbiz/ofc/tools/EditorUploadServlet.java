package org.ofbiz.ofc.tools;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.ByteBuffer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastMap;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.LocalDispatcher;

/**
 * Created by apple on 14-12-16.
 */
public class EditorUploadServlet{
    public static final String module   = EditorUploadServlet.class.getName();
    public static final String resource = "OfbizToolsUiLabels";
    private static boolean debug = false;// 是否debug模式
    private static boolean enabled = false;// 是否开启CKEditor上传
    private static SimpleDateFormat fileFormatter;// 文件命名格式:yyyyMMddHHmmssSSS
    private static int maxPostSize = 100 * 1024 * 1024;
    static ServletFileUpload uploadFileServlet = null;
    static {
        DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
        diskFileItemFactory.setSizeThreshold(4096);
        uploadFileServlet = new ServletFileUpload(diskFileItemFactory);
        uploadFileServlet.setSizeMax(maxPostSize);
    }
    @SuppressWarnings("unchecked")
    private static FileItem getFileItem(HttpServletRequest request) throws FileUploadException {
        FileItem fileItem = null;
        List<FileItem> fileItems = uploadFileServlet.parseRequest(request);
        for(FileItem fi : fileItems){
            if(!fi.isFormField()){
                fileItem = fi;
            }
        }
        return fileItem;
    }
    public static String uploader(HttpServletRequest request, HttpServletResponse response) throws Exception{
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        fileFormatter = new SimpleDateFormat("yyyyMMddHHmmssSSS");

        debug = true;
        if (debug) Debug.logInfo("---- SimpleUploaderServlet initialization started ----", module);

        enabled =true;
        if (debug) Debug.logInfo("---- SimpleUploaderServlet initialization completed, BEGIN DOPOST ----", module);

        response.setContentType("text/html; charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter out;
        String imagePath;
        out = response.getWriter();
        // 从请求参数中获取上传文件的类型：File/Image/Flash
        String typeStr = request.getParameter("Type");
        typeStr=typeStr.toLowerCase();
        if (typeStr == null) {typeStr = "file";}
        imagePath = "";
        if (enabled) {
            FileItem fileItem = getFileItem(request);
            if(UtilValidate.isNotEmpty(fileItem)){
                ByteBuffer fileBytes = ByteBuffer.wrap(fileItem.get());
                Map<String, Object> map = new HashMap<String, Object>();
                Date dNow = new Date();
                String baseId = fileFormatter.format(dNow);
                map.put("projectId", baseId);
                map.put("uploadFile", fileBytes);
                map.put("_uploadFile_fileName", fileItem.getName());
                Map<String,Object> result = dispatcher.runSync("uploadedFile", map);
                imagePath = (String) result.get("imagePath");
                imagePath = "/ofcupload/images/upload/"+imagePath;
                Debug.log("imagePath=========="+imagePath);
            }
        } else {
            if (debug)System.out.println("未开启CKEditor上传功能");
        }
        String callback = request.getParameter("CKEditorFuncNum");
        out.println("<script type=\"text/javascript\">");
        out.println("window.parent.CKEDITOR.tools.callFunction(" + callback
                + ",'" + imagePath + "',''" + ")");
        out.println("</script>");
        out.flush();
        out.close();
        if (debug)System.out.println("--- END ---");
        return null;
    }


    /**
     * flash头像上传
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public static String uploaderEvent(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Map<String,Object> context = FastMap.newInstance();
        Delegator delegator=(Delegator)request.getAttribute("delegator");
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        GenericValue userLogin=(GenericValue)request.getSession().getAttribute("userLogin");
        int s=-1;
        String d=(String)request.getParameter("action");
        InputStream in = null;
        if(d.equals("uploadtmp")){s=1;}else if (d.equals("uploadavatar")){s=2;}
        switch(s){
            case 1:
                System.out.println("test");
                break;
            case 2:
                try {
                    int len = request.getContentLength();
                    in = request.getInputStream();
                    String fileName= request.getHeader("fileName")!=null?request.getHeader("fileName"):"uploadtmp.jpg";
                    byte[] buf=buf(len, in);
                    ByteBuffer fileBytes = ByteBuffer.wrap(buf);

                    GenericValue person = delegator.findByPrimaryKey("Person",UtilMisc.toMap("partyId",userLogin.getString("partyId")));

                    Map<String,Object> map = FastMap.newInstance();
                    map.put("projectId", userLogin.getString("partyId"));
                    map.put("uploadFile",fileBytes);
                    map.put("_uploadFile_fileName",userLogin.getString("partyId")+".jpg");
                    Map<String,Object> resultFront = dispatcher.runSync("uploadedFile", map);
                    String imagePath = (String)resultFront.get("imagePath");
                    person.set("avatarFilePath", imagePath);
                    person.store();
                    if(UtilValidate.isNotEmpty(imagePath)){
                        request.setAttribute("status", "1");
                    }
                } catch (Exception e) {
                    Debug.logError(e, e.getMessage(), module);
                } finally{
                    if(null != in){
                        in.close();
                    }
                }

                break;

            default:
                request.setAttribute("status", "-1");
        }
        return "success";
    }

    public static byte[] buf(int length,InputStream in) throws IOException{
        byte[] buf = new byte[length];
        int perBufSize = 512;
        int destPos = 0;
        int readCount = length / perBufSize;
        int modSize = length % perBufSize;
        for(int i=0; i<readCount; i++){
            byte[] perBuf = new byte[perBufSize];
            int off = in.read(perBuf);
            while(off < perBufSize){
                int tOff = in.read(perBuf, off, perBufSize - off);
                off += tOff;
            }
            System.arraycopy(perBuf, 0, buf, destPos, perBuf.length);
            destPos += perBuf.length;
        }
        if(modSize > 0){
            byte[] tailBuf = new byte[modSize];
            int off = in.read(tailBuf);
            while(off < modSize){
                int tOff = in.read(tailBuf, off, modSize - off);
                off += tOff;
            }
            System.arraycopy(tailBuf, 0, buf, destPos, modSize);
        }
        return buf;
    }


    /**
     * UeEditor 面板文件上传
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public static String uploaderUe(HttpServletRequest request, HttpServletResponse response) throws Exception{
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        EditorUploader up = new EditorUploader(request);
        String[] fileType = {".gif" , ".png" , ".jpg" , ".jpeg" , ".bmp"};
        up.setAllowFiles(fileType);
        up.setMaxSize(10000); //单位KB
        up.upload(dispatcher);

        String callback = request.getParameter("callback");


        String result = "{\"name\":\""+ up.getFileName() +"\", \"originalName\": \""+ up.getOriginalName() +"\", \"size\": "+ up.getSize() +", \"state\": \""+ up.getState() +"\", \"type\": \""+ up.getType() +"\", \"url\": \""+ up.getUrl() +"\"}";

        Debug.log("uploaderUe.result============"+result);

        result = result.replaceAll( "\\\\", "\\\\" );

        if( callback == null ){
            response.getWriter().print( result );
        }else{
            response.getWriter().print("<script>"+ callback +"(" + result + ")</script>");
        }
        return null;
    }

    //String result = "{\"name\":\""+ up.getFileName() +"\", \"originalName\": \""+ up.getOriginalName() +"\", \"size\": "+ up.getSize() +", \"state\": \""+ up.getState() +"\", \"type\": \""+ up.getType() +"\", \"url\": \""+ up.getUrl() +"\"}";

}
