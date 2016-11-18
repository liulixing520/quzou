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

<script type="text/javascript">
    var checkBoxNameStart = "view";
    var formName = "findorder";


    function setCheckboxes() {
        // This would be clearer with camelCase variable names
        var allCheckbox = document.forms[formName].elements[checkBoxNameStart + "all"];
        for(i = 0;i < document.forms[formName].elements.length;i++) {
            var elem = document.forms[formName].elements[i];
            if (elem.name.indexOf(checkBoxNameStart) == 0 && elem.name.indexOf("_") < 0 && elem.type == "checkbox") {
                elem.checked = allCheckbox.checked;
            }
        }
    }

</script>

<form id="pagerForm" method="post" action="FindOrder">
	<input type="hidden" name="status" >
	<input type="hidden" name="keywords"  />
	<input type="hidden" name="VIEW_INDEX_1" />
	<input type="hidden" name="VIEW_SIZE_1"  />
	<input type="hidden" name="sortField"  />
	<input type="hidden" name="sorterDirection"  />
</form>
<#-- order list -->
<div class="pageContent" >
	<div class="panelBar">
		<ul class="toolBar">
		<form action='FindOrder' id='FindOrder'  method="post" rel="pageForm">
			
			<li><select name=''><option value=''>账单号码</option><option>收货人</option></select></li>
			<li><input type='text' name='userLoginId' onblur="if(this.value=='') this.value='输入关键字'" onfocus="if(this.value=='输入关键字') this.value=''" value="输入关键字" ></li>
			<li><a class="icon" href="#"  onclick="javascript:submitForm('FindMember');" ><span>搜索</span></a></li>
			<li><a class="icon" href="<@ofbizUrl>FindMemberAdvanced</@ofbizUrl>" target="dialog" mask="true" title="查询框"><span>高级检索</span></a></li>
		</form>	
			</ul>
	</div>
       <table class="table" width="100%" layoutH="78">
          <thead>
            <td width="10%">操作</td>
            <td width="10%">订单号</td>
            <td width="15%">下单时间</td>
            <td width="10%">交易成功时间</td>
            <td width="10%">收货人</td>
            <td width="10%">订单金额</td>
            <td width="10%">支付方式</td>
            <td width="10%">订单状态</td>
            <td width="10%">支付状态</td>
       		<td  width="15%">打印</td>
            
          </tr>
          </thead>
          <tbody>
          <#list orderHeaderList as orderHeader>
            <#assign status = orderHeader.getRelatedOneCache("StatusItem")>
            <#assign orh = Static["org.ofbiz.order.order.OrderReadHelper"].getHelper(orderHeader)>
            <#assign billToParty = orh.getBillToParty()?if_exists>
            <#assign billFromParty = orh.getBillFromParty()?if_exists>
            <#if billToParty?has_content>
                <#assign billToPartyNameResult = dispatcher.runSync("getPartyNameForDate", Static["org.ofbiz.base.util.UtilMisc"].toMap("partyId", billToParty.partyId, "compareDate", orderHeader.orderDate, "userLogin", userLogin))/>
                <#assign billTo = billToPartyNameResult.fullName?default("[${uiLabelMap.OrderPartyNameNotFound}]")/>
                <#-- <#assign billTo = Static["org.ofbiz.party.party.PartyHelper"].getPartyName(billToParty, true)?if_exists> -->
            <#else>
              <#assign billTo = ''/>
            </#if>
            <#if billFromParty?has_content>
              <#assign billFrom = Static["org.ofbiz.party.party.PartyHelper"].getPartyName(billFromParty, true)?if_exists>
            <#else>
              <#assign billFrom = ''/>
            </#if>
            <#assign productStore = orderHeader.getRelatedOneCache("ProductStore")?if_exists />
            <tr>
              <td>
              <a href="<@ofbizUrl>OrderDetail?orderId=${orderHeader.orderId}</@ofbizUrl>"  class="button" ><span>详情</span></a>
              </td>
              <td>
                <a href="<@ofbizUrl>orderview?orderId=${orderHeader.orderId}</@ofbizUrl>" class="buttontext">${orderHeader.orderId}</a>
              </td>
              <td>${orderHeader.orderDate.toString()}</td>
              	<!--
              <td>${orderHeader.getRelatedOneCache("OrderType").get("description",locale)}</td>
              <td>${billFrom?if_exists}</td>-->
              <td></td>
              <td>
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
              
              
              <td><@ofbizCurrency amount=orderHeader.grandTotal isoCode=orderHeader.currencyUom/></td>
              <td>
				<#assign orderPaymentPreferences = delegator.findByAnd("OrderPaymentPreference",Static["org.ofbiz.base.util.UtilMisc"].toMap("orderId",orderHeader.orderId))>
					<#list orderPaymentPreferences as orderPaymentPreference>
						<#assign paymentMethod = orderPaymentPreference.getRelatedOne("PaymentMethod")?if_exists>
						<#assign paymentMethodType = orderPaymentPreference.getRelatedOne("PaymentMethodType")>
						<#if paymentMethodType.paymentMethodTypeId == "EXT_COD">
						货到付款
						</#if>
					</#list>
				</td>
              <td>${orderHeader.getRelatedOneCache("StatusItem").get("description",locale)}</td>
              <td>
                <#assign trackingCodes = orderHeader.getRelated("TrackingCodeOrder")>
                <#list trackingCodes as trackingCode>
                    <#if trackingCode?has_content>
                        <a href="/marketing/control/FindTrackingCodeOrders?trackingCodeId=${trackingCode.trackingCodeId}&amp;externalLoginKey=${requestAttributes.externalLoginKey?if_exists}">${trackingCode.trackingCodeId}</a><br />
                    </#if>
                </#list>
              </td>
             
              <#if state.hasFilter('filterInventoryProblems') || state.hasFilter('filterAuthProblems') || state.hasFilter('filterPOsOpenPastTheirETA') || state.hasFilter('filterPOsWithRejectedItems') || state.hasFilter('filterPartiallyReceivedPOs')>
              <td>
                  <#if filterInventoryProblems.contains(orderHeader.orderId)>
                    Inv&nbsp;
                  </#if>
                  <#if filterAuthProblems.contains(orderHeader.orderId)>
                   Aut&nbsp;
                  </#if>
                  <#if filterPOsOpenPastTheirETA.contains(orderHeader.orderId)>
                    ETA&nbsp;
                  </#if>
                  <#if filterPOsWithRejectedItems.contains(orderHeader.orderId)>
                    Rej&nbsp;
                  </#if>
                  <#if filterPartiallyReceivedPOs.contains(orderHeader.orderId)>
                    Part&nbsp;
                  </#if>
              </td>
              <#else>
              
              </#if>
               
              <td>打印</td>
            </tr>
          </#list>
          <#if !orderHeaderList?has_content>
            <tr><td colspan="9"><h3>${uiLabelMap.OrderNoOrderFound}</h3></td></tr>
          </#if>
          </tbody>
        </table>

<div class="panelBar">
	<div class="pages">
			<span>显示</span>
			<select class="combox" name="VIEW_SIZE_1" onchange="navTabPageBreak({VIEW_SIZE_1:this.value})">
				<option value="20">20</option>
				<option value="50">50</option>
				<option value="100">100</option>
				<option value="200">200</option>
			</select>
			<span>${paginateViewSizeLabel!}&nbsp;&nbsp;共${state.getSize()!0}条</span>
		
			</div>
		<#if state.getSize() gt state.viewSize>
		<div class="pagination" targetType="navTab" totalCount="${state.getSize()!}" VIEW_SIZE_1="${viewSize!}" pageNumShown="3" currentPage="${(viewIndex+1)!}"></div>
		</#if>	
</div>
