<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId productCategoryId=categoryId/></#assign>
<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
<li class="c_item">
<a href="${productUrl}">
  <div class="g-pic"> <img src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>" width="200" height="200"> </div>
  <span class="g-title"> ${product.internalName?if_exists}</span> 
</a>
	<#if totalPrice?exists>
  <div>${uiLabelMap.ProductAggregatedPrice}: <span class='basePrice'><@ofbizCurrency amount=totalPrice isoCode=totalPrice.currencyUsed/></span></div>
<#else>
  <#if price.listPrice?exists && price.price?exists && price.price?double lt price.listPrice?double>
  	<span class="g-del-price notranslate"><del><@ofbizCurrency amount=price.listPrice isoCode=price.currencyUsed/></del></span> 
  </#if>
   
  <b>
  <#if price.isSale?exists && price.isSale> 
  	<span class="g-del-price notranslate"> <del>${uiLabelMap.OrderOnSale}! </del> </span> <#assign priceStyle = "salePrice">
  <#else>
  	<#assign priceStyle = "regularPrice">
  </#if>
  
  <#if (price.price?default(0) > 0 && product.requireAmount?default("N") == "N")>
  	<span class="g-price"> <b class="notranslate"><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/> </b></span> 
  </#if>
  </b> 
  
  <#if price.listPrice?exists && price.price?exists && price.price?double lt price.listPrice?double>
  <#assign priceSaved = price.listPrice?double - price.price?double>
  <#assign percentSaved = (priceSaved?double / price.listPrice?double) * 100>
  	${uiLabelMap.OrderSave}: <span class="basePrice"><@ofbizCurrency amount=priceSaved isoCode=price.currencyUsed/>(${percentSaved?int}%)</span> 
  </#if>
</#if>
	<span class="basePrice">
	<#if parameters.dxStoreId??>
	<#assign dxProduct=delegator.findOne("DxProduct",{"dxStoreId",parameters.dxStoreId,"supplierStoreId",parameters.productStoreId,"productId",product.productId},false)?if_exists>
	
	<a  href='<@ofbizUrl>EditDxProduct?productId=${product.productId}&dxStoreId=${parameters.dxStoreId!}&supplierStoreId=${parameters.productStoreId!}</@ofbizUrl>'><#if dxProduct?has_content>已分销<#else>分销</#if></a></span>
	</#if>
	<#if dxProduct?has_content>
		&nbsp;&nbsp;分销价:￥${dxProduct.dxPrice!}
	</#if>
</li>
