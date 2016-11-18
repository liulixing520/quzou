<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId /></#assign>
<#if productIds?has_content>
	<#list productIds as productId>
			${setRequestAttribute("optProductId", productId)}
			${screens.render(productsummaryScreen2)}
			${setRequestAttribute("optProductId", "")}
	</#list>
	<#--<div  style="float:right; text-align:right"><a href="/portal/control/globalSpeedSold"><font>${uiLabelMap.PortalBestSelling}</font></a></div>-->
</#if>



