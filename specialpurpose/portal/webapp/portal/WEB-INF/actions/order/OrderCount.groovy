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
import org.ofbiz.party.party.PartyWorker;

Calendar todayStart = Calendar.getInstance();  
todayStart.set(Calendar.HOUR, 0);  
todayStart.set(Calendar.MINUTE, 0);  
todayStart.set(Calendar.SECOND, 0);  
todayStart.set(Calendar.MILLISECOND, 0);
todayStart2=UtilDateTime.toTimestamp(todayStart.getTime());
//todayStart2=todayStart.getTime().getTime();
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
orderRoleCollection = delegator.findByAnd("OrderRole", [partyId : userLogin.partyId, roleTypeId : "PLACING_CUSTOMER"], ["createdStamp"], false);
orderList1 = EntityUtil.filterByAnd(EntityUtil.getRelated("OrderHeader", null, orderRoleCollection, false),[EntityCondition.makeCondition("orderDate", EntityOperator.GREATER_THAN_EQUAL_TO, todayStart2)]);//当日订单
orderList2 = EntityUtil.filterByAnd(EntityUtil.getRelated("OrderHeader", null, orderRoleCollection, false),[EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_APPROVED")]);//待发货
orderList3 = EntityUtil.filterByAnd(EntityUtil.getRelated("OrderHeader", null, orderRoleCollection, false),[EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_CREATED")]);//待付款
orderList4 = EntityUtil.filterByAnd(EntityUtil.getRelated("OrderHeader", null, orderRoleCollection, false),[EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_COMPLETED")]);//已完成
orderList5 = EntityUtil.filterByAnd(EntityUtil.getRelated("OrderHeader", null, orderRoleCollection, false),[EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_SENT")]);//已发货
//context.orderHeaderList = orderHeaderList;
context.orderList1=orderList1.size();//当日订单数量
context.orderList2=orderList2.size();//待发货数量
context.orderList3=orderList3.size();//待付款数量
context.orderList4=orderList4.size();//已完成数量
context.orderList5=orderList5.size();//已发货数量
context.orderInfoList1=orderList1;//当日订单
context.orderInfoList2=orderList2;//待发货
context.orderInfoList3=orderList3;//待付款
context.orderInfoList4=orderList4;//已完成
context.orderInfoList5=orderList5;//已发货
context.allOrderInfoList=EntityUtil.getRelated("OrderHeader", null, orderRoleCollection, false);//所有订单

downloadOrderRoleAndProductContentInfoList = delegator.findByAnd("OrderRoleAndProductContentInfo",
    [partyId : userLogin.partyId, roleTypeId : "PLACING_CUSTOMER", productContentTypeId : "DIGITAL_DOWNLOAD", statusId : "ITEM_COMPLETED"], null, false);
context.downloadOrderRoleAndProductContentInfoList = downloadOrderRoleAndProductContentInfoList;

/*loginHistory = delegator.findByAnd("UserLoginHistory", UtilMisc.toMap("partyId", partyId), UtilMisc.toList("-fromDate"), false);
v = EntityUtil.getFirst(loginHistory);
if (v != null) {
  v.getTimestamp("fromDate");
} else {
  
}*/
/*v=PartyWorker.findPartyLastLoginTime(userLogin.partyId,delegator);
lastLoginTime=v.toString();*/
loginHistory = delegator.findByAnd("UserLoginHistory", UtilMisc.toMap("partyId", userLogin.partyId), UtilMisc.toList("-fromDate"), false);
v = loginHistory[1];
if(v != null){
    lastLoginTime=v.getTimestamp("fromDate");
    context.lastLoginTime=lastLoginTime;
}
