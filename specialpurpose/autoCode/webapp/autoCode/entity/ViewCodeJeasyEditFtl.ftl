<div class="row-fluid sortable">
	<div class="box span12">
		<div class="box-content">
			<form name="Edit${entityName}" method="post" action="${'<#'}if entity??>update${entityName}<#if relationEntity??>And${relationEntity}</#if>${'<#'}else>create${entityName}<#if relationEntity??>And${relationEntity}</#if>${'</#'}if${'>'}" 
				 id="Edit${entityName}" class="form-horizontal"  <#if requestAttributes.parameters.hasMultipart.equals("Y")>enctype="multipart/form-data"</#if> >
					<#if relationEntity??>${'<'}#if entity??><input type="hidden" name="${entityId}" value="${'$'}${'{'}${entityId}?if_exists${'}'}" />${'<'}/#if>
					<#else><input type="hidden" name="${entityId}" value="${'$'}${'{'}${entityId}?if_exists${'}'}" />
					</#if>
					<table class="basic-table" cellspacing="0">
						<tbody>
					<#list editSortList as sortIndex> 
					<#assign field=editSortMap["sort_"+sortIndex]>
						<#if sortIndex_index==0><tr><#else><#if sortIndex_index%colNum==0></tr>
						<tr></#if></#if>
						<#assign editFieldType=editFieldMap["editFieldType_"+field]>
						<#assign editFieldRelName=''>
						<#assign required=''>
						<#if editFieldMap["editFieldRequired_"+field]?has_content&&editFieldMap["editFieldRequired_"+field]=="true">
							<#assign required= "required">
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
				  			    <#if entityFiled.isPk=='Y'&&entityFiled.name==field>
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
							<td class="label"><span>${title!}</span></td>
							<td >
							${'<#'}assign ${field}="">
							${'<#'}if entity??&&entity.${field}??>${'<#'}assign ${field}=entity.${field}>${'</#'}if>
							${'<@'}htmlTemplate.renderDateField name="${field}" title="Format: yyyy-MM-dd" value="${"$"}{${field}!}"/>
							</td>
						<#elseif editFieldType.equals("email")>
							<td class="label"><span>${title!}</span></td>
							<td >
							<input name="${field}" class="${required!} email"  type="text"  value="${'<#'}if entity??>${"$"}${"{"}entity.${field}?if_exists}${'</#'}if${'>'}" ${'<'}#if oper?? && oper.equals('view')>disabled${'<'}/#if>/>
							</td>
						<#elseif editFieldType.equals("number")>
							<td class="label"><span>${title!}</span></td>
							<td >
							<input name="${field}" class="${required!} number"  type="text" value="${'<#'}if entity??>${"$"}${"{"}entity.${field}?if_exists}${'</#'}if${'>'}" ${'<'}#if oper?? && oper.equals('view')>disabled${'<'}/#if>/>
							</td>
						<#elseif editFieldType.equals("digits")>
							<td class="label"><span>${title!}</span></td>
							<td >
							<input name="${field}" class="${required!} digits"  type="text" value="${'<#'}if entity??>${"$"}${"{"}entity.${field}?if_exists}${'</#'}if${'>'}" ${'<'}#if oper?? && oper.equals('view')>disabled${'<'}/#if>/>
							</td>
						<#elseif editFieldType.equals("select")>
							<td class="label"><span><#if editFieldType.equals("select")> ${displayName!}<#else>${title!}</#if></span></td>
							<td >
							<select name="${field}" style='width:120px'>
				            	<option value=""></option>
				            		${'<#'}list ${editFieldMap["editFieldRelEntityName_"+field]!}List as relEntity>
				            			<option ${'<#'}if relEntity??&&entity??&&entity.${field}??&&relEntity.${relFieldName!}==entity.${field}>selected ${'<'}/#if>  
				            			value='${"$"}${"{"}relEntity.${relFieldName!}}'>
				            			${"$"}${"{"}relEntity.${editFieldMap["editFieldRelName_"+field]!}}</option>
				            		${'</#list>'}
				            </select>
				            </td>
						<#elseif editFieldType.equals("hidden")>
							<input name="${field}"  type="hidden" value="${r"${field?if_exists}"}" />
						<#elseif editFieldType.equals("lookup")>
							<td class="label"><span>${title!}</span></td>
							<td >
							${'<#'}assign ${field}="">
							${'<#'}if entity??&&entity.${field}??>${'<#'}assign ${field}=entity.${field}>${'</#'}if>
							${'<@'}htmlTemplate.lookupField value='${'$'}{${field}?if_exists}' formName="Edit${entityName}"  name="${field!}"  fieldFormName="Lookup${editFieldMap["editFieldRelEntityName_"+field]!}"/>
							</td>
						<#elseif editFieldType.equals("enum")>
						 ${'<#'}assign enums = delegator.findByAndCache("Enumeration", {"enumTypeId" :"${editFieldMap["editEnumType_"+field]}" })?if_exists>
							<td class="label"><span>${title!}</span></td>
							<td >
							<select name="${field}" style='width:120px'><option></option>
				            	${'<#'}if enums?has_content>
				            		${'<#'}list enums as enum> 
				            			<option ${'<#'}if entity??&&entity.${field}??&&entity.${field}==enum.enumId>selected ${'<'}/#if>  value='${"$"}${"{"}enum.enumId!}'>${"$"}${"{"}enum.description!}</option>
				            		${'</#list>'}
				            	${'</#if>'}
				            </select>
							</td>
						<#elseif editFieldType.equals("whether")>
							<td class="label"><span>${title!}</span></td>
							<td >
							<select name="${field}" >
				            	<option value="Y" ${'<#'}if entity??&&entity.${field}??&&entity.${field}=='Y'>selected ${'<'}/#if>  >是</option>
								<option value="N" ${'<#'}if entity??&&entity.${field}??&&entity.${field}=='N'>selected ${'<'}/#if>  >否</option>
				            </select>
				            </td>
						<#elseif editFieldType.equals("textarea")>
							<td class="label"><span>${title!}</span></td>
							<td >
							<textarea id="${field}" name="${field}" rows="3" cols="60" class="textInput">${'<#'}if entity??>${"$"}${"{"}entity.${field}?if_exists}${'<'}/#if></textarea>
							</td>
						<#elseif editFieldType.equals("file")>
							<td class="label"><span>${title!}</span></td>
							<td >
							<input type="file" id="${field}" name="${field}" ${'<'}#if oper?? && oper.equals('view')>disabled${'<'}/#if>/>
							</td>
						<#else>
							<td class="label"><span>${title!}</span></td>
							<td >
							<input name="${field}" class="${required!}" type="text" value="${'<#'}if entity??>${"$"}${"{"}entity.${field}?if_exists}${'</#'}if${'>'}" ${'<'}#if oper?? && oper.equals('view')>disabled${'<'}/#if> />
							</td>
						</#if>
					</#list> 
					<#if requestAttributes.parameters.hasMultipart.equals("Y")>	
						</tr>
						${"<"}#if entity??>
						<tr>
							<td class="label"><span>附件查看</span></td>
							<td >
								${"<"}@htmlTemplate.fileLink documentPurpose="${entityName}"  entityIdValue="${"$"}{entity.${entityId}}"/>
							</td>
						</tr>
						${"<"}/#if>
						</tr>
						<tr>
							<td class="label"><span>附件</span></td>
							<td >
							<input type="file" name="filePath" <#if oper?? && oper.equals('view')>disabled</#if>/>
							</td>
					</#if>	
					</tr>
					<#if requestAttributes.parameters.hasWorkflow.equals("Y")>	
					${"<"}#if !parameters.oper??>	
					<!-- 工作流中下一步活动以及参与者选择 -->
				    ${"<"}#include "component://sysCommon/webapp/sysCommon/includes/wf/wf_common_mac.ftl"/>
					${"<"}@wfNextActivity  resultList 'Edit${entityName}' ''/>
					${"<"}/#if>
					${"<"}#include "component://sysCommon/webapp/sysCommon/includes/wf/wf_examine_trace.ftl"/>
					</#if>
					</tbody>
				</table>
				<#if !relationEntity??>
			</form>
		</div> 
	</div>	 
	${"<"}@htmlTemplate.submitButton formId="Edit${entityName}"  dialogId="${"$"}{parameters.dialogId!}" submitJs="${"$"}{submitJs!}" oper="${"$"}{parameters.oper!}"/>
				</#if>
	
	