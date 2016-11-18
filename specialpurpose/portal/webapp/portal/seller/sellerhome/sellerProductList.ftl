<#assign smallImageUrl = productCategory.categoryImageUrl?if_exists>
<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
<div> 
     <a href="<@ofbizCatalogAltUrl productCategoryId='${productCategory.productCategoryId?if_exists}' previousCategoryId='${productCategory.primaryParentCategoryId?if_exists}' />" class="industry-active-pic"> 
     	<img src="${smallImageUrl}" width="190" height="385" /> 
        <div class="txt-mask-layer">
         <span><font class="OUTFOX_JTR_TRANS_NODE">${productCategory.description?if_exists}</font></span><!-- categoryText-->
        </div> 
      </a> 
</div> 
<div>
       <ul class="g-items-list util-clearfix">
         	<#if productIds?has_content>
					<#list productIds as productId>
							${setRequestAttribute("optProductId", productId)}
							${screens.render(productsummaryScreen)}
					</#list>
           </#if> 
       </ul> 
      </div>