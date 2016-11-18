${setRequestAttribute("optViewSize","10")}
<#assign likeProductIds =Static["org.ofbiz.product.store.RecommenderUtil"].youMayLike(request)/>


<div id="historyOuterBox" class="box historyouterbox">
        <div class="hd">
          <h3> ${uiLabelMap.RecentlySeen} </h3>
        </div>
        <div class="bd historyBox">
          <div class="historylog">
            <div id="PSHistoryBox">
              <ul id="product_selloffer_hispanel" class="productimage">
              <#if likeProductIds?has_content>
                		<#list likeProductIds as productId> 
                		  ${setRequestAttribute("optProductId",  productId)}
                		  ${screens.render("component://portal/widget/thirdCategoriesScreens.xml#recentlySeenList")}
                		   ${setRequestAttribute("optProductId",  "")}
        		</#list>
        	</#if>
              
              <#--
                <li id="product_selloffer_li_0">
                  <div class="ui-image-viewer quick-image-viewer">
                    <div class="ui-image-viewer-thumb-wrap"> <a href="" class="ui-image-viewer-thumb-frame"> <img style="width: 49.3409090909091px; height: 65px;" src="<@ofbizUrl>../images/0005.jpg</@ofbizUrl>"> </a> </div>
                    <div style="width: 65px; height: 65px; display: none;" class="ui-image-viewer-loading">
                      <div class="ui-image-viewer-loading-mask"> </div>
                      <div class="ui-image-viewer-loading-whirl"> </div>
                    </div>
                  </div>
                </li>
                <li id="product_selloffer_li_1">
                  <div class="ui-image-viewer quick-image-viewer">
                    <div class="ui-image-viewer-thumb-wrap"> <a href="" class="ui-image-viewer-thumb-frame"> <img style="width: 65px; height: 65px;" src="<@ofbizUrl>../images/0006.jpg</@ofbizUrl>"> </a> </div>
                    <div style="width: 65px; height: 65px; display: none;" class="ui-image-viewer-loading">
                      <div class="ui-image-viewer-loading-mask"> </div>
                      <div class="ui-image-viewer-loading-whirl"> </div>
                    </div>
                  </div>
                </li>
                
                <li id="product_selloffer_li_2">
                  <div class="ui-image-viewer quick-image-viewer">
                    <div class="ui-image-viewer-thumb-wrap"> <a href="" class="ui-image-viewer-thumb-frame"> <img style="width: 49.3409090909091px; height: 65px;" src="<@ofbizUrl>../images/0005.jpg</@ofbizUrl>"> </a> </div>
                    <div style="width: 65px; height: 65px; display: none;" class="ui-image-viewer-loading">
                      <div class="ui-image-viewer-loading-mask"> </div>
                      <div class="ui-image-viewer-loading-whirl"> </div>
                    </div>
                  </div>
                </li>
                <li id="product_selloffer_li_3">
                  <div class="ui-image-viewer quick-image-viewer">
                    <div class="ui-image-viewer-thumb-wrap"> <a href="" class="ui-image-viewer-thumb-frame"> <img style="width: 65px; height: 65px;" src="<@ofbizUrl>../images/0006.jpg</@ofbizUrl>"> </a> </div>
                    <div style="width: 65px; height: 65px; display: none;" class="ui-image-viewer-loading">
                      <div class="ui-image-viewer-loading-mask"> </div>
                      <div class="ui-image-viewer-loading-whirl"> </div>
                    </div>
                  </div>
                </li>
                <li id="product_selloffer_li_4">
                  <div class="ui-image-viewer quick-image-viewer">
                    <div class="ui-image-viewer-thumb-wrap"> <a href="" class="ui-image-viewer-thumb-frame"> <img style="width: 49.3409090909091px; height: 65px;" src="<@ofbizUrl>../images/0005.jpg</@ofbizUrl>"> </a> </div>
                    <div style="width: 65px; height: 65px; display: none;" class="ui-image-viewer-loading">
                      <div class="ui-image-viewer-loading-mask"> </div>
                      <div class="ui-image-viewer-loading-whirl"> </div>
                    </div>
                  </div>
                </li>
                
                -->
              </ul>
              <div style="clear:both;"> </div>
            </div>
          </div>
           
        </div>
         
      </div>
    </div>