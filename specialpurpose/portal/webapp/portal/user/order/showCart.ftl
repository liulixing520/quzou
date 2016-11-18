

<#macro oneShoppingCart innerCartMap innerCart>
    <#assign productStoreId= innerCart.getProductStoreId()/>
<table class="orderbox">
    <tbody>
        <#assign productStore = Static["org.ofbiz.product.store.ProductStoreWorker"].getProductStore(productStoreId, delegator)?if_exists />
        <#assign productStorePrefix = Static["org.ofbiz.base.util.UtilHttpExt"].getProductStorePrefix(request,productStoreId)?if_exists />
    <tr>
        <th width="10%" colspan="7" style="background:#bbb; color:#fff;">${productStore.storeName!}</th>
    </tr>
        <#list innerCart.items() as cartLine>
            <#assign cartLineIndex = innerCart.getItemIndex(cartLine) />
        <tr>
            <td rowspan="2">
                <#if cartLine.getProductId()?exists>
                    <#if cartLine.getParentProductId()?exists>
                        <#assign parentProductId = cartLine.getParentProductId() />
                    <#else>
                        <#assign parentProductId = cartLine.getProductId() />
                    </#if>
                    <#assign smallImageUrl = Static["org.ofbiz.product.product.ProductContentWrapper"].getProductContentAsText(cartLine.getProduct(), "SMALL_IMAGE_URL", locale, dispatcher)?if_exists />
                    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg" /></#if>
                    <a href="<@ofbizCatalogAltUrl productId=parentProductId/>" target="_blank"
                       class="linktext">${cartLine.getProductId()} -
                    ${cartLine.getName()?if_exists}</a> : ${cartLine.getDescription()?if_exists}
                    <#if cartLine.getConfigWrapper()?exists>
                        <#assign selectedOptions = cartLine.getConfigWrapper().getSelectedOptions()?if_exists />
                        <#if selectedOptions?exists>
                            <div>&nbsp;</div>
                            <#list selectedOptions as option>
                                <div>
                                ${option.getDescription()}
                                </div>
                            </#list>
                        </#if>
                    </#if>
                    <#assign itemProduct = cartLine.getProduct() />
                    <#assign isStoreInventoryNotRequiredAndNotAvailable = Static["org.ofbiz.product.store.ProductStoreWorker"].isStoreInventoryRequiredAndAvailable(request, itemProduct, cartLine.getQuantity(), false, false) />
                    <#if isStoreInventoryNotRequiredAndNotAvailable && itemProduct.inventoryMessage?has_content>
                        (${itemProduct.inventoryMessage})
                    </#if>
                <#else>
                ${cartLine.getItemTypeDescription()?if_exists}: ${cartLine.getName()?if_exists}
                </#if>
            </td>
            <td><@ofbizCurrency amount=cartLine.getDisplayPrice() isoCode=innerCart.getCurrency()/></td>
            <td><input type="text" name="${productStorePrefix}update_${cartLineIndex}"
                       value="${cartLine.getQuantity()?string.number}" style="width: 30px"> &nbsp;块
            </td>
            <td><@ofbizCurrency amount=cartLine.getDisplayItemSubTotal() isoCode=innerCart.getCurrency()/></td>
            <td rowspan="2"><a href="#">删除</a></td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: left">添加备注：
                <textarea maxlength="2000" style="width: 450px"></textarea>
            </td>
        </tr>
        </#list>
    </tbody>
</table>

</#macro>
<div class="page-header">
    <h1>我的购物车</h1>
</div>
<div class="row">
    <div class="col-sm-9">
        <form method="post" action="<@ofbizUrl>modifycart</@ofbizUrl>" name="cartform">
        <#if shoppingCartMap?has_content>
            <#list shoppingCartMap.getShoppingCartList() as innerCart>
            <@oneShoppingCart innerCartMap=shoppingCartMap innerCart=innerCart />
        </#list>
        </#if>
        </form>
        <div>
            <div class="col-sm-4">
                <a href="<@ofbizUrl>main</@ofbizUrl>">继续购物</a>
            </div>
            <div class="col-sm-4 center">
                <button class="btn btn-lg btn-success" onclick="javascript:document.cartform.submit()">
                    重新计算
                </button>
            </div>
            <div class="col-sm-4 center">
                <a href="<@ofbizUrl>emptycart</@ofbizUrl>">删除所有</a>
            </div>

        </div>
    </div>
<#assign cartCurrency= "USD"/>
<#if shoppingCartMap.getShoppingCartList()?has_content>
    <#assign cartCurrency = shoppingCartMap.getShoppingCartList().get(0).getCurrency()/>
</#if>
    <div class="col-sm-3 alert alert-info">
        <h4>购物车汇总：</h4>
        <hr>
        <ul>
            <li>项目小计：<@ofbizCurrency amount=shoppingCartMap.getDisplaySubTotal() isoCode=cartCurrency/></li>
        </ul>
        <#--
        <ul>
            <li>运输成本：<@ofbizCurrency amount=shoppingCartMap.getTotalShipping() isoCode=cartCurrency/></li>
        </ul>-->
        <ul>
            <li>批发折扣：<@ofbizCurrency amount=shoppingCartMap.getOrderOtherAdjustmentTotal() isoCode=cartCurrency/></li>
        </ul>
        <ul>
            <p>总计：<@ofbizCurrency amount=shoppingCartMap.getGrandTotal() isoCode=cartCurrency/></p>
        </ul>

        <div class="col-sm-12 center">
            <a href="<@ofbizUrl>checkout</@ofbizUrl>">
                <button class="btn btn-danger">进行结账</button>
            </a>
        </div>
    </div>
</div>
