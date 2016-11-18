<div class="formBar" >
		<ul>
		<li><a class="button" href="#" onclick="javascript:ajaxSubmitForms('${currentForm}');"  ><span>
		<#if entity??>
		${uiLabelMap.CommonSave}
		
		<#else>
		${uiLabelMap.CommonCreate}
		</#if>
		</span></a></li>
			<li><div class="button"><div class="buttonContent"><button class="close" type="button">${uiLabelMap.CommonClose}</button></div></div></li>
		</ul>
	</div>  