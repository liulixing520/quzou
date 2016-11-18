<ul class="tt-wrapper util-clearfix">
<#if productIds?has_content> 
<#assign productIndex = 1>
	<#list productIds as productId>
		<#if productIndex!=1>
			 <li class="col-lg-15 col-md-15 col-sm-20 right">
		<#else>
			 <li class="col-lg-15 col-md-15 col-sm-20 left">
		</#if>
					${setRequestAttribute("optProductId", productId)}
					${setRequestAttribute("optProductIndex", productIndex)}
					${screens.render(newproductsummaryScreen2)}
					${setRequestAttribute("optProductId", "")}
			</li>
		<#assign productIndex = productIndex + 1>
	</#list>
</#if> 
</ul>
