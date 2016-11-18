<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId productCategoryId=categoryId/></#assign>
<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
<#assign productNameText><@htmlTemplate.productName product=product request=request/></#assign>
<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
<a href="${productUrl}" title="${productNameText}">
  <div class="g-pic"> <img src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>" width="200" height="200"> </div>
  <div class="g-title" style="width:200px;">
  <#--${productName?if_exists}-->
  <#if productNameText?length gt 128>${(productNameText[0..128])?if_exists}..<#else>${productNameText?if_exists}</#if>
  </div>
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
  	
  	<#else>
  	<span class="g-price"> <b class="notranslate"><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/> </b></span> 
  </#if>
  </b> 
  
  <#if price.listPrice?exists && price.price?exists && price.price?double lt price.listPrice?double>
  <#assign priceSaved = price.listPrice?double - price.price?double>
  <#assign percentSaved = (priceSaved?double / price.listPrice?double) * 100>
  	<br/>${uiLabelMap.OrderSave}: <span class="basePrice"><@ofbizCurrency amount=priceSaved isoCode=price.currencyUsed/>(${percentSaved?int}%)</span> 
  </#if>
</#if>

