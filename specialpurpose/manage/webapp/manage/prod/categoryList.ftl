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
<script language="JavaScript" type="text/javascript">
    function changeReviewStatus(statusId) {
        document.selectAllForm.statusId.value = statusId;
        document.selectAllForm.submit();
    }
</script>
<div class="head_main">
    <!--
    <div class="screenlet-title-bar">
         <h3>${uiLabelMap.ProductCategoriesMgr}</h3> 
    </div>
    -->
    <div class="head_main">
        <#if !productCategorys?has_content>
            <!-- <h3>${uiLabelMap.ProductCategoriesMgr}</h3> -->
        <#else>
            <form method='post' action='<@ofbizUrl>updateProductReview</@ofbizUrl>' name="selectAllForm">
                <input type="hidden" name="_useRowSubmit" value="Y" />
                <input type="hidden" name="_checkGlobalScope" value="Y" />
                <input type="hidden" name="statusId" value="" />
                
                <div align="right">
               
                    <!--
                    <input type="button" value="${uiLabelMap.CommonUpdate}" onclick="javascript:changeReviewStatus('PRR_PENDING')" />
                    <input type="button" value="${uiLabelMap.ProductPendingReviewUpdateAndApprove}" onclick="javascript:changeReviewStatus('PRR_APPROVED')" />
                     -->
                    <input type="button" value="${uiLabelMap.CommonDelete}" onclick="javascript:changeReviewStatus('PRR_DELETED')" />
                </div>
               
                <table cellspacing="0" class="basic-table">
                  <tr class="main_title">
                  <td><b>${uiLabelMap.oper}</b></td>
                  <td >
                        <span class="label">${uiLabelMap.CommonAll}</span>
                        <input type="checkbox" name="selectAll" value="${uiLabelMap.CommonY}" onclick="javascript:toggleAll(this, 'selectAllForm');highlightAllRows(this, 'review_tableRow_', 'selectAllForm');" />
                    </td>
                    
                    <td><b>${uiLabelMap.ProductCategoryName}</b></td>
                    <td><b>${uiLabelMap.ProductCategoryNumber}</b></td>
                    <td><b>${uiLabelMap.isView}</b></td>
       
                    
                  </tr>
                <#assign rowCount = 0>
                <#assign rowClass = "2">
                <#list productCategorys as review>
                <#if review.userLoginId?has_content>
                <#assign postedUserLogin = review.getRelatedOne("UserLogin")>
                <#if postedUserLogin.partyId?has_content>
                <#assign party = postedUserLogin.getRelatedOne("Party")>
                <#assign partyTypeId = party.get("partyTypeId")>
                <#if partyTypeId == "PERSON">
                    <#assign postedPerson = postedUserLogin.getRelatedOne("Person")>
                <#else>
                    <#assign postedPerson = postedUserLogin.getRelatedOne("PartyGroup")>
                </#if>
                </#if>
                </#if>
                  <tr id="review_tableRow_${rowCount}" valign="middle"<#if rowClass == "1"> class="alternate-row"</#if>>
              
                      
                      <td><input type='button' name='edit' value="${uiLabelMap.CommonUpdate}">
                          <!-- <input type='button' name='edit' value="${uiLabelMap.CommonDelete}">
                          -->
                          </td>
                      <td >
                        <input type="checkbox" name="_rowSubmit_o_${rowCount}" value="Y" onclick="javascript:checkToggle(this, 'selectAllForm');highlightRow(this,'review_tableRow_${rowCount}');" />
                      </td>
                      <td>
                         ${review.productCategoryId?if_exists}
                      </td>
                      <td>
                         ${review.productCategoryNumber?if_exists}
                      </td>
                      <td>
                         ${uiLabelMap.CommonY}
                      </td>
                      
                  </tr>
                <#assign rowCount = rowCount + 1>
                <#-- toggle the row color -->
                <#if rowClass == "2">
                    <#assign rowClass = "1">
                <#else>
                    <#assign rowClass = "2">
                </#if>
                </#list>
                <input type="hidden" name="_rowCount" value="${rowCount}" />
                </table>
            </form>
        </#if>
    </div>
</div>
