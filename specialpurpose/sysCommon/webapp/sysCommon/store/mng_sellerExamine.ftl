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
<#assign extInfo = parameters.extInfo?default("N")>
<#assign inventoryItemId = parameters.inventoryItemId?default("")>
<#assign serialNumber = parameters.serialNumber?default("")>
<#assign softIdentifier = parameters.softIdentifier?default("")>
<#assign sortField = parameters.sortField?if_exists/>
<#-- Only allow the search fields to be hidden when we have some results -->
<#if partyList?has_content>
  <#assign hideFields = parameters.hideFields?default("N")>
<#else>
  <#assign hideFields = "N">
</#if>
<#-- 
<h1>店铺申请审核</h1>
-->
<#if (parameters.firstName?has_content || parameters.lastName?has_content)>
  <#assign createUrl = "editperson?create_new=Y&amp;lastName=${parameters.lastName?if_exists}&amp;firstName=${parameters.firstName?if_exists}"/>
<#elseif (parameters.groupName?has_content)>
  <#assign createUrl = "editpartygroup?create_new=Y&amp;groupName=${parameters.groupName?if_exists}"/>
<#else>
  <#assign createUrl = "createnew"/>
</#if>
<div class="screenlet">
  <div class="screenlet-title-bar">
<#if partyList?has_content>
    <br class="clear"/>
</#if>
  </div>
  <div class="screenlet-body">
    <div id="findPartyParameters" <#if hideFields != "N"> style="display:none" </#if> >
      <h2>会员列表</h2>
      <form method="post" name="lookupparty" action="<@ofbizUrl>mng_sellerExamine</@ofbizUrl>" class="basic-form">
        <input type="hidden" name="lookupFlag" value="Y"/>
        <input type="hidden" name="hideFields" value="Y"/>
        <table class="basic-table" cellspacing="0">
          <tr>
            <td class="label">${uiLabelMap.PartyPartyId}</td>
            <td><input type="text" name="partyId" value="${parameters.partyId?if_exists}"/></td>
          
            <td class="label">${uiLabelMap.PartyUserLogin}</td>
            <td><input type="text" name="userLoginId" value="${parameters.userLoginId?if_exists}"/></td>
          </tr>
          <tr>
            <td class="label">${uiLabelMap.PartyLastName}</td>
            <td><input type="text" name="lastName" value="${parameters.lastName?if_exists}"/></td>
         
            <td class="label">${uiLabelMap.PartyFirstName}</td>
            <td><input type="text" name="firstName" value="${parameters.firstName?if_exists}"/></td>
          </tr>
          <tr>
            <td class="label">${uiLabelMap.PartyPartyGroupName}</td>
            <td><input type="text" name="groupName" value="${parameters.groupName?if_exists}"/></td>
            <td class="label">${uiLabelMap.PartyRoleType}</td>
            <td>
              <select name="roleTypeId">
<#if currentRole?has_content>
                <option value="${currentRole.roleTypeId}">${currentRole.get("description",locale)}</option>
                <option value="${currentRole.roleTypeId}">---</option>
</#if>
                <option value="ANY">${uiLabelMap.CommonAnyRoleType}</option>
<#list roleTypes as roleType>
                <option value="${roleType.roleTypeId}">${roleType.get("description",locale)}</option>
</#list>
              </select>
            </td>
          </tr>
          <tr>
            <td class="label">${uiLabelMap.PartyType}</td>
            <td>
              <select name="partyTypeId">
<#if currentPartyType?has_content>
                <option value="${currentPartyType.partyTypeId}">${currentPartyType.get("description",locale)}</option>
                <option value="${currentPartyType.partyTypeId}">---</option>
</#if>
                <option value="ANY">${uiLabelMap.CommonAny}</option>
<#list partyTypes as partyType>
                <option value="${partyType.partyTypeId}">${partyType.get("description",locale)}</option>
</#list>
              </select>
            </td>
            <td class="label">审核类型</td>
            <td><select><option>全部</option><option>待审核</option><option>审核通过</option><option>审核未通过</option></select></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>
              <input type="submit" value="${uiLabelMap.CommonFind}" onclick="javascript:document.lookupparty.submit();"/>
            </td>
          </tr>
        </table>
      </form>
    </div>
    <script language="JavaScript" type="text/javascript">
      document.lookupparty.partyId.focus();
    </script>

