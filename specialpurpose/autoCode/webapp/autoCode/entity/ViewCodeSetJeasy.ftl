<link rel="stylesheet" href="/sysCommon/images/bootstrap/common.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/bootstrap/bootstrap-extends.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/bootstrap/web.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/bootstrap/web-osf.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/bootstrap/style.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/bootstrap/osf.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/bootstrap/jquery-ui-1.8.21.custom.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/jquery.jqGrid-4.4.3/css/ui.jqgrid.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/bootstrap/jqGrid.overrides.css" type="text/css"/>
<script language="javascript" src="/sysCommon/images/jquery/jquery-1.7.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/jquery.jqGrid-4.4.3/js/jquery.jqGrid.src.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/jquery.jqGrid-4.4.3/js/i18n/grid.locale-cn.js" type="text/javascript"></script>
<script language="javascript" src="/images/jquery/plugins/validate/jquery.validate.js" type="text/javascript"></script>
<script language="javascript" src="/images/jquery/plugins/validate/lib/jquery.form.js" type="text/javascript"></script>
<script language="javascript" src="/images/jquery/plugins/validate/localization/messages_cn.js" type="text/javascript"></script>
<script language="javascript" src="/images/jquery/plugins/dialog1.0.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/bootstrap/bootstrap-modal-hack2.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/bootstrap/bootstrap.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/bootstrap/jquery-ui-1.8.21.custom.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script language="javascript" src="/images/selectall.js" type="text/javascript"></script>
<script language="javascript" src="/images/fieldlookup.js" type="text/javascript"></script>
<script language="javascript" src="/images/common.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/js/html_entity.js" type="text/javascript"></script>
<!--[if lt IE 8]>
<link href="/sysCommon/images/bootstrap/oldie.css" rel="stylesheet">
<![endif]-->
<link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/group.css">
<!--[if lt IE 9]>
<script src="/sysCommon/images/bootstrap/html5shiv.js"></script>
<![endif]-->
<!--[if IE 8]>
<script src="/sysCommon/images/bootstrap/respond.min.js"></script>
<![endif]-->
<title>代码生成</title>
</head>
<div id="content-container" class="container ptz">
  <div class="es-row-wrap container-gap">
	  <div class="row">
	    <div class="col-md-12">
	      <div class="page-header"><h1>代码生成工具</h1></div>
	    </div>
	  </div>
	  <div class="row">
    	<div class="col-md-12">
<div class="panel panel-default panel-col">
<#assign relations=requestAttributes.relations>
<form method="post" name="ViewCode" target='_blank' action="<@ofbizUrl>ViewCodeJeasy</@ofbizUrl>" class="form-horizontal">
<input type="hidden" name="entityName" value="${entityName}"/>
<ul class="nav nav-tabs" id="myTab"  role="tablist"> 
	<li class="active"><a href="#tab1" role="tab" data-toggle='myTab'>配置项</a></li> 
    <li><a href="#tab2" data-toggle='myTab'role="tab">编辑FORM</a></li> 
    <li><a href="#tab3" data-toggle='myTab'role="tab">查询FORM</a></li> 
    <li><a href="#tab4" data-toggle='myTab'role="tab">列表FORM</a></li> 
