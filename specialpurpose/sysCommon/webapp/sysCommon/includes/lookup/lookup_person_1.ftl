
<div class="pageHeader">
	<form rel="pagerForm" method="post" id="${searchForm!}"  action="<@ofbizUrl>LookupPerson</@ofbizUrl>">
		<div class="searchBar">
			<ul class="searchContent">
				<li>
					<label>用户名:</label>
					<input class="textInput" name="firstName" value="" type="text">
					<input type="hidden" value="Y" name="firstName_ic">
					<input type="hidden" value="contains" name="firstName_op">
				</li>	  
			</ul>
		</div>
		<div class="subBar">
			<ul>
				<li><a  href="#" onclick="javascript:searchLookupDialogForm('${searchForm!}','${lookupId!}');" class="button"><span>${uiLabelMap.CommonFind}</span></a></li>
				<li><a  href="#" onclick="javascript:resetForm('${searchForm!}');" class="button"><span>重置</span></a></li>
				<#if lookupId?exists>
					<li><div class="button"><div class="buttonContent"><button type="button" multLookup="${entityId!}" signle=${parameters.signle!} warn="请选择">选择带回</button></div></div></li>
				</#if>
			</ul>
		</div>   
	</form>
</div>
<div class="pageContent">
	<div align='left'>
	<table class="table" layoutH="118" targetType="dialog" width="50%">
		<thead>
			<tr>
				<td ><input type="checkbox" class="checkboxCtrl" group="${lookupId!}" />全选</td>
				<td >用户ID</td>
				<td orderfield="partyId">用户名</td>
				
			</tr>
		</thead>
		<tbody>
		<#list personList as person>
		
			<tr>
				<td><input type="checkbox"  id="${entityId!}" name="${entityId!}" value="{${lookupId!}:'${person.partyId?if_exists}',joinPersonName:'${person.firstName?if_exists}'}"/></td>
				<td>${person.partyId?if_exists}</td>
				<td>${person.firstName?if_exists}</td>
				
			</tr>
		</#list>
		</tbody>
	</table>
	<!--dwz  分页 -->      
<#include "component://extErp/webapp/extErp/includes/dwz_pagination.ftl"/>      
<@dwzPagin personList listSize viewSize viewIndex  searchAction "panelBar_dialog"/>
	</div>
	
</div>
<script language='javascript'>
function ceshi(values){
	alert(values);
	
	//DWZ.jsonEval(values);
	$.pdialog.closeCurrent();
}
</script>