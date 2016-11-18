<script type="text/javascript">
	$(function() {
		$('#admin_zygl_treegrid').treegrid({
			url : 'ajaxGetPartyGroupTreeAll',
			idField : 'id',
			treeField : 'text',
			parentField : 'pid',
			fit : true,
			fitColumns : true,
			border : false,
			frozenColumns : [ [ {
				title : '编号',
				field : 'id',
				width : 150,
				hidden : true
			}, {
				field : 'text',
				title : '部门名称',
				width : 200
			} ] ],
			columns : [ [  {
				field : 'sortNum',
				title : '排序',
				width : 50
			}, {
				field : 'pid',
				title : '上级部门ID',
				width : 150,
				hidden : true
			}, {
				field : 'pname',
				title : '上级部门',
				width : 80
			},  {
				field : 'barCode',
				title : '部门编号',
				width : 80
			},  {
				field : 'remark',
				title : '部门描述',
				width : 80
			}, {
				field : 'statusId',
				title : '状态',
				width : 80,
				formatter : function(value, row, index) {
					if(value=="Enabled"){
						return "启用";
					}else{
						return "禁用";
					}
				}
			}, {
				field : 'action',
				title : '修改',
				width : 50,
				formatter : function(value, row, index) {
					return formatString('<img onclick="admin_zygl_editFun(\'{0}\');" src="{1}"/>',row.id, '/sysCommon/images/jquery-easyui-1.3.3/themes/icons/pencil.png', row.id);
				}
			} , {
				field : 'assign',
				title : '分配部门负责人',
				width : 50,
				formatter : function(value, row, index) {
					return formatString('<img onclick="assignGroupLeader(\'{0}\');" src="{1}"/>',row.id, '/sysCommon/images/jquery-easyui-1.3.3/themes/icons/pencil.png', row.id);
				}
			} ] ],
			toolbar : [ {
				text : '增加',
				iconCls : 'icon-add',
				handler : function() {
					admin_zygl_appendFun();
				}
			}, '-',{
				text : '禁用',
				iconCls : 'icon-remove',
				handler : function() {
					admin_zygl_disabledFun();
				}
			}, '-',{
				text : '启用',
				iconCls : 'ext-icon-qy',
				handler : function() {
					admin_zygl_enabledFun();
				}
			}, '-', {
				text : '展开',
				iconCls : 'ext-icon-zk',
				handler : function() {
					var node = $('#admin_zygl_treegrid').treegrid('getSelected');
					if (node) {
						$('#admin_zygl_treegrid').treegrid('expandAll', node.cid);
					} else {
						$('#admin_zygl_treegrid').treegrid('expandAll');
					}
				}
			}, '-', {
				text : '折叠',
				iconCls : 'ext-icon-zd',
				handler : function() {
					var node = $('#admin_zygl_treegrid').treegrid('getSelected');
					if (node) {
						$('#admin_zygl_treegrid').treegrid('collapseAll', node.cid);
					} else {
						$('#admin_zygl_treegrid').treegrid('collapseAll');
					}
				}
			}, '-', {
				text : '刷新',
				iconCls : 'icon-reload',
				handler : function() {
					$('#admin_zygl_treegrid').treegrid('reload');
				}
			} ],
			onContextMenu : function(e, row) {
				e.preventDefault();
				$(this).treegrid('unselectAll');
				$(this).treegrid('select', row.id);
				$('#admin_zygl_menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});
	});

	function admin_zygl_appendFun() {
		var dialog =  $('<div/>').dialogext({
			href : 'EditPartyGroup',
			width : 500,
			height : 200,
			modal : true,
			title : '部门添加',
			buttons : [ {
				text : '保存',
				iconCls : 'icon-save',
				handler : function() {
					var d = $(this).closest('.window-body');
					var formId='admin_zyglAdd_addForm';
						if(jQuery("#" + formId).form('validate')){ 
							jQuery.ajax({
								url : jQuery("#" + formId).attr("action"),
								type : 'POST',
								data : jQuery("#" + formId).serializeArray(),
								error : function(msg) {
									// alert(msg);
								},
								success : function(msg) {
									$('#admin_zygl_treegrid').treegrid('reload');
									d.dialogext('destroy');
								}
							});
						}	
				}
			} ],
			onClose : function() {
				$(this).dialogext('destroy');
			}
		});
		dialog.parent().bgiframe();
	}
	function admin_zygl_editFun(id) {
		if (id != undefined) {
			$('#admin_zygl_treegrid').treegrid('select', id);
		}
		var node = $('#admin_zygl_treegrid').treegrid('getSelected');
		if(node){
			id=node.id;
		}
		var dialog =  $('<div/>').dialogext({
		href : 'EditPartyGroup?partyId='+id,
			width : 500,
			height : 200,
			modal : true,
			title : '部门编辑',
			buttons : [ {
				text : '保存',
				iconCls : 'icon-save',
				handler : function() {
					var d = $(this).closest('.window-body');
					var formId='admin_zyglAdd_addForm';
						if(jQuery("#" + formId).form('validate')){ 
							jQuery.ajax({
								url : jQuery("#" + formId).attr("action"),
								type : 'POST',
								data : jQuery("#" + formId).serializeArray(),
								error : function(msg) {
									// alert(msg);
								},
								success : function(msg) {
									$('#admin_zygl_treegrid').treegrid('reload');
									d.dialogext('destroy');
								}
							});
						}	
				}
			} ],
			onClose : function() {
				$(this).dialogext('destroy');
			},
			onLoad : function() {
				$('#admin_zyglAdd_addForm').form('load', node);
			}
		});
		dialog.parent().bgiframe();
	}
	function assignGroupLeader(id) {
		if (id != undefined) {
			$('#admin_zygl_treegrid').treegrid('select', id);
		}
		var node = $('#admin_zygl_treegrid').treegrid('getSelected');
		if(node){
			id=node.id;
		}
		var url='assignGroupLeader?partyGroupId='+id;
		operDialog(url,'','880','500');
		//openFrameTab('分配部门负责人',url);
		//lookupPerson('saveDepartLeader','');//回调函数saveDepartLeader
	}
	function saveDepartLeader(ids){
		$.ajax({
						url : 'assignGroupLeader?ids='+ids,
						cache : false,
						dataType : 'JSON',
						success : function(r) {
							
						}
					});
	}
	function admin_zygl_enabledFun() {
		var rows = $('#admin_zygl_treegrid').treegrid('getSelected');
		if (rows) {
		var ids = [];
			$.messager.confirm('确认', '您是否要启用吗？', function(b) {
				if (b) {
					
					$.ajax({
						url : 'updatePartyStatus?statusId=PARTY_ENABLED',
						data : {
							ids : rows.id
						},
						cache : false,
						dataType : 'JSON',
						success : function(r) {
							$('#admin_zygl_treegrid').treegrid('reload');
						}
					});
				}
			});
		} else {
			$.messager.alert('提示','请勾选要操作的记录！','warning');
		}	
	}
	function admin_zygl_disabledFun() {
		var rows = $('#admin_zygl_treegrid').treegrid('getSelected');
		if (rows) {
		var ids = [];
			$.messager.confirm('确认', '您是否要禁用吗？', function(b) {
				if (b) {
					
					$.ajax({
						url : 'updatePartyStatus?statusId=PARTY_DISABLED',
						data : {
							ids : rows.id
						},
						cache : false,
						dataType : 'JSON',
						success : function(r) {
							$('#admin_zygl_treegrid').treegrid('reload');
						}
					});
				}
			});
		} else {
			$.messager.alert('提示','请勾选要操作的记录！','warning');
		}	
	}
</script>
<table id="admin_zygl_treegrid"></table>
<div id="admin_zygl_menu" class="easyui-menu" style="width:120px;display: none;">
	<div onclick="admin_zygl_appendFun();" data-options="iconCls:'icon-add'">增加</div>
	<div onclick="admin_zygl_disabledFun();" data-options="iconCls:'icon-remove'">禁用</div>
	<div onclick="admin_zygl_editFun();" data-options="iconCls:'icon-edit'">编辑</div>
</div>