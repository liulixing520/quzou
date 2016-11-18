		
					<#if extendAttributeList??>
					<#list extendAttributeList as extendAttribute>
						<#if extendValueMap??><!-- 扩展属性值 -->
						<#assign extendValue=extendValueMap[extendAttribute.extendAttributeId]?if_exists>
						</#if>
						<#if (extendAttribute_index%3)==0>
							<tr class="background_tr">
							</#if>
						<td <#if (extendAttribute_index%3)==1>class="border13"<#else>class="label"</#if> >${extendAttribute.extendAttributeName!}</td>
						<td <#if (extendAttribute_index%3)==1>class="border12"<#else></#if>  >
						<#assign disType=extendAttribute.extendAttributeType>
						<#if disType=='text'||disType=='email'||disType=='date'||disType=='number'>
						<input type='${disType}' name='${extendAttribute.relEntityName!}^&&&^${extendAttribute.extendAttributeId!}' 
											value='<#if extendValueMap??>${extendValue!}</#if>'>
						<#elseif disType=='textarea'>
						<textarea id="sampleDisposeComment" name="sampleDisposeComment" rows="3" class="textInput">name='${extendAttribute.relEntityName!}^&&&^${extendAttribute.extendAttributeId!}' 
											value='<#if extendValueMap??>${extendValue!}</#if>'></textarea>
						<#else>
							<select name="${extendAttribute.relEntityName!}^&&&^${extendAttribute.extendAttributeId!}"><option></option>
		            	    
		            	<!-- 关联枚举数据-->
		            	<#if extendEnumMap??>
						<#assign extendEnums=extendEnumMap[extendAttribute.extendAttributeId]?if_exists>
						</#if>
		            	<#if extendEnums?has_content>
		            		<#list extendEnums as extendEnum>
		            			<option <#if extendValueMap??&&extendValue==extendEnum.enumId>selected</#if> value='${extendEnum.enumId}'>${extendEnum.description}</option>
		            		</#list>
		            	</#if>
		            	</select>
						</#if>
						</td>
						<#if (extendAttribute_index%3)==2>
							</tr>
							</#if>
					</#list>
					
					</#if>