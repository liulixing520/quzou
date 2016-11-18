	<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId /></#assign>
	<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
        
         <li style="width: 175.6px; visibility: visible;">
                  <div class="ui-slidebox-item" data-product-id="1960977156">
                  <div class="ui-slidebox-item-thumb"> <a href="${productUrl}">
                   <img src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>" width="120px" height="120px"> </a> </div>
                  <div class="ui-slidebox-item-info"> <a class="ui-slidebox-item-title" href="${productUrl}"><font>
                         
                   <#assign productName = Static["org.ofbiz.product.product.EbizProductContentWrapper"].getProductTitleByLocale(product, request)/>
														${productName!}
                  </font></a>
                  <div class="ui-slidebox-item-row ui-cost"><b class="notranslate"><font><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/> </font></b><font> </font></div>
               </div>
           </div>
        </li>       
        
