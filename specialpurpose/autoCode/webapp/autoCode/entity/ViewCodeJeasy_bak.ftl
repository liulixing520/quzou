<script language="javascript" src="/images/jquery/jquery-1.7.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/jquery-easyui-1.3.3/jquery.easyui.min-1.3.3.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
   <link rel="stylesheet"  href="/sysCommon/images/css/style.css" type="text/css"/>
   <link rel="stylesheet"  href="/sysCommon/images/jquery-easyui-1.3.3/themes/icon.css" type="text/css"/>
   <link rel="stylesheet"  href="/sysCommon/images/jquery-easyui-1.3.3/themes/default/t_datagrid.css" type="text/css"/>
   <link rel="stylesheet"  href="/sysCommon/images/css/common.css" type="text/css"/>
 <link id="easyuiTheme" rel="stylesheet" href="/sysCommon/images/jquery-easyui-1.3.3/themes/default/easyui.css" type="text/css"></link> 
<div>
<#assign entityTitle=requestAttributes.entityTitle>
<#assign entityName=requestAttributes.parameters.entityName>
<#assign projectName=requestAttributes.parameters.projectName>
<#assign packageName=requestAttributes.parameters.packageName>
<#assign modelName=requestAttributes.parameters.modelName>
<#assign modelNameLower=requestAttributes.modelNameLower>
<#assign entityNameLower=requestAttributes.entityNameLower>
<#assign searchField=requestAttributes.searchField>
<#assign listField=requestAttributes.listField>
<#assign searchFieldMap=requestAttributes.searchFieldMap>
<#assign listFieldMap=requestAttributes.listFieldMap>
<#assign hasSearchAdvanced=requestAttributes.parameters.hasSearchAdvanced>
<#assign searchAdvancedField=requestAttributes.searchAdvancedField>
<#assign searchAdvancedFieldMap=requestAttributes.searchAdvancedFieldMap>
<#assign editField=requestAttributes.editField>
<#assign editFieldMap=requestAttributes.editFieldMap>
<#assign relations=requestAttributes.relations>
<#assign hasDeleteAll=requestAttributes.parameters.hasDeleteAll>
<#assign hasDialog=requestAttributes.parameters.hasDialog>
<#assign hasAdd=requestAttributes.parameters.hasAdd>
<#assign hasEdit=requestAttributes.parameters.hasEdit>
<#assign hasDelete=requestAttributes.parameters.hasDelete>
<#assign hasLookup=requestAttributes.parameters.hasLookup>
<#assign colNum=requestAttributes.parameters.colNum?number>
<#assign isLogicDelete=requestAttributes.parameters.isLogicDelete>
<#assign selectedSubFiled=requestAttributes.parameters.selectedSubFiled?if_exists>

<#assign entityId=''>
<#list requestAttributes.fieldList as field>
	<#if field.isPk == 'Y'><#assign entityId=field.name></#if>
</#list>  
   
<div>
<h2>拷贝代码至项目下后,运行 ant load-demo ||ant start <a href=''>详细说明</a>
<input type="button" value="生成代码文件" onclick="javascript:document.ViewCode.submit();"
</h2>
<form method="post" name="ViewCode" target='_blank' action="<@ofbizUrl>genericCodeFile</@ofbizUrl>" class="basic-form">
<input type="hidden" name="projectName" value="${projectName!}">
<input type="hidden" name="modelNameLower" value="${modelNameLower!}">
<input type="hidden" name="entityName" value="${entityName!}">
<input type="hidden" name="packageName" value="${packageName!}">
<#if relationEntity??><input type="hidden" name="relationEntity" value="${relationEntity!}"></#if>
<div class="easyui-tabs" style="width:1100px;height:550px"> 
<div title="controller.xml" style="padding:10px">
<h2>${projectName}\webapp\${projectName}\WEB-INF\${modelNameLower}-controller.xml<button onclick="copyCode('area1');return false;">复制</button></h2>	
<textarea cols='200' rows='28' name='controlText' id='area1'>
	<!--${entityTitle!}-->
	<request-map uri="Find${entityName}">
		<security https="false" auth="true" />
		<response name="success" type="view" value="Find${entityName}" />
	</request-map>
	<request-map uri="Edit${entityName}">
		<security https="false" auth="true" />
		<response name="success" type="view" value="Edit${entityName}" />
	</request-map>
	<request-map uri="create${entityName}">
		<security https="false" auth="true"/>
		<#if requestAttributes.parameters.hasMultipart.equals("Y")>
		<event type="java" path="${packageName}.${projectName}.${modelNameLower}.${entityName}Events" invoke="create${entityName}" />
	    <response name="success" type="request-redirect-allparam"  value="Find${entityName}"/>
		<#else>
	    <event type="service" invoke="create${entityName}"/>
	    <response name="success" type="request-redirect-allparam"  value="Find${entityName}"/>
	    </#if>
	    <response name="error"  type="view-last"/>
	</request-map>
	<request-map uri="update${entityName}">
	    <security https="false" auth="true"/>
	    <#if requestAttributes.parameters.hasMultipart.equals("Y")>
		<event type="java" path="${packageName}.${projectName}.${modelNameLower}.${entityName}Events" invoke="update${entityName}" />
	    <response name="success" type="request-redirect-allparam"  value="Find${entityName}"/>
		<#else>
	    <event type="service" invoke="update${entityName}"/>
	    <response name="success" type="request-redirect-allparam"  value="Find${entityName}"/>
	    </#if>
	    <response name="error"  type="view-last"/>
	</request-map>
	<request-map uri="delete${entityName}">
	    <security https="false" auth="true"/>
	    <event type="service" invoke="delete${entityName}"/>
	    <response name="success"  type="request-redirect-allparam"  value="Find${entityName}"/>
	    <response name="error"  type="request-redirect"  value="Find${entityName}"/>
	</request-map>
	<!--批量删除${entityTitle!} -->
	<request-map uri="deleteAll${entityName!}">
	    <security https="false" auth="true"/>
	    <event type="service" invoke="deleteAll${entityName!}"/>
	    <response name="success"  type="request-redirect-allparam"  value="Find${entityName}"/>
	    <response name="error"  type="request-redirect"  value="Find${entityName}"/>
	</request-map>
	
	<#if relationEntity??>
	<!--主从结构${entityTitle!}-->
	<request-map uri="Edit${entityName!}And${relationEntity!}">
		<security https="false" auth="true" />
		<response name="success" type="view" value="Edit${entityName!}And${relationEntity!}" />
	</request-map>
	<request-map uri="create${entityName!}And${relationEntity!}">
		<security https="false" auth="true" />
 		<event type="service" invoke="create${entityName!}"/>
		<response name="success" type="request" value="create${relationEntity!}Mutil" />
		<response name="error" type="view-last" value="" />
	</request-map>
	<request-map uri="update${entityName!}And${relationEntity!}">
		<security https="false" auth="true" />
 		<event type="service" invoke="update${entityName!}"/>
		<response name="success" type="request" value="update${relationEntity!}Mutil" />
		<response name="error" type="view-last" value="" />
	</request-map>
	<request-map uri="create${relationEntity!}Mutil">
        <security https="true" auth="true"/>
        <event type="service-multi" path="" invoke="create${relationEntity!}"/>
        <response name="success" type="request" value="Find${entityName!}"/>
        <response name="error" type="view-last" value=""/>
    </request-map>
	<request-map uri="update${relationEntity!}Mutil">
        <security https="true" auth="true"/>
        <event type="service-multi" path="" invoke="createOrUpdate${relationEntity!}"/>
        <response name="success" type="request" value="Find${entityName!}"/>
        <response name="error" type="view-last" value=""/>
    </request-map>
    </#if>
	<#if hasLookup.equals("Y")>
	<request-map uri="Lookup${entityName}">
		<security https="false" auth="true" />
		<response name="success" type="view" value="Lookup${entityName}" />
	</request-map>
	</#if>
	<#if hasSearchAdvanced.equals("Y")> 
	<request-map uri="Find${entityName}Advanced">
	    <security https="false" auth="true"/>
	    <response name="success" type="view" value="Find${entityName}Advanced" />
	</request-map>
	</#if>
	<#if requestAttributes.parameters.listType=="Jeasy">
	<request-map uri="ajaxFind${entityName}">
	    <security https="false" auth="true"/>
	    <event type="groovy" path="component://${projectName}/webapp/${projectName}/WEB-INF/actions/${modelNameLower}/ajaxFind${entityName}.groovy" />
	    <response name="success" type="request" value="json" />
	    <response name="error" type="request" value="json" />
	</request-map>
	</#if>
	<#if requestAttributes.parameters.hasWorkflow=="Y">
	<request-map uri="saveExamin${entityName}">
	 	<security https="false" auth="true"/>
		<event type="service" invoke="saveExamin${entityName!}"/>
		<response name="success" type="request-redirect-allparam" value="Examine${entityName}"/>
    	<response name="error" type="view" value="error"/>
	</request-map>
		<!-- 审批 -->
	<request-map uri="Examine${entityName}">
		<security https="false" auth="true" />
		<response name="success" type="view" value="Examine${entityName}" />
	</request-map>
	<view-map name="Examine${entityName}" type="screen" 
		page="component://${projectName}/widget/${modelName}Screens.xml#Examine${entityName}"/>
	</#if>
	<!--${entityTitle!}-view -->
	<view-map name="Find${entityName}" type="screenjui" 
		page="component://${projectName}/widget/${modelName}Screens.xml#Find${entityName}" />
	<view-map name="Edit${entityName}" type="screenjui" 
		page="component://${projectName}/widget/${modelName}Screens.xml#Edit${entityName}" />
	<#if hasLookup.equals("Y")>
	<view-map name="Lookup${entityName}" type="screen" 
		page="component://${projectName}/widget/${modelName}Screens.xml#Lookup${entityName}"/>
	</#if>
	<#if hasSearchAdvanced.equals("Y")>
	<view-map name="Find${entityName}Advanced" type="screenjui" page="component://${projectName}/widget/${modelName}Screens.xml#Find${entityName}Advanced" />
	</#if>
	<#if relationEntity??>
	<view-map name="Edit${entityName!}And${relationEntity!}" type="screenjui" 
		page="component://${projectName!}/widget/${modelName!}Screens.xml#Edit${entityName!}And${relationEntity!}" />
	</#if>
</textarea>
</div>
<div title="screens.xml" style="padding:10px">
 <h2>${projectName}\widget\${modelName}Screens.xml<button onclick="copyCode('area2');return false;">复制</button></h2>	
