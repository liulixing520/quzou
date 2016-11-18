
<form id="pagerForm" method="post" action="${searchAction}">
	<input type="hidden" name="status" >
	<input type="hidden" name="keywords"  />
	<input type="hidden" name="VIEW_INDEX_1" />
	<input type="hidden" name="VIEW_SIZE_1"  />
	<input type="hidden" name="sortField"  />
	<input type="hidden" name="sorterDirection"  />
	<input type="hidden" name="lookupId" value='${lookupId!}' />
	
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
		<li><a  href="#" onclick="javascript:searchLookupDialogForm('${searchForm!}','${lookupId!}');" class="button"><span>${uiLabelMap.CommonFind}</span></a></li>
		<li><a  href="#" onclick="javascript:resetForm('${searchForm!}');" class="button"><span>重置</span></a></li>
		<#if lookupId?exists>
			<li><div class="button"><div class="buttonContent"><button type="button" multLookup="${entityId!}" signle=${parameters.signle!} warn="请选择">选择带回</button></div></div></li>
		</#if>
	</ul>
</div>          