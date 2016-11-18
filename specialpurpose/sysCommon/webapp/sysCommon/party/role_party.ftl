 <script>
	function partyRole(){
		var ids=getSelected('tt','partyId');//通用获取datagrid中已选择的ids
						if (ids) {
								$.messager.confirm('确认', '您是否要批量授权吗？', function(b) {
									if (b) {
										$.ajax({
											url : 'roleToParty',
											data : {
												ids :ids,roleTypeId:'${parameters.roleTypeId!}'
											},
											cache : false,
											dataType : 'JSON',
											success : function(r) {
												if (r._ERROR_MESSAGE_) {
													$.messager.alert('错误', r._ERROR_MESSAGE_, 'error');
												}
												$('#selectTb').datagrid('reload');
											}
										});
									}
								});
							} else {
								$.messager.alert('提示','请勾选要操作的记录！','warning');
						}	
	}
	function deletePartyRole(){
		var ids=getSelected('selectTb','partyId');//通用获取datagrid中已选择的ids
			if (ids) {
								$.messager.confirm('确认', '您是否要批量授权吗？', function(b) {
									if (b) {
										$.ajax({
											url : 'removeRoleToParty',
											data : {
												ids :ids,roleTypeId:'${parameters.roleTypeId!}'
											},
											cache : false,
											dataType : 'JSON',
											success : function(r) {
												if (r._ERROR_MESSAGE_) {
													$.messager.alert('错误', r._ERROR_MESSAGE_, 'error');
												}
												$('#selectTb').datagrid('reload');
											}
										});
									}
								});
							} else {
								$.messager.alert('提示','请勾选要操作的记录！','warning');
							}
	}	
	</script>
<div style="width: 890px; height:400px; margin:20px auto;">
<div style="float: left;" id="ext_quanxianzu">    
           	<table id="tt" url="commonPerformFind?entityName=UserLoginAndPerson" title='授权' class="easyui-datagrid" pagination="true" toolbar="#toolBar"  style="width:420px;height:400px;">
				<thead>
					<tr>
						<th field="id" width="100" checkbox="true">id</th>
						<th field="partyId" width="100" hidden="true">id</th>
						<th field="userLoginId" width="100" >用户名</th>
						<th field="firstName" width="100">姓名</th>
					</tr>                          
				</thead>                                                     
			</table> 
			<div id="toolBar" style="padding:2px;">  
			   <form id='searchForm' >
			 		<span style='color: #000000;'>用户：</span><input name='userLoginId' type='text'>
			 		<input type='hidden' name='userLoginId_ic' value='Y'><input type='hidden' name='userLoginId_op' value='contains'>
			 		<a href="#" class="easyui-linkbutton" iconCls="icon-search"  onclick="searchGridForm('tt','searchForm')">查询</a>
		 		</form>
			</div> 
</div>
<div style="float: left; width: 50px; padding-top:150px;"  align="center">
<a href="#" title='授权' class="easyui-linkbutton" data-options="plain:true,iconCls:'ext-icon-right'"  onclick="javascript:partyRole();"></a>
<br>
<br>
<a href="#" title='删除授权' class="easyui-linkbutton" data-options="plain:true,iconCls:'ext-icon-left'"  onclick="javascript:deletePartyRole();"></a>
</div>
<div style="float: left;" id="ext_quanxianzu"> 
        	<table id="selectTb" class="easyui-datagrid" data-options="title:'已授权用户',pagination:true,url:'commonPerformFind?entityName=UserLoginAndRole&roleTypeId=${parameters.roleTypeId!}'" toolbar="#tb"  style="width:420px;height:400px;">
				<thead>
					<tr>
						<th field="id" width="20" checkbox="true">id</th>
						<th field="userLoginId" width="100">用户名</th>
						<th field="partyId" width="100" hidden="true">partyId</th>
						<th field="firstName" width="100">姓名</th>
					</tr>                          
				</thead>                                                   
			</table>
</div>
</div>