<textarea cols='200' rows='28' name='screensText' id='area2'>
	<!--${entityTitle!} -->
	<screen name="Find${entityName}">
		<section>
			<actions>
				<set field="titleProperty" value="${entityTitle!}列表" />
				<set field="pCtx" from-field="parameters" />
				<#if requestAttributes.parameters.listType!="Jeasy">
				<set field="searchAction" value="Find${entityName}" />
				<set field="searchForm" value="Find${entityName}" />
				</#if>
				<#if requestAttributes.parameters.listType=="forms"||requestAttributes.parameters.listType=="ftl">
				<#if hasSearchAdvanced.equals("Y")> 
				<set field="searchAdvanced" value="Find${entityName}Advanced" /><!-- 高级查询 弹出框 -->
				</#if>
				<set field="operationButton[]" value="增加|icon-add|Edit${entityName}|<#if hasDialog.equals("Y")>dialog<#else>href</#if>|${entityName}_ADD" />
				<#if hasDeleteAll.equals("Y")> 
				<set field="operationButton[]" value="删除|icon-remove|deleteAll${entityName}|removeSelected|${entityName}_DELETE" />
				</#if>
				<set field="operationButton[]" value="编辑|icon-edit|Edit${entityName}|editSelected|${entityName}_UPDATE" />
				</#if>
				<#if requestAttributes.parameters.listType=="ftl">
				<set field="viewIndex" from-field="parameters.VIEW_INDEX_1" type="Integer" default-value="0"/>
	            <set field="viewSize" from-field="parameters.VIEW_SIZE_1" type="Integer" default-value="20"/>
	            <service service-name="performFindList" result-map="result">
	                <field-map field-name="inputFields" from-field="parameters"/>
	                <field-map field-name="entityName" value="${entityName}"/>
	            <#if requestAttributes.parameters.isLogicDelete=="Y">
	                <field-map field-name="filterByDate" value="Y"/>
	             </#if>
	                <field-map field-name="orderBy" from-field="parameters.sortField"/>
	                <field-map field-name="viewIndex" from-field="viewIndex" />
	                <field-map field-name="viewSize"  from-field="viewSize"/>
	            </service>
	            <set field="${entityName}List" from-field="result.list"/>
	            <set field="listSize" from-field="result.listSize"/>
	           <#list searchField as field>
						<#assign editFieldType=editFieldMap["editFieldType_"+field]>
					<#if editFieldType=='select'>
				<entity-condition list="${editFieldMap["editFieldRelEntityName_"+field]!}List" entity-name="${editFieldMap["editFieldRelEntityName_"+field]!}"></entity-condition>
					</#if>
				</#list>
				<set field="resultFtl" value="component://${projectName}/webapp/${projectName}/${modelName}/${entityName}_list.ftl" />
				</#if>
				
			</actions>
			<widgets>
				<decorator-screen name="<#if requestAttributes.parameters.listType=="Jeasy">jeasy-decorator<#else>main-decorator</#if>" location="${r"${parameters.sysCommonDecoratorLocation}"}">
					<decorator-section name="body">
						<#if requestAttributes.parameters.listType=="forms">
						<decorator-screen name="FindScreenDecorator" location="${r"${parameters.sysCommonDecoratorLocation}"}">
							<decorator-section name="search-options">
								<include-form name="Find${entityName}" 
									location="component://${projectName}/widget/${modelName}Forms.xml" />
							</decorator-section>
							<decorator-section name="search-results">
								<include-form name="List${entityName}" 
									location="component://${projectName}/widget/${modelName}Forms.xml" />
							</decorator-section>
						</decorator-screen>
						<#else>
						<decorator-screen name="ListResults" location="${r"${parameters.sysCommonDecoratorLocation}"}">
							<decorator-section name="list-results">
							</decorator-section>
						</decorator-screen>
						</#if>
					</decorator-section>
				</decorator-screen>
			</widgets>
		</section>
	</screen>
	
	<#if relationEntity??>
	<screen name="Edit${entityName!}And${relationEntity!}">
		<section>
			<actions>
				<set field="titleProperty" value="编辑${entityTitle}" />
				<set field="${relationEntity!}Id" from-field="parameters.${relationEntity!}Id" />
				<set field="oper" from-field="parameters.oper" />
				<set field="layoutSettings.javaScripts[+0]" value="/sysCommon/images/js/simple_table.js" global="true" /> 
				<entity-one entity-name="${entityName!}" value-field="entity" />
				<set field="currentForm" value="Edit${entityName}"/>
			</actions>
			<widgets>
				<decorator-screen name="main-decorator" location="${'${'}parameters.sysCommonDecoratorLocation}">
					<decorator-section name="body">
						<platform-specific>
				          	<html><html-template location="component://${projectName!}/webapp/${projectName!}/${modelNameLower!}/${entityName!}And${relationEntity!}_edit.ftl"/></html>
				        </platform-specific>
					</decorator-section>
				</decorator-screen>
			</widgets>
		</section>
	</screen>
	</#if>
	
	<#if hasLookup.equals("Y")>
	<screen name="Lookup${entityName}">
		<section>
			<actions>
				<set field="pCtx" from-field="parameters" />
				<set field="queryString" from-field="result.queryString"/>
				<set field="viewIndex" from-field="parameters.VIEW_INDEX" type="Integer" default-value="0"/>
				<set field="viewSize" from-field="parameters.VIEW_SIZE" type="Integer" default-value="20"/>
				<set field="entityName" value="${entityName}"/>
				<set field="searchFields" value="[${entityId}<#list searchField as field>, ${field}</#list>]"/>
			</actions>
			<widgets>
			    <decorator-screen name="LookupDecorator" location="component://common/widget/CommonScreens.xml">
			        <decorator-section name="search-options">
			            <include-form name="lookup${entityName}" location="component://${projectName}/widget/${modelName}Forms.xml"/>
			        </decorator-section>
			        <decorator-section name="search-results">
			            <include-form name="list${entityName}s" location="component://${projectName}/widget/${modelName}Forms.xml"/>
			        </decorator-section>
			    </decorator-screen>
			</widgets>	
		</section>
	</screen>
	</#if>
	<#if hasSearchAdvanced.equals("Y")> 
	<screen name="Find${entityName}Advanced">
		<section>
			<actions>
				<set field="titleProperty" value="" />
				<set field="pCtx" from-field="parameters" />
				<set field="searchAction" value="Find${entityName}" />
				<set field="searchForm" value="Find${entityName}Advanced" />
			</actions>
			<widgets>
				<decorator-screen name="main-decorator" location="${r"${parameters.sysCommonDecoratorLocation}"}">
					<decorator-section name="body">
						<decorator-screen name="FindDialogDecorator" 
								location="${r"${parameters.sysCommonDecoratorLocation}"}">
							<decorator-section name="search-form"> 
								<include-form name="Find${entityName}Advanced" 
									location="component://${projectName}/widget/${modelName}Forms.xml"/> 
							</decorator-section> 
						</decorator-screen>
					</decorator-section>
				</decorator-screen>
			</widgets>
		</section>
	</screen>
	</#if>
	<screen name="Edit${entityName}">
		<section>
			<actions>
				<set field="titleProperty" value="编辑${entityTitle!}" />
				<set field="${entityId}" from-field="parameters.${entityId}" />
				<set field="oper" from-field="parameters.oper" />
				<entity-one entity-name="${entityName}" value-field="entity" />
				<#if requestAttributes.parameters.formsType=="ftl">
					<#list editField as field>
						<#assign editFieldType=editFieldMap["editFieldType_"+field]>
						<#if editFieldType=='select'>
				<entity-condition list="${editFieldMap["editFieldRelEntityName_"+field]!}List" entity-name="${editFieldMap["editFieldRelEntityName_"+field]!}"></entity-condition>
						</#if>
					</#list>
				</#if>
				<set field="currentForm" value="Edit${entityName}"/>  
				<#if requestAttributes.parameters.hasWorkflow=="Y">
				<!--工作流 -->
				
				<!-- 从workeffort中获取workflow相关值和可退回选项 -->
				<script location="component://sysCommon/webapp/sysCommon/WEB-INF/actions/wf/wfRoute.groovy" />
				<set field="parameters.workflowPackageId" from-field="packageId" default-value="WorkFlowPackage.${entityName}.10000" />
				<set field="parameters.workflowProcessId" from-field="processId" default-value="${entityName}WorkFlow" />
				<!-- 获取下一步操作，无workeffort则初始化第一步 -->
				<set field="parameters.workflowActivityId" from-field="activityId"  default-value="${entityName}_StartActivityProcess" />
				<script location="component://sysCommon/webapp/sysCommon/WEB-INF/actions/wf/wfNextOption.groovy" />
				
				<set field="sourceReferenceId" from-field="${entityId}" />
				<script location="component://sysCommon/webapp/sysCommon/WEB-INF/actions/wf/wfExamineTrace.groovy"></script>
				</#if>
			</actions>
			<widgets>
				<decorator-screen name="main-decorator" location="${r"${parameters.sysCommonDecoratorLocation}"}">
					<decorator-section name="body">
					<#if requestAttributes.parameters.formsType=="ftl">
						<platform-specific>
				          	<html><html-template location="component://${projectName}/webapp/${projectName}/${modelNameLower}/${entityName}_edit.ftl"/></html>
				        </platform-specific>
					<#else>
						<decorator-screen name="<#if requestAttributes.parameters.hasWorkflow.equals("Y")>DetailWorkflowScreenDecorator<#else><#if requestAttributes.parameters.hasMultipart.equals("Y")>DetailUploadScreenDecorator<#else>DetailScreenDecorator</#if></#if>" location="${r"${parameters.sysCommonDecoratorLocation}"}">
							<decorator-section name="detail-options">
								<screenlet title="">
									<include-form name="Edit${entityName}" 
									location="component://${projectName}/widget/${modelName}Forms.xml" />
					    		</screenlet>	
							</decorator-section>
						</decorator-screen>
				    </#if>
					</decorator-section>
				</decorator-screen>
			</widgets>
		</section>
	</screen>
	<#if requestAttributes.parameters.hasWorkflow=="Y">
	<screen name="Examine${entityName}">
		<section>
			<actions>
				<set field="titleProperty" value="" />
				<set field="pCtx" from-field="parameters" />
				<set field="searchAction" value="Examine${entityName}" />
				<set field="searchForm" value="Examine${entityName}" />
				
				<set field="workflowProcessId" value="${entityName}WorkFlow" />
				<script location="component://sysCommon/webapp/sysCommon/WEB-INF/actions/wf/wfExamineList.groovy"></script>
			</actions>
			<widgets>
				<decorator-screen name="main-decorator" location="${'$'}{parameters.sysCommonDecoratorLocation}">
					<decorator-section name="body">
						<decorator-screen name="FindScreenDecorator" location="${'$'}{parameters.sysCommonDecoratorLocation}">
							<decorator-section name="search-options">
								<include-form name="Find${entityName}" location="component://${projectName}/widget/${modelName}Forms.xml" />
							</decorator-section>
							<decorator-section name="search-results">
								<include-form name="Examine${entityName}" location="component://${projectName}/widget/${modelName}Forms.xml" />
							</decorator-section>
						</decorator-screen>
					</decorator-section>
				</decorator-screen>
			</widgets>
		</section>
	</screen>
	</#if>
</textarea>
</div>
<!--生成forms代码-->
<div title="forms.xml" style="padding:10px">
<h2>forms.xml [${projectName}\widget\${modelName}Forms.xml]<button onclick="copyCode('area3');return false;">复制</button></h2>	
	<textarea cols='200' rows='28' name='formsText' id='area3'>
	<!--${entityTitle!} -->
<#if hasSearchAdvanced.equals("Y")> 
	<form name="Find${entityName}Advanced" type="single"  style="pageForm"  target="${'${'}searchAction}" default-entity-name="${entityName}">
        <#if searchAdvancedField?has_content>
        <#list searchAdvancedField as field>
     	   <#assign searchFieldType=searchAdvancedFieldMap["searchFieldType_"+field] >
	        <#if searchFieldType.equals("date")>
			<field name="${field}"  title="${searchAdvancedFieldMap["searchFieldDesc_"+field]!}">
				<date-time/>
			</field>
			<#elseif searchFieldType.equals("text")>
			<field name="${field}" title="${searchAdvancedFieldMap["searchFieldDesc_"+field]!}">
				<text-find hide-options="true" />	
			</field>	
			<#elseif searchFieldType.equals("select")>
			<field name="${field}" widget-style="" title="${searchAdvancedFieldMap["searchFieldDesc_"+field]!}">
				<drop-down text-size="30" allow-empty="true"> 
					<entity-options description="" entity-name="${editFieldMap["editFieldRelEntityName_"+field]!}"  key-field-name="${relEntityId!}"></entity-options>
				</drop-down>
			</field>
			<#elseif searchFieldType.equals("lookup")>
			<lookup target-form-name="Lookup${editFieldMap["editFieldRelEntityName_"+field]!}"  ></lookup>
			</#if>
		</#list>
		</#if>
    </form>
