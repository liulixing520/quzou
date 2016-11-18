//弹出编辑框
function operEditDialog(initUrl, backJs, width, height,title) {
	  var dlgid = "dialog";
      var options = {};
      options.title = (title) ? title : "";
      options.width = (width) ? width : '780',
      options.height = (height) ? height : '390',
      options.callback = function(data) {
          //这是回调函数 ，data自行定义，在模态窗口关闭后对本页面进行操作 
    	  eval(backJs);
      };
      var url="";
       if (initUrl.indexOf("?") > -1)
             url = initUrl + "&dialogId="+ dlgid;
        else 
             url = initUrl + "?dialogId="+dlgid;
      jQuery.Dialog.open(url, dlgid, options)
}
//弹出编辑框
function operInnerDialog(initUrl, backJs, width, height) {
	var thisDialog=$('<div>').dialog({
        bgiframe: true,
        autoOpen: false,
        height: (height) ? parseInt(height) : 500,
        width: (width) ? parseInt(width) : 620,
        draggable: true,
        zIndex: 9999,
        resizeable: true,
        open: function(event,ui) {
            //waitSpinnerShow();
            //jQuery("#" + lookupId).empty();
            jQuery.ajax({
                type: "post",
                url: initUrl,
                cache: false,
                success: function(data) {
                	thisDialog.html(data);
                },
                error: function(xhr, reason, exception) {}
            });
        },
        close: function() {}
    });
	thisDialog.dialog("open");
}
function closeDialog(dialogId){
	parent.jQuery.Dialog.close(dialogId);
}
//弹出编辑框
function alertDialog(info,width, height) {
	
	var thisDialog=jQuery('<div>').dialog({
		modal : true,
		autoOpen: false,
		open : function() {
			thisDialog.html(info);
		},buttons: {  
			"确定": function () {  jQuery(this).dialog('close');},   
            "关闭": function () { jQuery(this).dialog('close');} 
        },  
		close: function () { thisDialog.dialog( 'remove' ) ; },  
		width : (width) ? width : '300',
		height : (height) ? height : '200',
		title : '提示'
	});
	thisDialog.dialog("open"); 
}

function alertDialogCall(info,width, height,callback) {
	var thisDialog=$('<div>').dialog({
		modal : true,
		autoOpen: false,
		open : function() {
			thisDialog.html(info);
		},buttons: {  
			"确定": function () {  
				$(this).dialog('close');
				if(callback!="" && callback!=null){
					window.location.href=callback;
				}
			},   
        },  
		close: function () { 
				thisDialog.dialog( 'remove' ) ;
			 	if(callback!="" && callback!=null){
					window.location.href=callback;
				}
			 },  
		width : (width) ? width : '300',
		height : (height) ? height : '200',
		title : '提示'
	});
	thisDialog.dialog("open"); 
}
//通用多选
function selectMutilCommon(url,id,name){
	var dlgid = "dialog";
	var options = {};
	options.title = "多选框";
	options.width =  '780',
	options.height = '420';
	var url=url+"?id="+id+"&name="+name;
	$.Dialog.open(url, dlgid, options)
}
/**
 * 选择人员
 * 选择后的回写id和name
 * single：单选Y,多选N
 * departmentId：部门id，为空则显示所有人员
 */
function selectCheckallPerson(id,name,single,departmentId){
	 var dlgid = "dialog";
     var options = {};
     options.title = "选择人员";
     options.width =  '780',
     options.height = '390';
     var url="selectCheckallPerson?id="+id+"&name="+name+"&parentPartyId="+((departmentId) ? departmentId :'')+"&single="+((single) ? single :'Y');
     $.Dialog.open(url, dlgid, options)
}
/**
 * 选择本部门人员
 * 选择后的回写id和name
 * single：单选Y,多选N
 */
function selectMyDepartmentPerson(id,name,single){
	var dlgid = "dialog";
	var options = {};
	options.title = "选择人员";
	options.width =  '780',
	options.height = '390';
	var url="selectCheckallPerson?id="+id+"&name="+name+"&selectRange=myDepartment&single="+((single) ? single :'Y');
	$.Dialog.open(url, dlgid, options)
}
//选择人员复杂查询
function selectCheckallPersonMutil(id,name,single){
	var dlgid = "dialog";
	var options = {};
	options.title = "选择人员";
	options.width =  '780',
	options.height = '420';
	var url="selectCheckallPersonMutil?id="+id+"&name="+name+"&single="+((single) ? single :'Y');
	$.Dialog.open(url, dlgid, options)
}
//选择部门
function selectCheckallPartyGroup(id,name,single){
	var dlgid = "dialog";
	var options = {};
	options.title = "选择部门";
	options.width =  '780',
	options.height = '390';
	var url="selectCheckallPartyGroup?id="+id+"&name="+name+"&single="+((single) ? single :'Y');
	$.Dialog.open(url, dlgid, options)
}

