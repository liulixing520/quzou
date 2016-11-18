<link href="../images/css/product-to-one.css" rel="stylesheet" type="text/css" media="all"/>
<link href="../images/css/product-to-two.css" rel="stylesheet" type="text/css" media="all"/>
<link href="../images/css/product-to-third.css" rel="stylesheet" type="text/css" media="all"/>
<link href="../images/css/translateelement.css" rel="stylesheet" type="text/css" media="all"/>

<link href="../images/css/header-all.css" rel="stylesheet" type="text/css" media="all" />
<!--中文 翻译  -->
<div class="detail-page">
   <div class="en-us">
           <div class="ui-breadcrumb"> 
  	        <a rel="nofollow" href="<@ofbizUrl>main</@ofbizUrl>"><font>${uiLabelMap.PortalHome}</font></a> <span class="divider"><font>&gt;${uiLabelMap.PortalAboutUS}</font></span>
           </div>
   </div>
			<#if aboutus?has_content>
			   ${StringUtil.wrapString(aboutus.longHelpInfo?if_exists)}
			</#if>  
</div>


	
<!-- 登录页面-->
<#include "component://portal/webapp/portal/product/userlogin.ftl" />


