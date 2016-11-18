<div class="mod superdeals">
    <div class="mod-hd">
        <h3>${uiLabelMap.PortalSuperDeals}</h3>
    </div>
    
    <div class="mod-box">
        <ul class="g-items-list">
        	<#if weeklyCategoryMembers?has_content>
				<#assign appCount = 0>
				<#list weeklyCategoryMembers as productCategoryMember>
					<#if appCount lte 3 >
					<li class="item-cell">
					  ${setRequestAttribute("optProductId", productCategoryMember.productId)}
					  ${screens.render("component://portal/widget/CatalogScreens.xml#productsummaryForSuper")}
					</li>
					<#assign appCount = appCount + 1>
					</#if>
				</#list>
            </#if>
        </ul>
        
<#--        <div class="view-detail-btn learnmore">
            <a href="<@ofbizUrl>commoditySpecialOffer</@ofbizUrl>">${uiLabelMap.PortalLookMore}>></a>
        </div>-->
    </div>
</div>