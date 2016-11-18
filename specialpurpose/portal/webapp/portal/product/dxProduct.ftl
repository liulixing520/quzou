<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId productCategoryId=categoryId/></#assign>
<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
<#if requestAttributes.dxStoreId??>
	<#assign dxProduct=delegator.findOne("DxProduct",{"dxStoreId",requestAttributes.dxStoreId,"supplierStoreId",requestAttributes.supplierStoreId,"productId",requestAttributes.productId},false)?if_exists>
	</#if>
<li class="c_item">
<a href="${productUrl}?dxStoreId=${dxProduct.dxStoreId!}">
  <div class="g-pic"> <img src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>" width="200" height="200"> </div>
  <span class="g-title"> ${product.internalName?if_exists}</span> 
</a>
	
	
	<#if dxProduct?has_content>
		<span class="basePrice"><b class="notranslate">￥${dxProduct.dxPrice!}</b> </span>
	</#if>
</li>
