package org.ofbiz.tools.rest;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.Writer;
import java.sql.Timestamp;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javolution.util.FastList;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilValidate;

public class FixOfcTools {

    /**
     * @param args
     */
    public static void main(String[] args) {

        
//        String path = "C:/Users/Administrator/Desktop/fenlei1.xls";		//在hot-deploy\management\src\org\ofbiz\ofctools  下有模版 与方法名称对应的xls文件
//        String filePath="productDemoData";
//        xls2XmlForProductByCategory(path,filePath);
//        String path2 = "C:/Users/Administrator/Desktop/fenlei2.xls";		//在hot-deploy\management\src\org\ofbiz\ofctools  下有模版 与方法名称对应的xls文件
//        String filePath2="productDemoData2";
//        xls2XmlForProductByCategory(path2,filePath2);
        
//        String path3 = "C:/Users/Administrator/Desktop/fenlei3.xls";		//在hot-deploy\management\src\org\ofbiz\ofctools  下有模版 与方法名称对应的xls文件
//        String filePath3="productDemoData3";
//        xls2XmlForProductByCategory(path3,filePath3);
    	
      String path4 = "C:/Users/Administrator/Desktop/fenlei.xls";		//在hot-deploy\management\src\org\ofbiz\ofctools  下有模版 与方法名称对应的xls文件
      String filePath4="productDemoData";
      xls2XmlForProductByCategory(path4,filePath4);
    }
    
