<#import "component://sysCommon/webapp//sysCommon//includes//action//jeasyuiButtonMacroLibrary.ftl" as p> 
<#if remarksId?has_content>
			<div id="remarksdiv">
				<textarea name="${remarksId}" id="${remarksId}" rows="2" cols="20" style="padding-left:5px;color:Gray;width:85%"></textarea>
			</div>
</#if>
<#if operationButton?has_content||operationTaskButton?has_content||returnButton?has_content||commonButton?has_content>

   	<div id="toolBarDiv" style="padding:3px">
                  <#if commonButton?has_content>
                  <#list commonButton?replace("}","")?replace("{","")?split(",") as button>
                  <#assign buttonAtts =button?split("|")>
                  <#assign buttonUiLabelName =buttonAtts[0]?replace(" ","")>
                  	<li><a class="${buttonAtts[1]}" href="${buttonAtts[2]}" id="${buttonAtts[0]}"><span>${uiLabelMap[buttonUiLabelName]}</span></a></li>
                  </#list>
                  </#if>
                  <#if operationButton?has_content>
                  <#assign operationButtonNew=operationButton?replace(" ","")?replace("&#123;","")?replace("&#125;","")>
                  <#list operationButtonNew?split(",") as button>
                  <#assign buttonAtts =button?replace(" ","")?split("&#124;")>
                  <#if buttonAtts?size==5>
                  <#assign buttonPermission =buttonAtts[4]>
                  <#if security.hasEntityPermission(buttonPermission?substring(0,buttonPermission?index_of("_")),buttonPermission?substring(buttonPermission?index_of("_"),buttonPermission?length), session)>
	                  <#assign buttonUiLabelName =buttonAtts[0]?replace(" ","")>
	                  <#assign operInfo =buttonAtts[3]?split("-")>
	                 	<@p.juiButton id="${buttonAtts[0]}" value="${buttonAtts[0]}" disabled="disabled" class="${buttonAtts[1]}"
	                 	  target="${operInfo[0]!}" 
	                 	  href="${buttonAtts[2]}" title="${operInfo[1]!}"/>
	                 	 <#-- <div class="datagrid-btn-separator"></div> -->
	               </#if>
	               </#if>
	              </#list>
                  </#if>
                  <!--检测业务专有按钮-需要检测状态 -->
                  <#if operationTaskButton?has_content>
                  <#assign operationTaskButtonNew=operationTaskButton?replace(" ","")?replace("&#123;","")?replace("&#125;","")>
                  <#list operationTaskButtonNew?split(",") as button>
                  <#assign buttonAtts =button?replace(" ","")?split("&#124;")>
                  <#if buttonAtts?size==7>
                  <#assign currentStatuId =buttonAtts[5]>
                  <#assign buttonStatuId =buttonAtts[6]>
                  	<#assign buttonPermission =buttonAtts[4]>
	                  <#if buttonStatuId?index_of(currentStatuId)!=-1>
		                  <#if security.hasEntityPermission(buttonPermission?substring(0,buttonPermission?index_of("_")),buttonPermission?substring(buttonPermission?index_of("_"),buttonPermission?length), session)>
			                  <#assign buttonUiLabelName =buttonAtts[0]?replace(" ","")>
			                  <#assign operInfo =buttonAtts[3]?split("-")>
			                 	<@p.juiButton id="${buttonAtts[0]}" value="${buttonAtts[0]}" disabled="disabled" class="${buttonAtts[1]}"
			                 	  target="${operInfo[0]!}" 
			                 	  href="${buttonAtts[2]}" title="${operInfo[1]!}"/>
			               </#if>
		               </#if>
	               </#if>
	              </#list>
                  </#if>
                  <#if returnButton?has_content>
                   
                     </#if>
   </div>
 
</#if>

