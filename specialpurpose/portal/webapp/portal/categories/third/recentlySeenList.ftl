<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId /></#assign>
<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
	
	
	<li id="product_selloffer_li_0">
                  <div class="ui-image-viewer quick-image-viewer">
                    <div class="ui-image-viewer-thumb-wrap"> <a href="${productUrl}" class="ui-image-viewer-thumb-frame">
                        <img style="width: 65px; height: 65px;" src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>"> </a> </div>
                    <div style="width: 65px; height: 65px; display: none;" class="ui-image-viewer-loading">
                      <div class="ui-image-viewer-loading-mask"></div>
                      <div class="ui-image-viewer-loading-whirl"></div>
                    </div>
                  </div>
                </li>
	 <#--
	<li class="p4p-list-item">
                    <div class="img-box-wrap">
                      <div class="img-box"><a href="${productUrl}"><img src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>" class="auto-set-img0"></a></div>
                    </div>
                    <p class="p4p-product-title"><a href="${productUrl}">${product.productName?if_exists}</a></p>
                    <p class="p4p-price-list"><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/><span class="fwn"></span></p>
                   <p class="p4p-more-info"><a href="" class="p4pAliTalk atm16">现在聊天</a></p>
                  </li>
                  
                  -->
