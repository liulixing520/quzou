<#assign shoppingCartMap = sessionAttributes.shoppingCartMap?if_exists>
<#if shoppingCartMap?has_content>
    <#assign shoppingCartSize = shoppingCartMap.size()>
<#else>
    <#assign shoppingCartSize = 0>
</#if>

<div class="top-lighthouse" id="top-lighthouse">
    <div class="top-lighthouse-wrap container">
        <div class="nav-channel hidden-xs hidden-sm">
            <a href="<@ofbizUrl>commoditySpecialOffer</@ofbizUrl>">${uiLabelMap.PortalSuperDeals}</a>
            <a href="<@ofbizUrl>globalSpeedSold</@ofbizUrl>">${uiLabelMap.PortalBestSelling}</a>
        </div>
        <div class="nav-global" id="nav-global">
            <#if !userLogin?has_content>
                <div class="ng-item ng-bp"><a href="<@ofbizUrl>joinFree</@ofbizUrl>">免费开店</a>
                </div>
            </#if>
            <#if userLogin?has_content && security.hasEntityPermission("ECSELLER", "_VIEW", session)>
                <div class="ng-item ng-sub ng-seller">
                    <span class="ng-sub-title"><a href="<@ofbizUrl>sellerIndex</@ofbizUrl>">卖家入口</a></span>
                    <ul class="ng-sub-list">
<#--                        <li><a href="<@ofbizUrl>joinFree</@ofbizUrl>">卖家注册</a></li>
                        <li><a href="<@ofbizUrl>store</@ofbizUrl>">免费开店</a></li>-->
                        <li><a href="<@ofbizUrl>EditProductEn</@ofbizUrl>">发布商品</a></li>
                        <li><a href="<@ofbizUrl>tmall</@ofbizUrl>">我的店铺</a></li>
                        <li><a href="<@ofbizUrl>FindProductEn</@ofbizUrl>">管理商品</a></li>
                        <li><a href="<@ofbizUrl>FindOrderEn</@ofbizUrl>">管理订单</a></li>
<#--                    <li><a target="_blank" href="#">卖家频道</a></li>
                            <li><a target="_blank" href="#">平台介绍</a></li>
                            <li><a target="_blank" href="#">热卖推荐</a></li>
                            <li><a target="_blank" href="#">支付服务</a></li>
                            <li><a target="_blank" href="#">投诉举报</a></li>
                            <li><a target="_blank" href="#">物流服务</a></li>
                            <li><a target="_blank" href="#">官方微博</a></li>
                            <li><a target="_blank" href="#">卖家论坛</a></li>-->
                    </ul>
                </div>
            </#if>
            <div class="ng-item ng-bp"><a href="<@ofbizUrl>userMain</@ofbizUrl>">${uiLabelMap.PortalMyTradeEase}</a>
            </div>
            <div class="ng-item ng-bp"><a href="">${uiLabelMap.PortalBuyerProtection}</a></div>
            <div class="ng-item ng-bp"><a href="">${uiLabelMap.PortalHelpCenter}</a></div>
            <div class="ng-item ng-switcher ng-help ng-sub">
                <span class="ng-sub-title" id="swither-span">${uiLabelMap.PortalLanguageAndCurrency}</span>

                <div class="switcher-sub notranslate" style="top:33px;">
                <#assign curLocale = sessionAttributes.locale?if_exists>
                <#assign curCurrencyUom = sessionAttributes.currencyUom?if_exists>
                    <form action="<@ofbizUrl>setSessionLocaleAndCurrency</@ofbizUrl>" id="localeAndCurrency">
                        <input type="hidden" id="newLocale" name="newLocale" value="${curLocale}"/>
                        <input type="hidden" id="currencyUom" name="currencyUom" value="${curCurrencyUom}"/>

                        <div class="switcher-common">
                            <span class="switcher-title">${uiLabelMap.PortalLanguageAndCurrency}</span>
                            <div class="switcher-shipto item util-clearfix">
                                <span class="label">${uiLabelMap.PortalLanguage}</span>
                                <div class="country-selector switcher-shipto-c">
                                <#assign availableLocales = Static["org.ofbiz.base.util.UtilMisc"].availableLocales()/>
                                    <div class="link-fake-selector" id="country-selector" style="width:260px; right:auto; padding:0; margin:0; height:30px;">
                                        <div class="list-title fold">
                                            <span id="country-value" class="country-text">
                                                <#list availableLocales as availableLocale>
                                                    <#assign langAttr = availableLocale.toString()?replace("_", "-")>
                                                    <#if "zh.ru"?contains(langAttr)>
                                                        <#if curLocale=="${availableLocale.toString()}">
                                                            ${availableLocale.getDisplayName(curLocale)}
                                                        </#if>
                                                    </#if>
                                                </#list>
                                            </span>
                                        </div>
                                    </div>
                                    <div style="display: none;" class="list-container" id="list-country">
                                    <#list availableLocales as availableLocale>
                                        <#assign langAttr = availableLocale.toString()?replace("_", "-")>
                                        <#if "zh.ru"?contains(langAttr)>
                                            <a class="even"
                                               href="javascript:setParam('newLocale' , '${availableLocale.toString()}' , '${availableLocale.getDisplayName(availableLocale)}' , 'list-country' , 'country-value');">
                                                <span class="country-text">${availableLocale.getDisplayName(availableLocale)}</span>
                                            </a>
                                        </#if>
                                    </#list>
                                    </div>
                                </div>
                            </div>
                            <div class="switcher-shipto item util-clearfix">
                                <span class="label">${uiLabelMap.PortalCurrency}</span>

                                <div class="country-selector switcher-shipto-c">
                                    <div class="link-fake-selector" id="currency-selector">
                                        <div class="list-title fold">
                                            <span class="currency-text" id="currency-value">${curCurrencyUom}</span>
                                        </div>
                                    </div>
                                    <div style="display: none; width:260px; float:inherit; position:absolute;" class="list-container" id="list-currency">
                                        <a class="even"
                                           href="javascript:setParam('currencyUom' , 'CNY' , 'CNY' , 'list-currency' , 'currency-value');">
                                            <span class="country-text">CNY</span>
                                        </a>
