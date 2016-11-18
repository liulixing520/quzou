/*******************************************************************************
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *******************************************************************************/
package org.ofbiz.solr;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.product.config.ProductConfigWrapper;
import org.ofbiz.product.product.ProductContentWrapper;
import org.ofbiz.product.product.ProductWorker;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;

/**
 * Product utility class for solr.
 */
public abstract class ProductUtil {
    public static final String module = ProductUtil.class.getName();
    private static final String fmtSolrDate ="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";

    public static Map<String, Object> getProductContent(GenericValue product, DispatchContext dctx, Map<String, Object> context) {
        GenericDelegator delegator = (GenericDelegator) dctx.getDelegator();
        LocalDispatcher dispatcher = dctx.getDispatcher();
        GenericValue userLogin = (GenericValue) context.get("userLogin");
        String productId = (String) product.get("productId");
        Map<String, Object> dispatchContext = new HashMap<String, Object>();
        Locale locale = new Locale("zh_CN");
        TimeZone tz = TimeZone.getTimeZone("UTC");

        if (Debug.verboseOn()) {
            Debug.logVerbose("Solr: Getting product content for productId '" + productId + "'", module);
        }
        
        try {
            // Generate special ProductContentWrapper for the supported languages (de/en/fr/cn)
            ProductContentWrapper productContentEn = new ProductContentWrapper(dispatcher, product, new Locale("en"), null);
            ProductContentWrapper productContentDe = new ProductContentWrapper(dispatcher, product, new Locale("de"), null);
            ProductContentWrapper productContentFr = new ProductContentWrapper(dispatcher, product, new Locale("fr"), null);
            ProductContentWrapper productContentCn = new ProductContentWrapper(dispatcher, product, new Locale("cn"), null);
            ProductContentWrapper productContentRu = new ProductContentWrapper(dispatcher, product, new Locale("ru"), null);
            if (productId != null) {
                dispatchContext.put("productId", productId);
                // if (product.get("sku") != null) dispatchContext.put("sku", product.get("sku"));
                if (product.get("internalName") != null)
                    dispatchContext.put("internalName", product.get("internalName"));
                // GenericValue manu = product.getRelatedOneCache("Manufacturer");
                // if (product.get("manu") != null) dispatchContext.put("manu", "");
                String smallImage = (String) product.get("smallImageUrl");
                if (smallImage != null)
                    dispatchContext.put("smallImage", smallImage);
                String mediumImage = (String) product.get("mediumImageUrl");
                if (mediumImage != null)
                    dispatchContext.put("mediumImage", mediumImage);
                String largeImage = (String) product.get("largeImageUrl");
                if (largeImage != null)
                    dispatchContext.put("largeImage", largeImage);      
                
                if (product.get("productName") != null)
                    dispatchContext.put("productName", product.get("productName"));
                if (product.get("productNameZh") != null)
                    dispatchContext.put("productNameZh", product.get("productNameZh"));
                if (product.get("productNameRu") != null)
                    dispatchContext.put("productNameRu", product.get("productNameRu"));
                
                // if(product.get("weight") != null) dispatchContext.put("weight", "");

                // Trying to set a correctand trail
                List<GenericValue> category = delegator.findList("ProductCategoryMember", EntityCondition.makeCondition(UtilMisc.toMap("productId", productId)), null, null, null, false);
                List<String> trails = new ArrayList<String>();
                List<String> storeTrails = new ArrayList<String>();
                for (Iterator<GenericValue> catIterator = category.iterator(); catIterator.hasNext();) {
                    GenericValue cat = (GenericValue) catIterator.next();
                    String productCategoryId = (String) cat.get("productCategoryId");
                    List<List<String>> trailElements = CategoryUtil.getCategoryTrail(productCategoryId, dctx);
                    //Debug.log("trailElements ======> " + trailElements.toString());
                    for (List<String> trailElement : trailElements) {
                        StringBuilder catMember = new StringBuilder();
                        int i = 0;
                        Iterator<String> trailIter = trailElement.iterator();
                       
                        while (trailIter.hasNext()) {
                            String trailString = (String) trailIter.next();
                            if (catMember.length() > 0){
                                catMember.append("/");
                                i++;
                            }
                            catMember.append(trailString);
                            String cm = i +"/"+ catMember.toString();
                            if (!trails.contains(cm)) {
                                //Debug.logInfo("cm : "+cm, module);
                                trails.add(cm);
                                // Debug.log("trail for product " + productId + " ====> " + catMember.toString());
                            }
                        }
                        
                    }
                    //
                    List<List<String>> storeTrailElements = CategoryUtil.getStoreCategoryTrail(productCategoryId, dctx);
                    //Debug.log("trailElements ======> " + trailElements.toString());
                    for (List<String> trailElement : storeTrailElements) {
                        StringBuilder catMember = new StringBuilder();
                        int i = 0;
                        Iterator<String> trailIter = trailElement.iterator();
                       
                        while (trailIter.hasNext()) {
                            String trailString = (String) trailIter.next();
                            if (catMember.length() > 0){
                                catMember.append("/");
                                i++;
                            }
                            catMember.append(trailString);
                            String cm = i +"/"+ catMember.toString();
                            if (!storeTrails.contains(cm)) {
                                //Debug.logInfo("cm : "+cm, module);
                            	storeTrails.add(cm);
                                // Debug.log("trail for product " + productId + " ====> " + catMember.toString());
                            }
                        }
                        
                    }
                }
                dispatchContext.put("category", trails);
                dispatchContext.put("storeCategory", storeTrails);

                // Get the catalogs that have associated the categories
                List<String> catalogs = FastList.newInstance();
                for (String trail : trails) {
                    String productCategoryId = (trail.split("/").length > 0) ? trail.split("/")[1] : trail;
                    List<String> catalogMembers = CategoryUtil.getCatalogIdsByCategoryId(delegator, productCategoryId);
                    for (String catalogMember : catalogMembers)
                        if (!catalogs.contains(catalogMember))
                            catalogs.add(catalogMember);
                }
                dispatchContext.put("catalog", catalogs);

                // Alternative
                // if(category.size()>0) dispatchContext.put("category", category);
                // if(product.get("popularity") != null) dispatchContext.put("popularity", "");

                Map<String, Object> featureSet = dispatcher.runSync("getProductFeatureSet", UtilMisc.toMap("productId", productId));
                if (featureSet != null) {
                    dispatchContext.put("features", (Set<?>) featureSet.get("featureSet"));
                }
                
                Map<String, Object> productFeaturesResult = dispatcher.runSync("getProductFeatures", UtilMisc.toMap("productId", productId));
                if (productFeaturesResult != null) {
                	List<GenericValue> productFeatures = (List<GenericValue>) productFeaturesResult.get("productFeatures");
                	List<String> productFeatureStrList = FastList.newInstance();
                	for(GenericValue productFeatureAndAppl:productFeatures){
                		StringBuilder sbf = new StringBuilder();
                		sbf.append("featureId=").append(productFeatureAndAppl.getString("productFeatureId")).append("/");
                		sbf.append("featureTypeId=").append(productFeatureAndAppl.getString("productFeatureTypeId")).append("/");
                		sbf.append("featureCategoryId=").append(productFeatureAndAppl.getString("productFeatureCategoryId")).append("/");
                		sbf.append("featureApplTypeId=").append(productFeatureAndAppl.getString("productFeatureApplTypeId")).append("/");
                		productFeatureStrList.add(sbf.toString());
                	}
                    dispatchContext.put("productFeatures", productFeatureStrList);
                }

                Map<String, Object> productInventoryAvailable = dispatcher.runSync("getProductInventoryAvailable", UtilMisc.toMap("productId", productId));
                String inStock = null;
                BigDecimal availableToPromiseTotal = (BigDecimal) productInventoryAvailable.get("availableToPromiseTotal");
                if (availableToPromiseTotal != null) {
                    inStock = availableToPromiseTotal.toBigInteger().toString();
                }
                dispatchContext.put("inStock", inStock);

                Boolean isVirtual = ProductWorker.isVirtual(delegator, productId);
                if (isVirtual)
                    dispatchContext.put("isVirtual", isVirtual);
                Boolean isVariant = false;
                if(product.getString("isVariant")!=null && "Y".equals(product.getString("isVariant"))){
                	isVariant = true;
                }
                if (isVariant)
                    dispatchContext.put("isVariant", isVariant);
                Boolean isDigital = ProductWorker.isDigital(product);
                if (isDigital)
                    dispatchContext.put("isDigital", isDigital);
                Boolean isPhysical = ProductWorker.isPhysical(product);
                if (isPhysical)
                    dispatchContext.put("isPhysical", isPhysical);

                FastMap<String, String> title = new FastMap<String, String>();
                String detitle = productContentDe.get("PRODUCT_NAME").toString();
                if (detitle != null)
                    title.put("de", detitle);
                else if (product.get("productName") != null)
                    title.put("de", (String) product.get("productName"));
                String entitle = productContentEn.get("PRODUCT_NAME").toString();
                if (entitle != null)
                    title.put("en", entitle);
                else if (product.get("productName") != null)
                    title.put("en", (String) product.get("productName"));
                String frtitle = productContentFr.get("PRODUCT_NAME").toString();
                if (frtitle != null)
                    title.put("fr", frtitle);
                else if (product.get("productName") != null)
                    title.put("fr", (String) product.get("productName"));
                String cntitle = productContentCn.get("PRODUCT_NAME").toString();
                if (cntitle != null)
                    title.put("cn", cntitle);
                else if (product.get("productName") != null)
                    title.put("cn", (String) product.get("productName"));
                String rutitle = productContentRu.get("PRODUCT_NAME").toString();
                if (rutitle != null)
                    title.put("ru", rutitle);
                else if (product.get("productName") != null)
                    title.put("ru", (String) product.get("productName"));
                dispatchContext.put("title", title);

                Map<String, String> description = new FastMap<String, String>();
                String dedescription = productContentDe.get("DESCRIPTION").toString();
                if (dedescription != null)
                    description.put("de", dedescription);
                String endescription = productContentEn.get("DESCRIPTION").toString();
                if (endescription != null)
                    description.put("en", endescription);
                String frdescription = productContentFr.get("DESCRIPTION").toString();
                if (frdescription != null)
                    description.put("fr", frdescription);
                dispatchContext.put("description", description);
                String cndescription = productContentCn.get("DESCRIPTION").toString();
                if (cndescription != null)
                    description.put("cn", cndescription);
                String rudescription = productContentRu.get("DESCRIPTION").toString();
                if (rudescription != null)
                    description.put("ru", rudescription);
                dispatchContext.put("description", description);

                FastMap<String, String> longDescription = new FastMap<String, String>();
                String delongDescription = productContentDe.get("LONG_DESCRIPTION").toString();
                if (delongDescription != null)
                    longDescription.put("de", delongDescription);
                String enlongDescription = productContentEn.get("LONG_DESCRIPTION").toString();
                if (enlongDescription != null)
                    longDescription.put("en", enlongDescription);
                String frlongDescription = productContentFr.get("LONG_DESCRIPTION").toString();
                if (frlongDescription != null)
                    longDescription.put("fr", frlongDescription);
                String cnlongDescription = productContentCn.get("LONG_DESCRIPTION").toString();
                if (cnlongDescription != null)
                    longDescription.put("cn", cnlongDescription);
                String rulongDescription = productContentRu.get("LONG_DESCRIPTION").toString();
                if (rulongDescription != null)
                    longDescription.put("ru", rulongDescription);
                dispatchContext.put("longDescription", longDescription);

                // dispatchContext.put("comments", "");
                // dispatchContext.put("keywords", "");
                // dispatchContext.put("last_modified", "");

                if (product != null && "AGGREGATED".equals(product.getString("productTypeId"))) {
                    ProductConfigWrapper configWrapper = new ProductConfigWrapper(delegator, dispatcher, productId, null, null, null, null, locale, userLogin);
                    String listPrice = configWrapper.getTotalListPrice().setScale(2, BigDecimal.ROUND_HALF_DOWN).toString();
                    if (listPrice != null)
                        dispatchContext.put("listPrice", listPrice);
                    String defaultPrice = configWrapper.getTotalListPrice().setScale(2, BigDecimal.ROUND_HALF_DOWN).toString();
                    if (defaultPrice != null)
                        dispatchContext.put("defaultPrice", defaultPrice);
                } else {
                    Map<String, GenericValue> priceContext = UtilMisc.toMap("product", product);
                    Map<String, Object> priceMap = dispatcher.runSync("calculateProductPrice", priceContext);
                    if (priceMap.get("listPrice") != null) {
                        String listPrice = ((BigDecimal) priceMap.get("listPrice")).setScale(2, BigDecimal.ROUND_HALF_DOWN).toString();
                        dispatchContext.put("listPrice", listPrice);
                    }
                    if (priceMap.get("defaultPrice") != null) {
                        String defaultPrice = ((BigDecimal) priceMap.get("defaultPrice")).setScale(2, BigDecimal.ROUND_HALF_DOWN).toString();
                        if (defaultPrice != null)
                            dispatchContext.put("defaultPrice", defaultPrice);
                    }
                }
                
              //product attribute
                List<GenericValue> productAttrs = delegator.findByAnd("ProductAttribute", UtilMisc.toMap("productId",productId),null,true);
                if(UtilValidate.isNotEmpty(productAttrs)){
                	Map<String,String> productAttributes= FastMap.newInstance();
                	for (GenericValue productAttr : productAttrs) {
                		productAttributes.put(productAttr.getString("attrName"), productAttr.getString("attrValue"));
                	}
                	dispatchContext.put("productAttributes", productAttributes);
                }

                //ProductCalculatedInfo
                GenericValue productCalculatedInfo= delegator.findOne("ProductCalculatedInfo", UtilMisc.toMap("productId",productId),true);
                if(UtilValidate.isNotEmpty(productCalculatedInfo)){
                	if(UtilValidate.isNotEmpty(productCalculatedInfo.getBigDecimal("totalQuantityOrdered"))){
                		dispatchContext.put("totalQuantityOrdered", productCalculatedInfo.getBigDecimal("totalQuantityOrdered"));
                	}
                	if(UtilValidate.isNotEmpty(productCalculatedInfo.getLong("totalTimesViewed"))){
                		dispatchContext.put("totalTimesViewed", productCalculatedInfo.getLong("totalTimesViewed"));
                	}
                	if(UtilValidate.isNotEmpty(productCalculatedInfo.getBigDecimal("averageCustomerRating"))){
                		dispatchContext.put("averageCustomerRating", productCalculatedInfo.getBigDecimal("averageCustomerRating"));
                	}
                }
                if(UtilValidate.isNotEmpty(product.getTimestamp("introductionDate"))){
                	
                	Timestamp introDateTemp = product.getTimestamp("introductionDate");
                	String strIntroDate= UtilDateTime.timeStampToString(introDateTemp,fmtSolrDate,tz, locale);
                	Debug.logInfo("introductionDate="+strIntroDate, module);
                	/*
                	Timestamp timeIntroDate =  UtilDateTime.stringToTimeStamp(strIntroDate,UtilDateTime.DATE_TIME_SHORT_FORMAT,tz, locale);
                	*/
                	dispatchContext.put("introductionDate", strIntroDate);
                }
                if(UtilValidate.isNotEmpty(product.getTimestamp("releaseDate"))){
                	
                	Timestamp introDateTemp = product.getTimestamp("releaseDate");
                	String strIntroDate= UtilDateTime.timeStampToString(introDateTemp,fmtSolrDate,tz, locale);
                	Debug.logInfo("releaseDate="+strIntroDate, module);
                	/*
                	Timestamp timeIntroDate =  UtilDateTime.stringToTimeStamp(strIntroDate,UtilDateTime.DATE_TIME_SHORT_FORMAT,tz, locale);
                	*/
                	dispatchContext.put("releaseDate", strIntroDate);
                }
                if(UtilValidate.isNotEmpty(product.getTimestamp("salesDiscontinuationDate"))){
                	
                	Timestamp introDateTemp = product.getTimestamp("salesDiscontinuationDate");
                	String strIntroDate= UtilDateTime.timeStampToString(introDateTemp,fmtSolrDate,tz, locale);
                	Debug.logInfo("salesDiscontinuationDate="+strIntroDate, module);
                	/*
                	Timestamp timeIntroDate =  UtilDateTime.stringToTimeStamp(strIntroDate,UtilDateTime.DATE_TIME_SHORT_FORMAT,tz, locale);
                	*/
                	dispatchContext.put("salesDiscontinuationDate", strIntroDate);
                }
                if(UtilValidate.isNotEmpty(product.getTimestamp("lastModifiedDate"))){
                	
                	Timestamp introDateTemp = product.getTimestamp("lastModifiedDate");
                	String strIntroDate= UtilDateTime.timeStampToString(introDateTemp,fmtSolrDate,tz, locale);
                	Debug.logInfo("lastModifiedDate="+strIntroDate, module);
                	/*
                	Timestamp timeIntroDate =  UtilDateTime.stringToTimeStamp(strIntroDate,UtilDateTime.DATE_TIME_SHORT_FORMAT,tz, locale);
                	*/
                	dispatchContext.put("lastModifiedDate", strIntroDate);
                }
                //
                if(UtilValidate.isNotEmpty(product.getString("primaryProductStoreId"))){
                	dispatchContext.put("primaryProductStoreId", product.getString("primaryProductStoreId"));
                    GenericValue productStoreInfo = delegator.findOne("ProductStore", UtilMisc.toMap("productStoreId", product.getString("primaryProductStoreId")), true);
                    if(UtilValidate.isNotEmpty(productStoreInfo)){
                        if(UtilValidate.isNotEmpty(productStoreInfo.getString("storeName"))) {
                            dispatchContext.put("productStoreName", productStoreInfo.getString("storeName"));
                        }
                    }
                    List<GenericValue> saleAreaInfos = delegator.findByAnd("ProductStoreGeo", UtilMisc.toMap("productStoreId", product.getString("primaryProductStoreId")), null, true);
                    if(UtilValidate.isNotEmpty(saleAreaInfos)) {
                        int i = 0;
                        List<String> saleAreas = new ArrayList<String>();
                        for (GenericValue saleAreaInfo : saleAreaInfos) {
                            StringBuilder saleAreaIdStr = new StringBuilder();
                            saleAreaIdStr.append(i + "/");
                            List<String> geoIds = GeoUtil.getGeoTrail(saleAreaInfo.getString("geoId") , dctx);
                            if(UtilValidate.isNotEmpty(geoIds)){
                                String geoIdStr = "";
                                for(String geoId : geoIds){
                                    geoIdStr = geoId + "/" + geoIdStr ;
                                }
                                saleAreaIdStr.append(geoIdStr);
                            }
                            saleAreaIdStr.append(saleAreaInfo.getString("geoId"));
                            if (!saleAreas.contains(saleAreaIdStr)) {
                                saleAreas.add(saleAreaIdStr.toString());
                            }
                            i++;
                        }
                        dispatchContext.put("saleAreas", saleAreas);
                    }
                }
            }
        } catch (GenericEntityException e) {
            Debug.logError(e, e.getMessage(), module);
        } catch (Exception e) {
            Debug.logError(e, e.getMessage(), module);
        }
        return dispatchContext;
    }
}