<#if partyList?exists>
  <#if hideFields != "Y">
    <hr />
  </#if>
  	<#-- 
    <div id="findPartyResults">
      <h2>${uiLabelMap.CommonSearchResults}</h2>
    </div>
    -->
  <#if partyList?has_content>
    <#-- Pagination -->
    <#include "component://common/webcommon/includes/htmlTemplate.ftl"/>
    <#assign commonUrl = "mng_sellerExamine?hideFields=" + hideFields + paramList + "&sortField=" + sortField?if_exists + "&"/>
    <#assign viewIndexFirst = 0/>
    <#assign viewIndexPrevious = viewIndex - 1/>
    <#assign viewIndexNext = viewIndex + 1/>
    <#assign viewIndexLast = Static["org.ofbiz.base.util.UtilMisc"].getViewLastIndex(partyListSize, viewSize) />
    <#assign messageMap = Static["org.ofbiz.base.util.UtilMisc"].toMap("lowCount", lowIndex, "highCount", highIndex, "total", partyListSize)/>
    <#assign commonDisplaying = Static["org.ofbiz.base.util.UtilProperties"].getMessage("CommonUiLabels", "CommonDisplaying", messageMap, locale)/>
    <@nextPrev commonUrl=commonUrl ajaxEnabled=false javaScriptEnabled=false paginateStyle="nav-pager" paginateFirstStyle="nav-first" viewIndex=viewIndex highIndex=highIndex listSize=partyListSize viewSize=viewSize ajaxFirstUrl="" firstUrl="" paginateFirstLabel="" paginatePreviousStyle="nav-previous" ajaxPreviousUrl="" previousUrl="" paginatePreviousLabel="" pageLabel="" ajaxSelectUrl="" selectUrl="" ajaxSelectSizeUrl="" selectSizeUrl="" commonDisplaying=commonDisplaying paginateNextStyle="nav-next" ajaxNextUrl="" nextUrl="" paginateNextLabel="" paginateLastStyle="nav-last" ajaxLastUrl="" lastUrl="" paginateLastLabel="" paginateViewSizeLabel="" />
    <table class="table table-bordered table-striped table-condensed" cellspacing="0">
      <tr style="background-color:#aaa">
        <td>${uiLabelMap.PartyPartyId}</td>
        <td>${uiLabelMap.PartyName}</td>
    <#if extInfo?default("") == "P" >
        <td>${uiLabelMap.PartyCity}</td>
    </#if>
    <#if extInfo?default("") == "P">
        <td>${uiLabelMap.PartyPostalCode}</td>
    </#if>
    <#if extInfo?default("") == "T">
        <td>${uiLabelMap.PartyAreaCode}</td>
    </#if>
    <#if inventoryItemId?default("") != "">
        <td>${uiLabelMap.ProductInventoryItemId}</td>
    </#if>
    <#if serialNumber?default("") != "">
        <td>${uiLabelMap.ProductSerialNumber}</td>
    </#if>
    <#if softIdentifier?default("") != "">
        <td>${uiLabelMap.ProductSoftIdentifier}</td>
    </#if>
        <td>${uiLabelMap.PartyType}</td>
        <td>${uiLabelMap.PartyMainRole}</td>
        
        <td>&nbsp;</td>
      </tr>
    <#assign alt_row = false>
    <#assign rowCount = 0>
    <#list partyList as partyRow>
      <#assign partyType = partyRow.getRelatedOne("PartyType", false)?if_exists>
      <tr valign="middle"<#if alt_row> class="alternate-row"</#if>>
        <td><a href="<@ofbizUrl>viewprofile?partyId=${partyRow.partyId}</@ofbizUrl>">${partyRow.partyId}</a></td>
        <td>
      <#if partyRow.getModelEntity().isField("lastName") && lastName?has_content>
          ${partyRow.lastName}<#if partyRow.firstName?has_content>, ${partyRow.firstName}</#if>
      <#elseif partyRow.getModelEntity().isField("groupName") && partyRow.groupName?has_content>
          ${partyRow.groupName}
      <#else>
        <#assign partyName = Static["org.ofbiz.party.party.PartyHelper"].getPartyName(partyRow, true)>
        <#if partyName?has_content>
          ${partyName}
        <#else>
          (${uiLabelMap.PartyNoNameFound})
        </#if>
      </#if>
        </td>
      <#if extInfo?default("") == "T">
        <td>${partyRow.areaCode?if_exists}</td>
      </#if>
      <#if extInfo?default("") == "P" >
        <td>${partyRow.city?if_exists}, ${partyRow.stateProvinceGeoId?if_exists}</td>
      </#if>
      <#if extInfo?default("") == "P">
        <td>${partyRow.postalCode?if_exists}</td>
      </#if>
      <#if inventoryItemId?default("") != "">
        <td>${partyRow.inventoryItemId?if_exists}</td>
      </#if>
      <#if serialNumber?default("") != "">
        <td>${partyRow.serialNumber?if_exists}</td>
      </#if>
      <#if softIdentifier?default("") != "">
        <td>${partyRow.softIdentifier?if_exists}</td>
      </#if>
      <#if partyType?exists>
        <td><#if partyType.description?exists>${partyType.get("description", locale)}<#else>???</#if></td>
      <#else>
        <td></td><td></td>
      </#if>
        <td>
      <#assign mainRole = dispatcher.runSync("getPartyMainRole", Static["org.ofbiz.base.util.UtilMisc"].toMap("partyId", partyRow.partyId, "userLogin", userLogin))/>
              ${mainRole.description?if_exists}
        </td>
        <#assign partyDate = delegator.findOne("Party", {"partyId":partyRow.partyId}, true)/>
        <td class="button-col align-float">
          <a href="#">审核</a>
        </td>
      </tr>
      <#assign rowCount = rowCount + 1>
      <#assign alt_row = !alt_row>
    </#list>
    </table>
  <#else>
  	<#-- 
    <div id="findPartyResults_2">
      <h3>${uiLabelMap.PartyNoPartiesFound}</h3>
    </div>
    -->
  </#if>
  <#if lookupErrorMessage?exists>
    <h3>${lookupErrorMessage}</h3>
  </#if>
  </div>
</#if>
</div>
