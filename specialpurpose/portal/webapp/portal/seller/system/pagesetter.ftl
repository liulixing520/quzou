<link href="../images/css/product-to-one.css" rel="stylesheet" type="text/css" media="all"/>
<link href="../images/css/product-to-two.css" rel="stylesheet" type="text/css" media="all"/>
<link href="../images/css/product-to-third.css" rel="stylesheet" type="text/css" media="all"/>
<link href="../images/css/translateelement.css" rel="stylesheet" type="text/css" media="all"/>

<link href="../images/css/header-all.css" rel="stylesheet" type="text/css" media="all" />
<!--中文 翻译  -->

<div class="detail-page">
   <div class="en-us">
           <div class="ui-breadcrumb"> 
  	        <a rel="nofollow" href="<@ofbizUrl>main</@ofbizUrl>"><font>${uiLabelMap.PortalHome}</font></a> 
  	        <span class="divider" id="stempforshow">
  	        <font>&gt;
  	        <#assign param = paramTemp?if_exists>
  	        <#if param == "10001">
  	            ${uiLabelMap.PortalAboutUS}
  	        <#elseif param == "10002">
  	            ${uiLabelMap.PortalNewBuyers}
  	        <#elseif param == "10003">
  	            ${uiLabelMap.PortalCommonProblems}
  	        <#elseif param == "10004">
  	            ${uiLabelMap.PortalHelp}
  	        <#elseif param == "10005">
  	            ${uiLabelMap.PortalCustomerService}
  	        <#elseif param == "10006">
  	            ${uiLabelMap.PortalOnSite}
  	        <#elseif param == "10007">
  	            ${uiLabelMap.PortalPrivacyPolicy}
  	        <#elseif param == "10008">
  	            ${uiLabelMap.PortalTermsOfUse}
  	        <#elseif param == "10009">
  	            ${uiLabelMap.PortalSellerPlatform}
  	        </#if>
  	        </font></span>
           </div>
   </div>
			<#if pagesetter?has_content>
			   ${StringUtil.wrapString(pagesetter.longHelpInfo?if_exists)}
			</#if>  
</div>


	
<!-- 登录页面-->
<#include "component://portal/webapp/portal/product/userlogin.ftl" />


