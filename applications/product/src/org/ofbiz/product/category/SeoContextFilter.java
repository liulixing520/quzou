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

import static org.ofbiz.base.util.UtilGenerics.checkMap;

import java.io.IOException;
import java.net.URL;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastSet;

import org.apache.oro.text.regex.Pattern;
import org.apache.oro.text.regex.Perl5Matcher;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.StringUtil;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilObject;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.DelegatorFactory;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.security.Security;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.webapp.control.ConfigXMLReader;
import org.ofbiz.webapp.control.ConfigXMLReader.ControllerConfig;
import org.ofbiz.webapp.control.ContextFilter;
import org.ofbiz.webapp.control.WebAppConfigurationException;
import org.ofbiz.webapp.website.WebSiteWorker;

/**
 * SeoContextFilter - Restricts access to raw files and configures servlet objects.
 */
public class SeoContextFilter extends ContextFilter {

    public static final String module = SeoContextFilter.class.getName();
    
    protected Set<String> WebServlets = FastSet.newInstance();
    
    public void init(FilterConfig config) throws ServletException {
        super.init(config);
        
        Map<String, ? extends ServletRegistration> servletRegistrations = config.getServletContext().getServletRegistrations();
        for (String key : servletRegistrations.keySet()) {
            Collection<String> servlets = servletRegistrations.get(key).getMappings();
            for (String servlet : servlets) {
                if (servlet.endsWith("/*")) {
                    servlet = servlet.substring(0, servlet.length() - 2);
                    if (UtilValidate.isNotEmpty(servlet) && !WebServlets.contains(servlet)) {
                        WebServlets.add(servlet);
                    }
                }
            }
        }
    }

    /**
     * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest, javax.servlet.ServletResponse, javax.servlet.FilterChain)
     */
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String uri = httpRequest.getRequestURI();
        boolean forwarded = forwardUri(httpResponse, uri);
        if (forwarded) {
            return;
        }

        URL controllerConfigURL = ConfigXMLReader.getControllerConfigURL(config.getServletContext());
        ControllerConfig controllerConfig = null;
        Map<String, ConfigXMLReader.RequestMap> requestMaps = null;
        try {
            controllerConfig = ConfigXMLReader.getControllerConfig(controllerConfigURL);
            requestMaps = controllerConfig.getRequestMapMap();
        } catch (WebAppConfigurationException e) {
            Debug.logError(e, "Exception thrown while parsing controller.xml file: ", module);
            throw new ServletException(e);
        }
        Set<String> uris = requestMaps.keySet();

        // NOTE: the following part is copied from org.ofbiz.webapp.control.ContextFilter.doFilter method, please update this if framework is updated.
        // Debug.logInfo("Running ContextFilter.doFilter", module);

        // ----- Servlet Object Setup -----
        // set the cached class loader for more speedy running in this thread

        // set the ServletContext in the request for future use
        httpRequest.setAttribute("servletContext", config.getServletContext());

        // set the webSiteId in the session
        if (UtilValidate.isEmpty(httpRequest.getSession().getAttribute("webSiteId"))) {
            httpRequest.getSession().setAttribute("webSiteId", WebSiteWorker.getWebSiteId(httpRequest));
        }

        // set the filesystem path of context root.
        httpRequest.setAttribute("_CONTEXT_ROOT_", config.getServletContext().getRealPath("/"));

        // set the server root url
        String serverRootUrl = UtilHttp.getServerRootUrl(httpRequest);
        httpRequest.setAttribute("_SERVER_ROOT_URL_", serverRootUrl);

