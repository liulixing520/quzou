<form id="pagerForm" method="post" action="<@ofbizUrl>LookupUserLogin</@ofbizUrl>">
	<input type="hidden" name="status" >
	<input type="hidden" name="keywords"  />
	<input type="hidden" name="VIEW_INDEX_1" />
	<input type="hidden" name="VIEW_SIZE_1"  />
	<input type="hidden" name="sortField"  />
	<input type="hidden" name="sorterDirection"  />
</form>
<div class="pageHeader">
	<form rel="pagerForm" method="post" action="<@ofbizUrl>LookupUserLogin</@ofbizUrl>" onsubmit="return dwzSearch(this, 'dialog');">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>用户名:</label>
				<input class="textInput" name="userLoginId" value="" type="text">
			</li>	  
		</ul>
		</div>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">查询</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" multLookup="userLoginId" warn="请选择权限">选择带回</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
<div class="pageContent">

	<table class="table" layoutH="118" targetType="dialog" width="100%">
		<thead>
			<tr>
				<td ><input type="checkbox" class="checkboxCtrl" group="userLoginId" />全选</td>
				<td orderfield="userLoginId">用户</td>
				
			</tr>
		</thead>
		<tbody>
		<#list userLoginList as userLogin>
			
			 <#assign hasChecked=false>
			<#list userLoginSecurityGroupList as userLoginSecurityGroup>
				<#if userLoginSecurityGroup.userLoginId==userLogin.userLoginId>
					<#assign hasChecked=true><#break>
				</#if>
			</#list>
			<tr>
				<td><input type="checkbox"  <#if hasChecked>checked</#if>   name="userLoginId" value="{userLoginId:'${userLogin.userLoginId?if_exists}'}"/></td>
				<td>${userLogin.userLoginId?if_exists}</td>
				
			</tr>
		</#list>
		</tbody>
	</table>
</div>