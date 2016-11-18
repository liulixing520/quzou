<#--
add by wangyg 实体引擎web页面创建
-->
<script language="javascript" src="/images/jquery/jquery-1.7.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/jquery-easyui-1.3.3/jquery.easyui.min-1.3.3.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
   <link rel="stylesheet"  href="/sysCommon/images/css/style.css" type="text/css"/>
   <link rel="stylesheet"  href="/flatgrey/maincss.css" type="text/css"/>
   <link rel="stylesheet"  href="/sysCommon/images/jquery-easyui-1.3.3/themes/icon.css" type="text/css"/>
   <link rel="stylesheet"  href="/sysCommon/images/jquery-easyui-1.3.3/themes/default/t_datagrid.css" type="text/css"/>
   <link rel="stylesheet"  href="/sysCommon/images/css/common.css" type="text/css"/>
 <link id="easyuiTheme" rel="stylesheet" href="/sysCommon/images/jquery-easyui-1.3.3/themes/default/easyui.css" type="text/css"></link> 
<h3>${entityName!}<input type="button" value="生成代码" onclick="javascript:document.ViewCode.submit();"/>
</h3>  
    <div class="screenlet">
      <div class="screenlet-title-bar">
        <ul>
          <li class="h3">实体创建</li>自定义规则表单
        </ul>
        <br class="clear"/>
      </div>
      <form action="<@ofbizUrl>CreateEntity</@ofbizUrl>" target="" id='entityForm' name='entityForm' onsubmit="return toSubmit();">
      <input type='hidden' name='rowCount'>
      <input type='hidden' name='userOper' value='${parameters.userOper!}'>
      <div class="screenlet-body">
        <table class="basic-table hover-bar" cellspacing='0'>
          <tr class="header-row">
			<td <#if parameters.userOper??>style='display:none'</#if> class="label">项目名称</td>
	        <td <#if parameters.userOper??>style='display:none'</#if>><input type="text" name="projectName" value="sysCommon"/></td>
	   
			<td <#if parameters.userOper??>style='display:none'</#if> class="label">模块名称</td>
	        <td <#if parameters.userOper??>style='display:none'</#if>><input type="text" name="modelName" value="demo"/></td>
            <td>包含流程</td><td><select style='width:60px;' name='hasWorkflow'><option value='N'>否</option><option value='Y'>是</option></select></td>
            <td>表名称</td><td><input type='text' name='entityName'></td>
            <td>表中文描述</td><td><input type='text' name='entityDes'></td>
            <td><input type='text' size='2' name='filedCount' value='1' id='filedCount' >:<input type='button' onclick="addFiled(document.getElementById('filedCount').value);" value='添加字段'></td>
          </tr>
        </table>
      </div>
      <div class="screenlet-body">
       
        <table class="basic-table hover-bar" id='filedTb' cellspacing='0'>
          <tr class="header-row">
            <td>字段名称</td>
            <td>字段中文描述</td>
            <td width='30%'>字段类型</td>
            <td>是否主键</td>
            <td>关联外键</td>
            <td>操作</td>
          </tr>
          <tr id="tr_1">
          	<td><input type="text" value='id' name="filedName"></td>
          	<td><input type="text" value='id主键' name="filedCnName"></td>
          	<td><select style="width:180px;" name="filedType">
          		<option value="indicator">CHAR(1)</option><option value="very-short">VARCHAR(10)</option><option value="short-varchar">VARCHAR(60)</option><option value="name">普通input-VARCHAR(100)</option><option value="description">文本-VARCHAR(255)</option>
          		<option value="very-long">大文本-LONGTEXT</option><option value="numeric">整数</option><option value="id-ne" selected="">主键</option><option value="date">日期</option><option value="date-time">时间</option><option value="currency-amount">浮点-DECIMAL(18,2)</option><option value="currency-precise">浮点-DECIMAL(18,3)</option>
          		</select></td>
          	<td><select name="isPKey"><option value="Y">是</option><option value="N">否</option><option></option></select></td>
          	<td><span style='display:none'><select name='isRef'><option></option></select></span></td>
          	<td><span style='display:none'><select name='relEntity'><option></option></select></span></td></tr>
        </table>
      </div>
      </form>
    </div>
    
   <div class="buttonBarOuter"> 
    		<div id='toolBar' class="buttonBar">
				<a class="l-btn"  onclick="document.entityForm.submit();" >
					<span class="l-btn-left">
						<span class="l-btn-text icon-save l-btn-icon-left">
							提交
						</span>
					</span>
				</a>
    		</div>
		</div>
		
    <script language='javascript'>	
    var entityListStr="";
    	<#if requestAttributes.entitiesList??>
    	<#list requestAttributes.entitiesList as entity>
    		<#if entity.viewEntity=='N'&&entity.entityName??>
	       	entityListStr+="<option value='${entity.entityName}'>${entity.title}<option>";		
	       	</#if>	
	    </#list>
	    </#if>
   		function addFiled(count){
   			var tbRowLen=$("#filedTb tr").length;
   			for(var i=0;i<count;i++){
   				var trStr="";
   				 trStr+="<td><input type='text' value='filed"+(i+tbRowLen-1)+"' name='filedName'></td>";
   				 trStr+="<td><input type='text' value='字段"+(i+tbRowLen-1)+"' name='filedCnName'></td>";
   				 trStr+="<td><select style='width:180px;' name='filedType'><option value='indicator'>CHAR(1)</option><option value='very-short'>VARCHAR(10)</option><option value='short-varchar' selected>普通文本-VARCHAR(60)</option><option value='name'>普通input-VARCHAR(100)</option><option value='description'>文本-VARCHAR(255)</option><option value='very-long'>大文本-LONGTEXT</option><option value='numeric'>整数</option>";
   				 trStr+="<option value='id-ne' >主键</option><option value='date'>日期</option><option value='date-time'>时间</option><option value='currency-amount'>浮点-DECIMAL(18,2)</option><option value='currency-precise'>浮点-DECIMAL(18,3)</option></select></td>";
   				 trStr+="<td><select name='isPKey'><option value='N'>否</option><option value='Y'>是<option/></select></td>";
   				 trStr+="<td><select name='isRef' onchange=\"changeRef(this,'"+(i+tbRowLen)+"')\"><option value='N'>否</option><option value='Y'>是<option/></select><span id='relEntity_"+(i+tbRowLen)+"' style='display:none'><select style='width:90px' name='relEntity' >"+entityListStr+"</select></span></td>";
   				 trStr+="<td><input type='button' value='删除' onclick=\"javascript:delFiled('tr_"+(i+tbRowLen)+"')\"></td>";
   				$("#filedTb").append("<tr id='tr_"+(i+tbRowLen)+"'>"+trStr+"</tr>");
   			}
   		}
   		jQuery(function() {
   			addFiled(2);
   		});
   		function delFiled(trId){
   			$("#"+trId).remove();
   		}
   		function changeRef(thisObj,num){
   			if(thisObj.value='Y'){
   				document.getElementById("relEntity_"+num).style.display="";
   			}else{
   				document.getElementById("relEntity_"+num).style.display="none";
   			}
   			//$("#relEntity_"+num).attr("display","");
   		}
   		function toSubmit(){
   			document.getElementById('entityForm').rowCount.value=$("#filedTb tr").length-1;
   			return true; 
   		}
	</script>    
