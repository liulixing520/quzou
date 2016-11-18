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

import java.math.BigDecimal;
import java.util.*;
import java.sql.Timestamp;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.*;
import org.ofbiz.base.util.*;
import org.ofbiz.base.util.collections.*;
import org.ofbiz.order.order.*;
import org.ofbiz.party.contact.*;
import org.ofbiz.product.inventory.InventoryWorker;
import org.ofbiz.product.catalog.CatalogWorker;
import org.ofbiz.accounting.payment.*;
import org.ofbiz.entity.condition.EntityConditionList;
import org.ofbiz.entity.condition.EntityExpr;
import javolution.util.FastMap;

//获取发票抬头、发票内容等属性信息
orderId = parameters.orderId;
invoiceTitle="";
invoiceText="";
noteInfo="";
invoiceTextId="";
shippmentDateType="";
shippmentDateTypeId="";
attrList = delegator.findByAnd("OrderAttribute", [orderId : orderId]);
attrList.each { attr ->
attrName = attr.attrName;
	if(attrName.equals("invoiceItemType")){
		gc=delegator.findByPrimaryKey("Enumeration", [enumId : attr.attrValue]);
		if(gc){
			invoiceText=gc.description;
			invoiceTextId=gc.enumId;
		}
	}else if(attrName.equals("shipDateEnumId")){
		gc=delegator.findByPrimaryKey("Enumeration", [enumId : attr.attrValue]);
		if(gc){
			shippmentDateType=gc.description;
			shippmentDateTypeId=gc.enumId;
		}
	}else if(attrName.equals("invoiceTitle")){
		invoiceTitle=attr.attrValue;
	}
	else if(attrName.equals("noteInfo")){
		noteInfo=attr.attrValue;
	}
}

context.noteInfo=noteInfo;
context.invoiceTitle=invoiceTitle;
context.invoiceText=invoiceText;
context.invoiceTextId=invoiceTextId;
context.shippmentDateType=shippmentDateType;
context.shippmentDateTypeId=shippmentDateTypeId;

