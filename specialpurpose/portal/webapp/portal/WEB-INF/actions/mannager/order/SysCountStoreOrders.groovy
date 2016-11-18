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

//productStoreId = context.productStoreId;
Calendar todayStart = Calendar.getInstance();  
todayStart.set(Calendar.HOUR, 0);  
todayStart.set(Calendar.MINUTE, 0);  
todayStart.set(Calendar.SECOND, 0);  
todayStart.set(Calendar.MILLISECOND, 0);
todayStart2=UtilDateTime.toTimestamp(todayStart.getTime());
minDate = todayStart2.toString();
Calendar todayStart3 = Calendar.getInstance();  
todayStart3.set(Calendar.HOUR, 23);  
todayStart3.set(Calendar.MINUTE, 59);  
todayStart3.set(Calendar.SECOND, 59);  
todayStart3.set(Calendar.MILLISECOND, 0);
todayStart4=UtilDateTime.toTimestamp(todayStart3.getTime());
maxDate = todayStart4.toString();
//println(minDate+"=minDate  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
//println(maxDate+"=maxDate  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
// set the page parameters
viewIndex = request.getParameter("viewIndex") ? Integer.valueOf(request.getParameter("viewIndex")) : 1;
context.viewIndex = viewIndex;

viewSize =10000;// request.getParameter("viewSize") ? Integer.valueOf(request.getParameter("viewSize")) : 
                                                                UtilProperties.getPropertyAsInteger("widget", "widget.form.defaultViewSize",1000);
context.viewSize = viewSize;

contextInput = [userLogin : userLogin,viewIndex : viewIndex,viewSize : viewSize];

contextInput.minDate = minDate;//开始时间
contextInput.maxDate = maxDate;//结束时间
resultOutput = dispatcher.runSync("findOrders", contextInput);	
context.orderList1=resultOutput.orderList.size();//当日订单
//之后的没有时间限制
contextInput.minDate = null;//开始时间
contextInput.maxDate = null;//结束时间
contextInput.orderStatusId = UtilMisc.toList("ORDER_APPROVED");
resultOutput = dispatcher.runSync("findOrders", contextInput);	
context.orderList2=resultOutput.orderList.size();//待发货

contextInput.orderStatusId = UtilMisc.toList("ORDER_CREATED");
resultOutput = dispatcher.runSync("findOrders", contextInput);	
context.orderList3=resultOutput.orderList.size();//待付款

contextInput.orderStatusId = UtilMisc.toList("ORDER_COMPLETED");
resultOutput = dispatcher.runSync("findOrders", contextInput);	
context.orderList4=resultOutput.orderList.size();//已完成

contextInput.orderStatusId = UtilMisc.toList("ORDER_SENT");
resultOutput = dispatcher.runSync("findOrders", contextInput);	
context.orderList5=resultOutput.orderList.size();//已发货


/* orderStatusId = request.getParameter("orderStatusId")
 if(orderStatusId){
	contextInput.orderStatusId = UtilMisc.toList(orderStatusId);
	context.orderStatusId=orderStatusId;
}
resultOutput = dispatcher.runSync("findOrders", contextInput);

orderList = resultOutput.orderList;
context.orderList = orderList;

orderListSize = resultOutput.orderListSize;
context.orderListSize = orderListSize;*/

lowIndex = resultOutput.lowIndex;
context.lowIndex = lowIndex;

highIndex = resultOutput.highIndex;
context.highIndex = highIndex;
//查询上一次登录时间
loginHistory = delegator.findByAnd("UserLoginHistory", UtilMisc.toMap("partyId", userLogin.partyId), UtilMisc.toList("-fromDate"), false);
v = loginHistory[1];
if(v != null){
    lastLoginTime=v.getTimestamp("fromDate");
    context.lastLoginTime=lastLoginTime;
}