//弹出编辑框
function confirmDialog(title,content,callback) {
	
	var thisDialog=$('<div>').dialog({
		modal : true,
		autoOpen: false,
		open : function() {
			thisDialog.html(content);
		},buttons: {  
			"确定": function () {  
				$(this).dialog('close');
				callback();
				},   
			"关闭": function () { $(this).dialog('close');} 
		},  
		close: function () { thisDialog.dialog( 'remove' ) ; },  
		width :  '300',
		height : '200',
		title : (title)?title:'提示'
	});
	thisDialog.dialog("open"); 
}

 
// jquery.form-结合jquery.validate提交验证
function submitForm(formId) {
	if (validateForm(formId)) {
		document.getElementById(formId).submit();
	}
}
function submitDialogFormThis(form) {
	submitDialogForm(form.id);
}
function submitDialogForm(formId) {
	if (validateForm(formId)) {
		document.getElementById(formId).target="_parent";
		document.getElementById(formId).submit();
	}
}
function validateForm(formId) {
	// validate方法参数可选
	return $("#" + formId).validate({
		rules : {},
		messages : {}
	}).form();
}
//带附件表单提交
function submitUploadForm(formId) {
	if (validateForm(formId)) {
		document.getElementById(formId).submit();
	}
}
// 将form表单元素的值序列化成对象
function serializeObject(form) {
	var o = {};
	$.each(form.serializeArray(), function(index) {
		if (o[this['name']]) {
			o[this['name']] = o[this['name']] + "," + this['value'];
		} else {
			o[this['name']] = this['value'];
		}
	});
	return o;
}
function searchFormToParam(searchFormId) {
	var params="";
	$("#"+searchFormId).find("input").each(function(){
		var fieldNameCopy = $(this).attr("name");
		var fieldValue = $(this).val();
		//var fieldName = fieldNameCopy.substring(0,fieldNameCopy.length-4);
		params += "&"+fieldNameCopy+"="+fieldValue;
	});
	return params;
}
/**
 * 增加formatString功能
 * 
 * 使用方法：formatString('字符串{0}字符串{1}字符串','第一个变量','第二个变量');
 * 
 * @returns 格式化后的字符串
 */
formatString = function(str) {
	for ( var i = 0; i < arguments.length - 1; i++) {
		str = str.replace("{" + i + "}", arguments[i + 1]);
	}
	return str;
};
/**
 * 为空转换
 * 
 * @param value
 * @returns
 */
function formartEmp(value) {
	if (value != undefined && value != null && value.length > 0) {
		return value;
	} else {
		return '';
	}
}
/**
 * 判断数组是否有相同值
 * 
 * @param arr
 * @returns
 */
function isRepeat(arr) {
	var hash = {};
	for ( var i in arr) {
		if (hash[arr[i]])
			return true;
		hash[arr[i]] = true;
	}
	return false;
}
/**
 * @parampercent当前列的列宽所占整个窗口宽度的百分比(以小数形式出现，如0.3代表30%)
 * 
 * @return通过当前窗口和对应的百分比计算出来的具体宽度
 */
function fillsize(percent) {
	var bodyWidth = document.body.clientWidth;
	return (bodyWidth - 90) * percent;
}

/**
 * 接收一个以逗号分割的字符串，返回List，list里每一项都是一个字符串
 * 
 * @returns list
 */
stringToList = function(value) {
	if (value != undefined && value != '') {
		var values = [];
		var t = value.split(',');
		for ( var i = 0; i < t.length; i++) {
			values.push('' + t[i]);/* 避免他将ID当成数字 */
		}
		return values;
	} else {
		return [];
	}
};
/**
 * 接收一个以逗号分割的字符串，返回List，list里每一项都是一个字符串
 * 
 * @returns list
 */
