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

import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityFunction;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.condition.EntityFieldValue;
import org.ofbiz.entity.condition.EntityConditionList;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.util.EntityUtil;

productId = request.getParameter("productId") ?: "";
productName = request.getParameter("productName") ?: "";

conditionList = [];
orConditionList = [];
mainConditionList = [];

if (productId) {
    //make sure the look up is case insensitive
    conditionList.add(EntityCondition.makeCondition(EntityFunction.UPPER(EntityFieldValue.makeFieldValue("productId")),
            EntityOperator.LIKE, productId.toUpperCase() + "%"));
}

if (productName) {
    //make sure the look up is case insensitive
    conditionList.add(EntityCondition.makeCondition(EntityFunction.UPPER(EntityFieldValue.makeFieldValue("productName")),
            EntityOperator.LIKE, "%"+productName.toUpperCase() + "%"));
}
// do not include configurable products
conditionList.add(EntityCondition.makeCondition("productTypeId", EntityOperator.NOT_EQUAL, "AGGREGATED"));
//added by dongyc 20120904
conditionList.add(EntityCondition.makeCondition("productPriceTypeId", EntityOperator.EQUALS, "DEFAULT_PRICE"));

// no virtual products: note that isVirtual could be null,
// we consider those products to be non-virtual and hence addable to the order in bulk
orConditionList.add(EntityCondition.makeCondition("isVirtual", EntityOperator.EQUALS, "N"));
orConditionList.add(EntityCondition.makeCondition("isVirtual", EntityOperator.EQUALS, null));

orConditions = EntityCondition.makeCondition(orConditionList, EntityOperator.OR);
conditions = EntityCondition.makeCondition(conditionList, EntityOperator.AND);

mainConditionList.add(orConditions);
mainConditionList.add(conditions);
mainConditions = EntityCondition.makeCondition(mainConditionList, EntityOperator.AND);
//updated by dongyc 20120904 选货框，货物id唯一
context.productList = EntityUtil.filterByDate(delegator.findList("ProductAndPriceView", mainConditions, null as Set, ["productId"], null, false));
