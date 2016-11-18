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
            
            <td class="label">用户名</td>
            <td><input type="text" name="userLoginId" value="${parameters.userLoginId?if_exists}"/></td>
        
           
        
            <td>
            	&nbsp;&nbsp;
              <input type="submit" class="btn  btn-primary" value="查询" onclick="javascript:document.lookupparty.submit();"/>
            </td>
          </tr>
        </table>
       
      </form>
    <script language="JavaScript" type="text/javascript">
      document.lookupparty.partyId.focus();
    </script>

<#if userList?exists>
  	
   <table class="table table-bordered table-striped table-condensed" cellspacing="0">
      <tr style="background-color:#aaa">
        <td>编号</td>
        <td>姓名</td>
        <td>用户名</td>
        <td>注册时间</td>
      </tr>
     <#if userList?has_content>
    <#-- Pagination -->
    
    <#assign alt_row = false>
    <#assign rowCount = 0>
    <#list userList as user>
      <#assign party= delegator.findOne("Person",false,{"partyId",user.partyId})?if_exists>
      <tr valign="middle"<#if alt_row> class="alternate-row"</#if>>
        <td>
              <#if party??> ${party.partyId!}</#if>
        </td>
        <td>
              <#if party??> ${party.firstName!}</#if>
        </td>
        <td>
              <#if user??&&user.userLoginId?has_content> ${user.userLoginId!}</#if>
        </td>
        <td>
           <#--   <#if user??&&user.createdTxStamp?has_content> ${user.createdTxStamp?string("yyyy-MM-dd")!}</#if>  -->
        </td>
        <td class="button-col align-float">
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
