
<div class="buttonBarOuter">
    <div class="buttonBar">
    	<#if !parameters.oper??>
    	<a class="l-btn" onclick="${submitJs!'submitUploadForm'}('${currentForm!}');return false;"  href="javascript:void(0);">
				<span class="l-btn-left">
					<span class="l-btn-text icon-save l-btn-icon-left">
						保存
					</span>
				</span>
			</a>
    	</#if>
    	<a class="l-btn" onclick="javascript:window.history.back();" href="javascript:void(0);">
				<span class="l-btn-left">
					<span class="l-btn-text icon-no l-btn-icon-left">
						返回
					</span>
				</span>
			</a>
    </div>
</div>