listToString = function(value) {
	var ids="";
	for ( var i = 0; i < value.length; i++) {
		if (null == ids || i == 0) {
			ids = value[i];
		} else {
			ids = ids + "," + value[i];
		}
	}
	return ids;
};
function subStr(str) {
	return (str.length > 0) ? str.substring(0, str.length - 1) : str;
}
function findValuesByName(tableId, name) {
	var values = "";
	var inpId = "input[name='" + name + "']";
	$("#" + tableId).find(inpId).each(function() {
		values += $(this).val() + ",";
	});
	return subStr(values);
}
function getRowIndex(target) {
	var tr = $(target).closest('tr.datagrid-row');
	return parseInt(tr.attr('datagrid-row-index'));
}
function editRowFunc(target, gridTb) {
	$('#' + gridTb).datagrid('editRow', getRowIndex(target));
}
function editEgridRowFunc(target, gridTb) {
	$('#' + gridTb).edatagrid('editRow', getRowIndex(target));
}
function deleteRowFunc(target, gridTb) {
	$.messager.confirm('Confirm', '确定要删除吗?', function(r) {
		if (r) {
			$('#' + gridTb).datagrid('deleteRow', getRowIndex(target));
		}
	});
}
function updateActionsFunc(index, gridTb) {
	$('#' + gridTb).datagrid('updateRow', {
		index : index,
		row : {}
	});
}
function saveRowFunc(target, gridTb) {
	$('#' + gridTb).datagrid('endEdit', getRowIndex(target));
}
function saveEgridFunc(gridTb) {
	$('#' + gridTb).edatagrid('saveRow');
}
function saveReloadEgridFunc(gridTb) {
	$('#' + gridTb).edatagrid('saveRowReload');
}
function cancelRowFunc(target, gridTb) {
	$('#' + gridTb).datagrid('cancelEdit', getRowIndex(target));
}
function cancelEgridRowFunc(target, gridTb) {
	$('#' + gridTb).edatagrid('cancelEdit', getRowIndex(target));
}
function deleteEgridRowFunc(target, gridTb) {
	$('#' + gridTb).edatagrid('selectRow', getRowIndex(target));
	$('#' + gridTb).edatagrid('destroyRow', getRowIndex(target));
}
function thruEgridRowFunc(target, gridTb) {
	$('#' + gridTb).edatagrid('selectRow', getRowIndex(target));
	$('#' + gridTb).edatagrid('thruRow');
}
function searchGridForm(gridTb, searchFormId) {
	$('#' + gridTb).datagrid('load', serializeObject($('#' + searchFormId)));
	$('#' + gridTb).datagrid('uncheckAll').datagrid('unselectAll').datagrid(
			'clearSelections');
}
// 下拉方式可选条件查询
function searchGridFormMutil(searchNameId, searchValueId, gridTb, searchFormId) {
	var searchName = $("#" + searchNameId).val();
	var searchValue = $.trim($("#" + searchValueId).val());

	$('#' + searchNameId).find('option').each(function() {
		var oper = $(this);
		if (!oper.attr("selected")) {
			$('#' + searchFormId).find(':input').each(function() {
				if ($(this).attr("name") == oper.val()) {
					$(this).val('');// 清空前查询
				}
			});
		}
	});
	$('#' + searchFormId).find(':input').each(function() {
		if ($(this).attr("name") == searchName) {
			$(this).val(searchValue);
		}
	});

	$('#' + gridTb).datagrid('load', serializeObject($('#' + searchFormId)));
	$('#' + gridTb).datagrid('uncheckAll').datagrid('unselectAll').datagrid(
			'clearSelections');
}
// 下拉方式可选条件查询
function searchFrameFormMutil(searchNameId, searchValueId, searchFormId) {
	var searchName = $("#" + searchNameId).val();
	var searchValue = $.trim($("#" + searchValueId).val());

	$('#' + searchNameId).find('option').each(function() {
		var oper = $(this);
		if (!oper.attr("selected")) {
			$('#' + searchFormId).find(':input').each(function() {
				if ($(this).attr("name") == oper.val()) {
					$(this).val('');// 清空前查询
				}
			});
		}
	});
	$('#' + searchFormId).find(':input').each(function() {
		if ($(this).attr("name") == searchName) {
			$(this).val(searchValue);
		}
	});

	searchFormFun(searchFormId);
}

