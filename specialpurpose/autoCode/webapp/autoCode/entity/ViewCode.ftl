<div>
<#assign entityTitle=requestAttributes.entityTitle>
<#assign entityName=requestAttributes.parameters.entityName>
<#assign projectName=requestAttributes.parameters.projectName>
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
<#assign hasAdd=requestAttributes.parameters.hasAdd>
<#assign hasEdit=requestAttributes.parameters.hasEdit>
<#assign hasDelete=requestAttributes.parameters.hasDelete>
<#assign entityId=''>
<#list requestAttributes.fieldList as field>
	<#if field.isPk == 'Y'><#assign entityId=field.name></#if>
</#list>      
<div>
<h2>拷贝代码至项目下后,运行 ant load-demo ||ant start <a href=''>详细说明</a></h2>
<h2>controller.xml [lims\webapp\${projectName}\WEB-INF\${modelNameLower}-controller.xml]<button onclick="copyCode('area1');return false;">复制</button></h2>	
<textarea cols='130' rows='15' id='area1'>
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
    	<event type="service" invoke="create${entityName}"/>
        <response name="success" type="request" value="json" />
        <response name="error" type="request" value="json" />
    </request-map>
    <request-map uri="update${entityName}">
        <security https="false" auth="true"/>
        <event type="service" invoke="update${entityName}"/>
        <response name="success" type="request" value="json" />
        <response name="error" type="request" value="json" />
    </request-map>
    <request-map uri="delete${entityName}">
        <security https="false" auth="true"/>
        <event type="service" invoke="delete${entityName}"/>
        <response name="success" type="request" value="json" />
        <response name="error" type="request" value="json" />
    </request-map>
    <!--批量删除${entityTitle!} -->
    <request-map uri="deleteAll${entityName}">
        <security https="false" auth="true"/>
        <event type="service" invoke="deleteAll${entityName}"/>
        <response name="success" type="request" value="json" />
        <response name="error" type="request" value="json" />
    </request-map>
    <#list editField as field>
   		<#assign editFieldType=editFieldMap["editFieldType_"+field]>
   		<#if editFieldType.equals("lookup")>
	<request-map uri="Lookup${editFieldMap["editFieldRelEntityName_"+field]!}">
		<security https="false" auth="true" />
		<response name="success" type="view" value="Lookup${editFieldMap["editFieldRelEntityName_"+field]!}" />
	</request-map>
		</#if>
	</#list>	
    <#if hasSearchAdvanced.equals("Y")> 
    <request-map uri="Find${entityName}Advanced">
        <security https="false" auth="true"/>
        <response name="success" type="view" value="Find${entityName}Advanced" />
    </request-map>
    </#if>
    <!--${entityTitle!}-view -->
    <#if hasSearchAdvanced.equals("Y")> 
	<view-map name="Find${entityName}Advanced" type="screenjui" 
		page="component://${projectName}/widget/${modelName}Screens.xml#Find${entityName}Advanced" />
   	</#if>
	<view-map name="Find${entityName}" type="screenjui" 
		page="component://${projectName}/widget/${modelName}Screens.xml#Find${entityName}" />
	<view-map name="Edit${entityName}" type="screenjui" 
		page="component://${projectName}/widget/${modelName}Screens.xml#Edit${entityName}" />
	<#list editField as field>
   		<#assign editFieldType=editFieldMap["editFieldType_"+field]>
   		<#if editFieldType.equals("lookup")>
	<view-map name="Lookup${editFieldMap["editFieldRelEntityName_"+field]!}" type="screenjui" 
		page="component://${projectName}/widget/${modelName}Screens.xml#Lookup${editFieldMap["editFieldRelEntityName_"+field]!}"/>
		</#if>
	</#list>	
	</textarea>
