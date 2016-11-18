<h3 class="top-seller-bar">
    <font title="${uiLabelMap.PortalRecommendSeller?if_exists}">
    <#if uiLabelMap.PortalRecommendSeller?length gt 83>${(uiLabelMap.PortalRecommendSeller[0..83])?if_exists}..<#else>${uiLabelMap.PortalRecommendSeller?if_exists}</#if>
    </font>
</h3>
<#assign productStoreIndex = 1>
<div class="box-bd">
    <ul>
      <#if stores?has_content>
      	<#list stores as store>
      	<#if productStoreIndex <= 5>
        <li>
          <div class="store-info">
                <h4 class="store-name">
                    <a href="<@ofbizUrl>sellerhome?productStoreId=${store.productStoreId}</@ofbizUrl>"><font>${store.storeName}</font></a>
                </h4>
            </div>
            		${setRequestAttribute("optProductStoreId", store.productStoreId)}
					${screens.render("component://portal/widget/SecondCategoriesScreensToFor.xml#onesellertoFor")}
					${setRequestAttribute("optProductStoreId", "")}
        </li>
        </#if>
        <#assign productStoreIndex = productStoreIndex + 1>
        </#list>
      </#if>
    </ul>
</div>


