<div class="panel-heading">
	 ${titleProperty!}
	<div style='float:right;padding-right:13px;'>
		<#import "component://sysCommon/webapp//sysCommon//includes//action//jeasyuiButtonMacroLibrary.ftl" as p> 
		<#if operationButton?has_content||commonButton?has_content>
		
		  
		  <#if operationButton?has_content>
		      <#list operationButton as button>
		      <#assign buttonAtts =button?replace(" ","")?split(".")> 
			      <#if buttonAtts?size==5> 
			      <#assign buttonPermission =buttonAtts[4]>
			      <#assign hasPersonssion=Static["org.extErp.sysCommon.util.OfbizExtUtil"].hasPermission(buttonPermission,security,userLogin)>
				      <#if  hasPersonssion>
				          <#assign buttonUiLabelName =buttonAtts[0]?replace(" ","")>
				          <#assign operInfo =buttonAtts[3]?split("-")>
				         	 <@htmlTemplate.juiButton id="${buttonAtts[0]}" value="${buttonAtts[0]}" disabled="disabled" class="${buttonAtts[1]}"
				         	  target="${operInfo[0]!}" 
				         	  href="${buttonAtts[2]}" title="${operInfo[1]!}"/>
				       </#if>
			       </#if>
		      </#list>
		</#if>
		</#if>
	</div>
</div>	