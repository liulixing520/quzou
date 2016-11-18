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

import java.util.*;
import java.sql.Timestamp;
import org.ofbiz.entity.*;
import org.ofbiz.base.util.*;
import org.ofbiz.entity.util.*;

module = "FindOrders.groovy";



productStoreId = context.productStoreId;

minDate = request.getParameter("minDate");
maxDate = request.getParameter("maxDate");

// set the page parameters
viewIndex = request.getParameter("viewIndex") ? Integer.valueOf(request.getParameter("viewIndex")) : 1;
context.viewIndex = viewIndex;

viewSize = request.getParameter("viewSize") ? Integer.valueOf(request.getParameter("viewSize")) : 
                                                                UtilProperties.getPropertyAsInteger("widget", "widget.form.defaultViewSize",20);
context.viewSize = viewSize;

contextInput = [productStoreId : UtilMisc.toList(productStoreId), userLogin : userLogin,viewIndex : viewIndex,viewSize : viewSize];
if(minDate){
	contextInput.minDate = minDate;
	context.minDate=minDate;
}
if(maxDate){
	contextInput.maxDate = maxDate;
	context.maxDate=maxDate;
}
orderStatusId = request.getParameter("orderStatusId")
if(orderStatusId){
	contextInput.orderStatusId = UtilMisc.toList(orderStatusId);
	context.orderStatusId=orderStatusId;
}
resultOutput = dispatcher.runSync("findOrders", contextInput);

orderList = resultOutput.orderList;
context.orderList = orderList;

orderListSize = resultOutput.orderListSize;
context.orderListSize = orderListSize;

Debug.log("${productStoreId}-orderListSize: ${orderListSize}",module);

lowIndex = resultOutput.lowIndex;
context.lowIndex = lowIndex;

highIndex = resultOutput.highIndex;
context.highIndex = highIndex;
