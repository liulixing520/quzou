<div class="formBar" >
		<ul>
		<li><a class="button" href="#" onclick="javascript:submitFormsSimple('${currentForm}');"  ><span>
		<#if entity??>
		${uiLabelMap.CommonSave}
		
		<#else>
		${uiLabelMap.CommonSave}
		</#if>
		</span></a></li>
			<li><div class="button"><div class="buttonContent"><button class="close" type="button">${uiLabelMap.CommonClose}</button></div></div></li>
		</ul>
	</div>  