<script type="text/javascript">
	checkValueAndSubmit = function(){
		var content0 = document.getElementById("typeContent0").value;
		var content1 = document.getElementById("typeContent1").value;
		var content2 = document.getElementById("typeContent2").value;
		//var content3 = document.getElementById("typeContent3").value;
		
		if(content0==""||content1==""||content2==""){
			alert("信息都不能为空！");
			return false;
		}
		submitFormsSimple('setSeoMSG');
	};
</script>
<form id="setSeoMSG" name="setSeoMSG" action="setSeoMSG"  method="post" >
	<table class="basic-table" width="100%" cellspacing="0" cellpadding="0" border="0">
	<tr >
	<td class="border03 width15">
		<input type="hidden" name="PSCTypeId0"value="<#if psType?? && (psType[3].PSCTypeId)??>${psType[3].PSCTypeId}</#if>">
		<#if psType?? && (psType[3].PSCType)??>${psType[3].PSCType}</#if>
	</td>
	<td class="border02 width85">
		<input style="width:310px" type="text" id="typeContent0" name="typeContent0" value="<#if psType?? && (psType[3].typeContent)??>${psType[3].typeContent}</#if>">
	</td>
	</tr>
	<tr >
	<td class="border03 width15">
		<input type="hidden" name="PSCTypeId1"value="<#if psType?? && (psType[2].PSCTypeId)??>${psType[2].PSCTypeId}</#if>">
		<#if psType?? && (psType[2].PSCType)??>${psType[2].PSCType}</#if>
	</td>
	<td class="border02 width85">
		<input style="width:310px" type="text" id="typeContent1" name="typeContent1" value="<#if psType?? && (psType[2].typeContent)??>${psType[2].typeContent}</#if>">
	</td>
	</tr>
	<tr >
	<td class="border03 width15">
		<input type="hidden" name="PSCTypeId2"value="<#if psType?? && (psType[1].PSCTypeId)??>${psType[1].PSCTypeId}</#if>">
		<#if psType?? && (psType[1].PSCType)??>${psType[1].PSCType}</#if>
	</td>
	<td class="border02 width85">
		<input style="width:310px" type="text" id="typeContent2" name="typeContent2" value="<#if psType?? && (psType[1].typeContent)??>${psType[1].typeContent}</#if>">
	</td>
	</tr>
	<tr style="display:none">
	<td class="border03 width15">
		<input type="hidden" name="PSCTypeId3"value="<#if psType?? && (psType[0].PSCTypeId)??>${psType[0].PSCTypeId}</#if>">
		<#if psType?? && (psType[0].PSCType)??>${psType[0].PSCType}</#if>
	</td>
	<td class="border02 width85">
		<input style="width:315px;height:50px" type="textarea" id="typeContent3" name="typeContent3" value="<#if psType?? && (psType[0].typeContent)??>${psType[0].typeContent}</#if>">
	</td>
	</tr>
	<tr>
	<td colspan="2" align="center">
	<input id="button3" class="botinput" type="button" value="确定" name="button3" onclick = "submitForm('setSeoMSG');">
	<input id="button3" class="botinput" type="reset" value="重置" name="button3">
	</td>
	</tr>
	</table>
</form>