<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
	<title>${parameters.systemName!'一家网'}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<meta name="description" content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">
	<meta name="author" content="Muhammad Usman">

<#if layoutSettings??&&layoutSettings.rtlStyleSheets?has_content>
        <#--layoutSettings.javaScripts is a list of java scripts. -->
        <#list layoutSettings.rtlStyleSheets as rtlStyleSheet>
           <link rel="stylesheet"  href="<@ofbizContentUrl>${rtlStyleSheet}</@ofbizContentUrl>" type="text/css"/>
        </#list>
    </#if>
<#if layoutSettings??&&layoutSettings.styleSheets?has_content>
        <#--layoutSettings.javaScripts is a list of java scripts. -->
        <#list layoutSettings.styleSheets as styleSheet>
           <link rel="stylesheet"  href="<@ofbizContentUrl>${styleSheet}</@ofbizContentUrl>" type="text/css"/>
        </#list>
    </#if>
<#if layoutSettings??&&layoutSettings.javaScripts?has_content>
        <#--layoutSettings.javaScripts is a list of java scripts. -->
        <#list layoutSettings.javaScripts as javaScript>
            <script language="javascript" src="<@ofbizContentUrl>${javaScript}</@ofbizContentUrl>" type="text/javascript"></script>
        </#list>
    </#if>
<#if layoutSettings??&&layoutSettings.userJs?has_content>
        <#--layoutSettings.javaScripts is a list of java scripts. -->
        <#list layoutSettings.userJs as javaScript>
            <script language="javascript" src="<@ofbizContentUrl>${javaScript}</@ofbizContentUrl>" type="text/javascript"></script>
        </#list>
    </#if>

   <!--[if lt IE 8]>
      <link href="/sysCommon/images/bootstrap/oldie.css" rel="stylesheet">
    <![endif]-->
  
  <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/group.css">
  <!--[if lt IE 9]>
    <script src="/sysCommon/images/bootstrap/html5shiv.js"></script>
  <![endif]-->

  <!--[if IE 8]>
    <script src="/sysCommon/images/bootstrap/respond.min.js"></script>
  <![endif]-->
</head>
<body>