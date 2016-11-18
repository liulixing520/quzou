<div  class="accordion" fillSpace="sideBar" >
    <#if (admintreeItems?has_content)>
    	<#list admintreeItems as root>
            <#assign title = "">
            <#if root.itemName?exists>
                <#assign itemName = root.itemName>
                <#assign title = uiLabelMap[itemName]>
            </#if>
            	
            <#if root_has_next>
				<#if root.parentItemId==menuRoot>
							
			
				<div class="accordionHeader">
				<h2><span>Folder</span>${title?js_string}</h2>
				</div>
				<div class="accordionContent" >
					<ul class="tree treeFolder">
						
						<#list admintreeItems as allItem>
                	 	
                	 	<#assign parentId = allItem.parentItemId>
                	 	
                	 	 <#if parentId==root.id>
                	 	 <li><a href="${allItem.urlLocation}"    rel="${allItem.urlLocation}">${uiLabelMap[allItem.itemName]}</a></li>
                	 	 
                	 	  
                	 	 </#if> 
                	 </#list>
						
					</ul>
				</div>
			
			</#if> 
			</#if> 
       	</#list>
	</#if>

</div>