// 为区分forms中调用区分，删除和编辑做了特殊处理
function openFormsTab(url, title, isMax) {
	openFrameTab(title, url, isMax);
}
// innerTab
function openInnerTab(tabTitle, url, isMax) {
	layout_center_addTabFun({
		title : tabTitle,
		closable : true,
		cache : true,// 点击innerTab是否刷新
		href : url
	});
	if (isMax != null && isMax == 'Y') {
		if (!$('#layoutId').layout("panel", "west").panel("options").collapse) {
			$('#layoutId').layout('collapse', 'west');
		}
	}
}
// 打开innerTab并关闭当前tab页
function openInnerTabCloseCurrentTab(tabTitle, url, isMax) {
	commonCloseCurrentTab();
	layout_center_addTabFun({
		title : tabTitle,
		closable : true,
		cache : true,// 点击innerTab是否刷新
		href : url
	});
	if (isMax != null && isMax == 'Y') {
		if (!$('#layoutId').layout("panel", "west").panel("options").collapse) {
			$('#layoutId').layout('collapse', 'west');
		}
	}
}
// iframe中打开innerTab
function openInnerTabByFrame(tabTitle, url, isMax) {
	parent.layout_center_addTabFun({
		title : tabTitle,
		closable : true,
		cache : true,// 点击innerTab是否刷新
		href : url
	});
	if (isMax != null && isMax == 'Y') {
		if (!parent.$('#layoutId').layout("panel", "west").panel("options").collapse) {
			parent.$('#layoutId').layout('collapse', 'west');
		}
	}
}
// iframe方式打开新的TAB页
function openFrameTab(title, url, isMax) {
	try {
		parent
				.addTabFun({
					title : title,
					closable : true,
					cache : false,
					href : url,
					// iconCls : node.iconCls,
					content : '<iframe src="'
							+ url
							+ '" frameborder="0" style="border:0;width:100%;height:99%;"></iframe>'
				});
	} catch (e) {
		alert(e);
		window.open(url, target = 'blank');
	}
	if (isMax != null && isMax == 'Y') {
		if (!parent.$('#layoutId').layout("panel", "west").panel("options").collapse) {
			parent.$('#layoutId').layout('collapse', 'west');
		}
	}
}
// iframe方式打开新的TAB页，并且关闭当前tab页
function openFrameTabCloseCurrentTab(title, url, isMax) {
	var currentIndex = parent.$('#layout_center_tabs').tabs('getTabIndex',
			parent.$('#layout_center_tabs').tabs('getSelected'));
	try {
		parent
				.addTabFun({
					title : title,
					closable : true,
					cache : false,
					href : url,
					// iconCls : node.iconCls,
					content : '<iframe src="'
							+ url
							+ '" frameborder="0" style="border:0;width:100%;height:99%;"></iframe>'
				});
	} catch (e) {
		alert(e);
		window.open(url, target = 'blank');
	}
	parent.$('#layout_center_tabs').tabs('close', currentIndex);
	if (isMax != null && isMax == 'Y') {
		if (!parent.$('#layoutId').layout("panel", "west").panel("options").collapse) {
			parent.$('#layoutId').layout('collapse', 'west');
		}
	}

}
/**
 * 注：该方法会自动将所选记录的id(DataGrid的idField属性对应到列表Json数据中的字段名必须为id)
 * 动态组装成字符串，多个id使用逗号隔开(如：1,2,3,8,10)，然后存放入变量ids中传入后台，后台
 * 可以使用该参数名从request对象中获取所有id值字符串，此时在组装sql或者hql语句时可以采用in 关键字来处理，简介方便。
 * 另外，后台代码必须在操作完之后以ajax的形式返回Json格式的提示信息，提示的json格式信息中必须有一个
 * message字段，存放本次删除操作成功与失败等一些提示操作用户的信息。
 * 
 * @paramdataTableId将要删除记录所在的列表table的id
 * @paramrequestURL与后台服务器进行交互，进行具体删除操作的请求路径
 * @paramconfirmMessage 删除确认信息
 */

function deleteNoteByIds(dataTableId, requestURL, confirmMessage) {
	if (null == confirmMessage || typeof (confirmMessage) == "undefined"
			|| "" == confirmMessage) {
		confirmMessage = "确定删除所选记录?";
	}
	var rows = $('#' + dataTableId).datagrid('getSelections');
	var num = rows.length;
	var ids = null;
	if (num < 1) {
		$.messager.alert('提示消息', '请选择你要删除的记录!', 'info');
	} else {
		$.messager.confirm('确认', confirmMessage, function(r) {
			if (r) {
				for ( var i = 0; i < num; i++) {
					if (null == ids || i == 0) {
						ids = rows[i].id;
					} else {
						ids = ids + "," + rows[i].id;
					}
				}
				$.getJSON(requestURL, {
					"ids" : ids
				}, function(data) {
					if (null != data && null != data.message
							&& "" != data.message) {
						$.messager.alert('提示消息', data.message, 'info');
						flashTable(dataTableId);
					} else {
						$.messager.alert('提示消息', '删除失败！', 'warning');
					}
					clearSelect(dataTableId);
				});
			}
		});
	}
}

// 查询列表
function searchFormFun(formId) {
	jQuery("#pageForm").find(":input").each(
			function() {
				jQuery("#" + formId).append(
						"<input type='hidden' value='" + this.value
								+ "' name='" + this.name + "'>");
			});
	$("#" + formId).submit();
}
// iframe方式编辑表单-提交、刷新处理
function ajaxSubmitFrameForm(formId) {
	if (jQuery("#" + formId).form('validate')) {
		$.messager.progress({
			title : '正在处理中……'
		});
		jQuery.ajax({
			url : jQuery("#" + formId).attr("action"),
			type : 'POST',
			data : jQuery("#" + formId).serializeArray(),
			error : function(result) {
				// alert(msg);
				$.messager.progress('close');
			},
			success : function(result) {
				// var msg = jQuery.parseJSON(msg);
				if (result._ERROR_MESSAGE_LIST_) {
					$.messager.progress('close');
					$.messager
							.alert('错误', result._ERROR_MESSAGE_LIST_, 'error');
				} else {
					$.messager.progress('close');
					// 刷新父列表tab
					commonRefreshTab(formId);
					// 关闭tab
					commonCloseFrameTab(formId);
				}
			}
		});
	}
}

