<#assign productIndex = -1>
<#if context.completedTree?has_content>
					<#list context.completedTree as completed>
					<#assign productIndex = productIndex + 1>
					<#assign productCategory = delegator.findOne("ProductCategory", {"productCategoryId" : completed.productCategoryId}, true)>
					<#assign pCategory = Static["org.ofbiz.product.category.EbizCategoryContentWrapper"].getProdCatNameByLocale(productCategory,request)/>
<div class="cate-panel" id="bestselling-${productIndex}">
				<div class="cate-header"><font><font>${pCategory?if_exists}</font></font></div>
				<div class="products-pane">
					<div class="loading" style="display: none; "></div>
					<div class="flipsnap-wrap" id="flipsnap-0812304">
					 <div class="viewport">
					    <!-- 取得分类 ID  -->
		                ${setRequestAttribute("optProductCategoryId",completed.productCategoryId)}
						${screens.render(newproducts)}
						${setRequestAttribute("optProductCategoryId",  "")}
					 </div>
					</div>
				</div>
				<#--<div class="keyword-pane">
					<a href="#" class="more-btn" target="_blank"><font><font>${uiLabelMap.PortalGlobalSpeedSoldMore}</font></font></a>
				</div>-->
</div>

</#list>
</#if>