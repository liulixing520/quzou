<link href="/sysCommon/images/css/leftFrame.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="/images/jquery/jquery-1.7.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/js/chili-1.7.pack.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/js/jquery.easing.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/js/jquery.dimensions.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/js/jquery.accordion.js" type="text/javascript"></script>
    
<script language="javascript">
	jQuery().ready(function(){
		jQuery('#navigation').accordion({
			header: '.head',
			navigation1: false, 
			event: 'click',
			fillSpace: true
			,animated: 'bounceslide'
		});
	});
	function changeMenu(menuid){
		$('#navigation li li a').css("background-color","");
		$("#"+menuid+" a").css("background-color","#f9f8e0");
}
</script>
</script>
<div style="height:100%;">
  <ul id="navigation">
  <#if childList?has_content>
	  <#list childList as leftFirstMenu>
	 	 	<li ><a class="head" ><table border="0" cellspacing="0" cellpadding="0">
        		<tr><td width="25"> <img src="/sysCommon/images/jquery-easyui-1.3.3/themes/icons/${leftFirstMenu.icon!'icon-xtgl-xtyhgl'}.png" width="16" height="16" /></td><td>${leftFirstMenu.menuname!}</td></tr>
           		</table>
           	</a>
      	<ul>
	  		<#assign leftSecMenus=leftFirstMenu.menus>
			<#list leftSecMenus as leftSecMenu>
				<li id='${leftSecMenu.menuid!}' onclick="changeMenu('${leftSecMenu.menuid!}')"><a href="<@ofbizUrl>${leftSecMenu.url!}</@ofbizUrl>" target="mainFrame"><span>${leftSecMenu.menuname!}</span></a></li>
			</#list>
	  	</ul>
	  	</li>
	  </#list>
  </#if>
  
  <#-- 
  	<#if leftFirstMenus?has_content>
  		<#list leftFirstMenus as leftFirstMenu>
	  	<li ><a class="head" ><table border="0" cellspacing="0" cellpadding="0">
        		<tr><td width="25"> <img src="/sysCommon/images/jquery-easyui-1.3.3/themes/icons/${leftFirstMenu.icon!'icon-xtgl-xtyhgl'}.png" width="16" height="16" /></td><td>${leftFirstMenu.itemName!}</td></tr>
           		</table>
           	</a>
      	<ul>
	  	<#assign leftSecMenus=delegator.findByAnd("MenuTree",{"parentItemId",leftFirstMenu.id})?if_exists>
			<#list leftSecMenus as leftSecMenu>
				<li><a href="<@ofbizUrl>${leftSecMenu.urlLocation!}</@ofbizUrl>" target="mainFrame"><span>${leftSecMenu.itemName!}</span></a></li>
			</#list>
	  	</ul>
	  	</li>
	  	</#list>
  	</#if>
    -->
  </ul>
</div>