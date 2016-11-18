<div class="row-fluid sortable">
	<div class="box span12">
		<div class="box-content">
			<form name="EditLimsClass" method="post" action="<#if entity??>updateLimsClassAndStudent<#else>createLimsClassAndStudent</#if>" 
				 id="EditLimsClass" class="form-horizontal"  >
					<#if entity??><input type="hidden" name="classId" value="${entity.classId?if_exists}" /></#if>
					<legend>班级信息</legend>
					<table class="basic-table" cellspacing="0">
						<tbody>
						<tr>
							<td class="label"><span>班级名称</span></td>
							<td >
							<input name="className" class='required' type="text" value="<#if entity??>${entity.className?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> />
							</td>
						</tr>
						<tr>
							<td class="label"><span>班主任</span></td>
							<td >
							<input name="classTeacher" class="" type="text" value="<#if entity??>${entity.classTeacher?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> />
							</td>
						</tr>
						<tr>
							<td class="label"><span>班次</span></td>
							<td >
							<input name="sortNo" class=" number"  type="text" value="<#if entity??>${entity.sortNo?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if>/>
							</td>
						</tr>
					
					</tbody></table>
					<br>
					<legend>学生列表  <button class="btn" onclick="javascript:commonAddRows('studentTable');return false;">新增</button></legend>
					<input type='hidden'  value='1' id='rowNum'>
		             
		            <table  id='studentTable' class="table table-bordered table-striped table-condensed">
		    			<tbody>
					    <tr class="header-row">
					    <td width='2%'>选择</td>
					    <td width='2%'>序号</td>
					    <td width='15%'>学生名称</td>
					    <td width='7%'>邮箱</td>
					    <td width='7%'>性别</td>
					    <td width='7%'>操作</td>
					    
					    </tr>
					    
						</tbody></table>
						
						<@htmlTemplate.submitButton formId="EditAffordability"  dialogId="${parameters.dialogId!}" submitJs="${submitJs!}" oper="${parameters.oper!}" isReset="yes" /> 
				</form>
		 </div> 
	 </div> 
</div>
<script language="JavaScript" type="text/javascript">
  $(function() { 
  		<#if entity??>
  		//ajax获取从表数据
  		$.ajax({
				type:"post",
				datatype:"json",
				url:"commonPerformFind?entityName=LimsStudent&classId=${entity.classId!}",
				cache:false,
				success:function(result){
					if(result.rows){
						for(var i=0;i<result.rows.length;i++){
							insertRows(i,result.rows[i]);
						}
					}
				}
			});	
  		<#else>
    	insertRows('0');
    	</#if>
    });
    //复制行-公用行数
	var rowUtil = new RowCopyUtility({tableId: "studentTable",rowGroupNumber: 1});
	var html_entity = new html_entity();
	var enumStr="";
	<#assign enums = delegator.findByAndCache("Enumeration", {"enumTypeId" :"DOCUMENT_TYPE" })?if_exists>
	<#list enums as enum>
    	enumStr+="<option value='${enum.enumId}'>"+html_entity.decodeHtml('${enum.description}')+"</option>";
    </#list>

//插入行 
function insertRows(rowIndex,rowData){
	var str="<tr id='row1_"+rowIndex+"'>";
	str+="<td align='center'><input type='checkbox' checked name='studentId_o_"+rowIndex+"' id='studentId_o_"+rowIndex+"'   value='"+((rowData&&rowData.studentId)?rowData.studentId:'')+"'></td>";
	str+="<td ><input type='text' size='1' readonly name='rowIndex' value='"+(parseInt(rowIndex)+1)+"'></td>";
	str+=commonFiledStr({size:10,name:'studentName',classStyle:'required'},rowIndex,rowData);
	str+=commonFiledStr({size:15,name:'studentEmail',classStyle:'email'},rowIndex,rowData);
	str+="<td ><select name='gender_o_"+rowIndex+"' id='gender_o_"+rowIndex+"'>"+enumStr+"</select></td>";
	str+="<td ><a href='#' onclick='javascript:copyRows(this);'>复制</a>&nbsp;<a href='#' onclick='javascript:commonDeleteRowsTable(this);'>删除</a>&nbsp;</td>";
	str+="</tr>";
	$("#studentTable tbody:last").append(str);
}		

//复制行-特殊赋值时使用
 function copyRows(thisObj) {
 	var thisIndex= commonGetRowIndexTable(thisObj);
 	var maxIndex=parseInt(commonGetMaxRowIndex('studentTable'))+1;
 	var data=[];
 	commonFiledData("studentName",thisIndex,data);
 	commonFiledData("studentEmail",thisIndex,data);
 	insertRows(maxIndex,data);
    commonRefreshRowNum();
 }   
</script>	