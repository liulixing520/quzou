<div class="buttonBarOuter">
    <div class="buttonBar">
    	<#if !parameters.oper??>
    	<a class="l-btn" onclick="${submitJs!'submitForm'}('${currentForm!}');return false;"  href="javascript:void(0);">
				<span class="l-btn-left">
					<span class="l-btn-text icon-save l-btn-icon-left">
						保存
					</span>
				</span>
			</a>
    	</#if>
    	<a class="l-btn" onclick="<#if parameters.backHref?has_content>window.location.href='${parameters.backHref!}'<#else>window.history.back()</#if>;return false;" href="javascript:void(0);">
				<span class="l-btn-left">
					<span class="l-btn-text icon-no l-btn-icon-left">
						返回
					</span>
				</span>
			</a>
    </div>
</div>

	
	<script language='javascript'>
	$(function(){
		// 编辑页面样式控制-单双行-单双列-因ofbiz-forms中不能或不方便设置
		try{
			jQuery(".single_table_style tr:even").addClass("background_tr");
			jQuery(".single_table_style td:even").addClass("textColumn");
			jQuery(".single_table_style td:odd").addClass("valueColumn");
			}catch(e){}
	});
	
	function openLookupDialogForms(jsName,lookupId,lookupName,id,name){
		openLookupDialog(jsName,lookupId,lookupName,id,name,'${currentForm!}');
	}
	</script>