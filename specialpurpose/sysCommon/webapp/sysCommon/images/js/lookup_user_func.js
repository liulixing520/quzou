//添加自定义lookup-datagrid
//班级LOOKUP，一个lookup需要写一个js函数，此函数名称与forms中的lookup调用的target-form-name名称相同
function lookupLimsClass(fieldName){
	var gridTb=fieldName+'GridTb';//一个页面多个lookup的时候，第二个lookup名字需要改变
	var entityName='LimsClass';//通用查询的实体或实体的名称
	document.getElementById(fieldName+'toolBar').style.display='';//显示toolbar-div
	//toolbar添加到datagrid
	if($('#'+fieldName+'toolBar').html().indexOf('searchForm')==-1){//判断是否已有searchForm
		$("<div/>").html("<form id='searchForm' >" +
		 		"班级名称:<input name='className' type='text'>" +
		 		"<input type='hidden' name='className_ic' value='Y'><input type='hidden' name='className_op' value='contains'>" +
		 		"<a href='#' class='easyui-linkbutton'   onclick=\"searchGridForm('"+gridTb+"','searchForm')\">查询</a></form>")
		.appendTo($('#'+fieldName+'toolBar'));
	}
	$('#'+gridTb).datagrid({
			url: 'commonPerformFind?entityName='+entityName,//调用通用查找返回json
			title: '数据列表',
			width: 645,
			height: 320,
			loadMsg:null,
			singleSelect:true,//单选
			pagination:true,//分页
			toolbar:'#'+fieldName+'toolBar',//绑定toolBar
			columns:[[
				{field:'classId',title:'id',checkbox:true},
				{field:'className',title:'班级名称',width:180},
				{field:'classTeacher',title:'班主任',width:180}
			]]
		});
}
//添加自定义lookup-datagrid
//班级LOOKUP，一个lookup需要写一个js函数，此函数名称与forms中的lookup调用的target-form-name名称相同
//选择所有启用的部门
function lookupPartyGroup(fieldName,urlParam,singleSelect){
	var gridTb=fieldName+'GridTb';//一个页面多个lookup的时候，第二个lookup名字需要改变
	document.getElementById(fieldName+'toolBar').style.display='';//显示toolbar-div
	//toolbar添加到datagrid
	if($('#'+fieldName+'toolBar').html().indexOf('searchForm')==-1){//判断是否已有searchForm
		$("<div/>").html("<form id='"+fieldName+"_searchForm' >" +
		 		"机构名称:<input name='groupName' type='text'>" +
		 		"<input type='hidden' name='groupName_ic' value='Y'><input type='hidden' name='groupName_op' value='contains'>" +
		 		"<a href='#' class='easyui-linkbutton' iconCls='icon-search' plain='true' onclick=\"searchGridForm('"+gridTb+"','"+fieldName+"_searchForm')\">查询</a></form>")
		.appendTo($('#'+fieldName+'toolBar'));
		$.parser.parse('#'+fieldName+'_searchForm');
	}
	var suffix = "";
	if(urlParam!='undefined' && urlParam!=undefined)
		{
		suffix = urlParam;
		}
	$('#'+gridTb).datagrid({
			url: 'ajaxGetPartyGroup?roleTypeId=DEPARTMENT&statusId_op=notEqual&statusId=PARTY_DISABLED'+suffix,//调用通用查找返回json
			width: 450,
			height: 325,
			loadMsg:null,
			singleSelect:(singleSelect!=undefined&&singleSelect=='N')?false:true,//是否单选-默认单选
			pagination:true,//分页
			toolbar:'#'+fieldName+'toolBar',//绑定toolBar
			columns:[[
				{field:'partyId',title:'id',checkbox:true},
				{field:'groupName',title:'机构名称',width:180}
			]]
		});
}
//多选
function lookupMutilPartyGroup(fieldName,urlParam,singleSelect){
	var gridTb=fieldName+'GridTb';//一个页面多个lookup的时候，第二个lookup名字需要改变
	document.getElementById(fieldName+'toolBar').style.display='';//显示toolbar-div
	//toolbar添加到datagrid
	if($('#'+fieldName+'toolBar').html().indexOf('searchForm')==-1){//判断是否已有searchForm
		$("<div/>").html("<form id='searchForm' >" +
				"机构名称:<input name='groupName' type='text'>" +
				"<input type='hidden' name='groupName_ic' value='Y'><input type='hidden' name='groupName_op' value='contains'>" +
				"<a href='#' class='easyui-linkbutton' iconCls='icon-search' plain='true' onclick=\"searchGridForm('"+gridTb+"','searchForm')\">查询</a></form>")
				.appendTo($('#'+fieldName+'toolBar'));
	}
	var suffix = "";
	if(urlParam!='undefined' && urlParam!=undefined)
	{
		suffix = urlParam;
	}
	$('#'+gridTb).datagrid({
		url: 'ajaxGetPartyGroup?roleTypeId=DEPARTMENT&statusId_op=notEqual&statusId=PARTY_DISABLED'+suffix,//调用通用查找返回json
		width: 450,
		height: 325,
		loadMsg:null,
		singleSelect:false,//是否单选-默认单选
		pagination:true,//分页
		toolbar:'#'+fieldName+'toolBar',//绑定toolBar
		columns:[[
		          {field:'partyId',title:'id',checkbox:true},
		          {field:'groupName',title:'机构名称',width:180}
		          ]]
	});
}
//选择所有启用的登录用户部门以及下属部门
function lookupChildPartyGroup(fieldName,urlParam,singleSelect){
	lookupPartyGroup(fieldName,'&hasChild=Y',singleSelect);
}
//添加自定义lookup-datagrid
function lookupUserLogin(fieldName,urlParam,singleSelect){
	var gridTb=fieldName+'GridTb';//一个页面多个lookup的时候，第二个lookup名字需要改变
	var entityName='PersonAndUserLoginAndRole';//通用查询的实体或实体的名称
	document.getElementById(fieldName+'toolBar').style.display='';//显示toolbar-div
	//toolbar添加到datagrid
	if($('#'+fieldName+'toolBar').html().indexOf('searchForm')==-1){//判断是否已有searchForm
		$("<div/>").html("<form id='searchForm' >" +
		 		"用户名:<input name='groupName' type='text'>" +
		 		"<input type='hidden' name='groupName_ic' value='Y'><input type='hidden' name='groupName_op' value='contains'>" +
		 		"<a href='#' class='easyui-linkbutton' iconCls='icon-search' plain='true' onclick=\"searchGridForm('"+gridTb+"','searchForm')\">查询</a></form>")
		.appendTo($('#'+fieldName+'toolBar'));
	}
	$('#'+gridTb).datagrid({
			url: 'commonPerformFind?entityName='+entityName+'&roleTypeId=EMPLOYEE',//调用通用查找返回json
			width: 500,
			height: 320,
			loadMsg:null,
			singleSelect:(singleSelect!=undefined&&singleSelect=='N')?false:true,//是否单选-默认单选
			pagination:true,//分页
			toolbar:'#'+fieldName+'toolBar',//绑定toolBar
			columns:[[
				{field:'userLoginId',title:'id',checkbox:true},
				{field:'firstName',title:'用户名称',width:180}
			]]
		});
}
//选择部门树-返回函数
function assignDepartment(gridTb,backFun){
	var dialog =  $('<div/>').dialog({
		href : 'selectPartyGroupTree',//调用设备选择编辑页面operSample.ftl
		width : 500,
		height : 320,
		id:'departmentDialog',
		modal : true,
		title : '选择部门',
		buttons : [ {
			text : '确定',
			iconCls : 'icon-save',
			handler : function() {
				var d = $(this).closest('.window-body');
				var node = $('#partyGroupTree').tree('getSelected');
				if(node){
					eval(backFun+"('"+gridTb+"','"+node.id+"')");
					d.dialog('destroy');
				}else{
					$.messager.alert('提示','请选择部门！','warning');
				}
				
			}
		},{
			text:'关闭',
			iconCls:'icon-no',
			handler:function(){
				var d = $(this).closest('.window-body');
				d.dialog('destroy');
			}
		} ],
		onClose : function() {
			$(this).dialog('destroy');
		}
	});
	dialog.parent().bgiframe();
}
//选择人员-返回函数
function lookupPerson(gridTb,backFun){
	var dialog =  $('<div/>').dialog({
		href : 'selectPerson',//调用选择人员页面select_person.ftl
		width : 500,
		height : 320,
		id:'personDialog',
		modal : true,
		title : '选择人员',
		buttons : [ {
			text : '确定',
			iconCls : 'icon-save',
			handler : function() {
				var d = $(this).closest('.window-body');
				var ids=getSelected('personTb','partyId');
				if(ids){
					eval(backFun+"('"+gridTb+"','"+ids+"')");
					$("#personDialog").dialog('close');
				}else{
					$.messager.alert('提示','请选择人员！','warning');
				}
			}
		},{
			text:'关闭',
			iconCls:'icon-no',
			handler:function(){
				$("#personDialog").dialog('close');
			}
		} ],
		onClose : function() {
			$(this).dialog('destroy');
		}
	});
	dialog.parent().bgiframe();
}
//选择人员-带权限组-返回函数
function lookupPersonSecurityGroup(gridTb,backFun){
	var dialog =  $('<div/>').dialog({
		href : 'selectPersonSecurityGroup?singleSelect=true',//调用选择带权限组的用户页面select_person_securitygroup.ftl
		width : 500,
		height : 380,
		id:'personDialog',
		modal : true,
		title : '选择人员',
		buttons : [ {
			text : '确定',
			iconCls : 'icon-save',
			handler : function() {
				var d = $(this).closest('.window-body');
				var ids=getSelected('personTb','partyId');
				if(ids){
					eval(backFun+"('"+gridTb+"','"+ids+"')");
					$("#personDialog").dialog('close');
				}else{
					$.messager.alert('提示','请选择人员！','warning');
				}
			}
		},{
			text:'关闭',
			iconCls:'icon-no',
			handler:function(){
				$("#personDialog").dialog('close');
			}
		} ],
		onClose : function() {
			$(this).dialog('destroy');
		}
	});
	dialog.parent().bgiframe();
}