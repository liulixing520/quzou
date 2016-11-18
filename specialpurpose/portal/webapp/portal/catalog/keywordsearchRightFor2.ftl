	<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId /></#assign>
	<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>


            <li class="p4p-list-item">
              <div class="img-box-wrap">
                <div class="img-box"><a href="${productUrl}"><img src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>" class="auto-set-img0"></a></div>
              </div>
              <p class="p4p-product-title"><a href="${productUrl}">${product.internalName?if_exists}</a></p>
              <p class="p4p-price-list"><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/><span class="fwn"></span></p>
              <!-- <p class="p4p-more-info"><a href="javascript:void(0);" class="p4pAliTalk atm16">现在聊天</a></p> -->
            </li>
