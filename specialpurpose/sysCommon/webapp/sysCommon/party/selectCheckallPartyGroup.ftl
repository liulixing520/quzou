<script language='javascript'>
	function selectedPartyGroupSingle(id,name,selectIdValue,selectNameValue){
		parent.$('#'+id).val(selectIdValue);
		parent.$('#'+name).val(selectNameValue);
		closeDialog('dialog');
	}
	function selectedPartyGroup(id,name){
		var partyIds = [];
		var groupNames = [];
		$('input[name="partyIds"]:checked').each(function() {
			partyIds.push($(this).val());
			groupNames.push($(this).parent().parent().parent().children("span").text());
		});
		parent.$('#'+id).val(partyIds);
		parent.$('#'+name).val(groupNames);
		closeDialog('dialog');
	}
	
</script>

<div id="toolBar" class="buttonBar">
	<#if parameters.single??&&parameters.single='N'>
		<a href='#'  class="btn btn-primary" onclick="selectedPartyGroup('${parameters.id}','${parameters.name}');" >确定</a>
	</#if>
</div>
	<table id="personTb" class="basic-table" cellspacing="0">
		<tr class='tr_title'>
		<#list partyGroupList as partyGroup>
			<#assign rowNum=partyGroup_index+1>
				<td width='120' align='left'>
				<#if parameters.single??&&parameters.single='Y'>
					<a href='#' onclick="javascript:selectedPartyGroupSingle('${parameters.id}','${parameters.name}','${partyGroup.partyId}','${partyGroup.groupName!}');">${partyGroup.groupName!}</a>
				<#else>
				<input type='checkbox' name='partyIds' value='${partyGroup.partyId}'/><span>${partyGroup.groupName!}</span>
				</#if>
				</td>
			<#if rowNum%4==0>
			</tr><tr class='tr_title'>
			<#else>
				<#if rowNum==partyGroupList?size>
				<td colspan="${4 - (partyGroupList?size)%4}"></td>
				</#if>
			</#if>
			
		</#list>
	</table>
