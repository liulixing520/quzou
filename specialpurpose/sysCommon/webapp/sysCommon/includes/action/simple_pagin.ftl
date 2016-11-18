<#include "component://sysCommon/webapp/sysCommon/includes/pagination_simple.ftl"/>      
<@paginationSimple  listSize viewSize viewIndex  searchAction searchForm parameters.sortField!/>	
<script language='javascript'>	
	jQuery(function() {
		$(".checkboxCtrl").click(selectCheckIds);
   	});
</script>    	