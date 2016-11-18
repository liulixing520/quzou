 <link rel="stylesheet" type="text/css" href="/portal/images/css/cate-toplink.css">
<#--<link rel="stylesheet" type="text/css" href="../css/specialOffer.css">-->
<div class="main-wrap">
    <div class="j-module" data-title="促销信息">
        <div class="module m-sop m-sop-discount" style="display:none"></div>
    </div>
    <div class="j-module" data-title="图片轮播">
        <div class="module m-sop m-sop-slide ui-switchable">
        <!-- 图片轮播 begin -->
        ${screens.render("component://portal/widget/SellerHomeScreens.xml#switchable")}
        <!-- 图片轮播 end -->
        </div>
    </div>
    <div class="j-module" data-title="商品推荐">
    <!-- 商品推荐 begin -->
    ${screens.render("component://portal/widget/SellerHomeScreens.xml#recommend")}
    <!-- 商品推荐 end -->
    </div>
    <#--
    <div class="j-module" data-title="商品推荐">
    ${screens.render("component://portal/widget/SellerHomeScreens.xml#hotAndNew1")}
    </div>
    <div class="j-module" data-title="商品推荐">
    ${screens.render("component://portal/widget/SellerHomeScreens.xml#hotAndNew")}
    </div>
    -->
   <#-- <div class="sd-products-wrap">
			<ul class="sd-products-wrap-inner">
			<#if weeklyCategoryMembers?has_content>
        	<#assign appCount = 0>
			<#list weeklyCategoryMembers as productCategoryMember>
				<#if appCount lte 3 >
				<li class="sd-product-outer">
				  ${setRequestAttribute("optProductId", productCategoryMember.productId)}
				  ${screens.render("component://portal/widget/CatalogScreens.xml#productsummaryForSuper")}
				</li>
				</#if>
			</#list>
			<#else>
			</#if>
			
			 <#if productIds?has_content>
            		<#list productIds as productId>
            		<li class="sd-product-outer">
            			${setRequestAttribute("optProductId", productId)}
						${screens.render("component://portal/widget/CatalogScreens.xml#productsummaryForSuper")}
					</li>
            		</#list>
           </#if>
			
	</ul>
</div>-->
    
    
<div class="omod-category-page-img-nav1">
         <!--得到分类下的商品ID号,进一步for循环遍历  -->   
            <ul class="c_items">
			<#if productIds?has_content>            
						<#list productIds as productId>
								${setRequestAttribute("optProductId", productId)}
							<#--${screens.render("component://portal/widget/SecondCategoriesScreensToFor.xml#productsummary")}-->
								${screens.render("component://portal/widget/CatalogScreens.xml#sellerproductExhibition")}
								${setRequestAttribute("optProductId", "")}
						</#list>
			</#if> 
    </ul>
</div> 
<form  action="<@ofbizUrl>sellerhome</@ofbizUrl>" id="FindProductEn" method="GET">
	<input type="hidden" name="productStoreId" value="${fyproductStoreId}"/>
<form>
<#include "component://portal/webapp/portal/includes/sellerpagination.ftl"/>      
<@paginationSimple  listSize viewSize viewIndex  'FindProductEn' 'FindProductEn' parameters.sortField!/>	    

</div>