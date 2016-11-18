<div class="omod-title-bar-b-3px clearfix"><h2 class="c_title_bar"><span class="c_title"><font>${(catalogName)!}</font></span></h2>
</div>
<div style="position: relative; " class="categories_content row-4">
        <#assign secondCatList = Static["org.ofbiz.product.category.CategoryWorker"].getRelatedCategoriesRet(request, "secondCatList", productCategoryId, true)>
        <#if secondCatList?has_content>
            <#list secondCatList as secondCat>
                <div class="categorieslist">
                    <strong>${(secondCat.categoryName)!}</strong>
                    <ul>
                        <#assign thirdCatList = Static["org.ofbiz.product.category.CategoryWorker"].getRelatedCategoriesRet(request, "thirdCatList", secondCat.productCategoryId, true)>
                        <#if thirdCatList?has_content>
                            <#list thirdCatList as thirdCat>
                            <li>
                                <a href="">${(thirdCat.categoryName)!}</a>
                                <span class="hot"><img src="<@ofbizUrl>../categories/second/images/hot.png</@ofbizUrl>"></span>
                            </li>
                            </#list>
                        </#if>
                    </ul>
                </div>
            </#list>
        </#if>
</div>