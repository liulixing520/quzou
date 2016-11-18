<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->
<#include "component://itea/webapp/iteamgr/ftl/dwz_pagination.ftl"/>




<#-- order list -->
<div id='pageContent'  class="pageContent" >
	
       <table class="table" width="100%" layoutH="78">
          <thead>
            
            <td width="10%">订单号</td>
            <td width="10%">下单时间</td>
            <td width="10%">收货人</td>
            <td width="10%">订单金额</td>
            <td width="10%">支付方式</td>
            <td width="10%">订单状态</td>
            <td width="10%">支付状态</td>
            <td width="10%">货运状态</td>
          </tr>
          </thead>
          <tbody>
           <#if orderList?has_content>
          <#assign alt_row = false>
          <#list orderList as orderHeader>
            <#assign orh = Static["org.ofbiz.order.order.OrderReadHelper"].getHelper(orderHeader)>
            <#assign statusItem = orderHeader.getRelatedOneCache("StatusItem")>
            <#assign orderType = orderHeader.getRelatedOneCache("OrderType")>
            <#if orderType.orderTypeId == "PURCHASE_ORDER">
              <#assign displayParty = orh.getSupplierAgent()?if_exists>
            <#else>
              <#assign displayParty = orh.getPlacingParty()?if_exists>
            </#if>
            <#assign partyId = displayParty.partyId?default("_NA_")>
            <tr valign="middle"<#if alt_row> class="alternate-row"</#if>>
              <td>
                 
              	 <a href="<@ofbizUrl>OrderDetail?orderId=${orderHeader.orderId}</@ofbizUrl>"   >详情</a>
              </td>

              <td >${orderHeader.getString("orderDate")} </td>
              <!-- <td>${orderHeader.getString("orderDate")} </td>-->
              <td >
                <#assign orderContactMechValueMaps = Static["org.ofbiz.party.contact.ContactMechWorker"].getOrderContactMechValueMaps(delegator, orderHeader.orderId)>
					<#list orderContactMechValueMaps as orderContactMechValueMap>
          				<#assign contactMech = orderContactMechValueMap.contactMech>
          				<#assign contactMechPurpose = orderContactMechValueMap.contactMechPurposeType>
          				<#if contactMech.contactMechTypeId == "POSTAL_ADDRESS">
                			<#assign postalAddress = orderContactMechValueMap.postalAddress>
                			<#if postalAddress?has_content>
                			${(postalAddress.toName)?if_exists}
                			</#if>
                		</#if>
                	</#list>		
              </td>
              <td ><@ofbizCurrency amount=orderHeader.grandTotal isoCode=orh.getCurrency()/></td>
              
              <td ><#assign payType =Static["org.ofbiz.iteamgr.order.OrderServices"].getOrderPayTypeCn(delegator, orderHeader.orderId)>
              ${payType!}</td>
              
              
              <td>${statusItem.get("description",locale)?default(statusItem.statusId?default("N/A"))}</td>
              </td>
			  <td><#assign status =Static["org.ofbiz.iteamgr.order.OrderServices"].getOrderPayStatusCn(delegator, orderHeader.orderId)>
			  ${status!}
			  </td>
			  <td><#assign shipmentStatus =Static["org.ofbiz.iteamgr.order.OrderServices"].getOrderShipmentStateCn(delegator, orderHeader.orderId)>
			  ${shipmentStatus!}
			  </td>
              
            </tr>
            <#-- toggle the row color -->
            <#assign alt_row = !alt_row>
          </#list>
        <#else>
          
        </#if>
        <#if lookupErrorMessage?exists>
          <tr>
            <td colspan='4'><h3>${lookupErrorMessage}</h3></td>
          </tr>
        </#if>
          </tbody>
        </table>
    
</div>

<!--dwz  分页 -->     
 <!-- 
	<div class="panelBar">
		<#assign highIndex = (VIEW_INDEX_1 + 1) * VIEW_SIZE_1>
		<#if highIndex &gt; orderListSize>
			<#assign highIndex = orderListSize>
		</#if>
		<#if (orderListSize >= highIndex)>
		<div class="pages">
			<span>显示</span>
			<select class="combox" name="VIEW_SIZE_1" onchange="navTabPageBreak({VIEW_SIZE_1:this.value})">
				<option value="20">20</option>
				<option value="50">50</option>
				<option value="100">100</option>
				<option value="200">200</option>
			</select>
			<span>${paginateViewSizeLabel!}&nbsp;&nbsp;共${orderListSize!0}条</span>
			</div>
		<div  rel="jbsxBox" class="pagination" targetType="navTab" totalCount="${orderListSize!}" VIEW_SIZE_1="${VIEW_SIZE_1!}" pageNumShown="3" currentPage="${(VIEW_INDEX_1+1)!}"></div>
	</#if>	
</div>
-->
