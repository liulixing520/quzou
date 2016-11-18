<link rel="stylesheet" href="/portal/images/css/registe.css" type="text/css">
<div class="page" style="margin-top:20px;margin-bottom:-40px;min-height:499px;">
    <form method="post" action="<@ofbizUrl>forgotpassword${previousParams!}</@ofbizUrl>" id="getpasswordform" name="getpasswordform">
        <div class="form-head">
        	<a href="<@ofbizUrl>main</@ofbizUrl>"><img src="../images/logo-1x.png" /></a>
            <h2 style="margin-bottom:10px">${uiLabelMap.CommonForgotYourPassword}</h2>

            <div style="padding-top:22px;">${uiLabelMap.PortalJoin2}？<a href="<@ofbizUrl>login</@ofbizUrl>">${uiLabelMap.PortalLogin}</a></div>
        </div>
        <br/>
        <div class="form-detail" style="padding-top:50px;">
            ${screens.render("component://common/widget/CommonScreens.xml#EventMessages")}
            <div style="clear:both;"></div>
            <table>
                <tr>
                    <th style="font-weight:100;"><span style="color:red;">*</span> ${uiLabelMap.CommonUsername}：</th>
                    <td>
                        <input class="redborder" type="text"
                               id="forgotpassword_userName" name="USERNAME"
                               value="<#if requestParameters.USERNAME?has_content>${requestParameters.USERNAME}<#elseif autoUserLogin?has_content>${autoUserLogin.userLoginId}</#if>">
                    </td>
                </tr>
            </table>
            <div class="submit-box" style="padding-left:240px;">
                <#--<input name="GET_PASSWORD_HINT" class="ui-button ui-button-primary ui-button-large" value="${uiLabelMap.CommonGetPasswordHint}" tabindex="8" type="submit">-->
                <input name="EMAIL_PASSWORD" class="ui-button ui-button-primary ui-button-large" value="${uiLabelMap.CommonEmailPassword}" tabindex="8" type="submit">
            </div>
        </div>
    </form>
    <div style="clear:both;"></div>
</div>

<div style="clear:both;"></div>

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