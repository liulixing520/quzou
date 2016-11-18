<script language="javascript" src="/images/jquery/jquery-1.7.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/jquery-easyui-1.3.3/jquery.easyui.min-1.3.3.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
   <link rel="stylesheet"  href="/sysCommon/images/css/style.css" type="text/css"/>
   <link rel="stylesheet"  href="/flatgrey/maincss.css" type="text/css"/>
   <link rel="stylesheet"  href="/sysCommon/images/jquery-easyui-1.3.3/themes/icon.css" type="text/css"/>
   <link rel="stylesheet"  href="/sysCommon/images/jquery-easyui-1.3.3/themes/default/t_datagrid.css" type="text/css"/>
   <link rel="stylesheet"  href="/sysCommon/images/css/common.css" type="text/css"/>
 <link id="easyuiTheme" rel="stylesheet" href="/sysCommon/images/jquery-easyui-1.3.3/themes/default/easyui.css" type="text/css"></link> 
<#assign relations=requestAttributes.relations>
<#assign xmlMap=Static["org.ofbiz.base.util.UtilXml"].fromXml(entity.xmlMap)>
<h1>${entityName!}<input type="button" value="生成代码片段" onclick="javascript:document.ViewCode.submit();"/></h1>
<form method="post" name="ViewCode" target='_blank' action="<@ofbizUrl>ViewCodeJeasy</@ofbizUrl>" class="basic-form">
<input type="hidden" name="entityName" value="${entityName}"/>
<div class="easyui-tabs" style="width:1100px;height:550px"> 
<div title="配置项" style="padding:10px">
	<table  class="basic-table" cellspacing="0">
		<tr <#if userOper?has_content>style='display:none'</#if>>
			<td class="label">包名</td>
	        <td><input type="text" name="packageName" value="${xmlMap.packageName!'com.yuanh'}"/></td>
			<td class="label">项目名称:</td>
	        <td><input type="text" name="projectName" value="${xmlMap.projectName!'sysCommon'}"/></td>
			<td class="label">模块名称:</td>
	        <td><input type="text" name="modelName" value="${xmlMap.modelName!'Demo'}"/></td>
			
	   </tr>
	   <tr <#if userOper?has_content>style='display:none'</#if>>
			<td class="label">编辑页面展现方式:</td>
	        <td>
	        <input type="radio"  <#if xmlMap.formsType=='ftl'>checked</#if> name="formsType" value="ftl"/>ftl
	        <input type="radio" <#if xmlMap.formsType=='forms'>checked</#if> checked name="formsType" value="forms"/>forms
	        </td>
	   		<td class="label">列表页面展现方式:</td>
	        <td><input type="radio" <#if xmlMap.listType=='forms'>checked</#if> checked name="listType" value="forms"/>forms
	        <input type="radio" <#if xmlMap.listType=='ftl'>checked</#if> name="listType" value="ftl"/>ftl
	        <input type="radio" <#if xmlMap.listType=='Jeasy'>checked</#if>  name="listType" value="Jeasy"/>Jeasy
	        </td>
			<td class="label">后台处理方式:</td>
	        <td>
	      		<input type="radio" <#if xmlMap.javaType=='java'>checked</#if>  name="javaType" value="java"/>java
	        	<input type="radio" <#if xmlMap.javaType=='simple'>checked</#if> checked name="javaType" value="simple"/>simple
	        </td>
	   </tr>
	   <tr >    
	        <td class="label">是否生成LOOKUP:</td>
	        <td>
	      		<input type="radio" <#if xmlMap.hasLookup=='Y'>checked</#if> checked name="hasLookup" value="Y"/>是
	        	<input type="radio"<#if xmlMap.hasLookup=='N'>checked</#if> name="hasLookup" value="N"/>否
	        </td>
	        <td class="label">是否弹出框操作:</td>
	        <td>
	        	<input type="radio"<#if xmlMap.hasDialog=='N'>checked</#if> checked name="hasDialog" value="N"/>否
	      		<input type="radio" <#if xmlMap.hasDialog=='Y'>checked</#if>  name="hasDialog" value="Y"/>是
	        </td>
	        <td class="label">是否带附件[multipart]:</td>
	        <td>
	        	<input type="radio"<#if xmlMap.hasMultipart=='Y'>checked</#if> name="hasMultipart" value="Y"/>是
	            <input type="radio"<#if xmlMap.hasMultipart=='Y'>checked</#if> name="hasMultipart" value="Y" checked/>否
	        </td>
	   </tr>
	  <tr> 
	   		
        	<td class="label">是否包含批量删除:</td>
	        <td><input type="radio"<#if xmlMap.hasDeleteAll=='Y'>checked</#if> name="hasDeleteAll" value="Y" checked/>是
	        	<input type="radio"<#if xmlMap.hasDeleteAll=='N'>checked</#if> name="hasDeleteAll" value="N"/>否
	        </td>
	        <td class="label">是否包含新增:</td>
	        <td><input type="radio"<#if xmlMap.hasAdd=='Y'>checked</#if> name="hasAdd" value="Y" checked/>是
	        	<input type="radio"<#if xmlMap.hasAdd=='N'>checked</#if> name="hasAdd" value="N"/>否|
	        </td>
	       
	        <td>是否包含修改:</td>
	        <td><input type="radio"<#if xmlMap.hasEdit=='Y'>checked</#if> name="hasEdit" value="Y" checked/>是
	        	<input type="radio"<#if xmlMap.hasEdit=='N'>checked</#if> name="hasEdit" value="N"/>否|
	      	 </td>
	      	</tr>
	  		<tr>  
	        <td> 是否包含删除:</td>
	        <td><input type="radio"<#if xmlMap.hasDelete=='Y'>checked</#if> name="hasDelete" value="Y" checked/>是
	        	<input type="radio"<#if xmlMap.hasDelete=='N'>checked</#if> name="hasDelete" value="N"/>否|
	        	</td>
	        <td>是否显示序号:</td>
	        <td ><input type="radio"<#if xmlMap.hasCommSeq=='Y'>checked</#if> name="hasCommSeq" value="Y" checked/>是
	        	<input type="radio"<#if xmlMap.hasCommSeq=='N'>checked</#if> name="hasCommSeq" value="N"/>否
	        </td>
	        <td class="label">是否逻辑删除:</td>
	        <td>
	      		<input type="radio"<#if xmlMap.isLogicDelete=='Y'>checked</#if> checked  name="isLogicDelete" value="Y"/>是
	        	<input type="radio"<#if xmlMap.isLogicDelete=='N'>checked</#if>  name="isLogicDelete" value="N"/>否
	        </td>
	        <td style='display:none'>  是否包含高级查询:<input type="radio" name="hasSearchAdvanced" value="Y"/>是
        	<input type="radio"name="hasSearchAdvanced" value="N" checked/>否| 
        	<input type="hidden" name="hasSearchAdvanced" value="N" > </td>
        	
	   </tr>   
	   <tr>
	   		<td class="label">编辑页面列数:</td>
	        <td><input type="text" name="colNum" size='3' value="1"/></td>
	   		<td>包含流程</td>
	   		<td><select style='width:60px;' name='hasWorkflow'><option value='N'>否</option><option <#if parameters.hasWorkflow??&&parameters.hasWorkflow=='Y'>selected</#if> value='Y'>是</option></select></td>
	        <td></td><td></td><td></td><td></td></tr>  
	</table>
	<br class="clear"/>
	<#if relations?has_content>
    <li class="h4">${entityName!}对应关系-主从</li>
    <table class="basic-table hover-bar" cellspacing="0">
        <tr class="header-row">
        	<td>选择</td>
            <td>实体名称</td>
            <td>标题</td>
            <td>${uiLabelMap.WebtoolsRelationType}</td>
            <td>${uiLabelMap.WebtoolsFKName}</td>
            <td>${uiLabelMap.WebtoolsFieldsList}</td>
        </tr>
        <#assign alt_row = false>
        <#list relations as relation>
        	<#if relation.type='many'>
            <tr<#if alt_row> class="alternate-row"</#if>>
	            <td><input type="radio" onclick='selectedRef(this);' name="relationEntity"  value="${relation.relEntityName!}" /></td>
                <td class="button-col">${relation.relEntityName}</td>
                <td>${relation.title}</td>
                <td>${relation.type}</td>
                <td>${relation.fkName}</td>
                <td>
                    <#list relation.relFields as field>
                        ${field.fieldName} -> ${field.relFieldName}<br />
                    </#list>
                </td>
            </tr>
            </#if>
            <#assign alt_row = !alt_row>
        </#list>
    </table>
    </#if>
    <div id='girdDiv'>
    	
    </div>
