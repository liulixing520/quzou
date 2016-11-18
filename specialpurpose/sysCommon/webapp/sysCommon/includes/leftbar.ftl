<#assign menuName = "OrdersMgrMenu" >
<#if menuName?exists>
	<#assign appModelMenu = Static["org.ofbiz.widget.menu.MenuFactory"].getMenuFromLocation(applicationMenuLocation,menuName,delegator,dispatcher)>
	<#if appModelMenu?exists>
		<#assign menuItems = appModelMenu.getMenuItemList() >
		<#if menuItems?exists>
			<div id="leftNav">
				<ul>
					<#list menuItems as menuItem>
					<#assign menuItemTitle = menuItem.getTitle(context)>
					<#assign menuItemLink = menuItem.getLink().getTarget(context)>
						<li>
					    	<a href="<@ofbizUrl>${menuItemLink}</@ofbizUrl>" >${menuItemTitle}</a>
						</li>
					</#list>
				</ul>
			</div>
		</#if>
	</#if>
</#if>