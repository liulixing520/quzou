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
//import org.ofbiz.party.party.PartyWorker;

Calendar todayStart = Calendar.getInstance();  
todayStart.set(Calendar.HOUR, 0);  
todayStart.set(Calendar.MINUTE, 0);  
todayStart.set(Calendar.SECOND, 0);  
todayStart.set(Calendar.MILLISECOND, 0);
todayStart2=UtilDateTime.toTimestamp(todayStart.getTime());

//orderList1 = delegator.findList("OrderHeader", EntityCondition.makeCondition([invoiceId : invoiceId]), null, null, null, false);
orderList1 = delegator.findList("OrderHeader", EntityCondition.makeCondition("orderDate", EntityOperator.GREATER_THAN_EQUAL_TO, todayStart2), null,null,null, false);
orderList2 = delegator.findList("OrderHeader", EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_APPROVED"), null,null,null, false);
orderList3 = delegator.findList("OrderHeader", EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_CREATED"), null,null,null, false);
orderList4 = delegator.findList("OrderHeader", EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_COMPLETED"), null,null,null, false);
orderList5 = delegator.findList("OrderHeader", EntityCondition.makeCondition("statusId", EntityOperator.EQUALS, "ORDER_SENT"), null, null,null,false);

//context.orderHeaderList = orderHeaderList;
context.orderList1=orderList1.size();//当日订单
context.orderList2=orderList2.size();//待发货
context.orderList3=orderList3.size();//待付款
context.orderList4=orderList4.size();//已完成
context.orderList5=orderList5.size();//已发货

