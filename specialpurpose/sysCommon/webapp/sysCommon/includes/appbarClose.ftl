<#assign appModelMenu = Static["org.ofbiz.widget.menu.MenuFactory"].getMenuFromLocation(applicationMenuLocation,applicationMenuName,delegator,dispatcher)>
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

<#if appModelMenu.getModelMenuItemByName(headerItem)?exists>
    <div id="app-nav-selected-item">
      ${appModelMenu.getModelMenuItemByName(headerItem).getTitle(context)}
    </div>
</#if>

<#if parameters.portalPageId?has_content && !appModelMenu.getModelMenuItemByName(headerItem)?exists && userLogin?exists>
    <#assign findMap = Static["org.ofbiz.base.util.UtilMisc"].toMap("portalPageId", parameters.portalPageId)>
    <#assign portalPage = delegator.findOne("PortalPage", findMap, true)>
    <#if portalPage?has_content>
      <div id="app-nav-selected-item">
        ${portalPage.portalPageName?if_exists}
      </div>
    </#if>
</#if>

<div id="control-area">
  <ul id="preferences-menu">
    <#if userLogin?exists>
      <#if (userPreferences.COMPACT_HEADER)?default("N") == "Y">
        <li class="collapsed"><a href="javascript:document.setUserPreferenceCompactHeaderN.submit()">&nbsp;</a>
          <form name="setUserPreferenceCompactHeaderN" method="post" action="<@ofbizUrl>setUserPreference</@ofbizUrl>">
            <input type="hidden" name="userPrefGroupTypeId" value="GLOBAL_PREFERENCES"/>
            <input type="hidden" name="userPrefTypeId" value="COMPACT_HEADER"/>
            <input type="hidden" name="userPrefValue" value="N"/>
          </form>
        </li>
      <#else>
        <li class="expanded"><a href="javascript:document.setUserPreferenceCompactHeaderY.submit()">&nbsp;</a>
          <form name="setUserPreferenceCompactHeaderY" method="post" action="<@ofbizUrl>setUserPreference</@ofbizUrl>">
            <input type="hidden" name="userPrefGroupTypeId" value="GLOBAL_PREFERENCES"/>
            <input type="hidden" name="userPrefTypeId" value="COMPACT_HEADER"/>
            <input type="hidden" name="userPrefValue" value="Y"/>
          </form>
        </li>
      </#if>
    </#if>
    <#if userLogin?exists>
      <#if webSiteId?exists && requestAttributes._CURRENT_VIEW_?exists && helpTopic?exists>
        <li><a class="help-link <#if pageAvail?has_content> alert</#if>" href="javascript:lookup_popup2('showHelp?helpTopic=${helpTopic}&amp;portalPageId=${parameters.portalPageId?if_exists}','help' ,500,500);" title="${uiLabelMap.CommonHelp}"></a></li>
      </#if>
      <li><a href="<@ofbizUrl>logout</@ofbizUrl>">${uiLabelMap.CommonLogout}</a></li>
      
    <#else>
      <li><a href="<@ofbizUrl>${checkLoginUrl}</@ofbizUrl>">${uiLabelMap.CommonLogin}</a></li>
    </#if>
    <#if userLogin?exists>
      <#if orgName?has_content>
        <li class="org">${orgName}</li>
      </#if>
      <#if userLogin.partyId?exists>
        <li class="user">${userName}</li>
      <#else>
        <li class="user">${userName}</li>
      </#if>
    </#if>
  </ul>
</div>
</div>
<div class="clear">
</div>

<#if userLogin?exists>
<script type="text/javascript">
  var mainmenu = new DropDownMenu(jQuery('#main-navigation'));
  var appmenu = new DropDownMenu(jQuery('#app-navigation'));
</script>
</#if>
