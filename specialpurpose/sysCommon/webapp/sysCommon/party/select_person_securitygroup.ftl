<div id="toolBar_person" style="padding:2px;">  
			   <form id='searchForm_person' >
			 		<span style='color: #000000;'>姓名：</span><input name='firstName' type='text'>
			 		<input type='hidden' name='firstName_ic' value='Y'><input type='hidden' name='firstName_op' value='contains'>
			 		<a href="#" class="easyui-linkbutton" iconCls="icon-search"  onclick="searchGridForm('personTb','searchForm_person')">查询</a>
		 		</form>
</div> 	

<div id="ext_datagrid">	
	<table id="personTb" class='easyui-datagrid'  toolBar='#toolBar_person'
		data-options="iconCls:'icon-edit',loadMsg:null,pagination:true,singleSelect:${parameters.singleSelect!'false'},width:400,height:300,
		url:'commonPerformFind?entityName=PersonAndPartyGroupAndSecurityGroup&'+_selectPersonUrlParam">
		<thead>
			<tr>
				<th data-options="field:'partyId',checkbox:true,width:80">partyId</th>
				<th data-options="field:'userLoginId',width:80">用户名</th>
				<th data-options="field:'firstName',width:80">姓名</th>
		</tr>
		</thead>
	</table>
</div>	

