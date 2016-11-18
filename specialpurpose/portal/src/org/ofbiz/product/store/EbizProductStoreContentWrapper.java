package org.ofbiz.product.store;

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

public class EbizProductStoreContentWrapper implements ContentWrapper {

    public static final String module = EbizProductStoreContentWrapper.class.getName();

    protected LocalDispatcher dispatcher;
    protected GenericValue productStore;
    protected Locale locale;
    protected String mimeTypeId;

    public static EbizProductStoreContentWrapper makeProductStoreContentWrapper(GenericValue productStore, HttpServletRequest request) {
        return new EbizProductStoreContentWrapper(productStore, request);
    }

    public EbizProductStoreContentWrapper(LocalDispatcher dispatcher, GenericValue productStore, Locale locale, String mimeTypeId) {
        this.dispatcher = dispatcher;
        this.productStore = productStore;
        this.locale = locale;
        this.mimeTypeId = mimeTypeId;
    }

    public EbizProductStoreContentWrapper(GenericValue productStore, HttpServletRequest request) {
        this.dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        this.productStore = productStore;
        this.locale = UtilHttp.getLocale(request);
        this.mimeTypeId = "text/html";
    }

    public StringUtil.StringWrapper get(String productStoreContentTypeId) {
        return StringUtil.makeStringWrapper(getProductStoreContentAsText(productStore, productStoreContentTypeId, locale, mimeTypeId, productStore.getDelegator(), dispatcher));
    }

    public static String getProductStoreContentAsText(GenericValue productStore, String productStoreContentTypeId, HttpServletRequest request) {
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        return getProductStoreContentAsText(productStore, productStoreContentTypeId, UtilHttp.getLocale(request), "text/html", productStore.getDelegator(), dispatcher);
    }

    public static String getProductStoreContentAsText(GenericValue productStore, String productContentTypeId, Locale locale, LocalDispatcher dispatcher) {
        return getProductStoreContentAsText(productStore, productContentTypeId, locale, null, null, dispatcher);
    }

    public static String getProductStoreContentAsText(GenericValue productStore, String productStoreContentTypeId, Locale locale, String mimeTypeId, Delegator delegator, LocalDispatcher dispatcher) {
        String candidateFieldName = ModelUtil.dbNameToVarName(productStoreContentTypeId);
        try {
            Writer outWriter = new StringWriter();
            getProductStoreContentAsText(null, productStore, productStoreContentTypeId, locale, mimeTypeId, delegator, dispatcher, outWriter);
            String outString = outWriter.toString();
            if (outString.length() > 0) {
                return outString;
            } else {
                return "";
            }
        } catch (GeneralException e) {
            Debug.logError(e, "Error rendering ProductStoreContent, inserting empty String", module);
            return productStore.getString(candidateFieldName);
        } catch (IOException e) {
            Debug.logError(e, "Error rendering ProductStoreContent, inserting empty String", module);
            return productStore.getString(candidateFieldName);
        }
    }

    public static void getProductStoreContentAsText(String productStoreId, GenericValue productStore, String productStoreContentTypeId, Locale locale, String mimeTypeId, Delegator delegator, LocalDispatcher dispatcher, Writer outWriter) throws GeneralException, IOException {
        if (productStoreId == null && productStore != null) {
            productStoreId = productStore.getString("productStoreId");
        }

        if (delegator == null && productStore != null) {
            delegator = productStore.getDelegator();
        }

        if (UtilValidate.isEmpty(mimeTypeId)) {
            mimeTypeId = "text/html";
        }

        if (delegator == null) {
            throw new GeneralRuntimeException("Unable to find a delegator to use!");
        }

        Map filterMap = UtilMisc.toMap("productStoreId", productStoreId, "productStoreContentTypeId", productStoreContentTypeId);
        List<GenericValue> productStoreContentList = delegator.findByAnd("ProductStoreContent",filterMap , UtilMisc.toList("-fromDate"), true);
        productStoreContentList = EntityUtil.filterByDate(productStoreContentList);
        GenericValue productStoreContent = null;
        for(GenericValue prodStoreContent : productStoreContentList){
        	GenericValue content = prodStoreContent.getRelatedOne("Content",true);
        	if(locale!=null){
        		if(locale.toString().equalsIgnoreCase(content.getString("localeString"))){
                    productStoreContent = prodStoreContent;
        		}
        	}
        }
        if (UtilValidate.isNotEmpty(productStoreContent)) {
            // when rendering the category content, always include the Product Category and ProductCategoryContent records that this comes from
            Map<String, Object> inContext = FastMap.newInstance();
            inContext.put("productStore", productStore);
            inContext.put("productStoreContent", productStoreContent);
            ContentWorker.renderContentAsText(dispatcher, delegator, productStoreContent.getString("contentId"), outWriter, inContext, locale, mimeTypeId, null, null, true);
            return ;
        }
        
        String candidateFieldName = ModelUtil.dbNameToVarName(productStoreContentTypeId);
        ModelEntity productStoreModel = delegator.getModelEntity("ProductStore");
        if (productStoreModel.isField(candidateFieldName)) {
            if (productStore == null) {
                productStore = delegator.findOne("ProductStore", UtilMisc.toMap("productStoreId", productStoreId), true);
            }
            if (productStore != null) {
                String candidateValue = productStore.getString(candidateFieldName);
                if (UtilValidate.isNotEmpty(candidateValue)) {
                    outWriter.write(candidateValue);
                    return ;
                }
            }
        }
    }
    
    public static String getProductStoreNameByLocale(GenericValue productStore, HttpServletRequest request){
    	String productStoreNameByLocale = null;
        productStoreNameByLocale = getProductStoreContentAsText(productStore, "TITLE", request);
    	if(UtilValidate.isEmpty(productStoreNameByLocale)){
            productStoreNameByLocale = productStore.getString("title");
    	}
    	return productStoreNameByLocale;
    }
    
    public static String getProductStoreNameByLocale(String productStoreId, HttpServletRequest request){
    	String productStoreNameByLocale = null;
    	Delegator delegator = (Delegator) request.getAttribute("delegator");
    	GenericValue productStore = null;
    	try {
			productStore = delegator.findOne("ProductStore", UtilMisc.toMap("productStoreId", productStoreId), true);
		} catch (GenericEntityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        productStoreNameByLocale = getProductStoreContentAsText(productStore, "TITLE", request);
    	if(UtilValidate.isEmpty(productStoreNameByLocale)){
            productStoreNameByLocale = productStore.getString("title");
    	}
    	return productStoreNameByLocale;
    }
}
