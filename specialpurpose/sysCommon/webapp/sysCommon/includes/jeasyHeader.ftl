<!DOCTYPE html>
<html lang="en">
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

