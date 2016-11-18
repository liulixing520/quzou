<script language='javascript'>
jQuery(function() {
	$('#gridDialogTbs').jqGrid({
		url:'commonPerformFind?entityName=LimsClass&thruDate_op=empty',
		datatype: "json",
		colNames:[' ','班级名称','班主任','顺序'],
	   	colModel:[
	   		{name:'classId',hidden:true,checkbox:true,width:55},
	   		{name:'className',editable:true,edittype:'text',width:150},
	   		{name:'classTeacher',editable:true,edittype:'text',width:90},
	   		{name:'sortNo',editable:true,edittype:'text',width:90}
	   	],
		rowNum:10,
		rowList:[20,50,100],
		autowidth:true,
		pager:'#tb',
		viewrecords: true,
	    caption:"班级",
	    editurl:'OperGenericValue?entityName=LimsClass&idField=classId',
	    jsonReader : {
          	repeatitems : false,
		  	id: "0"
    	}	
	});
	$("#gridDialogTbs").jqGrid('navGrid','#tb',{edit:true,add:true,del:true});
});	
function addRow(){
	$('#gridDialogTbs').edatagrid('addRow');
}
</script>
<div id="tb" style="padding:3px"> 
	<#--<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="javascript:$('#gridDialogTbs').edatagrid('addRow')">新增</a>  
	<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="false" onclick="javascript:$('#gridDialogTbs').edatagrid('thruRow')">删除</a>  
	<a class="l-btn" onclick="openUploadDialog('importLimsClass','upload_iframe');" href="javascript:void(0);">
		<span class="l-btn-left">
			<span class="l-btn-text icon-redo l-btn-icon-left">
				excel导入
			</span>
		</span>
	</a> -->
</div>  
<table id="gridDialogTbs" >
</table> 
<iframe name="upload_iframe" style="display: none"></iframe>	