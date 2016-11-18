<div class="col-sub">

 <div class="seller-top-selling">
<div class="ui-box ui-box-primary">
    <h3 class="ui-box-title"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-766" rel="766">${uiLabelMap.PortalBestSellingCf}</font></h3>
    <div class="ui-box-body">

       ${screens.render("component://portal/widget/CatalogScreens.xml#showProductToleftToFor")}
      
      
    </div>
</div>
</div>

<div class="trending-products">
<div class="ui-box ui-box-primary">
    <h3 class="ui-box-title"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-788" rel="788">${uiLabelMap.PortalHotNewCf}</font></h3>
    <div class="ui-box-body">
        <div class="trending-products-list more">
  
        ${screens.render("component://portal/widget/CatalogScreens.xml#showProductToleftToNewSToFor")}
                
        </div>
        
        <#-- <div class="util-clearfix">
            <a data-role="more" class="internal view-more" href="javascript:void(0)" rel="nofollow" title="View More"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-834" rel="834">查看更多</font></a>
        </div> -->
        
    </div>
</div>



 <div class="seller-categories">
<div class="module m-sop m-sop-shop-cate">

    <#-- <div class="ui-box ui-box-wrap">
        <div class="ui-box-title">
            <h4>${uiLabelMap.PortalAllCategories}</h4>
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
                        <a href="<@ofbizUrl>StoreCategory?productStoreId=${productStoreId!}&productCategoryId=${category.productCategoryId}&parentCategoryId=${parentCategoryId!}/></@ofbizUrl>">${(gvCategory.categoryName)!}</a>
                        <ul class="sub-groups-list" style="display: block;">
                            <#local secondCatList = Static["org.ofbiz.product.category.CategoryExtWorker"].getRelatedCategoriesRet(request, "secondCatList",productStoreId, category.getString("productCategoryId"), true)>
                            <#if secondCatList?has_content>
                                <#list secondCatList as secondCat>
                                	<#assign findPftMap = Static["org.ofbiz.base.util.UtilMisc"].toMap("productCategoryId", secondCat.productCategoryId)>
                                	<#assign gvSecondCat =delegator.findOne("ProductCategory", findPftMap, true)>
                                    <li class="sub-group-item">
                                        <a href="<@ofbizUrl>StoreCategory?productStoreId=${productStoreId!}&productCategoryId=${secondCat.productCategoryId}&parentCategoryId=${category.productCategoryId!}/></@ofbizUrl>">${(gvSecondCat.categoryName)!}</a>
                                    </li>
                                </#list>
                            </#if>
                        </ul>
                    </li> 
                    
                    <li class="group-item">
                        <div class="group-tree-icon expand"></div>
                        <#assign gvCategory =category.getRelatedOne("CurrentProductCategory", true)>
                        <a href="<@ofbizUrl>sellerhome?productStoreId=${productStoreId!}</@ofbizUrl>">${(gvCategory.categoryName)!}</a>
                        <ul class="sub-groups-list" style="display: block;">
                            <#local secondCatList = Static["org.ofbiz.product.category.CategoryExtWorker"].getRelatedCategoriesRet(request, "secondCatList",productStoreId, category.getString("productCategoryId"), true)>
                            <#if secondCatList?has_content>
                                <#list secondCatList as secondCat>
                                	<#assign findPftMap = Static["org.ofbiz.base.util.UtilMisc"].toMap("productCategoryId", secondCat.productCategoryId)>
                                	<#assign gvSecondCat =delegator.findOne("ProductCategory", findPftMap, true)>
                                    <li class="sub-group-item">
                                        <a href="<@ofbizUrl>sellerhome?productStoreId=${productStoreId!}</@ofbizUrl>">${(gvSecondCat.categoryName)!}</a>
                                    </li>
                                </#list>
                            </#if>
                        </ul>
                    </li>
                </#macro>

                <li class="group-item">
                    <div class="group-tree-icon expand"></div>
                     <a href="<@ofbizUrl>StoreCategory?productStoreId=${productStoreId!}</@ofbizUrl>">其他</a> 
                    <a href="<@ofbizUrl>sellerhome?productStoreId=${productStoreId!}</@ofbizUrl>">其他</a>
                </li>
            </ul>
        </div>
    </div>
</div>-->


</div>

</div>