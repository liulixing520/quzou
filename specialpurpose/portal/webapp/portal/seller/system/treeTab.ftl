<div  class="accordion" fillSpace="sideBar" >
    <#if (admintreeItems?has_content)>
    	<#list admintreeItems as root>
            <#assign title = "">
            <#if root.itemName?exists>
                <#assign itemName = root.itemName>
                <#assign title = uiLabelMap[itemName]>
            </#if>
            	
			<#if root.parentItemId==menuRoot>
				 <#--  <#if root.permission?has_content&&security.hasPermission(root.permission, session)> -->
					<div class="accordionHeader">
						<h2><span>Folder</span>${title?js_string}</h2>
					</div>
					<div class="accordionContent" >
						<ul class="tree treeFolder">
						<#assign childrenItems = Static["org.ofbiz.iteamgr.system.ShopMenuHelper"].getChildrenMenu(delegator,root.id)>	
							<#list childrenItems as allItem>
	                	 	
	                	 	<#assign parentId = allItem.parentItemId>
	                	 	
	                	 	 <#if parentId==root.id>
		                	<#--  	 <#if allItem.permission?has_content&&security.hasPermission(allItem.permission, session)>  -->
		                	 	 	<li><a href="${allItem.urlLocation}"  rel="${allItem.urlLocation}">${uiLabelMap[allItem.itemName]}</a></li>
		                	 <#-- 	 </#if>  -->
	                	 	 </#if> 
	                	 </#list>
						</ul>
					</div>
			 	 <#-- </#if> -->
			</#if> 
       	</#list>
	</#if>

</div>