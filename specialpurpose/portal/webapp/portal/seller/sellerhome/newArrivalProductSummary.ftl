<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId productCategoryId=categoryId/></#assign>
	<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
<li class="item util-clearfix">
 
    
    <div class="img">
                        <a class="img"
                           href="${productUrl}">
                            <img width="50"
                                 src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>"
                                 alt="${product.productName?if_exists}">
                        </a>
                    </div>
                    <div class="detail">
                        <div class="pro-name">
                            <a href="${productUrl}"
                               title="${product.internalName?if_exists}">${product.internalName?if_exists}
                            </a>
                        </div>
                        <div class="price"><span class="notranslate"><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/></span></div>
                    </div>
</li>