// ajax提交表单
function ajaxSubmitForm(formId) {
	ajaxSubmitFrameForm(formId);
}
function ajaxSubmitForms(formId) {
	ajaxSubmitFrameForm(formId);
}

// ajax提交表单
function submitFormsSimple(formId) {
	ajaxSubmitFrameForm(formId);
}
// ajax提交表单,刷新本tab //isMessage 是否成功后提示
function ajaxSubmitFormInTab(formId, isMessage, autoCloseCurrentTab) {
	if (jQuery("#" + formId).form('validate')) {
		jQuery.ajax({
			url : jQuery("#" + formId).attr("action"),
			type : 'POST',
			data : jQuery("#" + formId).serializeArray(),
			error : function(result) {
				// alert(msg);
			},
			success : function(result) {
				// 错误提示
				if (result._EVENT_MESSAGE_ || result._ERROR_MESSAGE_) {
					if (result._EVENT_MESSAGE_) {
						$.messager.alert('错误消息', result._EVENT_MESSAGE_,
								'error');
					}
					if (result._ERROR_MESSAGE_) {
						$.messager.alert('错误消息', result._ERROR_MESSAGE_,
								'error');
					}
				} else {
					if (result.msg) {
						$.messager.alert('提示', result.msg, 'info');
					} else if (isMessage) {
						$.messager.alert('提示消息', '操作成功', 'info');
					}
					commonRefreshTab(formId);
					if (autoCloseCurrentTab == 'Y') {
						commonCloseFrameTab(formId);
					}
				}
			}
		});
	}
}


// 批量删除Forms中-样式公用函数
function removeFormsGridFun(entityId, url, messInfo) {
	var ids = [];
	$('input[name="ids"]:checked').each(function() {
		ids.push($(this).val());
	});
	if (ids.length > 0) {
		if (messInfo) {
		} else {
			messInfo = '您是否要删除吗？';
		}
		/*
		$.messager.confirm('确认', messInfo, function(r) {
			if (r) {
				window.location.href = url + "?ids=" + ids;
			}
		});*/
		if(confirm(messInfo)){
			window.location.href = url + "?ids=" + ids;
		}
	} else {
		/*
		$.messager.show({
			title : '提示',
			msg : '请勾选要删除的记录！'
		});*/
		alertDialog('请勾选要删除的记录！');
	}
}
// 编辑Forms中-公用函数
function editFormsGridFun(entityId, url, messInfo) {
	var ids = [];
	$('input[name="ids"]:checked').each(function() {
		ids.push($(this).val());
	});
	if (ids.length ==1) {
		//window.location.href = url+ ids; 
		operEditDialog(url+ ids);
	} else {
		alertDialog('只能选择一条要修改的记录！');
	}
}



// 批量删除Forms中-样式公用函数
function commonUpdateFun(entityId, url, messInfo) {
	var ids = [];
	$('input[name="ids"]:checked').each(function() {
		ids.push($(this).val());
	});
	if (ids.length > 0) {
		if (messInfo) {
		} else {
			messInfo = '您是否要删除吗？';
		}
		if(confirm(messInfo)){
			window.location.href = url + "?ids=" + ids;
		}
	} else {
		alertDialog('请勾选要删除的记录！');
	}
}

// 简单ftl-table中获取非主键列字段根据行号
function getFiledValueSimpleTable(rowNum, filed) {
	return $("#" + filed + "_" + rowNum).text();
}
function getHiddenFiledValueSimpleTable(rowNum, filed) {
	return $("#" + filed + "_" + rowNum).val();
}
// 简单ftl-table中获取主键ids
function getIdsSimpleTable() {
	var ids = [];
	$('input[name="ids"]:checked').each(function() {
		ids.push($(this).val());
	});
	return ids.join(',');
}