    public static String getOneYearsAgoTime () {
    	 String oneYearsAgoTime = "";
         Calendar cal = Calendar.getInstance();         
         cal.set(Calendar.YEAR, cal.get(Calendar.YEAR)+1);
         oneYearsAgoTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                 .format(cal.getTime());
         return oneYearsAgoTime;
    }
    

    
    /**
     *  产品Xls文件转换
     * @param filePathAndName
     */
    public static void xls2XmlForProductByCategory(String filePathAndName,String filePath){
        
    	long featureIdx = 1000;
        long category0Idx = 1;
        long featureTypeIdx = 1000;
        String featureTypePrefix = "FT-";
        String featurePrefix = "FE-";
        String productCategoryPrefix = "YUNTOU";
    	
        long category1Idx = 1;
        long category2Idx = 1;
        long category3Idx = 1;
        
        //列举需要处理的表
        String temp_ProdCatalogCategory = "<ProdCatalogCategory productCategoryId=\"#11#\" prodCatalogId=\"ytRootCatalog\" prodCatalogCategoryTypeId=\"PCCT_BROWSE_ROOT\" fromDate=\"2014-05-01 12:00:00.0\" />";
        String temp_ProductCategory = "<ProductCategory productCategoryId=\"#11#\" productCategoryTypeId=\"CATALOG_CATEGORY\" categoryName=\"#21#\" />";
        String temp_ProductCategoryRollup = "<ProductCategoryRollup parentProductCategoryId=\"#11#\" productCategoryId=\"#21#\" fromDate=\"2014-05-01 12:00:00.0\" />";
        String temp_featuryCategory = "<ProductFeatureCategory productFeatureCategoryId=\"#11#\" description=\"#21#\"/>";
        String temp_featuryCategoryAppl = "<ProductFeatureCategoryAppl productFeatureCategoryId=\"#11#\" productCategoryId=\"#21#\" fromDate=\"2014-05-01 12:00:00.0\"/>";
        
        String temp_ProductFeatureType = "<ProductFeatureType productFeatureTypeId=\"#11#\" description=\"#21#\"/>";
        String temp_ProductFeature = "<ProductFeature productFeatureId=\"#11#\" productFeatureTypeId=\"#21#\" productFeatureCategoryId=\"#31#\" description=\"#41#\"/>";

        Map<String, String> featureIdMap = new HashMap<String, String>();
        Map<String, String> featureMap = new HashMap<String, String>();
        
        Map<String, String> featureTypeMap = new HashMap<String, String>();
        Map<String, String> featureTypeIdMap = new HashMap<String, String>();
        
        Map<String, String> productCategoryMemberMap = new HashMap<String, String>();
        
        Map<String, String> featureCategoryMap = new HashMap<String, String>();
        Map<String, String> featureCategorApplMap = new HashMap<String, String>();
        
        Map<String, String> prodCatalogCategoryMap = new HashMap<String, String>();
        Map<String, String> productCategoryRollupMap = new HashMap<String, String>();
        
        Map<String, String> productCategory0Map = new HashMap<String, String>();
        Map<String, String> productCategory1Map = new HashMap<String, String>();
        Map<String, String> productCategory2Map = new HashMap<String, String>();
        Map<String, String> productCategory3Map = new HashMap<String, String>();
        
        Map<String, String> productCategoryId0Map = new HashMap<String, String>();
        Map<String, String> productCategoryId1Map = new HashMap<String, String>();
        Map<String, String> productCategoryId2Map = new HashMap<String, String>();
        Map<String, String> productCategoryId3Map = new HashMap<String, String>();
        HSSFWorkbook workbook = null;
        HSSFSheet sheet = null;
        try {
            //载入
            workbook = new HSSFWorkbook(new FileInputStream(new File(filePathAndName)));
            sheet = workbook.getSheetAt(0);
            int rowEnd = sheet.getLastRowNum();
            
            //读取
            int i = 1;
            for (; i < rowEnd+1; i++) {
            	System.out.println("运行到第"+i+"行");
                HSSFRow row = sheet.getRow(i);
                //建立1级分类.
                String productCategoryId0="";
                if(UtilValidate.isNotEmpty(convertCell(row.getCell(0)))){
                	
                	if(!productCategory0Map.containsKey(convertCell(row.getCell(0)))){
                   	 	
                   	    productCategoryId0=productCategoryPrefix+String.format("%02d",category0Idx++);
                   	 	
                        String productCategory = temp_ProductCategory.replace("#11#", productCategoryId0);
                        productCategory = productCategory.replace("#21#", convertCell(row.getCell(0)));
                        productCategory0Map.put(convertCell(row.getCell(0)), productCategory);
                        
                        //特征分类
                        String featuryCategory = temp_featuryCategory.replace("#11#", productCategoryId0);
                        featuryCategory = featuryCategory.replace("#21#", convertCell(row.getCell(0)));
                        featureCategoryMap.put(convertCell(row.getCell(0)), featuryCategory);
                		
                		 //分类和特征分类的关联
                		 String featuryCategoryAppl = temp_featuryCategoryAppl.replace("#11#", productCategoryId0);
                		 featuryCategoryAppl = featuryCategoryAppl.replace("#21#", productCategoryId0);
                		 featureCategorApplMap.put(productCategoryId0, featuryCategoryAppl);
                        
                        productCategoryId0Map.put(convertCell(row.getCell(0)),  productCategoryId0);
                   }else{
                   	 productCategoryId0=productCategoryId0Map.get(convertCell(row.getCell(0)));
                   }
                   
                   
                   //建立1级分类和目录的关系
                   if(UtilValidate.isNotEmpty(productCategoryId0)){
                   	if(UtilValidate.isEmpty(prodCatalogCategoryMap.get(productCategoryId0))){
                   		String ProdCatalogCategory = temp_ProdCatalogCategory.replace("#11#", productCategoryId0);
                   		prodCatalogCategoryMap.put(productCategoryId0, ProdCatalogCategory);
                   	}
                   }
                }
                
                
                
                //建立2级分类,
                String productCategoryId1 ="";
                
                if(UtilValidate.isNotEmpty(convertCell(row.getCell(1)))){
	                if(!productCategoryId1Map.containsKey(convertCell(row.getCell(1)))){
	                	productCategoryId1=productCategoryId0+"b"+category1Idx++;
	                    String productCategory = temp_ProductCategory.replace("#11#", productCategoryId1);
	                    productCategory = productCategory.replace("#21#", convertCell(row.getCell(1)));
	                    productCategory1Map.put(productCategoryId1, productCategory);
	                    
	                    //特征分类
	                    String featuryCategory = temp_featuryCategory.replace("#11#", productCategoryId1);
	                    featuryCategory = featuryCategory.replace("#21#", convertCell(row.getCell(1)));
	                    featureCategoryMap.put(productCategoryId1, featuryCategory);
	                   	
	                    //分类和特征分类的关联
	                		String featuryCategoryAppl = temp_featuryCategoryAppl.replace("#11#", productCategoryId1);
	                		featuryCategoryAppl = featuryCategoryAppl.replace("#21#", productCategoryId1);
	                		featureCategorApplMap.put(productCategoryId1, featuryCategoryAppl);
	                    
	                    productCategoryId1Map.put(convertCell(row.getCell(1)), productCategoryId1);
	               }else{
	               		productCategoryId1=productCategoryId1Map.get(convertCell(row.getCell(1)));
	               }
	                
	                
	                //建立一级分类和2级分类的关系
	               if(UtilValidate.isNotEmpty(productCategoryId0)&UtilValidate.isNotEmpty(productCategoryId1)){
	            	   if(UtilValidate.isEmpty(productCategoryRollupMap.get(productCategoryId1))){
	               		String ProductCategoryRollup = temp_ProductCategoryRollup.replace("#11#", productCategoryId0);
	               		ProductCategoryRollup = ProductCategoryRollup.replace("#21#", productCategoryId1);
	               		productCategoryRollupMap.put(productCategoryId1, ProductCategoryRollup);
	               		
	               		}
	               }
              } 
               
               //建立三级分类
               
               String productCategoryId2 ="";
               if(UtilValidate.isNotEmpty(convertCell(row.getCell(2)))){
	               if(!productCategoryId2Map.containsKey(convertCell(row.getCell(2)))){
	            	   productCategoryId2=productCategoryId1+"c"+category2Idx++;
	                   String productCategory = temp_ProductCategory.replace("#11#", productCategoryId2);
	                   productCategory = productCategory.replace("#21#", convertCell(row.getCell(2)));
	                   productCategory2Map.put(productCategoryId2, productCategory);
	                   
	                   //特征分类
	                   String featuryCategory = temp_featuryCategory.replace("#11#", productCategoryId2);
	                   featuryCategory = featuryCategory.replace("#21#", convertCell(row.getCell(2)));
	                   featureCategoryMap.put(productCategoryId2, featuryCategory);
	                   
	                 	//分类和特征分类的关联
	               		String featuryCategoryAppl = temp_featuryCategoryAppl.replace("#11#", productCategoryId2);
	               		featuryCategoryAppl = featuryCategoryAppl.replace("#21#", productCategoryId2);
	               		featureCategorApplMap.put(productCategoryId2, featuryCategoryAppl);
	                   
	                   productCategoryId2Map.put(convertCell(row.getCell(2)), productCategoryId2);
	              }else{
	              		productCategoryId2=productCategoryId2Map.get(convertCell(row.getCell(2)));
	              }
	               
	               //建立2级分类和3级分类的关系
	              if(UtilValidate.isNotEmpty(productCategoryId1)&UtilValidate.isNotEmpty(productCategoryId2)){
	           	   if(UtilValidate.isEmpty(productCategoryRollupMap.get(productCategoryId2))){
	              		String ProductCategoryRollup = temp_ProductCategoryRollup.replace("#11#", productCategoryId1);
	              		ProductCategoryRollup = ProductCategoryRollup.replace("#21#", productCategoryId2);
	              		productCategoryRollupMap.put(productCategoryId2, ProductCategoryRollup);
	              		
	              	}
	              }
               }
              //建立4级分类
              
              String productCategoryId3 ="";
              if(UtilValidate.isNotEmpty(convertCell(row.getCell(3)))){
  	            
	              if(!productCategoryId3Map.containsKey(convertCell(row.getCell(3)))){
	            	  productCategoryId3=productCategoryId2+"d"+category3Idx++;
	                  String productCategory = temp_ProductCategory.replace("#11#", productCategoryId3);
	                  productCategory = productCategory.replace("#21#", convertCell(row.getCell(3)));
	                  productCategory3Map.put(productCategoryId3, productCategory);
	                  
	                  //特征分类
	                  String featuryCategory = temp_featuryCategory.replace("#11#", productCategoryId3);
	                  featuryCategory = featuryCategory.replace("#21#", convertCell(row.getCell(3)));
	                  featureCategoryMap.put(productCategoryId3, featuryCategory);
	           		
		           		//分类和特征分类的关联
		          		String featuryCategoryAppl = temp_featuryCategoryAppl.replace("#11#", productCategoryId3);
		          		featuryCategoryAppl = featuryCategoryAppl.replace("#21#", productCategoryId3);
		          		featureCategorApplMap.put(productCategoryId3, featuryCategoryAppl);
	                  
	                  productCategoryId3Map.put(convertCell(row.getCell(3)), productCategoryId3);
	             }else{
	             		productCategoryId3=productCategoryId3Map.get(convertCell(row.getCell(3)));
	             }
	              
	              //建立3级分类和4级分类的关系
	             if(UtilValidate.isNotEmpty(productCategoryId2)&UtilValidate.isNotEmpty(productCategoryId3)){
	          	   if(UtilValidate.isEmpty(productCategoryRollupMap.get(productCategoryId3))){
	             		String ProductCategoryRollup = temp_ProductCategoryRollup.replace("#11#", productCategoryId2);
	             		ProductCategoryRollup = ProductCategoryRollup.replace("#21#", productCategoryId3);
	             		productCategoryRollupMap.put(productCategoryId3, ProductCategoryRollup);
	
	             	}
	             } 
              }
             //创建特征类型.创建特征 
              String categoryId = productCategoryId3;
              if(UtilValidate.isEmpty(productCategoryId3)){
            	  categoryId = productCategoryId2;
              }
              if(UtilValidate.isEmpty(productCategoryId2)){
            	  categoryId = productCategoryId1;
              }
            //读取常规特征
              isReturn : for (int j = 4; j <= 31; j++) {
                  String productFeatureTypeId = "";
                  if(j==4){
                  	productFeatureTypeId="BRAND";
                  }else if(j==5){
                  	productFeatureTypeId="SIZE";
                  }else if(j==6){
                  	productFeatureTypeId="COLOR";
                  }else if(j==7){
                  	productFeatureTypeId="ORIGIN";
                  }else if(j==8){
                  	productFeatureTypeId="ACCESSORY";
                  }else if(j==9){
                  	productFeatureTypeId="AMOUNT";
                  }else if(j==10){
                  	productFeatureTypeId="NET_WEIGHT";
                  }else if(j==11){
                  	productFeatureTypeId="ARTIST";
                  }else if(j==12){
                  	productFeatureTypeId="BILLING_FEATURE";
                  }else if(j==13){
                  	productFeatureTypeId="CARE";
                  }else if(j==14){
                  	productFeatureTypeId="DIMENSION";
                  }else if(j==15){
                  	productFeatureTypeId="EQUIP_CLASS";
                  }else if(j==16){
                  	productFeatureTypeId="FABRIC";
                  }else if(j==17){
                  	productFeatureTypeId="GENRE";
                  }else if(j==18){
                  	productFeatureTypeId="GIFT_WRAP";
                  }else if(j==19){
                  	productFeatureTypeId="HARDWARE_FEATURE";
                  }else if(j==20){
                  	productFeatureTypeId="HAZMAT";
                  }else if(j==21){
                  	productFeatureTypeId="LICENSE";
                  }else if(j==22){
                  	productFeatureTypeId="OTHER_FEATURE";
                  }else if(j==23){
                  	productFeatureTypeId="PRODUCT_QUALITY";
                  }else if(j==24){
                  	productFeatureTypeId="SOFTWARE_FEATURE";
                  }else if(j==25){
                  	productFeatureTypeId="STYLE";
                  }else if(j==26){
                  	productFeatureTypeId="SYMPTOM";
                  }else if(j==27){
                  	productFeatureTypeId="TOPIC";
                  }else if(j==28){
                  	productFeatureTypeId="TYPE";
                  }else if(j==29){
                  	productFeatureTypeId="WARRANTY";
                  }else if(j==30){
                  	productFeatureTypeId="MODEL_YEAR";
                  }else if(j==31){
                  	productFeatureTypeId="YEAR_MADE";
                  }
                  
                  String cellVal = convertCell(row.getCell(j));
                  
                  if(UtilValidate.isEmpty(cellVal)){
                  	continue isReturn;
                  }
                  	  
                  if(UtilValidate.isNotEmpty(cellVal)){
                	  String[] featureValue = cellVal.split("===");
                	  for(String feature : featureValue){
                		  String featureId = featurePrefix + featureIdx++;
                		  String ProductFeature = temp_ProductFeature.replace("#11#", featureId);
                          ProductFeature = ProductFeature.replace("#21#", productFeatureTypeId);//类型
                          ProductFeature = ProductFeature.replace("#31#", categoryId);
                          ProductFeature = ProductFeature.replace("#41#", feature);
                          featureMap.put(feature, ProductFeature);
                          featureIdMap.put(feature, featureId);
                	  }
                  }
                      
              }
              //读取非常规特征
             for(int j=32 ; j<=190;j=j+2){
          	   
              	 String cellValInfo = convertCell(row.getCell(j));
              	 String cellVal = convertCell(row.getCell(j+1));
              	 if(UtilValidate.isNotEmpty(cellValInfo)&&UtilValidate.isNotEmpty(cellVal)){
              		//特征类型
              		 String featureTypeId = featureTypePrefix+featureTypeIdx++;
              		 if(!featureTypeMap.containsKey(cellValInfo)){
                           String ProductFeatureType = temp_ProductFeatureType.replace("#11#", featureTypeId);
                           ProductFeatureType = ProductFeatureType.replace("#21#", cellValInfo);//类型
                           featureTypeMap.put(cellValInfo, ProductFeatureType);
                           featureTypeIdMap.put(cellValInfo, featureTypeId);
                       }else{
                      	 featureTypeId = featureTypeIdMap.get(cellValInfo);
                       }
              		 	
              		 
              		 
	              	  String[] featureValue = cellVal.split("===");
	              	  for(String feature : featureValue){
	              		  
	              		  String featureId = featurePrefix + featureIdx++;
	              		  String ProductFeature = temp_ProductFeature.replace("#11#", featureId);
	                        ProductFeature = ProductFeature.replace("#21#", featureTypeId);//类型
	                        ProductFeature = ProductFeature.replace("#31#", categoryId);
	                        ProductFeature = ProductFeature.replace("#41#", feature);
	                        featureMap.put(feature, ProductFeature);
	                        featureIdMap.put(feature, featureId);
	              	  }
              		 
              	 }
              	
              } 
              
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        //构建 xml文件内容
        String line = "\r\n";
        StringBuffer sb = new StringBuffer();
      sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+line);  
      sb.append("<entity-engine-xml>"+line);
      sb.append(StringUtils.join(productCategory0Map.values(), line));
      sb.append(line+line);
      sb.append(StringUtils.join(productCategory1Map.values(), line));
      sb.append(line+line);
      sb.append(StringUtils.join(productCategory2Map.values(), line));
      sb.append(line+line);
      sb.append(StringUtils.join(productCategory3Map.values(), line));
      sb.append(line+line);
      sb.append(StringUtils.join(productCategoryRollupMap.values(), line));
      sb.append(line+line);
      sb.append(StringUtils.join(prodCatalogCategoryMap.values(), line));
      sb.append(line+line);
      sb.append(StringUtils.join(productCategoryMemberMap.values(), line));
      sb.append(line+line);
      
      sb.append(StringUtils.join(featureCategoryMap.values(), line));
      sb.append(line+line);
      
      sb.append(StringUtils.join(featureCategorApplMap.values(), line));
      sb.append(line+line);
      
      sb.append(StringUtils.join(featureTypeMap.values(), line));
      sb.append(line+line);
      
      sb.append(StringUtils.join(featureMap.values(), line));
      sb.append(line+line);
      
      sb.append(line+"</entity-engine-xml>");
      
//      System.out.println(sb.toString());
      
      try {
    	String str = sb.toString();
//    	str = str.replace("\"", "");
    	str = str.replace("'", "");
    	String outPath="C:/Users/Administrator/Desktop/"+filePath+".xml";
		PrintWriter pw = new PrintWriter( new FileWriter( outPath ) );
		pw.write(str.toString());
		pw.close( );
	} catch (IOException e) {
		e.printStackTrace();
	}
    }
    
    
    
    /**
     * 产品生产.包含特征
     */
    
    /**
     *  产品Xls文件转换
     * @param filePathAndName
     */
   
 public static void xls2XmlForProduct(String filePathAndName){
        
        long featureIdx = 2000;
        String featurePrefix = "FT-";
        long invetoryIdx = 4000;
        Timestamp now = new Timestamp(System.currentTimeMillis());
        //列举需要处理的表
        String temp_Product = "<Product productId=\"#11#\" productName=\"#21#\" internalName=\"#41#\" primaryProductCategoryId=\"#31#\" productTypeId=\"FINISHED_GOOD\"  taxable=\"N\" chargeShipping=\"N\" autoCreateKeywords=\"Y\" isVirtual=\"N\" isVariant=\"N\" introductionDate=\"#51#\" salesDiscontinuationDate=\"#61#\" createdDate=\"#71#\" quantityUomId=\"#81#\" createdByUserLogin=\"admin\" />";
        
        String temp_ProductRole = "<ProductRole productId=\"#11#\" partyId=\"CompanyCq\" roleTypeId=\"SHIP_FROM_VENDOR\" fromDate=\"2001-05-13 12:00:00.0\"/> ";
        
        String temp_ProductFeature = "<ProductFeature productFeatureId=\"#11#\" productFeatureTypeId=\"#21#\" productFeatureCategoryId=\"#31#\" description=\"#41#\"/>";
        String temp_ProductFeatureAppl = "<ProductFeatureAppl productId=\"#11#\" productFeatureId=\"#21#\" productFeatureApplTypeId=\"STANDARD_FEATURE\" fromDate=\"#31#\" />";
        String temp_ProductCategoryMember = "<ProductCategoryMember productId=\"#11#\" productCategoryId=\"#21#\" fromDate=\"2001-05-13 12:00:00.000\"/>";
        String temp_ProductPrice="<ProductPrice productId=\"#11#\" productPricePurposeId=\"#41#\" productPriceTypeId=\"#21#\" currencyUomId=\"CNY\" productStoreGroupId=\"_NA_\" fromDate=\"2001-05-13 12:00:00.0\" price=\"#31#\"/>";
        String temp_ProductAttribute="<ProductAttribute productId=\"#11#\" attrName=\"#21#\"><attrValue><![CDATA[ #31# ]]></attrValue></ProductAttribute>";
        
        String temp_InventoryItem = "<InventoryItem facilityId=\"WebStoreWarehouse\" inventoryItemId=\"#11#\" inventoryItemTypeId=\"NON_SERIAL_INV_ITEM\" datetimeReceived=\"2008-08-01 08:00:00.000\" productId=\"#21#\" ownerPartyId=\"CompanyCq\" currencyUomId=\"CNY\" unitCost=\"200\"/>";
        String temp_InventoryItemDetail = "<InventoryItemDetail inventoryItemId=\"#11#\" inventoryItemDetailSeqId=\"0001\" effectiveDate=\"2001-05-13 12:00:00.0\" availableToPromiseDiff=\"228\" quantityOnHandDiff=\"228\" accountingQuantityDiff=\"228\"/>";
        
        
        
        Map<String, String> productMap = new HashMap<String, String>();
        Map<String, String> productRoleMap = new HashMap<String, String>();
        Map<String, String> inventoryItemMap = new HashMap<String, String>();
        Map<String, String> inventoryItemDetailMap = new HashMap<String, String>();
        Map<String, String> productPriceMap = new HashMap<String, String>();
        Map<String, String> productAttributeMap = new HashMap<String, String>();
        Map<String, String> productCategoryMemberMap = new HashMap<String, String>();
        Map<String, String> featureMap = new HashMap<String, String>();
        Map<String, String> featureIdMap = new HashMap<String, String>();
        Map<String, String> featureApplMap = new HashMap<String, String>();
        
        HSSFWorkbook workbook = null;
        HSSFSheet sheet = null;
        try {
            //载入
            workbook = new HSSFWorkbook(new FileInputStream(new File(filePathAndName)));
            sheet = workbook.getSheetAt(0);
            int rowEnd = sheet.getLastRowNum();
            
            //读取
            int i = 1;
            for (; i < rowEnd+1; i++) {
            	System.out.println("运行到第"+i+"行");
                HSSFRow row = sheet.getRow(i);
               
               
               String nowTime = UtilDateTime.nowTimestamp().toString();
                if(UtilValidate.isEmpty(convertCell(row.getCell(2)))){
                	continue ; 
                }
                //创建产品
                String productCategoryId1 = convertCell(row.getCell(1));
                String productId = convertCell(row.getCell(2));
                String productName = convertCell(row.getCell(3));
                String quantityUom = convertCell(row.getCell(4));
                String defaultPrice = convertCell(row.getCell(5));
                String listPrice = convertCell(row.getCell(6));
                String skuId = convertCell(row.getCell(8));
                
                String Product = temp_Product.replace("#11#", productId);

                Product = Product.replace("#21#", productName);
                Product = Product.replace("#31#", productCategoryId1);
                Product = Product.replace("#41#", skuId);
                Product = Product.replace("#51#", nowTime.substring(0,19));
                Product = Product.replace("#61#", getOneYearsAgoTime().substring(0,19));
                Product = Product.replace("#71#", nowTime.substring(0,19));
                String quantityUomId = "";
                if(UtilValidate.isNotEmpty(quantityUom)){
                	quantityUom = quantityUom.trim();
                    if(quantityUom.equals("套")){
                    	quantityUomId="WT_tao";
                    }else if(quantityUom.equals("片")){
                    	quantityUomId="WT_pian";
                    }else if(quantityUom.equals("台")){
                    	quantityUomId="WT_tai";
                    }else if(quantityUom.equals("个")){
                    	quantityUomId="WT_ge";
                    }else if(quantityUom.equals("延米")){
                    	quantityUomId="WT_yanmi";
                    }else if(quantityUom.equals("平方米")){
                    	quantityUomId="WT_pingfangmi";
                    }else if(quantityUom.equals("平米")){
                    	quantityUomId="WT_pingfangmi";
                    }else if(quantityUom.equals("千克")){
                    	quantityUomId="WT_kg";
                    }else if(quantityUom.equals("件")){
                    	quantityUomId="WT_jian";
                    }else if(quantityUom.equals("桶")){
                    	quantityUomId="WT_tong";
                    }else if(quantityUom.equals("对")){
                    	quantityUomId="WT_dui";
                    }else if(quantityUom.equals("副")){
                    	quantityUomId="WT_fu";
                    }else if(quantityUom.equals("根")){
                    	quantityUomId="WT_gen";
                    }else if(quantityUom.equals("盒")){
                    	quantityUomId="WT_he";
                    }else if(quantityUom.equals("支")){
                    	quantityUomId="WT_zhi";
                    }else if(quantityUom.equals("瓶")){
                    	quantityUomId="WT_ping";
                    }else if(quantityUom.equals("听")){
                    	quantityUomId="WT_ting";
                    }else if(quantityUom.equals("袋")){
                    	quantityUomId="WT_dai";
                    }else if(quantityUom.equals("合")){
                    	quantityUomId="WT_he";
                    }
                }
                
                Product = Product.replace("#81#", quantityUomId);
                
                productMap.put(productId, Product);
                
                
                String ProductRole = temp_ProductRole.replace("#11#", productId);
                productRoleMap.put(productId, ProductRole);
                
                
                long inventoryId = invetoryIdx++;
                String InventoryItem = temp_InventoryItem.replace("#21#", productId);
                InventoryItem = InventoryItem.replace("#11#", String.valueOf(inventoryId));
                inventoryItemMap.put(productId, InventoryItem);
                
                
                String InventoryItemDetail = temp_InventoryItemDetail.replace("#11#", String.valueOf(inventoryId));
                inventoryItemDetailMap.put(productId, InventoryItemDetail);
                
                
                //产品与分类的关联
                
                String ProductCategoryMember = temp_ProductCategoryMember.replace("#11#", productId);
                ProductCategoryMember = ProductCategoryMember.replace("#21#", productCategoryId1);
                productCategoryMemberMap.put(productId, ProductCategoryMember);
                
               
                //工程价
                if(UtilValidate.isNotEmpty(convertCell(row.getCell(5)))){
                	String ProductPrice = temp_ProductPrice.replace("#11#", productId);
                	ProductPrice = ProductPrice.replace("#21#", "DEFAULT_PRICE");
                	ProductPrice = ProductPrice.replace("#31#", defaultPrice);
                	ProductPrice = ProductPrice.replace("#41#", "PURCHASE");
                	productPriceMap.put(productId+"default", ProductPrice);
                }
                
                //市场价
                if(UtilValidate.isNotEmpty(convertCell(row.getCell(6)))){
                	String ProductPrice = temp_ProductPrice.replace("#11#", productId);
                	ProductPrice = ProductPrice.replace("#21#", "LIST_PRICE");
                	ProductPrice = ProductPrice.replace("#31#", listPrice);
                	ProductPrice = ProductPrice.replace("#41#", "PURCHASE");
                	productPriceMap.put(productId+"list", ProductPrice);
                }
                
                    String productFeatureTypeId = "BRAND";
                    String cellVal = convertCell(row.getCell(9));
                    if(UtilValidate.isNotEmpty(cellVal)){
                    	 String featureId = featurePrefix + featureIdx++;
                         //如果特征已存在
                         if(featureMap.containsKey(cellVal)){
                             String ProductFeatureAppl = temp_ProductFeatureAppl.replace("#11#", productId);
                             ProductFeatureAppl = ProductFeatureAppl.replace("#21#", featureIdMap.get(cellVal));
                             ProductFeatureAppl = ProductFeatureAppl.replace("#31#", now.toString());
                             featureApplMap.put(featureId, ProductFeatureAppl);
                         }else{
                         	//特征不存在
                             String ProductFeature = temp_ProductFeature.replace("#11#", featureId);
                             ProductFeature = ProductFeature.replace("#21#", productFeatureTypeId);//类型
                             ProductFeature = ProductFeature.replace("#31#", productCategoryId1);
                             ProductFeature = ProductFeature.replace("#41#", cellVal);
                             featureMap.put(cellVal, ProductFeature);
                             featureIdMap.put(cellVal, featureId);
                             
                             String ProductFeatureAppl = temp_ProductFeatureAppl.replace("#11#", productId);
                             ProductFeatureAppl = ProductFeatureAppl.replace("#21#", featureId);
                             ProductFeatureAppl = ProductFeatureAppl.replace("#31#", now.toString().subSequence(0, 19));
                             featureApplMap.put(featureId, ProductFeatureAppl);
                         }
                    }
                   

	          	 //插入产品属性 
	          	 for(int j=10 ; j<=45;j=j+2){
	          		String cellValInfo = convertCell(row.getCell(j));
                	String cellValue = convertCell(row.getCell(j+1));
	          		 if(UtilValidate.isNotEmpty(cellValInfo)&UtilValidate.isNotEmpty(cellValue)){
		          		String ProductAttribute = temp_ProductAttribute.replace("#11#", productId);
		          		ProductAttribute = ProductAttribute.replace("#21#", cellValInfo);
		          		ProductAttribute = ProductAttribute.replace("#31#", cellValue);
		          		productAttributeMap.put(productId+j, ProductAttribute);
	          		 }
	          	 }

            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        //构建 xml文件内容
        String line = "\r\n";
        StringBuffer sb = new StringBuffer();
      sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+line);  
      sb.append("<entity-engine-xml>"+line);
      
      sb.append(StringUtils.join(productMap.values(), line));
      sb.append(line+line);
      sb.append(StringUtils.join(productRoleMap.values(), line));
      sb.append(line+line);
      sb.append(StringUtils.join(productPriceMap.values(), line));
      sb.append(line+line);
      sb.append(StringUtils.join(inventoryItemMap.values(), line));
      sb.append(line+line);
      sb.append(StringUtils.join(inventoryItemDetailMap.values(), line));
      sb.append(line+line);
      sb.append(StringUtils.join(productCategoryMemberMap.values(), line));
      sb.append(line+line);
      sb.append(StringUtils.join(featureMap.values(), line));
      sb.append(line+line);
      sb.append(StringUtils.join(featureApplMap.values(), line));
      sb.append(line+line);
      sb.append(StringUtils.join(productAttributeMap.values(), line));
      
      sb.append(line+"</entity-engine-xml>");
      
//      System.out.println(sb.toString());
      
	   try {
	    	String str = sb.toString();
	//    	str = str.replace("\"", "");
	    	str = str.replace("'", "");
	    	String outPath="C:/Users/Administrator/Desktop/productData.xml";
			PrintWriter pw = new PrintWriter( new FileWriter( outPath ) );
			pw.write(str.toString());
			pw.close( );
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
    
    /**
     * 读取单元给内容为 字符串
     * @param cell
     * @return
     */
    public static String convertCell(HSSFCell cell) {
        String cellValue = "";
        if (cell == null) {
            return cellValue;
        }
        NumberFormat formater = NumberFormat.getInstance();
        formater.setGroupingUsed(false);
        switch (cell.getCellType()) {
            case HSSFCell.CELL_TYPE_NUMERIC:
                cellValue = formater.format(cell.getNumericCellValue());
                break;
            case HSSFCell.CELL_TYPE_STRING:
                cellValue = cell.getStringCellValue();
                break;
            case HSSFCell.CELL_TYPE_BLANK:
                cellValue = cell.getStringCellValue();
                break;
            case HSSFCell.CELL_TYPE_BOOLEAN:
                cellValue = Boolean.valueOf(cell.getBooleanCellValue()).toString();
                break;
            case HSSFCell.CELL_TYPE_ERROR:
                cellValue = String.valueOf(cell.getErrorCellValue());
                break;
            default:
                cellValue = "";
        }
        return cellValue.replaceAll("\\s","").trim();
    }
    
    /**
     * 转换USD为CNY
     * @param ofbizHomePath
     */
    public static void usd2Cny(String ofbizHomePath){
        if(!ofbizHomePath.endsWith("/")) ofbizHomePath+="/";
        String[] OFBIZ_APP_FOLDERS = {"framework", "applications", "specialpurpose", "hot-deploy"};
        for (int i = 0; i < OFBIZ_APP_FOLDERS.length; i++) {
            String app_dirs = ofbizHomePath + OFBIZ_APP_FOLDERS[i] + "/";
            String[] appArr = getFileStrListFromFolder(app_dirs, "");
            if(appArr == null || appArr.length < 1) return;
            
            for (int j = 0; j < appArr.length; j++) {
                String appFolder = appArr[j];
                if(appFolder.indexOf(".")>-1) continue;
                
                String[] includeDir = {"/testdef/data/", "/data/"};
                for (int l = 0; l < includeDir.length; l++) {

                    String appDir = app_dirs + appFolder + includeDir[l];
                    if(excludesFile(appDir)) continue;
                    String[] dataArr = getFileStrListFromFolder(appDir, "xml");
                    
                    for (int k = 0; k < dataArr.length; k++) {
                        String dataFilePath = appDir + dataArr[k];
                        if(!excludesFile(dataFilePath)){
                            System.out.println(dataFilePath);
                            StringBuffer sb = readFileAndReplaceAll(dataFilePath);
                            writeFile(new File(dataFilePath), sb.toString(), false);
                        }
                    }
                }
            }
        }
        /*
        //迭代目录, 判断 /data/ 包含
        //文件列表迭代, 判断文件/读取/替换/保存
        boolean end = false;
        do {
            File f = new File(ofbizHomePath);
            
        } while (end);
        
        
        String input ="";
        //CurrencyUomId="USD"
                
        //currencyUomId="USD"
        input.replaceAll("UomId=\"USD\"", "UomId=\"CNY\"");
        
        input.replaceAll("uomId=\"USD\"", "uomId=\"CNY\"");
        
        //CurrencyData.xml
        
         */
    }
    
    /**
     * 获取文件列表信息[String]
     * @param filePath [文件路径]
     * @param type [获取指定类型的文件名]
     * @return
     */
    public static String[] getFileStrListFromFolder(String filePath, String type) {
        String[] tmpArr = null;
        File tmp = new File(filePath);
        if(!tmp.isDirectory()){
            tmp = new File(new File(filePath).getParent());
        }
        if(tmp.isDirectory()){
            if(type!=null && !type.equals("")){
                tmpArr = tmp.list(typeFilter(type));
            }else{
                tmpArr = tmp.list();
            }
        }
        return tmpArr;
    }

    /**
     * 通过过滤内容获取文件过滤器
     * @param type
     * @return
     */
    protected static final FilenameFilter typeFilter(final String type){
        return new FilenameFilter() {
            //返回true的文件则合格
            @Override
            public boolean accept(File dir, String path) {
                String filename=new File(path).getName();
                return filename.indexOf(type)!=-1;
            }
        };
    }

    /**
     * 读取文件
     * @param filePathName [文件路径 + 文件名]
     * @param charSet [读取数据的编码方式]
     * @param split [行数据分隔符]
     * @param size [缓冲区大小]
     * @return
     */
    public static StringBuffer readFileAndReplaceAll(String filePathName) {
        StringBuffer sb = new StringBuffer();
        if (filePathName == null || filePathName.equals("") || !new File(filePathName).exists()) { return sb; }
        
        BufferedReader br = null;
        try{
            br = new BufferedReader(
                    new InputStreamReader(
                            new FileInputStream(filePathName), "UTF-8"), 1024);
            String data = "";
            while ((data = br.readLine()) != null) {
                sb.append(replaceAll(data)).append("\r\n");
            }
        }catch(IOException e) {
            System.out.println(filePathName+"_文件读取失败!");
        }finally{
            try{
                br.close();
            }catch(IOException e) {
                System.out.println(filePathName+"_文件读取缓冲器强制关闭!");
            }
        }
        return sb;
    }

    /**
     * 文件写入操作 
     * @param tmpFile 文件对象
     * @param fileContent 文件内容
     * @param isAppend 是否为追加
     * @return
     */
    protected static final boolean writeFile(File tmpFile, String fileContent, boolean isAppend){
        if (!tmpFile.exists()) { return false; }
        try {
            //isAppend=true，则将字节写入文件末尾处，而不是写入文件开始处。
            Writer out=new FileWriter(tmpFile, isAppend); 
            out.write(fileContent);
            out.close();
            return true;
        } catch (IOException e) {
            System.out.println(tmpFile.getPath() + "_文件写入失败!");
        }
        return false;
    }
    
    
    /**
     * 检查并跳过文件
     * @param filePathAndName
     * @return
     */
    public static boolean excludesFile(String filePathAndName){
        boolean isPass = false;
        if (filePathAndName == null || filePathAndName.equals("") || !new File(filePathAndName).exists()) { return true; }
        String[] excludes = {
                "CurrencyData.xml"
        };
        for (int i = 0; i < excludes.length; i++) {
            if(filePathAndName.indexOf(excludes[i])!=-1){
                isPass = true;
                break;
            }
        }
        if(!readFileAndFind(filePathAndName)){
        	 isPass = true;
        }
        return isPass;
    }
    /**
     * 读取文件
     * 检查文件中是否有可替换的字符串
     * @return
     */
    public static boolean readFileAndFind(String filePathName) {
    	boolean isFind = false;
        
        if (filePathName == null || filePathName.equals("") || !new File(filePathName).exists()) { return isFind; }
        
        BufferedReader br = null;
        try{
            br = new BufferedReader(
                    new InputStreamReader(
                            new FileInputStream(filePathName), "UTF-8"), 1024);
            String data = "";
            while ((data = br.readLine()) != null) {
            	int ss = data.indexOf("UomId=\"USD\"");
            	if(ss==-1){return isFind;}
            	ss = data.indexOf("uomId=\"USD\"");
            	if(ss==-1){return isFind;}
            	ss = data.indexOf("Uom=\"USD\"");
            	if(ss==-1){return isFind;}
                
            }
        }catch(IOException e) {
            System.out.println(filePathName+"_文件读取失败!");
            return isFind;
        }finally{
            try{
                br.close();
            }catch(IOException e) {
                System.out.println(filePathName+"_文件读取缓冲器强制关闭!");
                return isFind;
            }
        }
        isFind=true;
        return isFind;
    }
    
    /**
     * 替换
     * @param content
     * @return
     */
    public static String replaceAll(String content){
        //CurrencyUomId="USD"
        //currencyUomId="USD"
        content = content.replaceAll("UomId=\"USD\"", "UomId=\"CNY\"");
        content = content.replaceAll("uomId=\"USD\"", "uomId=\"CNY\"");
        content = content.replaceAll("Uom=\"USD\"", "Uom=\"CNY\"");
        return content;
    }
    
	/**
     * 转换USD为CNY
     * @param ofbizHomePath
     */
	public static void importProductXlsToXml(String ofbizHomePath){
		
		
		
		
		
			
            List rowList=new ArrayList();
			
			
	        	  

	}	
	    
	public List ss(List rowList){
		List dataRows = FastList.newInstance();
		String product ="<Product productId='@1@' productName='@2@'/>hezengyao";
		String productFurture ="<ProductFurture productId='@1@' productFurtureId='@11@'/>";
		
		for (int rowNum = 1 ; rowNum < rowList.size() ; rowNum++) {
			List row = (List)rowList.get(rowNum);
           
            	
            		product =product.replace("@1@", (String)row.get(1));
            	
            	
            		product =product.replace("@2@", (String)row.get(2));
            	
            		dataRows.add(product);
            		
            		productFurture =productFurture.replace("@1@", (String)row.get(1));
            		productFurture =productFurture.replace("@11@", (String)row.get(11));
            		dataRows.add(productFurture);
            	
            		productFurture =productFurture.replace("@1@", (String)row.get(1));
	            	
            		productFurture =productFurture.replace("@12@", (String)row.get(12));
            		
            		dataRows.add(productFurture);
            		
            	
             
            
          
           }
		return dataRows;
	}
	
	
}
