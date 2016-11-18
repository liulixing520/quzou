
	<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId /></#assign>
	<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
	<#if (requestAttributes.ProductCategoryId)?exists><#assign threePCId = requestAttributes.ProductCategoryId></#if>
    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
	<#assign pagelanguage = Languages?if_exists>
    <#assign productName = Static["org.ofbiz.product.product.EbizProductContentWrapper"].getProductTitleByLocale(product,request)!!/>
            <li class="c_item">
              <div> <a href="${productUrl}" title="${productName?if_exists}"> <img width="120" height="120" src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>" class="c_img" href="${productUrl}"> 
			  <span title="" class="c_name elliptical"> <font>${productName?if_exists}</font> </span> </a>
                <ul class="c_attribute">
                  <li><span class="price"><em><font><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/></font></em></span></li>
                </ul>
              </div>
            </li>
 
 