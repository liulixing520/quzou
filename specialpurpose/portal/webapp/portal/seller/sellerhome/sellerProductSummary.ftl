<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId productCategoryId=categoryId/></#assign>
	<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
<li class="item">
    <div class="img">
        <div class="pic">
            <a class="pic-rind" href="${productUrl}">
                <img class="pic-core" src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>" alt="In Stock Original Xiaomi Mi4 Snapdragon 801  Quad Core 2.5Ghz Xiaomi M4 Mobile Phone 3G RAM 16G/64G ROM JDI Android 4.4 8MP 13MP">
            </a>
        </div>
    </div>
    <div class="detail">
        <h3>
            <a href="${productUrl}" title="In Stock Original Xiaomi Mi4 Snapdragon 801  Quad Core 2.5Ghz Xiaomi M4 Mobile Phone 3G RAM 16G/64G ROM JDI Android 4.4 8MP 13MP">${product.productName?if_exists}
            </a>
        </h3>

        <div class="cost"><b class="notranslate"><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/></b>/块</div>
        <div class="star-cost">
                 <span title="Star Rating: 4.8 out of 5" class="star star-s">
                                 <span class="rate-percent" style="width: 95.5%;"></span>
                </span>
            <span class="recent-order">订单(73)</span>
        </div>
    </div>
</li>