<head>
    <#if layoutSettings?has_content&&layoutSettings.styleSheets?has_content>
        <#--layoutSettings.styleSheets is a list of style sheets. So, you can have a user-specified "main" style sheet, AND a component style sheet.-->
        <#list layoutSettings.styleSheets as styleSheet>
            <link rel="stylesheet" href="<@ofbizContentUrl>${styleSheet}</@ofbizContentUrl>" type="text/css"/>
        </#list>
    <#else>
    <!--
        <link rel="stylesheet" href="<@ofbizContentUrl>/images/maincss.css</@ofbizContentUrl>" type="text/css"/>
    -->
    </#if>
    <#if layoutSettings?has_content&&layoutSettings.rtlStyleSheets?has_content && langDir?has_content&&langDir == "rtl">
        <#--layoutSettings.rtlStyleSheets is a list of rtl style sheets.-->
        <#list layoutSettings.rtlStyleSheets as styleSheet>
            <link rel="stylesheet" href="<@ofbizContentUrl>${styleSheet!}</@ofbizContentUrl>" type="text/css"/>
        </#list>
    </#if>
   
 </head>   
 
<div class="pageContent" id="pageContent">
<!--
	<h2 class="contentTitle">&nbsp;&nbsp; <#if labelTitleProperty?has_content>${uiLabelMap[labelTitleProperty]}</#if></h2>
-->