</#if>
<#if requestAttributes.parameters.listType=="forms">
	<form name="Find${entityName}" type="single"  style="pageForm" default-table-style="searchContent" target="${'${'}searchAction}" default-entity-name="${entityName}">
		<#list searchSortList as sortIndex> 
		<#assign field=searchSortMap["sort_"+sortIndex]>
		<#assign editFieldType=editFieldMap["editFieldType_"+field]>
		<#assign editFieldRelName=''>
		<#assign required=''>
		<#if editFieldMap["editFieldRequired_"+field]?has_content>
			<#assign required= editFieldMap["editFieldRequired_"+field]>
		</#if>
		<#assign title=''>
		<#if editFieldMap["editFieldDesc_"+field]?has_content>
			<#assign title= editFieldMap["editFieldDesc_"+field]>
		</#if>
		<#if editFieldMap["editFieldRelName_"+field]?has_content>
		<#assign editFieldRelName= editFieldMap["editFieldRelName_"+field]>
		<#assign displayName=''>
		<#assign relEntityId=''>
		    <#list relations as relation>
  			    <#list relation.relEntity as entityFiled>
  			    	<#if entityFiled.name==editFieldRelName>
  			    		<#if entityFiled.description??>
  			    			<#assign displayName=entityFiled.description!>
  			    		<#else>
  			    			<#assign displayName=entityFiled.name!>
  			    		</#if>
  			    	</#if>
  			    	<#if entityFiled.isPk=='Y'&&entityFiled.name==field>
	  			    	<#assign relEntityId=entityFiled.name>
	  			    </#if>
  			    	</#list>
  			    	 <#list relation.relFields as relfield>
						<#if relation.type?has_content&&relation.type=="one"&&field==relfield.fieldName>
							 <#assign relFieldName=relfield.relFieldName>
					 	</#if>
				 </#list>
		    </#list>    	
		</#if>
		<#if editFieldType.equals("date")>
		<field name="${field}"  title="${title!}" position="${searchFieldMap["searchFieldSort_"+field]!}">
			<date-time type="date"/>
		</field>
		<#elseif editFieldType.equals("email")>
		<field name="${field}" widget-style=" email" title="${title!}" position="${searchFieldMap["searchFieldSort_"+field]!}">
			<text />
		</field>
		<#elseif editFieldType.equals("number")>
		<field name="${field}" widget-style=" number" title="${title!}" position="${searchFieldMap["searchFieldSort_"+field]!}">
			<text />
		</field>	
		<#elseif editFieldType.equals("digits")>
		<field name="${field}" widget-style=" digits" title="${title!}" position="${searchFieldMap["searchFieldSort_"+field]!}">
			<text />
		</field>	
		<#elseif editFieldType.equals("select")>
		<field name="${field}" widget-style="" title="${title!}" position="${searchFieldMap["searchFieldSort_"+field]!}">
			<drop-down text-size="30"  allow-empty="true"> 
				<entity-options description="${'$'}${'{'}${editFieldRelName}${'}'}" entity-name="${editFieldMap["editFieldRelEntityName_"+field]!}"  key-field-name="${relFieldName!}"></entity-options>
			</drop-down>
		</field>
		<#elseif editFieldType.equals("lookup")>
		<field name="${field!}" widget-style="${required!}"   title="${title!}" position="${searchFieldMap["searchFieldSort_"+field]!}" >
			<lookup target-form-name="Lookup${editFieldMap["editFieldRelEntityName_"+field]!}"  description-field-name="${editFieldMap["editFieldDesc_"+field]!}" ></lookup>
		</field>
		<#elseif editFieldType.equals("hidden") >
		<field name="articleId" position="${searchFieldMap["searchFieldSort_"+field]!}">
			<hidden />
		</field>
		<#elseif editFieldType.equals("enum")>
		<field name="${field!}" widget-style="${required!}" title="${title!}" position="${searchFieldMap["searchFieldSort_"+field]!}">
			<drop-down allow-empty="true">
				<entity-options entity-name="Enumeration" cache="true" description="${r"${description}"}" key-field-name="enumId">
					<entity-constraint name="enumTypeId" operator="equals" value="${editFieldMap["editEnumType_"+field]}" />
					<entity-order-by field-name="enumId" />
				</entity-options>
			</drop-down>
		</field>
		<#elseif editFieldType.equals("file")>
		<field name="${field}" widget-style="${required!}" title="${title!}" position="${searchFieldMap["searchFieldSort_"+field]!}"><file/></field>
		<#else>
		<field name="${field}" widget-style="${required!}" title="${title!}" position="${searchFieldMap["searchFieldSort_"+field]!}">
			<text-find hide-options="true" />	
		</field>
		</#if>
	</#list> 
	</form>
	<form name="List${entityName}" type="list" list-name="listIt" group-columns="false"   paginate-target="${'${'}searchAction}"
   		default-entity-name="${entityName}" odd-row-style="alternate-row" header-row-style="header-row-2" default-table-style="basic-table hover-bar">
		<actions>
			<service service-name="performFind" result-map="result" result-map-list="listIt">
				<field-map field-name="inputFields" from-field="pCtx" />
				<field-map field-name="entityName" value="${entityName}" />
				<field-map field-name="orderBy" from-field="parameters.sortField" />
			<#if requestAttributes.parameters.isLogicDelete=="Y">
	            <field-map field-name="filterByDate" value="Y"/>
	        </#if>
				<field-map field-name="viewIndex" from-field="viewIndex" />
				<field-map field-name="viewSize" from-field="viewSize" />
			</service>
		</actions>
		<#if requestAttributes.parameters.hasCommSeq.equals("Y")>
		<field name="ids" widget-area-style="groupAll" id-name="groupAll" title=" ">
			<check>
				<option key="${'$'}${'{'}${entityId}${'}'}"  description=" "/>
			</check>
		</field>
		<field name="CommSeq" title="序号">
			<display description="${r"${itemIndex+1+viewSize*viewIndex}"}" ></display>
		</field>
		</#if>
	<#list listSortList as sortIndex> 
		<#assign field=listSortMap["sort_"+sortIndex]>
		<#assign listFieldType=listFieldMap["listFieldType_"+field]?if_exists>
		<#assign listFieldHasSort=listFieldMap["listFieldHasSort_"+field]?if_exists>
		<#assign title=''>
		<#if listFieldMap["listFieldDesc_"+field]?has_content>
			<#assign title= listFieldMap["listFieldDesc_"+field]>
		</#if>
		<#if listFieldMap["listFieldRelName_"+field]?has_content>
		<#assign listFieldRelName= listFieldMap["listFieldRelName_"+field]>
		<#assign displayName=''>
		<#assign relEntityId=''>
		    <#list relations as relation>
  			    <#list relation.relEntity as entityFiled>
  			    	<#if entityFiled.name==listFieldRelName>
  			    		<#if entityFiled.description??>
  			    			<#assign displayName=entityFiled.description!>
  			    		<#else>
  			    			<#assign displayName=entityFiled.name!>
  			    		</#if>
  			    	</#if>
  			    	<#if entityFiled.isPk=='Y'&&entityFiled.name==field>
	  			    	<#assign relEntityId=entityFiled.name>
	  			    </#if>
  			    </#list>
  			     <#list relation.relFields as relfield>
					<#if relation.type?has_content&&relation.type=="one"&&field==relfield.fieldName>
						 <#assign relFieldName=relfield.relFieldName>
				 	</#if>
				 </#list>
		    </#list>    	
		</#if>
		<#if listFieldType?has_content&&listFieldType.equals("date")>
		<field name="${field}" <#if listFieldHasSort.equals("true")>sort-field="true"</#if> title="${title!}" >
			<display />
		</field>
				<#elseif listFieldType?has_content&&listFieldType.equals("number")>
		<field name="${field}" <#if listFieldHasSort.equals("true")>sort-field="true"</#if> title="${title!}" >
			<display />
		</field>
				<#elseif listFieldType.equals("enum")>
		<field name="${field!}"  title="${title!}">
			<display-entity entity-name="Enumeration" cache="true" key-field-name="enumId" description="${r"${description}"}" />
		</field>	
				<#elseif listFieldType.equals("select")||listFieldType.equals("lookup")>
		<field name="${field}"  title="${title!}">
			<display-entity entity-name="${listFieldMap["listFieldRelEntityName_"+field]!}" key-field-name="${relFieldName!}" description="${'$'}${'{'}${listFieldRelName}${'}'}" />
		</field>
				<#else>
		<field name="${field}" <#if listFieldHasSort.equals("true")>sort-field="true"</#if> title="${listFieldMap["listFieldDesc_"+field]!}" >
			<display />
		</field>
			</#if>
		</#list>
		<!-- 
		<field name="view" title="查看" use-when="${'$'}{groovy:security.hasEntityPermission(&amp;quot;${entityName}&amp;quot;, &amp;quot;_VIEW&amp;quot;, session);}" widget-style="btnView">
			<hyperlink also-hidden="false" target-type="plain" <#if hasDialog.equals("Y")>target-window="dialog"</#if> description="查看" target="Edit${entityName}">
				<parameter param-name="${entityId}" />
				<parameter param-name="oper" value="view"/>
			</hyperlink>
		</field>		
		<field name="edit" title="编辑" use-when="${'$'}{groovy:security.hasEntityPermission(&amp;quot;${entityName}&amp;quot;, &amp;quot;_UPDATE&amp;quot;, session);}" widget-style="btnEdit">
			<hyperlink also-hidden="false" target-type="plain" <#if hasDialog.equals("Y")>target-window="dialog"</#if>  description="编辑" target="Edit${entityName}">
				<parameter param-name="${entityId}" />
			</hyperlink>
		</field>
		<field name="delete" title="删除" use-when="${'$'}{groovy:security.hasEntityPermission(&amp;quot;${entityName}&amp;quot;, &amp;quot;_DELETE&amp;quot;, session);}" widget-style="btnDel">
			<hyperlink also-hidden="false" target-type="plain" description="删除" target="delete${entityName}">
				<parameter param-name="${entityId}" />
			</hyperlink>
		</field>
		-->
		<#if requestAttributes.parameters.hasWorkflow.equals("Y")>
		<field name="start" title="启动" widget-style="btnEdit">
			<hyperlink also-hidden="false" 
				target-type="plain" description="启动" target="startCommonWorkFlow">
				<parameter param-name="entityName" value="${entityName}"/>
				<parameter param-name="entityIdName" value="${entityId}"/>
				<parameter param-name="entityIdValue" from-field="${entityId}"/>
				<parameter param-name="workflowProcessServices" value="${entityName}Workflow"/>
				<parameter param-name="areaId" value="10000"/>
			</hyperlink> 
		</field>
		<field name="trace" title="跟踪" widget-style="btnView">
			<hyperlink also-hidden="false" target-type="plain"
				description="跟踪" target="Edit${entityName}">
				<parameter param-name="sourceReferenceId" from-field="${entityId}" />
				<parameter param-name="oper" value="view" />
				<parameter param-name="${entityId}" />
			</hyperlink>
		</field>
		</#if>
	</form>
	</#if>
	<#if requestAttributes.parameters.formsType=="forms">
	<form name="Edit${entityName}" id="${'${'}currentForm}" <#if requestAttributes.parameters.hasMultipart.equals("Y")>type="upload"<#else>type='single'</#if> style="single_table" 
	    default-table-style="basic-table" target="update${entityName}"  default-map-name="entity" default-entity-name="${entityName}">
		<alt-target use-when="entity==null" target="create${entityName}" />
		<field name="${entityId}">
			<hidden />
		</field>
		<#list editSortList as sortIndex> 
			<#assign field=editSortMap["sort_"+sortIndex]>
			<#assign fieldIndex=(sortIndex_index%colNum)+1>
			<#assign editFieldType=editFieldMap["editFieldType_"+field]>
			<#assign editFieldRelName=''>
			<#assign required=''>
			<#if editFieldMap["editFieldRequired_"+field]?has_content>
				<#assign required= editFieldMap["editFieldRequired_"+field]>
			</#if>
			<#assign title=''>
			<#if editFieldMap["editFieldDesc_"+field]?has_content>
				<#assign title= editFieldMap["editFieldDesc_"+field]>
			</#if>
			<#if editFieldMap["editFieldRelName_"+field]?has_content>
			<#assign editFieldRelName= editFieldMap["editFieldRelName_"+field]>
			<#assign displayName=''>
			<#assign relEntityId=''>
			    <#list relations as relation>
	  			    <#list relation.relEntity as entityFiled>
	  			    	<#if entityFiled.name==editFieldRelName>
	  			    		<#if entityFiled.description??>
	  			    			<#assign displayName=entityFiled.description!>
	  			    		<#else>
	  			    			<#assign displayName=entityFiled.name!>
	  			    		</#if>
	  			    	</#if>
		  			    <#if entityFiled.isPk=='Y'&&entityFiled.name==field>
		  			    	<#assign relEntityId=entityFiled.name>
		  			    </#if>
	  			    </#list>
	  			  	 <#list relation.relFields as relfield>
						<#if relation.type?has_content&&relation.type=="one"&&field==relfield.fieldName>
							 <#assign relFieldName=relfield.relFieldName>
					 	</#if>
					 </#list>
			    </#list>    
			    	
			</#if>
		<#if editFieldType.equals("date")>
		<field name="${field}" position='${fieldIndex}' use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}"  required-field="${required!}"  title="${title!}" >
			<text  disabled="true"/>
		</field>
		<field name="${field}" position='${fieldIndex}' use-when="${'$'}{groovy:oper==null}" required-field="${required!}"  title="${title!}">
			<date-time type="date"/>
		</field>
		<#elseif editFieldType.equals("email")>
		<field name="${field}" position='${fieldIndex}' use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}" 
			widget-style="email"   required-field="${required!}" title="${title!}">
			<text  disabled="true"/>
		</field>
		<field name="${field}" position='${fieldIndex}'  use-when="${'$'}{groovy:oper==null}" widget-style="email"   required-field="${required!}" title="${title!}">
			<text />
		</field>
		<#elseif editFieldType.equals("digits")>
		<field name="${field}" position='${fieldIndex}'  use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}" 
			widget-style="digits"  required-field="${required!}" title="${title!}">
			<text  disabled="true"/>
		</field>
		<field name="${field}" position='${fieldIndex}' use-when="${'$'}{groovy:oper==null}" widget-style="digits"    required-field="${required!}" title="${title!}">
			<text />
		</field>
		<#elseif editFieldType.equals("number")>
		<field name="${field}" position='${fieldIndex}' use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}"
			 widget-style="number" required-field="${required!}" title="${title!}">
			<text disabled="true"/>
		</field>
		<field name="${field}" position='${fieldIndex}'  use-when="${'$'}{groovy:oper==null}"  widget-style="number" required-field="${required!}" title="${title!}">
			<text />
		</field>		
		<#elseif editFieldType.equals("select")>
	
		<field name="${field}" position='${fieldIndex}'  widget-style="" title="${displayName!}">
			<drop-down text-size="30"> 
				<entity-options description="${'$'}${'{'}${editFieldMap["editFieldRelName_"+field]!}${'}'}" entity-name="${editFieldMap["editFieldRelEntityName_"+field]!}"  key-field-name="${relFieldName!}"></entity-options>
			</drop-down>
		</field>
		<#elseif editFieldType.equals("lookup")>
		<field name="${field}" position='${fieldIndex}' use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}" widget-style="${required!} " title="${title!}">
			<text disabled="true"/>
		</field>
		<field name="${field!}" position='${fieldIndex}' use-when="${'$'}{groovy:oper==null}" widget-style="${required!}"  title="${title!}" >
			<lookup target-form-name="Lookup${editFieldMap["editFieldRelEntityName_"+field]!}"  description-field-name="${editFieldMap["editFieldRelName_"+field]!}" ></lookup>
		</field>
		<#elseif editFieldType.equals("hidden")>
		<field name="${field}">
			<hidden />
		</field>
		<#elseif editFieldType.equals("enum")>
		
		<field name="${field!}" position='${fieldIndex}' widget-style="${required!}" title="${title!}">
			<drop-down allow-empty="true">
				<entity-options entity-name="Enumeration" cache="true" description="${r"${description}"}" key-field-name="enumId">
					<entity-constraint name="enumTypeId" operator="equals" value="${editFieldMap["editEnumType_"+field]}" />
					<entity-order-by field-name="enumId" />
				</entity-options>
			</drop-down>
		</field>
		<#elseif editFieldType.equals("whether")>
		<field name="${field}" position='${fieldIndex}' use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}" widget-style="${required!} " title="${title!}">
			<text disabled="true"/>
		</field>
		<field name="${field!}" position='${fieldIndex}'  use-when="${'$'}{groovy:oper==null}" widget-style=" ${required!}" title="${title!}">
			<drop-down text-size="30" allow-empty="false" no-current-selected-key="Y">
				<option key="Y" description="${r"${uiLabelMap.CommonYes}"}" />
				<option key="N" description="${r"${uiLabelMap.CommonFalse}"}" />
			</drop-down>
		</field>
		<#elseif editFieldType.equals("file")>
		<field name="${field}" position='${fieldIndex}' use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}" widget-style="${required!} " title="${title!}">
			<text disabled="true"/>
		</field>
		<field name="${field}" position='${fieldIndex}'  use-when="${'$'}{groovy:oper==null}" widget-style="${required!}" title="${title!}"><file/></field>
		<#elseif editFieldType.equals("textarea")>
		<field name="${field}" position='${fieldIndex}'  use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}" title="${title!}"  widget-style="easyui-validatebox"  required-field="${required!}">
			<textarea disabled="true"/>
		</field>
		<field name="${field}" position='${fieldIndex}'  use-when="${'$'}{groovy:oper==null}"  title="${title!}"  widget-style="easyui-validatebox"  required-field="${required!}">
			<textarea />
		</field>
		<#else>
		<field name="${field}" position='${fieldIndex}' use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}"   required-field="${required!}"  title="${title!}" >
			<display/>
		</field>
		<field name="${field}" position='${fieldIndex}' use-when="${'$'}{groovy:oper==null}"    required-field="${required!}"  title="${title!}">
			<text  />
		</field>
		</#if>
	</#list> 
		<#if requestAttributes.parameters.hasMultipart.equals("Y")>	
		<field name="filePath1" position='1' use-when="${'$'}{groovy:(entity!=null);}"
			 title="附件查看">
			 <hyperlink target="getDocUrlByPurpose" target-window="_blank" target-type="plain" 
            	description="${'$'}{groovy:org.extErp.sysCommon.document.DocumentUtils.getDocNameByPurpose(request, &amp;quot;${entityName}&amp;quot;, ${entityId})}">
                 <parameter param-name="sysDocPurposeId" value="${entityName}"/>
                 <parameter param-name="relatedIdValue" value="${'$'}{${entityId}}"/>
            </hyperlink>
		</field>		
		<field name="filePath" title="附件"  use-when="${'$'}{groovy:oper==null}">
			<file></file>
		</field>
		</#if>
	</form>
