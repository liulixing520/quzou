<form id="searchForm" method="post" action="<@ofbizUrl>LookupCustomerDialog</@ofbizUrl>">
	<input type="hidden" name="status" >
	<input type="hidden" name="keywords"  />
	<input type="hidden" name="VIEW_INDEX_1" />
	<input type="hidden" name="VIEW_SIZE_1"  />
	<input type="hidden" name="sortField"  />
	<input type="hidden" name="sorterDirection"  />
	<input type="hidden" name="lookupId" value='${lookupId!}' />
</form>
<div class="pageHeader">
	<form rel="searchForm" method="post" action="<@ofbizUrl>LookupCustomerDialog</@ofbizUrl>" onsubmit="return dwzSearch(this, 'dialog');">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>客户名称:</label>
				<input class="textInput" name="groupName" value="" type="text">
			</li>
		</ul>
		</div>
		<div class="subBar">
			<ul>
				<li><a  href="#" onclick="javascript:searchLookupDialogForm('${searchForm!}','${lookupId!}');" class="button"><span>${uiLabelMap.CommonFind}</span></a></li>
				<li><div class="button"><div class="buttonContent" >
				<button type="button" multLookup="${entityId!}" warn="请选择">选择带回</button>
				</div></div></li>
			</ul>
		</div>
	</form>
</div>
<div class="pageContent">

	<table class="table" layoutH="118" targetType="dialog" width="100%">
		<thead>
			<tr>
				<td ></td>
				<td >客户名称</td>
				<td orderfield="partyId">客户代码</td>
			</tr>
		</thead>
		<tbody>
        <#list results as partyGroup>
            <tr>
                <td><input type="radio" name="partyId" value="{${lookupId!}:'${partyGroup.partyId?if_exists}',groupName:'${partyGroup.groupName?if_exists}'}"/></td>
                <td>${partyGroup.groupName?if_exists}</td>
                <td>${partyGroup.customerCode?if_exists}</td>
            </tr>
        </#list>
		</tbody>
	</table>
</div>