</div>
<div><h2>screens.xml  [lims\widget\${modelName}Screens.xml]<button onclick="copyCode('area2');return false;">复制</button></h2>	
	<textarea cols='130' rows='15' id='area2'>
	<!--${entityTitle!} -->
	<screen name="Find${entityName}">
		<section>
			<actions>
				<set field="titleProperty" value="" />
				<set field="pCtx" from-field="parameters" />
				<set field="searchAction" value="Find${entityName}" />
				<set field="searchForm" value="Find${entityName}" />
				<#if requestAttributes.parameters.listType=="forms">
				<#if hasSearchAdvanced.equals("Y")> 
				<set field="searchAdvanced" value="Find${entityName}Advanced" /><!-- 高级查询 弹出框 -->
				</#if>
				<set field="operationButton[]" value="增加|add|Edit${entityName}|navTab|${entityName}_ADD" />
				<#if hasDeleteAll.equals("Y")> 
				<set field="operationButton[]" value="批量删除|delete|deleteAll${entityName}|removeSelected|${entityName}_DELETE" />
				</#if>
				</#if>
				<#if requestAttributes.parameters.listType=="ftl">
				<set field="viewIndex" from-field="parameters.VIEW_INDEX_1" type="Integer" default-value="0"/>
                <set field="viewSize" from-field="parameters.VIEW_SIZE_1" type="Integer" default-value="20"/>
                <service service-name="performFindList" result-map="result">
	                <field-map field-name="inputFields" from-field="parameters"/>
	                <field-map field-name="entityName" value="${entityName}"/>
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
				</#if>
			</actions>
			<widgets>
				<decorator-screen name="main-decorator" location="${r"${parameters.mainDecoratorLocation}"}">
					<decorator-section name="body">
						<#if requestAttributes.parameters.listType=="forms">
						<decorator-screen name="FindScreenDecorator" location="${r"${parameters.mainDecoratorLocation}"}">
							<decorator-section name="search-options">
								<include-form name="Find${entityName}" 
									location="component://${projectName}/widget/forms/${modelName}Forms.xml" />
							</decorator-section>
							<decorator-section name="search-results">
								<include-form name="List${entityName}" 
									location="component://${projectName}/widget/forms/${modelName}Forms.xml" />
							</decorator-section>
						</decorator-screen>
						<#else>
						<platform-specific>
							<html>
								<html-template location="component://${projectName}/webapp/${projectName}/${modelName}/${entityName}_list.ftl" />
							</html>
						</platform-specific>
						</#if>
					</decorator-section>
				</decorator-screen>
			</widgets>
		</section>
	</screen>
	<#list editField as field>
   		<#assign editFieldType=editFieldMap["editFieldType_"+field]>
   		<#if editFieldType.equals("lookup")>
		<screen name="Lookup${editFieldMap["editFieldRelEntityName_"+field]!}">
			<section>
				<actions>
					<set field="headerItem" value="${editFieldMap["editFieldRelEntityName_"+field]!}" />
					<set field="titleProperty" value="${editFieldMap["editFieldRelEntityName_"+field]!}" />
					<set field="pCtx" from-field="parameters" />
					<set field="parameters.noConditionFind" value="Y" />   <!--默认无条件查询 -->
					<set field="lookupId" from-field="parameters.lookupId"/> <!--需要返回的外键ID -->
					<#assign editFieldRelEntityName=editFieldMap["editFieldRelEntityName_"+field]>
					<#list relations as relation>
						<#if relation.relEntityName.equals(editFieldRelEntityName)>
							<#list relation.relEntity as relationField>
								<#if relationField['isPk'].equals("Y")>
					<set field="entityId" value="${ relationField['name']}" />   <!--主键ID -->
								</#if>
							</#list>
						</#if>
					</#list>
					<set field="searchAction" value="Lookup${editFieldMap["editFieldRelEntityName_"+field]!}" /><!--列表查询url -->
					<set field="searchForm" value="LookupFind${editFieldMap["editFieldRelEntityName_"+field]!}" />  <!-- 查询 form id -->
					</actions>
				<widgets>
					<decorator-screen name="main-decorator" location="${r"${parameters.mainDecoratorLocation}"}">
						<decorator-section name="body">
							<decorator-screen name="LookupScreenDecorator" location="${r"${parameters.mainDecoratorLocation}"}">
								<decorator-section name="lookup-options">
									<include-form name="LookupFind${editFieldMap["editFieldRelEntityName_"+field]!}" 
										location="component://${projectName}/widget/forms/${modelName}Forms.xml" />
								</decorator-section>
								<decorator-section name="search-results">
									<include-form name="Lookup${editFieldMap["editFieldRelEntityName_"+field]!}" 
										location="component://${projectName}/widget/forms/${modelName}Forms.xml" />
								</decorator-section>
							</decorator-screen>
						</decorator-section>
					</decorator-screen>
				</widgets>
			</section>
		</screen>
		</#if>
	</#list>	
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
				<decorator-screen name="main-decorator" location="${r"${parameters.mainDecoratorLocation}"}">
					<decorator-section name="body">
						<decorator-screen name="FindDialogDecorator" 
								location="${r"${parameters.mainDecoratorLocation}"}">
							<decorator-section name="search-form"> 
								<include-form name="Find${entityName}Advanced" 
									location="component://${projectName}/widget/forms/${modelName}Forms.xml"/> 
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
				<set field="titleProperty" value="" />
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
				<set field="currentForm" value="${'$'}${'{'}groovy:(entity==null)?&amp;quot;Create${entityName}&amp;quot;:&amp;quot;Edit${entityName}&amp;quot;${'}'}"/>  
			</actions>
			<widgets>
				<decorator-screen name="main-decorator" location="${r"${parameters.mainDecoratorLocation}"}">
					<decorator-section name="body">
					<#if requestAttributes.parameters.formsType=="ftl">
						<platform-specific>
				          	<html><html-template location="component://${projectName}/webapp/${projectName}/${modelNameLower}/${entityName}_edit.ftl"/></html>
				        </platform-specific>
					<#else>
					<decorator-screen name="DetailScreenDecorator" location="${r"${parameters.mainDecoratorLocation}"}">
							<decorator-section name="detail-options">
							<screenlet title="">
								<include-form name="Edit${entityName}" 
									location="component://${projectName}/widget/forms/${modelName}Forms.xml" />
						    </screenlet>	
							</decorator-section>
						</decorator-screen>
				    </#if>
					</decorator-section>
				</decorator-screen>
			</widgets>
		</section>
	</screen>
	</textarea>