</#if>
<#if hasLookup.equals("Y")>
	<form name="lookup${entityName}" target="Lookup${entityName}" title="" type="single"
	    header-row-style="header-row" default-table-style="basic-table">
	    <field name="${entityId}" ><text-find/></field>
	    <#list searchField as field>
	    <field name="${field}" ><text-find/></field>
	    </#list>
	    <field name="noConditionFind"><hidden value="Y"/></field>
	    <field name="submitButton" title="查询" widget-style="smallSubmit"><submit button-type="button"/></field>
	</form>
	<form name="list${entityName}s" list-name="listIt" title="" type="list" target="Lookup${entityName}"
	    odd-row-style="alternate-row" default-table-style="basic-table hover-bar">
	    <actions>
	        <service service-name="performFind" result-map="result" result-map-list="listIt">
	            <field-map field-name="inputFields" from-field="parameters"/>
	            <field-map field-name="entityName" value="${entityName}"/>
	            <#if requestAttributes.parameters.isLogicDelete=="Y">
	            <field-map field-name="filterByDate" value="Y"/>
	            </#if>
	        </service>
	    </actions>
	    <field name="${entityId}" widget-style="buttontext">
	        <hyperlink also-hidden="false" target-type="plain" description="${'$'}{${entityId}}" target="javascript:set_value('${'$'}{${entityId}}')"/>
	    </field>
	    <#list searchField as field>
	    	<#assign title=''>
				<#if editFieldMap["editFieldDesc_"+field]?has_content>
					<#assign title= editFieldMap["editFieldDesc_"+field]>
				</#if>		
		<field name="${field}" title="${title!}">
			<hyperlink also-hidden="false" target-type="plain" description="${'$'}{${field}}" target="javascript:set_value('${'$'}{${entityId}}')"/>
		</field>
	    </#list>
	</form>
</#if>
<#if requestAttributes.parameters.hasWorkflow=="Y">
<form name="Examine${entityName}" type="list" list-name="partyWorkEfforts"
		group-columns="false" paginate-target="Examine${entityName}"
		 default-table-style="basic-table hover-bar">
		<row-actions>
			<set field="${entityId}" from-field="sourceReferenceId"/>
			<entity-one entity-name="${entityName}"  value-field="${entityName}"></entity-one>
		</row-actions>
		<field name="sourceReferenceId" sort-field="true" title="数据源ID">
			<display />
		</field>
		
		<field name="workEffortName" sort-field="true" title="任务名称">
			<display />
		</field>
		<field name="route" title="处理" widget-style="btnEdit">
			<hyperlink also-hidden="false" target-type="plain"
				description="处理" target="Edit${entityName}">
				<parameter param-name="workEffortId" />
				<parameter param-name="${entityId}" from-field="sourceReferenceId"/>
				<parameter param-name="sourceReferenceId"/>
			</hyperlink>
		</field>
	</form>
</#if>	
</textarea>
</div>

<#if requestAttributes.parameters.formsType=="ftl"&&!relationEntity??>
 <div title="编辑ftl" style="padding:10px">
  <h2>
	${projectName}/webapp/${projectName}/${modelNameLower}/${entityName}_edit.ftl
	<button onclick="copyCode('editFtlText');return false;">复制编辑FTL</button>
	</h2>	
	<textarea cols='200' rows='28' id='editFtlText' name='editFtlText'>
		<#include "component://webtools/webapp/webtools/entity/ViewCodeJeasyEditFtl.ftl"/>
	</textarea>
	</div>
</#if>

