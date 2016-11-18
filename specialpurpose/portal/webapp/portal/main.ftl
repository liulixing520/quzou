<script language="javascript">
    (function (category) {
        category.fn.hoverDelay = function () {
            return this.each(function () {
                $(this).mouseenter(function () {
                    $(this).addClass("cl-item-unfold").siblings().removeClass("cl-item-unfold");
                }).mouseleave(function () {
                            $(this).removeClass("cl-item-unfold");
                        })
            })
        }
    })(jQuery);
    (function (industry) {
        industry.fn.tabHoverDelay = function () {
            return this.each(function (i) {
                var tabs = $(".tabbed-pane-panel").find(".industry-main");
                $(this).click(function () {
                    $(this).addClass("on-click").siblings().removeClass("on-click");
                    $(tabs[i]).css({"z-index": "6", "opacity": "1"}).siblings().css({"z-index": "1", "opacity": "0"});
                })
            })
        }
    })(jQuery);
    (function (switchable) {
        switchable.fn.switchHoverDelay = function () {
            return this.each(function (i) {
                var switchables = $(".tabbed-pane-panel").find(".industry-main");
                $(this).mouseenter(function () {
                    $(".ui-switchable-prev-btn").css({"display": "inline"});
                    $(".ui-switchable-next-btn").css({"display": "inline"});
                    $(this).addClass("on-click").siblings().removeClass("on-click");
                    $(switchables[i]).css({"z-index": "6", "opacity": "1"}).siblings().css({"z-index": "1", "opacity": "0"});
                }).mouseleave(function () {
                            $(".ui-switchable-prev-btn").css({"display": "none"});
                            $(".ui-switchable-next-btn").css({"display": "none"});
                        })
            })
        }
    })(jQuery);

    $(function () {
        var page = 1;
        var i = 5; //每版放5个图片
        //向后 按钮
        $("a.ui-switchable-prev-btn").click(function () {    //绑定click事件
            var content = $("ul .key-visual-content");
            var v_width = "510px";
            var divLeft = $("ul .key-visual-content").css("left");
            $("ul .key-visual-content").css({"left": "-1020px"});
        });
        //往前 按钮
        $("a.ui-switchable-next-btn").click(function () {
        });
    });

</script>

<div class="grid grid-c2-e6">
    <div class="col-extra home-b">
        <!--超级特卖-->
        ${screens.render("component://portal/widget/CommonScreens.xml#superdeals")}
        <!--超级特卖 end-->
        <!--猜您喜欢-->
        ${screens.render("component://portal/widget/CommonScreens.xml#popular")}
        <!--猜您喜欢 end-->

    </div>
    <style type="text/css">
.play ol li{float:left;margin-left:8px;}
</style>
    <div class="col-main">
        <div class="main-wrap">
            <!--导航/banner-->
            <div class="top-container" id="top-container">
            <#assign localeStr=Static["org.ofbiz.base.util.UtilHttp"].getLocale(request).toString()>
            <#assign catalogMenu=Static["org.ofbiz.base.util.UtilStaticHtml"].screensRenderAsText("component://images/webapp/images/static/catalogMenu_${localeStr!'zh'}.ftl",screens,"component://portal/widget/MainScreens.xml#categories-main",true)>
            ${StringUtil.wrapString(catalogMenu!)}
            <#--
                ${screens.render("component://portal/widget/MainScreens.xml#categories-main")}
                -->
                ${screens.render("component://portal/widget/CommonScreens.xml#activityShow")}
            </div>
            <!--畅销商品-->
            ${screens.render("component://portal/widget/CommonScreens.xml#weeklyBestsellingsSearch")}
            <!--新品上架-->
            ${screens.render("component://portal/widget/CommonScreens.xml#hotNew")}

                <div class="mod brand-showcase ui-switchable" id="brandShowCase" style="display:none;">
                        <div class="tabbed-pane-panel ui-switchable-content">
                            <div class="brand-main-box ui-switchable-panel"></div>
                        </div>
                    </div>
            <!--推荐卖家-->
            ${screens.render("component://portal/widget/CommonScreens.xml#bestselling")}
            <!--推荐品类-->
           <#-- ${screens.render("component://portal/widget/CommonScreens.xml#bestselling2")}  -->
        </div>
    </div>
</div>
</div>
<#--说明
${screens.render("component://portal/widget/CommonScreens.xml#publicInformation")}
</div>
-->
<script>
    $(function () {
        $(".categories-list-box dl").hoverDelay();
        $("#tabbedIndustryMenus li").tabHoverDelay();
        $("#key-visual li").switchHoverDelay();
    });
</script>