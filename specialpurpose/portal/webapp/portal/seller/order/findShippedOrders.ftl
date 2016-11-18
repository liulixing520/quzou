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

<script language='javascript'>
function subSearch(formName){
	var  searchType=document.getElementById('searchSHPType').value;
	if(searchType!=null&&searchType.length>0){
		if(searchType=='orderId'){
			document.getElementById('orderIdSHP').value=document.getElementById('searchSHPContent').value;
		}else if(searchType=='userLoginId'){
			document.getElementById('userLoginIdSHP').value=document.getElementById('searchSHPContent').value;
		}
		
	}
	submitForm(formName);
}
</script>


<#-- order list -->
<div id='pageContent'  class="pageContent" >
	<div class="panelBar">
		<ul class="toolBar">
		<form action='FindShippedOrder' id='FindShippedOrder' name='FindShippedOrder' method="post" rel="pagerForm">
			  <input type="hidden" name="hideFields" id="hideFields"  value="Y"/>
			  
			  <input type='hidden' name='correspondingPoId' value='${requestParameters.correspondingPoId?if_exists}'/>
			  <input type='hidden' name='internalCode' value='${requestParameters.internalCode?if_exists}'/>
			  <input type='hidden' name='productId' value='${requestParameters.productId?if_exists}'/>
			  <input type='hidden' name='inventoryItemId' value='${requestParameters.inventoryItemId?if_exists}'/>
			  <input type='hidden' name='serialNumber' value='${requestParameters.serialNumber?if_exists}'/>
			  <input type='hidden' name='softIdentifier' value='${requestParameters.softIdentifier?if_exists}'/>
			  <input type='hidden' name='partyId'  id='partyId' value='${requestParameters.partyId?if_exists}'/>
			  <input type='hidden' name='orderId'  id='orderIdSHP' />
			  <input type='hidden' name='userLoginId' id='userLoginIdSHP' value='${requestParameters.userLoginId?if_exists}'/>
			  <input type='hidden' name='billingAccountId' value='${requestParameters.billingAccountId?if_exists}'/>
			  <input type='hidden' name='createdBy' value='${requestParameters.createdBy?if_exists}'/>
			  <input type='hidden' name='minDate' value='${requestParameters.minDate?if_exists}'/>
			  <input type='hidden' name='maxDate' value='${requestParameters.maxDate?if_exists}'/>
			  <input type='hidden' name='roleTypeId' value="${requestParameters.roleTypeId?if_exists}"/>
			  <input type='hidden' name='orderTypeId' value='${requestParameters.orderTypeId?if_exists}'/>
			  <input type='hidden' name='salesChannelEnumId' value='${requestParameters.salesChannelEnumId?if_exists}'/>
			  <input type='hidden' name='productStoreId' value='${requestParameters.productStoreId?if_exists}'/>
			  <input type='hidden' name='orderWebSiteId' value='${requestParameters.orderWebSiteId?if_exists}'/>
			  <input type='hidden' name='orderStatusId' value='ORDER_COMPLETED'/>
			  <input type='hidden' name='hasBackOrders' value='${requestParameters.hasBackOrders?if_exists}'/>
			  <input type='hidden' name='filterInventoryProblems' value='${requestParameters.filterInventoryProblems?if_exists}'/>
			  <input type='hidden' name='filterPartiallyReceivedPOs' value='${requestParameters.filterPartiallyReceivedPOs?if_exists}'/>
			  <input type='hidden' name='filterPOsOpenPastTheirETA' value='${requestParameters.filterPOsOpenPastTheirETA?if_exists}'/>
			  <input type='hidden' name='filterPOsWithRejectedItems' value='${requestParameters.filterPOsWithRejectedItems?if_exists}'/>
			  <input type='hidden' name='countryGeoId' value='${requestParameters.countryGeoId?if_exists}'/>
			  
			  <input type='hidden' name='stateGeoId' value='${requestParameters.stateGeoId?if_exists}'/>
			  <input type='hidden' name='cityGeoId' value='${requestParameters.cityGeoId?if_exists}'/>
			  <input type='hidden' name='countyGeoId' value='${requestParameters.countyGeoId?if_exists}'/>
			  <input type='hidden' name='shipmentStatusId' value='SHIPMENT_SHIPPED'/>
			  
			  <input type='hidden' name='includeCountry' value='${requestParameters.includeCountry?if_exists}'/>
			  <input type='hidden' name='isViewed' value='${requestParameters.isViewed?if_exists}'/>
			  <input type='hidden' name='shipmentMethod' value='${requestParameters.shipmentMethod?if_exists}'/>
			  <input type='hidden' name='gatewayAvsResult' value='${requestParameters.gatewayAvsResult?if_exists}'/>
			  <input type='hidden' name='gatewayScoreResult' value='${requestParameters.gatewayScoreResult?if_exists}'/>
			  <input type='hidden' name='showAll' id='showAll' value="Y"/>
			  <input type='hidden' name='aotuSearch' id='aotuSearch' value="Y"/>
			  <input type="hidden" name="lookupFlag" value="Y"/>
			<li><select name='searchType' id='searchSHPType'><option value='orderId'>订单号</option><option value='userLoginId'>下单人</option></select></li>
			<li><input type='text' name='searchContent' id='searchSHPContent' onblur="if(this.value=='') this.value=''" onfocus="if(this.value=='') this.value=''" value="" ></li>
			<li><a class="search" href="#"  onclick="javascript:subSearch('FindShippedOrder');" ><span>搜索</span></a></li>
			<li><a class="search" href="<@ofbizUrl>FindShippedOrderAdvanced</@ofbizUrl>" target="dialog" mask="true" title="查询框"><span>高级检索</span></a></li>
		</form>	
			</ul>
	</div>
       <table class="table" width="100%" layoutH="78">
          <thead>
            <td width="5%">操作</td>
            <td width="10%"><input type="checkBox" class="checkboxCtrl" group="orderIndexs">订单号</td>
            <td width="13%" >
            	下单时间
            </td>
            <!-- <td width="13%">交易成功时间</td> -->
            <td width="10%">下单人</td>
            <td width="10%">收货人</td>
            <td width="10%">订单金额</td>
            <td width="10%">支付方式</td>
            <td width="10%">订单状态</td>
            <td width="8%">支付状态</td>
            <td width="8%">货运状态</td>
       		<td  width="8%">打印</td>
            
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
                 
              	 <a href="<@ofbizUrl>OrderDetail?orderId=${orderHeader.orderId}</@ofbizUrl>"  rel="OrderDetail">详情</a>
              </td>

              <td>
              <input type="checkbox" name="orderIndexs"  value="${orderHeader.orderId}" />
              ${orderHeader.orderId}</td>
              <td >${orderHeader.getString("orderDate")} </td>
              <td ><#assign userId =Static["org.ofbiz.iteamgr.order.OrderServices"].getOrderUserLoginIdFromParty(delegator, orderHeader.orderId,'PLACING_CUSTOMER')>
              ${userId!} </td>
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
			  <td><#if orderHeader.paymentStatus?has_content>
			  <#if orderHeader.paymentStatus == "1">未支付
			  <#elseif orderHeader.paymentStatus == "2">部分支付
			  <#elseif orderHeader.paymentStatus == "3" || orderHeader.paymentStatus == "5">已支付
			  <#elseif orderHeader.paymentStatus == "4">已退款
			  </#if>
			  </#if>
			  </td>
			  <td><#assign shipmentStatus =Static["org.ofbiz.iteamgr.order.OrderServices"].getOrderShipmentStateCn(delegator, orderHeader.orderId)>
			  ${shipmentStatus!}
			  </td>
              <td><a href="<@ofbizUrl>printShipment?orderId=${orderHeader.orderId}</@ofbizUrl>" target="_blank"  >快递单</a></td>
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
    <!--dwz  分页 -->      
	<@dwzPagin orderList![] orderListSize!0 VIEW_SIZE_1!20 VIEW_INDEX_1!0  "FindShippedOrder" "navTab"/>
</div>