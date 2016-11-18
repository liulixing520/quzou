
  <link href="../images/css/general_popup_box.css" rel="stylesheet" type="text/css" /> 
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
#right{float:left; width:auto; padding-left:6px;}         
</style>
  <script type="text/javascript">
	function savePartyGroup(){
		var officeSiteName = $("#inputvalue_1").val();
		var groupName = $("#inputvalue_2").val();
		var barCode = $("#inputvalue_3").val();
		if(groupName==""){
			alert("有值为空");
			return;
		}
		if(officeSiteName==""){
			alert("有值为空");
			return;
		}
		if(barCode==""){
			alert("有值为空");
			return;
		}
		window.location.href="<@ofbizUrl>stor_certificationTwo</@ofbizUrl>?groupName="+groupName+"&officeSiteName="+officeSiteName+"&barCode="+barCode;
	}
  </script>  
  <div> <#-- class="content" -->
   <div class="layout clearfix"> 
    <div class="col-main"> 
     <link href="../images/css/micidentity.css" rel="stylesheet" type="text/css" /> 
     <link href="../images/css/setauthentication.css" rel="stylesheet" type="text/css" /> 
     <link href="../images/css/register1309.css" rel="stylesheet" type="text/css" />  
     <div id="right"> 
      <div class="reg-minbox"> 
       <div class="col-boxpd col-linebom"> 
        <h2>身份信息</h2> 
       </div> 
       <!-- <div class="reg-auttxt">
                <p>1、证件必须是清晰彩色原件电子版，可以是扫描件或者数码拍摄图片。手持身份证照片必须看清证件号且证件完整。不能使用复印件。</p>
                <p class="txtindent">上传文件仅支持.jpg .jpeg .bmp .gif 的图片格式。图片大小不超过500K。</p>
                <p>2、上传营业执照图片必须有当年最新年检章！</p>
                <p>3、请务必上传本人真实认证资料进行身份认证，如一经发现认证资料作假，将取消卖家申请身份认证资格！</p>
            </div>--> 
       <!-- <div class="auttip-box">
                                       您申请的身份认证类别为：<span class="marig-15"> 大陆企业 </span>  刘继松,410928198803045672<a href="/merchant/identity.do">返回修改</a>
            </div>--> 
       <div class="auttip-box"> 
        <table> 
         <tbody>
          <tr> 
           <td class="right">申请的身份认证类别为：</td> 
           <td><b> 大陆企业 </b></td> 
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
        <b>认证信息：</b>
       </div> 
    
        <div class="aut-postatta" id="rgPostatta"> 
         <div class="autpost-tit">
          <span>*</span>公司名称：
         </div> 
         <div class="autpost-con"> 
          <span class="marg-r9"> <label>${officeSiteName!}</label><#-- <input type="text" class="textinpt" value="${officeSiteName!}" id="inputvalue_1" must="1" name="inputvalue" onblur="setInput(1);" maxlength="150" /> <input type="hidden" name="tcIdentityId" id="tcIdentityId_1" value="1" />--> </span> 
          <span class="auterror" id="erroriInfo_1" style="display:none">请填写公司名称</span>
         </div> 
         <div class="autpost-tit">
          <span>*</span> 企业法人： 
         </div> 
         <div class="autpost-con"> 
          <span class="marg-r9"> <label>${groupName!}</label><#--<input type="text" class="textinpt" value="${groupName!}" id="inputvalue_2" must="1" name="inputvalue" onblur="setInput(2);" maxlength="50" /> <input type="hidden" name="tcIdentityId" id="tcIdentityId_2" value="2" /> --> </span> 
          <span class="auterror" id="erroriInfo_2" style="display:none"> 请填写企业法人 </span> 
         </div> 
         <div class="autpost-tit"> 
          <span>*</span> 营业执照号： 
          <!----> &nbsp; 
         </div> 
         <div class="autpost-con clearfix"> 
          <!--       ----------------       是文字内容还是图片内容--> 
          <span class="marg-r9"> <label>${groupName!}</label><#-- <input type="text" class="textinpt" name="inputvalue" value="${barCode!}" id="inputvalue_3" must="1" onblur="setInput(3);" maxlength="50" />--> </span> 
          <span style="display:none" id="erroriInfo_3" class="auterror">请填写营业执照号</span> 
          <!--   --------------          提示信息内容   --> 
         </div> 
         <input type="hidden" name="tcIdentityId" id="tcIdentityId_4" value="6001" /> 
         <div class="autpost-tit"> 
          <span>*</span> 营业执照照片： 
			 &nbsp; 
         </div>
         <br/> 
         <br/>  
         <div class="autpost-con clearfix"> 
          <div class="autopost-lf">
           <#if partyContentList?has_content>
           		<#assign legpoidPartyContentList = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(partyContentList,Static["org.ofbiz.base.util.UtilMisc"].toMap("partyContentTypeId", "BIZLIC_PHOTO"))/>
           		<#if legpoidPartyContentList?has_content>
           			<#assign legpoidPartyContent = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(legpoidPartyContentList)>
           			<#assign legpoidContent = delegator.findOne("Content",Static["org.ofbiz.base.util.UtilMisc"].toMap("contentId", legpoidPartyContent.contentId),false)/>
           		</#if>
           </#if> 
           <span class="upimgcon"> <span class="uploadingimg"> <img alt="" src="<#if legpoidContent?has_content><@ofbizUrl>img?imgId=${(legpoidContent.dataResourceId)!}</@ofbizUrl></#if>" id="show_url_4" /> <var class="rg-fangda"></var> </span> </span> 
           <#-- 
           <form method="post" enctype="multipart/form-data" action="<@ofbizUrl>upCertificateContentForCompany</@ofbizUrl>"> 
           	<div class="uploading-btn">
           	    <input type="hidden" name="partyId" value="${(userLogin.partyId)!}"/>
        		<input type="hidden" name="dataCategoryId" value="PERSONAL"/>
        		<input type="hidden" name="contentTypeId" value="DOCUMENT"/>
        		<input type="hidden" name="statusId" value="CTNT_PUBLISHED"/>
        		<input type="hidden" name="roleTypeId" value="OWNER"/>
        		<input type="hidden" name="partyContentTypeId" value="BIZLIC_PHOTO"/>
        		<input type="hidden" name="mimeTypeId" value="image/jpeg"/>
           		<span class="tourBtn rg-modified"><input type="file" value="选择文件" name="uploadedFile"/></span>  
            	<span class="tourBtn rg-modified"><input type="submit" value="上传" onclick="popuUpload(4)" id="button_4" /></span> 
            	<span class="tourBtn"><input type="button" value="删除" onclick="delurl(4)" /></span> 
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
            <p>1.请确保营业执照上的信息清晰有效，不得遮挡、涂抹或PS</p> 
            <p>2.请勿提供复印件；</p> 
            <p>3.如提供虚假证件进行认证，您的帐号将被关闭。</p> 
            <p><a href="#">帮助</a></p> 
            <p><span style="display:none" id="erroriInfo_4" class="auterror">请上传认证图片</span></p> 
           </div> 
          </div>
          -->  
          <!--  修改 end --> 
          <!-- <span class="tourBtn">
						<input type="button" value="点击上传" onclick='popuUpload(4)' id='button_4'>
					   </span>--> 
          <input type="hidden" name="inputvalue" id="inputvalue_4" must="1" /> 
          <!--   --------------          提示信息内容   --> 
         </div> 
         <input type="hidden" name="tcIdentityId" id="tcIdentityId_5" value="6002" /> 
         <div class="autpost-tit"> 
          <span>*</span> 法定代表人手持身份证正面头部照片： 
			 &nbsp; 
         </div>
         <br/> 
         <br/>  
         <div class="autpost-con clearfix"> 
          <div class="autopost-lf">
           <#if partyContentList?has_content>
           		<#assign legpoidPartyContentList = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(partyContentList,Static["org.ofbiz.base.util.UtilMisc"].toMap("partyContentTypeId", "LEGPOID_PHOTO"))/>
           		<#if legpoidPartyContentList?has_content>
           			<#assign legpoidPartyContent = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(legpoidPartyContentList)>
           			<#assign legpoidContent = delegator.findOne("Content",Static["org.ofbiz.base.util.UtilMisc"].toMap("contentId", legpoidPartyContent.contentId),false)/>
           		</#if>
           </#if> 
           <span class="upimgcon"> <span class="uploadingimg"> <img alt="" src="<#if legpoidContent?has_content><@ofbizUrl>img?imgId=${(legpoidContent.dataResourceId)!}</@ofbizUrl></#if>" id="show_url_5" /> <var class="rg-fangda"></var> </span> </span> 
           <#-- 
           <form method="post" enctype="multipart/form-data" action="<@ofbizUrl>upCertificateContentForCompany</@ofbizUrl>"> 
           	<div class="uploading-btn">
           	    <input type="hidden" name="partyId" value="${(userLogin.partyId)!}"/>
        		<input type="hidden" name="dataCategoryId" value="PERSONAL"/>
        		<input type="hidden" name="contentTypeId" value="DOCUMENT"/>
        		<input type="hidden" name="statusId" value="CTNT_PUBLISHED"/>
        		<input type="hidden" name="roleTypeId" value="OWNER"/>
        		<input type="hidden" name="partyContentTypeId" value="LEGPOID_PHOTO"/>
        		<input type="hidden" name="mimeTypeId" value="image/jpeg"/>
           		<span class="tourBtn rg-modified"><input type="file" value="选择文件" name="uploadedFile"/></span>  
            	<span class="tourBtn rg-modified"><input type="submit" value="上传" id="button_5" /></span> 
            	<span class="tourBtn"><input type="button" value="删除" onclick="delurl(5)" /></span> 
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
            <p>1.请按照示例提供二代身份证进行认证，请确保证件上的信息清晰有效，如：姓名、地址、身份证号码；</p> 
            <p>2.请勿提供临时身份证或身份证复印件；</p> 
            <p>3.请确认上传的身份证与营业执照上的法定代表人一致；</p> 
            <p>4.如提供虚假证件进行认证，您的帐号将被关闭。</p> 
            <p><a href="#">帮助</a></p> 
            <p><span style="display:none" id="erroriInfo_5" class="auterror">请上传认证图片</span></p> 
           </div> 
          </div>
          --> 
          <!--  修改 end --> 
          <!-- <span class="tourBtn">
						<input type="button" value="点击上传" onclick='popuUpload(5)' id='button_5'>
					   </span>--> 
          <input type="hidden" name="inputvalue" id="inputvalue_5" must="1" /> 
          <!--   --------------          提示信息内容   --> 
         </div> 
         <input type="hidden" name="tcIdentityId" id="tcIdentityId_6" value="6003" /> 
         <div class="autpost-tit"> 
          <span>*</span> 法定代表人手持身份证背面头部照片： 
			&nbsp; 
         </div>
         <br/> 
         <br/>  
         <div class="autpost-con clearfix"> 

          <div class="autopost-lf">
           <#if partyContentList?has_content>
           		<#assign legpoidPartyContentList = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(partyContentList,Static["org.ofbiz.base.util.UtilMisc"].toMap("partyContentTypeId", "LEGOPID_PHOTO"))/>
           		<#if legpoidPartyContentList?has_content>
           			<#assign legpoidPartyContent = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(legpoidPartyContentList)>
           			<#assign legpoidContent = delegator.findOne("Content",Static["org.ofbiz.base.util.UtilMisc"].toMap("contentId", legpoidPartyContent.contentId),false)/>
           		</#if>
           </#if> 
           <span class="upimgcon"> <span class="uploadingimg"> <img alt="" src="<#if legpoidContent?has_content><@ofbizUrl>img?imgId=${(legpoidContent.dataResourceId)!}</@ofbizUrl></#if>" id="show_url_6" /> <var class="rg-fangda"></var> </span> </span> 
           <#-- 
           <form method="post" enctype="multipart/form-data" action="<@ofbizUrl>upCertificateContentForCompany</@ofbizUrl>"> 
           	<div class="uploading-btn">
           	    <input type="hidden" name="partyId" value="${(userLogin.partyId)!}"/>
        		<input type="hidden" name="dataCategoryId" value="PERSONAL"/>
        		<input type="hidden" name="contentTypeId" value="DOCUMENT"/>
        		<input type="hidden" name="statusId" value="CTNT_PUBLISHED"/>
        		<input type="hidden" name="roleTypeId" value="OWNER"/>
        		<input type="hidden" name="partyContentTypeId" value="LEGOPID_PHOTO"/>
        		<input type="hidden" name="mimeTypeId" value="image/jpeg"/>
           		<span class="tourBtn rg-modified"><input type="file" value="选择文件" name="uploadedFile"/></span>  
            	<span class="tourBtn rg-modified"><input type="submit" value="上传"  id="button_6" /></span> 
            	<span class="tourBtn"><input type="button" value="删除" onclick="delurl(6)" /></span> 
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
            <p>1.请按照示例提供二代身份证进行认证，请确保证件上的信息清晰有效，如：签发机关及有效期；</p> 
            <p>2.请勿提供临时身份证或身份证复印件；</p> 
            <p>3.请确认上传的身份证与营业执照上的法定代表人一致；</p> 
            <p>4.如提供虚假证件进行认证，您的帐号将被关闭。</p> 
            <p><a href="#">帮助</a></p> 
            <p><span style="display:none" id="erroriInfo_6" class="auterror">请上传认证图片</span></p> 
           </div> 
          </div>
          -->  
          <!--  修改 end --> 
          <!-- <span class="tourBtn">
						<input type="button" value="点击上传" onclick='popuUpload(6)' id='button_6'>
					   </span>--> 
          <input type="hidden" name="inputvalue" id="inputvalue_6" must="1" /> 
          <!--   --------------          提示信息内容   --> 
         </div> 
         <input type="hidden" name="tcIdentityId" id="tcIdentityId_7" value="6004" /> 
         <div class="autpost-tit"> 
          <span>*</span> 联系人手持身份证正面照片：
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
           			<#assign legpoidContent = delegator.findOne("Content",Static["org.ofbiz.base.util.UtilMisc"].toMap("contentId", legpoidPartyContent.contentId),false)/>
           		</#if>
           </#if> 
           <span class="upimgcon"> <span class="uploadingimg"> <img alt="" src="<#if legpoidContent?has_content><@ofbizUrl>img?imgId=${(legpoidContent.dataResourceId)!}</@ofbizUrl></#if>" id="show_url_7" /> <var class="rg-fangda"></var> </span> </span> 
           <#-- 
           <form method="post" enctype="multipart/form-data" action="<@ofbizUrl>upCertificateContentForCompany</@ofbizUrl>"> 
           	<div class="uploading-btn">
           	    <input type="hidden" name="partyId" value="${(userLogin.partyId)!}"/>
        		<input type="hidden" name="dataCategoryId" value="PERSONAL"/>
        		<input type="hidden" name="contentTypeId" value="DOCUMENT"/>
        		<input type="hidden" name="statusId" value="CTNT_PUBLISHED"/>
        		<input type="hidden" name="roleTypeId" value="OWNER"/>
        		<input type="hidden" name="partyContentTypeId" value="CTAPOID_PHOTO"/>
        		<input type="hidden" name="mimeTypeId" value="image/jpeg"/>
           		<span class="tourBtn rg-modified"><input type="file" value="选择文件" name="uploadedFile"/></span>  
            	<span class="tourBtn rg-modified"><input type="submit" value="上传" onclick="popuUpload(7)" id="button_7" /></span> 
            	<span class="tourBtn"><input type="button" value="删除" onclick="delurl(7)" /></span> 
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
            <p>1.请按照示例提供二代身份证进行认证，确保证件上的信息清晰有效，如：姓名、地址、身份证号码</p> 
            <p>2.请勿提供临时身份证或身份证复印件；</p> 
            <p>3.请确认上传的身份证与帐号注册联系人一致；</p> 
            <p>4.如提供虚假证件进行认证，您的帐号将被关闭。</p> 
            <p><a href="#">帮助</a></p> 
            <p><span style="display:none" id="erroriInfo_7" class="auterror">请上传认证图片</span></p> 
           </div> 
          </div>
          -->  
          <!--  修改 end --> 
          <!-- <span class="tourBtn">
						<input type="button" value="点击上传" onclick='popuUpload(7)' id='button_7'>
					   </span>--> 
          <input type="hidden" name="inputvalue" id="inputvalue_7" must="1" /> 
          <!--   --------------          提示信息内容   --> 
         </div> 
         <input type="hidden" name="tcIdentityId" id="tcIdentityId_8" value="6005" /> 
         <div class="autpost-tit"> 
          <span>*</span> 联系人手持身份证反面照片：
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
           			<#assign legpoidContent = delegator.findOne("Content",Static["org.ofbiz.base.util.UtilMisc"].toMap("contentId", legpoidPartyContent.contentId),false)/>
           		</#if>
           </#if> 
           <span class="upimgcon"> <span class="uploadingimg"> <img alt="" src="<#if legpoidContent?has_content><@ofbizUrl>img?imgId=${(legpoidContent.dataResourceId)!}</@ofbizUrl></#if>" id="show_url_8" /> <var class="rg-fangda"></var> </span> </span> 
           <#-- 
           <form method="post" enctype="multipart/form-data" action="<@ofbizUrl>upCertificateContentForCompany</@ofbizUrl>"> 
           	<div class="uploading-btn">
           	    <input type="hidden" name="partyId" value="${(userLogin.partyId)!}"/>
        		<input type="hidden" name="dataCategoryId" value="PERSONAL"/>
        		<input type="hidden" name="contentTypeId" value="DOCUMENT"/>
        		<input type="hidden" name="statusId" value="CTNT_PUBLISHED"/>
        		<input type="hidden" name="roleTypeId" value="OWNER"/>
        		<input type="hidden" name="partyContentTypeId" value="CTAOPID_PHOTO"/>
        		<input type="hidden" name="mimeTypeId" value="image/jpeg"/>
           		<span class="tourBtn rg-modified"><input type="file" value="选择文件" name="uploadedFile"/></span>  
            	<span class="tourBtn rg-modified"><input type="submit" value="上传"  id="button_8" /></span> 
            	<span class="tourBtn"><input type="button" value="删除" onclick="delurl(8)" /></span> 
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
            <p><a href="#">帮助</a></p> 
            <p><span style="display:none" id="erroriInfo_8" class="auterror">请上传认证图片</span></p> 
           </div> 
          </div>
          -->  
          <!--  修改 end --> 
          <!-- <span class="tourBtn">
						<input type="button" value="点击上传" onclick='popuUpload(8)' id='button_8'>
					   </span>--> 
          <input type="hidden" name="inputvalue" id="inputvalue_8" must="1" /> 
          <!--   --------------          提示信息内容   --> 
         </div> 
         <input type="hidden" name="tcIdentityId" id="tcIdentityId_9" value="6006" /> 
         <div class="autpost-tit"> 
          <span>*</span> 公司门头照： 
    		 &nbsp; 
         </div>
         <br/> 
         <br/>  
         <div class="autpost-con clearfix"> 
          <div class="autopost-lf">
           <#if partyContentList?has_content>
           		<#assign legpoidPartyContentList = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(partyContentList,Static["org.ofbiz.base.util.UtilMisc"].toMap("partyContentTypeId", "CORPDOOR_PHOTO"))/>
           		<#if legpoidPartyContentList?has_content>
           			<#assign legpoidPartyContent = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(legpoidPartyContentList)>
           			<#assign legpoidContent = delegator.findOne("Content",Static["org.ofbiz.base.util.UtilMisc"].toMap("contentId", legpoidPartyContent.contentId),false)/>
           		</#if>
           </#if> 
           <span class="upimgcon"> <span class="uploadingimg"> <img alt="" src="<#if legpoidContent?has_content><@ofbizUrl>img?imgId=${(legpoidContent.dataResourceId)!}</@ofbizUrl></#if>" id="show_url_9" /> <var class="rg-fangda"></var> </span> </span> 
           <#-- 
           <form method="post" enctype="multipart/form-data" action="<@ofbizUrl>upCertificateContentForCompany</@ofbizUrl>"> 
           	<div class="uploading-btn">
           	    <input type="hidden" name="partyId" value="${(userLogin.partyId)!}"/>
        		<input type="hidden" name="dataCategoryId" value="PERSONAL"/>
        		<input type="hidden" name="contentTypeId" value="DOCUMENT"/>
        		<input type="hidden" name="statusId" value="CTNT_PUBLISHED"/>
        		<input type="hidden" name="roleTypeId" value="OWNER"/>
        		<input type="hidden" name="partyContentTypeId" value="CORPDOOR_PHOTO"/>
        		<input type="hidden" name="mimeTypeId" value="image/jpeg"/>
           		<span class="tourBtn rg-modified"><input type="file" value="选择文件" name="uploadedFile"/></span>  
            	<span class="tourBtn rg-modified"><input type="submit" value="上传" id="button_9" /></span> 
            	<span class="tourBtn"><input type="button" value="删除" onclick="delurl(9)" /></span> 
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
            <p>1.请提供带有公司名称的门头照（室内室外均可），并确保照片中的公司门牌与营业执照上的公司名称一致。</p> 
            <p>2.照片中请不要进行遮挡，请勿对照片进行涂抹或PS；</p> 
            <p><a href="#">帮助</a></p> 
            <p><span style="display:none" id="erroriInfo_9" class="auterror">请上传认证图片</span></p> 
           </div> 
          </div>
          --> 
          <!--  修改 end --> 
          <!-- <span class="tourBtn">
						<input type="button" value="点击上传" onclick='popuUpload(9)' id='button_9'>
					   </span>--> 
          <input type="hidden" name="inputvalue" id="inputvalue_9" must="1" /> 
          <!--   --------------          提示信息内容   --> 
         </div> 
         <input type="hidden" name="tcIdentityId" id="tcIdentityId_10" value="6007" /> 
         <div class="autpost-con02 clearfix" style="margin-bottom:50px; margin-left:366px;"> 
         <#-- <span><input type="button" class="smallSubmit" value="返回" /></span> -->
         </div> 
         
         
        <#-- 商铺信息 start -->
          <div class="authenticn-cat">
        <b>商铺信息：</b>
       </div>
        <div class="aut-postatta" id="rgPostatta"> 
        
         <div class="autpost-tit">
          <span>*</span>店铺名称：
         </div> 
         <div class="autpost-con"> 
          <span class="marg-r9"> <label>
           <#if (productStore)?exists>
          ${productStore.storeName!}
          </#if>
          </label> </span> 
         </div> 
         
          <div class="autpost-tit">
          <span>*</span>店铺标题：
         </div> 
         <div class="autpost-con"> 
          <span class="marg-r9"> <label>
          <#if (productStore)?exists>
          ${productStore.title!}
          </#if>
          </label> </span> 
         </div> 
         
          <div class="autpost-tit">
          <span>*</span>主营业务：
         </div> 
         <div class="autpost-con"> 
          <span class="marg-r9"> <label>
           <#if (productStore)?exists>
          ${productStore.subtitle!}
          </#if>
          </label> </span> 
         </div> 
         
       <div class="autpost-tit">
          <span>*</span>公司名称：
         </div> 
         <div class="autpost-con"> 
          <span class="marg-r9"> <label>
           <#if (productStore)?exists>
          ${productStore.companyName!}
          </#if>
          </label> </span> 
         </div> 
         
         <div class="autpost-tit">
          <span>*</span>商业类型：
         </div> 
         <div class="autpost-con"> 
          <span class="marg-r9"> <label>
           <#if (ProductStoreCompany)?exists>
          ${ProductStoreCompany.businessType!}
          </#if>
          </label> </span> 
         </div> 
         
         <div class="autpost-tit">
          <span>*</span>创建时间：
         </div> 
         <div class="autpost-con"> 
          <span class="marg-r9"> <label>
           <#if (ProductStoreCompany)?exists>
          ${ProductStoreCompany.createTime!}
          </#if>
          </label> </span> 
         </div>
         
         <div class="autpost-tit">
          <span>*</span>注册地址：
         </div> 
         <div class="autpost-con"> 
          <span class="marg-r9"> <label>
           <#if (ProductStoreCompany)?exists>
          ${ProductStoreCompany.registeredAddress!}
          </#if>
          </label> </span> 
         </div>
         
         <div class="autpost-tit">
          <span>*</span>公司规模：
         </div> 
         <div class="autpost-con"> 
          <span class="marg-r9"> <label>
           <#if (ProductStoreCompany)?exists>
          ${ProductStoreCompany.scaleCompany!}
          
          </#if>
          </label> </span> 
         </div>
         
         <div class="autpost-tit">
          <span>*</span>商铺LOGO：
         </div> 
         <div class="autpost-con"> 
           				<#if (ProductStoreCompany.productStoreLogo)?exists>
                            <br>
                            <a href="<@ofbizContentUrl>${(ProductStoreCompany.productStoreLogo)?if_exists}</@ofbizContentUrl>"
                               target="_blank"><img alt="Category Image" width="200px" height="200px"
                                                    src="<@ofbizContentUrl>${(ProductStoreCompany.productStoreLogo)?if_exists}</@ofbizContentUrl>"
                                                    class="cssImgSmall"/></a>
                        </#if>
         </div>
         
         <div class="autpost-tit">
          <span>*</span>商铺横幅：
         </div> 
         	<div class="autpost-con"> 
						<#if (ProductStoreCompany.productStoreBanner)?exists>
                            
                            <a href="<@ofbizContentUrl>${(ProductStoreCompany.productStoreBanner)?if_exists}</@ofbizContentUrl>"
                               target="_blank"><img alt="Category Image"  width="200px" height="200px"
                                                    src="<@ofbizContentUrl>${(ProductStoreCompany.productStoreBanner)?if_exists}</@ofbizContentUrl>"
                                                    class="cssImgSmall"/></a>
                        </#if>
        	 </div>
         
         </div>
         
        </div> 
    
    
      <#-- 商铺信息 end -->
    
      </div> 
     </div> 
    