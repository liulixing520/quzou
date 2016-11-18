// 刷新父列表tab
	function commonRefreshTab(formId) {
		try {
			if (document.getElementById(formId).navTabTitle) {
				var refreshTabTitle = document.getElementById(formId).refreshTabTitle.value;
				if (refreshTabTitle.length > 0) {
					var cfg = {
						tabTitle : refreshTabTitle
					};
					parent.refreshFrameTab(cfg);
				}
			} else {
				parent.refreshPrevFrameTab();
			}
		} catch (e) {
		}

	}
	// 刷新innerTab
	function reFreshInnerTab(title) {
		parent.$('#layout_center_tabs').tabs('getTab', title).panel('refresh');
	}
	// 关闭frame列表tab
	function commonCloseFrameTab(formId) {

		try {
			if (document.getElementById(formId).navTabTitle) {
				var navTabTitle = document.getElementById(formId).navTabTitle.value;
				// 关闭当前tab
				if (navTabTitle.length > 0) {
					parent.closeFrameTab(navTabTitle);
				}
			} else {
				commonCloseCurrentTab();
			}
		} catch (e) {
		}
	}
	function closeFreshByTitle(title){
		var cfg={tabTitle:title};//刷新tab列表 
		parent.refreshFrameTab(cfg);
		commonCloseCurrentTab();
	}
	// 关闭当前tab页
	function commonCloseCurrentTab() {
		parent.closeCurrentTab();
	}
	// 刷新当前innerTAB页
	function commonRefreshCurrentTab() {
		refreshCurrentTab();
	}
	// 刷新上一TAB页
	function commonRefreshPrevTab() {
		parent.refreshPrevFrameTab();
	}
	// 刷新上一InnerTAB页
	function commonRefreshPrevInnerTab() {
		parent.refreshPrevInnerTab();
	}
	// 刷新当前frame-TAB页
	function commonRefreshCurrentFrameTab() {
		parent.refreshCurrentFrameTab();
	}
	function resetFormFun(formId) {
		document.getElementById(formId).reset();
	}
	function isSelect(gridTb) {
		var rows = $('#' + gridTb).datagrid('getSelections');
		if (rows) {
			return true;
		} else {
			return false;
		}
	}
	// 查找带回-赋值给父窗口
	function getSelections(formId, gridTb, lookupId, lookupName, id, name) {
		var ids = "";
		var names = "";
		var rows = $('#' + gridTb).datagrid('getSelections');
		for ( var i = 0; i < rows.length; i++) {
			ids += (rows[i][lookupId]) + ",";
			names += (rows[i][lookupName]) + ",";
		}
		if (ids != null && ids.length > 0) {
			var inpId = "input[name='" + id + "']";
			//var obj = $('#' + formId).find(inpId).get(0); ie6兼容问题
			var obj = $.find(inpId)[0];
			$.find(inpId)[0].value = ids.substring(0,
					ids.length - 1);
		}
		if (names != null && names.length > 0) {
			var inpName = "input[name='" + name + "']";
			$.find(inpName)[0].value = names.substring(0,
					names.length - 1);
		}
	}

	// 获取grid的种的某一字段值ids
	function getSelected(gridTb, field) {
		var ids = "";
		var rows = $('#' + gridTb).datagrid('getSelections');
		for ( var i = 0; i < rows.length; i++) {
			ids += (rows[i][field]) + ",";
		}
		return subStr(ids);
	}
	// 获取grid的全部的某一字段值ids
	function getRowsField(gridTb, field) {
		var ids = "";
		var rows = $('#' + gridTb).datagrid('getRows');
		for ( var i = 0; i < rows.length; i++) {
			ids += (rows[i][field]) + ",";
		}
		return subStr(ids);
	}
	// 界面上删除datagrid-当前行
	function removeFrontGrid(dataGridTb, target) {
		$.messager.confirm('确定要删除吗?', function(r) {
			if (r) {
				$('#' + dataGridTb).datagrid('deleteRow', getRowIndex(target));
			}
		});
	}
	// 界面上删除datagrid=多个选中行
	function removeFrontGridRows(dataGridTb) {
		var rows = $('#'+dataGridTb).datagrid('getSelections');
		for ( var i = 0; i < rows.length; i++) {
			var index = $('#'+dataGridTb).datagrid('getRowIndex', rows[i]);
			$('#'+dataGridTb).datagrid('deleteRow', index);
		}
	}

	// 批量删除公用函数
	function removeGridFun(gridTb, entityId, url) {
		var rows = $('#' + gridTb).datagrid('getChecked');
		var ids = [];
		if (rows.length > 0) {
			$.messager.confirm('确认', '您是否要删除吗？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i][entityId]);
					}
					$.ajax({
						url : url,
						data : {
							ids : ids.join(',')
						},
						dataType : 'json',
						success : function(result) {
							// if (result.success) {
							$('#' + gridTb).datagrid('load');
							$('#' + gridTb).datagrid('uncheckAll').datagrid(
									'unselectAll').datagrid('clearSelections');
							// }
							if (result.msg) {
								$.messager.show({
									title : '提示',
									msg : result.msg
								});
							}
						}
					});
				}
			});
		} else {
			$.messager.show({
				title : '提示',
				msg : '请勾选要删除的记录！'
			});
		}
	}
	// 批量操作公用函数-如提交等，操作后刷新grid
	function commonOperGridFun(gridTb, entityId, url, taskMsg) {
		var rows = $('#' + gridTb).datagrid('getChecked');
		var ids = [];
		if (rows.length > 0) {
			$.messager.confirm('确认', '您是否要' + taskMsg + '吗？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i][entityId]);
					}
					$.ajax({
						url : url,
						data : {
							ids : ids.join(',')
						},
						dataType : 'json',
						success : function(result) {
							// if (result.success) {
							$('#' + gridTb).datagrid('load');
							$('#' + gridTb).datagrid('uncheckAll').datagrid(
									'unselectAll').datagrid('clearSelections');
							// }
							if (result.msg) {
								$.messager.show({
									title : '提示',
									msg : result.msg
								});
							}
						}
					});
				}
			});
		} else {
			$.messager.show({
				title : '提示',
				msg : '请勾选要删除的记录！'
			});
		}
	}
	/*******************************************************************************
	 * function
	 * openLookupDialogFtl(jsName,lookupId,lookupName,id,name,currentForm,gridTb,urlParam){
	 * $('#dialogDiv').dialogext({ width: 650, title:'查找带回', height: 400, buttons:[{
	 * text:'确定', iconCls:'icon-ok', handler:function(){
	 * getSelections(currentForm,gridTb,lookupId,lookupName,id,name);
	 * $('#dialogDiv').dialogext('close'); } },{ text:'关闭', iconCls:'icon-no',
	 * handler:function(){ $('#dialogDiv').dialogext('close'); } }] });
	 * eval(jsName.substring(0,jsName.length-1)+"'"+id+"','"+urlParam+"')"); }
	 ******************************************************************************/
	// 弹出框支持FTL并支持多属性
	function openLookupDialogFtl(jsName, lookupFields, fields, id, currentForm,
			gridTb, urlParam) {
		var dialog =  $('#'+id+'DialogDiv').dialogext({
			width : 650,
			title : '查找带回',
			height : 400,
			buttons : [ {
				text : '确定',
				iconCls : 'icon-ok',
				handler : function() {
					getSelectionsFtl(currentForm, gridTb, lookupFields, fields);
					$('#'+id+'DialogDiv').dialogext('close');
				}
			}, {
				text : '关闭',
				iconCls : 'icon-no',
				handler : function() {
				$('#'+id+'DialogDiv').dialogext('close');
				}
			} ]
		});
		dialog.parent().bgiframe();
		eval(jsName.substring(0, jsName.length - 1) + "'" + id + "','" + urlParam
				+ "')");
	}
	//多选
	function openMutilLookupDialogFtl(jsName, lookupFields, fields, id, currentForm,
			gridTb, urlParam) {
		var dialog =  $('#'+id+'DialogDiv').dialogext({
			width : 650,
			title : '查找带回',
			height : 400,
			buttons : [ {
				text : '确定',
				iconCls : 'icon-ok',
				handler : function() {
					getSelectionsFtl(currentForm, gridTb, lookupFields, fields);
					$('#'+id+'DialogDiv').dialogext('close');
				}
			}, {
				text : '关闭',
				iconCls : 'icon-no',
				handler : function() {
					$('#'+id+'DialogDiv').dialogext('close');
				}
			} ]
		});
		dialog.parent().bgiframe();
		eval(jsName.substring(0, jsName.length - 1) + "'" + id + "','" + urlParam
				+ "','N')");
	}
	// 查找带回-赋值给父窗口Ftl
	function getSelectionsFtl(formId, gridTb, lookupField, field) {
		var result = new Array();
		var lookupFields = lookupField.split(",");
		var fields = field.split(",");
		var rows = $('#' + gridTb).datagrid('getSelections');
		for ( var i = 0; i < lookupFields.length; i++) {
			result[i] = new Array();
			for ( var j = 0; j < rows.length; j++) {
				result[i][j] = "";
				result[i][j] += (rows[j][lookupFields[i]]) + ",";
			}
		}
		for ( var i = 0; i < fields.length; i++) {
			var inpId = "input[name='" + fields[i] + "']";
			//var obj = $('#' + formId).find(inpId).get(0); ie6兼容问题
			var obj = $.find(inpId)[0];
			// 初始化
			obj.value = "";
			for ( var j = 0; j < rows.length; j++) {
				if (result[i][j] != undefined) {
					obj.value += result[i][j];
				}
			}
			var cont = obj.value;
			obj.value = cont.substring(0, cont.length - 1);
		}
	}
	function openLookupDialog(jsName, lookupId, lookupName, id, name, currentForm) {
		var gridTb = id+'GridTb';
		var dialogDiv = id+'DialogDiv';
		var dialog =  $('#' + dialogDiv).dialogext(
				{
					title:'查找带回',
					width : 650,
					height : 400,
					buttons : [
							{
								text : '确定',
								iconCls : 'icon-ok',
								handler : function() {
									doLookup(dialogDiv, currentForm, gridTb,
											lookupId, lookupName, id, name);
								}
							}, {
								text : '关闭',
								iconCls : 'icon-no',
								handler : function() {
									$('#' + dialogDiv).dialogext('close');
								}
							} ]
				});
		dialog.parent().bgiframe();
		
		eval(jsName.substring(0, jsName.length - 1) + "'" + id + "')");
	}

	function doLookup(dialogDiv, formId, gridTb, lookupId, lookupName, id, name) {
		getSelections(formId, gridTb, lookupId, lookupName, id, name);
		try{
			$('#'+name).validatebox("isValid");
		}catch(e){}
		$('#' + dialogDiv).dialogext('close');
	}
	/**
	 * 普通弹出框-按钮确认、关闭
	 * 
	 * @returns
	 */
	function operDialog(initUrl,backJs,width,height) {
		var url="";
	    if (initUrl.indexOf("?") > -1)
	          url = initUrl + "&1="+Math.random();
	     else 
	          url = initUrl + "?1="+Math.random();
		var dialog =  $('<div/>').dialogext(
				{
					href : url+'?1='+Math.random(),
					width : (width)?width:'580',
							height : (height)?height:'270',
									modal : true,
									title : '弹出框',
									buttons : [{
										text : '确定',
										iconCls : 'icon-search',
										handler : function() {
											var d = $(this).closest('.window-body');
											if(backJs){
												eval(backJs);
											}
											d.dialogext('destroy');
										}
									}, {
										text : '关闭',
										iconCls : 'icon-ok',
										handler : function() {
											var d = $(this).closest('.window-body');
											
											d.dialogext('destroy');
										}
									} ],
									onClose : function() {
										$(this).dialogext('destroy');
									}
				});
		dialog.parent().bgiframe();
		
	}
	function operEditDialogJ(url,backJs,width,height) {
		var dialog =  $('<div/>').dialogext(
				{
					href : url,
					width : (width)?width:'680',
							height : (height)?height:'370',
									modal : true,
									title : '编辑框',
									onClose : function() {
										$(this).dialogext('destroy');
									}
				});
		dialog.parent().bgiframe();
		
	}
	//批量导入-需要服务端返回s回调函数
	function openUploadDialog(url)
	{
		var dialog =  $('<div/>').dialogext(
		{
			href : "commonUpload",
			width : '350',
			height :'130',
			modal : true,
			title : '导入EXCEL',
			buttons : [ {
				text : '导入',
				iconCls : 'icon-redo',
				handler : function() {
					var d = $(this).closest('.window-body');
					var filePath = $("#excelPath").val();
					if(!filePath)
					{
						$.messager.show({title:'Warning',msg:'请选择excel文件'});
						return;
					}
					var suffix = filePath.substring(filePath.lastIndexOf(".")+1,filePath.length);
					if(suffix!='xls'&& suffix!='XLS')
					{
						$.messager.show({title:'Warning',msg:'请选择excel文件'});
						return;
					}
					$("#upLoadForm").attr("enctype","multipart/form-data");
			    	$("#upLoadForm").attr("encoding", "multipart/form-data");
			    	$("#upLoadForm").attr("target","upload_iframe");
			    	$("#upLoadForm").attr("action",url);
					$("#upLoadForm").submit();
					d.dialogext('destroy');
				}
			}, {
				text : '关闭',
				iconCls : 'icon-no',
				handler : function() {
					var d = $(this).closest('.window-body');
					d.dialogext('destroy');
				}
			} ],
			onClose : function() {
				$(this).dialogext('destroy');
			}
		});
		dialog.parent().bgiframe();
	}
	//easyui验证表单提交
	function submitEasyuiForm(formId) {
		if (jQuery("#" + formId).form('validate')) {
			document.getElementById(formId).submit();
		}
	}
	
	// 回车查询
	function enterSearch(seachTable,seachForm){
		var event = arguments.callee.caller.arguments[0] || window.event;
		if(event.keyCode == 13){
			searchGridForm(seachTable,seachForm);
			window.event.keyCode=0;
		}
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
	function selectMutilSubmit(id,name){
		var ids = [];
		var names = [];
		$('.onSelect').each(function() {
			ids.push($(this).attr("id"));
			names.push($(this).text());
		});
		parent.$('#'+id).val(ids);
		parent.$('#'+name).val(names);
		closeDialog('dialog');
	}