<#--                                        <a class="even"
                                           href="javascript:setParam('currencyUom' , 'USD' , 'USD' , 'list-currency' , 'currency-value');">
                                            <span class="country-text">USD</span>
                                        </a>-->
                                        <a class="even"
                                           href="javascript:setParam('currencyUom' , 'RUR' , 'RUR' , 'list-currency' , 'currency-value');">
                                            <span class="country-text">RUR</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="switcher-btn item util-clearfix">
                               <#-- <button class="ui-button ui-button-primary go-contiune-btn"
                                        type="submit">${uiLabelMap.sellerDetermine}
                                </button>-->
                                <button class="ui-button ui-button-primary go-contiune-btn"
                                        type="button" onclick='localeAndCurrency()'>${uiLabelMap.sellerDetermine}
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="ng-item ng-help ng-sub"></div>
        </div>
    </div>
</div>
<script>
function localeAndCurrency(){
	jQuery.ajax({
            type: "post",//使用get方法访问后台
            url:"<@ofbizUrl>setSessionLocaleAndCurrency</@ofbizUrl>",//要访问的后台地址
            data:{"newLocale":$("#newLocale").val(),"currencyUom":$("#currencyUom").val()},//要发送的数据
            success: function (msg) {//msg为返回的数据，在这里做数据绑定
	               location.reload();
            }
      });
}
</script>
<div class="header" id="header">
    <div class="header-wrap container">
        <div class="hm-left">
        <#--            <div class="header-categories unfold-home-categories" id="header-categories">
                            <span class="categories-title">${uiLabelMap.PortalCategories}</span>
                        <i class="balloon-arrow">
                        </i>
                    </div>-->
            <h1 class="logo">
                <a href="<@ofbizUrl>main</@ofbizUrl>">${uiLabelMap.PortalTradeEase}</a>
            </h1>
        </div>
        <div class="hm-right">
            <div class="nav-cart">
                <a href="<@ofbizUrl>showcart</@ofbizUrl>"><span class="text">${uiLabelMap.PortalShoppingCart}</span></a>
                <#if shoppingCartMap?has_content>
                    <span id="nav-cart-num" class="cart-number">${shoppingCartMap.getTotalQuantity()}</span>
                <#else>
                    <span id="nav-cart-num" class="cart-number">0</span>
                </#if>
            </div>

            <div class="nav-user-account">
                <div class="user-account-info">
                    <div class="user-account-inner">
                            <span class="account-unsigned">
                            <#if sessionAttributes.autoName?has_content>
                                <a href="<@ofbizUrl>userMain</@ofbizUrl>">${sessionAttributes.autoName?html}</a>
                    				<span class="ua-line">|</span>
                    				<a href="<@ofbizUrl>logout</@ofbizUrl>">${uiLabelMap.PortalLogout}</a>
                            <#else>
                                <a href="<@ofbizUrl>login</@ofbizUrl>">${uiLabelMap.PortalLogin}</a>
                                	<span class="ua-line">|</span>
                                	<a href="<@ofbizUrl>newcustomer</@ofbizUrl>">${uiLabelMap.PortalRegister}</a>
                            </#if>
                            </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="hm-middle">
            <form id="form-searchbar" class="searchbar-form" method="post"
                  action="<@ofbizUrl>keywordsearch</@ofbizUrl>">
                <input type="hidden" name="VIEW_SIZE" value="10"/>
                <input type="hidden" name="PAGING" value="Y"/>

                <div class="searchbar-operate-box">
                    <div class="search-category hidden-sm notranslate">
                        <div class="search-cate-title">
                            <span id="categoryShow"
                                  class="search-category-value">${uiLabelMap.PortalAllCategories}</span>
                        </div>
                        <select class="search-cate notranslate" name="SEARCH_CATEGORY_ID" id="SEARCH_CATEGORY_ID"
                                onchange="$('#categoryShow').html(this[this.selectedIndex].text)">
                            <option value="all">${uiLabelMap.PortalAllCategories}</option>
                        <#if (requestAttributes.topLevelList)?exists><#assign topLevelList = requestAttributes.topLevelList></#if>
                        <#if topLevelList?has_content>
                            <#list topLevelList as category>
                                <@categoryList parentCategory="" category=category wrapInBox="Y"/>
                            </#list>
                        </#if>
                        <#macro categoryList parentCategory category wrapInBox>
                            <#assign catInfo = Static["org.ofbiz.product.category.EbizCategoryContentWrapper"].getProdCatNameByLocale(category, request)/>
                            <option value="${category.productCategoryId}" <#if requestParameters.SEARCH_CATEGORY_ID??&&requestParameters.SEARCH_CATEGORY_ID==category.productCategoryId>selected=true</#if> >${(catInfo)!}</option>
                        </#macro>
                        </select>
                    </div>
                    <input type="submit" class="search-button" value="">
                </div>
                <div class="search-key-box">
                    <input type="text" placeholder="${uiLabelMap.PortalSearchKey}" maxlength="50" autocomplete="off"
                            name="SEARCH_STRING" class="search-key" id="search-key"
                           value="${requestParameters.SEARCH_STRING?if_exists}">
                </div>
            </form>
        </div>
    </div>
</div>
<div style="height:0px; display: block;" id="fixed-placeholder">
</div>

<script>

    $(function () {
    	<#if requestParameters.SEARCH_CATEGORY_ID??>
    		$('#categoryShow').html($("#SEARCH_CATEGORY_ID").find("option:selected").text()); 
    	</#if>
        $(document).bind("click", function (e) {
            var target = $(e.target);
            if (target.closest(".ng-switcher").length == 0) {
                $(".switcher-sub").hide();
            }
        })
    })

    $("#swither-span").click(function () {
        $(".switcher-sub").toggle();
    });
    $("#country-selector").click(function () {
        $("#list-country").toggle();
    });
    $("#currency-selector").click(function () {
        $("#list-currency").toggle();
    });

    function setParam(paraName, paraValue, paraDesc, obj, paraShow) {
        $("#" + obj).hide();
        $("#" + paraShow).text(paraDesc);
        $("#" + paraName).val(paraValue);
    }
</script>