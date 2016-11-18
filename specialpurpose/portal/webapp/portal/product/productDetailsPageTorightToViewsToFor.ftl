
<ul id="sellingGoodsRoll">
<#if productIds?has_content>            

			<#list productIds as productId>
					${setRequestAttribute("optProductId", productId)}
					${screens.render(showproductViewsScreen)}
					${setRequestAttribute("optProductId", "")}
			</#list>
			           
	
</#if> 
</ul>