</div>
<!--生成forms代码-->

	<div><h2>forms.xml [lims\widget\forms\${modelName}Forms.xml]<button onclick="copyCode('area3');return false;">复制</button></h2>	
		<textarea cols='130' rows='15' id='area3'>
		<!--${entityTitle!} -->
		<#if hasSearchAdvanced.equals("Y")> 
			<form name="Find${entityName}Advanced" type="single"  style="pageForm"  target="Find${entityName}" default-entity-name="${entityName}">
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
		<form name="Find${entityName}" type="single"  style="pageForm" default-table-style="searchContent" target="Find${entityName}" default-entity-name="${entityName}">
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
		  			    	<#if entityFiled.isPk=='Y'>
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
				<field name="${field}" widget-style=" date" title="${title!}" position="${searchFieldMap["searchFieldSort_"+field]!}">
					<text/>
				</field>
				<#elseif editFieldType.equals("email")>
				<field name="${field}" widget-style=" email" title="${title!}" position="${searchFieldMap["searchFieldSort_"+field]!}">
					<text />
				</field>
				<#elseif editFieldType.equals("number")>
				<field name="${field}" widget-style=" number" title="${title!}" position="${searchFieldMap["searchFieldSort_"+field]!}">
					<text />
				</field>	
				<#elseif editFieldType.equals("select")>
				<field name="${field}" widget-style="" title="${displayName!}" position="${searchFieldMap["searchFieldSort_"+field]!}">
					<drop-down text-size="30"> 
						<entity-options description="${'$'}${'{'}${editFieldRelName}${'}'}" entity-name="${editFieldMap["editFieldRelEntityName_"+field]!}"  key-field-name="${relEntityId!}"></entity-options>
					</drop-down>
				</field>
				<#elseif editFieldType.equals("lookup")>
				<field name="${field!}" widget-style="${required!}"   title="${displayName!}" position="${searchFieldMap["searchFieldSort_"+field]!}" >
					<lookup target-form-name="Lookup${editFieldMap["editFieldRelEntityName_"+field]!}"  description-field-name="${editFieldMap["editFieldRelName_"+field]!}" ></lookup>
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
		<form name="List${entityName}" type="list" list-name="listIt" group-columns="false"   paginate-target="Find${entityName}"
	       default-entity-name="${entityName}" paginate-style="panelBar" default-table-style="table">
			<actions>
				<service service-name="performFind" result-map="result" result-map-list="listIt">
					<field-map field-name="inputFields" from-field="pCtx" />
					<field-map field-name="entityName" value="${entityName}" />
					<field-map field-name="orderBy" from-field="parameters.sortField" />
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
		  			    	<#if entityFiled.isPk=='Y'>
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
			<field name="${field}"  title="${displayName!}">
				<display-entity entity-name="${listFieldMap["listFieldRelEntityName_"+field]!}" key-field-name="${relEntityId!}" description="${'$'}${'{'}${listFieldRelName}${'}'}" />
			</field>
					<#else>
			<field name="${field}" <#if listFieldHasSort.equals("true")>sort-field="true"</#if> title="${listFieldMap["listFieldDesc_"+field]!}" >
				<display />
			</field>
				</#if>
			</#list>
			<field name="view" title="查看" use-when="${'$'}{groovy:security.hasEntityPermission(&amp;quot;${entityName}&amp;quot;, &amp;quot;_VIEW&amp;quot;, session);}" widget-style="btnView">
				<hyperlink also-hidden="false" target-window="navTab" description="查看" target="Edit${entityName}">
					<parameter param-name="${entityId}" />
					<parameter param-name="oper" value="view"/>
				</hyperlink>
			</field>		
			<field name="edit" title="编辑" use-when="${'$'}{groovy:security.hasEntityPermission(&amp;quot;${entityName}&amp;quot;, &amp;quot;_UPDATE&amp;quot;, session);}" widget-style="btnEdit">
				<hyperlink also-hidden="false" target-window="navTab" description="编辑" target="Edit${entityName}">
					<parameter param-name="${entityId}" />
				</hyperlink>
			</field>
			<field name="delete" title="删除" use-when="${'$'}{groovy:security.hasEntityPermission(&amp;quot;${entityName}&amp;quot;, &amp;quot;_DELETE&amp;quot;, session);}" widget-style="btnDel">
				<hyperlink also-hidden="false" target-window="navTabTodo" target-type="plain" description="删除" target="delete${entityName}">
					<parameter param-name="${entityId}" />
				</hyperlink>
			</field>
		</form>
		</#if>
		<#if requestAttributes.parameters.formsType=="forms">
		<form name="Edit${entityName}" id="${'$'}${'{'}groovy:(entity==null)?&amp;quot;Create${entityName}&amp;quot;:&amp;quot;Edit${entityName}&amp;quot;${'}'}" <#if requestAttributes.parameters.hasMultipart.equals("Y")>type="upload"<#else>type='single'</#if> style="single_table" default-table-style="single_table_style" target-type="plain" target="update${entityName}"  default-map-name="entity" default-entity-name="${entityName}">
			<alt-target use-when="entity==null" target="create${entityName}" />
			<field name="${entityId}">
				<hidden />
			</field>
			<field name="navTabId">
				<hidden value="Find${entityName}" />
			</field>
			<field name="callbackType">
				<hidden value="closeCurrent" />
			</field>
			<#list editField as field>
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
			  			    <#if entityFiled.isPk=='Y'>
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
				<field name="${field}" use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}" widget-style="${required!} date" title="${title!}" >
					<text  disabled="true"/>
				</field>
				<field name="${field}" use-when="${'$'}{groovy:oper==null}" widget-style="${required!} date" title="${title!}">
					<text  />
				</field>
				<#elseif editFieldType.equals("email")>
				<field name="${field}"  use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}" widget-style="${required!} email" title="${title!}">
					<text  disabled="true"/>
				</field>
				<field name="${field}"  use-when="${'$'}{groovy:oper==null}" widget-style="${required!} email" title="${title!}">
					<text />
				</field>
				<#elseif editFieldType.equals("number")>
				<field name="${field}" use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}" widget-style="${required!} number" title="${title!}">
					<text disabled="true"/>
				</field>
				<field name="${field}"  use-when="${'$'}{groovy:oper==null}"  widget-style="${required!} number" title="${title!}">
					<text />
				</field>		
				<#elseif editFieldType.equals("select")>
	
				<field name="${field}"   widget-style="" title="${displayName!}">
					<drop-down text-size="30"> 
						<entity-options description="${'$'}${'{'}${editFieldMap["editFieldRelName_"+field]!}${'}'}" entity-name="${editFieldMap["editFieldRelEntityName_"+field]!}"  key-field-name="${relFieldName!}"></entity-options>
					</drop-down>
				</field>
				<#elseif editFieldType.equals("lookup")>
				<field name="${field}" use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}" widget-style="${required!} " title="${displayName!}">
					<text disabled="true"/>
				</field>
				<field name="${field!}" use-when="${'$'}{groovy:oper==null}" widget-style="${required!}"  title="${displayName!}" >
					<lookup target-form-name="Lookup${editFieldMap["editFieldRelEntityName_"+field]!}"  description-field-name="${editFieldMap["editFieldRelName_"+field]!}" ></lookup>
				</field>
				<#elseif editFieldType.equals("hidden")>
				<field name="${field}">
					<hidden />
				</field>
				<#elseif editFieldType.equals("enum")>
				
				<field name="${field!}" widget-style="${required!}" title="${title!}">
					<drop-down allow-empty="true">
						<entity-options entity-name="Enumeration" cache="true" description="${r"${description}"}" key-field-name="enumId">
							<entity-constraint name="enumTypeId" operator="equals" value="${editFieldMap["editEnumType_"+field]}" />
							<entity-order-by field-name="enumId" />
						</entity-options>
					</drop-down>
				</field>
				<#elseif editFieldType.equals("whether")>
				<field name="${field}" use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}" widget-style="${required!} " title="${title!}">
					<text disabled="true"/>
				</field>
				<field name="${field!}"  use-when="${'$'}{groovy:oper==null}" widget-style=" ${required!}" title="${title!}">
					<drop-down text-size="30" allow-empty="false" no-current-selected-key="Y">
						<option key="Y" description="${r"${uiLabelMap.CommonYes}"}" />
						<option key="N" description="${r"${uiLabelMap.CommonFalse}"}" />
					</drop-down>
				</field>
				<#elseif editFieldType.equals("file")>
				<field name="${field}" use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}" widget-style="${required!} " title="${title!}">
					<text disabled="true"/>
				</field>
				<field name="${field}"  use-when="${'$'}{groovy:oper==null}" widget-style="${required!}" title="${title!}"><file/></field>
				<#elseif editFieldType.equals("textarea")>
				<field name="${field}"  use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}" title="${title!}" widget-style="${required!}">
					<textarea disabled="true"/>
				</field>
				<field name="${field}"  use-when="${'$'}{groovy:oper==null}"  title="${title!}" widget-style="${required!}">
					<textarea />
				</field>
				<#else>
				<field name="${field}" use-when="${'$'}{groovy:(oper!=null&amp;amp;&amp;amp;oper.equals(&amp;quot;view&amp;quot;));}" widget-style="${required!}" title="${title!}" >
					<text  disabled="true"/>
				</field>
				<field name="${field}" use-when="${'$'}{groovy:oper==null}" widget-style="${required!}" title="${title!}">
					<text  />
				</field>
				</#if>
			</#list> 
		</form>
		</#if>
		<#list editField as field>
			<#assign editFieldType=editFieldMap["editFieldType_"+field]>
			<#if editFieldType.equals("lookup")>
				<form name="LookupFind${editFieldMap["editFieldRelEntityName_"+field]!}" type="single" client-autocomplete-fields="true" style="pageForm" default-table-style="searchContent" target="Lookup${editFieldMap["editFieldRelEntityName_"+field]!}" default-entity-name="${editFieldMap["editFieldRelEntityName_"+field]!}">
					<field name="${editFieldMap["editFieldRelName_"+field]!}" title="${displayName!}" position="1">
						<text-find hide-options="true" />
					</field>
				</form>
				<form name="Lookup${editFieldMap["editFieldRelEntityName_"+field]!}" type="list"   list-name="listIt" group-columns="false" separate-columns="false" use-row-submit="false"   paginate-target="Lookup${editFieldMap["editFieldRelEntityName_"+field]!}" default-entity-name="${editFieldMap["editFieldRelEntityName_"+field]!}" paginate-style="panelBar_dialog" default-table-style="table">
					<actions>
						<service service-name="performFind" result-map="result" result-map-list="listIt">
							<field-map field-name="inputFields" from-field="pCtx" />
							<field-map field-name="entityName" value="${editFieldMap["editFieldRelEntityName_"+field]!}" />
							<field-map field-name="viewIndex" from-field="viewIndex" />
							<field-map field-name="viewSize" from-field="viewSize" />
						</service>
					</actions>
					<#assign editFieldRelEntityName=editFieldMap["editFieldRelEntityName_"+field]>
					<#list relations as relation>
						<#if relation.relEntityName.equals(editFieldRelEntityName)>
							<#list relation.relEntity as relationField>
								<#if relationField['isPk'].equals("Y")>
								<field name="${ relationField['name']}"   id-name="${ relationField['name']}" title="${r"${uiLabelMap.CommSelectAll}"}">
									<check>
										<option key="{${'$'}${'{'}lookupId${'}'}:\'${'$'}${'{'}${ relationField['name']}${'}'}\',${editFieldMap["editFieldRelName_"+field]!}:\'${'$'}${'{'}${editFieldMap["editFieldRelName_"+field]!}${'}'}\'}" description=" " />
									</check>
								</field>
								</#if>
							</#list>
						</#if>
					</#list>
					<field name="${editFieldMap["editFieldRelName_"+field]!}" title="${displayName!}" sort-field="true">
						<display/>
					</field>
				</form>
			</#if>
		</#list>
		</textarea>
	</div>

