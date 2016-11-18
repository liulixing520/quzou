
  <link href="../seller/css/seller.css" rel="stylesheet" type="text/css" /> 
  <link href="../seller/css/general_popup_box.css" rel="stylesheet" type="text/css" />
       <link href="../seller/css/micidentity.css" rel="stylesheet" type="text/css" /> 
     <link href="../seller/css/setauthentication.css" rel="stylesheet" type="text/css" /> 
     <link href="../seller/css/register1309.css" rel="stylesheet" type="text/css" /> 
  <script type="text/javascript">
  	$(function(){ 
		$(".breadcrumb").append("<li class='active'>身份认证</li>")
		
	});
	function toCertification(){
		var cer=$("#inputvalue_1").val();
		if(cer=="SELLER_PERSONAL"){
			window.location.href="<@ofbizUrl>stor_certification4</@ofbizUrl>?"+$('#UserIdentityForm').serialize();
		}else if(cer=="SELLER_DOMECORP"){
	    	window.location.href="<@ofbizUrl>stor_certificationTwo</@ofbizUrl>?"+$('#UserIdentityForm').serialize();
		}else if(cer=="SELLER_INDIVBIZ"){
			window.location.href="<@ofbizUrl>stor_certification3</@ofbizUrl>?"+$('#UserIdentityForm').serialize();
		}else{
			alert("请选择用户类型!");
		}
	}
  </script> 
  <style type="text/css">  
#right{float:left; width:auto; padding-left:6px;}         
</style> 
  <div class="content">
   <#if party?has_content>
   		<#if party.sellerStatusId?has_content && (party.sellerStatusId=="SELLER_CREATED" || party.sellerStatusId=="SELLER_ACCEPTED")>
   			<div class="layout clearfix"> 
    			<div class="col-main">
    				<div id="right">
    				       <div class="col-sailtips clearfix"> 
        						<span class="leftcol-tip">温馨提示：</span> 
        						<div class="rightcol-tip">
        							<#if  party.sellerStatusId=="SELLER_CREATED" >
        								<p id="hideTipsBox">您好，您已经提交了审核资料，现在正在审核中... ...</p> 
        							</#if>
        							<#if  party.sellerStatusId=="SELLER_ACCEPTED" >
        								<p id="hideTipsBox">您好，恭喜您，你提交的审核资料已审核通过，谢谢您的支持！</p> 
        							</#if>
        						</div>
        					</div>
        			</div>
        		</div>
        	</div> 	
    				
    			
 		<#else>

   <div class="layout clearfix"> 
    <div class="col-main"> 
     <div id="right"> 
      <form  name="UserIdentityForm" id="UserIdentityForm" method="post"> 
       <div class="col-boxpd col-linebom"> 
        <h2>身份认证</h2> 
       </div> 
       <div class="col-sailtips clearfix"> 
        <span class="leftcol-tip">温馨提示：</span> 
        <div class="rightcol-tip">
        <#-- 
         <#if  party.sellerStatusId?has_content>
        	<p id="hideTipsBox">您好，您还没有提交了审核资料，请填写下面的信息，进行身份审核，谢谢配合！</p> 
         </#if>
         -->
         <#if  party.sellerStatusId?has_content>
         	<#if party.sellerStatusId=="SELLER_DECLINED">
        		<p id="hideTipsBox">您好,您上次提交材料审核未通过，请修改后重新提交，谢谢配合！</p>
        	</#if>
         <#else>
         	<p id="hideTipsBox">您好，您还没有提交了审核资料，请填写下面的信息，进行身份审核，谢谢配合！</p> 
         </#if>
        </div> 
       </div>
       <div class="aut-postatta" id="rgPostatta"> 
        <div class="autpost-tit">
         <span>*</span>请选择您要认证的用户类型：
        </div> 
        <div class="autpost-con"> 
         <span class="marg-r9"> <select class="seta-select addwid235" id="inputvalue_1" name="partyClassificationGroupId"> 
         	<option >请选择您的身份类型</option>
         	<#list classificationList as classification> 
         	<option value="${classification.partyClassificationGroupId}">${classification.description}</option> 
         	</#list> 
         	</select> </span> 
        <#-- <span class="tiparrow-h"> <span class="onfocus" id="tipInfo_1"> <span class="includeno">{</span> <span class="include-txt m-t7">身份认证提交审核后，认证类型将无法修改。</span> </span> <span class="auterror" id="erroriInfo_1" style="display:none">请选择您的身份类型</span> </span>  -->
        </div> 
        <!--为了更新用户名公司名称和企业法人--> 
        <div class="autpost-tit">
         <span>*</span>联系人姓名：
        </div> 
        <div class="autpost-con"> 
         <span class="marg-r9"> <input type="text" class="textinpt" style="padding:0;" name="firstName" maxlength="50" id="inputvalue_2"   value="" /> </span>  
        </div> 
        <div class="autpost-tit"> 
         <span>*</span> 联系人身份证号：
        </div> 
        <div class="autpost-con clearfix"> 
         <span class="marg-r9"> <input type="text" class="textinpt" style="padding:0;" name="socialSecurityNumber" id="inputvalue_3" must="1"  maxlength="20" value="" /> </span> 
        </div> 
        <div class="autpost-tit"></div> 
        <div class="autpost-con02 clearfix" style="margin-bottom:50px; margin-left:366px;"> 
          <span><input type="button" class="smallSubmit" value="开始认证" onclick="toCertification()"/></span>
        </div>  
       </div>
      </form>
     </div>
     </div>
     </div>
        </#if>
   </#if>
   </div> 