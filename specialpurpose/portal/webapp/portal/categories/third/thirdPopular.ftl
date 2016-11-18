${setRequestAttribute("optViewSize","4")}
<#assign likeProductIds =Static["org.ofbiz.product.store.RecommenderUtil"].youMayLike(request)/>


<div class="p4pExpress" id="p4pHotProducts-old">
            <h4>${uiLabelMap.PortalPopular}</h4>
            <div class="relatied-product-slide" id="relatied-product-slide">
              <div class="relatied-products-container">
                <ul class="p4p-bottom-content" id="p4p-ul-content">
                
                
                <#if likeProductIds?has_content>
                		<#list likeProductIds as productId>
                		
                	 ${setRequestAttribute("optProductId",  productId)}
				    	${screens.render("component://portal/widget/thirdCategoriesScreens.xml#thirdPopularList")}
				         ${setRequestAttribute("optProductId",  "")}
                		</#list>
                	</#if>
                
                
                 <#-- <li class="p4p-list-item">
                    <div class="img-box-wrap">
                      <div class="img-box"><a href=""><img src="<@ofbizUrl>../images/0001.jpg</@ofbizUrl>" class="auto-set-img0"></a></div>
                    </div>
                    <p class="p4p-product-title"><a href="">兼容的佳能GPR-11 IRC3200 IRC 3200红外C… ...</a></p>
                    <p class="p4p-price-list">￥61.99<span class="fwn"> / 件</span></p>
                    <p class="p4p-more-info"><a href="" class="p4pAliTalk atm16">现在聊天</a></p>
                  </li>
                  <li data-ctr="1" class="p4p-list-item">
                    <div class="img-box-wrap">
                      <div class="img-box"><a href=""><img src="<@ofbizUrl>../images/0002.jpg</@ofbizUrl>" class="auto-set-img1"></a></div>
                    </div>
                    <p class="p4p-product-title"><a href="">兼容的佳能GPR-11 IRC3200 IRC 3200红外C… </a></p>
                    <p class="p4p-price-list">￥139.99 - 194.89<span class="fwn"> / 件</span></p>
                    <p class="p4p-more-info"><a href="javascript:void(0);" class="p4pAliTalk atm16grey">离线</a></p>
                  </li>
                  <li class="p4p-list-item">
                    <div class="img-box-wrap">
                      <div class="img-box"><a href=""><img src="<@ofbizUrl>../images/0003.jpg</@ofbizUrl>" class="auto-set-img2"></a></div>
                      <div class="discount-rate"><span class="rate">10</span></div>
                    </div>
                    <p class="p4p-product-title"><a href="">兼容的佳能GPR-11 IRC3200 IRC 3200红外C… </a></p>
                    <p class="p4p-price-list">￥9.89<span class="fwn"> / 件</span></p>
                    <del class="original-price">￥10.99  / 件 </del>
                    <p class="p4p-more-info"><a href="javascript:void(0);" class="p4pAliTalk atm16">现在聊天</a></p>
                  </li>
                  <li class="p4p-list-item">
                    <div class="img-box-wrap">
                      <div class="img-box"><a href=""><img src="<@ofbizUrl>../images/0004.jpg</@ofbizUrl>" class="auto-set-img3"></a></div>
                      <div class="discount-rate"><span class="rate">10</span></div>
                    </div>
                    <p class="p4p-product-title"><a href="">兼容的佳能GPR-11 IRC3200 IRC 3200红外C… </a></p>
                    <p class="p4p-price-list">￥21.58<span class="fwn"> / 件</span></p>
                    <del class="original-price">￥23.98  / 件 </del>
                    <p class="p4p-more-info"><a href="" class="p4pAliTalk atm16">现在聊天</a></p>
                  </li>
                  -->
                  
                </ul>
              </div>
              <a id="lnk-prev" class="lnk-prev lnk-prev-disabled"></a><a id="lnk-next" class="lnk-next"></a></div>
            <div class="p4pClearfix"></div>
          </div>