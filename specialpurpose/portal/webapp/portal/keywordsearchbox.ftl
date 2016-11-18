
<form name="keywordsearchform" id="keywordsearchbox_keywordsearchform" method="post" action="<@ofbizUrl>keywordsearch</@ofbizUrl>">

    <label for="key_S" class="label_search" id="label_key"
           onclick="this.style.color='rgb(255, 255, 255)';"
           style="visibility: visible; color: rgb(102, 102, 102);">input</label>
    <input type="text" class="text" name="SEARCH_STRING" autocomplete="off"
           value="${requestParameters.SEARCH_STRING?if_exists}"
           onclick="key_onclick();" onfocus="this.className='text';" onblur="key_onblur();"
           onbeforepaste="onpaste_search();">
    <a href="javascript:void(0);" onclick="clearkeys();" class="del-keywords"></a>
    <span class="select" onmouseover="allCategoryShow();" onmouseleave="allCategoryHide();"
          onmouseout="if(&quot;\v&quot;!=&quot;v&quot;){ allCategoryHide();}">
        <span id="Show_Category_Name">${uiLabelMap.ProductEntireCatalog}</span><span class="icon"></span>
            <div id="search_all_category" class="select_pop" style="height: 0px; padding: 0px; border-width: 0px;">
                <#list otherSearchProdCatalogCategories as otherSearchProdCatalogCategory>
                    <#assign searchProductCategory = otherSearchProdCatalogCategory.getRelatedOne("ProductCategory", true)>
                    <#if searchProductCategory?exists>
                        <a href="javascript:void(0);" onclick="selectCategory(${searchProductCategory.productCategoryId} ,this);"><span>${searchProductCategory.description?default("No Description " + searchProductCategory.productCategoryId)}</span></a>
                    </#if>
                </#list>
            </div>
        </span>

    <input type="hidden" name="VIEW_SIZE" value="10" />
    <input type="hidden" name="PAGING" value="Y" />
    <input type="submit" id="search_btn" style="display:none" value="${uiLabelMap.CommonFind}" />
    <input type="button" class="button" onclick="javascript:document.getElementById('search_btn').click();">

</form>