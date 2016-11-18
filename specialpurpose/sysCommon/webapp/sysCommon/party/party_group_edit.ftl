<div align="center">
	<form id="admin_zyglAdd_addForm" method="post" action='<#if entity??>updatePartyGroup<#else>createPartyGroup</#if>'>
	<input type='hidden' name='roleTypeId' value='DEPARTMENT'>
	<input type="hidden" name="partyId" value="${partyId?if_exists}" />
		<table class="tableForm">
			<tr>
			
				<th>部门名称</th>
				<td><input name="groupName" value="<#if entity??>${entity.groupName?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> class="easyui-validatebox" data-options="required:true" />
				</td>
				<th>部门排序</th>
				<td><input name="sortNum" class="easyui-numberspinner" data-options="min:0,max:999,editable:true" value="<#if entity??&&entity.sortNum??>${entity.sortNum?if_exists}<#else>1</#if>" style="width: 155px;" />
				</td>
			</tr>
			<tr>
			
				<th>部门编号</th>
				<td><input name="barCode" value="<#if entity??>${entity.barCode?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> class="easyui-validatebox" data-options="required:true" />
				</td>
				<th>部门描述</th>
				<td><input name="remark"  value="<#if entity??&&entity.remark??>${entity.remark?if_exists}</#if>" style="width: 155px;" />
				</td>
			</tr>
             
			<tr>
				<th>上级部门</th>
				<td colspan="3"><input id="admin_zyglAdd_pid" name="parentPartyId" class="easyui-combotree" data-options="url:'ajaxGetPartyGroupTree',parentField : 'pid',lines : true" value="${(entity.parentPartyId)!}" style="width: 370px;" />
				<img src="/images/icons/famfamfam/cut_red.png" onclick="$('#admin_zyglAdd_pid').combotree('clear');" />
				</td>
			</tr>
		</table>
	</form>
</div>