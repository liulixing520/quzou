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
package org.ofbiz.product.category;

import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.GeneralException;
import org.ofbiz.base.util.StringUtil;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.base.util.GeneralRuntimeException;
import org.ofbiz.content.content.ContentWorker;
import org.ofbiz.content.content.ContentWrapper;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.model.ModelEntity;
import org.ofbiz.entity.model.ModelUtil;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.service.LocalDispatcher;

/**
 * Category Content Worker: gets category content to display
 */
public class EbizCategoryContentWrapper implements ContentWrapper {

    public static final String module = EbizCategoryContentWrapper.class.getName();

    protected LocalDispatcher dispatcher;
    protected GenericValue productCategory;
    protected Locale locale;
    protected String mimeTypeId;

    public static EbizCategoryContentWrapper makeCategoryContentWrapper(GenericValue productCategory, HttpServletRequest request) {
        return new EbizCategoryContentWrapper(productCategory, request);
    }

    public EbizCategoryContentWrapper(LocalDispatcher dispatcher, GenericValue productCategory, Locale locale, String mimeTypeId) {
        this.dispatcher = dispatcher;
        this.productCategory = productCategory;
        this.locale = locale;
        this.mimeTypeId = mimeTypeId;
    }

    public EbizCategoryContentWrapper(GenericValue productCategory, HttpServletRequest request) {
        this.dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        this.productCategory = productCategory;
        this.locale = UtilHttp.getLocale(request);
        this.mimeTypeId = "text/html";
    }

    public StringUtil.StringWrapper get(String prodCatContentTypeId) {
        return StringUtil.makeStringWrapper(getProductCategoryContentAsText(productCategory, prodCatContentTypeId, locale, mimeTypeId, productCategory.getDelegator(), dispatcher));
    }

    public static String getProductCategoryContentAsText(GenericValue productCategory, String prodCatContentTypeId, HttpServletRequest request) {
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        return getProductCategoryContentAsText(productCategory, prodCatContentTypeId, UtilHttp.getLocale(request), "text/html", productCategory.getDelegator(), dispatcher);
    }

    public static String getProductCategoryContentAsText(GenericValue productCategory, String prodCatContentTypeId, Locale locale, LocalDispatcher dispatcher) {
        return getProductCategoryContentAsText(productCategory, prodCatContentTypeId, locale, null, null, dispatcher);
    }

    public static String getProductCategoryContentAsText(GenericValue productCategory, String prodCatContentTypeId, Locale locale, String mimeTypeId, Delegator delegator, LocalDispatcher dispatcher) {
        String candidateFieldName = ModelUtil.dbNameToVarName(prodCatContentTypeId);
        try {
            Writer outWriter = new StringWriter();
            getProductCategoryContentAsText(null, productCategory, prodCatContentTypeId, locale, mimeTypeId, delegator, dispatcher, outWriter);
            String outString = outWriter.toString();
            if (outString.length() > 0) {
                return outString;
            } else {
                return null;
            }
        } catch (GeneralException e) {
            Debug.logError(e, "Error rendering CategoryContent, inserting empty String", module);
            return productCategory.getString(candidateFieldName);
        } catch (IOException e) {
            Debug.logError(e, "Error rendering CategoryContent, inserting empty String", module);
            return productCategory.getString(candidateFieldName);
        }
    }

    public static void getProductCategoryContentAsText(String productCategoryId, GenericValue productCategory, String prodCatContentTypeId, Locale locale, String mimeTypeId, Delegator delegator, LocalDispatcher dispatcher, Writer outWriter) throws GeneralException, IOException {
        if (productCategoryId == null && productCategory != null) {
            productCategoryId = productCategory.getString("productCategoryId");
        }

        if (delegator == null && productCategory != null) {
            delegator = productCategory.getDelegator();
        }

        if (UtilValidate.isEmpty(mimeTypeId)) {
            mimeTypeId = "text/html";
        }

        if (delegator == null) {
            throw new GeneralRuntimeException("Unable to find a delegator to use!");
        }

        Map filterMap = UtilMisc.toMap("productCategoryId", productCategoryId, "prodCatContentTypeId", prodCatContentTypeId);
        List<GenericValue> categoryContentList = delegator.findByAnd("ProductCategoryContent",filterMap , UtilMisc.toList("-fromDate"), true);
        categoryContentList = EntityUtil.filterByDate(categoryContentList);
        GenericValue categoryContent = null;
        for(GenericValue productCategoryContent:categoryContentList){
        	GenericValue content = productCategoryContent.getRelatedOne("Content",true);
        	if(locale!=null){
        		if(locale.toString().equalsIgnoreCase(content.getString("localeString"))){
        			categoryContent = productCategoryContent;
        		}
        	}
        }
        if (UtilValidate.isNotEmpty(categoryContent)) {
            // when rendering the category content, always include the Product Category and ProductCategoryContent records that this comes from
            Map<String, Object> inContext = FastMap.newInstance();
            inContext.put("productCategory", productCategory);
            inContext.put("categoryContent", categoryContent);
            ContentWorker.renderContentAsText(dispatcher, delegator, categoryContent.getString("contentId"), outWriter, inContext, locale, mimeTypeId, null, null, true);
            return;
        }
        
        String candidateFieldName = ModelUtil.dbNameToVarName(prodCatContentTypeId);
        ModelEntity categoryModel = delegator.getModelEntity("ProductCategory");
        if (categoryModel.isField(candidateFieldName)) {
            if (productCategory == null) {
                productCategory = delegator.findOne("ProductCategory", UtilMisc.toMap("productCategoryId", productCategoryId), true);
            }
            if (productCategory != null) {
                String candidateValue = productCategory.getString(candidateFieldName);
                if (UtilValidate.isNotEmpty(candidateValue)) {
                    outWriter.write(candidateValue);
                    return;
                }
            }
        }

        
    }
    
    public static String getProdCatNameByLocale(GenericValue productCategory, HttpServletRequest request){
    	String prodCatNameByLocale = null;
    	prodCatNameByLocale = getProductCategoryContentAsText(productCategory, "CATEGORY_NAME", request);
    	if(UtilValidate.isEmpty(prodCatNameByLocale)){
    		prodCatNameByLocale = getProductCategoryContentAsText(productCategory, "DESCRIPTION", request);
    	}
    	if(UtilValidate.isEmpty(prodCatNameByLocale)){
    		prodCatNameByLocale = productCategory.getString("categoryName");
    	}
    	return prodCatNameByLocale;
    }
    
    public static String getProdCatNameByLocale(String productCategoryId, HttpServletRequest request){
    	String prodCatNameByLocale = null;
    	Delegator delegator = (Delegator) request.getAttribute("delegator");
    	GenericValue productCategory = null;
    	try {
			productCategory = delegator.findOne("ProductCategory", UtilMisc.toMap("productCategoryId", productCategoryId), true);
		} catch (GenericEntityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	prodCatNameByLocale = getProductCategoryContentAsText(productCategory, "CATEGORY_NAME", request);
    	if(UtilValidate.isEmpty(prodCatNameByLocale)){
    		prodCatNameByLocale = getProductCategoryContentAsText(productCategory, "DESCRIPTION", request);
    	}
    	if(UtilValidate.isEmpty(prodCatNameByLocale)){
    		prodCatNameByLocale = productCategory.getString("categoryName");
    	}
    	return prodCatNameByLocale;
    }
}
