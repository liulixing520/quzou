<div class="panel panel-default">
      <div class="panel-body">
        <div class="list-group-block">
			<#if childList?has_content>
				<#list childList as leftFirstMenu>
					 <div class="list-group-panel">
						<div class="list-group-heading">${leftFirstMenu.menuname!}</div>
						<ul class="list-group">
  							<#assign leftSecMenus=leftFirstMenu.menus>
							<#list leftSecMenus as leftSecMenu>
								<#assign url = request.getPathInfo()>
								<#assign url = url.substring(url.indexOf("/")+1)>
  								<a class="list-group-item <#if leftSecMenu.url == url>menuActive</#if>" href="<@ofbizUrl>${leftSecMenu.url!}</@ofbizUrl>"> ${leftSecMenu.menuname!}</a>
  							</#list>
						</ul>
					</div>	
				</#list>
  			</#if>	
        </div>
      </div>
    </div>  
