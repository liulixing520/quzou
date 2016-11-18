<div class="wb-item">
	<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId productCategoryId=categoryId/></#assign>
	<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>  
    <#assign productNameText><@htmlTemplate.productName product=product request=request/></#assign>
    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
        <a class="item-hover wb-link" href="${productUrl}" title="${productNameText}">
            <div class="wb-info">
                <div class="wb-meta">
                    <span class="wb-index">${productIndex}</span>
                    <span class="wb-order">${orderQuantity}&nbsp;${uiLabelMap.PortalBestSellingQuantity}</span>
                </div>
                <img src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>" width="160" height="160">
                <div class="wb-title">
                    <#if productNameText?length gt 128>${(productNameText[0..128])?if_exists}..<#else>${productNameText?if_exists}</#if>
                </div>
                <div class="cost">
                    <b class="notranslate"><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/></b>
                    <#-- 
                    / ${uiLabelMap.PortalBestSellingDanWei}
                    -->
                </div>
            </div>
        </a>
<#--        <div class="wb-feedback">
            <span class="star star-s"><span class="rate-percent" style="width:96%"></span></span>
            <span class="feedback-num">反馈(263)</span>
        </div>-->
    </div>

