<link rel="stylesheet" type="text/css" href="../seller/css/429JPOFV.css">
<link rel="stylesheet" type="text/css" href="../seller/css/css.css">

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
            <!-- 面包屑 -->
            ${screens.render("component://portal/widget/SellerHomeScreens.xml#crumb")}
            <!-- 面包屑 end-->
            </div>
        </div>
    </div>
    <div class="layout row-c2-s7">
        <div class="col-main">
                ${screens.render("component://portal/widget/SellerHomeScreens.xml#shopmain")}
        </div>
        <div class="col-sub">
                ${screens.render("component://portal/widget/SellerHomeScreens.xml#shopsub")}
        </div>
    </div>
</div>
