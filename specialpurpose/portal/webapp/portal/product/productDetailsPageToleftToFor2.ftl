	<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId productCategoryId=categoryId/></#assign>
	<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>


       <div class="ui-product-listitem " data-product-id="1472716032">
            <div class="ui-product-listitem-thumb">
                <a href="${productUrl}" rel="nofollow" target="_blank">
                    <img alt="${product.internalName?if_exists}" src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>">
                </a>
            </div>
            <div class="ui-product-listitem-info">
                <a  href="${productUrl}"  >
                <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-767" rel="767">
              
          <#assign productName = Static["org.ofbiz.product.product.EbizProductContentWrapper"].getProductTitleByLocale(product, request)/>
														${productName!}
                                     
                </font></a>
                <div class="ui-product-listitem-row ui-cost"><b class="notranslate">
                <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-768" rel="768">
                <#if price?has_content>
                   <@ofbizCurrency amount=price.price isoCode=price.currencyUsed/>
                </#if>
                </font></b>
                <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-769" rel="769"></font></div>
                <#-- <div class="ui-product-listitem-row"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-770" rel="770">最近的订单(1534)</font></div> -->
            </div>
        </div> 
        
        
        
