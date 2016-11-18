<#list catChilds as catChild>
	<li onclick="javascript:selectCategory('${catChild.productCategoryId}', '${catChild.categoryName}', '${catChild.primaryParentCategoryId}', '${divId}', '${index}');" title="${catChild.categoryName}" data-param="catePubId=${catChild.productCategoryId}" data-message=""
		data-remark="" data-leaf="0" data-valid="1" data-en="${category.categoryName}"
		data-cn="${catChild.categoryName}" >${catChild.categoryName}</li>
</#list>