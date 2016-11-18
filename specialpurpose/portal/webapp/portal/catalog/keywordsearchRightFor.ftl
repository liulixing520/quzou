      
<ul class="p4p-side-content" id="p4p-side-content">
<#if productIds?has_content> 
	<#list productIds as productId>
					${setRequestAttribute("optProductId", productId)}
					${screens.render(showproducttjScreen)}
					${setRequestAttribute("optProductId", "")}
	</#list>
</#if> 
</ul>