<div class="pageContent">
	<table class="table" layoutH="118" targetType="dialog" width="80%">
		<thead>
			<tr>
				<th orderfield="orgName">商品分类名称</th>
				<th width="80">查找带回</th>
			</tr>
		</thead>
		<tbody>
		<#list productCategoryList as productCategory>
			<tr>
				<td>${productCategory.categoryName?if_exists}</td>
				<td>
					<a class="btnSelect" href="javascript:$.bringBack({primaryProductCategoryId:'${productCategory.productCategoryId?if_exists}', productCategoryName:'${productCategory.categoryName?if_exists}'});changeFeature('${productCategory.productCategoryId?if_exists}');" title="查找带回">选择</a>
				</td>
			</tr>
		</#list>
		</tbody>
	</table>
</div>