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

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javolution.util.FastMap;

import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrRequest.METHOD;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrInputDocument;
import org.ofbiz.base.component.ComponentConfig;
import org.ofbiz.base.component.ComponentConfig.WebappInfo;
import org.ofbiz.base.component.ComponentException;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilGenerics;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.GenericEntityException;

/**
 * Solr utility class.
 */
public abstract class SolrUtil {
    
    public static final String module = SolrUtil.class.getName();

    private static String[] solrProdAttribute = { "productId", "internalName", "manu", "size", "smallImage", "mediumImage", "largeImage", "listPrice", "defaultPrice", "inStock", "isVirtual","isVariant","isDigital","isPhysical", "totalQuantityOrdered", "totalTimesViewed","averageCustomerRating","introductionDate","releaseDate","salesDiscontinuationDate","lastModifiedDate","primaryProductStoreId","productStoreName","productName","productNameZh","productNameRu", "saleAreas"};

    public static final String solrConfigName = "solrconfig.properties";
    public static final String solrUrl = makeSolrWebappUrl();

    public static String makeSolrWebappUrl() {
        final String solrWebappProtocol = UtilProperties.getPropertyValue(solrConfigName, "solr.webapp.protocol");
        final String solrWebappDomainName = UtilProperties.getPropertyValue(solrConfigName, "solr.webapp.domainName");
        final String solrWebappPath = UtilProperties.getPropertyValue(solrConfigName, "solr.webapp.path");
        final String solrWebappPortOverride = UtilProperties.getPropertyValue(solrConfigName, "solr.webapp.portOverride");
        
        String solrPort;
        if (UtilValidate.isNotEmpty(solrWebappPortOverride)) {
            solrPort = solrWebappPortOverride;
        }
        else {
            solrPort = UtilProperties.getPropertyValue("url.properties", ("https".equals(solrWebappProtocol) ? "port.https" : "port.http"));
        }
        
        return solrWebappProtocol + "://" + solrWebappDomainName + ":" + solrPort + solrWebappPath;
    }
    
    public static boolean isSolrEcaEnabled() {
        Boolean ecaEnabled = null;
        String sysProp = System.getProperty("ofbiz.solr.eca.enabled");
        if (UtilValidate.isNotEmpty(sysProp)) {
            if ("true".equalsIgnoreCase(sysProp))  {
                ecaEnabled = Boolean.TRUE;
            }
            else if ("false".equalsIgnoreCase(sysProp)) {
                ecaEnabled = Boolean.FALSE;
            }
        }
        if (ecaEnabled == null) {
            ecaEnabled = UtilProperties.getPropertyAsBoolean(SolrUtil.solrConfigName, "solr.eca.enabled", false);
        }
        return Boolean.TRUE.equals(ecaEnabled);
    }
    
    public static WebappInfo getSolrWebappInfo() {
        WebappInfo solrApp = null;
        try {
            ComponentConfig cc = ComponentConfig.getComponentConfig("solr");
            for(WebappInfo currApp : cc.getWebappInfos()) {
                if ("solr".equals(currApp.getName())) {
                    solrApp = currApp;
                    break;
                }
            }
        }
        catch(ComponentException e) {
            throw new IllegalStateException(e);
        }
        return solrApp;
    }
    
    public static boolean isSolrEcaWebappInitCheckPassed() {
        Boolean webappCheckEnabled = UtilProperties.getPropertyAsBoolean(solrConfigName, "solr.eca.useSolrWebappLoadedCheck", true);
        if (Boolean.TRUE.equals(webappCheckEnabled)) {
            return isSolrWebappInitialized();
        }
        else {
            // If webapp check disabled, then we say the check passed.
            return true;
        }
    }
    
    public static boolean isSolrWebappInitialized() {
        return OfbizSolrInfoServlet.isServletInitStatusReached();
    }
    