<#if requestAttributes.parameters.formsType=="ftl">
	<div><h2>编辑FTL <button onclick="copyCode('area3');return false;">复制编辑FTL</button>
	${projectName}/webapp/${projectName}/${modelNameLower}/${entityName}_edit.ftl
	</h2>	
	<textarea cols='130' rows='15' id='area3'>
	<div class="pageContent" id="pageContent">
	<div id="screenlet-body" class="screenlet-body" layoutH="110">
	<form name="Edit${entityName}" method="post" action="${'<#'}if entity??>update${entityName}${'<#'}else>create${entityName}${'</#'}if${'>'}" 
		 id="${'<#'}if entity??>Edit${entityName}${'<#'}else>Create${entityName}${'</#'}if${'>'}" class="single_table"   >
			<input type="hidden" name="${entityId}" value="${'$'}${'{'}${entityId}?if_exists${'}'}" />
			<input type="hidden" name="navTabId" value="Find${entityName}" />
			<input type="hidden" name="callbackType" value="closeCurrent" />
			<table class="single_table_style" cellspacing="0">
				<tbody>
			<#list editField as field>
				<tr class="">
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
				<#assign relEntityId=''>

				<#assign displayName=''>
	  			    <#list relations as relation>
		  			    <#list relation.relEntity as entityFiled>
		  			    <#if entityFiled.isPk=='Y'>
		  			    	<#assign relEntityId=entityFiled.name>
		  			    </#if>
		  			    	<#if entityFiled.name==editFieldRelName>
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
				<#if editFieldType.equals("date")>
					<td class=""><span>${title!}</span></td>
					<td class="">
					<input name="${field}" class="${required!} date" readonly="true" type="text" value="${'<#'}if entity??&&entity.${field}??>${"$"}${"{"}entity.getString("${field}")}${'</#'}if${'>'}" ${'<'}#if oper?? && oper.equals('view')>disabled${'<'}/#if>/>
					</td>
				<#elseif editFieldType.equals("email")>
					<td class=""><span>${title!}</span></td>
					<td class="">
					<input name="${field}" class="${required!} email" type="text" value="${'<#'}if entity??>${"$"}${"{"}entity.${field}?if_exists}${'</#'}if${'>'}" ${'<'}#if oper?? && oper.equals('view')>disabled${'<'}/#if>/>
					</td>
				<#elseif editFieldType.equals("number")>
					<td class=""><span>${title!}</span></td>
					<td class="">
					<input name="${field}" class="${required!} number" type="text" value="${'<#'}if entity??>${"$"}${"{"}entity.${field}?if_exists}${'</#'}if${'>'}" ${'<'}#if oper?? && oper.equals('view')>disabled${'<'}/#if>/>
					</td>
				<#elseif editFieldType.equals("select")>
					<td class=""><span><#if editFieldType.equals("select")> ${displayName!}<#else>${title!}</#if></span></td>
					<td class="">
					<select name="${field}" class="">
		            	<option value=""></option>
		            		${'<#'}list ${editFieldMap["editFieldRelEntityName_"+field]!}List as relEntity>
		            			<option ${'<#'}if relEntity??&&entity??&&entity.${field}??&&relEntity.${relEntityId!}==entity.${field}>selected ${'<'}/#if>  
		            			value='${"$"}${"{"}relEntity.${relEntityId!}}'>
		            			${"$"}${"{"}relEntity.${editFieldMap["editFieldRelName_"+field]!}}</option>
		            		${'</#list>'}
		            </select>
		            </td>
				<#elseif editFieldType.equals("hidden")>
					<input name="${field}"  type="hidden" value="${r"${field?if_exists}"}" />
				
				<#elseif editFieldType.equals("lookup")>
					<td class="">${displayName!}:<input type="hidden"  value="" name="${field!}"> </td>
					<td class=""><input type="text" size="60" readonly lookupgroup="" name="${editFieldRelName!}" class="textInput"> 
					<a lookupgroup="" href="Lookup${editFieldMap["editFieldRelEntityName_"+field]!}?signle=Y&lookupId=${field!}" class="btnLook">查找带回</a>
					</td>
				<#elseif editFieldType.equals("enum")>
				 ${'<#'}assign enums = delegator.findByAndCache("Enumeration", {"enumTypeId" :"${editFieldMap["editEnumType_"+field]}" })?if_exists>
					<td class=""><span>${title!}</span></td>
					<td class="">
					<select name="${field}" class=""><option></option>
		            	${'<#'}if enums?has_content>
		            		${'<#'}list enums as enum> 
		            			<option ${'<#'}if entity??&&entity.${field}==enum.enumId>selected ${'<'}/#if>  value='${"$"}${"{"}enum.enumId!}'>${"$"}${"{"}enum.description!}</option>
		            		${'</#list>'}
		            	${'</#if>'}
		            </select>
					</td>
				<#elseif editFieldType.equals("whether")>
					<td class=""><span>${title!}</span></td>
					<td class="">
					<select name="${field}" class="">
		            	<option value="Y">${r"${uiLabelMap.CommonYes}"}</option>
						<option value="N">${r"${uiLabelMap.CommonFalse}"} </option>
		            </select>
		            </td>
				<#elseif editFieldType.equals("textarea")>
					<td class=""><span>${title!}</span></td>
					<td class="">
					<textarea id="${field}" name="${field}" rows="3" cols="60" class="textInput">${'<#'}if entity??>${"$"}${"{"}entity.${field}?if_exists}${"$"}${"{"}entity.${field}?if_exists}${'<'}/#if><|textarea>
					</td>
				<#elseif editFieldType.equals("file")>
					<td class=""><span>${title!}</span></td>
					<td class="">
					<input type="file" id="${field}" name="${field}" ${'<'}#if oper?? && oper.equals('view')>disabled${'<'}/#if>/>
					</td>
				<#else>
					<td class=""><span>${title!}</span></td>
					<td class="">
					<input name="${field}" class="${required!}" type="text" value="${'<#'}if entity??>${"$"}${"{"}entity.${field}?if_exists}${'</#'}if${'>'}" ${'<'}#if oper?? && oper.equals('view')>disabled${'<'}/#if> />
					</td>
				</#if>
				</tr>
			</#list> 
			</tbody></table>
		</form>
		 </div> 
		<div class="formBar" >
			<ul>
			<li><a class="button"  onclick="javascript:submitFormsSimple('${'<#'}if entity??>Edit${entityName}${'<#'}else>Create${entityName}${'</#'}if${'>'}');"  ><span>保存</span></a></li>
				<li><div class="button"><div class="buttonContent"><button class="close" type="button">关闭</button></div></div></li>
			</ul>
		</div>  
	</div>
	</textarea>
	</div>
</#if>

<#if requestAttributes.parameters.listType=="ftl">
	<div><h2>列表FTL <button onclick="copyCode('area10');return false;">复制列表FTL</button>
	${projectName}/webapp/${projectName}/${modelNameLower}/${entityName}_list.ftl
	</h2>	
	<textarea cols='130' rows='15' id='area10'>
	<div class="pageHeader">
	<form  id='${'$'}${'{'}searchForm!}' action="${'$'}${'{'}searchAction}" method="post">
	<div class="searchBar">
		<div class="subBar">
		<table class="searchContent">
			<tr>
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
		  			    	
		  			    	<#if entityFiled.isPk=='Y'>
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
					<input type="text" name="${field!}" class='date' value='${'$'}${'{'}queryStringMap.${field!}!}'/>
				<#elseif editFieldType.equals("hidden") >
					<input type='hidden' name='${field!}'>
				<#elseif editFieldType.equals("select") >
					${displayName!}：<select name="${field}" class="">
		            	<option value=""></option>
		            		${'<#'}list ${editFieldMap["editFieldRelEntityName_"+field]!}List as relEntity>
		            			<option ${'<#'}if relEntity??&&relEntity.${relEntityId!}==queryStringMap.${field}>selected ${'<'}/#if>  
		            			value='${"$"}${"{"}relEntity.${relEntityId!}}'>
		            			${"$"}${"{"}relEntity.${editFieldMap["editFieldRelName_"+field]!}}</option>
		            		${'</#list>'}
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
			<ul>
				<li><a  href="#" onclick="javascript:searchNavTabForm('${'$'}${'{'}searchForm!}');" class="button"><span>查询</span></a></li>
				<li><a  href="#" onclick="javascript:resetForm('${'$'}${'{'}searchForm!}');" class="button"><span>重置</span></a></li>
				<li><a class="button" href="${'$'}${'{'}searchForm!}Advanced" target="dialog" mask="true" title="查询框"><span>高级检索</span></a></li>
			</ul>
		</div>
	</div>
	</form>
</div>
<div class="pageContent" >
	<div class="panelBar">
		<ul class="toolBar">
		<li><a class="add" href="Edit${entityName}" ><span>添加</span></a></li>
		</ul>
	</div>	
${'<#'}if ${entityName}List?exists>

  ${'<#'}if ${entityName}List?has_content>
   	<table class="table" width="100%" layoutH="138">
     <thead>
		<tr>
			<td width="10%"><input type="checkBox" class="checkboxCtrl" group="ids"></td>
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
				
	        <td ><#if listFieldType.equals("select")> ${displayName!}<#else>${title!}</#if></td></#list>	
	        <td >编辑</td>
	        <td >删除</td>
      </tr>
      </thead>
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
		  			    	 <#if entityFiled.isPk=='Y'>
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
					<td>${'<#if'} entityRow.${field!}??> ${'<#'}assign enum = delegator.findOne("Enumeration", Static["org.ofbiz.base.util.UtilMisc"].toMap("enumId", entityRow.${field!}), true)>
					${'$'}${'{'}enum.description}${'</#if>'}</td>
				<#elseif listFieldType.equals("select")||listFieldType.equals("lookup")>
					<td>${'<#if'} entityRow.${field!}??> ${'<#'}assign relEntity = delegator.findOne("${listFieldMap["listFieldRelEntityName_"+field]!}", Static["org.ofbiz.base.util.UtilMisc"].toMap("${relEntityId!}", entityRow.${field!}), true)>
					${'$'}${'{'}relEntity.${listFieldRelName}}${'</#if>'}</td>
					<#else>
					<td>${'$'}${'{'}entityRow.${field!}!}</td>
				</#if>
			
	        </#list>
	  <td><a title="编辑"  href="/lims/control/Edit${entityName}?${entityId}=${'$'}${'{'}entityRow.${entityId}!}" class="btnEdit">编辑</a></td>
	  <td><a title="删除" target="navTabTodo" href="/lims/control/deleteLims${entityName}?${entityId}=${'$'}${'{'}entityRow.${entityId}!}" class="btnDel">删除</a></td>
      </tr>
      ${'<#'}assign rowCount = rowCount + 1>
     
      ${'<#'}assign alt_row = !alt_row>
    ${'</#'}list>
    </table>
 
  ${'</#'}if>
