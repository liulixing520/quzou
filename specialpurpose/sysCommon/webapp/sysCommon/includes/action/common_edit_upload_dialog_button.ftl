<div class="buttonBarOuter">
    <div class="buttonBar">
    	<#if !parameters.oper??>
    	<a class="l-btn" onclick="${submitJs!'submitDialogForm'}('${currentForm!}');" target="mainFrame"  href="javascript:void(0);">
				<span class="l-btn-left">
					<span class="l-btn-text icon-save l-btn-icon-left">
						保存
					</span>
				</span>
			</a>
    	</#if>
    	<a class="l-btn" onclick="javascript:closeDialog('${dialogId!}');" href="javascript:void(0);">
				<span class="l-btn-left">
					<span class="l-btn-text icon-no l-btn-icon-left">
						关闭
					</span>
				</span>
			</a>
    </div>
</div>