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
package org.ofbiz.service.config;

import org.ofbiz.base.config.GenericConfigException;

/**
 * Service configuration exception. Thrown when there is a configuration error in the
 * <code>serviceengine.xml</code> file.
 */
@SuppressWarnings("serial")
public class ServiceConfigException extends GenericConfigException {

    public ServiceConfigException() {
        super();
    }

    public ServiceConfigException(String str) {
        super(str);
    }

    public ServiceConfigException(String str, Throwable nested) {
        super(str, nested);
    }
}

