	<link href="../images/css/general_popup_box.css" rel="stylesheet" type="text/css" /> 
   <div class="layout clearfix"> 
    <div class="col-main"> 
     <link href="../images/css/micidentity.css" rel="stylesheet" type="text/css" /> 
     <link href="../images/css/setauthentication.css" rel="stylesheet" type="text/css" /> 
     <link href="../images/css/register1309.css" rel="stylesheet" type="text/css" /> 
	<style type="text/css">
.upimgcon{display:table;*display:block;table-layout:fixed;width:120px;height:88px;border:1px solid #ddd;vertical-align:middle;}
.uploadingimg{cursor:pointer;display:table-cell;*display:inline-block;text-align:center;width:120px;height:88px;vertical-align:middle;}
.autpost-con .uploadingimg img{display:block;margin:0 auto;max-width:120px;max-height:88px;overflow:hidden;_width:120px;_height:88px;}
.autpost-con .tourBtn{display:inline-block;margin:10px 0px 0 0;}

.autpost-con .tourBtn input{padding:0 13px 3px;}
.autopost-lf{position:relative;float:left;width:122px;}
.autopost-ri{margin-left:131px;min-height:88px;}
.aut-postatta .autpost-tit{width:240px;}
.aut-postatta .autpost-con{margin-left:240px;}

.ap-riexample{float:left;width:40px;}
.aut-postatta .autpost-con02{margin-left:226px;}
.autpost-con .rg-modified{margin-right:4px;}
.rg-fangda{position:absolute;width:19px;height:19px;right:1px;top:70px;background:url(../../image/register/rg-fangda.png) no-repeat 0 0;}

.m-mid .mid-warp .rg-regisImg{display:table-cell;text-align:center;max-width:776px;max-height:600px;overflow:hidden;vertical-align:middle;}
.m-mid .mid-warp .rg-regisImg img{max-width:776px;max-height:600px;_width:776px;_height:600px;margin:0 auto;vertical-align:middle;}
.reg-minbox .mob-failright p{line-height:17px;}
.col-sm-3{padding-left:0px; margin-top:10px; text-align:right; padding-right:10px;}    
.col-sm-9{padding-left:0px; margin-top:10px;}  
#right{float:left; width:auto; padding-left:15px;}          
</style>
  <script type="text/javascript">
	function savePartyGroup(){
		var isPerson = true;
		window.location.href="<@ofbizUrl>stor_certification4</@ofbizUrl>?isPerson="+isPerson;
	}
  </script> 
     <div id="right"> 
      <div class="reg-minbox"> 
       <div class="col-boxpd col-linebom"> 
        <h2>身份认证</h2> 
       </div> 
       <div class="auttip-box">
        <table> 
         <tbody>
          <tr> 
           <td class="right">您申请的身份认证类别为：</td> 
           <td><b> 个人 </b></td> 
          </tr> 
          <tr> 
           <td class="right">联系人姓名：</td> 
           <td>${firstName!}</td> 
          </tr> 
          <tr> 
           <td class="right">身份证号码：</td> 
           <td>${socialSecurityNumber!}</td> 
          </tr>
          <#-- 
          <tr> 
           <td class="right"></td> 
           <td><a href="<@ofbizUrl>stor_certification</@ofbizUrl>" class="marginleft20">返回修改</a></td> 
          </tr>
          -->  
         </tbody>
        </table> 
       </div> 
       <div class="authenticn-cat">
        <b>请提交如下认证材料：</b>
       </div> 
        <div class="aut-postatta" id="rgPostatta"> 
         <div class="autpost-tit"> 
          <span>*</span> tradeease联系人手持身份证正面照片： 
			 &nbsp; 
         </div>
         <br/>
         <br/> 
         <div class="autpost-con clearfix"> 
          <div class="autopost-lf"> 
           <#if partyContentList?has_content>
           		<#assign legpoidPartyContentList = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(partyContentList,Static["org.ofbiz.base.util.UtilMisc"].toMap("partyContentTypeId", "CTAPOID_PHOTO"))/>
           		<#if legpoidPartyContentList?has_content>
           			<#assign legpoidPartyContent = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(legpoidPartyContentList)>
           			<#assign legpoidContent1 = delegator.findOne("Content",Static["org.ofbiz.base.util.UtilMisc"].toMap("contentId", legpoidPartyContent.contentId),false)/>
           		</#if>
           </#if>
           
           <span class="upimgcon"> <span class="uploadingimg"> <img alt="" src="<#if legpoidContent1?has_content><@ofbizUrl>img?imgId=${(legpoidContent1.dataResourceId)!}</@ofbizUrl></#if>" id="show_url_1" /> <var class="rg-fangda"></var> </span> </span>
           <#-- 
           <form method="post" enctype="multipart/form-data" action="<@ofbizUrl>upCertificateContentForPerson</@ofbizUrl>"> 
           	<div class="uploading-btn">        		
        		<input type="hidden" name="partyId" value="${(userLogin.partyId)!}"/>
        		<input type="hidden" name="dataCategoryId" value="PERSONAL"/>
        		<input type="hidden" name="contentTypeId" value="DOCUMENT"/>
        		<input type="hidden" name="statusId" value="CTNT_PUBLISHED"/>
        		<input type="hidden" name="roleTypeId" value="OWNER"/>
        		<input type="hidden" name="partyContentTypeId" value="CTAPOID_PHOTO"/>
        		<input type="hidden" name="mimeTypeId" value="image/jpeg"/>
           		<span class="tourBtn rg-modified"><input type="file" value="选择文件" name="uploadedFile"/></span> 
            	<span class="tourBtn rg-modified"><input type="submit" value="上传" id="button_1" /></span> 
            	<span class="tourBtn"><input type="button" value="删除" /></span> 
           	</div>
           </form>
           --> 
          </div>
          <#-- 
          <div class="autopost-ri"> 
           <div class="autopost-riimg clearfix"> 
            <span class="ap-riexample">示例：</span> 
            <span class="upimgcon"> <span class="uploadingimg"> <img alt="" src="" /> <var class="rg-fangda"></var> </span> </span> 
           </div> 
           <div class="autopost-ritips"> 
            <p>1.请按照示例提供二代身份证进行认证，确保证件上的信息清晰有效，如：姓名、地址、身份证号码</p> 
            <p>2.请勿提供临时身份证或身份证复印件；</p> 
            <p>3.请确认上传的身份证与帐号注册联系人一致；</p> 
            <p>4.如提供虚假证件进行认证，您的帐号将被关闭。</p> 
           </div> 
          </div>
          -->  
          <!--  修改 end --> 

          <!--   --------------          提示信息内容   --> 
         </div>  
         <div class="autpost-tit"> 
          <span>*</span> tradeease联系人手持身份证反面照片： 
			 &nbsp; 
         </div>
         <br/>
         <br/> 
         <div class="autpost-con clearfix"> 
          <div class="autopost-lf">
           <#if partyContentList?has_content>
           		<#assign legpoidPartyContentList = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(partyContentList,Static["org.ofbiz.base.util.UtilMisc"].toMap("partyContentTypeId", "CTAOPID_PHOTO"))/>
           		<#if legpoidPartyContentList?has_content>
           			<#assign legpoidPartyContent = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(legpoidPartyContentList)>
           			<#assign legpoidContent2 = delegator.findOne("Content",Static["org.ofbiz.base.util.UtilMisc"].toMap("contentId", legpoidPartyContent.contentId),false)/>
           		</#if>
           </#if> 
           <span class="upimgcon"> <span class="uploadingimg"> <img alt="" src="<#if legpoidContent2?has_content><@ofbizUrl>img?imgId=${(legpoidContent2.dataResourceId)!}</@ofbizUrl></#if>" id="show_url_2" /> <var class="rg-fangda"></var> </span> </span>
           <#-- 
           <form method="post" enctype="multipart/form-data" action="<@ofbizUrl>upCertificateContentForPerson</@ofbizUrl>"> 
           	<div class="uploading-btn">
        		<input type="hidden" name="partyId" value="${(userLogin.partyId)!}"/>
        		<input type="hidden" name="dataCategoryId" value="PERSONAL"/>
        		<input type="hidden" name="contentTypeId" value="DOCUMENT"/>
        		<input type="hidden" name="statusId" value="CTNT_PUBLISHED"/>
        		<input type="hidden" name="roleTypeId" value="OWNER"/>
        		<input type="hidden" name="partyContentTypeId" value="CTAOPID_PHOTO"/>
        		<input type="hidden" name="mimeTypeId" value="image/jpeg"/>
           		<span class="tourBtn rg-modified"><input type="file" value="选择文件" name="uploadedFile"/></span> 
            	<span class="tourBtn rg-modified"><input type="submit" value="上传" id="button_2" /></span> 
            	<span class="tourBtn"><input type="button" value="删除" onclick="delurl(2)" /></span> 
           	</div>
           </form>
           --> 
          </div>
          <#-- 
          <div class="autopost-ri"> 
           <div class="autopost-riimg clearfix"> 
            <span class="ap-riexample">示例：</span> 
            <span class="upimgcon"> <span class="uploadingimg"> <img alt="" src=" " /> <var class="rg-fangda"></var> </span> </span> 
           </div> 
           <div class="autopost-ritips"> 
            <p>1.请按照示例提供二代身份证进行认证，确保证件上的信息清晰有效，如：签发机关及有效期；</p> 
            <p>2.请勿提供临时身份证或身份证复印件；</p> 
            <p>3.请确认上传的身份证与帐号注册联系人一致；</p> 
            <p>4.如提供虚假证件进行认证，您的帐号将被关闭。</p> 
           </div> 
          </div>
          --> 
          <!--  修改 end --> 
         </div> 
         <div class="autpost-con02 clearfix" style="margin-bottom:50px; margin-left:366px;"> 
          <span><a href="<@ofbizUrl>mng_sellerExamine</@ofbizUrl>" class="smallSubmit" >返回</a></span><#-- onclick="savePartyGroup();" --> 
         </div> 
        </div> 
      </div> 
     </div> 