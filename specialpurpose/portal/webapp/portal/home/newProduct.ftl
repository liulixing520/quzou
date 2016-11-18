<#-- 
<#assign smallImageUrl = productCategory.categoryImageUrl?if_exists>
<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
-->

<div class="recommend-goods">
       <ul class="g-items-list util-clearfix">
         	<#if productIds?has_content>
					<#list productIds as productId>
							${setRequestAttribute("optProductId", productId)}
							${screens.render(productsummaryScreen)}
					</#list>
           </#if> 
       </ul> 
      </div>