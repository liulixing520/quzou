<div class="main-wrap">
    <div class="j-module" data-title="店铺信息">
        <!-- 店铺信息 -->
    ${screens.render("component://portal/widget/SellerHomeScreens.xml#shopinfo")}
        <!-- 店铺信息 end-->
    </div>
    <div class="j-module" data-title="店铺招牌">
        <div class="module m-sop m-sop-banner" style="height:150px">
            <a href="">
            <img src="<#if productStore??>${productStore.productStoreBanner!}</#if>" alt=""></a>
        </div>
    </div>
    <div class="j-module" data-title="页面导航">
        <!-- 页面导航信息 -->
    ${screens.render("component://portal/widget/SellerHomeScreens.xml#shopnav")}
        <!-- 页面导航信息 end-->
    </div>
</div>