</ul>    
<div class="tab-content"> 
	<div class="tab-pane active" id="tab1">
	<br>
	<table  class="basic-table" cellspacing="0">
		<tr <#if userOper?has_content>style='display:none'</#if>>
			<td class="label">包名</td>
	        <td><input type="text" name="packageName" value="org.ofbiz"/></td>
			<td class="label">项目名称:</td>
	        <td><input type="text" name="projectName" value="yxck"/></td>
			<td class="label">模块名称:</td>
	        <td><input type="text" name="modelName" value="Refer"/></td>
			
	   </tr>
	   <tr <#if userOper?has_content>style='display:none'</#if>>
			<td class="label">编辑页面展现方式:</td>
	        <td>
	        <input type="radio" checked  name="formsType" value="ftl"/>ftl
	        <input type="radio"  name="formsType" value="forms"/>forms
	        </td>
	   		<td class="label">列表页面展现方式:</td>
	        <td><input type="radio"  name="listType" value="forms"/>forms
	        <input type="radio"  name="listType" value="ftl"/>ftl
	        <input type="radio" checked  name="listType" value="grid"/>grid
	        </td>
			<td class="label">后台处理方式:</td>
	        <td>
	      		<input type="radio" checked  name="javaType" value="java"/>java
	        	<input type="radio"  name="javaType" value="simple"/>simple
	        </td>
	   </tr>
	   <tr >    
	        <td class="label">是否生成LOOKUP:</td>
	        <td>
	      		<input type="radio"  checked name="hasLookup" value="Y"/>是
	        	<input type="radio" name="hasLookup" value="N"/>否
	        </td>
	        <td class="label">是否弹出框操作:</td>
	        <td>
	        	<input type="radio" checked name="hasDialog" value="N"/>否
	      		<input type="radio"   name="hasDialog" value="Y"/>是
	        </td>
	        <td class="label">是否带附件[multipart]:</td>
	        <td>
	        	<input type="radio" name="hasMultipart" value="Y"/>是
	            <input type="radio" name="hasMultipart" value="N" checked/>否
	        </td>
	   </tr>
	  <tr> 
	   		
        	<td class="label">是否包含批量删除:</td>
	        <td><input type="radio" name="hasDeleteAll" value="Y" checked/>是
	        	<input type="radio" name="hasDeleteAll" value="N"/>否
	        </td>
	        <td class="label">是否包含新增:</td>
	        <td><input type="radio" name="hasAdd" value="Y" checked/>是
	        	<input type="radio" name="hasAdd" value="N"/>否
	        </td>
	       
	        <td class="label">是否包含修改:</td>
	        <td><input type="radio" name="hasEdit" value="Y" checked/>是
	        	<input type="radio" name="hasEdit" value="N"/>否|
	      	 </td>
	      	</tr>
	  		<tr>  
	        <td class="label"> 是否包含删除:</td>
	        <td><input type="radio" name="hasDelete" value="Y" checked/>是
	        	<input type="radio" name="hasDelete" value="N"/>否
	        	</td>
	        <td class="label">是否显示序号:</td>
	        <td ><input type="radio" name="hasCommSeq" value="Y" checked/>是
	        	<input type="radio" name="hasCommSeq" value="N"/>否
	        </td>
	        <td class="label">是否逻辑删除:</td>
	        <td>
	      		<input type="radio" checked  name="isLogicDelete" value="Y"/>是
	        	<input type="radio"  name="isLogicDelete" value="N"/>否
	        </td>
	        <td style='display:none'>  是否包含高级查询:<input type="radio" name="hasSearchAdvanced" value="Y"/>是
        	<input type="radio" name="hasSearchAdvanced" value="N" checked/>否
        	<input type="hidden" name="hasSearchAdvanced" value="N" > </td>
        	
	   </tr>   
	   <tr>
	   		<td class="label">编辑页面列数:</td>
	        <td><input type="text" name="colNum" size='3' value="1"/></td>
	   		<td class="label">包含流程</td>
	   		<td><select style='width:60px;' name='hasWorkflow'><option value='N'>否</option><option <#if parameters.hasWorkflow??&&parameters.hasWorkflow=='Y'>selected</#if> value='Y'>是</option></select></td>
	        <td></td><td></td><td></td><td></td></tr>  
	</table>
	<#if relations?has_content>
    <div class="page-header"><h1>${entityName!}对应关系-主从</h1></div>
    <table class="table table-bordered table-striped table-condensed" cellspacing="0">
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
<div class="tab-pane" id="tab2">
   <table cellspacing="0" class="table table-bordered table-striped table-condensed">
   		 <tr class="header-row">
   		 	<td style="width:30px"><input type="checkbox" checked id="allEditField"   onclick="selectAllFiled('allEditField','editField')"/></td>
            <td>字段名称</td>
            <td>显示名称</td>
            <td>是否必填项</td>
            <td width='20%'>样式</td>
            <td>顺序</td>
        </tr>
	   <#list requestAttributes.fieldList as field>
	   <#if field.name!='nextActive'&&field.name!='joinPersonId'>
	   	<tr>
	   		<td><input type="checkbox"  name="editField"  checked value="${field.name}" /></td>
	  		<td>${field.name}</td>
	  		<td width='25%'>
	  		<#assign isRelation=false>
	  			    <#list relations as relation>
		  			    <#list relation.relFields as relfield>
		  			    	<#if relation.type?has_content&&relation.type=="one"&&field.name==relfield.fieldName>
		  			    	<#if  isRelation=false ><#assign isRelation=true></#if>
		  			    	<select name='editFieldRelName_${field.name}' onchange='javascript:displayName()'>
		  			    	<#list relation.relEntity as entityFiled>
		  			    	    <#if !(entityFiled.name=="createdStamp" || entityFiled.name=="createdTxStamp" || entityFiled.name=="lastUpdatedStamp" || entityFiled.name=="lastUpdatedTxStamp")>
		  			    		   <option value='${entityFiled.name}'>${entityFiled.description!}</option>
		  			    		</#if>
		  			    	</#list>
                            </select>
                            </#if>
                        </#list>
	  			    </#list>
	  			    <input type="text" name="editFieldDesc_${field.name}" value="${field.description!}" />
	                  
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
	  						<option value='digits'>整数</option>
	  					<#elseif field.javaType=='java.math.BigDecimal'>	
	  						<option value='number'>数字</option>
	  					<#elseif (field.name.indexOf("Enum")!=-1)>	
	  						<option value='enum'>枚举类型</option>
	  					<#else>	
	  						<option value='text'>文本</option>
				  			<option value='textarea'>多行文本</option>
				  			<option value='email'>邮箱</option>
				  			<option value='date'>日期</option>
				  			<option value='number'>数字</option>
				  			<option value='digits'>整数</option>
						  	<option value='enum'>枚举类型</option>
						  	<option value='whether'>是与否选择框</option>
						  	<option value='hidden'>隐藏字段</option>
						  	<option value='select'>下拉框选择</option>
						  	<option value='lookup'>弹出框选择</option>
						  	<option value='file'>附件</option>
	  					</#if>
	  			
	  			<#else>
	  			<option value='select'>下拉框选择</option>
			  	<option value='lookup'>弹出框选择</option>
			  	</#if>
	  			</select>
	  			<select  id='editEnumType_${field.name}'   name='editEnumType_${field.name}' style='width:100px;<#if (field.name.indexOf("Enum")==-1)>display:none</#if>'>
	  				<#list requestAttributes.enumTypes as enumType>
	  				<option value='${enumType.enumTypeId}' <#if field.name==enumType.enumTypeId>selected</#if> >${enumType.description}</option>
	  				</#list>
	  			</select>
	  			</td>
	  		<td><input type="text" size='3' name="editFieldSort_${field.name}" value="${field_index}" /></td>	
	  	</tr>
	  	</#if>
	  </#list>
	 
    </table>
    </div>   
