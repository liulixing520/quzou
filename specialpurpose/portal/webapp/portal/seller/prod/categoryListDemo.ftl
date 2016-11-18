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
<style>
html, body {
	overflow:auto;
}
</style>
<div id="all_main">
  <!--功能区域-->
  <div class="head_main" id="head_main">
    <div class="main_nav01">
    	<span>${uiLabelMap.ProductCategoriesMgr}</span>
        <div class="inputright"><input name="" type="button" class="input01" value="${uiLabelMap.ProductNewCategory}" onclick="location.href='/iteamgr/control/EditCategory'"></div>
    </div>
  </div>
 
    <div class="content_main main_pag" id="list" style="height: 472px; width: 1105px; ">
      
        <div id="list_title" style="width: 1105px; ">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="main_title" id="main_title">
<script>window.finder['order_by']=new Sort('order_by',{queryString:''});</script><tbody><tr class="border_tr"><!--  <th class="width5"><input type="checkbox" name="checkbox" id="checkbox" /></th>-->
              <th class="width10" style="border-left:none">${uiLabelMap.CommOper}</th>
              <th onclick="" class="null width20 sort_show">${uiLabelMap.CommonAll}<input type="checkbox" name="selectAll" value="${uiLabelMap.CommonY}" onclick="javascript:toggleAll(this, 'selectAllForm');highlightAllRows(this, 'review_tableRow_', 'selectAllForm');" /></th>
               <th onclick="window.finder[&#39;order_by&#39;].orderby(&#39;8d8da466617b8aa4&#39;)" class="null width20 sort_show">${uiLabelMap.ProductCategoryName}</th>
               <th onclick="window.finder[&#39;order_by&#39;].orderby(&#39;8d8da46667938da4&#39;)" class="null width15 sort_show">${uiLabelMap.ProductCategoryNumber}</th>
               <th class="null width15 sort_show"> ${uiLabelMap.CommIsView}</th>
                   </tbody></table>
   </div>
        <!--具体内容-->
        <div class="main_pag" id="list_cont" style="width: 1105px; height: 443px; ">
             <form method='post' action='<@ofbizUrl>updateProductReview</@ofbizUrl>' name="selectAllForm">
            <table border="0" cellpadding="0" cellspacing="0" width="1105px" class="mouseAction">
              <tbody>
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
                  <tr id="review_tableRow_${rowCount}" valign="middle"<#if rowClass == "1"> class="border_tr background_tr"<#else> class="border_tr"</#if> >
              
                      
                      <td class="width10" ><input type='button' name='edit' value="${uiLabelMap.CommEdit}">
                         <input type='button' name='delete' value="${uiLabelMap.CommonDelete}">
                        
                          </td>
                      <td  class="null width20 ">
                        <input type="checkbox" name="_rowSubmit_o_${rowCount}" value="Y" onclick="javascript:checkToggle(this, 'selectAllForm');highlightRow(this,'review_tableRow_${rowCount}');" />
                      </td>
                      <td class="null width20 "> 
                         ${review.productCategoryId?if_exists}
                      </td>
                      <td class="null width15 ">
                         ${review.productCategoryNumber?if_exists}
                      </td>
                      <td class="null width15 ">
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
              
            </tbody></table>
            </form>
        </div>
  </div>
  <!--页脚，翻页，功能提交-->
  <div class="footbar_main" id="footbar_main">
<script type="text/javascript" src="page.js"></script>
<div class="footbar">
    <div class="lapel">
    	<input type="hidden" name="totalRow" id="totalRow" value="15">
		<input type="hidden" name="pageSize" id="pageSize" value="20">
    	<span> ${uiLabelMap.CommpPageTotalNum} 15 ${uiLabelMap.CommpPageTotalItem}</span>
    	<span>${uiLabelMap.CommpPageFirst}</span>
    	<span>${uiLabelMap.CommpPageBack}</span>
<span>1</span>    	<span>${uiLabelMap.CommpPageNext}</span>
    	<span>${uiLabelMap.CommpPageEnd}</span>
    	<!--  <span>页次：1/1 页</span>  -->
    	<span>${uiLabelMap.CommpPageForword} : ${uiLabelMap.CommpPageNow}<input id="_pgNoTxt" type="text" style="width:20px; text-align:center; margin:0 2px" onkeypress="if(event.keyCode==13)goTo(1,1,&#39;&#39;)">${uiLabelMap.CommpPagePage}
    	<input type="button" value="GO" style="cursor:pointer" onclick="goTo(1,1,&#39;&#39;)"></span>
    </div>
	<div class="lapel01">${uiLabelMap.CommpPageDisplayCount} :
	<a href="http://demo.shop.cn/admin/query_specifications.dhtml?pgSize=10&titSize=15&pgNumber=1">10</a>	<span>20</span>	<a href="http://demo.shop.cn/admin/query_specifications.dhtml?pgSize=50&titSize=15&pgNumber=1">50</a>	<a href="http://demo.shop.cn/admin/query_specifications.dhtml?pgSize=100&titSize=15&pgNumber=1">100</a>	</div>
</div> </div>
 
</div>
</div>
