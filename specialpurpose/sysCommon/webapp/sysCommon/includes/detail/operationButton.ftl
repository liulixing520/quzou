<#assign backAction = StringUtil.wrapString("&backAction="+request.getRequestURI()+"?"+(request.getQueryString().replaceAll("&","`"))!)>


<#if (OperationLayout?exists)&&OperationLayout=="footer">
					
<div class="orderactionbntfooder">
    <div class="action-bnt-middle">
	    <div class="inlinedivFooder">
<#else>
<div class="orderactionbnt">
                 <div class="action-bnt-middle">
					<div class="inlinediv">
					
</#if> 					

			<!-- start  -->
			${screens.render(buttonScreens)}
 
             <!--  end  -->
          </div>
      </div>
</div>
