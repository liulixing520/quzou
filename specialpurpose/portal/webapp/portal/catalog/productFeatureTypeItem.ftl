
<dl class="attribute-item">
            <dt class="cate-title"> <font>${(productFeatureType.description)!} </font> </dt>
            <dd class="list-box">
              <ul class="common-select">
              <#if productFeatures?has_content>
              <#list productFeatures as productFeature>
                <#assign eavAttrnameUrl=Static["org.ofbiz.ebiz.product.ProductCategoryCondFilter"].getFullRequestUrl(request,productCategory.productCategoryId,"productFeatureId_${productFeatureTypeId!}")/>
                <li> <a href="${eavAttrnameUrl!}&productFeatureId_${productFeatureTypeId!}=${productFeature.productFeatureId}"> <font>${productFeature.description} </font> </a> <span> <font>  </font> </span> </li>
              </#list>
              </#if>
              <#--
                <li> <a href=""> <font> 英语 </font> </a> <span> <font> (3747) </font> </span> </li>
                <li> <a href=""> <font> 中国 </font> </a> <span> <font> (3479) </font> </span> </li>
                <li> <a href=""> <font> 波兰 </font> </a> <span> <font> (3195) </font> </span> </li>
                <li> <a href=""> <font> 德国 </font> </a> <span> <font> (3386) </font> </span> </li>
                <li> <a href=""> <font> 法国 </font> </a> <span> <font> (3469) </font> </span> </li>
                <li> <a href=""> <font> 葡萄牙语 </font> </a> <span> <font> (3448) </font> </span> </li>
              </ul>
              <ul class="common-select list-view-more">
                <li> <a href=""> <font> 日本 </font> </a> <span> <font> (3320) </font> </span> </li>
                <li> <a href=""> <font> 瑞典 </font> </a> <span> <font> (3190) </font> </span> </li>
                <li> <a href=""> <font> 土耳其 </font> </a> <span> <font> (3260) </font> </span> </li>
                <li> <a href=""> <font> 乌克兰 </font> </a> <span> <font> (3007) </font> </span> </li>
                <li> <a href=""> <font> 希伯来语 </font> </a> <span> <font> (2883) </font> </span> </li>
                <li> <a href=""> <font> 希腊 </font> </a> <span> <font> (3107) </font> </span> </li>
                <li> <a href=""> <font> 西班牙语 </font> </a> <span> <font> (3513) </font> </span> </li>
                <li> <a href=""> <font> 意大利 </font> </a> <span> <font> (3439) </font> </span> </li>
              </ul>
              -->
            </dd>
            <#-- <dd class="view-more-box"> <a href=""> 查看更多 </font> </a> </dd> -->
          </dl>