<@htmlTemplate.navTitle titleProperty/>

<div align="left">
	<form id="editForm" method="post" action='<#if securityGroup??>updateSecurityGroup<#else>createSecurityGroup</#if>'>
	 <input type="hidden" name="groupId" value="${groupId?if_exists}" />
	 <input type="hidden" name="permissionIds" id="permissionIds" />
		<table cellspacing="0" class="basic-table">
			<tr class='background_tr'>
				<td class='textColumn'>权限组名称</td>
				<td class='valueColumn'><input name="description" size='50' value="${(securityGroup.description)?if_exists}" <#if oper?? && oper.equals('view')>disabled</#if> class="easyui-validatebox" data-options="required:true" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button class="bttn"  onclick="javascript:subThisForm('editForm');return false;">保存</button>
			</tr>
    </div>
			
		</table>
		<div style="height:500px;background:#fafafa;padding:5px;">
		<div id="p" class="easyui-panel" style="width:630px;height:400px;padding:10px;"
				data-options="title:'权限选择',iconCls:'icon-save',
						collapsible:true">
			<ul id="tt2" class="easyui-tree" style="width:600px;height:400px;"  data-options="url:'ajaxGetPermissionTree?groupId=${groupId?if_exists}',checkbox:true,
			onClick: function(node){
				$(this).tree('toggle', node.target);
			},
			onContextMenu: function(e,node){
				e.preventDefault();
				$(this).tree('select',node.target);
				$('#mm').menu('show',{
					left: e.pageX,
					top: e.pageY
				});
			}"
	></ul>
		</div>
	
	</form>
	
<script language='javascript'>
	function subThisForm(formId){
		var nodes = $('#tt2').tree('getChecked');
		var ids = '';
		for(var i=0; i<nodes.length; i++){
			if (nodes[i].id == 'undefined' || nodes[i].id == '' || nodes[i].id == null) {
				//alert(nodes[i].id);
			}
			else{
				ids += nodes[i].id+",";
			}
		}
		jQuery("#permissionIds").val((ids.length>0)?ids.substring(0,ids.length-1):ids);
		submitEasyuiForm(formId);
	}	
</script>	