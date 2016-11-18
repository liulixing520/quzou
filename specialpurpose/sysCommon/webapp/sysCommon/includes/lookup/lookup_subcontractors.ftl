
<div id='partyGroupToolBar'>	
		<form id='partyGroupSearchForm' >分包方名称:
	    <input name="groupName"  type='text' >  
	    <input type='hidden' name='groupName_ic' value='Y'><input type='hidden' name='groupName_op' value='contains'>
    	<a href="#" class="easyui-linkbutton"  iconCls="icon-search" plain="false" 
    		onclick="searchGridForm('partyGroupTb','partyGroupSearchForm');">查询</a> 
		</form>
	</div> 	
<div id="ext_datagrid">			
<table id="partyGroupTb" class='easyui-datagrid' 
data-options="pagination:true,toolbar:'partyGroupToolBar',height:350,singleSelect:false,
url:'commonPerformFind?entityName=PartyGroupAndPartyAndRole&roleTypeId=SUBCONTRACTOR'">
	<thead>
			<tr>
				<th data-options="field:'partyId',checkbox:true,width:80">partyId</th>
				<th data-options="field:'groupName',width:80">分包方名称</th>
		</tr>
		</thead>
	</table>
</div> 
