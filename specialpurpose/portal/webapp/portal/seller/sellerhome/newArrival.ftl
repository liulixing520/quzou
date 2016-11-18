<div class="module m-sop m-sop-top-selling">
    <div class="ui-box ui-box-wrap">
        <div class="ui-box-title">
            <h3>${uiLabelMap.sellernewarrival}</h3>
        </div>
        <div class="ui-box-body">
            <ul class="items-list">
                
                <#if productIds?has_content>
            		<#list productIds as productId >
            		    <#if productId_index&lt;9> 
            			${setRequestAttribute("optProductId", productId)}
						${screens.render("component://portal/widget/SellerHomeScreens.xml#newArrivalProductSummary")}
						</#if>
            		</#list>
            	</#if>
            </ul>
        </div>
    </div>
</div>