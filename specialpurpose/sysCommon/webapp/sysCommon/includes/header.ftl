<#assign externalKeyParam = "&amp;externalLoginKey=" + requestAttributes.externalLoginKey?if_exists>

<#if (requestAttributes.person)?exists><#assign person = requestAttributes.person></#if>
<#if (requestAttributes.partyGroup)?exists><#assign partyGroup = requestAttributes.partyGroup></#if>
<#assign docLangAttr = locale.toString()?replace("_", "-")>
<#assign langDir = "ltr">
<#if "ar.iw"?contains(docLangAttr?substring(0, 2))>
    <#assign langDir = "rtl">
</#if>
<html lang="${docLangAttr}" dir="${langDir}" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>${layoutSettings.companyName}: <#if (page.titleProperty)?has_content>${uiLabelMap[page.titleProperty]}<#else>${(page.title)?if_exists}</#if></title>
    <#if layoutSettings.shortcutIcon?has_content>
      <#assign shortcutIcon = layoutSettings.shortcutIcon/>
    <#elseif layoutSettings.VT_SHORTCUT_ICON?has_content>
      <#assign shortcutIcon = layoutSettings.VT_SHORTCUT_ICON.get(0)/>
    </#if>
    <#if shortcutIcon?has_content>
      <link rel="shortcut icon" href="<@ofbizContentUrl>${StringUtil.wrapString(shortcutIcon)}</@ofbizContentUrl>" />
    </#if>
    <#if layoutSettings.javaScripts?has_content>
        <#--layoutSettings.javaScripts is a list of java scripts. -->
        <#-- use a Set to make sure each javascript is declared only once, but iterate the list to maintain the correct order -->
        <#assign javaScriptsSet = Static["org.ofbiz.base.util.UtilMisc"].toSet(layoutSettings.javaScripts)/>
        <#list layoutSettings.javaScripts as javaScript>
            <#if javaScriptsSet.contains(javaScript)>
                <#assign nothing = javaScriptsSet.remove(javaScript)/>
                <script src="<@ofbizContentUrl>${StringUtil.wrapString(javaScript)}</@ofbizContentUrl>" type="text/javascript"></script>
            </#if>
        </#list>
    </#if>
    <#if layoutSettings.VT_HDR_JAVASCRIPT?has_content>
        <#list layoutSettings.VT_HDR_JAVASCRIPT as javaScript>
            <script src="<@ofbizContentUrl>${StringUtil.wrapString(javaScript)}</@ofbizContentUrl>" type="text/javascript"></script>
        </#list>
    </#if>
    <#if layoutSettings.styleSheets?has_content>
        <#--layoutSettings.styleSheets is a list of style sheets. So, you can have a user-specified "main" style sheet, AND a component style sheet.-->
        <#list layoutSettings.styleSheets as styleSheet>
            <link rel="stylesheet" href="<@ofbizContentUrl>${StringUtil.wrapString(styleSheet)}</@ofbizContentUrl>" type="text/css"/>
        </#list>
    </#if>
    <#if layoutSettings.VT_STYLESHEET?has_content>
        <#list layoutSettings.VT_STYLESHEET as styleSheet>
            <link rel="stylesheet" href="<@ofbizContentUrl>${StringUtil.wrapString(styleSheet)}</@ofbizContentUrl>" type="text/css"/>
        </#list>
    </#if>
    <#if layoutSettings.rtlStyleSheets?has_content && langDir == "rtl">
        <#--layoutSettings.rtlStyleSheets is a list of rtl style sheets.-->
        <#list layoutSettings.rtlStyleSheets as styleSheet>
            <link rel="stylesheet" href="<@ofbizContentUrl>${StringUtil.wrapString(styleSheet)}</@ofbizContentUrl>" type="text/css"/>
        </#list>
    </#if>
    <#if layoutSettings.VT_RTL_STYLESHEET?has_content && langDir == "rtl">
        <#list layoutSettings.VT_RTL_STYLESHEET as styleSheet>
            <link rel="stylesheet" href="<@ofbizContentUrl>${StringUtil.wrapString(styleSheet)}</@ofbizContentUrl>" type="text/css"/>
        </#list>
    </#if>
    <#if layoutSettings.VT_EXTRA_HEAD?has_content>
        <#list layoutSettings.VT_EXTRA_HEAD as extraHead>
            ${extraHead}
        </#list>
    </#if>
</head>
<#if layoutSettings.headerImageLinkUrl?exists>
  <#assign logoLinkURL = "${layoutSettings.headerImageLinkUrl}">
<#else>
  <#assign logoLinkURL = "${layoutSettings.commonHeaderImageLinkUrl}">
</#if>

<#if person?has_content>
  <#assign userName = person.firstName?if_exists + " " + person.middleName?if_exists + " " + person.lastName?if_exists>
<#elseif partyGroup?has_content>
  <#assign userName = partyGroup.groupName?if_exists>
<#elseif userLogin?exists>
  <#assign userName = userLogin.userLoginId>
<#else>
  <#assign userName = "">
</#if>

<#if defaultOrganizationPartyGroupName?has_content>
  <#assign orgName = " - " + defaultOrganizationPartyGroupName?if_exists>
<#else>
  <#assign orgName = "">
</#if>

<body>
  <div id="wait-spinner" style="display:none">
    <div id="wait-spinner-image"></div>
  </div>
  <div class="page-container">
    <div class="hidden">
      <a href="#column-container" title="${uiLabelMap.CommonSkipNavigation}" accesskey="2">
        ${uiLabelMap.CommonSkipNavigation}
      </a>
    </div>
    <div id="masthead">
      <ul>
        <#if (userPreferences.COMPACT_HEADER)?default("N") == "Y">
          <li class="logo-area">
            <#if shortcutIcon?has_content>
              <a href="<@ofbizUrl>${logoLinkURL}</@ofbizUrl>"><img src="<@ofbizContentUrl>${StringUtil.wrapString(shortcutIcon)}</@ofbizContentUrl>" height="16px" width="16px" alt="" /></a>
            </#if>
          </li>
        <#else>
          <#if layoutSettings.headerImageUrl?exists>
            <#assign headerImageUrl = layoutSettings.headerImageUrl>
          <#elseif layoutSettings.commonHeaderImageUrl?exists>
            <#assign headerImageUrl = layoutSettings.commonHeaderImageUrl>
          <#elseif layoutSettings.VT_HDR_IMAGE_URL?exists>
            <#assign headerImageUrl = layoutSettings.VT_HDR_IMAGE_URL.get(0)>
          </#if>
          <#if headerImageUrl?exists>
            <li class="logo-area"><a href="<@ofbizUrl>${logoLinkURL}</@ofbizUrl>"><img alt="${layoutSettings.companyName}" src="<@ofbizContentUrl>${StringUtil.wrapString(headerImageUrl)}</@ofbizContentUrl>"/></a></li>
          </#if>
          <#if layoutSettings.middleTopMessage1?has_content && layoutSettings.middleTopMessage1 != " ">
            <li>
            <div class="last-system-msg">
            <center>${layoutSettings.middleTopHeader?if_exists}</center>
            <a href="${layoutSettings.middleTopLink1?if_exists}">${layoutSettings.middleTopMessage1?if_exists}</a><br/>
            <a href="${layoutSettings.middleTopLink2?if_exists}">${layoutSettings.middleTopMessage2?if_exists}</a><br/>
            <a href="${layoutSettings.middleTopLink3?if_exists}">${layoutSettings.middleTopMessage3?if_exists}</a>
            </div>
            </li>
          </#if>
        </#if>
      </ul>
      <br class="clear" />
    </div>
