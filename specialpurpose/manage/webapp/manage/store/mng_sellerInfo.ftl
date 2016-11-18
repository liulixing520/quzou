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
 <script src="../images/js/jquery.js" type="text/javascript"></script>
 <script type="text/javascript">
	function toCertificationPage(cer,partyId){
		if(cer=="SELLER_PERSONAL"){
			window.open("<@ofbizUrl>mng_sellerInfoDetail3</@ofbizUrl>?partyId="+partyId);
			//window.location.href="<@ofbizUrl>mng_sellerInfoDetail3</@ofbizUrl>?partyId="+partyId;
		}else if(cer=="SELLER_DOMECORP"){
			window.open("<@ofbizUrl>mng_sellerInfoDetail1</@ofbizUrl>?partyId="+partyId);
	    	//window.location.href="<@ofbizUrl>mng_sellerInfoDetail1</@ofbizUrl>?partyId="+partyId;
		}else if(cer=="SELLER_INDIVBIZ"){
			window.open("<@ofbizUrl>mng_sellerInfoDetail2</@ofbizUrl>?partyId="+partyId);
			//window.location.href="<@ofbizUrl>mng_sellerInfoDetail2</@ofbizUrl>?partyId="+partyId;
		}else{
			alert("该用户没有提交审核请求！");
		}
	}
	function setProductStoreStatus(obj,sellerStatusId,partyId){
			var obj2=$(obj);
			var html1="<a href='javascript:void(0);' onclick='setProductStoreStatus(this,\"SELLER_ACCEPTED\",\""+partyId+"\")'>通过</a>&nbsp;|&nbsp;<a href='javascript:void(0);' onclick='setProductStoreStatus(this,\"SELLER_DECLINED\",\""+partyId+"\");'>不通过</a>";
			jQuery.ajax({
            	url: 'mng_setSellerStatus',
            	async: false,
            	type: 'POST',
            	data: "sellerStatusId="+sellerStatusId+"&partyId="+partyId,
            	success: function(data) {
            	
            		if(sellerStatusId=='SELLER_CREATED'){
            			//obj2.parent().parent().prev().html('<label>待审核</label>');
            			//obj2.parent().html(html1);
            			alert("撤销成功！");
            		}else if(sellerStatusId=='SELLER_ACCEPTED'){
            			//obj2.parent().parent().prev().html('<label>通过</label>');
            			//obj2.parent().html("<a href='javascript:void(0);' onclick='setProductStoreStatus(this,\"SELLER_CREATED\",\""+partyId+"\")'>撤销</a>");
            			alert("审核通过！");
            		}else if(sellerStatusId=='SELLER_DECLINED'){
            			//obj2.parent().parent().prev().html('<label>不通过</label>');
            			//obj2.parent().html("<a href='javascript:void(0);' onclick='setProductStoreStatus(this,\"SELLER_CREATED\",\""+partyId+"\")'>撤销</a>");
            			alert("审核不通过！");
            		}else{
            			//obj2.parent().parent().prev().html('<label>无请求</label>');
            			alert("无请求！");
            		}
            		
            		//alert(obj2.parent().html());
            		 location.reload();
            	}
        	});
	}
  </script>

  <div class="panel-body">
      <form method="post" name="lookupparty" action="<@ofbizUrl>mng_sellerInfo</@ofbizUrl>" class="pageForm">
        <input type="hidden" name="lookupFlag" value="Y"/>
        <input type="hidden" name="hideFields" value="Y"/>
         <input type="hidden" name="roleTypeId" value="SELLER" />
        <table class="searchContent" cellspacing="0">
          <tr>
            
            <td class="label">${uiLabelMap.PartyUserLogin}</td>
            <td><input type="text" name="userLoginId" value="${parameters.userLoginId?if_exists}"/></td>
        
            <td class="label">店铺名称</td>
            <td><input type="text" name="groupName" value="${parameters.groupName?if_exists}"/></td>
            <td class="label">审核类型</td>
            <td>
            	<select name="sellerStatusId">
            		<option value="">全部</option>
            		<option value="SELLER_CREATED">待审核</option>
            		<option value="SELLER_ACCEPTED">审核通过</option>
            		<option value="SELLER_DECLINED">审核未通过</option>
            	</select>
            </td>
        
            <td>
            	&nbsp;&nbsp;
              <input type="submit" class="btn  btn-primary" value="${uiLabelMap.CommonFind}" onclick="javascript:document.lookupparty.submit();"/>
            </td>
          </tr>
        </table>
       
      </form>
    <script language="JavaScript" type="text/javascript">
      document.lookupparty.partyId.focus();
    </script>

<#if partyList?exists>
  	
   <table class="table table-bordered table-striped table-condensed" cellspacing="0">
      <tr style="background-color:#aaa">
        <td>${uiLabelMap.PartyPartyId}</td>
        <td>请求时间</td>
        <td>店铺名称</td>
        <td>审核时间</td>
        <td>审核状态</td>
        <td>操作</td>
      </tr>
     <#if partyList?has_content>
    <#-- Pagination -->
    
    <#assign alt_row = false>
    <#assign rowCount = 0>
    <#list partyList as partyRow>
      <#if partyRow.payToPartyId??>
      <#assign party= delegator.findOne("Party",false,{"partyId",partyRow.payToPartyId})?if_exists>
      </#if>
      <tr valign="middle"<#if alt_row> class="alternate-row"</#if>>
        <td>
              <#if party??> ${party.partyId!}</#if>
        </td>
        <td>
              <#if party??&&party.begDate?has_content> ${party.begDate!}</#if>
        </td>
        <td>
              <#if partyRow??> ${partyRow.storeName!}</#if>
        </td>
        <td><#if party??&&party.examineDate??>${party.examineDate}</#if></td>
        <td class="button-col align-float">
        	<#if party.sellerStatusId?has_content>
        		<#if party.sellerStatusId=="SELLER_CREATED"><label>待审核</label></#if>
        		<#if party.sellerStatusId=="SELLER_ACCEPTED"><label>通过</label></#if>
        		<#if party.sellerStatusId=="SELLER_DECLINED"><label>不通过</label></#if>
        	<#else>
        		<label >通过</label>
        	</#if>
        </td>
        
        <td class="button-col align-float">
          <#if party.sellerStatusId?has_content>
          	<#assign patyClassification = delegator.findByAnd("PartyClassification", {"partyId":partyRow.partyId},null, true)/>
          	<#if patyClassification?has_content>
          		<a href="javascript:void(0);" onclick="toCertificationPage('${patyClassification[0].partyClassificationGroupId}','${patyClassification[0].partyId}');" >查看</a> 
          	</#if>
          </#if>
          <a>冻结</a>
        </td>
      </tr>
      <#assign rowCount = rowCount + 1>
      <#assign alt_row = !alt_row>
    </#list>
    </table>
   
  </#if>
  <#if lookupErrorMessage?exists>
    <h3>${lookupErrorMessage}</h3>
  </#if>
  </div>
</#if>
</div>
