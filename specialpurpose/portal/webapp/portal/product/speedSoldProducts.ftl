<li class="flipsnap-item" style="width: 1199px; ">
	<ul class="product-items" style="width:100%">
    <#assign productUrl><@ofbizCatalogAltUrl productId=product.productId productCategoryId=categoryId/></#assign>
			<#if productIds?has_content>
						<#list productIds as productId>
								${setRequestAttribute("optProductId", productId)}
								${screens.render(productsummary1)}
								${setRequestAttribute("optProductId", "")}
						</#list>

			</#if>
		</ul>
</li>