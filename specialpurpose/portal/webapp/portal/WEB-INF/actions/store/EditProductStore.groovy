import org.ofbiz.base.util.HttpRequestFileUpload
import org.ofbiz.base.util.UtilProperties
import org.ofbiz.base.util.UtilValidate
import org.ofbiz.base.util.string.FlexibleStringExpander
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList
import org.ofbiz.entity.util.EntityUtilProperties;
import org.ofbiz.product.catalog.*;
import org.ofbiz.product.category.*;
import org.ofbiz.base.util.UtilMisc;

chinaCountys=parameters.chinaCountys?:null;
def productStoreId = null
if(userLogin){
	condList = FastList.newInstance();
	condList.add(EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, userLogin.partyId));
	condList.add(EntityCondition.makeCondition("roleTypeId", EntityOperator.EQUALS, "OWNER"));
	rolesCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
	productStoreRoleList = delegator.findList("ProductStoreRole", rolesCond, null, ["-sequenceNum"], null, false);
	
	productStoreRoleList = EntityUtil.filterByDate(productStoreRoleList);
	if(UtilValidate.isNotEmpty(productStoreRoleList)){
		productStoreRole = EntityUtil.getFirst(productStoreRoleList);
      
		/**xiaoao zs
		 * productStoreId = productStoreRole.productStoreId
		context.productStoreId = productStoreRole.productStoreId;*/
        productStoreId=parameters.productStoreId;
        if(productStoreId){
        	productStoreRole.productStoreId=productStoreId;
        	
        	use =  delegator.findList("ProductStoreRole", EntityCondition.makeCondition("productStoreId", EntityOperator.EQUALS, productStoreId), null, null, null, false);
        	if(use){
        		context.partyId=use[0].partyId;
        	}
        }else{
        	parameters.productStoreId=productStoreRole.productStoreId;
        }
        context.productStoreId = productStoreRole.productStoreId;
        
        //productStoreCity=parameters.productStoreCity?:null;

		//productStore = delegator.findOne("ProductStore", [productStoreId : productStoreRole.productStoreId], false)

		//context.productStore = productStore;
	}

    	//跳转到店铺信息页面查找
    def geoStatus=false;
    def geoProvinceList=[];
    def geoCityList=[];
    def geoCountyList=[];
    productStoreGeoList = delegator.findByAnd("ProductStoreGeo", [productStoreId : parameters.productStoreId], null, false);
    if(productStoreGeoList){
    	productStoreGeoList.each{it ->
    		geo=delegator.findOne("ChinaGeo", [geoId : it.geoId], false);
    		if(geo){
    			if(geo.geoId.size()==4){
    				geoProvinceList.add(geo);
    			}
    			if(geo.geoId.size()==6){
    				geoCityList.add(geo);
    			}
    			if(geo.geoId.size()==8){
    				geoCountyList.add(geo);
    			}
    		}
    	}
    	if(geoCountyList){
    		geoStatus=true;
    		context.geoCountyList=geoCountyList;
    	}
    	if(geoCityList){
    		geoStatus=true;
    		context.geoCityList=geoCityList;
    	}
    	if(geoProvinceList){
    		geoStatus=true;
    		context.geoProvinceList=geoProvinceList;
    	}
    	
    	//geoList = delegator.findByAnd("ChinaGeo", [parentGeoId : productStoreGeo.parentGeoId], null, false);
    }
    context.geoStatus=geoStatus;
	//获取主要分类
	CategoryWorker.getRelatedCategories(request, "topLevelList", CatalogWorker.getCatalogTopCategoryId(request, EbizCatalogWorker.getNavMenuCatalogId(request)), true);
	categoryList = request.getAttribute("topLevelList");
	context.categoryList = categoryList;


    // 获取图片名称
    imageFilenameFormat = UtilProperties.getPropertyValue("store", "image.filename.format");
    imageServerPath = FlexibleStringExpander.expandString(EntityUtilProperties.getPropertyValue("store", "image.server.path", delegator), context);
    imageUrlPrefix = EntityUtilProperties.getPropertyValue("store", "image.url.prefix",delegator);
    context.imageFilenameFormat = imageFilenameFormat;
    context.imageServerPath = imageServerPath;
    context.imageUrlPrefix = imageUrlPrefix;

    filenameExpander = FlexibleStringExpander.getInstance(imageFilenameFormat);
    context.imageNameStoreBanner = imageUrlPrefix + "/" + filenameExpander.expandString([location : "stores", type : "banner", id : productStoreId]);
    context.imageNameStoreLogo  = imageUrlPrefix + "/" + filenameExpander.expandString([location : "stores", type : "logon", id : productStoreId]);
    //查询地区
    geoList = delegator.findByAnd("ChinaGeo", [geoType : "PROVINCE"], null, false);
    if(geoList){
    	context.geoList=geoList;
    }
    // 上传图片
    forLock = new Object();
    contentType = null;
    fileType = request.getParameter("upload_file_type");
    if (fileType) {
        context.fileType = fileType;

        String fileLocation = filenameExpander.expandString([location : "stores", type : fileType, id : productStoreId]);
        println "---------------------------------------------------------" + fileLocation
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
                productCategory.set(fileType , imageUrl);
                productCategory.store();
            }
        }
    }
}else{
	productStoreId=parameters.productStoreId;
	use =  delegator.findList("ProductStoreRole", EntityCondition.makeCondition("productStoreId", EntityOperator.EQUALS, productStoreId), null, null, null, false);
	if(use){
		context.partyId=use[0].partyId;
	}
	
}