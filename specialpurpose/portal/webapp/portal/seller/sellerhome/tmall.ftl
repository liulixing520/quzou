<link rel="stylesheet" type="text/css" href="../seller/css/429JPOFV.css">
<link rel="stylesheet" type="text/css" href="../seller/css/css.css">
<link rel="stylesheet" type="text/css" href="../seller/css/node-contacts.css">
<link href="/portal/images/css/common-nohead.css" rel="stylesheet" type="text/css" media="all" />
<div id="hd">
    <div class="layout grid-c">
        <div class="col-main">
        ${screens.render("component://portal/widget/SellerHomeScreens.xml#shopheader")}
        </div>
    </div>
</div>
<div id="bd">
    <div class="">
        <div class="col-main">
            <div class="main-wrap" data-title="面包屑">
                <!-- 面包屑 -->
            <#--${screens.render("component://portal/widget/SellerHomeScreens.xml#crumb")}-->
            <div class="j-module" data-title="面包屑">
    <div class="module m-sop m-sop-crumb">
	        <a href="<@ofbizUrl>main</@ofbizUrl>" rel="nofollow">${uiLabelMap.PortalHome}</a>
	        &gt;
	        <b>${uiLabelMap.sellerStorehomepagel}</b>
	    </div>
	</div>
	              <!-- 面包屑 end-->
            </div>
        </div>
    </div>
    <div class="layout row-c2-s7">
        <div class="col-main">
        	<div class="main-wrap">
      <#--  去掉分类查询，暂时把所有的列出来-->	
<link rel="stylesheet" type="text/css" href="/portal/images/css/cate-toplink.css">
<style type="text/css">
.omod-category-page-img-nav1 .c_item{width:202px; margin-top:20px;}
.omod-category-page-img-nav1 .c_item a .g-pic img{border:1px solid #ccc;}
.omod-category-page-img-nav1 .c_item a:hover .g-pic img{border:1px solid rgb(255, 124, 0);}
.omod-category-page-img-nav1 .c_item .g-title{display:block; padding-top:10px; font-size:14px; color:#000;}
.omod-category-page-img-nav1 .c_item .g-price{padding-top:10px; display:block; color:rgb(255, 124, 0); font-size:18px; font-weight:bold;}
.omod-category-page-img-nav1 .c_item .basePrice{color:#898989;}
</style>
<#if !fyproductStoreId?has_content>
<script>
	alert("您还没有店铺，请先开店");
	location="/portal/control/main;jsessionid=0DA89144FD738BE853F9F3610CB72B74.jvm1";
</script>
</#if>
<#--
<div class="j-module" data-title="图片轮播">
        <div class="module m-sop m-sop-slide ui-switchable">
        ${screens.render("component://portal/widget/SellerHomeScreens.xml#switchable")}
        </div>
</div>
-->
<div class="omod-category-page-img-nav1">
         <!--得到分类下的商品ID号,进一步for循环遍历  -->   
            <ul class="c_items" style="width:950px;">
            <#if dxProductList?has_content>            
						<#list dxProductList as product>
								${setRequestAttribute("dxStoreId", product.dxStoreId!)}
								${setRequestAttribute("supplierStoreId", product.supplierStoreId!)}
								${setRequestAttribute("productId", product.productId)}
								${screens.render("component://portal/widget/CatalogScreens.xml#dxProduct")}
						</#list>
			</#if> 
			<#if productIds?has_content>            
						<#list productIds as productId>
								${setRequestAttribute("dxStoreId", parameters.dxStoreId!)}
								${setRequestAttribute("optProductId", productId)}
								${screens.render("component://portal/widget/CatalogScreens.xml#sellerproductExhibition")}
								${setRequestAttribute("optProductId", "")}
						</#list>
			</#if> 
    </ul>
</div> 
<#if fyproductStoreId?has_content>
<form  action="<@ofbizUrl>tmall</@ofbizUrl>" id="FindProductEn" method="GET">
	<input type="hidden" name="productStoreId" value="${fyproductStoreId}"/>
<form>
<#include "component://portal/webapp/portal/includes/sellerpagination.ftl"/>      
<@paginationSimple  listSize viewSize viewIndex  'FindProductEn' 'FindProductEn' parameters.sortField!/>
</#if>
 <#--
<#if productCategoryId?exists>
${setRequestAttribute("productCategoryId","${productCategoryId}")}
${screens.render("component://portal/widget/SellerHomeScreens.xml#sellerProductList")}
<#else>
<#if (requestAttributes.curCategoryId)?exists><#assign curCategoryId = requestAttributes.curCategoryId></#if>

                <#if topStoreCategoryList?has_content>
                    
                    <#list topStoreCategoryList as category>
                        <@categoryList parentCategoryId="" category=category wrapInBox="N"/>
                    </#list>
                </#if>

                <#macro categoryList parentCategoryId category wrapInBox>
                        <#assign gvCategory =category.getRelatedOne("CurrentProductCategory", true)>
                            <#local secondCatList = Static["org.ofbiz.product.category.CategoryExtWorker"].getRelatedCategoriesRet(request, "secondCatList",productStoreId, category.getString("productCategoryId"), true)>
                            <#if secondCatList?has_content>
                                <#list secondCatList as secondCat>
                                	<#assign findPftMap = Static["org.ofbiz.base.util.UtilMisc"].toMap("productCategoryId", secondCat.productCategoryId)>
                                	<#assign gvSecondCat =delegator.findOne("ProductCategory", findPftMap, true)>
                                       <#-- <a href="<@ofbizUrl>StoreCategory?productStoreId=${productStoreId!}&productCategoryId=&parentCategoryId=${category.productCategoryId!}/></@ofbizUrl>">${(gvSecondCat.categoryName)!}</a> 后面有--
       						               <div class="omod-title-bar-b-3px clearfix" style="width:982px;">
                                  	      <h2 class="c_title_bar">
                                  	  		  ${(gvSecondCat.categoryName)!}
                                  	  	  </h2>
                                  	    </div>
                                      ${setRequestAttribute("productCategoryId","${secondCat.productCategoryId}")}
            						  ${screens.render("component://portal/widget/SellerHomeScreens.xml#sellerProductList")}
                                </#list>
                            </#if>
                </#macro>
</#if>-->

          </div>
        </div>
        <div class="col-sub">
        ${screens.render("component://portal/widget/SellerHomeScreens.xml#shopsub")}
        </div>
    </div>
</div>