    public static boolean isEcaTreatConnectErrorNonFatal() {
        Boolean treatConnectErrorNonFatal = UtilProperties.getPropertyAsBoolean(solrConfigName, "solr.eca.treatConnectErrorNonFatal", true);
        return Boolean.TRUE.equals(treatConnectErrorNonFatal);
    }
    
    
    public static SolrInputDocument generateSolrDocument(Map<String, Object> context) throws GenericEntityException {
        SolrInputDocument doc1 = new SolrInputDocument();
        try{
        // add defined attributes
        for (int i = 0; i < solrProdAttribute.length; i++) {
            if (context.get(solrProdAttribute[i]) != null) {
                doc1.addField(solrProdAttribute[i], context.get(solrProdAttribute[i]).toString());
            }
        }

        // add catalog
        if (context.get("catalog") != null) {
            List<String> catalog = UtilGenerics.<String>checkList(context.get("catalog"));
            for (String c : catalog) {
                doc1.addField("catalog", c);
            }
        }

        // add categories
        if (context.get("category") != null) {
            List<String> category = UtilGenerics.<String>checkList(context.get("category"));
            Iterator<String> catIter = category.iterator();
            while (catIter.hasNext()) {
                /*
                 * GenericValue cat = (GenericValue) catIter.next(); GenericValue prodCategory = cat.getRelatedOneCache("ProductCategory"); if (prodCategory.get("description") != null) {
                 * doc1.addField("category", prodCategory.get("description")); } doc1.addField("cat", prodCategory.get("productCategoryId"));
                 */
                String cat = (String) catIter.next();
                doc1.addField("cat", cat);
            }
        }
        
        if (context.get("storeCategory") != null) {
            List<String> storeCategory = UtilGenerics.<String>checkList(context.get("storeCategory"));
            Iterator<String> catIter = storeCategory.iterator();
            while (catIter.hasNext()) {
                String cat = (String) catIter.next();
                doc1.addField("strcat", cat);
            }
        }

        // add features
        if (context.get("features") != null) {
            Set<String> features = UtilGenerics.<String>checkSet(context.get("features"));
            Iterator<String> featIter = features.iterator();
            while (featIter.hasNext()) {
                String feat = featIter.next();
                doc1.addField("features", feat);
            }
        }

        // add product features
        if (context.get("productFeatures") != null) {
        	List<String> productFeatures = UtilGenerics.<String>checkList(context.get("productFeatures"));
            Iterator<String> prodFeatIter = productFeatures.iterator();
            while (prodFeatIter.hasNext()) {
            	String prodFeat = prodFeatIter.next();
                doc1.addField("productFeatures", prodFeat);
            }
        }
        
        // add attributes
        if (context.get("attributes") != null) {
            List<String> attributes = UtilGenerics.<String>checkList(context.get("attributes"));
            Iterator<String> attrIter = attributes.iterator();
            while (attrIter.hasNext()) {
                String attr = attrIter.next();
                doc1.addField("attributes", attr);
            }
        }

        //add productAttributes
        if (context.get("productAttributes") != null) {
            Map<String,String> productAttributes = UtilGenerics.<String,String>checkMap(context.get("productAttributes"));
            Iterator<String> attrIter = productAttributes.keySet().iterator();
            while (attrIter.hasNext()) {
                String attr = attrIter.next();
                doc1.addField("attr_"+attr, productAttributes.get(attr));
            }
        }
        
        // add title
        if (context.get("title") != null) {
            Map<String, String> title = UtilGenerics.<String, String>checkMap(context.get("title"));
            for (Map.Entry<String, String> entry : title.entrySet()) {
                doc1.addField("title_i18n_" + entry.getKey(), entry.getValue());
            }
        }

        // add short_description
        if (context.get("description") != null) {
            Map<String, String> description = UtilGenerics.<String, String>checkMap(context.get("description"));
            for (Map.Entry<String, String> entry : description.entrySet()) {
                doc1.addField("description_i18n_" + entry.getKey(), entry.getValue());
            }
        }

        // add short_description
        if (context.get("longDescription") != null) {
            Map<String, String> longDescription = UtilGenerics.<String, String>checkMap(context.get("longDescription"));
            for (Map.Entry<String, String> entry : longDescription.entrySet()) {
                doc1.addField("longdescription_i18n_" + entry.getKey(), entry.getValue());
            }
        }

        if (context.get("saleAreas") != null) {
            List<String> saleAreas = UtilGenerics.<String>checkList(context.get("saleAreas"));
            for(String saleArea : saleAreas){
                doc1.addField("saleAreas", saleArea);
            }
        }
        }catch(Exception e){
        	e.printStackTrace();
        }
        return doc1;
    }
    
    public static Map<String, Object> categoriesAvailable(String catalogId, String categoryId, String productId, boolean displayproducts, int viewIndex, int viewSize) {
        return categoriesAvailable(catalogId,categoryId,productId,null,displayproducts,viewIndex,viewSize);
    }

    public static Map<String, Object> categoriesAvailable(String catalogId, String categoryId, String productId, String facetPrefix, boolean displayproducts, int viewIndex, int viewSize) {
        // create the data model
        Map<String, Object> result = FastMap.newInstance();
        HttpSolrServer server = null;
        QueryResponse returnMap = new QueryResponse();
        try {
            // do the basic query
            server = new HttpSolrServer(solrUrl);
            // create Query Object
            String query = "inStock[1 TO *]";
            if (categoryId != null)
                query += " +cat:"+ categoryId;
            else if (productId != null)
                query += " +productId:" + productId;
            SolrQuery solrQuery = new SolrQuery();
            solrQuery.setQuery(query);

            if (catalogId != null)
                solrQuery.setFilterQueries("catalog:" + catalogId);
            if (displayproducts) {
                if (viewSize > -1) {
                    solrQuery.setRows(viewSize);
                } else
                    solrQuery.setRows(50000);
                if (viewIndex > -1) {
                    solrQuery.setStart(viewIndex);
                }
            } else {
                solrQuery.setFields("cat");
                solrQuery.setRows(0);
            }
            
            if(UtilValidate.isNotEmpty(facetPrefix)){
                solrQuery.setFacetPrefix(facetPrefix);
            }
            
            solrQuery.setFacetMinCount(0);
            solrQuery.setFacet(true);
            solrQuery.addFacetField("cat");
            solrQuery.setFacetLimit(-1);
            Debug.logVerbose("solr: solrQuery: " + solrQuery, module);
            returnMap = server.query(solrQuery,METHOD.POST);
            result.put("rows", returnMap);
            result.put("numFound", returnMap.getResults().getNumFound());
        } catch (Exception e) {
            Debug.logError(e.getMessage(), module);
        }
        return result;
    }

}