<link href="/portal/images/css/header.css" rel="stylesheet" type="text/css" media="all" />
<link href="/portal/images/css/footer.css" rel="stylesheet" type="text/css" media="all" />
<link href="/portal/images/css/header-all.css" rel="stylesheet" type="text/css" media="all" />
<link href="/portal/images/css/common-nohead.css" rel="stylesheet" type="text/css" media="all" />
<link href="/portal/images/css/cate-toplink.css" rel="stylesheet" type="text/css" media="all" />
<link href="/portal/images/css/go-top-ws.css"  rel="stylesheet" />


<style type="text/css">
    .omod-cate-nav-all-categories .row-4 .categorieslist {
        width: 190px;
    }
    .mm-ae-recommended-tips{width:982px;}
</style>

<div class="crumb">
    <a href="<@ofbizUrl>main</@ofbizUrl>">${uiLabelMap.PortalHome}</a>
    <#if parentCategory?exists>
        <font>&gt;</font>
        	<#assign parentProductCategory = prodCatWithLevel.getParentProductCategory()/>
                  	<#assign parentCatInfo = Static["org.ofbiz.product.category.EbizCategoryContentWrapper"].getProdCatNameByLocale(parentProductCategory, request)/>
                  
        <#--<a href="<@ofbizCatalogAltUrl productCategoryId=parentCategory.productCategoryId previousCategoryId=parentCategory.parentCategoryId/>">-->
            <font>${parentCatInfo!}</font>
        <#--</a>-->
    </#if>
    <font>&gt;</font>
    <#assign catInfo = Static["org.ofbiz.product.category.EbizCategoryContentWrapper"].getProdCatNameByLocale(productCategory, request)/>
    <h2><font>${catInfo!}</font></h2>
</div>

<div class="page" style="padding:0px;">
    <div class="grid-c2-s5">
        <div class="col-main">
            <div data-layout-type="CM2" class="main-wrap vi-virtual-module">
                
                <!-- 页面轮换图+轮滑图下的单品展示 -->
                <div class="omod-category-page-cate-banner2">
                
                ${screens.render("component://portal/widget/SecondCategoriesScreens.xml#banner2")}
                </div>
                
                <!-- 页面下的品牌图标 -->
                <!--<div class="omod-category-page-cate-brand">-->
                <#--${screens.render("component://portal/widget/SecondCategoriesScreens.xml#brand")}  -->
                <!--</div>-->
                
                <#-- ${screens.render("component://portal/widget/CatalogScreens.xml#categoryDetail")} -->
                
                <!-- 新品上架  -->
                <div class="mm-ae-recommended-tips">
                <div id="gallery-item" class="gallery-mode">
                <#assign localReqUtil=Static["org.ofbiz.ebiz.util.EbizRequestUtil"].getEbizRequestUtil(request)/>
                <#assign objAttr=localReqUtil.setReqAttrValue(request,"orderByName","lastModifiedDate")!/>
                ${screens.render("component://portal/widget/SecondCategoriesScreens.xml#recommended")}
                <#assign objResAttr=localReqUtil.restoreReqAttrValue(request)?if_exists/>
                <#assign localReqUtil=""/>
                </div>
                </div>
                
                <!-- 左侧导航目录下一级分类  展示   -->
                <div class="mm-ae-recommended-tips">
                ${screens.render("component://portal/widget/SecondCategoriesScreens.xml#gallery")}
                </div>
                                
                <!-- 分类热门商品 -->
                <#-- ${screens.render("component://portal/widget/SecondCategoriesScreens.xml#hotCategories")} -->
                <!-- 分类热门商品 end-->
                
                <!-- 所有分类 -->
                <!--<div id="J-omod-43">
                    <div class="omod-cate-nav-all-categories">-->
                   <#-- ${screens.render("component://portal/widget/SecondCategoriesScreens.xml#allCategories")}--> 
                <!--    </div>
                </div>-->
                
            </div>
        </div>
        <div class="col-sub">
            <div data-layout-type="SUB" class="w230 vi-virtual-module">
                
                <!-- 左侧目录列表 -->
                <div class="omod-cate-nav-tree-cate-nav premier-categories">
                ${screens.render("component://portal/widget/SecondCategoriesScreens.xml#categories")}
                </div>
                
                <!-- 畅销商品 -->
                <div class="omod-category-page-best-selling">
                 ${setRequestAttribute("orderByName",  "totalQuantityOrdered")}
                 ${screens.render("component://portal/widget/SecondCategoriesScreens.xml#bestSelling")}
                 ${setRequestAttribute("orderByName",  "")}
                </div>
                
                <!-- 推荐卖家  -->
                <div class="omod-category-page-top-seller">
                ${screens.render("component://portal/widget/SecondCategoriesScreens.xml#topSeller")}
                </div>
                
                <!-- 热门搜索 -->
                <#-- <div class="box omod-nav-bar-pop-search">
                 ${screens.render("component://portal/widget/SecondCategoriesScreens.xml#hotSearch")}
                </div>-->
            </div>
        </div>
    </div>
</div>

<!-- 特色促销活动 -->
${screens.render("component://portal/widget/SecondCategoriesScreens.xml#promotion")}
<!-- 特色促销活动 end -->

