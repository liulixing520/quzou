<div class="module m-o m-o-large-all-detail">
    <div class="ui-box ui-box-wrap">
        <div class="ui-box-title">
            <h2>畅销产品</h2>
        </div>
        <div class="ui-box-body">
            <ul class="items-list  util-clearfix">
                <#if weeklyCategoryMembers?has_content>
                    <#list weeklyCategoryMembers as productCategoryMember>
                        <li class="item">
                            ${setRequestAttribute("optProductId", productCategoryMember.productId)}
                            ${screens.render("component://portal/widget/CatalogScreens.xml#productsummaryForWeekly")}
                        </li>
                    </#list>
                </#if>
                <li class="item">
                    <div class="img">
                        <div class="pic">
                            <a class="pic-rind"
                               href="http://www.aliexpress.com/store/product/Russian-support-Original-Lenovo-A516-MT6572-4GB-ROM-Android-4-2-2-4-5-Inch-IPS/609089_1341767196.html">
                                <img class="pic-core"
                                     src="http://i00.i.aliimg.com/wsphoto/v6/1341767196_1/Russian_support_Original_Lenovo_A516_MT6572_4GB_ROM_Android_4_2_2_4_5_Inch_IPS_Capcitive_touch_screen_Dual_Core_cellphone_Pink.jpg_200x200.jpg"
                                     alt="Russian support Original Lenovo A516 MT6572 4GB ROM Android 4.2.2 4.5 Inch IPS Capcitive touch screen Dual Core cellphone Pink">
                            </a>
                        </div>
                        <div class="discount">
                            <span class="rate">15</span>
                        </div>
                    </div>
                    <div class="detail">
                        <h3>
                            <a href="http://www.aliexpress.com/store/product/Russian-support-Original-Lenovo-A516-MT6572-4GB-ROM-Android-4-2-2-4-5-Inch-IPS/609089_1341767196.html"
                               title="Russian support Original Lenovo A516 MT6572 4GB ROM Android 4.2.2 4.5 Inch IPS Capcitive touch screen Dual Core cellphone Pink">俄罗斯支持原始联想A516……
                            </a>
                        </h3>
                        <div class="cost"><b class="notranslate">84.14美元</b>/块</div>
                        <div class="cost-old">
                            <del>98.99美元/件</del>
                        </div>
                        <div class="star-cost">
                             <span title="Star Rating: 4.9 out of 5" class="star star-s">
                                 <span class="rate-percent" style="width: 97.4%;"></span>
                            </span>
                            <span class="recent-order">订单(46)</span>
                        </div>
                    </div>
                </li>
<#--                <li class="item">
                    <div class="img">
                        <div class="pic">
                            <a class="pic-rind"
                               href="http://www.aliexpress.com/store/product/Original-Huawei-Honor-3C-Quad-Core-Smartphone-5-inch-LTPS-1280x720-MTK6582-8-0MP-Android-4/609089_1645249989.html">
                                <img class="pic-core"
                                     src="http://i01.i.aliimg.com/wsphoto/v2/1645249989_1/Original_4G_TD_LTE_Huawei_Honor_3C_Quad_Core_Smartphone_5_inch_LTPS_1280x720_Kirin_K910_1_6GHz_8_0MP_Android_4_4_16G_ROM.jpg_200x200.jpg"
                                     alt="Original 4G TD LTE Huawei Honor 3C Quad Core Smartphone 5 inch LTPS 1280x720 Kirin K910 1.6GHz 8.0MP Android 4.4 16G ROM">
                            </a>
                        </div>

                        <div class="discount">
                            <span class="rate">5</span>
                        </div>

                    </div>
                    <div class="detail">
                        <h3>
                            <a href="http://www.aliexpress.com/store/product/Original-Huawei-Honor-3C-Quad-Core-Smartphone-5-inch-LTPS-1280x720-MTK6582-8-0MP-Android-4/609089_1645249989.html"
                               title="Original 4G TD LTE Huawei Honor 3C Quad Core Smartphone 5 inch LTPS 1280x720 Kirin K910 1.6GHz 8.0MP Android 4.4 16G ROM">原来的4
                                g TD LTE华为荣耀3 c…
                            </a>
                        </h3>

                        <div class="cost"><b class="notranslate">167.99美元</b>/块</div>
                        <div class="cost-old">
                            <del>176.83美元/件</del>
                        </div>
                        <div class="star-cost">
                                                                                 <span title="Star Rating: 4.9 out of 5"
                                                                                       class="star star-s">
                                                 <span class="rate-percent" style="width: 98.1%;"></span>
                                            </span>

    								                                             <span class="recent-order">订单(355)
                                                                                 </span>


                        </div>

                    </div>
                </li>-->
            </ul>
        </div>
    </div>
</div>

<!-- 960 -->

