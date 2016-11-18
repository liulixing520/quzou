<form id='searchForm' >
<div style="width: 650px;  margin:1px auto;">
	<div style="float: left;width:350px;">   
			<div>
				<div id="toolBar_person" style="padding:2px;">  
				 		<span style='color: #000000;'>班级名称：</span><input name='className' type='text'>
				 		<input type='hidden' name='className_ic' value='Y'><input type='hidden' name='className_op' value='contains'>
				 		<a href="#" class="easyui-linkbutton" iconCls="icon-search"  onclick="searchGridForm('tableTb','searchForm')">查询</a>
				</div> 	
				
				<div id="ext_datagrid">	
					<table id="tableTb" class='easyui-datagrid'  toolBar='#toolBar_person'
						data-options="iconCls:'icon-edit',loadMsg:null,pagination:true,singleSelect:false,height:350,
						url:'commonPerformFind?entityName=LimsClass',
						 onDblClickRow:function(index,row){
			                selectMutilAdd('selectedDiv',row.classId,row.className);
			            }
						">
						<thead>
							<tr>
								<th data-options="field:'classId',hidden:true">classId</th>
								<th data-options="field:'className',width:80">班级</th>
							</tr>
						</thead>
					</table>
				</div>	
			</div>
	</div>
	<div class="crossULdivright_rig"> 
		<div class="list_div">
			<a class="l-btn"  onclick="selectMutilRemoveAll('selectedDiv');" >
				<span class="l-btn-left">
					<span class="l-btn-text icon-remove l-btn-icon-left">
						移除所有
					</span>
				</span>
			</a>	
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="l-btn"  onclick="selectMutilSubmit('${parameters.id}','${parameters.name}');" >
				<span class="l-btn-left">
					<span class="l-btn-text icon-save l-btn-icon-left">
						确定
					</span>
				</span>
			</a>
		</div>
		<div style="selectedDivList">已选择：</div>
			<div id="selectedDiv" class="selectedDiv">
				
			</div>
		</div>
	</div>
	
</div>
</form>   