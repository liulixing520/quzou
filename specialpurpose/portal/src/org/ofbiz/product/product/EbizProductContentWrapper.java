package org.ofbiz.product.product;

import javolution.util.FastMap;
import org.ofbiz.base.util.*;

import org.ofbiz.content.content.ContentWorker;
import org.ofbiz.content.content.ContentWrapper;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.model.ModelEntity;
import org.ofbiz.entity.model.ModelUtil;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.service.LocalDispatcher;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class EbizProductContentWrapper implements ContentWrapper {

    public static final String module = EbizProductContentWrapper.class.getName();

    protected LocalDispatcher dispatcher;
    protected GenericValue product;
    protected Locale locale;
    protected String mimeTypeId;

    public static EbizProductContentWrapper makeProductContentWrapper(GenericValue product, HttpServletRequest request) {
        return new EbizProductContentWrapper(product, request);
    }

    public EbizProductContentWrapper(LocalDispatcher dispatcher, GenericValue product, Locale locale, String mimeTypeId) {
        this.dispatcher = dispatcher;
        this.product = product;
        this.locale = locale;
        this.mimeTypeId = mimeTypeId;
    }

    public EbizProductContentWrapper(GenericValue product, HttpServletRequest request) {
        this.dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        this.product = product;
        this.locale = UtilHttp.getLocale(request);
        this.mimeTypeId = "text/html";
    }

    public StringUtil.StringWrapper get(String productContentTypeId) {
        return StringUtil.makeStringWrapper(getProductContentAsText(product, productContentTypeId, locale, mimeTypeId, product.getDelegator(), dispatcher));
    }

    public static String getProductContentAsText(GenericValue product, String productContentTypeId, HttpServletRequest request) {
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        return getProductContentAsText(product, productContentTypeId, UtilHttp.getLocale(request), "text/html", product.getDelegator(), dispatcher);
    }

    public static String getProductContentAsText(GenericValue product, String productContentTypeId, Locale locale, LocalDispatcher dispatcher) {
        return getProductContentAsText(product, productContentTypeId, locale, null, null, dispatcher);
    }

    public static String getProductContentAsText(GenericValue product, String productContentTypeId, Locale locale, String mimeTypeId, Delegator delegator, LocalDispatcher dispatcher) {
        String candidateFieldName = ModelUtil.dbNameToVarName(productContentTypeId);
        try {
            Writer outWriter = new StringWriter();
            getProductContentAsText(null, product, productContentTypeId, locale, mimeTypeId, delegator, dispatcher, outWriter);
            String outString = outWriter.toString();
            if (outString.length() > 0) {
                return outString;
            } else {
                return "";
            }
        } catch (GeneralException e) {
            Debug.logError(e, "Error rendering ProductContent, inserting empty String", module);
            return product.getString(candidateFieldName);
        } catch (IOException e) {
            Debug.logError(e, "Error rendering ProductContent, inserting empty String", module);
            return product.getString(candidateFieldName);
        }
    }

    public static void getProductContentAsText(String productId, GenericValue product, String productContentTypeId, Locale locale, String mimeTypeId, Delegator delegator, LocalDispatcher dispatcher, Writer outWriter) throws GeneralException, IOException {
        if (productId == null && product != null) {
            productId = product.getString("productId");
        }

        if (delegator == null && product != null) {
            delegator = product.getDelegator();
        }

        if (UtilValidate.isEmpty(mimeTypeId)) {
            mimeTypeId = "text/html";
        }

        if (delegator == null) {
            throw new GeneralRuntimeException("Unable to find a delegator to use!");
        }

        Map filterMap = UtilMisc.toMap("productId", productId, "productContentTypeId", productContentTypeId);
        List<GenericValue> productContentList = delegator.findByAnd("ProductContent",filterMap , UtilMisc.toList("-fromDate"), true);
        productContentList = EntityUtil.filterByDate(productContentList);
        GenericValue productContent = null;
        for(GenericValue prodContent : productContentList){
        	GenericValue content = prodContent.getRelatedOne("Content",true);
        	if(locale!=null){
        		if(locale.toString().equalsIgnoreCase(content.getString("localeString"))){
                    productContent = prodContent;
        		}
        	}
        }
        if (UtilValidate.isNotEmpty(productContent)) {
            // when rendering the category content, always include the Product Category and ProductCategoryContent records that this comes from
            Map<String, Object> inContext = FastMap.newInstance();
            inContext.put("product", product);
            inContext.put("productContent", productContent);
            ContentWorker.renderContentAsText(dispatcher, delegator, productContent.getString("contentId"), outWriter, inContext, locale, mimeTypeId, null, null, true);
            return;
        }
        
        String candidateFieldName = ModelUtil.dbNameToVarName(productContentTypeId);
        ModelEntity productModel = delegator.getModelEntity("Product");
        if (productModel.isField(candidateFieldName)) {
            if (product == null) {
                product = delegator.findOne("Product", UtilMisc.toMap("productId", productId), true);
            }
            if (product != null) {
                String candidateValue = product.getString(candidateFieldName);
                if (UtilValidate.isNotEmpty(candidateValue)) {
                    outWriter.write(candidateValue);
                    return;
                }
            }
        }
    }
    
    public static String getProductNameByLocale(GenericValue product, HttpServletRequest request){
    	String productNameByLocale = null;
        productNameByLocale = getProductContentAsText(product, "INTERNAL_NAME", request);
    	if(UtilValidate.isEmpty(productNameByLocale)){
            productNameByLocale = product.getString("internalName");
    	}
    	return productNameByLocale;
    }
    
    public static String getProductNameByLocale(String productId, HttpServletRequest request){
    	String productNameByLocale = null;
    	Delegator delegator = (Delegator) request.getAttribute("delegator");
    	GenericValue product = null;
    	try {
			product = delegator.findOne("Product", UtilMisc.toMap("productId", productId), true);
		} catch (GenericEntityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        productNameByLocale = getProductContentAsText(product, "INTERNAL_NAME", request);
    	if(UtilValidate.isEmpty(productNameByLocale)){
            productNameByLocale = product.getString("internalName");
    	}
    	return productNameByLocale;
    }
    
    /**
     * productName
     */
    public static String getProductTitleByLocale(GenericValue product, HttpServletRequest request){
    	String productNameByLocale = null;
    	/*
    	Locale locale = UtilHttp.getLocale(request);
    	if(locale!=null && locale.toString().indexOf("zh")>-1){
    	    productNameByLocale = product.getString("productNameZh");
    	}
    	if(locale!=null && locale.toString().indexOf("ru")>-1){
    	    productNameByLocale = product.getString("productNameRu");
    	}
    	if(UtilValidate.isEmpty(productNameByLocale)){
            productNameByLocale = product.getString("productName");
    	}*/
    	productNameByLocale = product.getString("productName");
    	return productNameByLocale;
    }
    /**
     * productName
     */
    public static String getProductTitleByLocale(GenericValue product){
    	String productNameByLocale = null;
    	/*
    	Locale locale = UtilHttp.getLocale(request);
    	if(locale!=null && locale.toString().indexOf("zh")>-1){
    	    productNameByLocale = product.getString("productNameZh");
    	}
    	if(locale!=null && locale.toString().indexOf("ru")>-1){
    	    productNameByLocale = product.getString("productNameRu");
    	}
    	if(UtilValidate.isEmpty(productNameByLocale)){
            productNameByLocale = product.getString("productName");
    	}*/
    	productNameByLocale = product.getString("productName");
    	return productNameByLocale;
    }
}
