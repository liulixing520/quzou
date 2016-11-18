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

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.ofbiz.base.util.Debug;

/**
 * OFBiz Solr info/helper servlet.
 */
@SuppressWarnings("serial")
public class OfbizSolrInfoServlet extends HttpServlet {

    public static final String module = OfbizSolrInfoServlet.class.getName();
    
    /**
     * Used to deduce whether the solr webapp initialization step was reached
     * during OFBiz initialization.
     */
    private static volatile boolean servletInitStatusReached = false;
    
    public OfbizSolrInfoServlet() {
        super();
    }
    
    /**
     * @see javax.servlet.Servlet#init(javax.servlet.ServletConfig)
     */
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        boolean firstInit = setServletInitStatusReached();
        if (!firstInit) {
            Debug.logInfo("OfbizSolrInfoServlet: (Non-first) servlet init executed", module);
        }
    }
    
    private static boolean setServletInitStatusReached() {
        if (!isServletInitStatusReached()) {
            Debug.logInfo("OfbizSolrInfoServlet: First servlet init executed", module);
            servletInitStatusReached = true;
            return true;
        }
        else {
            return false;
        }
    }
    
    /**
     * Checks if the init method was called for any instance of this servlet.
     * <p>
     * This can be used as a workaround to detect the approximate point at which the webapp was loaded.
     */
    public static boolean isServletInitStatusReached() {
        return servletInitStatusReached;
    }
    
}