<#if relationEntity??>
<!--主从结构FTL-->
	<div title="主从FTL" style="padding:10px">	
	 <h2>
		${projectName}/webapp/${projectName}/${modelNameLower}/${entityName!}And${relationEntity!}_edit.ftl
		<button onclick="copyCode('editAndFtlText');return false;">复制主从FTL</button>
		</h2>	
		<textarea cols='200' rows='28' id='editAndFtlText' name='editAndFtlText'>
			<#include "component://webtools/webapp/webtools/entity/ViewCodeJeasyEditFtl.ftl"/>
					<div class="button-bar">
						 增加行数: <input type='text' style='width:3%;' value='1' id='rowNum'>
				        <a class="buttontext create" href="#"  onclick="javascript:commonAddRows('${relationEntity!}Table');">批量新增</a>
						<a class="buttontext create" href="#" onclick="javascript:commonDeleteRowAll('${relationEntity!}Table')">批量删除</a>
					</div>
		             
		            <table cellspacing="0" width='100%' id='${relationEntity!}Table' class="basic-table hover-bar">
		    			<tbody>
					    <tr class="header-row">
					    <td width='2%'>选择</td>
					    <td width='2%'>序号</td>
					    <#list subFieldList as entityFiled>
					    	<#list selectedSubFiled as subFiled>
					    	<#if entityFiled.name=subFiled>
						    	<#if entityFiled.isPk != 'Y'&&entityFiled.sqlType!='DATETIME'>
						    	<td width="7%"><#if entityFiled.description??>${entityFiled.description!}<#else>${entityFiled.name!}</#if></td>
						    	</#if>
					    	</#if>
					    	</#list>
					    </#list>
					    <td width='7%'>操作</td>
					    
					    </tr>
					    
						</tbody></table>
				</form>
				 </div> 
				   ${"<"}@htmlTemplate.submitButton formId="${'$'}{currentForm}"  dialogId="${"$"}{parameters.dialogId!}" submitJs="${"$"}{submitJs!}" oper="${"$"}{parameters.oper!}"/>

			</div>
		<script language="JavaScript" type="text/javascript">
		  $(function() { 
		    	${"<"}#if entity??>
		  		//ajax获取从表数据
		  		$.ajax({
						type:"post",
						datatype:"json",
						url:"commonPerformFind?entityName=${relationEntity!}&${entityId}=${'$'}{entity.${entityId}!}",
						cache:false,
						success:function(result){
							if(result.rows){
								for(var i=0;i<result.rows.length;i++){
									insertRows(i,result.rows[i]);
								}
							}
						}
					});	
		  		${"<"}#else>
		    	insertRows('0');
		    	${"<"}/#if>
		    });
		    //复制行-公用行数
			var rowUtil = new RowCopyUtility({tableId: "${relationEntity!}Table",rowGroupNumber: 1});
			var html_entity = new html_entity();
			<#assign subPkEntityId=''>
			<#list subFieldList as field>
				<#if field.isPk == 'Y'><#assign subPkEntityId=field.name></#if>
			</#list> 
		//插入行 
		function insertRows(rowIndex,rowData){
			var str="<tr id='row1_"+rowIndex+"' onmouseover=\"this.style.background='#eaf2ff'\" onmouseout=\"this.style.background=''\">";
			str+="<td align='center'><input type='checkbox' checked name='${subPkEntityId!}_o_"+rowIndex+"'   value='"+((rowData&&rowData.${subPkEntityId!})?rowData.${subPkEntityId!}:'')+"'></td>";
			str+="<td ><input type='text'  size='1' readonly name='rowIndex' value='"+(parseInt(rowIndex)+1)+"'></td>";
			<#list subFieldList as entityFiled>
		    	<#list selectedSubFiled as subFiled>
		    	<#if entityFiled.name=subFiled>
			str+=commonFiledStr({size:10,name:'${subFiled!}',classStyle:'required'},rowIndex,rowData);
				</#if>
				</#list>
			</#list>
			str+="<td ><a href='#' onclick='javascript:copyRows(this);'>复制</a>&nbsp;<a href='#' onclick='javascript:commonDeleteRowsTable(this);'>删除</a>&nbsp;</td>";
			str+="</tr>";
			$("#${relationEntity!}Table tbody:last").append(str);
		}		
		
		//复制行-特殊赋值时使用
		 function copyRows(thisObj) {
		 	var thisIndex= commonGetRowIndexTable(thisObj);
		 	var maxIndex=parseInt(commonGetMaxRowIndex('${relationEntity!}Table'))+1;
		 	var data=[];
		 	<#list subFieldList as entityFiled>
		    	<#list selectedSubFiled as subFiled>
		    	<#if entityFiled.name=subFiled>
		    	commonFiledData("${subFiled!}",thisIndex,data);
				</#if>
				</#list>
			</#list>
		 	insertRows(maxIndex,data);
		    commonRefreshRowNum();
		 }   
		</script>	
		</textarea>
	</div>
</#if>
<#if requestAttributes.parameters.listType=="ftl">
<div title="列表FTL" style="padding:10px">	
 <h2>
	${projectName}/webapp/${projectName}/${modelNameLower}/${entityName}_list.ftl
	<button onclick="copyCode('listFtlText');return false;">复制列表FTL</button>
	</h2>	
	<textarea cols='200' rows='28' id='listFtlText' name='listFtlText'>
	<div class="navTitle">位置：${'$'}{titleProperty!}</div>
	<div class="search_area">
		<table>
			<tr>
				<td>
					<form  id='${'$'}${'{'}searchForm!}' action="${'$'}${'{'}searchAction}" method="post">
						<table class="searchContent">
							<tr>
						<#list searchSortList as sortIndex> 
							<#assign field=searchSortMap["sort_"+sortIndex]>
							<#assign editFieldType=editFieldMap["editFieldType_"+field]>
							<#assign editFieldRelName=''>
							<#assign required=''>
							<#if editFieldMap["editFieldRequired_"+field]?has_content>
								<#assign required= editFieldMap["editFieldRequired_"+field]>
							</#if>
							<#assign title=''>
							<#if editFieldMap["editFieldDesc_"+field]?has_content>
								<#assign title= editFieldMap["editFieldDesc_"+field]>
							</#if>
							<#if editFieldMap["editFieldRelName_"+field]?has_content>
							<#assign editFieldRelName= editFieldMap["editFieldRelName_"+field]>
							<#assign displayName=''>
							<#assign relEntityId=''>
				  			    <#list relations as relation>
					  			    <#list relation.relEntity as entityFiled>
					  			    	<#if entityFiled.name==editFieldRelName>
					  			    		<#if entityFiled.description??>
					  			    			<#assign displayName=entityFiled.description!>
					  			    			<#else>
					  			    			<#assign displayName=entityFiled.name!>
					  			    		</#if>
					  			    	</#if>
					  			    	<#if entityFiled.isPk=='Y'&&entityFiled.name==field>
						  			    	<#assign relEntityId=entityFiled.name>
						  			    </#if>
					  			    	</#list>
					  			    	 <#list relation.relFields as relfield>
											<#if relation.type?has_content&&relation.type=="one"&&field==relfield.fieldName>
												 <#assign relFieldName=relfield.relFieldName>
										 	</#if>
									 </#list>
				  			    </#list>    	
							</#if>
								<td>
							<#if editFieldType.equals("date")>
								${'<#'}assign ${field}="">
								${'<#'}if entity??&&entity.${field}??>${'<#'}assign ${field}=entity.${field}>${'</#'}if>
								${title!}：${'<@'}htmlTemplate.renderDateField name="${field}" title="Format: yyyy-MM-dd" value="${"$"}{queryStringMap.${field}!}"/>
							<#elseif editFieldType.equals("hidden") >
								<input type='hidden' name='${field!}'>
							<#elseif editFieldType.equals("select") >
								${displayName!}：<select name="${field}" class="">
					            	<option value=""></option>
					            		${'<#'}list ${editFieldMap["editFieldRelEntityName_"+field]!}List as relEntity>
					            			<option ${'<#'}if relEntity??&&queryStringMap.${field}??&&relEntity.${relEntityId!}==queryStringMap.${field}>selected ${'<'}/#if>  
					            			value='${"$"}${"{"}relEntity.${relEntityId!}}'>
					            			${"$"}${"{"}relEntity.${editFieldMap["editFieldRelName_"+field]!}}</option>
					            		${'</#list>'}
					            </select>
					        <#elseif editFieldType.equals("enum")>
							 ${'<#'}assign enums = delegator.findByAndCache("Enumeration", {"enumTypeId" :"${editFieldMap["editEnumType_"+field]}" })?if_exists>
								${title!}：<select name="${field}" ><option></option>
					            	${'<#'}if enums?has_content>
					            		${'<#'}list enums as enum> 
					            			<option ${'<#'}if queryStringMap.${field}??&&queryStringMap.${field}==enum.enumId>selected ${'<'}/#if>  value='${"$"}${"{"}enum.enumId!}'>${"$"}${"{"}enum.description!}</option>
					            		${'</#list>'}
					            	${'</#if>'}
					            </select>
							<#else>
							${title!}：<input type="text" name="${field!}" value='${'$'}${'{'}queryStringMap.${field!}!}'/>
								<input type="hidden" value="Y" name="${field!}_ic">
								<input type="hidden" value="contains" name="${field!}_op">
							</#if>
						</#list> 
							</td>
						</tr>
					</table>
				</form>
			</td>	
			<td>
				${'<@'}htmlTemplate.searchButton searchForm/>
			</td>
		</tr>
		</table>
	<div>
		${'<@'}htmlTemplate.operButton operationButton/>
	</div>
</div>

<div class="listheight" style="height:75%; width:100%; overflow-y: auto;">
	

   	<table class="basic-table hover-bar" cellspacing="0" width="100%">
     <thead>
		<tr class='header-row-2'>
			<td width="10%"><input type="checkBox" class="checkboxCtrl" group="ids"></td>
	        <#list listSortList as sortIndex> 
				<#assign field=listSortMap["sort_"+sortIndex]>
				<#assign listFieldType=listFieldMap["listFieldType_"+field]?if_exists>
				<#assign listFieldHasSort=listFieldMap["listFieldHasSort_"+field]?if_exists>
				<#assign title=''>
				<#if listFieldMap["listFieldDesc_"+field]?has_content>
					<#assign title= listFieldMap["listFieldDesc_"+field]>
				</#if>
				<#if listFieldMap["listFieldRelName_"+field]?has_content>
				<#assign listFieldRelName= listFieldMap["listFieldRelName_"+field]>
				<#assign displayName=''>
	  			    <#list relations as relation>
		  			    <#list relation.relEntity as entityFiled>
		  			    	<#if entityFiled.name==listFieldRelName>
		  			    		<#if entityFiled.description??>
		  			    			<#assign displayName=entityFiled.description!>
		  			    			<#else>
		  			    			<#assign displayName=entityFiled.name!>
		  			    		</#if>
		  			    	</#if>
		  			    </#list>
		  			     <#list relation.relFields as relfield>
							<#if relation.type?has_content&&relation.type=="one"&&field==relfield.fieldName>
								 <#assign relFieldName=relfield.relFieldName>
						 	</#if>
						 </#list>
	  			    </#list>    	
				</#if>
	        <td <#if listFieldHasSort.equals("true")>sortField="${field}"</#if>><#if listFieldType.equals("select")> ${title!}<#else>${title!}</#if></td>
	        </#list>	
	        <td >编辑</td>
	        <td >删除</td>
      </tr>
      </thead>
    ${'<#'}if ${entityName}List?exists>
    ${'<#'}if ${entityName}List?has_content>  
    ${'<#'}assign alt_row = false>
    ${'<#'}assign rowCount = 0>
    ${'<#'}list ${entityName}List as entityRow>
      <tr valign="middle"${'<#'}if alt_row> class="alternate-row"${'</#'}if>>
	  <td><input type="checkbox" value="${'$'}${'{'}entityRow.${entityId}!}" name="ids" ></td>
		<#list listField as field>
				<#assign listFieldType=listFieldMap["listFieldType_"+field]?if_exists>
				<#assign listFieldHasSort=listFieldMap["listFieldHasSort_"+field]?if_exists>
				<#assign title=''>
				<#if listFieldMap["listFieldDesc_"+field]?has_content>
					<#assign title= listFieldMap["listFieldDesc_"+field]>
				</#if>
				<#if listFieldMap["listFieldRelName_"+field]?has_content>
				<#assign listFieldRelName= listFieldMap["listFieldRelName_"+field]>
				<#assign displayName=''>
				<#assign relEntityId=''>
	  			    <#list relations as relation>
		  			    <#list relation.relEntity as entityFiled>
		  			    	<#if entityFiled.name==listFieldRelName>
		  			    		<#if entityFiled.description??>
		  			    			<#assign displayName=entityFiled.description!>
		  			    		<#else>
		  			    			<#assign displayName=entityFiled.name!>
		  			    		</#if>
		  			    	</#if>
		  			    	 <#if entityFiled.isPk=='Y'&&entityFiled.name==field>
		  			    		<#assign relEntityId=entityFiled.name>
		  			   		 </#if>
		  			    </#list>
		  			     <#list relation.relFields as relfield>
							<#if relation.type?has_content&&relation.type=="one"&&field==relfield.fieldName>
								 <#assign relFieldName=relfield.relFieldName>
						 	</#if>
						 </#list>
	  			    </#list>    	
				</#if>
	<#if listFieldType?has_content&&listFieldType.equals("enum")>
		<td>${'<#if'} entityRow.${field!}??> ${'<#'}assign enum = delegator.findOne("Enumeration", Static["org.ofbiz.base.util.UtilMisc"].toMap("enumId", entityRow.${field!}), true)?if_exists>
		${'<#if'} enum??>${'$'}${'{'}enum.description!}${'</#if>'}${'</#if>'}</td>
	<#elseif listFieldType.equals("select")||listFieldType.equals("lookup")>
		<td>${'<#if'} entityRow.${field!}??> ${'<#'}assign relEntity = delegator.findOne("${listFieldMap["listFieldRelEntityName_"+field]!}", Static["org.ofbiz.base.util.UtilMisc"].toMap("${relFieldName!}", entityRow.${field!}), true)?if_exists>
		${'<#if'} relEntity??>${'$'}${'{'}relEntity.${listFieldRelName}!}${'</#if>'}${'</#if>'}</td>
		<#else>
		<td>${'$'}${'{'}entityRow.${field!}!}</td>
	</#if>
			
	        </#list>
	        
	  <td>${'<#'}if security.hasEntityPermission("${entityName}", "_UPDATE", session)><a title="编辑" <#if hasDialog.equals("Y")> href="#" onclick="javascript:operEditDialog('Edit${entityName}?${entityId}=${'${'}entityRow.${entityId}!}')"<#else>  href="Edit${entityName}?${entityId}=${'${'}entityRow.${entityId}!}" </#if> class="btnEdit">编辑</a>${'</#if>'}</td>
	  <td>${'<#'}if security.hasEntityPermission("${entityName}", "_DELETE", session)><a title="删除"  href="delete${entityName}?${entityId}=${'$'}${'{'}entityRow.${entityId}!}" class="btnDel">删除</a>${'</#if>'}</td>
      </tr>
      ${'<#'}assign rowCount = rowCount + 1>
      ${'<#'}assign alt_row = !alt_row>
    ${'</#'}list>
    </table>
  ${'</#'}if>
