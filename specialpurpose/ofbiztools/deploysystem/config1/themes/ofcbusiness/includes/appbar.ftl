<#--

-->
<#if (requestAttributes.externalLoginKey)?exists><#assign externalKeyParam = "?externalLoginKey=" + requestAttributes.externalLoginKey?if_exists></#if>
<#if (externalLoginKey)?exists><#assign externalKeyParam = "?externalLoginKey=" + requestAttributes.externalLoginKey?if_exists></#if>
<#assign ofbizServerName = application.getAttribute("_serverId")?default("default-server")>
<#assign contextPath = request.getContextPath()>
<#assign displayApps = Static["org.ofbiz.base.component.ComponentConfig"].getAppBarWebInfos(ofbizServerName, "main")>

<#if userLogin?has_content>
        <div id="main-nav" style="display:none;">
            <h2 class="contracted">${uiLabelMap.CommonApplications}</h2>
            <div id="header-nav" class="clearfix" style="display:none">
                <ul>
                <li><h4>${uiLabelMap.CommonPrimaryApps}</h4></li>
            <#list displayApps as display>
              <#assign thisApp = display.getContextRoot()>
              <#assign permission = true>
              <#assign selected = false>
              <#assign permissions = display.getBasePermission()>
              <#list permissions as perm>
                <#if perm != "NONE" && !security.hasEntityPermission(perm, "_VIEW", session)>
                  <#-- User must have ALL permissions in the base-permission list -->
                  <#assign permission = false>
                </#if>
              </#list>
              <#if permission == true>
                <#if thisApp == contextPath || contextPath + "/" == thisApp>
                  <#assign selected = true>
                </#if>
                <#assign thisApp = StringUtil.wrapString(thisApp)>
                <#assign thisURL = thisApp>
                <#if thisApp != "/">
                  <#assign thisURL = thisURL + "/control/main">
                </#if>
                  <#if layoutSettings.suppressTab?exists && display.name == layoutSettings.suppressTab>
                    <!-- do not display this component-->
                  <#else>
                    <li><a href="${thisURL + externalKeyParam}" <#if uiLabelMap?exists> title="${uiLabelMap[display.description]}">${uiLabelMap[display.title]}<#else> title="${display.description}">${display.title}</#if></a></li>
                  </#if>
              </#if>
            </#list>
                </ul>
                
                <#include "component://ofcbusiness/includes/secondary-appbar.ftl" />
            </div>
        </div>
</#if>

<#if userLogin?has_content && contextPath.contains("/ytcm")>
	<div id="app-navigation">
	  <#if categoryList?has_content>
		  <#list categoryList as cate>
		  		<#--
		  		<h2>${uiLabelMap['${(cate.itemName)!}']}</h2>
		  		-->
			  <ul ref="${(cate.id)!}" style="display:<#if headerItem==cate.id>block<#else>none</#if>;">
			    <li><ul>
			      <#assign findList = delegator.findByAndCache("GlobalTreeItem", {"parentItemId":cate.id, "isLeaf":"ACTION"},["rank"])>
			      <#if findList?has_content>
				      <#list findList as item>
				      		<li<#if leftItem==item.id> class="selected"</#if>><a href="${(item.itemAction)!"#"}">${uiLabelMap['${(item.itemName)!}']}</a></li>
				      </#list>
			      </#if>
			      </ul></li>
			  </ul>
		  </#list>
	  </#if>
	</div>
	<script>
		$('#header-menu ul li').click(function(){
			$(this).siblings().removeClass('selected');
			$(this).addClass('selected');
			var ref = $(this).attr('ref');
			$('#app-navigation ul[ref]').hide();
			$('#app-navigation ul[ref="' + ref  + '"]').show();
		});
	</script>
</#if>