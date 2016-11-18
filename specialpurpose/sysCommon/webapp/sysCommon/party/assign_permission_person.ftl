<script language='javascript'>
$(function(){
	//var initWH = Public.setGrid();
	jQuery("#list1").jqGrid({
	   	url:'ajaxGetParty',
		datatype: "json",
	   	multiselect: true,
	   	colNames:['用户名','姓名'],
	   	colModel:[
	   		{name:'userLoginId', width:55},
	   		{name:'partyName', width:90}
	   	],
	   	rowNum:10,
	   	autowidth:true,
	   	height: 400,
	   	rowList:[10,20,30],
	   	pager: '#pager1',
	    viewrecords: true,
	    //sortorder: "desc",
	    caption:"未授权用户",
	    jsonReader : {  
          repeatitems : false,
		  id: "0"
        }
	});
	jQuery("#list1").jqGrid('navGrid','#pager1',{edit:false,add:false,del:false});
	//loadTable();
	
	jQuery("#rightTable").jqGrid({
	   	url:'commonPerformFind?entityName=UserLoginSecurityGroup&groupId=${parameters.groupId!}',
		datatype: "json",
	   	multiselect: true,
	   	colNames:['用户名','姓名'],
	   	colModel:[
	   		{name:'userLoginId', width:55},
	   		{name:'firstName', width:90}
	   	],
	   	rowNum:10,
	   	autowidth:true,
	   	height: 400,
	   	rowList:[10,20,30],
	   	pager: '#pager2',
	    viewrecords: true,
	    //sortorder: "desc",
	    caption:"已授权用户",
	    jsonReader : {  
          repeatitems : false,
		  id: "0"
        }
	});
	jQuery("#rightTable").jqGrid('navGrid','#pager2',{edit:false,add:false,del:false});
	//loadTable();
});		
function toRight(){
	var ids = listToString(jQuery('#list1').jqGrid('getGridParam','selarrrow'));
	if (ids) {
			 if(confirm("您是否要批量授权吗？")){
					$.ajax({
						url : 'permissionToParty',
						data : {
							ids :ids,groupId:'${parameters.groupId!}'
						},
						cache : false,
						dataType : 'JSON',
						success : function(r) {
							$("#rightTable").trigger("reloadGrid");//执行reload
							//loadTable();
						}
					});
			}
		} else {
			alertDialog('请勾选要操作的记录！');
	}	
}
function toLeft(){
	//var ids=getIdsSimpleTable("rightTable","userLoginId");
	var ids = listToString(jQuery('#rightTable').jqGrid('getGridParam','selarrrow'));
	if (ids) {
			 if(confirm("您是否要取消授权吗？")){
					$.ajax({
						url : 'removePermissionToParty',
						data : {
							ids :ids,groupId:'${parameters.groupId!}'
						},
						cache : false,
						dataType : 'JSON',
						success : function(r) {
							$("#rightTable").trigger("reloadGrid");//执行reload
							//loadTable();
						}
					});
			}
		} else {
			alertDialog('请勾选要操作的记录！');
	}	
}

function loadTable(){
	$("#rightTable tr:not(:first)").remove();
	$.ajax({
				type:"post",
				datatype:"json",
				url:"commonPerformFind?entityName=UserLoginSecurityGroup&groupId=${parameters.groupId!}",
				cache:false,
				success:function(result){
					if(result.rows){
						for(var i=0;i<result.rows.length;i++){
							insertRows(i,result.rows[i]);
						}
					}
				}
			});	
}
//插入行 
function insertRows(rowIndex,rowData){
	var str="<tr id='row1_"+rowIndex+"' onmouseover=\"this.style.background='#eaf2ff'\" onmouseout=\"this.style.background=''\">";
	str+="<td align='center'><input type='checkbox'  name='ids'  value='"+((rowData&&rowData.userLoginId)?rowData.userLoginId:'')+"'></td>";
	str+=commonTextStr({size:10,name:'userLoginId'},rowIndex,rowData);
	//str+=commonTextStr({size:15,name:'firstName'},rowIndex,rowData);
	str+="</tr>";
	$("#rightTable tbody:last").append(str);
}
</script>
<div style="margin:1cm 2cm 3cm 2cm;">
	<div class="row">

			<div  class="col-md-5">  	
				<table id="list1"></table>
				<div id="pager1"></div>
			</div>
		
			<div class="col-md-1" style='padding-top:100px' align="center">
				<span class="glyphicon glyphicon-arrow-right"  onclick="javascript:toRight();"></span>
				<br>
				<br>
				<span class="glyphicon glyphicon-arrow-left"  onclick="javascript:toLeft();"></span>
			</div>
		
		<div class="col-md-5" >
			<table id='rightTable'>
				<!--<tbody>
			    <tr class="header-row">
			    <td width='2%'>选择</td>
			    <td width='15%'>用户名</td>
			    <td width='7%'>姓名</td>
			    </tr>
				</tbody>-->
			</table>
			<div id="pager2"></div>
		</div>
	</div>
</div>