<div class="tab-pane" id="tab3">
		 <table cellspacing="0" class="table table-bordered table-striped table-condensed" >
		   		 <tr class="header-row">
		   		 	<td style="width:80px"><input type="checkbox"  id="allFindField"   onclick="selectAllFiled('allFindField','searchField')"/>选择</td>
		   		 	<td style='display:none'><input type="checkbox"  id="allAdvFindField"   onclick="selectAllFiled('allAdvFindField','searchAdvancedField')" />高级查询</td>
		            <td>字段</td>
		            <td>顺序</td>
		        </tr>
			   <#list requestAttributes.fieldList as field>
			   	<#if field.isPk != 'Y'&&field.javaType!='java.sql.Timestamp'&&field.name!='nextActive'&&field.name!='joinPersonId'>
			   	<tr>
			   		<td><input type="checkbox" name="searchField" value="${field.name}" /></td>
			   		<td style='display:none'><input type="checkbox" name="searchAdvancedField" value="${field.name}" /></td>
			  		<td>${field.name}</td>
			  		<td><input type="text" size='3' name="searchFieldSort_${field.name}" value="${field_index}" /></td>		
			  	</tr>
			  	</#if>
			  </#list>
		    </table>
	</div>
	<div class="tab-pane" id="tab4">
   <table cellspacing="0" class="table table-bordered table-striped table-condensed">
   		 <tr class="header-row">
   		 	<td style="width:30px"><input type="checkbox" checked id="allListField"   onclick="selectAllFiled('allListField','listField')" /></td>
            <td>字段</td>
        <!--<td>是否默认排序</td>-->
            <td>是否可排序</td>
        <!--<td>超链接路径</td>-->
		    <td>顺序</td>
        </tr>
	   <#list requestAttributes.fieldList as field>
	   	<#if field.isPk != 'Y'&&field.javaType!='java.sql.Timestamp'&&field.name!='nextActive'&&field.name!='joinPersonId'>
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
    </table>
    </div>  
</div>  
</form>
</div>  
 <button type="button" onclick="javascript:document.ViewCode.submit();" class="btn btn-fat btn-primary btn-large">生成代码</button>
</div>  
</div>  
</div>  
<script language="JavaScript" type="text/javascript">
	$(function () {
    	$('#myTab a').click(function (e) {
		  e.preventDefault()
		  $(this).tab('show')
		})
  	})
  	
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
						var  tableHtml="<table class='table table-bordered table-striped table-condensed'><tr class='header-row'><td>全选</td><td>字段</td></tr>";
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