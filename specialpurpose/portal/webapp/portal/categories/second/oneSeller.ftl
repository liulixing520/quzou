<div class="store-img">
            <#assign productCategory1 = productCategory?if_exists />
            <#assign productCategoryId1 = productCategoryId?if_exists />
            <#assign smallImageUrl = "/images/defaultImage.jpg">
			<a href="<@ofbizUrl>sellerhome?productStoreId=${productCategoryId1}</@ofbizUrl>"><img alt="" src="<@ofbizContentUrl>${productCategory1.productStoreLogo!smallImageUrl}</@ofbizContentUrl>"></a>
</div>