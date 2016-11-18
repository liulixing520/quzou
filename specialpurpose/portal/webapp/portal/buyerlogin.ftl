
<link rel="stylesheet" href="/portal/images/css/registe.css" type="text/css">
<div class="page" style="margin-top:20px;margin-bottom:-40px;min-height:499px;">
    <form method="post" action="<@ofbizUrl>login</@ofbizUrl>" name="loginform">
        <input type="hidden" name="JavaScriptEnabled" value="Y"/>

        <div class="form-head" style="height:55px;">
            <a href="<@ofbizUrl>main</@ofbizUrl>" style="float:left;"><img src="../images/logo-1x.png" style="border:none;"/></a>

            <h2 style="margin-bottom:10px; float:left;">${uiLabelMap.PortalLogin}</h2>

            <div style="padding-top:22px;">${uiLabelMap.PortalJoin0}？<a
                    href="/portal/control/joinFree">${uiLabelMap.PortalRegister}</a></div>
        </div>
        <div class="form-detail" style="padding-top:50px;">
            <#if requestParameters.USERNAME?has_content>
                <#include "component://common/webcommon/includes/messages.ftl"/>
            </#if>
            <table>
                <tr>
                    <th>
                        <span style="color:red;">*</span>
                    ${uiLabelMap.CommonUsername}：
                    </th>
                    <td>
                        <input type="text" id="userName" name="USERNAME"
                               value="<#if requestParameters.USERNAME?has_content>${requestParameters.USERNAME}<#elseif autoUserLogin?has_content>${autoUserLogin.userLoginId}</#if>"/>
                    </td>
                </tr>
            <#if autoUserLogin?has_content>
                <p>(${uiLabelMap.CommonNot} ${autoUserLogin.userLoginId}? <a
                        href="<@ofbizUrl>${autoLogoutUrl}</@ofbizUrl>">${uiLabelMap.CommonClickHere}</a>)</p>
            </#if>
                <tr>
                    <th>
                        <span style="color:red;">*</span>
                    ${uiLabelMap.CommonPassword}：
                    </th>
                    <td>
                        <input type="password" id="password" name="PASSWORD" value=""/>
                    </td>
                </tr>
            </table>
            <div class="submit-box" style="padding-left:270px;float:left;">
                <input id="submit-btn" class="ui-button ui-button-primary ui-button-large"
                       value=" ${uiLabelMap.CommonLogin} " tabindex="8"
                       type="submit">
            </div>
            <div style="margin-left:20px;float:left;padding-top: 30px;padding-bottom:8px;">
                <a href="<@ofbizUrl>getPassword</@ofbizUrl>">${uiLabelMap.CommonForgotYourPassword}</a>
            </div>
        </div>
        <div style="clear:both;"></div>
    </form>
    <div style="clear:both;"></div>
</div>

<#--<div class="screenlet">
  <div class="screenlet-title-bar"><h3>${uiLabelMap.CommonForgotYourPassword}</h3></div>
  <div class="screenlet-body">
  <form method="post" action="<@ofbizUrl>forgotpassword</@ofbizUrl>" class="horizontal">
    <div>
      <label for="forgotpassword_userName">${uiLabelMap.CommonUsername}</label>
      <input type="text" id="forgotpassword_userName" name="USERNAME" value="<#if requestParameters.USERNAME?has_content>${requestParameters.USERNAME}<#elseif autoUserLogin?has_content>${autoUserLogin.userLoginId}</#if>"/>
    </div>
    <div class="buttons">
      <input type="submit" class="button" name="GET_PASSWORD_HINT" value="${uiLabelMap.CommonGetPasswordHint}"/>
      <input type="submit" class="button" name="EMAIL_PASSWORD" value="${uiLabelMap.CommonEmailPassword}"/>
    </div>
  </form>
  </div>
</div>-->
<#--    
<div class="screenlet">
  <h3>${uiLabelMap.CommonNewUser}</h3>
  <form method="post" action="<@ofbizUrl>newcustomer</@ofbizUrl>">
    <div>
      <label for="newcustomer_submit">${uiLabelMap.CommonMayCreateNewAccountHere}:</p>
      <input type="submit" class="button" id="newcustomer_submit" value="${uiLabelMap.CommonMayCreate}"/>
    <div>
  </form>
</div>
-->
<div class="endcolumns">&nbsp;</div>

<script language="JavaScript" type="text/javascript">
    <#if autoUserLogin?has_content>document.loginform.PASSWORD.focus();</#if>
    <#if !autoUserLogin?has_content>document.loginform.USERNAME.focus();</#if>
</script>
<div style="clear:both;"></div>
<#--${screens.render("component://portal/widget/CommonScreens.xml#footer")}-->

<#assign nowTimestamp = Static["org.ofbiz.base.util.UtilDateTime"].nowTimestamp()>

<div class="content-bottom" style="padding-top:25px; min-width:990px;*min-width:1200px;min-width:1200px\0;">
<div class="website-intro-main">
    <font>
    <P><a href="#">${uiLabelMap.PortalOnSite}</a> | <a href="#">${uiLabelMap.PortalPrivacyPolicy}</a> | <a
            href="#">${uiLabelMap.PortalTermsOfUse}</a> | <a href="#">${uiLabelMap.PortalSellerPlatform}</a></P>
    <P>${uiLabelMap.Portalbanquan} Copyright (C) 2014-${nowTimestamp?string("yyyy")}, All Rights Reserved</p>
    </font>
</div>
</div>