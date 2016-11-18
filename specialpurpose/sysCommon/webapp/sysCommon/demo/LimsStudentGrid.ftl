<div id="toolbar_26">
        <form method="get" action="#" id="formwinStat26">
        学生姓名：
        <input type="text" class="easyui-datebox" required="true" name="start" />
        班级名称：
        <input type="text" class="easyui-datebox" required="true" name="end" /><input type="hidden"
            name="type" value="OA.Model.DealItem" />
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$('#formwinStat26').submit();">
            查询 </a>
        </form>
     
    </div>
<script language='javascript'>
var tool = [{ text: ' 查看 ' , iconCls: 'icon-read', handler: function () {
            alert("查看");
        }
        }, '-', { text: ' 添加 ' , iconCls: 'icon-add', handler: function () {
            alert("添加");
        }
        }, '-', { text: ' 修改 ' , iconCls: 'icon-edit', handler: function () {
            alert("修改");
        }
        }, '-', {
            text: ' 查询 ', iconCls: 'icon-search' , handler: function () {
                alert("查询");
            }
        }, '-', { text: ' 导入数据 ' , iconCls: 'icon-redo', handler: function () {
            alert("导入数据");
        }
        }, '-', { text: ' 批量删除 ' , iconCls: 'icon-set', handler: function () {
            alert("批量删除");
        }
        }];
$(function(){
	//var initWH = Public.setGrid();
	jQuery("#dataList").jqGrid({
	   	url:'commonFindDataTable?entityName=LimsStudent',
		datatype: "json",
	   	multiselect: true,
		multiboxonly: true,
		//toolbar: [ true, "top" , tool],
	   	toolbar: [ true, "top" ,"#toolbar_26"],
	   	colNames:[' ','学生姓名','邮箱地址','座位号'],
	   	colModel:[
	   		{name:'studentId',hidden:true,checkbox:true, width:55},
	   		{name:'studentName',index:'studentName', width:55},
	   		{name:'studentEmail', width:90},	
	   		{name:'seatNo', width:90}	
	   	],
	   	rowNum:10,
	   	autowidth:true,
	   	//height: initWH.h,
	   	height: 400,
	   	rowList:[10,20,30],
	   	pager: '#pager',
	   	//sortname: 'studentId',
	    viewrecords: true,
	    //sortorder: "desc",
	    //caption:"临检项目",
	    altRows: true,
	    jsonReader : {  
          repeatitems : false,
		  id: "0"
        }
	});
	jQuery("#dataList").jqGrid('navGrid','#pager',{edit:false,add:false,del:false});
});		

function gridReload(){
	var studentName = jQuery("#studentName").val();
	var classId = jQuery("#classId").val();
	jQuery("#dataList").jqGrid('setGridParam',{url:"commonFindDataTable?entityName=LimsStudent&studentName="+studentName+"&classId="+classId,page:1}).trigger("reloadGrid");
}
</script>
<div class="row-fluid sortable">	
	<div class="box span12">
		<div class="box-content" >
			<form id='LimsStudent_gridTb_search' class='form-horizontal'>
					学生姓名：<input type="text"  name="studentName"  id="studentName" />
						<input type="hidden" value="Y" name="studentName_ic">
						<input type="hidden" value="contains" name="studentName_op">
						班级名称：<select name="classId" id="classId" class="">
			            	<option value=""></option>
			            		<#list LimsClassList as relEntity>
			            			<option   
			            			value='${relEntity.classId}'>
			            			${relEntity.className!}</option>
			            		</#list>
			            </select>
			 <input type="button" onclick="javascript:gridReload();" href="javascript:void(0);" class="btn btn-primary" name="search" value="查询">           
			</form>

			<div id="dataGrid">
			<table id="dataList"></table>
			<div id="pager"></div>
			</div>

		</div>
		
	</div><!--/span-->
</div><!--/row-->


