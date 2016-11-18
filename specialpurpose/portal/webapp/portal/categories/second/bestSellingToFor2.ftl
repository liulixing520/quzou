<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId /></#assign>
<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
<#assign pagelanguage = Languages?if_exists>
	<dl class="p-item">
	    <dt class="p-name">
                      <#assign productName =  Static["org.ofbiz.product.product.EbizProductContentWrapper"].getProductTitleByLocale(product,request)!!/>
	         <a href=""><font><a href="${productUrl}" title="${productName?if_exists}">
	         <#if productName?length gt 100>${(productName[0..100])?if_exists}..<#else>${productName?if_exists}</#if>
	         </a></font></a>
	         <span class="price"><font><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/></font></span>
	    </dt>
	        <dd class="p-pic">
	            <a href=""><img width="60" height="60" src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>"  alt="${product.internalName?if_exists}"></a>
	            <!-- <span class="orders-num"><font>xxxw个订单</font></span> -->
	        </dd>
	    </dl>