// 查询表单重置
function resetForm(formId) {
	$("#" + formId + " input:visible").val('');
	// $("#"+formId+" .easyui-combobox").select("");
	$("#" + formId + " .easyui-combobox").combobox('setValues', []);

}
function resetGridForm(gridId, formId) {
	$("#" + formId + " input:visible").val('');
}
// 未选择的消息提示
function alertMessage() {
	$.messager.alert('提示', '请勾选要操作的记录！', 'warning');
}
function selectAlert(result) {
	if (result._EVENT_MESSAGE_ != null) {
		$.messager.alert('提示', result._EVENT_MESSAGE_, 'warning');
	} else {
		$.messager.alert('提示', '操作成功!', 'warning');
	}
}
// 设置省县市,传入出发的对象this,请求地址,表单ID,替换内容的name
function getArea(thisObj, url, formId, replaceDivId, childAreaDiv) {
	var area = $("#" + formId).find("select[name='" + replaceDivId + "']").get(
			0);
	jQuery.getJSON("ajaxArea", {
		parentId : thisObj.value
	}, function(json) {
		// area.options.length = 1;
		$(area).empty();
		var options = "";
		if (childAreaDiv != 'null') {
			// area.options[0] = new Option("选择城市", "");
			options += "<option value=\"\">选择城市</option>";
		} else {
			// area.options[0] = new Option("选择区县", "");
			options += "<option value=\"\">选择区县</option>";
		}
		if (json && json.areaList != null && json.areaList != 'undefined') {
			var areaList = (json.areaList != null) ? json.areaList : null;
			for ( var i = 0, end = areaList.length; i < end; i++) {
				// area.options[i + 1] = new
				// Option(areaList[i].geoName,areaList[i].geoId);
				options += "<option value=\"" + areaList[i].geoId + "\">"
						+ areaList[i].geoName + "</option>";
			}
		}
		$(area).html(options)
		if (childAreaDiv != 'null') {
			var childArea = $("#" + formId).find(
					"select[name='" + childAreaDiv + "']").get(0);
			// childArea.options.length = 1;
			$(childArea).empty();
			$(childArea).html("<option value=\"\">选择区县</option>");
		}
	});
}

// forms中全选操作
function selectAllIds() {
	if ($('#allIds').is(":checked")) {
		$("input[name='ids']").attr("checked", true);
	} else {
		$("input[name='ids']").attr("checked", false);
	}
}
function selectCheckIds() {
	if ($('.checkboxCtrl').is(":checked")) {
		$("input[name='ids']").attr("checked", true);
	} else {
		$("input[name='ids']").attr("checked", false);
	}
}
// 全选,id_all表头checkboxID
function selectAll(id_all, id) {
	if ($("#" + id_all).attr("checked")) {
		$("input[name='" + id + "']").each(function() {
			$(this).attr("checked", true);
		});
	} else {
		$("input[name='" + id + "']").each(function() {
			$(this).attr("checked", false);
		});
	}
}
/**
 * 高级查询
 * 
 * @returns
 */
function advancedSearch(url, gridTb, searchForm, searchDialog, width, height) {
	var dialog = $('<div/>').dialogext({
		href : url + '?1=' + Math.random() + '&searchForm=' + searchForm,
		width : (width) ? width : '580',
		height : (height) ? height : '270',
		modal : true,
		title : '高级查询',
		buttons : [ {
			text : '重置',
			iconCls : 'icon-no',
			handler : function() {
				var d = $(this).closest('.window-body');
				resetForm(searchForm);
			}
		}, {
			text : '确定',
			iconCls : 'icon-search',
			handler : function() {
				var d = $(this).closest('.window-body');
				searchGridForm(gridTb, searchForm);
			}
		}, {
			text : '确定并关闭',
			iconCls : 'icon-ok',
			handler : function() {
				var d = $(this).closest('.window-body');
				searchGridForm(gridTb, searchForm);
				resetForm(searchForm);
				d.dialogext('destroy');
			}
		} ],
		onClose : function() {
			$(this).dialogext('destroy');
		}
	});
	dialog.parent().bgiframe();

}
/**
 * 高级查询-frame
 * 
 * @returns
 */
function advancedSearchFrame(url, searchForm, searchDialog, searchAction,
		width, height) {
	var dialog = $('<div/>').dialogext(
			{
				href : url + '?1=' + Math.random() + '&searchForm='
						+ searchForm + '&searchAction=' + searchAction,
				width : (width) ? width : '580',
				height : (height) ? height : '270',
				modal : true,
				title : '高级查询',
				buttons : [ {
					text : '重置',
					iconCls : 'icon-no',
					handler : function() {
						var d = $(this).closest('.window-body');
						resetForm(searchForm);
					}
				}, {
					text : '确定',
					iconCls : 'icon-search',
					handler : function() {
						var d = $(this).closest('.window-body');
						searchFormFun(searchForm);
					}
				} ],
				onClose : function() {
					$(this).dialogext('destroy');
				}
			});
	dialog.parent().bgiframe();

}

// 修改状态
/*******************************************************************************
 * function changeStatus(ids,modelName,statusId,nextStatusId){ if(ids.length>0){
 * jQuery.ajax({ url : 'specialChangeStatus', type : 'POST', data :
 * {ids:ids,modelName:modelName,statusId:statusId,nextStatusId:nextStatusId},
 * error : function(msg) { }, success : function(msg) {
 * $('#'+gridTb).datagrid('load'); } }); }else{
 * $.messager.alert('提示','请勾选要操作的记录！','warning'); } }
 ******************************************************************************/

/*
 * 使用一个数据追加一个选项到给定下拉列表,并设置为当前值. selectId 下拉列表ID key key value 字面值
 */
