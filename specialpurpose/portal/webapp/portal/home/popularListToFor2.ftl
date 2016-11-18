<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId /></#assign>
<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
<#assign productName><@htmlTemplate.productName product=product request=request/></#assign>

                   <dl class="clearfix">
                        <dt>
                        <a class="first" href="${productUrl}">
                            <img width="60" height="60" src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>">
                            </a>
                        </dt>
                        <dd>
                            <a class="first" href="${productUrl}">${productName}</a>
                           <#-- <a href="${productUrl}">${product.internalName?if_exists}</a>-->
                            <a href="${productUrl}" style="color:#f60;"><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/></a> 
                        </dd>
                    </dl>