${'</#'}if>  
<!--dwz  分页 -->      
${'<#'}include "component://lims/webapp/lims/includes/dwz_pagination.ftl"/>      
${'<'}@dwzPagin ${entityName}List listSize viewSize viewIndex  "Find${entityName}" "navTab"/>
</div>
	</textarea>
	</div>
</#if>

<div><h2>service.xml  [lims\servicedef\services_${modelNameLower}.xml]<button onclick="copyCode('area4');return false;">复制service.xml</button></h2>	
	<textarea cols='130' rows='15' id='area4'>
	<!--${entityTitle!} -->
	<#if requestAttributes.parameters.javaType.equals("simple")>
		<service name="create${entityName}" engine="simple" default-entity-name="${entityName}"
	             location="component://${projectName}/script/com/yuanh/${modelName}Services.xml" invoke="create${entityName}" auth="true">
	        <description>Create ${entityName}-${entityTitle!}</description>
	        <auto-attributes include="pk" mode="OUT" optional="false" />
			<auto-attributes include="nonpk" mode="IN" optional="true" />
	    </service>
	     <service name="update${entityName}" engine="simple" default-entity-name="${entityName}"
	             location="component://${projectName}/script/com/yuanh/${modelName}Services.xml" invoke="update${entityName}" auth="true">
	        <description>Update ${entityName}-${entityTitle!}</description>
	        <auto-attributes include="pk" mode="IN" optional="false" />
			<auto-attributes include="nonpk" mode="IN" optional="true" />
	    </service>
	    <service name="delete${entityName}" engine="simple" default-entity-name="${entityName}"
	             location="component://${projectName}/script/com/yuanh/${modelName}Services.xml" invoke="delete${entityName}" auth="true">
	        <description>Delete ${entityName}-${entityTitle!}</description>
	        <auto-attributes mode="IN" include="pk" optional="false"/>
	    </service>
	    <service name="deleteAll${entityName}" engine="simple" default-entity-name="${entityName}"
	             location="component://${projectName}/script/com/yuanh/${modelName}Services.xml" invoke="deleteAll${entityName}" auth="true">
	        <description>Delete ${entityName}-${entityTitle!}</description>
	        <attribute name="ids"  mode="IN" type="String" optional="false"/>
	    </service>
    <#else>
	    <service name="create${entityName}" engine="java" default-entity-name="${entityName}"
	     		location="org.extErp.${projectName}.${modelNameLower}.${entityName}Services" invoke="create${entityName}" auth="true">
	        <description>Create ${entityName}-${entityTitle!}</description>
	        <auto-attributes include="pk" mode="OUT" optional="false" />
			<auto-attributes include="nonpk" mode="IN" optional="true" />
	    </service>
	     <service name="update${entityName}" engine="java" default-entity-name="${entityName}"
	             location="org.extErp.${projectName}.${modelNameLower}.${entityName}Services" invoke="update${entityName}" auth="true">
	        <description>Update ${entityName}-${entityTitle!}</description>
	        <auto-attributes include="pk" mode="IN" optional="false" />
			<auto-attributes include="nonpk" mode="IN" optional="true" />
	    </service>
	    <service name="delete${entityName}" engine="java" default-entity-name="${entityName}"
	             location="org.extErp.${projectName}.${modelNameLower}.${entityName}Services" invoke="delete${entityName}" auth="true">
	        <description>Delete ${entityName}-${entityTitle!}</description>
	        <auto-attributes mode="IN" include="pk" optional="false"/>
	    </service>
    </#if>
    </textarea>
