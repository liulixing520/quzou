<div class="col-sub">
<#--  左侧导航属性
      <div id="refine-category">
        <div id="refine-category-list">
          <dl class="category-list">
            <dt class="cate-title"> <font style="text-decoration: underline;"> 相关类别 </font> </dt>
            <dd class="list-box">
              <dl class="son-category">
                <dt class="sn-parent-title"> <a href=""> <span class="back-icon"> <font> &lt; </font> </span> <font> 任何类别 </font> </a> </dt>
                <dd class="list-box">
                  <dl class="son-category">
                  	<#assign parentProductCategory = prodCatWithLevel.getParentProductCategory()/>
                  	<#assign parentCatInfo = Static["org.ofbiz.product.category.EbizCategoryContentWrapper"].getProdCatNameByLocale(parentProductCategory, request)/>
                  	<#assign parentProdCatWithLevel = Static["org.ofbiz.ebiz.product.CategoryLevelWorker"].getProductCategoryWithLevel(request,parentProductCategory.productCategoryId)/>
                    <#assign topProductCategory = parentProdCatWithLevel.getParentProductCategory()/>
                    <dt class="sn-parent-title"> <a href="<@ofbizCatalogAltUrl productCategoryId=parentProductCategory.productCategoryId previousCategoryId='${(topProductCategory.productCategoryId)!}'/>"> <span class="back-icon"> <font> &lt; </font> </span> <font>${parentCatInfo!} </font> </a> </dt>
                    <dd>
                      <dl class="son-category">
                        <#assign catInfo = Static["org.ofbiz.product.category.EbizCategoryContentWrapper"].getProdCatNameByLocale(productCategory, request)/>
                        <dt class="sn-parent-title"> <span class="current-cate"> <font>${catInfo!} </font> </span> </dt>
                      </dl>
                    </dd>
                  </dl>
                </dd>
              </dl>
            </dd>
          </dl>
          
           <#if facetFields?has_content>
          	<#if facetFields.features?has_content>
          		<#list facetFields.features.keySet() as productFeatureTypeId>
          			${setRequestAttribute("optProductFeatureTypeId",productFeatureTypeId)}
          			${screens.render("component://portal/widget/CatalogScreens.xml#productFeatureTypeItem")}
          		</#list>
          	</#if>
          </#if>
          


          <dl class="attribute-item">
            <dt class="cate-title"> <font> 网络 </font> </dt>
            <dd class="list-box">
              <ul class="common-select">
                <li> <a href=""> <font> 无线网络 </font> </a> <span> <font> (3915) </font> </span> </li>
                <li> <a href=""> <font> 内置3 g </font> </a> <span> <font> (1951) </font> </span> </li>
                <li> <a href=""> <font> 4 g LTE </font> </a> <span> <font> (44) </font> </span> </li>
                <li> <a href=""> <font> 外部3 g </font> </a> <span> <font> (1838) </font> </span> </li>
                <li> <a href=""> <font> 蓝牙 </font> </a> <span> <font> (2859) </font> </span> </li>
              </ul>
            </dd>
          </dl>
          
          <dl class="attribute-item">
            <dt class="cate-title"> <font>屏幕尺寸</font> </dt>
            <dd class="list-box">
              <ul class="common-select two-rows">
                <li> <a href=""> <font> Ainol </font> </a> </li>
                <li> <a href=""> <font> Ampe </font> </a> </li>
                <li> <a href=""> <font> 神行者 </font> </a> </li>
                <li> <a href=""> <font> 雅 </font> </a> </li>
                <li> <a href=""> <font> 台电 </font> </a> </li>
                <li> <a href=""> <font> 其他 </font> </a> </li>
              </ul>
            </dd>
          </dl>
          <dl class="attribute-item">
            <dt class="cate-title"> <font> 屏幕类型  </font> </dt>
            <dd class="list-box">
              <ul class="common-select">
                <li> <a href=""> <font> 电容屏幕 </font> </a> <span> <font> (5065) </font> </span> </li>
                <li> <a href=""> <font> 电阻屏 </font> </a> <span> <font> (8) </font> </span> </li>
                <li> <a href=""> <font> 压电 </font> </a> <span> <font> (16) </font> </span> </li>
                <li> <a href=""> <font> 电磁屏蔽 </font> </a> <span> <font> (3) </font> </span> </li>
              </ul>
            </dd>
          </dl>

          <dl class="attribute-item">
            <dt class="cate-title"> <font> 颜色 </font> </dt>
            <dd class="list-box">
              <ul class="common-select">
                <li> <a href=""> <font> 红色的 </font> </a> <span> <font> (99) </font> </span> </li>
                <li> <a href=""> <font> 粉红色的 </font> </a> <span> <font> (53) </font> </span> </li>
                <li> <a href=""> <font> 蓝色的 </font> </a> <span> <font> (53) </font> </span> </li>
                <li> <a href=""> <font> 绿色 </font> </a> <span> <font> (5) </font> </span> </li>
                <li> <a href=""> <font> 黑色的 </font> </a> <span> <font> (2156) </font> </span> </li>
                <li> <a href=""> <font> 白色的 </font> </a> <span> <font> (2404) </font> </span> </li>
                <li> <a href=""> <font> 黄金 </font> </a> <span> <font> (121) </font> </span> </li>
              </ul>
              <ul class="common-select list-view-more">
                <li> <a href=""> <font> 银 </font> </a> <span> <font> (219) </font> </span> </li>
                <li> <a href=""> <font> 黄色的 </font> </a> <span> <font> (4) </font> </span> </li>
                <li> <a href=""> <font> 紫色的 </font> </a> <span> <font> (18) </font> </span> </li>
                <li> <a href=""> <font> 灰色的 </font> </a> <span> <font> (40) </font> </span> </li>
              </ul>
            </dd>
            <dd class="view-more-box"> <a href=""> 查看更多 </font> </a> </dd>
          </dl>

          <dl class="attribute-item">
            <dt class="cate-title"> <font> 操作系统 </font> </dt>
            <dd class="list-box">
              <ul class="common-select">
                <li> <a href=""> <font> Android 4.1 </font> </a> <span> <font> (1357) </font> </span> </li>
                <li> <a href=""> <font> Android 4.0 </font> </a> <span> <font> (676) </font> </span> </li>
                <li> <a href=""> <font> Android 4.2 </font> </a> <span> <font> (2202) </font> </span> </li>
                <li> <a href=""> <font> Android 2.1 </font> </a> <span> <font> (1) </font> </span> </li>
                <li> <a href=""> <font> Android 2.0 </font> </a> <span> <font> (487) </font> </span> </li>
                <li> <a href=""> <font> Android 2.2 </font> </a> <span> <font> (30) </font> </span> </li>
                <li> <a href=""> <font> Android 2.3 </font> </a> <span> <font> (4) </font> </span> </li>
              </ul>
              <ul class="common-select list-view-more">
                <li> <a href=""> <font> windows 8 </font> </a> <span> <font> (120) </font> </span> </li>
                <li> <a href=""> <font> 铬操作系统 </font> </a> <span> <font> (1) </font> </span> </li>
              </ul>
            </dd>
            <dd class="view-more-box"> <a href=""> 查看更多 </font> </a> </dd>
          </dl>


        </div>
      </div>
       -->
      <style type="text/css">.layout{ margin-bottom:10px;}</style>
      <#-- 左侧广告 
      <div id="refine-shopping-guide-banner"> <a href=""> <img src="../images/list-shopping-guide-banner.png"> </a> </div>
      <div id="refine-shopping-guide-banner"> <a href=""> <img src="../images/list-shopping-guide-banner.png"> </a> </div>
       -->
       
       <#-- 最近看过-->
      ${screens.render("component://portal/widget/thirdCategoriesScreens.xml#recentlySeen")}
     
       
       <#-- 
      <div id="historyOuterBox" class="box historyouterbox">
        <div class="hd">
          <h3> 最近查看 </h3>
        </div>
        <div class="bd historyBox">
          <div class="historylog">
            <div id="PSHistoryBox">
              <ul id="product_selloffer_hispanel" class="productimage">
                <li id="product_selloffer_li_0">
                  <div class="ui-image-viewer quick-image-viewer">
                    <div class="ui-image-viewer-thumb-wrap"> <a href="" class="ui-image-viewer-thumb-frame"> <img style="width: 49.3409090909091px; height: 65px;" src="../images/0005.jpg"> </a> </div>
                    <div style="width: 65px; height: 65px; display: none;" class="ui-image-viewer-loading">
                      <div class="ui-image-viewer-loading-mask"> </div>
                      <div class="ui-image-viewer-loading-whirl"> </div>
                    </div>
                  </div>
                </li>
                <li id="product_selloffer_li_1">
                  <div class="ui-image-viewer quick-image-viewer">
                    <div class="ui-image-viewer-thumb-wrap"> <a href="" class="ui-image-viewer-thumb-frame"> <img style="width: 65px; height: 65px;" src="../images/0006.jpg"> </a> </div>
                    <div style="width: 65px; height: 65px; display: none;" class="ui-image-viewer-loading">
                      <div class="ui-image-viewer-loading-mask"> </div>
                      <div class="ui-image-viewer-loading-whirl"> </div>
                    </div>
                  </div>
                </li>
                
                <li id="product_selloffer_li_2">
                  <div class="ui-image-viewer quick-image-viewer">
                    <div class="ui-image-viewer-thumb-wrap"> <a href="" class="ui-image-viewer-thumb-frame"> <img style="width: 49.3409090909091px; height: 65px;" src="../images/0005.jpg"> </a> </div>
                    <div style="width: 65px; height: 65px; display: none;" class="ui-image-viewer-loading">
                      <div class="ui-image-viewer-loading-mask"> </div>
                      <div class="ui-image-viewer-loading-whirl"> </div>
                    </div>
                  </div>
                </li>
                <li id="product_selloffer_li_3">
                  <div class="ui-image-viewer quick-image-viewer">
                    <div class="ui-image-viewer-thumb-wrap"> <a href="" class="ui-image-viewer-thumb-frame"> <img style="width: 65px; height: 65px;" src="../images/0006.jpg"> </a> </div>
                    <div style="width: 65px; height: 65px; display: none;" class="ui-image-viewer-loading">
                      <div class="ui-image-viewer-loading-mask"> </div>
                      <div class="ui-image-viewer-loading-whirl"> </div>
                    </div>
                  </div>
                </li>
                <li id="product_selloffer_li_4">
                  <div class="ui-image-viewer quick-image-viewer">
                    <div class="ui-image-viewer-thumb-wrap"> <a href="" class="ui-image-viewer-thumb-frame"> <img style="width: 49.3409090909091px; height: 65px;" src="../images/0005.jpg"> </a> </div>
                    <div style="width: 65px; height: 65px; display: none;" class="ui-image-viewer-loading">
                      <div class="ui-image-viewer-loading-mask"> </div>
                      <div class="ui-image-viewer-loading-whirl"> </div>
                    </div>
                  </div>
                </li>
              </ul>
              <div style="clear:both;"> </div>
            </div>
          </div>
        </div>
      </div>
      
    </div>
    -->