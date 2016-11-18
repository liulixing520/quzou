<#--

-->
<#assign relations=requestAttributes.relations>
<div class="screenlet-body">
<form method="post" name="ViewCode" target='_blank' action="<@ofbizUrl>ViewCode</@ofbizUrl>" class="basic-form">
	<input type="hidden" name="entityName" value="${entityName}"/>
	<table>
		 <tr><td><input type="submit" value="生成代码" onclick="javascript:document.ViewCode.submit();"/></td></tr>
		<tr><td colspan='4'><hr/></td></tr>
		<tr>
			<td class="label">项目名称</td>
	        <td><input type="text" name="projectName" value="sysCommon"/></td>
	   
			<td class="label">模块名称</td>
	        <td><input type="text" name="modelName" value="Demo"/></td>
			<td class="label">包名</td>
	        <td><input type="text" name="packageName" value="com.yuanh"/></td>
	   </tr>
	   <tr>
			<td class="label">编辑页面展现方式</td>
	        <td><input type="radio" checked name="formsType" value="forms"/>forms
	        <input type="radio"  name="formsType" value="ftl"/>ftl
	        </td>
	   		<td class="label">列表页面展现方式</td>
	        <td><input type="radio" checked name="listType" value="forms"/>forms
	        <input type="radio"  name="listType" value="ftl"/>ftl
	        </td>
			<td class="label">后台处理方式</td>
	        <td>
	        	<input type="radio" checked name="javaType" value="simple"/>simple
	      		<input type="radio" name="javaType" value="java"/>java
	        </td>
	   </tr>
	</table>
	
	<div class="easyui-tabs" style="width:700px;height:250px">
	<div id='editFormCommDiv' title="编辑form" >
	<table><tr>
	<td>是否带附件[multipart]</td><td><input type="radio" name="hasMultipart" value="Y"/>是
	        <input type="radio" name="hasMultipart" value="N" checked/>否</td>
	</tr>
	
	</table>
	
   <table cellspacing="0" class="basic-table hover-bar">
   		 <tr class="header-row">
   		 	<td style="width:30px"><input type="checkbox" name="" /></td>
            <td>字段名称</td>
            <td>显示名称</td>
            <td>是否必填项</td>
            <td width='20%'>样式</td>
            <td>顺序</td>
        </tr>
	   <#list requestAttributes.fieldList as field>
	   <#if field.isPk != 'Y'&&field.sqlType!='DATETIME'>
	   	<tr>
	   		<td><input type="checkbox" name="editField" checked value="${field.name}" /></td>
	  		<td>${field.name}</td>
	  		<td width='20%'>
	  		<#assign isRelation=false>
	  			    <#list relations as relation>
		  			    <#list relation.relFields as relfield>
		  			    	<#if relation.type?has_content&&relation.type=="one"&&field.name==relfield.fieldName>
		  			    	<#if  isRelation=false ><#assign isRelation=true></#if>
		  			    	<select name='editFieldRelName_${field.name}'>
		  			    	<#list relation.relEntity as entityFiled>
		  			    		<option value='${entityFiled.name}'>${entityFiled.description!}</option>
		  			    	</#list>
                            </select>
                            </#if>
                        </#list>
	  			    </#list>
	  			     <#if isRelation=false>
	                         <input type="text" name="editFieldDesc_${field.name}" value="${field.description!}" />
	                  </#if>
	  		</td>
	  		<input type='hidden' name='editFieldRelEntityName_${field.name}' 
		  			value='<#list relations as relation><#list relation.relFields as relfield><#if field.name==relfield.fieldName>${relation.relEntityName}</#if></#list></#list>'>
			  		
	  		<td><select name='editFieldRequired_${field.name}'>
	  			<option value='required'>是</option>
	  			<option value='' selected>否</option>
	  			</select></td>
	  		<td><select name='editFieldType_${field.name}' onchange="javascript:changeFieldType(this);" >
	  			<#if isRelation=false>
	  			<option value='text'>文本</option>
	  			<option value='textarea'>多行文本</option>
	  			<option value='email'>邮箱</option>
	  			<option value='date'>日期</option>
	  			<option value='number'>数字</option>
			  	<option value='enum'>枚举类型</option>
			  	<option value='whether'>是与否选择框</option>
			  	<option value='hidden'>隐藏字段</option>
			  	<option value='select'>下拉框选择</option>
			  	<option value='lookup'>弹出框选择</option>
			  	<option value='file'>附件</option>
	  			<#else>
	  			<option value='select'>下拉框选择</option>
			  	<option value='lookup'>弹出框选择</option>
			  	</#if>
	  			</select>
	  			<select  id='editEnumType_${field.name}'   name='editEnumType_${field.name}' style='width:100px;display:none'>
	  				<#list requestAttributes.enumTypes as enumType>
	  				<option value='${enumType.enumTypeId}'>${enumType.description}</option>
	  				</#list>
	  			</select>
	  			</td>
	  		<td><input type="text" size='3' name="editFieldSort_${field.name}" value="${field_index}" /></td>	
	  	</tr>
	  	</#if>
	  </#list>
	 
    </table>
    </div>   
  <!--当前表表头-->
	<div id='searchFormCommDiv' title="查询FORM" >
	<table border='1'><tr><td>是否包含高级查询</td><td><input type="radio" name="hasSearchAdvanced" value="Y"/>是
        <input type="radio" name="hasSearchAdvanced" value="N" checked/>否</td>
        </tr>
	</table>
		 <table cellspacing="0" class="basic-table hover-bar" >
		   		 <tr class="header-row">
		   		 	<td style="width:80px"><input type="checkbox" name="aa" />选择</td>
		   		 	<td style="width:80px"><input type="checkbox" name="aa" />高级查询</td>
		            <td>字段</td>
		            <td>顺序</td>
		        </tr>
			   <#list requestAttributes.fieldList as field>
			   	<#if field.isPk != 'Y'&&field.sqlType!='DATETIME'>
			   	<tr>
			   		<td><input type="checkbox" name="searchField" value="${field.name}" /></td>
			   		<td><input type="checkbox" name="searchAdvancedField" value="${field.name}" /></td>
			  		<td>${field.name}</td>
			  		<td><input type="text" size='3' name="searchFieldSort_${field.name}" value="${field_index}" /></td>		
			  	</tr>
			  	</#if>
			  </#list>
		    </table>
	</div>

	<div id='listFormCommDiv' title="列表FORM" >
	<table border='1'>
			<tr>
			<td colspan='6'>是否包含批量删除</td><td><input type="radio" name="hasDeleteAll" value="Y" checked/>是
	        <input type="radio" name="hasDeleteAll" value="N"/>否</td>
	        <td>是否包含新增</td><td><input type="radio" name="hasAdd" value="Y" checked/>是
	        <input type="radio" name="hasAdd" value="N"/>否</td>
	        <td>是否包含修改</td><td><input type="radio" name="hasEdit" value="Y" checked/>是
	        <input type="radio" name="hasEdit" value="N"/>否</td>
	        <td>是否包含删除</td><td><input type="radio" name="hasDelete" value="Y" checked/>是
	        <input type="radio" name="hasDelete" value="N"/>否</td>
	        <td>是否显示序号</td><td><input type="radio" name="hasCommSeq" value="Y" checked/>是
	        <input type="radio" name="hasCommSeq" value="N"/>否</td>
	        </tr>
	</table>
	
   <table cellspacing="0" class="basic-table hover-bar">
   		 <tr class="header-row">
   		 	<td style="width:30px"><input type="checkbox" name="" /></td>
            <td>字段</td>
        <!--<td>是否默认排序</td>-->
            <td>是否可排序</td>
        <!--<td>超链接路径</td>-->
		    <td>顺序</td>
        </tr>
	   <#list requestAttributes.fieldList as field>
	   	<#if field.isPk != 'Y'&&field.sqlType!='DATETIME'>
	   	<tr>
	   		<td><input type="checkbox" name="listField" checked  value="${field.name}" /></td>
			  		<td>${field.name}</td>
			  		
	  		<td><select name='listFieldHasSort_${field.name}'>
	  			<option value='true'>是</option>
	  			<option value='false'>否</option>
	  			</select></td>
	  		<!--<td><input type="text" name="listFieldLink_${field.name}" value="" /></td>-->	
	  		
		  		<td><input type="text" size='3' name="listFieldSort_${field.name}" value="${field_index}" /></td>
	  	</tr>
	  	</#if>
	  </#list>
	  <tr><td><input type="submit" value="生成代码" onclick="javascript:document.ViewCode.submit();"/></td></tr>
    </table>
    </div>  
    </div>  
    
           
    <!--表关系-->
    <div class="screenlet-title-bar">
	    <ul>
	      <li class="h3">${uiLabelMap.WebtoolsForEntity}: ${entityName}${uiLabelMap.WebtoolsRelations}</li>
	    </ul>
		<br class="clear"/>
	</div>
	<#if hasViewPermission>
        <table class="basic-table hover-bar" cellspacing="0">
            <tr class="header-row">
                <td>${uiLabelMap.WebtoolsTitle}</td>
                <td>${uiLabelMap.WebtoolsRelatedEntity}</td>
                <td>${uiLabelMap.WebtoolsRelationType}</td>
                <td>${uiLabelMap.WebtoolsFKName}</td>
                <td>${uiLabelMap.WebtoolsFieldsList}</td>
            </tr>
            <#assign alt_row = false>
            <#list relations as relation>
                <tr<#if alt_row> class="alternate-row"</#if>>
                    <td>${relation.title}</td>
                    <td class="button-col"><a href='<@ofbizUrl>FindGeneric?entityName=${relation.relEntityName}&amp;find=true&amp;VIEW_SIZE=50&amp;VIEW_INDEX=0</@ofbizUrl>'>${relation.relEntityName}</a></td>
                    <td>${relation.type}</td>
                    <td>${relation.fkName}</td>
                    <td>
                        <#list relation.relFields as field>
                            ${field.fieldName} -> ${field.relFieldName}<br />
                        </#list>
                    </td>
                </tr>
                <#assign alt_row = !alt_row>
            </#list>
        </table>
    <#else>
        <h3>${uiLabelMap.WebtoolsEntityCretePermissionError} ${entityName} ${plainTableName}.</h3>
    </#if>
</form>
<script language="JavaScript" type="text/javascript">
	function changeFieldType(thisObj){
		if(thisObj.value=='enum'){
			document.getElementById('editEnumType_'+thisObj.name.substring(14,thisObj.name.length)).style.display='';
		}else{
			document.getElementById('editEnumType_'+thisObj.name.substring(14,thisObj.name.length)).value='';
			document.getElementById('editEnumType_'+thisObj.name.substring(14,thisObj.name.length)).style.display='none';
		}
	}
</script>