</div>
<#if requestAttributes.parameters.javaType.equals("simple")>
<div><h2>simple.xml [lims\script\com\yuanh\${modelName}Services.xml]<button onclick="copyCode('area5');return false;">复制simple.xml</button></h2>	
	<textarea cols='130' rows='15' id='area5'>
    <!--${entityTitle!} -->
    <simple-method method-name="create${entityName}" short-description="Create ${entityName}">
        <make-value entity-name="${entityName}" value-field="newEntity"/>
   	    <if-empty field="parameters.${entityId}">
        	<sequenced-id sequence-name="${entityName}" field="newEntity.${entityId}"/>
		</if-empty>

        <set-pk-fields map="parameters" value-field="newEntity"/>
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
    <simple-method method-name="delete${entityName}" short-description="Delete ${entityName}">
        <entity-one entity-name="${entityName}" value-field="${entityName}"/>
        <remove-value value-field="${entityName}"/>
    </simple-method>
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
	</textarea>
</div>
</#if>
<#if requestAttributes.parameters.javaType.equals("java")>
	<div><h2>java<button onclick="copyCode('area5');return false;">复制</button>
	org.extErp.${projectName}.${modelNameLower}.${entityName}Services.java
	</h2>	
	<textarea cols='130' rows='15' id='area5'>
		
