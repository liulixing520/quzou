<#assign productIndex = -1>
<ul class="cates-nav" id="bs-cates-nav">
					<#if context.completedTree?has_content>
					<#list context.completedTree as completed>
					<#assign productCategory = delegator.findOne("ProductCategory", {"productCategoryId" : completed.productCategoryId}, true)>
					<#assign pCategory = Static["org.ofbiz.product.category.EbizCategoryContentWrapper"].getProdCatNameByLocale(productCategory,request)/>
					<#assign productIndex = productIndex + 1>
						<li class="tab">
						   <a href="#bestselling-${productIndex?if_exists}"><font><font>${pCategory?if_exists}</font></font></a>
					    </li>
					</#list>
           </#if>
</ul>