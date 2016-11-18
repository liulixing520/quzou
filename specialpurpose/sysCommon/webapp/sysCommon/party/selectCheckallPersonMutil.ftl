<script language='javascript'>

	function selectedPerson(id,name){
		var partyIds = [];
		var partyNames = [];
		$('.onSelect').each(function() {
			partyIds.push($(this).attr("id"));
			partyNames.push($(this).text());
		});
		parent.$('#'+id).val(partyIds);
		parent.$('#'+name).val(partyNames);
		closeDialog('dialog');
	}
	function addPerson(partyId,firstName){
		$("#selectedUserDiv").append('<span style="display:block;width:95%;" onclick=deletePerson("'+partyId+'") title="点击删除" class="onSelect" id="'+partyId+'">'+firstName+'</span>');
	}
	function deletePerson(partyId){
		$("#"+partyId).remove();
	}
	function deleteAllPerson(){
		$("#selectedUserDiv span").remove();
	}
	function diaplayPerson(parentPartyId){
		$(".list_div_click").remove();
		$.ajax({
					type:"post",
					datatype:"json",
					url:"commonPerformFind?entityName=PersonAndPartyGroup&partyRelationshipTypeId=EMPLOYMENT&parentPartyId="+parentPartyId,
					cache:false,
					success:function(result){
						var data=result.rows;
							for(var i=0;i<data.length;i++){
								$("#rightcontent").append('<div class="list_div" title="'+data[i].firstName+'"><span class="list_div_click"  id="'+data[i].partyId+'"  onclick=addPerson("'+data[i].partyId+'","'+data[i].firstName+'") >'+data[i].firstName+'</span></div>');
						}
					}
				});	
		
	}
</script>
<style>
	.crossULdivright_lef {
	width: 49%;
	height: 100%;
	overflow: auto;
	float: left;
	border: 1px solid #808080;
	font-size: 12px;
	}
	.crossULdivright_rig {
	width: 39%;
	height: 100%;
	overflow: auto;
	float: right;
	border: 1px solid #808080;
	font-size: 12px;
	}
	.list_div {
	padding-left: 25px;
	border-bottom: 1px solid gray;
	margin-bottom: 5px;
	cursor: pointer;
	}
	.selectedUserDiv {
	height: 305px;
	padding-left: 25px;
	padding-bottom: 5px;
	cursor: pointer;
	}
	.onSelect {
	border-bottom: 1px solid gray;
	margin-top: 5px;
	cursor: pointer;
	}
</style>
<form id='searchForm_person' >
<div style="width: 650px;  margin:1px auto;">
	<div style="float: left;width:350px;" id="ext_quanxianzu">   
		<div id="tt" class="easyui-tabs" >
			<div title="用户查询" selected="true"   data-options="cache:false" style="padding:0px;">
				<div id="toolBar_person" style="padding:2px;">  
				 		<span style='color: #000000;'>姓名：</span><input name='firstName' type='text'>
				 		<input type='hidden' name='firstName_ic' value='Y'><input type='hidden' name='firstName_op' value='contains'>
				 		<a href="#" class="easyui-linkbutton" iconCls="icon-search"  onclick="searchGridForm('personTb','searchForm_person')">查询</a>
				</div> 	
				
				<div id="ext_datagrid">	
					<table id="personTb" class='easyui-datagrid'  toolBar='#toolBar_person'
						data-options="iconCls:'icon-edit',loadMsg:null,pagination:true,singleSelect:false,height:350,
						url:'commonPerformFind?entityName=PersonAndPartyGroup&partyRelationshipTypeId=EMPLOYMENT',
						 onDblClickRow:function(index,row){
			                addPerson(row.partyId,row.firstName);
			            }
						">
						<thead>
							<tr>
								<th data-options="field:'partyId',hidden:true">partyId</th>
								<th data-options="field:'firstName',width:80">姓名</th>
								<th data-options="field:'parentGroupName',width:80">部门</th>
							</tr>
						</thead>
					</table>
				</div>	
			</div>
			<div title="按部门查询"   data-options="cache:false" style="padding:0px;border:1">
				<div class="crossULdivright_lef">
				<ul id="partyGroupTree" class="easyui-tree" data-options="url:'ajaxGetPartyGroupTree',checkbox:false,
						lines : true,
						onClick: function(node){
								 diaplayPerson(node.id);
							}"
						></ul>
				</div>		
				<div class="crossULdivright_rig">
					<div id="right_btn" class="list_div1">
						<a class="l-btn"  onclick="selectedPerson('${parameters.id}','${parameters.name}');" >
							<span class="l-btn-left">
								<span class="l-btn-text icon-add l-btn-icon-left">
									添加所有
								</span>
							</span>
						</a>
					</div>
						<div id="rightcontent" style="padding-top: 5px; overflow: auto;">
						</div>
				</div>		
			</div>
		</div>	
	</div>
	<div class="crossULdivright_rig" id="ext_quanxianzu"> 
		
		<div class="list_div">
			<a class="l-btn"  onclick="deleteAllPerson();" >
				<span class="l-btn-left">
					<span class="l-btn-text icon-remove l-btn-icon-left">
						移除所有
					</span>
				</span>
			</a>	
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="l-btn"  onclick="selectedPerson('${parameters.id}','${parameters.name}');" >
				<span class="l-btn-left">
					<span class="l-btn-text icon-save l-btn-icon-left">
						确定
					</span>
				</span>
			</a>
		</div>
		<div style="background-color: #F6F7F9;padding-top: 5px;padding-left: 2px;text-align: left;vertical-align: middle;height: 22px;">已选择用户：</div>
		<div id="selectedUserDiv" class="selectedUserDiv">
			
		</div>
	</div>
	</div>
	
</div>
</form>   