package org.extErp.${projectName}.${modelNameLower};

import java.util.HashMap;
import java.util.Map;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;



public class ${entityName}Services {
		/**
		 * 保存数据
		 * 
		 * @param dctx
		 * @param context
		 * @return
		 * @throws GenericEntityException
		 */
	    public static Map<String, Object> create${entityName}(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
			Map result = new HashMap();
			try {
				Delegator delegator = dctx.getDelegator();
				String ${entityId} = delegator.getNextSeqId("${entityName}");
				GenericValue gv = delegator.makeValue("${entityName}", UtilMisc.toMap("${entityId}", ${entityId}));
				gv.setNonPKFields(context);
				gv.create();
				result.put("${entityId}",${entityId});
			} catch (Exception e) {
				e.printStackTrace();
			}
			return result;
		}
		/**
		 * 更新数据
		 * 
		 * @param dctx
		 * @param context
		 * @return
		 * @throws GenericEntityException
		 */
		public static Map<String, Object> update${entityName}(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
			Map result = new HashMap();
			Delegator delegator = dctx.getDelegator();
			String ${entityId} = (String) context.get("${entityId}");
			GenericValue gv = delegator.findOne("${entityName}",false, UtilMisc.toMap("${entityId}", ${entityId}));
			if (UtilValidate.isNotEmpty(gv)) {
				gv.setNonPKFields(context);
				gv.store();
			}
			return result;
		}
	    /**
		 * 删除数据
		 * 
		 * @param dctx
		 * @param context
		 * @return
		 * @throws GenericEntityException
		 */
		public static Map<String, Object> delete${entityName}(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
			Map result = new HashMap();
			Delegator delegator = dctx.getDelegator();
			String ${entityId} = (String) context.get("${entityId}");
			GenericValue gv = delegator.findOne("${entityName}",false, UtilMisc.toMap("${entityId}", ${entityId}));
			if (UtilValidate.isNotEmpty(gv)) {
				gv.remove();
			}
	
			return result;
		}
	}
	</textarea>
	</div>
