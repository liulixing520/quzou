<script language='javascript'>
	
// frame方式删除
function deleteForms(url) {
	$.messager.confirm('确认', '您确定要删除吗？', function(r) {
		if (r) {
			jQuery.ajax({
				url : url,
				type : 'POST',
				error : function(msg) {
					// alert(msg);
				},
				success : function(msg) {
					$.messager.show({
						title : '提示',
						msg : '删除成功'
					});
					// 查询
					searchFormFun('${searchForm!}');
				}
			});
		}
	});
}
</script>

</td>
<td>
<a class="l-btn" onclick="javascript:searchFormFun('${searchForm!}');return false;" href="javascript:void(0);">
	<span class="l-btn-left">
		<span class="l-btn-text icon-search l-btn-icon-left">
			查询
		</span>
	</span>
</a>
</td></tr></table>