function buildSelectOptionsWithKeyValue(selectId, key, value) {
	if ($('#' + selectId).size() > 0) {
		var jDomSelect = $('#' + selectId)[0];
		var n = jDomSelect.options.length;
		jDomSelect.options[n] = new Option(value, key);
		$('#' + selectId).val(key);
	}
}
/*
 * 使用数据填充到下拉列表. selectId 下拉列表ID dataList 填充的键值对数据Map
 */
function buildSelectOptionsWithDataList(selectId, dataMap) {
	if ($('#' + selectId).size() > 0) {
		var jDomSelect = $('#' + selectId)[0];
		var dataList = dataList;

		$.each(dataMap, function(key, value) {
			var n = jDomSelect.options.length;
			jDomSelect.options[n] = new Option(value, key);
		});
	}
}
/*
 * 使用实体List填充到下拉列表. selectId 下拉列表ID; gvList 填充的实体List; keyField
 * 用作key字段名;valueField 用作value的字段名
 */
function buildSelectOptionsWithGvList(selectId, gvList, keyField, valueField) {
	if ($('#' + selectId).size() > 0 && gvList.length > 0) {
		var data = [];
		$.each(gvList, function(i, gv) {
			var key = eval('gv.' + keyField);
			var value = eval('gv.' + valueField);
			eval('data.push({\'' + keyField + '\':\'' + key + '\',\''
					+ valueField + '\':\'' + value + '\'})');
		});
		$('#' + selectId).combobox('loadData', data).combobox('setValue',
				eval('data[0].' + valueField));
	}
}
/*
 * 清空下拉列表 selectId 下拉列表ID
 */
function clearSelectOptions(selectId) {
	if ($('#' + selectId).size() > 0) {
		var jDomSelect = $('#' + selectId)[0];

		for (i = jDomSelect.options.length - 1; i >= 0; i--) {
			jDomSelect.options[i] = null;
		}
	}
}
/*
 * 清空下拉列表,并使用新数据填充一个选项. selectId 下拉列表ID key key value 字面值
 */
function resetSelectOptionsWithKeyValue(selectId, key, value) {
	clearSelectOptions(selectId);
	buildSelectOptionsWithKeyValue(selectId, key, value);
}
/*
 * 清空下拉列表,并使用新数据填充,默认选中第一个. selectId 下拉列表ID dataList 填充的键值对数据Map
 */
function resetSelectOptionsWithDataList(selectId, dataMap) {
	clearSelectOptions(selectId);
	buildSelectOptionsWithDataList(selectId, dataMap);
}
/*
 * 如果默认变量存在,则设定下拉列表默认值为此变量 selectId: 下拉列表ID; defaultValue: 默认值;
 */
function setDefaultIfExists(selectId, defaultValue) {
	if (defaultValue) {
		$('#' + selectId).children('option[value=' + defaultValue + ']').attr(
				'selected', true);
	}
}
/*
 * 清空下拉列表,并使用新数据填充,如果默认变量存在,则设定下拉列表默认值为此变量. selectId: 下拉列表ID; dataList:
 * 填充的键值对数据Map; defaultValue: 默认值;
 */
function resetSelectWithDataListAndSetDefault(selectId, dataMap, defaultValue) {
	resetSelectOptionsWithDataList(selectId, dataMap);
	setDefaultIfExists(selectId, defaultValue);
}

/*
 * 判断一个 combo 的值是否新输入的. 返回 true 或者 false
 */
