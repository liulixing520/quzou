<script language='javascript'>
	function selectedPersonSingle(id,name,selectIdValue,selectNameValue){
		parent.$('#'+id).val(selectIdValue);
		parent.$('#'+name).val(selectNameValue);
		closeDialog('dialog');
	}
	function selectedPerson(id,name){
		var partyIds = [];
		var partyNames = [];
		$('input[name="partyIds"]:checked').each(function() {
			partyIds.push($(this).val());
			partyNames.push($(this).parent().children("span").text());
		});
		parent.$('#'+id).val(partyIds);
		parent.$('#'+name).val(partyNames);
		closeDialog('dialog');
	}
</script>
<div align='center' style='padding: 15px 15px;'  >
	<table id="personTb" class="basic-table" cellspacing="0">
		<tr class='tr_title'>
		<#list personList as person>
			<#assign rowNum=person_index+1>
				<td width='100' align='left'>
				<#if parameters.single??&&parameters.single='Y'>
					<a href='#' onclick="javascript:selectedPersonSingle('${parameters.id}','${parameters.name}','${person.partyId}','${person.firstName!}');">${person.firstName!}</a>
				<#else>
				<input type='checkbox' name='partyIds' value='${person.partyId}'><span>${person.firstName!}</span>
				</#if>
				</td>
			<#if rowNum%4==0>
			</tr><tr class='tr_title'>
			<#else>
				<#if rowNum==personList?size>
				<td colspan="${4 - (personList?size)%4}"></td>
				</#if>
			</#if>
			
		</#list>
	</table>
	<div class="buttonBarOuter"> 
    		<div id='toolBar' class="buttonBar">
				<#if parameters.single??&&parameters.single='N'>
				<a class="l-btn"  onclick="selectedPerson('${parameters.id}','${parameters.name}');" >
					<span class="l-btn-left">
						<span class="l-btn-text icon-save l-btn-icon-left">
							确定
						</span>
					</span>
				</a>
				</#if>
    		</div>
		</div>
</div>