        // request attributes from redirect call
        String reqAttrMapHex = (String) httpRequest.getSession().getAttribute("_REQ_ATTR_MAP_");
        if (UtilValidate.isNotEmpty(reqAttrMapHex)) {
            byte[] reqAttrMapBytes = StringUtil.fromHexString(reqAttrMapHex);
            Map<String, Object> reqAttrMap = checkMap(UtilObject.getObject(reqAttrMapBytes), String.class, Object.class);
            if (reqAttrMap != null) {
                for (Map.Entry<String, Object> entry : reqAttrMap.entrySet()) {
                    httpRequest.setAttribute(entry.getKey(), entry.getValue());
                }
            }
            httpRequest.getSession().removeAttribute("_REQ_ATTR_MAP_");
        }

        // ----- Context Security -----
        // check if we are disabled
        String disableSecurity = config.getInitParameter("disableContextSecurity");
        if (disableSecurity != null && "Y".equalsIgnoreCase(disableSecurity)) {
            chain.doFilter(httpRequest, httpResponse);
            return;
        }

        // check if we are told to redirect everthing
        String redirectAllTo = config.getInitParameter("forceRedirectAll");
        if (UtilValidate.isNotEmpty(redirectAllTo)) {
            // little trick here so we don't loop on ourself
            if (httpRequest.getSession().getAttribute("_FORCE_REDIRECT_") == null) {
                httpRequest.getSession().setAttribute("_FORCE_REDIRECT_", "true");
                Debug.logWarning("Redirecting user to: " + redirectAllTo, module);

                if (!redirectAllTo.toLowerCase().startsWith("http")) {
                    redirectAllTo = httpRequest.getContextPath() + redirectAllTo;
                }
                httpResponse.sendRedirect(redirectAllTo);
                return;
            } else {
                httpRequest.getSession().removeAttribute("_FORCE_REDIRECT_");
                chain.doFilter(httpRequest, httpResponse);
                return;
            }
        }

