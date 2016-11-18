<script language='javascript'>
		var entityName='LimsStudentComplex';
		var gridTb='gridTb';
		var entityId='studentId';
		var deleteUrl='deleteAllLimsStudentComplex';
		$(function(){
			$('#'+gridTb).datagrid({
				url:'commonPerformFind?entityName='+entityName,
				title:'学生列表',
				pagination:true,
				toolbar:[{
					id:'btnadd',
					text:'学生增加',
					iconCls:'icon-add',
					handler:function(){
						openFrameTab('学生添加','EditLimsStudent') ;
					}
				},'-',{
					id:'btnremove',
					text:'批量删除',
					iconCls:'icon-remove',
					handler:function(){
						removeGridFun(gridTb,entityId,deleteUrl);
					}
				}]
			});
		});
		
		
	</script>
	
<div id='layoutDiv' class="easyui-layout" data-options="fit : true,border : false">
	<div  id='northDiv' data-options="region:'north',title:'查询条件',border:false,collapsed:true" style="height: 135px;" align="center">
		<form id="searchForm" name="searchForm" action='FindLimsStudentComplex'>
			<table class="tableForm">
				<tr>
					<th style="width: 170px;">学生名称</th>
						<td><input type="text" name="studentName" value='${queryStringMap.studentName!}'/>
						<input type="hidden" value="Y" name="studentName_ic">
						<input type="hidden" value="contains" name="studentName_op">
					</td>
				</tr>
				
				
			</table>
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchGridForm('gridTb','searchForm');">查询</a> 
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="resetGridForm('gridTb','searchForm');">重置</a>
		</form>
	</div>
	<div data-options="region:'center',border:false">
		<table id="gridTb">
			<thead>
			<tr>
				<th field="id" checkbox="true">id</th>
				<th field="studentName"  sortable="true" width="150">学生名称</th>
				<th field="studentEmail" width="150">邮箱</th>
				
			</tr>                          
		</thead>     
		</table>
	</div>
</div>	
	