</#if>

<div><h2>权限(LimsMgrSecurityData.xml)和菜单初始数据(MenuTreeData.xml) <button onclick="copyCode('area6');return false;">复制</button></h2>	
<textarea cols='130' rows='15' id='area6'>
	<SecurityPermission permissionId="${entityName}_ADMIN" description="${entityName}全部权限"/>
	<SecurityPermission permissionId="${entityName}_ADD" description="${entityName}增加权限"/>
	<SecurityPermission permissionId="${entityName}_VIEW" description="${entityName}查看权限"/>
	<SecurityPermission permissionId="${entityName}_UPDATE" description="${entityName}修改权限"/>
	<SecurityPermission permissionId="${entityName}_DELETE" description="${entityName}删除权限"/>
	<SecurityGroupPermission groupId="FULLADMIN" permissionId="${entityName}_ADMIN"/><!-- 给FULLADMIN权限组赋予${entityName}全部权限 -->
	 	
	<MenuTree id="Edit${entityName}" itemName="${entityTitle!}添加" urlLocation="lims/control/Edit${entityName}" parentItemId="${modelName}Mgr" permission="${entityName}_ADD"/>
	<MenuTree id="Find${entityName}" itemName="${entityTitle!}列表" urlLocation="lims/control/Find${entityName}" parentItemId="${modelName}Mgr" permission="${entityName}_VIEW"/>
</textarea>
</div>

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