${'</#'}if>  
</div>
	</textarea>
	</div>
</#if>


<#if requestAttributes.parameters.listType=="Jeasy">
<div title="列表easyuiFTL" style="padding:10px">	<h2>列表easyuiFTL <button onclick="copyCode('easyuiFTLText');return false;">复制列表easyuiFTL</button>
${projectName}/webapp/${projectName}/${modelNameLower}/${entityName}_list.ftl
</h2>	
<textarea cols='200' rows='28' id='easyuiFTLText' name='easyuiFTLText'>
<script language='javascript'>
$(function(){
	$('#${entityName}_gridTb').datagrid({
		url:'ajaxFind${entityName}?thruDate_op=empty',
		fit:true,
		pagination:true,
		toolbar:'#${entityName}_gridTb_tb',
		fitColumns:true,
		loadMsg:null,
		rownumbers:true,
		columns:[[
	        <#list listField as field>
			<#assign listFieldType=listFieldMap["listFieldType_"+field]?if_exists>
			<#assign listFieldHasSort=listFieldMap["listFieldHasSort_"+field]?if_exists>
			<#assign title=''>
			<#if listFieldMap["listFieldDesc_"+field]?has_content>
				<#assign title= listFieldMap["listFieldDesc_"+field]>
			</#if>
			<#if listFieldMap["listFieldRelName_"+field]?has_content>
			<#assign listFieldRelName= listFieldMap["listFieldRelName_"+field]>
			<#assign displayName=''>
  			    <#list relations as relation>
	  			    <#list relation.relEntity as entityFiled>
	  			    	<#if entityFiled.name==listFieldRelName>
	  			    		<#if entityFiled.description??>
	  			    			<#assign displayName=entityFiled.description!>
	  			    			<#else>
	  			    			<#assign displayName=entityFiled.name!>
	  			    		</#if>
	  			    	</#if>
	  			    </#list>
	  			     <#list relation.relFields as relfield>
						<#if relation.type?has_content&&relation.type=="one"&&field==relfield.fieldName>
							 <#assign relFieldName=relfield.relFieldName>
					 	</#if>
					 </#list>
  			    </#list>    	
			</#if>
            	{field:'${field}',title:'<#if listFieldType.equals("select")> ${displayName!}<#else>${title!}</#if>'},
            </#list>
		        {field:'view',title:'查看',width:50,
		        	formatter : function(value, row, index) {
						return formatString('<a class="btnView" title="查看" href="Edit${entityName}?oper=view&${entityId}={0}"/>',row.${entityId});
					}
		        },
		        {field:'delete',title:'删除',width:50,
		        	formatter : function(value, row, index) {
						return formatString('<a class="btnDel" title="删除" href="delete${entityName}?${entityId}={0}"/>',row.${entityId});
					}
		        }
		]]
	});
});		
</script>
<div class="navTitle">位置：${'$'}{titleProperty!}</div>
<table id="${entityName}_gridTb" >
</table>
<div id="${entityName}_gridTb_tb">
	<form id='${entityName}_gridTb_search'>
	<#list searchField as field>
	<#assign editFieldType=editFieldMap["editFieldType_"+field]>
	<#assign editFieldRelName=''>
	<#assign required=''>
	<#if editFieldMap["editFieldRequired_"+field]?has_content>
		<#assign required= editFieldMap["editFieldRequired_"+field]>
	</#if>
	<#assign title=''>
	<#if editFieldMap["editFieldDesc_"+field]?has_content>
		<#assign title= editFieldMap["editFieldDesc_"+field]>
	</#if>
	<#if editFieldMap["editFieldRelName_"+field]?has_content>
	<#assign editFieldRelName= editFieldMap["editFieldRelName_"+field]>
	<#assign displayName=''>
	<#assign relEntityId=''>
	    <#list relations as relation>
		    <#list relation.relEntity as entityFiled>
		    	<#if entityFiled.name==editFieldRelName>
		    		<#if entityFiled.description??>
		    			<#assign displayName=entityFiled.description!>
		    			<#else>
		    			<#assign displayName=entityFiled.name!>
		    		</#if>
		    	</#if>
		    	<#if entityFiled.isPk=='Y'&&entityFiled.name==field>
  			    	<#assign relEntityId=entityFiled.name>
  			    </#if>
		    	</#list>
		    	 <#list relation.relFields as relfield>
					<#if relation.type?has_content&&relation.type=="one"&&field==relfield.fieldName>
						 <#assign relFieldName=relfield.relFieldName>
				 	</#if>
			 </#list>
	    </#list>    	
	</#if>
	<#if editFieldType.equals("date")>
		<input type="text" name="${field!}" class='date' />
	<#elseif editFieldType.equals("hidden") >
		<input type='hidden' name='${field!}'>
	<#elseif editFieldType.equals("select") >
		${displayName!}：<select name="${field}" class="">
        	<option value=""></option>
        		${'<#'}list ${editFieldMap["editFieldRelEntityName_"+field]!}List as relEntity>
        			<option   
        			value='${"$"}${"{"}relEntity.${relEntityId!}}'>
        			${"$"}${"{"}relEntity.${editFieldMap["editFieldRelName_"+field]!}}</option>
        		${'</#list>'}
        </select>
	<#else>
		${title!}：<input type="text" name="${field!}" />
		<input type="hidden" value="Y" name="${field!}_ic">
		<input type="hidden" value="contains" name="${field!}_op">
	</#if>
	</#list> 
		<a class="l-btn" onclick="javascript:searchGridForm('${entityName}_gridTb','${entityName}_gridTb_search');" href="javascript:void(0);">
			<span class="l-btn-left">
				<span class="l-btn-text icon-search l-btn-icon-left">
					查询
				</span>
			</span>
		</a>
	</form>
	<a href="Edit${entityName}" class="easyui-linkbutton" iconCls="icon-add" plain="false" >新增</a>
</div>	

</textarea>
</div>
<div title="列表easyui-groovy" style="padding:10px">
<h2>
${projectName}/webapp/${projectName}/WEB-INF/actions/${modelNameLower}/ajaxFind${entityName}.groovy
<button onclick="copyCode('easyuiGroovyText');return false;">复制列表easyui-groovy</button>
</h2>	
<textarea cols='200' rows='28' id='easyuiGroovyText' name='easyuiGroovyText'>
	import org.ofbiz.base.util.*
	import org.ofbiz.entity.*
	import org.ofbiz.entity.condition.*
	import org.ofbiz.entity.util.*
	import java.util.*
	import org.extErp.sysCommon.util.*
	inputFields = [:];
	inputFields=org.ofbiz.base.util.UtilHttp.getParameterMap(request);
	performFindInMap = [:];
	performFindInMap.entityName ="${entityName}";
	outputList = [];
	viewIndex=0;
	viewSize=20;
	if(inputFields.page){
		viewIndex=Integer.valueOf(inputFields.page).intValue()-1;
	}
	if(inputFields.rows){
		viewSize=Integer.valueOf(inputFields.rows);
	}
	if(UtilValidate.isEmpty(inputFields.sort)){
		inputFields.sort="-createdStamp";
	}
	performFindInMap.put("viewIndex",viewIndex);
	performFindInMap.put("viewSize",viewSize);
	//处理in类型 strings转换为list
	org.extErp.sysCommon.util.OfbizExtUtil.convertParamStrsToList(inputFields);
	
	performFindInMap.noConditionFind = "Y";
	performFindInMap.inputFields = inputFields;
	performFindInMap.orderBy = inputFields.sort;
	if (inputFields.order) {
		if(inputFields.order.equals("desc")){
			performFindInMap.orderBy="-"+performFindInMap.orderBy;
		}
	}
	
	performFindResults = dispatcher.runSync("performFindList", performFindInMap);
	resultList = performFindResults.list;
	listSize=performFindResults.listSize;
	
	//日期类型转换
	outputList = org.extErp.sysCommon.util.JsonUtil.jsonFromGenericValueList(resultList);
	for(Map<String,Object> result:outputList){
	    //  从关联表获取信息
	    <#list listField as field>
		<#assign listFieldType=listFieldMap["listFieldType_"+field]?if_exists>
		<#assign listFieldHasSort=listFieldMap["listFieldHasSort_"+field]?if_exists>
		<#assign title=''>
		<#if listFieldMap["listFieldDesc_"+field]?has_content>
			<#assign title= listFieldMap["listFieldDesc_"+field]>
		</#if>
		<#if listFieldMap["listFieldRelName_"+field]?has_content>
		<#assign listFieldRelName= listFieldMap["listFieldRelName_"+field]>
		<#assign displayName=''>
		<#assign relEntityId=''>
		    <#list relations as relation>
  			    <#list relation.relEntity as entityFiled>
  			    	<#if entityFiled.name==listFieldRelName>
  			    		<#if entityFiled.description??>
  			    			<#assign displayName=entityFiled.description!>
  			    		<#else>
  			    			<#assign displayName=entityFiled.name!>
  			    		</#if>
  			    	</#if>
  			    	<#if entityFiled.isPk=='Y'&&entityFiled.name==field>
	  			    	<#assign relEntityId=entityFiled.name>
	  			    </#if>
  			    </#list>
  			     <#list relation.relFields as relfield>
					<#if relation.type?has_content&&relation.type=="one"&&field==relfield.fieldName>
						 <#assign relFieldName=relfield.relFieldName>
				 	</#if>
				 </#list>
		    </#list>    	
		</#if>
		<#if listFieldType.equals("enum")>
		if(UtilValidate.isNotEmpty(result.get("${field}"))){
			GenericValue gv = delegator.findOne("Enumeration",[enumId:result.get("${field}")],true);
			if(gv)result.${field} = gv.description?gv.description:"";
	     }	
		<#elseif listFieldType.equals("select")||listFieldType.equals("lookup")>
		 if(UtilValidate.isNotEmpty(result.get("${field}"))){
				GenericValue gv = delegator.findOne("${listFieldMap["listFieldRelEntityName_"+field]!}",[${relEntityId!}:result.get("${field}")],true);
				if(gv)result.${field} = gv.${listFieldRelName}?gv.${listFieldRelName}:"";
		     }		
		</#if>
	</#list>
	}
	request.setAttribute("rows",outputList);
	request.setAttribute("total",listSize);
