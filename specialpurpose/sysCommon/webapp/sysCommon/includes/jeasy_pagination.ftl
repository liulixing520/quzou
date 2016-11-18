<#-- 分页调用 参数说明 -->
<#macro jeasyPagin   entityListTotalSize viewSize viewIndex>
<form name='pageForm' id='pageForm'>
	<input type='hidden' name='VIEW_INDEX_1' id='VIEW_INDEX_1' >
	<input type='hidden' name='VIEW_SIZE_1' id='VIEW_SIZE_1' >
</form>
<script language='javascript'>
	$(function(){
		var p = $('.easyui-datagrid').datagrid('getPager');
			$(p).pagination({
			total:${entityListTotalSize},pageSize:${viewSize!20},pageNumber:${(viewIndex?int+1)},
				onBeforeRefresh:function(){
					alert('before refresh');
				}
			});
	});
</script>

</#macro>