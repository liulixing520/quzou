
<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId /></#assign>
<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
<#assign productNameText><@htmlTemplate.productName product=product request=request/></#assign>
	
	<li class="p4p-list-item">
                    <div class="img-box-wrap">
                      <div class="img-box"><a href="${productUrl}"><img src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>" class="auto-set-img0"></a></div>
                    </div>
                    <p class="p4p-product-title"><a href="${productUrl}">${productNameText}</a></p>
                    <p class="p4p-price-list"><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/><span class="fwn"></span></p>
                   <#-- <p class="p4p-more-info"><a href="" class="p4pAliTalk atm16">现在聊天</a></p>-->
    </li>

