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
package org.ofbiz.webapp.event;

import static org.ofbiz.base.util.UtilGenerics.checkList;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Writer;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javolution.util.FastList;
import javolution.util.FastMap;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.processors.JsDateJsonValueProcessor;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.StringUtil;
import org.ofbiz.base.util.UtilGenerics;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.model.ModelEntity;
import org.ofbiz.entity.util.EntityUtilProperties;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelParam;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;
import org.ofbiz.webapp.control.ConfigXMLReader;
import org.ofbiz.webapp.control.ConfigXMLReader.Event;
import org.ofbiz.webapp.control.ConfigXMLReader.RequestMap;

	/**
	 * RestEventHandler - REST Event Handler implementation
	 */
	public class RestEventHandler implements EventHandler {

	    public static final String module = RestEventHandler.class.getName();
	    

	    /**
	     * @see org.ofbiz.webapp.event.EventHandler#init(javax.servlet.ServletContext)
	     */
	    public void init(ServletContext context) throws EventHandlerException {
	    }

	    /**
	     * @see org.ofbiz.webapp.event.EventHandler#invoke(ConfigXMLReader.Event, ConfigXMLReader.RequestMap, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	     */
	    public String invoke(Event event, RequestMap requestMap, HttpServletRequest request, HttpServletResponse response) throws EventHandlerException {
	        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	        Delegator delegator = (GenericDelegator) request.getAttribute("delegator");
	        DispatchContext dctx = dispatcher.getDispatchContext();
	        
	        HttpSession session = request.getSession();
	        
            Map<String, Object> serviceContext = FastMap.newInstance();
        	
        	Map<String, Object> parameterMap = null;
        	List uploadedFileList = new ArrayList();
        	String method =request.getMethod();
        	if("POST".equals(method)||"PUT".equals(method)){
        		// get the service name and parameters
    	        BufferedReader reader = null;
                StringBuilder buf = new StringBuilder();
                boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
                try {
                	Map<String, Object> multiPartMap = new HashMap<String, Object>();
                	if (isMultiPart) {
                        // get the http upload configuration
                        String maxSizeStr = EntityUtilProperties.getPropertyValue("general.properties", "http.upload.max.size", "-1", dctx.getDelegator());
                        long maxUploadSize = -1;
                        try {
                            maxUploadSize = Long.parseLong(maxSizeStr);
                        } catch (NumberFormatException e) {
                            Debug.logError(e, "Unable to obtain the max upload size from general.properties; using default -1", module);
                            maxUploadSize = -1;
                        }
                        // get the http size threshold configuration - files bigger than this will be
                        // temporarly stored on disk during upload
                        String sizeThresholdStr = EntityUtilProperties.getPropertyValue("general.properties", "http.upload.max.sizethreshold", "10240", dctx.getDelegator());
                        int sizeThreshold = 10240; // 10K
                        try {
                            sizeThreshold = Integer.parseInt(sizeThresholdStr);
                        } catch (NumberFormatException e) {
                            Debug.logError(e, "Unable to obtain the threshold size from general.properties; using default 10K", module);
                            sizeThreshold = -1;
                        }
                        // directory used to temporarily store files that are larger than the configured size threshold
                        String tmpUploadRepository = EntityUtilProperties.getPropertyValue("general.properties", "http.upload.tmprepository", "runtime/tmp", dctx.getDelegator());
                        String encoding = request.getCharacterEncoding();
                        // check for multipart content types which may have uploaded items

                        ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory(sizeThreshold, new File(tmpUploadRepository)));

                        // create the progress listener and add it to the session
                        FileUploadProgressListener listener = new FileUploadProgressListener();
                        upload.setProgressListener(listener);
                        session.setAttribute("uploadProgressListener", listener);

                        if (encoding != null) {
                            upload.setHeaderEncoding(encoding);
                        }
                        upload.setSizeMax(maxUploadSize);

                        List<FileItem> uploadedItems = null;
                        try {
                            uploadedItems = UtilGenerics.<FileItem>checkList(upload.parseRequest(request));
                        } catch (FileUploadException e) {
                            throw new EventHandlerException("Problems reading uploaded data", e);
                        }
                        if (uploadedItems != null) {
                            for (FileItem item: uploadedItems) {
                                String fieldName = item.getFieldName();
                                if (item.isFormField() || item.getName() == null) {
                                    if (multiPartMap.containsKey(fieldName)) {
                                        Object mapValue = multiPartMap.get(fieldName);
                                        if (mapValue instanceof List<?>) {
                                            checkList(mapValue, Object.class).add(item.getString());
                                        } else if (mapValue instanceof String) {
                                            List<String> newList = new LinkedList<String>();
                                            newList.add((String) mapValue);
                                            newList.add(item.getString());
                                            multiPartMap.put(fieldName, newList);
                                        } else {
                                            Debug.logWarning("Form field found [" + fieldName + "] which was not handled!", module);
                                        }
                                    } else {
                                        if (encoding != null) {
                                            try {
                                                multiPartMap.put(fieldName, item.getString(encoding));
                                            } catch (java.io.UnsupportedEncodingException uee) {
                                                Debug.logError(uee, "Unsupported Encoding, using deafault", module);
                                                multiPartMap.put(fieldName, item.getString());
                                            }
                                        } else {
                                            multiPartMap.put(fieldName, item.getString());
                                        }
                                    }
                                } else {
                                	Map<String, Object> uploadedMap = FastMap.newInstance();
                                    String fileName = item.getName();
                                    if (fileName.indexOf('\\') > -1 || fileName.indexOf('/') > -1) {
                                        // get just the file name IE and other browsers also pass in the local path
                                        int lastIndex = fileName.lastIndexOf('\\');
                                        if (lastIndex == -1) {
                                            lastIndex = fileName.lastIndexOf('/');
                                        }
                                        if (lastIndex > -1) {
                                            fileName = fileName.substring(lastIndex + 1);
                                        }
                                    }
                                    uploadedMap.put("uploadedFile", ByteBuffer.wrap(item.get()));
                                    uploadedMap.put("_uploadedFile_size", Long.valueOf(item.getSize()));
                                    uploadedMap.put("_uploadedFile_fileName", fileName);
                                    uploadedMap.put("_uploadedFile_contentType", item.getContentType());
                                    uploadedFileList.add(uploadedMap);
                                }
                            }
                        }
                        request.setAttribute("multiPartMap", multiPartMap);
                        Map<String, Object> rawParametersMap = UtilHttp.getParameterMap(request, null, null);
                        Set<String> urlOnlyParameterNames = UtilHttp.getUrlOnlyParameterMap(request).keySet();
                        Map<String, Object> requestBodyMap = null;
                        try {
                        	requestBodyMap = RequestBodyMapHandlerFactory.extractMapFromRequestBody(request);
                        } catch (IOException ioe) {
                        	Debug.logWarning(ioe, module);
                        }
                        if (requestBodyMap != null) {
                        	rawParametersMap.putAll(requestBodyMap);
                        }
                        
                	}else{
//                		parameterMap = requestByMap(request, response);
                		// read the inputstream buffer
                		String line;
//                      reader = new BufferedReader(new InputStreamReader(request.getInputStream(),"UTF-8"));  
                		reader = new BufferedReader(new InputStreamReader(request.getInputStream()));
                		while ((line = reader.readLine()) != null) {
                			buf.append(line).append("\n");
                		}
                	}
                	
                } catch (Exception e) {
                    throw new EventHandlerException(e.getMessage(), e);
                } finally {
                    if (reader != null) {
                        try {
                            reader.close();
                        } catch (IOException e) {
                            throw new EventHandlerException(e.getMessage(), e);
                        }
                    }
                }
                Debug.logInfo("json: " + buf.toString(), module);
                Map<String, Object> rawParametersMap = UtilHttp.getParameterMap(request, null, null);
       		    serviceContext.putAll(rawParametersMap);
       		    if(UtilValidate.isNotEmpty(rawParametersMap)){
       		    	serviceContext.putAll(rawParametersMap);
       		    }else if(buf.toString().length()>0){
                	JSONObject json =JSONObject.fromObject(buf.toString());
                	serviceContext.putAll(json);
        		}
        	}
        	if("GET".equals(method)||"DELETE".equals(method)){
        		 Map<String, Object> rawParametersMap = UtilHttp.getParameterMap(request, null, null);
        		 serviceContext.putAll(rawParametersMap);
        		
        	}
	       
	        

            String serviceName = getOverrideViewUri(request.getPathInfo());
            String restIdValue= "";
            List<String> pathItemList = StringUtil.split(serviceName, "/");
            if(pathItemList.size()>1){
            	serviceName=pathItemList.get(0);
            	restIdValue=pathItemList.get(1);
            }
            Debug.log("serviceName:\n" + serviceName + "\n", module);
            GenericValue userLogin=null;
            
            try {
            	ModelService model = dctx.getModelService(serviceName);
               	 
                 if (model == null) {
                     sendError(response, "Problem processing the service", serviceName);
                     Debug.logError("Could not find Service [" + serviceName + "].", module);
                     return null;
                 }
                
//                 if (!model.export) {
//                     sendError(response, "Problem processing the service", serviceName);
//                     Debug.logError("Trying to call Service [" + serviceName + "] that is not exported.", module);
//                     return null;
//                 }
                 
            if(model.auth){
	         	     String  username =request.getHeader("USERNAME");
	         	     String  password =request.getHeader("PASSWORD");
	         	     if(UtilValidate.isNotEmpty(username) && UtilValidate.isNotEmpty(password)){
	         	    	serviceContext.remove("USERNAME");
	         	    	serviceContext.remove("PASSWORD");
	         	     }else {
	         	    	username = request.getParameter("USERNAME");
	         	    	password = request.getParameter("PASSWORD");
					}
	         	     
//	         	    GenericValue yuemeiUser = delegator.findOne("YuemeiUser", UtilMisc.toMap("userLoginId", username), true);
//	         	    if(UtilValidate.isNotEmpty(yuemeiUser)){
//	         	      String tenantId = yuemeiUser.getString("tenantId");
//	         	      if(UtilValidate.isNotEmpty(tenantId)){
//	         	          delegator = DelegatorFactory.getDelegator(delegator.getDelegatorBaseName() + "#" + tenantId);
//	         	          dispatcher = GenericDispatcher.getLocalDispatcher(dispatcher.getName(), delegator);
//	         	      }
//	         	    }
	         	        
	         	    Map<String,Object> loginResult = dispatcher.runSync("userLogin", UtilMisc.toMap("login.username", username, "login.password", password));//, "locale", Locale.CHINESE
	         		  Debug.log(loginResult.toString(),module);
	         		  if(ServiceUtil.isSuccess(loginResult)){
	         		  		userLogin = delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId", username), false);
	         		  	}
	         	    if(UtilValidate.isEmpty(userLogin)){
	            				sendError(response, "Problem processing the service, check your USERNAME and PASSWORD.", "serviceName");
	            	  }
            }
                 
 	        	
	        	 Locale locale = UtilHttp.getLocale(request);
	             TimeZone timeZone = UtilHttp.getTimeZone(request);
	        	 // get only the parameters for this service - converted to proper type
		        // TODO: pass in a list for error messages, like could not convert type or not a proper X, return immediately with messages if there are any
		        List<Object> errorMessages = FastList.newInstance();
//		        serviceContext = model.makeValid(serviceContext, ModelService.IN_PARAM, true, errorMessages, timeZone, locale);
		        if (errorMessages.size() > 0) {
		            
		            sendError(response, "Problem processing the serviceContext Valid,"+errorMessages, serviceName);
		        }

		        // include the UserLogin value object
		        if (userLogin != null) {
		            serviceContext.put("userLogin", userLogin);
		        }

		        // include the Locale object
		        if (locale != null) {
		            serviceContext.put("locale", locale);
		        }

		        // include the TimeZone object
		        if (timeZone != null) {
		            serviceContext.put("timeZone", timeZone);
		        }
		        if(UtilValidate.isNotEmpty(model.defaultEntityName)){
		        	ModelEntity modelEntity =delegator.getModelEntity(model.defaultEntityName);
			        if(UtilValidate.isNotEmpty(restIdValue)&&modelEntity.getPksSize()==1){
			        	String pkFieldName =modelEntity.getPkFieldNames().get(0);
			        	serviceContext.put(pkFieldName, restIdValue);
			        }
		        }
            } catch (GenericServiceException e) {
				Debug.logError(e.getMessage(), module);
				sendError(response, "Problem processing the service, check ."+e.getMessage(), serviceName);
			} catch (GenericEntityException e) {
				Debug.logError(e.getMessage(), module);
				sendError(response, "Problem processing the service, check your ."+e.getMessage(), serviceName);
			}
	       
            
	        
	        //response.setContentType("text/xml");
	        response.setContentType("application/json");
	      
	        Debug.logVerbose("[Processing]: REST Event", module);
	        
	        try {
	        		if(UtilValidate.isNotEmpty(uploadedFileList))
	        			serviceContext.put("uploadedFileList", uploadedFileList);
	        		if(UtilValidate.isNotEmpty(serviceName) && !"updateOutsideExperts".equals(serviceName) && !"saveTgAndItemAndDse".equals(serviceName) && 
	        				!"getMyFriends".equals(serviceName)){
	        			serviceContext.remove("json");
	        		}
	                Map<String, Object> serviceResults = dispatcher.runSync(serviceName, serviceContext);
	                Debug.logVerbose("[EventHandler] : Service invoked", module);
	                createAndSendRESTResponse(serviceResults, serviceName, response);
	            } catch (GenericServiceException e) {
	               
	                    if(e.getMessageList() == null) {
	                        sendError(response, e.getMessage(), serviceName);
	                    } else {
	                        sendError(response, e.getMessageList(), serviceName);
	                    }
	                    Debug.logError(e, module);
	                    return null;
	                
	            }
	        
	        return null;
	    }



	    private void createAndSendRESTResponse(Map<String, Object> serviceResults, String serviceName, HttpServletResponse response) throws EventHandlerException {
	        try {
	        // setup the response
	            Debug.logVerbose("[EventHandler] : Setting up response message", module);
	            
	            JsonConfig config = new JsonConfig();
	            config.registerJsonValueProcessor(java.util.Date.class, new JsDateJsonValueProcessor());
	            config.registerJsonValueProcessor(java.sql.Date.class, new JsDateJsonValueProcessor());
	            config.registerJsonValueProcessor(java.sql.Timestamp.class, new JsDateJsonValueProcessor());
	            config.registerJsonValueProcessor(java.sql.Time.class, new JsDateJsonValueProcessor());
	            JSONObject restResults =JSONObject.fromObject(serviceResults, config);
	            
//	            Debug.logInfo("restResults ==================" + restResults, module);
	            
	            // log the response message
	            if (Debug.verboseOn()) {
	                try {
	                    Debug.logInfo("Response Message:\n" + restResults + "\n", module);
	                } catch (Throwable t) {
	                }
	            }

	            //Writer out = response.getWriter();
                //out.write(restResults.toString());
                //restResult.write(out);
                //out.flush();
	            ByteArrayOutputStream bout = new ByteArrayOutputStream();
	            GZIPOutputStream gout = new GZIPOutputStream(bout); //buffer
	            gout.write(restResults.toString().getBytes());
	            gout.close();
	            //得到压缩后的数据
	            byte g[] = bout.toByteArray();
	            response.setHeader("Content-Encoding", "gzip");
	            response.setHeader("Content-Length",g.length +"");
	            response.getOutputStream().write(g);
                //restResult.write(response.getOutputStream());
	            //response.getOutputStream().flush();
	        } catch (Exception e) {
	            Debug.logError(e, module);
	            throw new EventHandlerException(e.getMessage(), e);
	        }
	    }
	    public static final int BUFFER = 1024;  
	    /** 
	     * 数据压缩 
	     *  
	     * @param is 
	     * @param os 
	     * @throws Exception 
	     */  
	    public static void compress(InputStream is, OutputStream os)  
	            throws Exception {  
	  
	        GZIPOutputStream gos = new GZIPOutputStream(os);  
	  
	        int count;  
	        byte data[] = new byte[BUFFER];  
	        while ((count = is.read(data, 0, BUFFER)) != -1) {  
	            gos.write(data, 0, count);  
	        }  
	  
	        gos.finish();  
	  
	        gos.flush();  
	        gos.close();  
	    }  
	    /** 
	     * 数据解压缩 
	     *  
	     * @param data 
	     * @return 
	     * @throws Exception 
	     */  
	    public static byte[] decompress(byte[] data) throws Exception {  
	        ByteArrayInputStream bais = new ByteArrayInputStream(data);  
	        ByteArrayOutputStream baos = new ByteArrayOutputStream();  
	  
	        // 解压缩  
	  
	        decompress(bais, baos);  
	  
	        data = baos.toByteArray();  
	  
	        baos.flush();  
	        baos.close();  
	  
	        bais.close();  
	  
	        return data;  
	    }  
	    /** 
	     * 数据解压缩 
	     *  
	     * @param is 
	     * @param os 
	     * @throws Exception 
	     */  
	    public static void decompress(InputStream is, OutputStream os)  
	            throws Exception {  
	  
	        GZIPInputStream gis = new GZIPInputStream(is);  
	  
	        int count;  
	        byte data[] = new byte[BUFFER];  
	        while ((count = gis.read(data, 0, BUFFER)) != -1) {  
	            os.write(data, 0, count);  
	        }  
	  
	        gis.close();  
	    }  
	    private void sendError(HttpServletResponse res, String errorMessage, String serviceName) throws EventHandlerException {
	        // setup the response
	        sendError(res, ServiceUtil.returnError(errorMessage), serviceName);
	    }

	    private void sendError(HttpServletResponse res, List<String> errorMessages, String serviceName) throws EventHandlerException {
	        sendError(res, ServiceUtil.returnError(errorMessages.toString()), serviceName);
	    }
	    private void sendError(HttpServletResponse response, Object object, String serviceName) throws EventHandlerException {
	        try {
	            // setup the response
	            //res.setContentType("text/xml");
	        	response.setContentType("application/json");
	            
	        	JSONObject restResults =JSONObject.fromObject(object);
	            Debug.logInfo("restResults ==================" + restResults, module);
	            
	    
	            // log the response message
	            if (Debug.verboseOn()) {Debug.logInfo("Response Message:\n" + restResults + "\n", module);}

	            //resEnv.serialize(res.getOutputStream());
	            //res.getOutputStream().flush();
	            Writer out = response.getWriter();
                out.write(restResults.toString());
                //restResult.write(out);
                out.flush();
	        } catch (Exception e) {
	            throw new EventHandlerException(e.getMessage(), e);
	        }
	    }
	    
	    public static String getOverrideViewUri(String path) {
	        List<String> pathItemList = StringUtil.split(path, "/");
	        if (pathItemList == null) {
	            return null;
	        }
	        pathItemList = pathItemList.subList(1, pathItemList.size());

	        String nextPage = null;
	        for (String pathItem: pathItemList) {
	            if (pathItem.indexOf('~') != 0) {
	                if (pathItem.indexOf('?') > -1) {
	                    pathItem = pathItem.substring(0, pathItem.indexOf('?'));
	                }
	                nextPage = (nextPage == null ? pathItem : nextPage + "/" + pathItem);
	            }
	        }
	        return nextPage;
	    }

	    private Map getServiceContext(HttpServletRequest request,DispatchContext dctx,ModelService model,Locale locale) throws EventHandlerException {

	        // get the http upload configuration
	        String maxSizeStr = EntityUtilProperties.getPropertyValue("general.properties", "http.upload.max.size", "-1", dctx.getDelegator());
	        long maxUploadSize = -1;
	        try {
	            maxUploadSize = Long.parseLong(maxSizeStr);
	        } catch (NumberFormatException e) {
	            Debug.logError(e, "Unable to obtain the max upload size from general.properties; using default -1", module);
	            maxUploadSize = -1;
	        }
	        // get the http size threshold configuration - files bigger than this will be
	        // temporarly stored on disk during upload
	        String sizeThresholdStr = EntityUtilProperties.getPropertyValue("general.properties", "http.upload.max.sizethreshold", "10240", dctx.getDelegator());
	        int sizeThreshold = 10240; // 10K
	        try {
	            sizeThreshold = Integer.parseInt(sizeThresholdStr);
	        } catch (NumberFormatException e) {
	            Debug.logError(e, "Unable to obtain the threshold size from general.properties; using default 10K", module);
	            sizeThreshold = -1;
	        }
	        // directory used to temporarily store files that are larger than the configured size threshold
	        String tmpUploadRepository = EntityUtilProperties.getPropertyValue("general.properties", "http.upload.tmprepository", "runtime/tmp", dctx.getDelegator());
	        String encoding = request.getCharacterEncoding();
	        // check for multipart content types which may have uploaded items
	        boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
	        Map<String, Object> multiPartMap = FastMap.newInstance();
	        if (isMultiPart) {
	            ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory(sizeThreshold, new File(tmpUploadRepository)));

	            // create the progress listener and add it to the session
	            FileUploadProgressListener listener = new FileUploadProgressListener();
	            upload.setProgressListener(listener);
	            //session.setAttribute("uploadProgressListener", listener);

	            if (encoding != null) {
	                upload.setHeaderEncoding(encoding);
	            }
	            upload.setSizeMax(maxUploadSize);

	            List<FileItem> uploadedItems = null;
	            try {
	                uploadedItems = UtilGenerics.<FileItem>checkList(upload.parseRequest(request));
	            } catch (FileUploadException e) {
	                throw new EventHandlerException("Problems reading uploaded data", e);
	            }
	            if (uploadedItems != null) {
	                for (FileItem item: uploadedItems) {
	                    String fieldName = item.getFieldName();
	                    //byte[] itemBytes = item.get();
	                    /*
	                    Debug.logInfo("Item Info [" + fieldName + "] : " + item.getName() + " / " + item.getSize() + " / " +
	                            item.getContentType() + " FF: " + item.isFormField(), module);
	                    */
	                    if (item.isFormField() || item.getName() == null) {
	                        if (multiPartMap.containsKey(fieldName)) {
	                            Object mapValue = multiPartMap.get(fieldName);
	                            if (mapValue instanceof List<?>) {
	                                checkList(mapValue, Object.class).add(item.getString());
	                            } else if (mapValue instanceof String) {
	                                List<String> newList = FastList.newInstance();
	                                newList.add((String) mapValue);
	                                newList.add(item.getString());
	                                multiPartMap.put(fieldName, newList);
	                            } else {
	                                Debug.logWarning("Form field found [" + fieldName + "] which was not handled!", module);
	                            }
	                        } else {
	                            if (encoding != null) {
	                                try {
	                                    multiPartMap.put(fieldName, item.getString(encoding));
	                                } catch (java.io.UnsupportedEncodingException uee) {
	                                    Debug.logError(uee, "Unsupported Encoding, using deafault", module);
	                                    multiPartMap.put(fieldName, item.getString());
	                                }
	                            } else {
	                                multiPartMap.put(fieldName, item.getString());
	                            }
	                        }
	                    } else {
	                        String fileName = item.getName();
	                        if (fileName.indexOf('\\') > -1 || fileName.indexOf('/') > -1) {
	                            // get just the file name IE and other browsers also pass in the local path
	                            int lastIndex = fileName.lastIndexOf('\\');
	                            if (lastIndex == -1) {
	                                lastIndex = fileName.lastIndexOf('/');
	                            }
	                            if (lastIndex > -1) {
	                                fileName = fileName.substring(lastIndex + 1);
	                            }
	                        }
	                        multiPartMap.put(fieldName, ByteBuffer.wrap(item.get()));
	                        multiPartMap.put("_" + fieldName + "_size", Long.valueOf(item.getSize()));
	                        multiPartMap.put("_" + fieldName + "_fileName", fileName);
	                        multiPartMap.put("_" + fieldName + "_contentType", item.getContentType());
	                    }
	                }
	            }
	        }

	        // store the multi-part map as an attribute so we can access the parameters
	        //request.setAttribute("multiPartMap", multiPartMap);

	        Map<String, Object> rawParametersMap = UtilHttp.getParameterMap(request, null, null);
	        Set<String> urlOnlyParameterNames = UtilHttp.getUrlOnlyParameterMap(request).keySet();

	        // we have a service and the model; build the context
	        Map<String, Object> serviceContext = FastMap.newInstance();
	        for (ModelParam modelParam: model.getInModelParamList()) {
	            String name = modelParam.name;

	            // don't include userLogin, that's taken care of below
	            if ("userLogin".equals(name)) continue;
	            // don't include locale, that is also taken care of below
	            if ("locale".equals(name)) continue;
	            // don't include timeZone, that is also taken care of below
	            if ("timeZone".equals(name)) continue;

	            Object value = null;
	            if (UtilValidate.isNotEmpty(modelParam.stringMapPrefix)) {
	                Map<String, Object> paramMap = UtilHttp.makeParamMapWithPrefix(request, multiPartMap, modelParam.stringMapPrefix, null);
	                value = paramMap;
	                if (Debug.verboseOn()) Debug.logVerbose("Set [" + modelParam.name + "]: " + paramMap, module);
	            } else if (UtilValidate.isNotEmpty(modelParam.stringListSuffix)) {
	                List<Object> paramList = UtilHttp.makeParamListWithSuffix(request, multiPartMap, modelParam.stringListSuffix, null);
	                value = paramList;
	            } else {
	                // first check the multi-part map
	                value = multiPartMap.get(name);

	                // next check attributes; do this before parameters so that attribute which can be changed by code can override parameters which can't
	                if (UtilValidate.isEmpty(value)) {
	                    Object tempVal = request.getAttribute(name);
	                    if (tempVal != null) {
	                        value = tempVal;
	                    }
	                }

	                // check the request parameters
	                if (UtilValidate.isEmpty(value)) {
	                    //ServiceEventHandler.checkSecureParameter(requestMap, urlOnlyParameterNames, name, session, serviceName, dctx.getDelegator());

	                    // if the service modelParam has allow-html="any" then get this direct from the request instead of in the parameters Map so there will be no canonicalization possibly messing things up
	                    if ("any".equals(modelParam.allowHtml)) {
	                        value = request.getParameter(name);
	                    } else {
	                        // use the rawParametersMap from UtilHttp in order to also get pathInfo parameters, do canonicalization, etc
	                        value = rawParametersMap.get(name);
	                    }

	                    // make any composite parameter data (e.g., from a set of parameters {name_c_date, name_c_hour, name_c_minutes})
	                    if (value == null) {
	                        value = UtilHttp.makeParamValueFromComposite(request, name, locale);
	                    }
	                }

	                // then session
//	                if (UtilValidate.isEmpty(value)) {
//	                    Object tempVal = request.getSession().getAttribute(name);
//	                    if (tempVal != null) {
//	                        value = tempVal;
//	                    }
//	                }

	                // no field found
	                if (value == null) {
	                    //still null, give up for this one
	                    continue;
	                }

	                if (value instanceof String && ((String) value).length() == 0) {
	                    // interpreting empty fields as null values for each in back end handling...
	                    value = null;
	                }
	            }
	            // set even if null so that values will get nulled in the db later on
	            serviceContext.put(name, value);
	        }
            
	        
	        return serviceContext;
	       

	    }
	}
