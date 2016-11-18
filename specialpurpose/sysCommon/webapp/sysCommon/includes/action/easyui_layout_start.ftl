
<#-- <@htmlTemplate.navTitle titleProperty/>  -->
<div class="navTitle" style="position:fixed;"><div style="float:left;">位置：${titleProperty!}</div>
	<div style="float:right;">
		<#import "component://sysCommon/webapp//sysCommon//includes//action//jeasyuiButtonMacroLibrary.ftl" as p> 
		<#if operationButton?has_content||commonButton?has_content>
		
		  <#if commonButton?has_content>
		  <#list commonButton?replace("}","")?replace("{","")?split(",") as button>
		  <#assign buttonAtts =button?split("|")>
		  <#assign buttonUiLabelName =buttonAtts[0]?replace(" ","")>
		  	<li><a class="${buttonAtts[1]}" href="${buttonAtts[2]}" id="${buttonAtts[0]}"><span>${uiLabelMap[buttonUiLabelName]}</span></a></li>
		  </#list>
		  </#if>
		  <@htmlTemplate.operButton operationButton/>
		</#if>
	</div>
</div>
<div class="search_area" >
<table><tr><td>