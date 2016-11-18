<div class="pageHeader">
	<form rel="pagerForm" method="post" action="demo/database/dwzOrgLookup2.html" onsubmit="return dwzSearch(this, 'dialog');">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>权限名称:</label>
				<input class="textInput" name="orgName" value="" type="text">
			</li>	  
			<li>
				<label></label>
				<input class="textInput" name="orgNum" value="" type="text">
			</li>
			
		</ul>
		</div>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">查询</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" multLookup="permissionId" warn="请选择权限">选择带回</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
<div class="pageContent">

	<table class="table" layoutH="118" targetType="dialog" width="40%">
		<thead>
			<tr>
				<td width="10%"><input type="checkbox" class="checkboxCtrl" group="permissionId" />全选</td>
				<td width="30%" orderfield="permissionId">权限名称</td>
				<td width="60%" orderfield="description">描述</td>
			</tr>
		</thead>
		<tbody>
		<#list securityPermissionList as securityPermission>
		 <#assign hasChecked=false>
			<#list securityGroupPermissionList as securityGroupPermission>
				<#if securityPermission.permissionId==securityGroupPermission.permissionId>
					<#assign hasChecked=true><#break>
				</#if>
			</#list>
			<tr>
				<td width="10%"><input type="checkbox" <#if hasChecked>checked</#if>  name="permissionId" value="{permissionId:'${securityPermission.permissionId?if_exists}',permission_description:'${securityPermission.description?if_exists}'}"/></td>
				<td width="30%">${securityPermission.permissionId?if_exists}</td>
				<td width="60%">
					${securityPermission.description?if_exists}
				</td>
			</tr>
		</#list>
		</tbody>
	</table>
</div>