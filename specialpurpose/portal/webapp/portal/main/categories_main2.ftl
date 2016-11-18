<div class="categories-main">
    <div class="categories-list-box">

        <#if (requestAttributes.topLevelList)?exists><#assign topLevelList = requestAttributes.topLevelList></#if>
        <#if (requestAttributes.curCategoryId)?exists><#assign curCategoryId = requestAttributes.curCategoryId></#if>

        <#if topLevelList?has_content>
            <#list topLevelList as category>
                <@categoryList parentCategory="" category=category wrapInBox="N"/>
            </#list>
        </#if>

        <#macro categoryList parentCategory category wrapInBox>
            <#if category.showInHome?has_content && category.showInHome=="Y">
            <dl data-role="first-menu" class="cl-item cl-item-electronics">
            	<#--
            	<#assign catInfo = Static["org.ofbiz.product.category.CategoryContentWrapper"].getProductCategoryContentAsText(category, "CATEGORY_NAME", locale, null)/>
                <#if !catInfo?has_content>
                	<#assign catInfo = Static["org.ofbiz.product.category.CategoryContentWrapper"].getProductCategoryContentAsText(category, "DESCRIPTION", locale, null)/>
                </#if>
                -->
                <dt class="cate-name">
                	<#-- <@ofbizCatalogAltUrl productCategoryId=category.productCategoryId previousCategoryId=parentCategoryId/> -->
                    <a href="#"><@categoryName category=category/></a>
                </dt>
                <#local secondCatList = Static["org.ofbiz.product.category.CategoryWorker"].getRelatedCategoriesRet(request, "secondCatList", category.getString("productCategoryId"), true)>
                <dd data-role="first-menu-main" class="sub-cate">
                    <div class="sub-cate-main">
                        <#if secondCatList?has_content>
                            <#list secondCatList as secondCat>
                            <#if secondCat.showInHome?has_content && secondCat.showInHome="Y">
                                <dl data-role="two-menu" class="sub-cate-items">
                                    <dt>
                                        <a href="<@ofbizCatalogAltUrl productCategoryId=secondCat.productCategoryId+'001' />">
                                        <@categoryName category=secondCat/>
                                        </a>
                                    </dt>
                                    <#local thirdCatList = Static["org.ofbiz.product.category.CategoryWorker"].getRelatedCategoriesRet(request, "thirdCatList", secondCat.getString("productCategoryId"), true)>
                                    <#if thirdCatList?has_content>
                                        <dd>
                                            <#list thirdCatList as thirdCat>
                                                <#if thirdCat.showInHome?has_content && thirdCat.showInHome="Y">
                                                    <a href="<@ofbizCatalogAltUrl productCategoryId=thirdCat.productCategoryId/>">
                                                    <@categoryName category=thirdCat/>
                                                    </a>
                                                </#if>
                                            </#list>
                                        </dd>
                                    </#if>
                                </dl>
                            </#if>
                            </#list>
                        </#if>
                        <#if category.categoryImageUrl?has_content>
                            <#assign smallImageUrl = category.categoryImageUrl?if_exists>
                            <div class="scp-banner">
                                <img src="${smallImageUrl!}" width="220" height="450">
                            </div>
                        </#if>
                        <ul class="clearfix bottom-show-list">
                            <#if secondCatList?has_content>
                                <#list secondCatList as secondCat>
                                    <li class="hidden-sm">
                                        <#if secondCat.showInHome?has_content && secondCat.showInHome="Y" && secondCat.categoryImageUrl?has_content>
                                            <#assign smallImageUrl = secondCat.categoryImageUrl?if_exists>
                                                <span class="activity-pic"><img src="${smallImageUrl!}" width="160" height="120"></span>
                                        </#if>
                                    </li>
                                </#list>
                            </#if>
                        </ul>
                    </div>
                </dd>
            </dl>
            </#if>
        </#macro>

		<#macro categoryName category>
			<#assign catInfo = Static["org.ofbiz.product.category.EbizCategoryContentWrapper"].getProductCategoryContentAsText(category, "CATEGORY_NAME", request)/>
            <#if !catInfo?has_content>
            	<#assign catInfo = Static["org.ofbiz.product.category.EbizCategoryContentWrapper"].getProductCategoryContentAsText(category, "DESCRIPTION", request)/>
            </#if>
            <#if catInfo?has_content>
            ${catInfo!}
            <#else>
            ${(category.categoryName)!}
            </#if>
		</#macro>
        <div class="categories-all"><a href="#">${uiLabelMap.PortalAllCategories}</a></div>
    </div>
</div>
