<div>
<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId /></#assign>
<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
<#assign productNameText><@htmlTemplate.productName product=product request=request/></#assign>
<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
    <li class="item-cell">
        <a rel="nofollow" hidefocus="true" class="item-hover" href="${productUrl}" title="${(productNameText)!}">
            <div class="g-pic">
                <img src="${contentPathPrefix?if_exists}${smallImageUrl}">
            </div>
                <span class="g-title">
                    <#--${product.internalName?if_exists}-->
                    ${productNameText!}
                </span>
        </a>
    </li>
<div>

