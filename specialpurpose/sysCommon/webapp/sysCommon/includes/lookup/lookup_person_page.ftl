<div class="pageContent">
	<div id="jbsxBox2" class="unitBox" style="float:left; display:block; overflow:auto; width:514px;">
		${screens.render("component://extErp/widget/CommonScreens.xml#LookupPerson")}
	</div>
</div>
	
	<div id="jbsxBox3" class="unitBox" style="margin-left:520px;">
		<!--
		<div class="pageHeader" style="border:1px #B8D0D6 solid">
			
		</div>
		-->
		<div class="pageContent" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
			<div class="panelBar">
				<ul class="toolBar">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				【已选择】
				</ul>
			</div>
			<table class="list" id="selectedTable" width="49%" layoutH="38">
				<thead>
					<tr>
						<td width="80">操作</th>
						<td>用户ID</th>
						<td>用户名</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>
		</div>
	</div>
	
</div>
<script language='javascript'>
function selectTo(selectId){
		var trStr="<tr id='selected"+selectId+"Tr'><td><div class='buttonActive'><div class='buttonContent'><button type='button' onclick=\"javascript:deleteTo('selected"+selectId+"Tr')\">删除</button></div></div></td>";
		jQuery("#"+selectId+"Tr").children().each(
				function(i) {
					if(i!=0){
						trStr+="<td>"+$(this).html()+"</td>";
					}
				});
		jQuery("#selectedTable").append(trStr+"</tr>");	
}
function deleteTo(selectId){
	jQuery("#"+selectId).remove();
}
function ceshi(values){
	//DWZ.jsonEval(values);
	$.pdialog.closeCurrent();
}
</script>