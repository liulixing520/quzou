<div class="row-fluid sortable ui-sortable">
<div class="box span12">
<!-- Begin Template component://sysCommon/webapp/sysCommon/includes/bootstrap/divSearchStart.ftl -->
<!--<div class="box-header well" data-original-title="">
<h2><i class="icon-list"></i> ${titleProperty!}</h2>-->
<div class="box-icon">
<a href="#" class="btn btn-setting btn-round"><i class="icon-cog"></i></a>
<a href="#" class="btn btn-minimize btn-round"><i class="icon-chevron-up"></i></a>
<a href="#" class="btn btn-close btn-round"><i class="icon-remove"></i></a>
</div>
</div>

<div class="box-content" align="left">
	<form id="editForm" method="post" action='<#if securityGroup??>updateSecurityGroup<#else>createSecurityGroup</#if>'>
	 <input type="hidden" name="groupId" value="${groupId?if_exists}" />
	 <input type="hidden" name="permissionIds" id="permissionIds" />
		<table cellspacing="0" class="basic-table">
			<tr class='background_tr'>
				<td class='textColumn'>&nbsp;&nbsp;&nbsp;&nbsp;权限组名称：</td>
				<td class='valueColumn'><input name="description" size='30' value="${(securityGroup.description)?if_exists}" <#if oper?? && oper.equals('view')>disabled</#if> class="required" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button class="btn btn-primary"  onclick="subThisForm('editForm');return false;">保存</button>
			</tr>
    </div>
			
		</table>
		<div style="height:500px;background:#fafafa;padding:5px;">
		<div id="p" class="easyui-panel" style="width:630px;height:400px;padding:10px;">
			<span class='textColumn'>权限选择</span>
			<ul id="treeDemo" class="ztree" style="width: 300px;height: 400px;"></ul>
		</div>
	
	</form>
</div>	
<script language='javascript'>
	var setting = {
			async: {
				enable: true,
				url:"ajaxGetPermissionTree?groupId=${groupId?if_exists}",
				autoParam: ["id", "name"],
				otherParam:{"otherParam":"zTreeAsyncTest"},
				dataFilter: filter
			},
			check: {
				enable: true
			}
		};

		function filter(treeId, parentNode, childNodes) {
			if (!childNodes) return null;
			for (var i=0, l=childNodes.length; i<l; i++) {
				childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
			}
			return childNodes;
		}

		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting);
		});
	function subThisForm(formId){
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = treeObj.getCheckedNodes(true);
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
		submitForm(formId);
	}	
</script>	