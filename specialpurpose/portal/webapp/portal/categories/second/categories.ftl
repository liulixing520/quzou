<h3 class="cate-nav-bar">
    <#assign catInfo = Static["org.ofbiz.product.category.EbizCategoryContentWrapper"].getProdCatNameByLocale(productCategory, request)/>

    <font>${catInfo!}</font>
</h3>
<ul class="categories-list">
<#assign secondCatList = Static["org.ofbiz.product.category.CategoryWorker"].getRelatedCategoriesRet(request, "secondCatList", productCategoryId, true)>
<#if secondCatList?has_content>
    <#list secondCatList as secondCat>
        <li class="c-list">
            <a href="<@ofbizCatalogAltUrl productCategoryId=secondCat.productCategoryId />"><font>
            <@categoryName category=secondCat/>
            <#--<#if secondCat.categoryName?length gt 100>${(secondCat.categoryName[0..100])?if_exists}..<#else>${secondCat.categoryName}</#if>-->
            </font></a>
            
            <ul style="margin-top: -1px; display: none;" class="l-2-menu">
                <#assign thirdCatList = Static["org.ofbiz.product.category.CategoryWorker"].getRelatedCategoriesRet(request, "thirdCatList", secondCat.getString("productCategoryId"), true)>
                <#if thirdCatList?has_content>
                    <#list thirdCatList as thirdCat>
                        <li class="sub-list"><a href="${(secondCat.productCategoryId)!}"><font><@categoryName category=thirdCat/></font></a></li>
                    </#list>
                </#if>
            </ul> 
        </li>
    </#list>
</#if>
</ul>
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