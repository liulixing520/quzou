<form id="pagerForm" method="post" action="<@ofbizUrl>LookupPartyGroup</@ofbizUrl>">
	<input type="hidden" name="status" >
	<input type="hidden" name="keywords"  />
	<input type="hidden" name="VIEW_INDEX_1" />
	<input type="hidden" name="VIEW_SIZE_1"  />
	<input type="hidden" name="sortField"  />
	<input type="hidden" name="sorterDirection"  />
	<input type="hidden" name="lookupId" value='${lookupId!}' />
</form>
<div class="pageHeader">
	<form rel="pagerForm" method="post" action="<@ofbizUrl>LookupPartyGroup</@ofbizUrl>" onsubmit="return dwzSearch(this, 'dialog');">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>用户名:</label>
				<input class="textInput" name="groupName" value="" type="text">
			</li>	  
		</ul>
		</div>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">查询</button></div></div></li>
				<li><div class="button"><div class="buttonContent" >
				<button type="button" multLookup="${entityId!}" warn="请选择部门">选择带回</button>
				</div></div></li>
			</ul>
		</div>
	</form>
</div>
<div class="pageContent">

	<table class="table" layoutH="118" targetType="dialog" width="100%">
		<thead>
			<tr>
				<td ><input type="checkbox" class="checkboxCtrl" group="partyId" />全选</td>
				<td >部门ID</td>
				<td orderfield="partyId">部门名称</td>
				
			</tr>
		</thead>
		<tbody>
		<#list partyGroupList as partyGroup>
		
			<tr>
				<td><input type="checkbox"   name="partyId" value="{${lookupId!}:'${partyGroup.partyId?if_exists}',groupName:'${partyGroup.groupName?if_exists}'}"/></td>
				<td>${partyGroup.partyId?if_exists}</td>
				<td>${partyGroup.groupName?if_exists}</td>
				
			</tr>
		</#list>
		</tbody>
	</table>
</div>