</textarea>
</div>
</#if>

<div title="service.xml" style="padding:10px"> 
 <h2>service.xml  [${projectName}\servicedef\services_${modelNameLower}.xml]<button onclick="copyCode('area4');return false;">复制service.xml</button></h2>	
<textarea cols='200' rows='28' name='serviceText' id='area4'>
	<!--${entityTitle!} -->
	<#if requestAttributes.parameters.javaType.equals("simple")>
	<service name="create${entityName}" engine="simple" default-entity-name="${entityName}"
             location="component://${projectName}/script/${modelName}Services.xml" invoke="create${entityName}" auth="true">
        <description>Create ${entityName}-${entityTitle!}</description>
        <auto-attributes include="pk" mode="INOUT" optional="true" />
		<auto-attributes include="nonpk" mode="IN" optional="true" />
    </service>
     <service name="update${entityName}" engine="simple" default-entity-name="${entityName}"
             location="component://${projectName}/script/${modelName}Services.xml" invoke="update${entityName}" auth="true">
        <description>Update ${entityName}-${entityTitle!}</description>
        <auto-attributes include="pk" mode="IN" optional="false" />
		<auto-attributes include="nonpk" mode="IN" optional="true" />
    </service>
    <service name="delete${entityName}" engine="simple" default-entity-name="${entityName}"
             location="component://${projectName}/script/${modelName}Services.xml" invoke="delete${entityName}" auth="true">
        <description>Delete ${entityName}-${entityTitle!}</description>
        <auto-attributes mode="IN" include="pk" optional="false"/>
    </service>
    <service name="deleteAll${entityName}" engine="simple" default-entity-name="${entityName}"
             location="component://${projectName}/script/${modelName}Services.xml" invoke="deleteAll${entityName}" auth="true">
        <description>Delete ${entityName}-${entityTitle!}</description>
        <attribute name="ids"  mode="IN" type="String" optional="false"/>
    </service>
	<#else>
    <service name="create${entityName}" engine="java" default-entity-name="${entityName}"
     		location="${packageName}.${projectName}.${modelNameLower}.${entityName}Services" invoke="create${entityName}" auth="true">
        <description>Create ${entityName}-${entityTitle!}</description>
        <auto-attributes include="pk" mode="INOUT" optional="true" />
		<auto-attributes include="nonpk" mode="IN" optional="true" />
    </service>
     <service name="update${entityName}" engine="java" default-entity-name="${entityName}"
             location="${packageName}.${projectName}.${modelNameLower}.${entityName}Services" invoke="update${entityName}" auth="true">
        <description>Update ${entityName}-${entityTitle!}</description>
        <auto-attributes include="pk" mode="IN" optional="false" />
		<auto-attributes include="nonpk" mode="IN" optional="true" />
    </service>
    <service name="delete${entityName}" engine="java" default-entity-name="${entityName}"
             location="${packageName}.${projectName}.${modelNameLower}.${entityName}Services" invoke="delete${entityName}" auth="true">
        <description>Delete ${entityName}-${entityTitle!}</description>
        <auto-attributes mode="IN" include="pk" optional="false"/>
    </service>
    <#if relationEntity??>
    <service name="createOrUpdate${relationEntity}" engine="simple" default-entity-name="LimsStudent"
             location="component://insure/script/MedicalServices.xml" invoke="createOrUpdate${relationEntity}" auth="true">
        <description>Update ${relationEntity}-</description>
        <auto-attributes include="pk" mode="IN" optional="true" />
		<auto-attributes include="nonpk" mode="IN" optional="true" />
    </service>
    </#if>
</#if>
<#if requestAttributes.parameters.hasWorkflow=="Y">
	<!-- ${entityTitle!} 工作流 name对应启动按钮的传参workflowProcessServices-->
   	<service name="${entityName}Workflow" engine="ofbiz-workflow" debug="true" require-new-transaction="true" 
           location="WorkFlowPackage.${entityName}" invoke="${entityName}WorkFlow">
       <description>${entityTitle!}流程</description>
       <attribute name="nextActive" type="String" mode="IN" optional="true"/>
       <attribute name="areaId" type="String" mode="IN" optional="true"/>
       <attribute name="entityName" type="String" mode="IN" optional="true"/>
       <attribute name="entityIdName" type="String" mode="IN" optional="true"/>
       <attribute name="entityIdValue" type="String" mode="IN" optional="true"/>
       <attribute name="packageId" type="String" mode="IN" optional="true"/>
	</service>
	<service name="saveExamin${entityName}" engine="simple" default-entity-name="${entityName}"
             location="component://${projectName}/script/${modelName}Services.xml" invoke="saveExamin${entityName}" auth="true">
        <description>${entityName}下一步</description>
        <auto-attributes include="pk" mode="IN" optional="false" />
		<auto-attributes include="nonpk" mode="IN" optional="true" />
		<attribute name="workEffortId" type="String" mode="IN" optional="true"/>
		<attribute name="entityIdValue" type="String" mode="IN" optional="true"/>
		<attribute name="LeadCensure" type="String" mode="IN" optional="true"/>
		<attribute name="returnActivity" type="String" mode="IN" optional="true"/>
    </service>
</#if>	
</textarea>
</div>
<#if requestAttributes.parameters.javaType.equals("simple")>
<div title="simple.xml" style="padding:10px"> 
<h2>simple.xml [${projectName}\script\${modelName}Services.xml]<button onclick="copyCode('area5');return false;">复制simple.xml</button></h2>	
	<textarea cols='200' rows='28' name='simpleText' id='area5'>
    <!--${entityTitle!} -->
    <simple-method method-name="create${entityName}" short-description="Create ${entityName}">
        <make-value entity-name="${entityName}" value-field="newEntity"/>
   	    <if-empty field="parameters.${entityId}">
        	<sequenced-id sequence-name="${entityName}" field="newEntity.${entityId}"/>
        	 <else>
                <set field="newEntity.${entityId}" from-field="parameters.${entityId}"/>
            </else>
		</if-empty>
        <set-nonpk-fields map="parameters" value-field="newEntity"/>
        <field-to-result field="newEntity.${entityId}" result-name="${entityId}"/>
        <create-value value-field="newEntity"/>
        <check-errors/>
    </simple-method>
    <simple-method method-name="update${entityName}" short-description="Update ${entityName}">
        <entity-one entity-name="${entityName}" value-field="lookedUpValue"/>
        <set-nonpk-fields value-field="lookedUpValue" map="parameters"/>
        <store-value value-field="lookedUpValue"/>
    </simple-method>
    <#if isLogicDelete??&&isLogicDelete=='Y'>
    <simple-method method-name="delete${entityName}" short-description="Delete ${entityName}">
        <now-timestamp field="nowTimestamp"/>
        <set field="parameters.thruDate" from-field="nowTimestamp"/>
        <set-service-fields service-name="update${entityName}" to-map="thisCtx" map="parameters"/>
        <call-service service-name="update${entityName}" in-map-name="thisCtx"/>
    </simple-method>
    <#else>
     <simple-method method-name="delete${entityName}" short-description="Delete ${entityName}">
        <make-value entity-name="${entityName}" value-field="lookupKeyValue"/>
        <set-pk-fields map="parameters" value-field="lookupKeyValue"/>
        <find-by-primary-key entity-name="${entityName}" map="lookupKeyValue" value-field="lookedUpValue"/>
        <remove-value value-field="lookedUpValue"/>
    </simple-method>
    </#if>
    <simple-method method-name="deleteAll${entityName}" short-description="Delete select ${entityName}">
        <call-bsh><![CDATA[
               ids = org.ofbiz.base.util.StringUtil.split(parameters.get("ids"),",");
               parameters.put("ids", ids);
        ]]></call-bsh>
        <if-not-empty field="parameters.ids">
       		<iterate entry="thisId" list="parameters.ids">
			<set from-field="thisId" field="thisMap.${entityId}" />
	        <call-service service-name="delete${entityName}" in-map-name="thisMap"></call-service>
			</iterate>
		</if-not-empty>	
    </simple-method>
    <#if relationEntity??>
    <#assign subPkEntityId=''>
	<#list subFieldList as field>
		<#if field.isPk == 'Y'><#assign subPkEntityId=field.name></#if>
	</#list> 
    <simple-method method-name="createOrUpdate${relationEntity}" short-description="createOrUpdate PsychologicalResult">
   	    <if-empty field="parameters.${subPkEntityId}">
        		<set-service-fields service-name="create${relationEntity}" to-map="thisCtx" map="parameters"/>
        		<call-service service-name="create${relationEntity}" in-map-name="thisCtx"/>
			<else>
				<set-service-fields service-name="update${relationEntity}" to-map="thisCtx" map="parameters"/>
        		<call-service service-name="update${relationEntity}" in-map-name="thisCtx"/>
			</else>
		</if-empty>
        <check-errors/>
    </simple-method>
     </#if>
    <#if requestAttributes.parameters.hasWorkflow.equals("Y")>
    <simple-method method-name="saveExamin${entityName}" short-description="Update ${entityName}">
        <entity-one entity-name="${entityName}" value-field="lookedUpValue"/>
        <set-nonpk-fields value-field="lookedUpValue" map="parameters"/>
        <store-value value-field="lookedUpValue"/>
        <set-service-fields to-map="createParams" service-name="saveCommonExamin" map="parameters"/>
        <call-service service-name="saveCommonExamin" in-map-name="createParams"/>
    </simple-method>
    </#if>
	</textarea>
</div>
</#if>
<#if requestAttributes.parameters.hasMultipart.equals("Y")>
	<div title="java-Events" style="padding:10px"> 
	<h2>java<button onclick="copyCode('EventsJavaText');return false;">复制</button>
	${packageName}.${projectName}.${modelNameLower}.${entityName}Events.java
	</h2>	
	<textarea cols='200' rows='28' id='EventsJavaText' name='EventsJavaText'>
		
package ${packageName}.${projectName}.${modelNameLower};

import java.util.HashMap;
import java.util.Map;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;
import org.extErp.sysCommon.document.DocumentHelper;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.ofbiz.service.ServiceUtil;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;
import org.ofbiz.entity.transaction.*;
import javolution.util.FastMap;

