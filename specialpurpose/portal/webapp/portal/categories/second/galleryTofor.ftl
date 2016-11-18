   <div class="omod-category-page-img-nav1">
 	<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId productCategoryId=categoryId/></#assign>
    <#assign smallImageUrl = productCategory.categoryImageUrl?if_exists>
    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
         <!--得到分类下的商品ID号,进一步for循环遍历  -->   
     <ul class="c_items">
			<#if productIds?has_content>   
			         
						<#list productIds as productId>
								${setRequestAttribute("optProductId", productId)}
								${screens.render(productsummaryScreen)}
								${setRequestAttribute("optProductId", "")}
						</#list>
			</#if> 
    </ul>
</div> 



