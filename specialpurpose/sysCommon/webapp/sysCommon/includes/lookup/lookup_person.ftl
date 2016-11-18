<div class="pageHeader" style="border:1px #B8D0D6 solid">
	<form id="pagerForm" onsubmit="return divSearch(this, 'jbsxBox2');" action="LookupPerson" method="post">
	<input type="hidden" name="status" >
	<input type="hidden" name="keywords"  />
	<input type="hidden" name="VIEW_INDEX_1" />
	<input type="hidden" name="VIEW_SIZE_1"  />
	<input type="hidden" name="sortField"  />
	<input type="hidden" name="sorterDirection"  />
	<input type="hidden" name="lookupId" value='${lookupId!}' />
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					姓名：<input class="textInput" name="firstName" value='${queryStringMap.firstName!}' type="text">
							<input type="hidden" value="Y" name="firstName_ic">
							<input type="hidden" value="contains" name="firstName_op">
				</td>
				<td><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></td>
				<#if lookupId?exists>
					<td><div class="button"><div class="buttonContent"><button type="button" multLookup="${entityId!}" signle=${parameters.signle!} warn="请选择">选择带回</button></div></div></td>
				</#if>
				
			</tr>
		</table>
	</div>
	</form>
</div>

<div class="pageContent" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
	<div class="panelBar">
		
	</div>
	<table class="table" width="99%" layoutH="138" rel="jbsxBox2">
		<thead>
				<tr>
					<td >操作</td>
					<td >用户ID</td>
					<td orderfield="partyId">用户名</td>
					
				</tr>
		</thead>
		<tbody>
			<#list personList as person>
			<!-- 
			<input type='hidden'  id="${entityId!}" name="${entityId!}" value="{${lookupId!}:'${person.partyId?if_exists}',joinPersonName:'${person.firstName?if_exists}'}"/>
			-->
				<tr id='${person.partyId?if_exists}Tr'>
					<td><div class="buttonActive"><div class="buttonContent"><button type="button" onclick="javascript:selectTo('${person.partyId?if_exists}')">增加</button></div></div></td>
					<td>${person.partyId?if_exists}</td>
					<td>${person.firstName?if_exists}</td>
					
				</tr>
			</#list>
		</tbody>
	</table>
	<div class="panelBar">
		<div class="pages">
			<span>显示</span>
			<select class="combox" name="VIEW_SIZE_1" onchange="dialogPageBreak({VIEW_SIZE_1:this.value}, 'jbsxBox2')">
				<option value="20">20</option>
				<option value="50">50</option>
				<option value="100">100</option>
				<option value="200">200</option>
			</select>
			<span>显示&nbsp;&nbsp;共${listSize!0}条</span>
		</div>
		
		<div class="pagination" rel="jbsxBox2" targetType="dialog" totalCount="${listSize!}" VIEW_SIZE_1="${VIEW_SIZE_1!20}" pageNumShown="3" currentPage="${(VIEW_INDEX_1)!1}"></div>

	</div>
	
</div>