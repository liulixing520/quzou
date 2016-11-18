<#if communicationEvent??>
	<table  cellspacing="0" class="basic-table" style="margin-bottom: 10px;">
		<#if communicationEvent.subject??>
		<tr class='background_tr'>
			<td class='border03'align="right" style="width:15%">
			主题
			</td>
			<td class='border02'>
		&nbsp;&nbsp;&nbsp;&nbsp;${communicationEvent.subject}
			</td>
		</tr>
		</#if>
		<#if communicationEvent.fromString??>
		<tr class='background_tr'>
			<td class='border03'align="right" style="width:15%">
			发件箱
			</td>
			<td class='border02'>
		&nbsp;&nbsp;&nbsp;&nbsp;${communicationEvent.fromString}
			</td>
		</tr>
		</#if>
		<#if communicationEvent.datetimeStarted??>
		<tr class='background_tr'>
			<td class='border03'align="right" style="width:15%">
			发件日期
			</td>
			<td class='border02'>
		&nbsp;&nbsp;&nbsp;&nbsp;${communicationEvent.datetimeStarted}
			</td>
		</tr>
		</#if><#if communicationEvent.content??>
		<tr class='background_tr'>
			<td class='border03'align="right" style="width:15%">
			邮件内容
			</td>
			<td class='border02'>
			<div style="overflow:auto;" id="emailContent">
			</div>
			<script type="text/javascript">
				document.getElementById("emailContent").innerHTML="${communicationEvent.content}";
			</script>
			</td>
		</tr>
		</#if>
	</table>
</#if>