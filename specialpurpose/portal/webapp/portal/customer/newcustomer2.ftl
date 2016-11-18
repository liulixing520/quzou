  <script src="../product/js/jquery.js" type="text/javascript"></script>
  <script type="text/javascript">
	function searchGeo(obj,num){
        geoId=jQuery("#"+obj+"  option:selected").val();
        var htmls=""
		if(geoId!="" && geoId!=null){
			jQuery.ajax({
            	url: 'search_geo_reg',
            	async: false,
            	type: 'POST',
            	data: "geoId="+geoId,
            	success: function(data) {
            		if(data.length>0){
            			objs=eval('(' + data + ')');
            			for(var p in objs){
            				htmls=htmls+"<option value="+objs[p].geoId+">"+objs[p].geoName+"</option>";
            			}
            			if(num==2){
            				$("#city").html("<option value=''> 请选择市</option>"+htmls);
            				$("#county").html("<option value=''> 请选择市</option>");
            			}
            			if(num==3){
            				$("#county").html("<option value=''> 请选择市</option>"+htmls);
            			}
            		}else{
            			if(num==2){
            				$("#city").html("<option value=''> 请选择市</option>");
            				$("#county").html("<option value=''> 请选择市</option>");
            			}
            			if(num==3){
            				$("#county").html("<option value=''> 请选择市</option>");
            			}
            		}

            	}
        	});
		}
		

	}
  </script>
<link rel="stylesheet" href="/portal/images/css/registe.css" type="text/css">
<div class="page" style="margin-top:20px;margin-bottom:-40px;min-height:499px;">
    <form method="post" action="<@ofbizUrl>createcustomer${previousParams!}</@ofbizUrl>" id="newuserform" name="newuserform">
        <input type="hidden" name="usePrimaryEmailUsername" value="Y">
        <input type="hidden" name="USE_ADDRESS" value="false">
        <input type="hidden" name="emailProductStoreId" value="${productStoreId!}"/>
        <div class="form-head" style="height:55px;">
        	<a href="<@ofbizUrl>main</@ofbizUrl>" style="float:left;"><img src="../images/logo-1x.png" style="border:none;"/></a>
            <h2 style="float:left; line-height:35px;">${uiLabelMap.PortalJoin1}</h2>
            <div style="margin-top:20px;">${uiLabelMap.PortalJoin2}？<a href="<@ofbizUrl>login</@ofbizUrl>">${uiLabelMap.PortalLogin}</a></div>
        </div>
        <br/>
        <div class="form-detail" style="float:left; width;900px;">
            <table>
                <tr>
                    <th style="font-weight:100;"><span style="color:red;">*</span> ${uiLabelMap.PortalJoin3}：</th>
                    <td>
                        <input id="CUSTOMER_EMAIL" class="redborder" type="text" maxlength="128" name="CUSTOMER_EMAIL"
                               value="${requestParameters.CUSTOMER_EMAIL?if_exists}">
                        <div id="email-tip" class="tip">
                            <div class="tip-board hide"><span class="tip-arrow"></span></div>
                            <div class="tip-success hide"></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th style="font-weight:100;"><span style="color:red;">*</span> ${uiLabelMap.PortalJoin4}：</th>
                    <td>
                        <input id="PASSWORD" class="redborder" type="password" maxlength="20" autocomplete="off"
                               name="PASSWORD" value="">
                        <div id="password-tip" class="tip">
                            <div class="tip-board hide"><span class="tip-arrow"></span></div>
                            <div class="tip-success hide"></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th style="font-weight:100;"><span style="color:red;">*</span> ${uiLabelMap.PortalJoin5}：</th>
                    <td>
                        <input id="CONFIRM_PASSWORD" class="redborder" type="password" autocomplete="off" maxlength="20"
                               name="CONFIRM_PASSWORD" value="" onpaste="return false">
                        <div id="password-confirm-tip" class="tip">
                            <div class="tip-board hide"><span class="tip-arrow"></span></div>
                            <div class="tip-success hide"></div>
                        </div>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <th style="font-weight:100;"><span style="color:red;">*</span> 姓名：</th>
                    <td style="width:300px;"><input name="USER_FIRST_NAME" id="USER_FIRST_NAME" type="text" class="redborder first-name"
                               placeholder="姓名" maxlength="128"
                               value="${requestParameters.USER_FIRST_NAME?if_exists}" style="float:left;">
                        <input name="USER_LAST_NAME" id="USER_LAST_NAME" type="text" class="redborder last-name"
                            placeholder="Last name (姓)" maxlength="128"
                            value=" " style="display:none;float:left; margin-left:10px;">

                        <div id="first-name-tip" class="tip">
                            <div class="tip-board hide"><span class="tip-arrow"></span><p></p></div>
                            <div class="tip-success hide"></div>
                        </div>
                        <div id="last-name-tip" class="tip">
                            <div class="tip-board hide"><span class="tip-arrow"></span><p></p></div>
                            <div class="tip-success hide"></div>
                        </div>
                    </td>
                </tr>
<#--                <tr>
                    <th style="font-weight:100;"> 所在地区：</th>
                    <td style="width:300px;">
                        <select name="geo_china" id="province" style="height:35px; width:80px; border:1px solid #ccc;" onchange="searchGeo(this.id,2);">
                            <option value=""> 请选择省</option>
                            <#if geoList?has_content>
                            	<#list geoList as geo>
                            		<option value="${geo.geoId!}">${geo.geoName!}</option>
                            	</#list>
                            </#if>
                        </select>
                        <select name="geo_china2" id="city" style="height:35px; width:100px; border:1px solid #ccc;" onchange="searchGeo(this.id,3);">
                            <option value=""> 请选择市</option>
                        </select>
                        <select name="GEO_COUNTY_ID" style="height:35px; width:100px; border:1px solid #ccc;" id="county">
                            <option value=""> 请选择小区</option>
                        </select>
                    </td>
                </tr>-->
            </table>
            <div class="submit-box" style="padding-left:180px;">
                <input id="submit-btn" class="ui-button ui-button-primary ui-button-large" value=" ${uiLabelMap.PortalJoin15} " tabindex="8" type="submit">
            </div>
        </div>
        <div class=""
             style="float:right; width:400px; padding-top:50px;">${screens.render("component://common/widget/CommonScreens.xml#EventMessages")}</div>
        <div style="clear:both;"></div>
    </form>
    <div style="clear:both;"></div>
</div>
<#assign nowTimestamp = Static["org.ofbiz.base.util.UtilDateTime"].nowTimestamp()>

<div class="content-bottom" style="padding-top:25px; min-width:990px;*min-width:1200px;min-width:1200px\0;">
    <div class="website-intro-main">
    <#--    
    <font>
            <P><a href="#">${uiLabelMap.PortalOnSite}</a> | <a href="#">${uiLabelMap.PortalPrivacyPolicy}</a> | <a
                    href="#">${uiLabelMap.PortalTermsOfUse}</a> | <a href="#">${uiLabelMap.PortalSellerPlatform}</a></P>
            <P>${uiLabelMap.Portalbanquan} Copyright (C) 2014-${nowTimestamp?string("yyyy")}, All Rights Reserved</p>
        </font>
        -->
        <font>
            <P>${uiLabelMap.PortalOnSite} | ${uiLabelMap.PortalPrivacyPolicy} | 
                    ${uiLabelMap.PortalTermsOfUse} | ${uiLabelMap.PortalSellerPlatform}</P>
            <P>${uiLabelMap.Portalbanquan}</p>
        </font>
    </div>
</div>