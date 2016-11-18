<#if sellerCategories?has_content>
<#list sellerCategories as sellerCategory>
	${setRequestAttribute("optProductCategoryId", sellerCategory.productCategoryId)}
	${screens.render("component://portal/widget/SellerHomeScreens.xml#sellerCategory")}
</#list>
</#if>
<#--
<div class="module m-o m-o-large-all-detail">
    <div class="ui-box ui-box-wrap">
        <div class="ui-box-title">
            <h2>热门商品</h2>
        </div>
        <div class="ui-box-body">
            <ul class="items-list  util-clearfix">
                <li class="item">
                    <div class="img">
                        <div class="pic">
                            <a class="pic-rind"
                               href="http://www.aliexpress.com/store/product/In-Stock-Original-Xiaomi-Mi4-Snapdragon-801-Quad-Core-2-5Ghz-Xiaomi-M4-Mobile-Phone-3G/609089_1992823857.html">
                                <img class="pic-core"
                                     src="http://i01.i.aliimg.com/wsphoto/v1/1992823857_1/In_Stock_Original_Xiaomi_Mi4_Snapdragon_801_Quad_Core_2_5Ghz_Xiaomi_M4_Mobile_Phone_3G_RAM_16G_64G_ROM_JDI_Android_4_4_8MP_13MP.jpg_200x200.jpg"
                                     alt="In Stock Original Xiaomi Mi4 Snapdragon 801  Quad Core 2.5Ghz Xiaomi M4 Mobile Phone 3G RAM 16G/64G ROM JDI Android 4.4 8MP 13MP">
                            </a>
                        </div>
                    </div>
                    <div class="detail">
                        <h3>
                            <a href="http://www.aliexpress.com/store/product/In-Stock-Original-Xiaomi-Mi4-Snapdragon-801-Quad-Core-2-5Ghz-Xiaomi-M4-Mobile-Phone-3G/609089_1992823857.html"
                               title="In Stock Original Xiaomi Mi4 Snapdragon 801  Quad Core 2.5Ghz Xiaomi M4 Mobile Phone 3G RAM 16G/64G ROM JDI Android 4.4 8MP 13MP">在原始股票Mi4小觅……
                            </a>
                        </h3>

                        <div class="cost"><b class="notranslate">387.99美元</b>/块</div>
                        <div class="star-cost">
                                 <span title="Star Rating: 4.8 out of 5" class="star star-s">
                                                 <span class="rate-percent" style="width: 95.5%;"></span>
                                </span>
                            <span class="recent-order">订单(73)</span>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
-->
