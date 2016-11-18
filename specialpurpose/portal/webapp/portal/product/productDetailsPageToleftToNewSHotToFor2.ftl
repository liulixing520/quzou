<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId /></#assign>
<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>

<div class="ui-product-listitem-vertical util-clearfix">
    <div class="ui-product-listitem-thumb">
        <a href="${productUrl}">
            <img src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>">
        </a>
    </div>
    <div class="ui-product-listitem-info">
        <div class="product-title">
            <a href="${productUrl}">
                <#assign productName = Static["org.ofbiz.product.product.EbizProductContentWrapper"].getProductTitleByLocale(product, request)/>
														${productName!}
            </a>
        </div>
        <div class="ui-product-listitem-row ui-cost">
            <b class="notranslate">
                <@ofbizCurrency amount=price.price isoCode=price.currencyUsed/>
            </b>
        </div>
    </div>
</div>



