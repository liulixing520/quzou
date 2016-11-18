/*
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
 */
import org.ofbiz.product.product.ProductContentWrapper;
import org.ofbiz.product.category.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import org.ofbiz.base.util.*;
import org.ofbiz.entity.util.EntityUtil;

index = parameters.index;
productCategoryId = parameters.category_id;
parentCategoryStr = parameters.parentCategoryStr;
preCatChilds = delegator.findByAnd("ProductCategoryRollup", ["parentProductCategoryId": productCategoryId], null, false);
catChilds = EntityUtil.getRelated("CurrentProductCategory", null, preCatChilds, false);
context.index = index.toInteger() + 1;
context.divId = "catagory" + context.index;
context.catChilds = catChilds;