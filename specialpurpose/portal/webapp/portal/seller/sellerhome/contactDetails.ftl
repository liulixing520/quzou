<link rel="stylesheet" type="text/css" href="../seller/css/429JPOFV.css">
<link rel="stylesheet" type="text/css" href="../seller/css/css.css">
<link rel="stylesheet" type="text/css" href="../seller/css/node-contacts.css">

<div id="hd">
    <div class="layout grid-c">
        <div class="col-main">
        ${screens.render("component://portal/widget/SellerHomeScreens.xml#shopheader")}
        </div>
    </div>
</div>
<div id="bd">
    <div class="layout grid-c">
        <div class="col-main">
            <div class="main-wrap" data-title="面包屑">
                <#-- 面包屑 
        ${screens.render("component://portal/widget/SellerHomeScreens.xml#crumb")}-->
            <div class="j-module" data-title="面包屑">
    <div class="module m-sop m-sop-crumb">
	        <a href="<@ofbizUrl>main</@ofbizUrl>" rel="nofollow">${uiLabelMap.PortalHome}</a>
	        &gt;
	        <b>${uiLabelMap.sellerCommodity}</b>
	    </div>
                <!-- 面包屑 end-->
            </div>
        </div>
    </div>
    <div class="layout row-c2-s7">
        <div class="col-main">
        		${setRequestAttribute("productStoreId","${productStoreId}")}
                ${screens.render("component://portal/widget/SellerHomeScreens.xml#contactInformation")}
        </div>
        <div class="col-sub">
        ${screens.render("component://portal/widget/SellerHomeScreens.xml#shopsub")}
        </div>
    </div>
</div>
