<div class="module m-o m-o-large-all-detail">
    <div class="ui-box ui-box-wrap">
        <div class="ui-box-title">
            <h2>${(optCurrentCategory.categoryName)!}</h2>
        </div>
        <div class="ui-box-body">
            <ul class="items-list  util-clearfix">
            	<#if productIds?has_content>
            		<#list productIds as productId>
            			${setRequestAttribute("optProductId", productId)}
						${screens.render("component://portal/widget/SellerHomeScreens.xml#sellerProductSummary")}
            		</#list>
            	</#if>
            </ul>
        </div>
    </div>
</div>