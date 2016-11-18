
<#-- variable setup -->
    <#if backendPath?default("N") == "Y">
        <#assign productUrl><@ofbizCatalogUrl productId=product.productId productCategoryId=categoryId/></#assign>
    <#else>
        <#assign productUrl><@ofbizCatalogAltUrl productId=product.productId productCategoryId=categoryId/></#assign>
    </#if>

    <#if requestAttributes.productCategoryMember?exists>
        <#assign prodCatMem = requestAttributes.productCategoryMember>
    </#if>
    <#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
<#assign productNameText><@htmlTemplate.productName product=product request=request/></#assign>
<div index="0" class="listitem">
            <div class="photo"> <a class="pic" href="<@ofbizUrl>../products/p_${product.productId?if_exists}</@ofbizUrl>"><img class="lthumbnail" src="${smallImageUrl!}" style="width: 160px; height: 115.2px;"> <span style="visibility: hidden;" class="enlarge"></span></a> </div>
            <h3 class="pro-title"> <a class="subject" href="<@ofbizUrl>../products/p_${product.productId?if_exists}</@ofbizUrl>"><font style="text-decoration: none;">${productNameText!} </font></a> </h3>
            <div class="list-pro">
              <div class="firstattr">
                <ul class="pricewrap">
                  <li class="price"><span><font><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/></font></span><font> </font></li>
                  <#--<li>${product.description?if_exists}</li>-->
                </ul>
                
                
                 <ul class="attribute">
                  <li class="freeico"><span class="free"><font>${uiLabelMap.FreeShippingCf}</font></span> </li>
                 <#-- <li> <span class="shipout"><font>2天内发货</font></span> </li>
                   <div class="rate-history">
                    <span class="star star-s">
                    <span style="width: 94.8%;" class="rate-percent"><font>额定</font><span><font>4.7</font></span><font>/ 5的基础上</font><span><font>31日</font></span><font>顾客评论</font></span>
                	</span>
                    <a href="" class="rate-num"><font style="text-decoration: none;">反馈(31)</font></a>
                    <span class="rate-separator"><font>|</font></span>
                    <span class="order-num">
                    <a href="" class="order-num-a"><em><font style="text-decoration: none;">订单(115)</font></em></a></span>
                  </div> 
                  <li class="sellerservice"> <span class="icon-pledge"></span> </li> -->
                </ul>
                
              </div>
              
              
            
            
              <form method="post" action="<@ofbizUrl>additem</@ofbizUrl>" name="the${requestAttributes.formNamePrefix?if_exists}${requestAttributes.listIndex?if_exists}${product.productId}form" style="margin: 0;">
              <input type="hidden" name="add_product_id" value="${product.productId}"/>
              
              <input type="hidden" name="clearSearch" value="N"/>
              <input type="hidden" name="mainSubmitted" value="Y"/>
              <div class="secattr">
                <#if mainProducts?has_content>
                <input type="hidden" name="product_id" value=""/>
                <select name="productVariantId" onchange="javascript:displayProductVirtualId(this.value, '${product.productId}', this.form);">
                    <option value="">Select Unit Of Measure</option>
                    <#list mainProducts as mainProduct>
                        <option value="${mainProduct.productId}">${mainProduct.uomDesc} : ${mainProduct.piecesIncluded}</option>
                    </#list>
                </select>
                <div style="display: inline-block;">
                    <strong><span id="product_id_display"> </span></strong>
                    <strong><span id="variant_price_display"> </span></strong>
                </div>
            </#if>
                <ul>
                 
                  <li class="pro-seller"><a href="" class="score-dot"></a>
                  <span class="seller"><font>${uiLabelMap.SellerCf}: </font>
                <#-- http://localhost:8080/portal/control/sellerhome?productStoreId=10001 -->
				 <script type="text/javascript">
					 function oncheckP(){
		                  var  PcompanyIdVal =$("#PcompanyId").val();
		                  window.location.href="<@ofbizUrl>../control/sellerhome?productStoreId=</@ofbizUrl>"+PcompanyIdVal;
	                 }
                </script>
                  
                  
                  
                  <a onclick="oncheckP();"><font>
                          <#if product.primaryProductStoreId??>
								  <#assign productStoreList = delegator.findByAnd("ProductStore", {"productStoreId":product.primaryProductStoreId}, null, false)>							
								     <#if productStoreList??>
								      <#list productStoreList as ps> 
								             ${ps.storeName!}
								             <input value="${(ps.productStoreId)!}"  id="PcompanyId" name="PcompanyId" style="display: none;">								             
								      </#list>  
	                              </#if>
                         </#if>
                  
                   </font></a> </span></li>
                  <li class="feedback"><span class="chat"><font></font></span> </li>
                  
                  <li class="cart"> <span class="n-yellow-button"><input type="hidden" size="5" name="quantity" value="1"/>
                  <font><a href="javascript:document.the${requestAttributes.formNamePrefix?if_exists}${requestAttributes.listIndex?if_exists}${product.productId}form.submit()" class="buttontext">${uiLabelMap.PortalAddtoCartCf}</a> </font></span> </li>
                
                </ul>
              </div>
              </form>
            </div>
          </div>

<#macro productName product>
    <#assign productName = Static["org.ofbiz.product.product.EbizProductContentWrapper"].getProductTitleByLocale(product,request)!!/>
    ${productName!}
</#macro>