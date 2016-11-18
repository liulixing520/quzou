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

import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.entity.util.*;
import org.ofbiz.entity.condition.*;
import java.util.Locale;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.entity.condition.EntityExpr;
import javolution.util.FastList;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.base.util.UtilMisc;

Locale locale = UtilHttp.getLocale(request);
//Locale locale = new Locale("zh_CN");
TimeZone tz = TimeZone.getTimeZone("GMT+8");
statusId = parameters.statusId?:null;
startTimeStr = parameters.startOrderDate?:null;
endTimeStr = parameters.endOrderDate?:null;
orderId=parameters.orderId?:null
statusId2 = parameters.statusId2?:null;
page = parameters.page?:0;
//page=parameters.page;
if(orderId && statusId2){
	dispatcher.runSync("changeOrderStatus",[orderId:orderId,statusId:statusId2])
	/*
	order = delegator.findOne("OrderHeader", ["orderId" : orderId], false);
	order.put("statusId",statusId2);
	int update=delegator.store(order);*/
}
List<EntityExpr> exprs = FastList.newInstance();
List<String> ids = FastList.newInstance();
if(startTimeStr){
	startTime = UtilDateTime.stringToTimeStamp(startTimeStr,"yyyy-MM-dd HH:mm:ss",tz, locale);	
	exprs.add(EntityCondition.makeCondition("orderDate", EntityOperator.GREATER_THAN_EQUAL_TO, startTime));
	context.startTime=startTime;
}
if(endTimeStr){
	endTime = UtilDateTime.stringToTimeStamp(endTimeStr,"yyyy-MM-dd HH:mm:ss",tz, locale);
	exprs.add(EntityCondition.makeCondition("orderDate", EntityOperator.LESS_THAN_EQUAL_TO, endTime));
	context.endTime=endTime;
}
if(statusId){
	exprs.add(EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, statusId));
	context.statusId=statusId;
}
partyRole = delegator.findOne("PartyRole", [partyId : userLogin.partyId, roleTypeId : "SUPPLIER"], false);
if (partyRole) {
    if ("SUPPLIER".equals(partyRole.roleTypeId)) {
        /** drop shipper or supplier **/
        porderRoleCollection = delegator.findByAnd("OrderRole", [partyId : userLogin.partyId, roleTypeId : "SUPPLIER_AGENT"], null, false);
        porderHeaderList = EntityUtil.orderBy(EntityUtil.filterByAnd(EntityUtil.getRelated("OrderHeader", null, porderRoleCollection, false),
                [EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "ORDER_REJECTED"),
                 EntityCondition.makeCondition("orderTypeId", EntityOperator.EQUALS, "PURCHASE_ORDER")]),
                 ["orderDate DESC"]);
        context.porderHeaderList = porderHeaderList;
    }
}
orderRoleCollection = delegator.findByAnd("OrderRole", [partyId : userLogin.partyId, roleTypeId : "PLACING_CUSTOMER"], null, false);
if(orderRoleCollection){
	orderRoleCollection.each{it ->
		ids.add(it.orderId);
	}
}
if(ids.size()>0){
	exprs.add(EntityCondition.makeCondition("orderId", EntityOperator.IN, ids));
}else{
	exprs.add(EntityCondition.makeCondition("orderId", EntityOperator.IN, ["nosuchorder"]));
}
dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
Map<String,Object> inputContext = UtilMisc.toMap("entityName", "OrderHeader");
inputContext.put("viewSize",10);
inputContext.put("viewIndex",page.toInteger());
inputContext.put("mainCond",EntityCondition.makeCondition(exprs, EntityOperator.AND));
returnResult=dispatcher.runSync("findPortalList", inputContext);
context.orderHeaderList=returnResult.list;
context.listSize=returnResult.listSize;
context.viewIndex=page;
context.viewSize=10;
/*orderHeaderList = EntityUtil.orderBy(EntityUtil.filterByAnd(EntityUtil.getRelated("OrderHeader", null, orderRoleCollection, false),
        [EntityCondition.makeCondition(exprs, EntityOperator.AND)]), ["orderDate DESC"]);
context.orderHeaderList = orderHeaderList;*/

downloadOrderRoleAndProductContentInfoList = delegator.findByAnd("OrderRoleAndProductContentInfo",
    [partyId : userLogin.partyId, roleTypeId : "PLACING_CUSTOMER", productContentTypeId : "DIGITAL_DOWNLOAD", statusId : "ITEM_COMPLETED"], null, false);
context.downloadOrderRoleAndProductContentInfoList = downloadOrderRoleAndProductContentInfoList;
