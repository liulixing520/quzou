<ul>    
    <#list shoppingCart.getProductPromoUseInfoIter() as productPromoUseInfo>
        <li>
        	<#assign productPromo = delegator.findOne("ProductPromo", {"productPromoId" : productPromoUseInfo.productPromoId}, true)>
           ${productPromo.promoName?if_exists}
            <#if productPromoUseInfo.productPromoCodeId?has_content> - ${uiLabelMap.OrderWithPromoCode} [${productPromoUseInfo.productPromoCodeId}]</#if>
            <#if (productPromoUseInfo.totalDiscountAmount != 0)> - ${uiLabelMap.CommonTotalValue} <@ofbizCurrency amount=(-1*productPromoUseInfo.totalDiscountAmount) isoCode=shoppingCart.getCurrency()/></#if>
        </li>
        <#if (productPromoUseInfo.quantityLeftInActions > 0)>
            <li>- Could be used for ${productPromoUseInfo.quantityLeftInActions} more discounted item<#if (productPromoUseInfo.quantityLeftInActions > 1)>s</#if> if added to your cart.</li>
        </#if>
    </#list>
</ul>