        // test to see if we have come through the control servlet already, if not do the processing
        String requestPath = null;
        String contextUri = null;
        if (httpRequest.getAttribute(ContextFilter.FORWARDED_FROM_SERVLET) == null) {
            // Debug.logInfo("In ContextFilter.doFilter, FORWARDED_FROM_SERVLET is NOT set", module);
            String allowedPath = config.getInitParameter("allowedPaths");
            String redirectPath = config.getInitParameter("redirectPath");
            String errorCode = config.getInitParameter("errorCode");

            List<String> allowList = StringUtil.split(allowedPath, ":");

            if (debug) Debug.logInfo("[Domain]: " + httpRequest.getServerName() + " [Request]: " + httpRequest.getRequestURI(), module);

            requestPath = httpRequest.getServletPath();
            if (requestPath == null) requestPath = "";
            if (requestPath.lastIndexOf("/") > 0) {
                if (requestPath.indexOf("/") == 0) {
                    requestPath = "/" + requestPath.substring(1, requestPath.indexOf("/", 1));
                } else {
                    requestPath = requestPath.substring(1, requestPath.indexOf("/"));
                }
            }

            String requestInfo = httpRequest.getServletPath();
            if (requestInfo == null) requestInfo = "";
            if (requestInfo.lastIndexOf("/") >= 0) {
                requestInfo = requestInfo.substring(0, requestInfo.lastIndexOf("/")) + "/*";
            }

            StringBuilder contextUriBuffer = new StringBuilder();
            if (httpRequest.getContextPath() != null) {
                contextUriBuffer.append(httpRequest.getContextPath());
            }
            if (httpRequest.getServletPath() != null) {
                contextUriBuffer.append(httpRequest.getServletPath());
            }
            if (httpRequest.getPathInfo() != null) {
                contextUriBuffer.append(httpRequest.getPathInfo());
            }
            contextUri = contextUriBuffer.toString();

            List<String> pathItemList = StringUtil.split(httpRequest.getPathInfo(), "/");
            String viewName = "";
            if (pathItemList != null) {
                viewName = pathItemList.get(0);
            }
            
            String requestUri = UtilHttp.getRequestUriFromTarget(httpRequest.getRequestURI());

            // Verbose Debugging
            if (Debug.verboseOn()) {
                for (String allow : allowList) {
                    Debug.logVerbose("[Allow]: " + allow, module);
                }
                Debug.logVerbose("[View Name]: " + viewName, module);
                Debug.logVerbose("[Request Uri]: " + requestUri, module);
                Debug.logVerbose("[Request path]: " + requestPath, module);
                Debug.logVerbose("[Request info]: " + requestInfo, module);
                Debug.logVerbose("[Servlet path]: " + httpRequest.getServletPath(), module);
                Debug.logVerbose(
                        "[Not In AllowList]: " + (!allowList.contains(requestPath) && !allowList.contains(requestInfo) && !allowList.contains(httpRequest.getServletPath()) && !allowList.contains(requestUri) && !allowList.contains("/" + viewName)),
                        module);
                Debug.logVerbose("[Not In controller]: " + (UtilValidate.isEmpty(requestPath) && UtilValidate.isEmpty(httpRequest.getServletPath()) && !uris.contains(viewName)),
                        module);
            }

            // check to make sure the requested url is allowed
            if (!allowList.contains(requestPath) && !allowList.contains(requestInfo) && !allowList.contains(httpRequest.getServletPath())
                    && !allowList.contains(requestUri) && !allowList.contains("/" + viewName)
                    && (UtilValidate.isEmpty(requestPath) && UtilValidate.isEmpty(httpRequest.getServletPath()) && !uris.contains(viewName))) {
                String filterMessage = "[Filtered request]: " + contextUri;

                if (redirectPath == null) {
                    if (UtilValidate.isEmpty(viewName)) {
                        // redirect without any url change in browser
                        RequestDispatcher rd = request.getRequestDispatcher(SeoControlServlet.defaultPage);
                        rd.forward(request, response);
                    } else {
                        int error = 404;
                        if (UtilValidate.isNotEmpty(errorCode)) {
                            try {
                                error = Integer.parseInt(errorCode);
                            } catch (NumberFormatException nfe) {
                                Debug.logWarning(nfe, "Error code specified would not parse to Integer : " + errorCode, module);
                            }
                        }
                        filterMessage = filterMessage + " (" + error + ")";
                        httpResponse.sendError(error, contextUri);
                        request.setAttribute("filterRequestUriError", contextUri);
                    }
                } else {
                    filterMessage = filterMessage + " (" + redirectPath + ")";
                    if (!redirectPath.toLowerCase().startsWith("http")) {
                        redirectPath = httpRequest.getContextPath() + redirectPath;
                    }
                    // httpResponse.sendRedirect(redirectPath);
                    if (uri.equals("") || uri.equals("/")) {
                        // redirect without any url change in browser
                        RequestDispatcher rd = request.getRequestDispatcher(redirectPath);
                        rd.forward(request, response);
                    } else {
                        // redirect with url change in browser
                        httpResponse.setStatus(SeoConfigUtil.DEFAULT_RESPONSECODE);
                        httpResponse.setHeader("Location", redirectPath);
                    }
                }
                Debug.logWarning(filterMessage, module);
                return;
            } else if ((allowList.contains(requestPath) || allowList.contains(requestInfo) || allowList.contains(httpRequest.getServletPath())
                    || allowList.contains(requestUri) || allowList.contains("/" + viewName))
                    && !WebServlets.contains(httpRequest.getServletPath())) {
                request.setAttribute(SeoControlServlet.REQUEST_IN_ALLOW_LIST, Boolean.TRUE);
            }
        }

