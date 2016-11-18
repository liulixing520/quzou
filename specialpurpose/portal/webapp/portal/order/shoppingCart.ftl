<#macro oneShoppingCart innerCartMap innerCart>
    <#assign productStoreId= innerCart.getProductStoreId()/>
<table class="orderbox">
    <tbody>
        <#assign productStore = Static["org.ofbiz.product.store.ProductStoreWorker"].getProductStore(productStoreId, delegator)?if_exists />
        <#assign productStorePrefix = Static["org.ofbiz.base.util.UtilHttpExt"].getProductStorePrefix(request,productStoreId)?if_exists />
    <tr>
        <th width="10%" colspan="6" style="background:#bbb; color:#fff; text-align:left;">${uiLabelMap.PortalUserCarStore}：
        <!-- 分销 -->
        <@htmlTemplate.storeNameMac storeName=productStore.storeName dxStoreId=innerCart.dxStoreId!/>
       </th>
    </tr>
    <tr>
        <td style="background:#eee;">${uiLabelMap.PortalUserCarProduct}</td>
        <td style="background:#eee;">${uiLabelMap.PortalUserCarPicture}</td>
        <td style="background:#eee;">${uiLabelMap.PortalUserCarUnitPrice}</td>
        <td style="background:#eee;">${uiLabelMap.PortalUserCarQuantity}</td>
        <td style="background:#eee;">${uiLabelMap.PortalUserCarTotalPrice}</td>
        <td style="background:#eee;">${uiLabelMap.PortalUserCarOperating}</td>
    </tr>
        <#list innerCart.items() as cartLine>

            <#assign cartLineIndex = innerCart.getItemIndex(cartLine) />
        <tr>
            <td>
                <#if cartLine.getProductId()?exists>
                <#-- product item -->
                <#-- start code to display a small image of the product -->
                    <#if cartLine.getParentProductId()?exists>
                        <#assign parentProductId = cartLine.getParentProductId() />
                    <#else>
                        <#assign parentProductId = cartLine.getProductId() />
                    </#if>
                    <#assign smallImageUrl = Static["org.ofbiz.product.product.ProductContentWrapper"].getProductContentAsText(cartLine.getProduct(), "SMALL_IMAGE_URL", locale, dispatcher)?if_exists />
                    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg" /></#if>
                <#--
                <#if smallImageUrl?string?has_content>
                  <a href="<@ofbizCatalogAltUrl productId=parentProductId/>"  target="_blank">
                    <img src="<@ofbizContentUrl>${requestAttributes.contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>" alt="Product Image" class="imageborder" />
                  </a>
                </#if>
                -->
                <#-- end code to display a small image of the product -->
                <#-- ${cartLineIndex} - -->
                
                
                
               
                
                
                    <a href="<@ofbizCatalogAltUrl productId=parentProductId/><#if innerCart.dxStoreId?has_content>?dxStoreId=${innerCart.dxStoreId}</#if>" target="_blank"
                       class="linktext">${cartLine.getProductId()} -
                       
                       <#-- 判断商品语种-->
 					<#assign product=cartLine.getProduct() />
						<#assign productName = Static["org.ofbiz.product.product.EbizProductContentWrapper"].getProductTitleByLocale(product, request)/>
														${productName!}
                    
                    : ${cartLine.getDescription()?if_exists}</a>
                <#-- For configurable products, the selected options are shown -->
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

                <#-- if inventory is not required check to see if it is out of stock and needs to have a message shown about that... -->
                    <#assign itemProduct = cartLine.getProduct() />
                    <#assign isStoreInventoryNotRequiredAndNotAvailable = Static["org.ofbiz.product.store.ProductStoreWorker"].isStoreInventoryRequiredAndAvailable(request, itemProduct, cartLine.getQuantity(), false, false) />
                    <#if isStoreInventoryNotRequiredAndNotAvailable && itemProduct.inventoryMessage?has_content>
                        (${itemProduct.inventoryMessage})
                    </#if>

                <#else>
                <#-- this is a non-product item -->
                ${cartLine.getItemTypeDescription()?if_exists}: ${cartLine.getName()?if_exists}
                </#if>

            </td>
            <td><img src="${smallImageUrl}" width="80px" height="80px" /></td>
            <td><@ofbizCurrency amount=cartLine.getDisplayPrice() isoCode=innerCart.getCurrency()/></td>
               <script type="text/javascript">
                    //判断正整数  
					function checkRate(obj){  
					  if(isNaN(obj.value)){ 
						obj.value=(obj.value+"").substr(0,(obj.value+"").length-1);
						if(obj.value.length<1)
						obj.value=1;
						return;
					  } 
					  var str = obj.value+"";
					  if(str.indexOf(".")>-1){    
					    obj.value=(obj.value+"").substr(0,(obj.value+"").length-1);
					    if(obj.value.length<1)
						obj.value=1;
					    return;
					  }
					   
					 } 
	            	function checkRatenull(obj){
	            		if(obj.value.length<1)
						obj.value=1;
	            	}
	            	
                    </script>
                    
            <td><input type="text" name="${productStorePrefix}update_${cartLineIndex}"
                       value="${cartLine.getQuantity()?string.number}" style="width: 30px"  onkeyup="checkRate(this);" onBlur="checkRatenull(this);" > &nbsp;${uiLabelMap.PortalUserCarNumber}
            </td>
            <td><@ofbizCurrency amount=cartLine.getDisplayItemSubTotal() isoCode=innerCart.getCurrency()/></td>
            <td><a href="<@ofbizUrl>deleteFromCart</@ofbizUrl>?DELETE_${cartLineIndex}=Y&productStoreId=${productStoreId}">${uiLabelMap.PortalUserDelete}</a></td>
        </tr>
        </#list>
    </tbody>
