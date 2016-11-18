<script language='javascript'>
$(function(){
	$('#LimsStudent_gridTb').datagrid({
		url:'ajaxFindLimsStudent?thruDate_op=empty',
		//title:'学生列表',
		fit:true,
		pagination:true,
		toolbar:'#LimsStudent_gridTb_tb',
		fitColumns:true,
		loadMsg:null,
		pageSize:20,
		rownumbers:true,
		columns:[[
            	{field:'studentName',title:'学生姓名'},
            	{field:'studentEmail',title:'邮箱地址'},
            	{field:'seatNo',title:'座位号'},
            	{field:'birthDate',title:'出生年月'},
            	{field:'gender',title:'性别'},
            	{field:'sign',title:'星座'},
            	{field:'classId',title:' 班级名称'},
		        {field:'view',title:'查看',width:50,
		        	formatter : function(value, row, index) {
						return formatString('<a class="btnView" title="查看" href="EditLimsStudent?oper=view&studentId={0}"/>',row.studentId);
					}
		        },
		        {field:'delete',title:'删除',width:50,
		        	formatter : function(value, row, index) {
						return formatString('<a class="btnDel" title="删除" href="deleteLimsStudent?studentId={0}"/>',row.studentId);
					}
		        }
		]]
	});
});		
	function exportExcel(searchFormId){
		var params = searchFormToParam(searchFormId);
		window.open("ajaxFindLimsStudent?thruDate_op=empty&exportExcel=Y"+params);
	}
</script>
<@htmlTemplate.navTitle titleProperty/>
<table id="LimsStudent_gridTb" >
</table>
<div id="LimsStudent_gridTb_tb">
	<form id='LimsStudent_gridTb_search'>
			学生姓名：<input type="text" name="studentName" />
				<input type="hidden" value="Y" name="studentName_ic">
				<input type="hidden" value="contains" name="studentName_op">
				班级名称：<select name="classId" class="">
	            	<option value=""></option>
	            		<#list LimsClassList as relEntity>
	            			<option   
	            			value='${relEntity.classId}'>
	            			${relEntity.className!}</option>
	            		</#list>
	            </select>
	<a class="l-btn" onclick="javascript:searchGridForm('LimsStudent_gridTb','LimsStudent_gridTb_search');" href="javascript:void(0);">
		<span class="l-btn-left">
			<span class="l-btn-text icon-search l-btn-icon-left">
				查询
			</span>
		</span>
	</a>
	<a class="l-btn" onclick="javascript:exportExcel('LimsStudent_gridTb_search');" href="javascript:void(0);">
		<span class="l-btn-left">
			<span class="l-btn-text icon-search l-btn-icon-left">
				导出
			</span>
		</span>
	</a>
	</form>
	<a href="EditLimsStudent" class="easyui-linkbutton" iconCls="icon-add" >新增</a>
	
</div>	