        // check if multi tenant is enabled
        String useMultitenant = UtilProperties.getPropertyValue("general.properties", "multitenant");
        if ("Y".equals(useMultitenant)) {
            // get tenant delegator by domain name
            String serverName = httpRequest.getServerName();
            try {
                // if tenant was specified, replace delegator with the new per-tenant delegator and set tenantId to session attribute
                Delegator delegator = getDelegator(config.getServletContext());
                List<GenericValue> tenants = delegator.findList("Tenant", EntityCondition.makeCondition("domainName", serverName), null, UtilMisc.toList("-createdStamp"), null, false);
                if (UtilValidate.isNotEmpty(tenants)) {
                    GenericValue tenant = EntityUtil.getFirst(tenants);
                    String tenantId = tenant.getString("tenantId");

                    // if the request path is a root mount then redirect to the initial path
                    if (UtilValidate.isNotEmpty(requestPath) && requestPath.equals(contextUri)) {
                        String initialPath = tenant.getString("initialPath");
                        if (UtilValidate.isNotEmpty(initialPath) && !"/".equals(initialPath)) {
                            ((HttpServletResponse) response).sendRedirect(initialPath);
                            return;
                        }
                    }

                    // make that tenant active, setup a new delegator and a new dispatcher
                    String tenantDelegatorName = delegator.getDelegatorBaseName() + "#" + tenantId;
                    httpRequest.getSession().setAttribute("delegatorName", tenantDelegatorName);

                    // after this line the delegator is replaced with the new per-tenant delegator
                    delegator = DelegatorFactory.getDelegator(tenantDelegatorName);
                    config.getServletContext().setAttribute("delegator", delegator);

                    // clear web context objects
                    config.getServletContext().setAttribute("security", null);
                    config.getServletContext().setAttribute("dispatcher", null);

                    // initialize security
                    Security security = getSecurity();
                    // initialize the services dispatcher
                    LocalDispatcher dispatcher = getDispatcher(config.getServletContext());

                    // set web context objects
                    request.setAttribute("dispatcher", dispatcher);
                    request.setAttribute("security", security);

                    request.setAttribute("tenantId", tenantId);
                }

                // NOTE DEJ20101130: do NOT always put the delegator name in the user's session because the user may
                // have logged in and specified a tenant, and even if no Tenant record with a matching domainName field
                // is found this will change the user's delegator back to the base one instead of the one for the
                // tenant specified on login
                // httpRequest.getSession().setAttribute("delegatorName", delegator.getDelegatorName());
            } catch (GenericEntityException e) {
                Debug.logWarning(e, "Unable to get Tenant", module);
            }
        }

        // we're done checking; continue on
        chain.doFilter(httpRequest, httpResponse);
    }

    /**
     * Forward a uri according to forward pattern regular expressions. Note: this is developed for Filter usage.
     * 
     * @param uri String to reverse transform
     * @return String
     */
    protected static boolean forwardUri(HttpServletResponse response, String uri) {
        Perl5Matcher matcher = new Perl5Matcher();
        boolean foundMatch = false;
        Integer responseCodeInt = null;

        if (SeoConfigUtil.checkUseUrlRegexp() && SeoConfigUtil.getSeoPatterns() != null && SeoConfigUtil.getForwardReplacements() != null) {
            Iterator<String> keys = SeoConfigUtil.getSeoPatterns().keySet().iterator();
            while (keys.hasNext()) {
                String key = keys.next();
                Pattern pattern = SeoConfigUtil.getSeoPatterns().get(key);
                String replacement = SeoConfigUtil.getForwardReplacements().get(key);
                if (matcher.matches(uri, pattern)) {
                    for (int i = matcher.getMatch().groups(); i > 0; i--) {
                        replacement = replacement.replaceAll("\\$" + i, matcher.getMatch().group(i));
                    }
                    uri = replacement;
                    responseCodeInt = SeoConfigUtil.getForwardResponseCodes().get(key);
                    foundMatch = true;
                    // be careful, we don't break after finding a match
                }
            }
        }

        if (foundMatch) {
            if (responseCodeInt == null) {
                response.setStatus(SeoConfigUtil.DEFAULT_RESPONSECODE);
            } else {
                response.setStatus(responseCodeInt.intValue());
            }
            response.setHeader("Location", uri);
        } else {
            Debug.logInfo("Can NOT forward this url: " + uri, module);
        }
        return foundMatch;
    }
}
