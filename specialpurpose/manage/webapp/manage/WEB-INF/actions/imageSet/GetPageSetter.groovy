import org.ofbiz.base.util.*
import org.ofbiz.base.util.string.*
import org.ofbiz.entity.util.EntityUtilProperties

//  获取广告位信息
	if(pageSettingId){
		pageSetting = delegator.findOne("PageSetting",[pageSettingId: pageSettingId], false);
		context.pageSettingId = pageSetting.pageSettingId;
    	context.pageSetting = pageSetting;
	 }

    println "---------------------------------广告位  =  "+context.pageSetting

//  获取图片名称
    imageFilenameFormat = UtilProperties.getPropertyValue("catalog", "image.filename.format");
    imageServerPath = FlexibleStringExpander.expandString(EntityUtilProperties.getPropertyValue("catalog", "image.server.path", delegator), context);
    imageUrlPrefix = EntityUtilProperties.getPropertyValue("catalog", "image.url.prefix",delegator);
    context.imageFilenameFormat = imageFilenameFormat;
    context.imageServerPath = imageServerPath;
    context.imageUrlPrefix = imageUrlPrefix;

    filenameExpander = FlexibleStringExpander.getInstance(imageFilenameFormat);
    context.imageNameStoreBanner = imageUrlPrefix + "/" + filenameExpander.expandString([location : "categories",type : "setmrl", id : pageSettingId]);
  
// 上传图片
	forLock = new Object();
	contentType = null;
	fileType = request.getParameter("upload_file_type");
	
	
	if (fileType) {
	    context.fileType = fileType;

	    String fileLocation = filenameExpander.expandString([location : "categories", type : fileType, id : pageSettingId]);
	    String filePathPrefix = "";
	    String filenameToUse = fileLocation;
	    if (fileLocation.lastIndexOf("/") != -1) {
	        filePathPrefix = fileLocation.substring(0, fileLocation.lastIndexOf("/") + 1); // adding 1 to include the trailing slash
	        filenameToUse = fileLocation.substring(fileLocation.lastIndexOf("/") + 1);
	    }

	    int i1;
	    if (contentType && (i1 = contentType.indexOf("boundary=")) != -1) {
	        contentType = contentType.substring(i1 + 9);
	        contentType = "--" + contentType;
	    }

	    defaultFileName = filenameToUse + "_temp";
	    uploadObject = new HttpRequestFileUpload();
	    uploadObject.setOverrideFilename(defaultFileName);
	    uploadObject.setSavePath(imageServerPath + "/" + filePathPrefix);
	    uploadObject.doUpload(request);

	    clientFileName = uploadObject.getFilename();
	    if (clientFileName) {
	        context.clientFileName = clientFileName;
	    }

	    if (clientFileName) {
	        if (clientFileName.lastIndexOf(".") > 0 && clientFileName.lastIndexOf(".") < clientFileName.length()) {
	            filenameToUse += clientFileName.substring(clientFileName.lastIndexOf("."));
	        } else {
	            filenameToUse += ".jpg";
	        }

	        context.clientFileName = clientFileName;
	        context.filenameToUse = filenameToUse;

	        characterEncoding = request.getCharacterEncoding();
	        imageUrl = imageUrlPrefix + "/" + filePathPrefix + java.net.URLEncoder.encode(filenameToUse, characterEncoding);

	        try {
	            file = new File(imageServerPath + "/" + filePathPrefix, defaultFileName);
	            file1 = new File(imageServerPath + "/" + filePathPrefix, filenameToUse);
	            try {
	                file1.delete();
	            } catch (Exception e) {
	                System.out.println("error deleting existing file (not neccessarily a problem)");
	            }
	            file.renameTo(file1);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        if (imageUrl) {
	            context.imageUrl = imageUrl;
	            pageSetting.set(fileType, imageUrl);
	            pageSetting.store();
	        }
	    }
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
/*    String fileLocation = filenameExpander.expandString([location : "stores", id : pageSettingId]);

    fileLocation = fileLocation+"pageLogoImage"
    println "fileLocation-------------------"+fileLocation
    
    String filePathPrefix = "";
    String filenameToUse = fileLocation;
    if (fileLocation.lastIndexOf("/") != -1) {
        filePathPrefix = fileLocation.substring(0, fileLocation.lastIndexOf("/") + 1); 
        filenameToUse = fileLocation.substring(fileLocation.lastIndexOf("/") + 1);
    }
    println "----------------------"+ filenameToUse
    int i1;
    if (contentType && (i1 = contentType.indexOf("boundary=")) != -1) {
        contentType = contentType.substring(i1 + 9);
        contentType = "--" + contentType;
    }
    println "---------------------------------" + contentType

    defaultFileName = filenameToUse + "_temp";
    uploadObject = new HttpRequestFileUpload();
    uploadObject.setOverrideFilename(defaultFileName);
    uploadObject.setSavePath(imageServerPath + "/" + filePathPrefix);
    uploadObject.doUpload(request);
    
    clientFileName = uploadObject.getFilename();
    if (clientFileName) {
        context.clientFileName = clientFileName;
    }
    println "-----------------------------------" + clientFileName

    if (clientFileName) {
        if (clientFileName.lastIndexOf(".") > 0 && clientFileName.lastIndexOf(".") < clientFileName.length()) {
            filenameToUse += clientFileName.substring(clientFileName.lastIndexOf("."));
        } else {
            filenameToUse += ".jpg";
        }
        println "-----------------------------------" + filenameToUse

        context.clientFileName = clientFileName;
        context.filenameToUse = filenameToUse;

        characterEncoding = request.getCharacterEncoding();
        imageUrl = imageUrlPrefix + "/" + filePathPrefix + java.net.URLEncoder.encode(filenameToUse, characterEncoding);

        try {
            file = new File(imageServerPath + "/" + filePathPrefix, defaultFileName);
            file1 = new File(imageServerPath + "/" + filePathPrefix, filenameToUse);
            try {
                file1.delete();
            } catch (Exception e) {
                System.out.println("error deleting existing file (not neccessarily a problem)");
            }
            file.renameTo(file1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        if (imageUrl) {
            context.imageUrl = imageUrl;
            pageSetting.set(imageUrl);
            pageSetting.store();
        }
   }*/
    
    
