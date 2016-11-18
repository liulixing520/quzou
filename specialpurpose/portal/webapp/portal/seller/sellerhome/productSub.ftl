<div class="module m-sop m-sop-shop-cate">
    <div class="ui-box ui-box-wrap">
        <div class="ui-box-title">
            <h3>产品分类</h3>
        </div>
        <div class="ui-box-body">
            <div class="loading16" style="display: none;"></div>
            <ul class="groups-list groups-default">

                <#if (requestAttributes.curCategoryId)?exists><#assign curCategoryId = requestAttributes.curCategoryId></#if>

                <#if topStoreCategoryList?has_content>
                    
                    <#list topStoreCategoryList as category>
                        <@categoryList parentCategoryId="" category=category wrapInBox="N"/>
                    </#list>
                </#if>

                <#macro categoryList parentCategoryId category wrapInBox>
                    <li class="group-item">
                        <div class="group-tree-icon expand"></div>
                        <#assign gvCategory =category.getRelatedOne("CurrentProductCategory", true)>
                        <#--<a href="<@ofbizUrl>StoreCategory?productStoreId=${productStoreId!}&productCategoryId=${category.productCategoryId}&parentCategoryId=${parentCategoryId!}/></@ofbizUrl>">${(gvCategory.categoryName)!}</a>-->
                        <a href="<@ofbizUrl>tmall?productStoreId=${productStoreId!}&productCategoryId=${category.productCategoryId}</@ofbizUrl>">${(gvCategory.categoryName)!}</a>
                        <ul class="sub-groups-list" style="display: block;">
                            <#local secondCatList = Static["org.ofbiz.product.category.CategoryExtWorker"].getRelatedCategoriesRet(request, "secondCatList",productStoreId, category.getString("productCategoryId"), true)>
                            <#if secondCatList?has_content>
                                <#list secondCatList as secondCat>
                                	<#assign findPftMap = Static["org.ofbiz.base.util.UtilMisc"].toMap("productCategoryId", secondCat.productCategoryId)>
                                	<#assign gvSecondCat =delegator.findOne("ProductCategory", findPftMap, true)>
                                    <li class="sub-group-item">
                                        <#--<a href="<@ofbizUrl>StoreCategory?productStoreId=${productStoreId!}&productCategoryId=${secondCat.productCategoryId}&parentCategoryId=${category.productCategoryId!}/></@ofbizUrl>">${(gvSecondCat.categoryName)!}</a>-->
                                        <a href="<@ofbizUrl>tmall?productStoreId=${productStoreId!}&productCategoryId=${secondCat.productCategoryId}</@ofbizUrl>">${(gvSecondCat.categoryName)!}</a>
                                    </li>
                                </#list>
                            </#if>
                        </ul>
                    </li>
                </#macro>
            </ul>
        </div>
    </div>
</div>