public class ${entityName}Events {
	public static final String module = ${entityName}Events.class.getName();
    public static final String DCT_PPS = "${entityName}";// 需要维护种子数据到Syscdoc下
	/**
     * 
     * create${entityName}(附件上传)<br/>
     * 
     * @param request
     * @param response
     * @return
     */
    public static String create${entityName}(HttpServletRequest request, HttpServletResponse response)
    {
	
	    LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		boolean beganTransaction = false;
		try
		{
		    beganTransaction = TransactionUtil.begin();
		    Map<String, Object> entityMap = FastMap.newInstance();
		    String relatedIdValue = delegator.getNextSeqId("${entityName}");
		    // 上传资源并生成关联
		    Map<String, Object> uploadMap = DocumentHelper.uploadSysDocByPurpose(request, DCT_PPS, relatedIdValue);
		    if (ServiceUtil.isError(uploadMap))
		    {
			throw new Exception(ServiceUtil.getErrorMessage(uploadMap));
		    }
		    // 回写到实体
		    ModelService pService = dispatcher.getDispatchContext().getModelService("create${entityName}");
		    entityMap = pService.makeValid(uploadMap, ModelService.IN_PARAM);
		    entityMap.put("userLogin", userLogin);
		    entityMap.put("${entityId}", relatedIdValue);
		    dispatcher.runSync(pService.name, entityMap);
	
		} catch (Exception e)
		{
		    try
		    {
			TransactionUtil.rollback(beganTransaction, e.getLocalizedMessage(), e);
		    } catch (GenericTransactionException e1)
		    {
			e1.printStackTrace();
		    }
		    Debug.logError(e, e.getLocalizedMessage(), module);
		} finally
		{
		    try
		    {
			TransactionUtil.commit(beganTransaction);
		    } catch (GenericTransactionException e)
		    {
			e.printStackTrace();
		    }
		}
	return ModelService.RESPOND_SUCCESS;
    }
    /**
     * 
     * update${entityName}(附件上传)<br/>
     * 
     * @param request
     * @param response
     * @return
     */
    public static String update${entityName}(HttpServletRequest request, HttpServletResponse response)
    {

	LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");

	boolean beganTransaction = false;
	try
	{
	    beganTransaction = TransactionUtil.begin();

	    Map<String, Object> uploadResult = DocumentHelper.uploadSysDocByPurpose(request, DCT_PPS, null);// 更新的时候,不需要当前实体主键传入,会从表单中自动获取
	    if (UtilValidate.isEmpty(uploadResult))
	    {
		Debug.logError("上传文件失败", module);
		return "error";
	    }

	    uploadResult.put("userLogin", userLogin);
	    ModelService pService = dispatcher.getDispatchContext().getModelService("update${entityName}");
	    uploadResult = pService.makeValid(uploadResult, ModelService.IN_PARAM);
	    dispatcher.runSync(pService.name, uploadResult);
	} catch (Exception e)
	{
	    try
	    {
		TransactionUtil.rollback(beganTransaction, e.getLocalizedMessage(), e);
	    } catch (GenericTransactionException e1)
	    {
		e1.printStackTrace();
	    }
	    Debug.logError(e, e.getLocalizedMessage(), module);
	} finally
	{
	    try
	    {
		TransactionUtil.commit(beganTransaction);
	    } catch (GenericTransactionException e)
	    {
		e.printStackTrace();
	    }
	}
	return ModelService.RESPOND_SUCCESS;
    }
}		
	</textarea>
	</div>
</#if>
<#if requestAttributes.parameters.javaType.equals("java")>
	<div title="java" style="padding:10px"> 
	<h2>java<button onclick="copyCode('servicesJavaText');return false;">复制</button>
	${packageName}.${projectName}.${modelNameLower}.${entityName}Services.java
	</h2>	
	<textarea cols='200' rows='28' id='servicesJavaText' name='servicesJavaText'>
		
package ${packageName}.${projectName}.${modelNameLower};

import java.util.Locale;
import java.util.Map;

import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;

public class ${entityName}Services 
{
    public static final String module = ${entityName}Services.class.getName();
    public static final String resource = "${modelName}UiLabels";
    public static final String resourceError = "${modelName}ErrorUiLabels";
    
    /**
     * 创建数据
     * 
     * Create a ${entityName}. If no ${entityId} is specified a numeric
     * ${entityId} is retrieved from the ${entityName} sequence.
     * 
     * @param dctx
     *            The DispatchContext that this service is operating
     *            in.
     * @param context
     *            Map containing the input parameters.
     * @return Map with the result of the service, the output
     *         parameters.
     */
    public static Map<String, Object> create${entityName}(DispatchContext dctx, Map<String, ? extends Object> context)
    {
        Map<String, Object> result = FastMap.newInstance();
        Delegator delegator = dctx.getDelegator();
        Locale locale = (Locale) context.get("locale");
        GenericValue gv = null;

        if (result.size() > 0)
            return result;

        String ${entityId} = null;
        try
        {
        	if (UtilValidate.isNotEmpty(context.get("${entityId}")))
		    {
			${entityId} = context.get("${entityId}").toString();
		    } else
		    {
			 ${entityId} = delegator.getNextSeqId("${entityName}");
		    }
        } catch (IllegalArgumentException e)
        {
            Debug.logError(e, module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "${entityNameLower}.id_generation_failure", locale));
        }

        gv = delegator.makeValue("${entityName}", UtilMisc.toMap("${entityId}", ${entityId}));
        gv.setNonPKFields(context);
        if (gv.containsKey("fromDate"))
        {
            gv.set("fromDate", UtilDateTime.nowTimestamp());
        }

        try
        {
            gv.create();
        } catch (GenericEntityException e)
        {
            Debug.logError(e, module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "${entityNameLower}.create_failure", locale));
        }

        if (gv != null)
        {
            result.put("${entityId}", ${entityId});
        }
        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
        return result;
    }

    /**
     * 更新数据
     * 
     * update a ${entityName}.
     * 
     * @param dctx
     *            The DispatchContext that this service is operating
     *            in.
     * @param context
     *            Map containing the input parameters.
     * @return Map with the result of the service, the output
     *         parameters.
     */
    public static Map<String, Object> update${entityName}(DispatchContext dctx, Map<String, ? extends Object> context)
    {
        Map<String, Object> result = FastMap.newInstance();
        Delegator delegator = dctx.getDelegator();
        Locale locale = (Locale) context.get("locale");

        String ${entityId} = (String) context.get("${entityId}");
        GenericValue gv = null;

        try
        {
            gv = delegator.findOne("${entityName}", false, UtilMisc.toMap("${entityId}", ${entityId}));
        } catch (GenericEntityException e)
        {
            Debug.logError(e, module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "${entityNameLower}.find_failure", locale));
        }
        if (gv != null)
        {
            gv.setNonPKFields(context);
            try
            {
                gv.store();
                //result.put("${entityId}", ${entityId});
            } catch (GenericEntityException e)
            {
                Debug.logError(e, module);
                return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "${entityNameLower}.update_failure", locale));
            }
        }

        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
        return result;
    }

    /**
     * 删除数据
     * 
     * delete a ${entityName}.
     * 
     * @param dctx
     *            The DispatchContext that this service is operating
     *            in.
     * @param context
     *            Map containing the input parameters.
     * @return Map with the result of the service, the output
     *         parameters.
     */
    public static Map<String, Object> delete${entityName}(DispatchContext dctx, Map<String, ? extends Object> context)
    {
        Map<String, Object> result = FastMap.newInstance();
        Delegator delegator = dctx.getDelegator();
        Locale locale = (Locale) context.get("locale");

        String ${entityId} = (String) context.get("${entityId}");
        GenericValue gv = null;
       
        try
        {
            gv = delegator.findOne("${entityName}", false, UtilMisc.toMap("${entityId}", ${entityId}));
        } catch (GenericEntityException e)
        {
            Debug.logError(e, module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "${entityNameLower}.find_failure", locale));
        }
        if (UtilValidate.isNotEmpty(gv))
        {
            try
            {
             <#if isLogicDelete??&&isLogicDelete=='Y'>
       			gv.put("thruDate", UtilDateTime.nowTimestamp());
       			gv.store();
       			<#else>
                gv.remove();
              </#if>  
            } catch (GenericEntityException e)
            {
                Debug.logError(e, module);
                return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "${entityNameLower}.delete_failure", locale));
            }
        }

        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
        return result;
    }
}
	</textarea>
	</div>
</#if>

<div title="种子数据" style="padding:10px"> 
<h2>权限(SecurityData.xml)和菜单初始数据(MenuTreeData.xml) <button onclick="copyCode('area6');return false;">复制</button></h2>	
<textarea cols='200' rows='28' name='dataText' id='area6'>
	<SecurityPermission permissionId="${entityName}_ADMIN" description="${entityTitle}全部权限"  modelId="${entityName}Mgr"/>
	<SecurityPermission permissionId="${entityName}_ADD" description="${entityTitle}增加权限" modelId="${entityName}Mgr"/>
	<SecurityPermission permissionId="${entityName}_VIEW" description="${entityTitle}查看权限" modelId="${entityName}Mgr"/>
	<SecurityPermission permissionId="${entityName}_UPDATE" description="${entityTitle}修改权限" modelId="${entityName}Mgr"/>
	<SecurityPermission permissionId="${entityName}_DELETE" description="${entityTitle}删除权限" modelId="${entityName}Mgr"/>
	<SecurityGroupPermission groupId="FULLADMIN" permissionId="${entityName}_ADMIN"/>
	 	
	<MenuTree id="${entityName}Mgr" itemName="${entityTitle!}管理"  parentItemId="MedicalModel" rank="1"/>
	<MenuTree id="Edit${entityName}" itemName="${entityTitle!}添加" urlLocation="<#if relationEntity??>Edit${entityName!}And${relationEntity!}<#else>Edit${entityName}</#if>" parentItemId="${entityName}Mgr" permission="${entityName}_ADD" rank="1"/>
	<MenuTree id="Find${entityName}" itemName="${entityTitle!}列表" urlLocation="Find${entityName}" parentItemId="${entityName}Mgr" permission="${entityName}_VIEW" rank="2"/>
	<#if requestAttributes.parameters.hasWorkflow.equals("Y")>
	<MenuTree id="Examine${entityName}" itemName="${entityTitle!}审批" urlLocation="Examine${entityName}" parentItemId="${entityName}Mgr" permission="${entityName}_VIEW" rank="3"/>
	</#if>	
	<#if requestAttributes.parameters.hasMultipart.equals("Y")>
	<SysDocPurpose sysDocPurposeId="${entityName}" entiyName="${entityName}"
		relatedDetailId="${entityId}" description="${entityTitle}" mimeTypeId="application/msword"  inApp="Y"  appName="${projectName}" path="" />
	</#if>	
</textarea>
</div>
</form>
<script type="text/javascript">
function copyCode(id){
 var testCode=document.getElementById(id).value;
 if(copy2Clipboard(testCode)!=false){
  alert("生成的代码已经复制到粘贴板，你可以使用Ctrl+V 贴到需要的地方去了哦！  ");
 }
}
copy2Clipboard=function(txt){
 if(window.clipboardData){
  window.clipboardData.clearData();
  window.clipboardData.setData("Text",txt);
 }
 else if(navigator.userAgent.indexOf("Opera")!=-1){
  window.location=txt;
 }
 else if(window.netscape){
  try{
   netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
  }
  catch(e){
   alert("您的firefox安全限制限制您进行剪贴板操作，请打开’about:config’将signed.applets.codebase_principal_support’设置为true’之后重试，相对路径为firefox根目录/greprefs/all.js");
   return false;
  }
  var clip=Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
  if(!clip)return;
  var trans=Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
  if(!trans)return;
  trans.addDataFlavor('text/unicode');
  var str=new Object();
  var len=new Object();
  var str=Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
  var copytext=txt;str.data=copytext;
  trans.setTransferData("text/unicode",str,copytext.length*2);
  var clipid=Components.interfaces.nsIClipboard;
  if(!clip)return false;
  clip.setData(trans,null,clipid.kGlobalClipboard);
 }
}
</script>