function isNewComboValue(comboId) {
	var isNew = true;
	var input = $('#' + comboId);
	var selectKey = input.combobox('getText');
	var data = input.combobox('getData');

	if (data) {
		var textFd = input.combobox('options').textField;
		$.each(data, function(i, item) {
			var v = eval('item.' + textFd);
			if (selectKey === v) {
				isNew = false;
				return false;
			}
		});
	}
	return isNew;
}
function isUrlFileExist(fileURL) {
	var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.open("GET", fileURL, false);
	xmlhttp.send();
	if (xmlhttp.readyState == 4) {
		if (xmlhttp.status == 404) {
			return false;
		}
	}
	return true;
}
// 格式化人民币金额数字 2 小数点
function amountFormatter(value) {
	if (value) {
		return (new Number(value).toFixed(2));
	} else {
		return '';
	}
}
// 格式化 "2013年04月08日 14时33分43秒" 这样的日期时间
function dateTimeFormatter(value, style) {
	if (value) {
		if (0 == style)
			return value.substr(0, value.indexOf(' '));
		else if (1 == style)
			return value.substr(value.lastIndexOf(' '));
		else if (3 == style)
			return value;
		else
			return value;
	}
}
//批量新增行		 
function commonAddRows(tableId){
	var lastNum=parseInt(commonGetMaxRowIndex(tableId)+1);
	var rowNum=1;
	if($('#rowNum')){
		rowNum=parseInt($('#rowNum').val());
	}
	var data=[];
	for(var i=lastNum;i<rowNum+lastNum;i++){
		insertRows(i,data);
	}
	commonRefreshRowNum();
}	
 function commonRefreshRowNum(){
 	xuhao = 1;
 	$("input[name='rowIndex']").each(function(){
		$(this).val(xuhao++);
	});
 }   
 function commonGetRowCount(){
	 return $("input[name='rowIndex']").length;
 }   
 //通过链接(复制等)-得到tr的行index  
 function commonGetRowIndexTable(thisObj){
 	return $(thisObj).parent().parent().attr("id").replace('row1_','');
 }
 //获取最大rowId
 function commonGetMaxRowIndex(tableId){
 	var rowIndex=[];
 	$('#'+tableId).find("tr").each(function(){
 		if($(this).attr("id")){
			rowIndex.push($(this).attr("id").replace('row1_',''));
		}
	});
 	if(rowIndex.length>0){
 		return Math.max.apply( Math, rowIndex );
 	}else{
 		return 0;
 	}
 } 
 function commonDeleteRowsTable(thisObj) {
	 	var deleteIndex=commonGetRowIndexTable(thisObj);
	    //更新删除之下的所有tr和td内的id和name -1
	    var rowNum=$(thisObj).parent().parent().parent().find("tr").length;
	    for(var i=deleteIndex;i<rowNum;i++){
	    	$('#row1_'+i).find("td").each(function(){
	     		$(this).children().each(function(){
	     			if($(this).attr("id")&&$(this).attr("id").indexOf("_o_")!=-1){
	     				var attrId=$(this).attr("id");
	     				$(this).attr("id",attrId.substring(0,attrId.length-1)+(i-1));
	     				$(this).attr("name",attrId.substring(0,attrId.length-1)+(i-1));
	     			}
	    			
	    		});
	    	});
	    }
	    rowUtil.deleteRow(deleteIndex);
	    for(var i=deleteIndex;i<rowNum;i++){
		    if($('#row1_'+i).attr("id")){
		    	var trId=$('#row1_'+i).attr("id");
		    	$('#row1_'+i).attr("id",trId.substring(0,trId.length-1)+(i-1));
		    }
	    }
	   
	    
	    commonRefreshRowNum();
 }
 function commonDeleteRowAll(tableId) {
 	$('#'+tableId).find(":checkbox:checked").each(function() {  
		var rowIndex=$(this).parent().parent().attr("id").replace('row1_','');
		rowUtil.deleteRow(rowIndex);  
    });
 	commonRefreshRowNum();
}
function commonFiledStr(filedOpt,rowIndex,rowData){
		return "<td><input type='text' class='span"+filedOpt.size+"' size='"+filedOpt.size+"'  name='"+filedOpt.name+"_o_"+rowIndex+"'  id='"+filedOpt.name+"_o_"+rowIndex+"' class='"+filedOpt.classStyle+"'  value='"+((rowData&&rowData[filedOpt.name])?rowData[filedOpt.name]:'')+"'></td>"
}
function commonTextStr(filedOpt,rowIndex,rowData){
	return "<td>"+((rowData&&rowData[filedOpt.name])?rowData[filedOpt.name]:'')+"</td>"
}
function commonFiledData(filedName,thisIndex,data){ 
	if($("#"+filedName+"_o_"+thisIndex).val()!=null){
		data[filedName]=$("#"+filedName+"_o_"+thisIndex).val();
	}	
}
function getArea(thisObj, url, replaceDivId, childAreaDiv) {
	var area = document.getElementById(replaceDivId + "");
	var childArea = document.getElementById(childAreaDiv + "");
	$.ajax({
		url:'ajaxArea',
		type:'POST',
		data:{parentId:thisObj.value},
		success:function(json) {
			area.options.length = 1;
			if (childAreaDiv != 'null') {
				area.options[0] = new Option("选择城市", "");
			} 
			if (json && json.areaList != null && json.areaList != 'undefined') {
				var areaList = (json.areaList != null) ? json.areaList : null;
				for ( var i = 0, end = areaList.length; i < end; i++) {
					area.options[i + 1] = new Option(areaList[i].geoName,
							areaList[i].geoId);
				}
			} 
			if (childAreaDiv != 'null') {
				var childArea = document.getElementById(childAreaDiv + "");
				childArea.options.length = 1;
				//childArea.options[0] = new Option("选择区县", "");
			}
		}	
	});
}
function selectMutilAdd(div,id,name){
	$("#"+div).append('<span style="display:block;width:95%;" onclick=selectMutilRemove("'+id+'") title="点击删除" class="onSelect" id="'+id+'">'+name+'</span>');
}
function selectMutilRemove(id){
	$("#"+id).remove();
}
function selectMutilRemoveAll(div){
	$("#"+div+" span").remove();
}