</div>
<div title="编辑FORM" style="padding:10px">	
   <table cellspacing="0" class="basic-table hover-bar">
   		 <tr class="header-row">
   		 	<td style="width:30px"><input type="checkbox" checked id="allEditField"   onclick="selectAllFiled('allEditField','editField')"/></td>
            <td>字段名称</td>
            <td>显示名称</td>
            <td>是否必填项</td>
            <td width='20%'>样式</td>
            <td>顺序</td>
        </tr>
	   <#list requestAttributes.fieldList as field>
	   <#if field.isPk != 'Y'&&field.sqlType!='DATETIME'&&field.name!='nextActive'&&field.name!='joinPersonId'>
	   	<tr>
	   		<td><input type="checkbox"  name="editField" <#if xmlMap.editField?contains(field.name)>checked</#if> value="${field.name}" /></td>
	  		<td>${field.name}</td>
	  		<td width='20%'>
	  		<#assign isRelation=false>
	  			    <#list relations as relation>
		  			    <#list relation.relFields as relfield>
		  			    	<#if relation.type?has_content&&relation.type=="one"&&field.name==relfield.fieldName>
		  			    	<#if  isRelation=false ><#assign isRelation=true></#if>
		  			    	<select name='editFieldRelName_${field.name}'>
		  			    	<#list relation.relEntity as entityFiled>
		  			    	    <#if !(entityFiled.name=="createdStamp" || entityFiled.name=="createdTxStamp" || entityFiled.name=="lastUpdatedStamp" || entityFiled.name=="lastUpdatedTxStamp")>
		  			    		   <#assign editName=xmlMap["editFieldRelName_"+field.name]>
		  			    		   <option value='${entityFiled.name}' <#if editName==entityFiled.name>selected</#if> >${entityFiled.description!}</option>
		  			    		</#if>
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
	  			<option value='true'>是</option>
	  			<option value='false' selected>否</option>
	  			</select></td>
	  		<td><select name='editFieldType_${field.name}' onchange="javascript:changeFieldType(this);" >
	  			<#if isRelation=false>
	  					<#if field.javaType=='java.sql.Date'>
	  						<option value='date'>日期</option>
	  					<#elseif field.javaType=='Long'>	
	  						<option value='number'>数字</option>
	  					<#else>	
	  						<option value='text' <#if xmlMap["editFieldType_"+field.name]=='text'>selected</#if> >文本</option>
				  			<option value='textarea' <#if xmlMap["editFieldType_"+field.name]=='textarea'>selected</#if> >多行文本</option>
				  			<option value='email' <#if xmlMap["editFieldType_"+field.name]=='email'>selected</#if> >邮箱</option>
				  			<option value='date' <#if xmlMap["editFieldType_"+field.name]=='date'>selected</#if> >日期</option>
				  			<option value='number' <#if xmlMap["editFieldType_"+field.name]=='select'>selected</#if> >数字</option>
				  			<option value='digits' <#if xmlMap["editFieldType_"+field.name]=='digits'>selected</#if> >整数</option>
						  	<option value='enum' <#if xmlMap["editFieldType_"+field.name]=='enum'>selected</#if> >枚举类型</option>
						  	<option value='whether' <#if xmlMap["editFieldType_"+field.name]=='whether'>selected</#if> >是与否选择框</option>
						  	<option value='hidden' <#if xmlMap["editFieldType_"+field.name]=='hidden'>selected</#if> >隐藏字段</option>
						  	<option value='select' <#if xmlMap["editFieldType_"+field.name]=='select'>selected</#if> >下拉框选择</option>
						  	<option value='lookup' <#if xmlMap["editFieldType_"+field.name]=='lookup'>selected</#if> >弹出框选择</option>
						  	<option value='file' <#if xmlMap["editFieldType_"+field.name]=='file'>selected</#if> >附件</option>
	  					</#if>
	  			
	  			<#else>
	  			<option value='select' <#if xmlMap["editFieldType_"+field.name]=='select'>selected</#if>>下拉框选择</option>
			  	<option value='lookup' <#if xmlMap["editFieldType_"+field.name]=='lookup'>selected</#if>>弹出框选择</option>
			  	</#if>
	  			</select>
	  			<select  id='editEnumType_${field.name}'   name='editEnumType_${field.name}' <#if xmlMap["editEnumType_"+field.name]=='_NA_'>style='width:100px;display:none'</#if>>
	  				<#list requestAttributes.enumTypes as enumType>
	  				<option <#if xmlMap["editEnumType_"+field.name]==enumType.enumTypeId>selected</#if> value='${enumType.enumTypeId}'>${enumType.description}</option>
	  				</#list>
	  			</select>
	  			</td>
	  			<#assign editFieldSort=xmlMap["editFieldSort_"+field.name]>
	  		<td><input type="text" size='3' name="editFieldSort_${field.name}" value="${editFieldSort!}" /></td>	
	  	</tr>
	  	</#if>
	  </#list>
	 
    </table>
    </div>   
 <div title="查询FORM" style="padding:10px">
		 <table cellspacing="0" class="basic-table hover-bar" >
		   		 <tr class="header-row">
		   		 	<td style="width:80px"><input type="checkbox"  id="allFindField"   onclick="selectAllFiled('allFindField','searchField')"/>选择</td>
		   		 	<td style='display:none'><input type="checkbox"  id="allAdvFindField"   onclick="selectAllFiled('allAdvFindField','searchAdvancedField')" />高级查询</td>
		            <td>字段</td>
		            <td>顺序</td>
		        </tr>
			   <#list requestAttributes.fieldList as field>
			   	<#if field.isPk != 'Y'&&field.sqlType!='DATETIME'&&field.name!='nextActive'&&field.name!='joinPersonId'>
			   	<tr>
			   		<td><input type="checkbox" name="searchField" <#if xmlMap.searchField?contains(field.name)>checked</#if>   value="${field.name}" /></td>
			   		<td style='display:none'><input type="checkbox" name="searchAdvancedField" value="${field.name}" /></td>
			  		<td>${field.name}</td>
			  		<td><input type="text" size='3' name="searchFieldSort_${field.name}" value="${xmlMap["searchFieldSort_"+field.name]}" /></td>		
			  	</tr>
			  	</#if>
			  </#list>
		    </table>
	</div>
	<div title="列表FORM" style="padding:10px">
   <table cellspacing="0" class="basic-table hover-bar">
   		 <tr class="header-row">
   		 	<td style="width:30px"><input type="checkbox" checked id="allListField"   onclick="selectAllFiled('allListField','listField')" /></td>
            <td>字段</td>
        <!--<td>是否默认排序</td>-->
            <td>是否可排序</td>
        <!--<td>超链接路径</td>-->
		    <td>顺序</td>
        </tr>
	   <#list requestAttributes.fieldList as field>
	   	<#if field.isPk != 'Y'&&field.sqlType!='DATETIME'&&field.name!='nextActive'&&field.name!='joinPersonId'>
	   	<tr>
	   		<td><input type="checkbox" name="listField" <#if xmlMap.listField?contains(field.name)>checked</#if>    value="${field.name}" /></td>
			  		<td>${field.name}</td>
			  		
	  		<td><select name='listFieldHasSort_${field.name}'>
	  			<option value='true' <#if xmlMap["listFieldHasSort_"+field.name]=='true'>selected</#if> >是</option>
	  			<option value='false'<#if xmlMap["listFieldHasSort_"+field.name]=='false'>selected</#if> >否</option>
	  			</select></td>
	  		<!--<td><input type="text" name="listFieldLink_${field.name}" value="" /></td>-->	
	  		
		  		<td><input type="text" size='3' name="listFieldSort_${field.name}" value="${xmlMap["listFieldSort_"+field.name]}" /></td>
	  	</tr>
	  	</#if>
	  </#list>
	  <tr><td><input type="submit" value="生成代码" onclick="javascript:document.ViewCode.submit();"/></td></tr>
    </table>
    </div>  
