<script language="javascript">
    (function (category) {
        category.fn.hoverDelay = function () {
            return this.each(function () {
                $(this).mouseenter(function () {
                    $(this).addClass("hover-on").siblings().removeClass("hover-on");
                }).mouseleave(function () {
                    $(this).removeClass("hover-on");
                })
            })
        }
    })(jQuery);
</script>

<div class="module m-sop m-sop-shop-nav">
    <div class="shop-nav">
        <ul class="nav-list util-clearfix">
            <li class="current">
                <a class="nav-link nav-link-first"
                   href="<@ofbizUrl>tmall</@ofbizUrl>?productStoreId=${productStoreId}">
                <#-- 此链接可用 <a class="nav-link nav-link-first"  href="<@ofbizUrl>sellerhome</@ofbizUrl>?productStoreId=${productStoreId}">-->
                    <span class="over"> ${uiLabelMap.Commoditypage}</span>
                </a>
            </li>
<#--            <li id="product-nav" class="">
                <a class="">
                    <span class="product-nav">${uiLabelMap.sellerProducts}<b class="arrow"></b></span>
                </a>

                <div id="pro-category-wrap" class="pro-category-wrap">
                    <ul class="pro-category-list">
                    <#if (requestAttributes.curCategoryId)?exists><#assign curCategoryId = requestAttributes.curCategoryId></#if>
                    <#if topStoreCategoryList?has_content>
                        <#list topStoreCategoryList as category>
                            <@categoryList parentCategory="" category=category wrapInBox="N"/>
                        </#list>
                    </#if>
                    <#macro categoryList parentCategory category wrapInBox>
                        <li>
                            <#assign gvCategory =category.getRelatedOne("CurrentProductCategory", true)>
                        &lt;#&ndash;<a href="<@ofbizCatalogAltUrl productCategoryId=category.productCategoryId previousCategoryId=parentCategoryId/>">${(gvCategory.categoryName)!}</a>&ndash;&gt;
                            <a href="<@ofbizUrl>tmall?productStoreId=${productStoreId!}&productCategoryId=${category.productCategoryId}</@ofbizUrl>">${(gvCategory.categoryName)!}</a>
                            <#local secondCatList = Static["org.ofbiz.product.category.CategoryExtWorker"].getRelatedCategoriesRet(request, "secondCatList",productStoreId, category.getString("productCategoryId"), true)>
                            <#if secondCatList?has_content>
                                <i class="sub-group-arrow"></i>

                                <div class="pro-category-wrap sub-group-list">
                                    <ul>
                                        <#list secondCatList as secondCat>
                                            <li>
                                                <a href="<@ofbizUrl>tmall?productStoreId=${productStoreId!}&productCategoryId=${secondCat.productCategoryId}</@ofbizUrl>">${(secondCat.categoryName)!}</a>
                                            </li>
                                        </#list>
                                    </ul>
                                </div>
                            </#if>
                        </li>
                    </#macro>

                    </ul>
                </div>
            </li>-->
            <li class="current last">
                <a class="nav-link" rel="nofollow"
                   href="<@ofbizUrl>sellerContactDetails</@ofbizUrl>?productStoreId=${productStoreId}">
                    <span>${uiLabelMap.sellerCommodity}</span>
                </a>
            </li>
        </ul>
    </div>
</div>

<script>
    $(function () {
        $("#product-nav").hoverDelay();
        $("#pro-category-wrap li").hoverDelay();
    });
</script>
