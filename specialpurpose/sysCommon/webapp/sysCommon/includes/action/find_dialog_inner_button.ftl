
<form id="pagerForm" method="post" action="${searchAction}">
	<input type="hidden" name="status" >
	<input type="hidden" name="keywords"  />
	<input type="hidden" name="VIEW_INDEX_1" />
	<input type="hidden" name="VIEW_SIZE_1"  />
	<input type="hidden" name="sortField"  />
	<input type="hidden" name="sorterDirection"  />
	
</form>
<script langugage='javascript'>
 jQuery(function(){
    	
    	jQuery("#${searchForm!}").find(":input").each(function(){
    		jQuery("#pagerForm").append("<input type='hidden' value='"+this.value+"' name='"+this.name+"'>");
    	});
    	
   	});
</script>    	
<div class="subBar">
	<ul>
		<li><a  href="#" onclick="javascript:submitDialogForm('${searchForm!}');" class="button"><span>${uiLabelMap.CommonFind}</span></a></li>
		<li><a  href="#" onclick="javascript:resetForm('${searchForm!}');" class="button"><span>${uiLabelMap.CommonReset}</span></a></li>
	</ul>
</div>          