</div>  
    
</form>
<script language="JavaScript" type="text/javascript">
	function  selectAllFiled(allId,nameIds) {
	if ($('#'+allId).is(":checked")) {
		$("input[name='"+nameIds+"']").attr("checked", true);
	} else {
		$("input[name='"+nameIds+"']").attr("checked", false);
	}
}
	function changeFieldType(thisObj){
		if(thisObj.value=='enum'){
			document.getElementById('editEnumType_'+thisObj.name.substring(14,thisObj.name.length)).style.display='';
		}else{
			document.getElementById('editEnumType_'+thisObj.name.substring(14,thisObj.name.length)).value='';
			document.getElementById('editEnumType_'+thisObj.name.substring(14,thisObj.name.length)).style.display='none';
		}
	}
	function selectedRef(thisObj){
		$.ajax({
					type:"post",
					datatype:"json",
					url:"getEntityFiled?entityName="+thisObj.value,
					cache:false,
					success:function(result){
						var  tableHtml="<table class='basic-table hover-bar'><tr class='header-row'><td>全选</td><td>字段</td></tr>";
						for(var i=0;i<result.fieldList.length;i++){
							var filed=result.fieldList[i];
							tableHtml+="<tr><td><input type='checkbox' name='selectedSubFiled' value='"+filed.name+"' checked></td><td>"+filed.description+"</td></tr>";
						}
						tableHtml+="</table>";
						$("#girdDiv").html(tableHtml);
					}
				});	
	}
</script>