</table>

</#macro>
<div class="cartList">
    <div class="">
        <h1>${uiLabelMap.PortalUserMyCar}</h1>
    </div>
<#if shoppingCartMap?has_content && shoppingCartMap.getShoppingCartList()?has_content && (shoppingCartMap.size()>0)>
    <div class="cartList-left">
        <#assign cartCurrency= "USD"/>
        <form method="post" action="<@ofbizUrl>modifycart</@ofbizUrl>" name="cartform">
            <#list shoppingCartMap.getShoppingCartList() as innerCart>
            	<#if (innerCart.size()>0)>
                 <@oneShoppingCart innerCartMap=shoppingCartMap innerCart=innerCart />
                 <#assign cartCurrency = innerCart.getCurrency()/>
                </#if>
            </#list>
        </form>
        <div>
            <a href="<@ofbizUrl>main</@ofbizUrl>" class="b_list">${uiLabelMap.PortalUserCarContinueShopping}</a>
            <a href="<@ofbizUrl>emptycart</@ofbizUrl>" class="d_list">${uiLabelMap.PortalUserCarDeleteAll}</a>
            <button class="c_list" onclick="javascript:document.cartform.submit()">
                ${uiLabelMap.PortalUserCarRecalculated}
            </button>
        </div>
    </div>

    <div class="cartList-right">
        <h4 style="line-height:30px; padding-left:10px; font-weight:bold; margin-bottom:0;">${uiLabelMap.PortalUserCarRollup}：</h4>
        <hr>
        <ul>
            <li style="line-height:25px;">${uiLabelMap.PortalUserCarItemsSubTotal}：<@ofbizCurrency amount=shoppingCartMap.getDisplaySubTotal() isoCode=cartCurrency/></li>
            <li style="line-height:25px;">${uiLabelMap.PortalUserCarShippingCosts}：<@ofbizCurrency amount=shoppingCartMap.getTotalShipping() isoCode=cartCurrency/></li>
            <li style="line-height:25px;">
                ${uiLabelMap.PortalUserCarWholesaleDiscount}：<@ofbizCurrency amount=shoppingCartMap.getOrderOtherAdjustmentTotal() isoCode=cartCurrency/></li>
        </ul>
        <div class="cart-summer">
            <p>${uiLabelMap.PortalUserCarTotal}：<@ofbizCurrency amount=shoppingCartMap.getGrandTotal() isoCode=cartCurrency/></p>
            <a href="<@ofbizUrl>checkout</@ofbizUrl>" class="a_list">${uiLabelMap.PortalUserCarCheckout}</a>
        </div>
    </div>
<#else>
    <div style="min-height: 150px">
        ${uiLabelMap.PortalUserCarShoppingCartEmpty}！！
        <a href="<@ofbizUrl>main</@ofbizUrl>">${uiLabelMap.PortalUserCarBackHome}</a>
    </div>
</#if>
</div>
<div class="endcolumns">&nbsp;</div>
<div style="clear:both;"></div>