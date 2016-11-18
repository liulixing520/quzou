
<#-- <div style="width:1000px; margin:0 auto;">
<h1 style="font-size:14px; padding-top:15px;">${uiLabelMap.ProductProductSearch}, <span class="h2" style="font-weight:bold;">${uiLabelMap.ProductYouSearchedFor}:${requestParameters.SEARCH_STRING?if_exists}</span></h1>
<ul>
<#if searchConstraintStrings?has_content>
<#list searchConstraintStrings as searchConstraintString>
    <li><a href="<@ofbizUrl>keywordsearch?removeConstraint=${searchConstraintString_index}&amp;clearSearch=N</@ofbizUrl>" class="buttontext">X</a>&nbsp;${searchConstraintString}</li>
</#list>
</#if>
</ul>
<br />
<div>${uiLabelMap.CommonSortedBy}: ${searchSortOrderString!}</div>
<br />


<#if !productIds?has_content>
  <h2>&nbsp;${uiLabelMap.ProductNoResultsFound}.</h2>
</#if>

<#if productIds?has_content>
    <div class="product-prevnext">
        Start Page Select Drop-Down 
        <#assign viewIndexMax = Static["java.lang.Math"].ceil((listSize - 1)?double / viewSize?double)>
        <select name="pageSelect" onchange="window.location=this[this.selectedIndex].value;">
          <option value="#">${uiLabelMap.CommonPage} ${viewIndex?int + 1} ${uiLabelMap.CommonOf} ${viewIndexMax + 1}</option>
          <#list 0..viewIndexMax as curViewNum>
            <option value="<@ofbizUrl>keywordsearch/~SEARCH_STRING=${requestParameters.SEARCH_STRING?if_exists}/~VIEW_SIZE=${viewSize}/~VIEW_INDEX=${curViewNum?int}/~clearSearch=N</@ofbizUrl>">${uiLabelMap.CommonGotoPage} ${curViewNum + 1}</option>
          </#list>
        </select>
         End Page Select Drop-Down 
         <b>
        <#if (viewIndex?int > 0)>
          <a href="<@ofbizUrl>keywordsearch/~SEARCH_STRING=${requestParameters.SEARCH_STRING?if_exists}/~VIEW_SIZE=${viewSize}/~VIEW_INDEX=${viewIndex?int - 1}/~clearSearch=N</@ofbizUrl>" class="buttontext">${uiLabelMap.CommonPrevious}</a> |
        </#if>
        <#if (listSize?int > 0)>
          <span>${lowIndex+1} - ${highIndex} ${uiLabelMap.CommonOf} ${listSize}</span>
        </#if>
        <#if highIndex?int < listSize?int>
          | <a href="<@ofbizUrl>keywordsearch/~SEARCH_STRING=${requestParameters.SEARCH_STRING?if_exists}/~VIEW_SIZE=${viewSize}/~VIEW_INDEX=${viewIndex+1}/~clearSearch=N</@ofbizUrl>" class="buttontext">${uiLabelMap.CommonNext}</a>
        </#if>
        </b>
    </div>
</#if>

<ul class="clearfix">
            <li><a href="/portal/control/sellerhome?productStoreId=10000">
                <div class="bs-pro-img">
                    <img width="170" height="170" src="../images/b1.jpg">
                </div>
                </a><a class="bs-pro-name" href="/portal/control/sellerhome?productStoreId=10000"><p>卖家：永辉超市</p></a>
                <a class="bs-pro-piece" href="/portal/control/sellerhome?productStoreId=10000"><p>主营：永辉超市</p></a></li>
        </ul>

 <#if productIds?has_content>
    <div class="bestSelling clearfix">
    	<ul class="clearfix">
        <#list productIds as productId> <#-- note that there is no boundary range because that is being done before the list is put in the content
        	<li style="margin-top:15px;">
            ${setRequestAttribute("optProductId", productId)}
            ${setRequestAttribute("listIndex", productId_index)}
            ${setRequestAttribute("productIndex", productId_index+1)}
            ${screens.render(productsummaryScreen)}
            </li>
        </#list>
        </ul>
    </div>
</#if>

<#if productIds?has_content>
    <div class="product-prevnext" style="margin-top:55px">
         Start Page Select Drop-Down 
        <#assign viewIndexMax = Static["java.lang.Math"].ceil((listSize - 1)?double / viewSize?double)>
        <select name="pageSelect" onchange="window.location=this[this.selectedIndex].value;">
          <option value="#">${uiLabelMap.CommonPage} ${viewIndex?int + 1} ${uiLabelMap.CommonOf} ${viewIndexMax + 1}</option>
          <#list 0..viewIndexMax as curViewNum>
            <option value="<@ofbizUrl>keywordsearch/~SEARCH_STRING=${requestParameters.SEARCH_STRING?if_exists}/~VIEW_SIZE=${viewSize}/~VIEW_INDEX=${curViewNum?int}/~clearSearch=N</@ofbizUrl>">${uiLabelMap.CommonGotoPage} ${curViewNum + 1}</option>
          </#list>
        </select>
        End Page Select Drop-Down
      <b>
        <#if (viewIndex?int > 0)>
          <a href="<@ofbizUrl>keywordsearch/~SEARCH_STRING=${requestParameters.SEARCH_STRING?if_exists}/~VIEW_SIZE=${viewSize}/~VIEW_INDEX=${viewIndex?int - 1}/~clearSearch=N</@ofbizUrl>" class="buttontext">${uiLabelMap.CommonPrevious}</a> |
        </#if>
        <#if (listSize?int > 0)>
          <span>${lowIndex+1} - ${highIndex} ${uiLabelMap.CommonOf} ${listSize}</span>
        </#if>
        <#if highIndex?int < listSize?int>
          | <a href="<@ofbizUrl>keywordsearch/~SEARCH_STRING=${requestParameters.SEARCH_STRING?if_exists}/~VIEW_SIZE=${viewSize}/~VIEW_INDEX=${viewIndex+1}/~clearSearch=N</@ofbizUrl>" class="buttontext">${uiLabelMap.CommonNext}</a>
        </#if>
        </b>
    </div>
</#if>
</div>-->

<link href="/portal/images/css/header-all.css" rel="stylesheet" type="text/css" media="all" />
<link href="/portal/images/css/header.css" rel="stylesheet" type="text/css" media="all" />
<link href="/portal/images/css/footer.css" rel="stylesheet" type="text/css" media="all" />
<link href="/portal/images/css/m-search-common.css" rel="stylesheet" type="text/css" media="all"/>
<link href="/portal/images/css/m-spu-product-detail.css" rel="stylesheet" type="text/css" media="all"/>
  <link rel="stylesheet" href="/portal/images/css/common-nohead.css" type="text/css"/>
  <link rel="stylesheet" href="/portal/images/css/cate-toplink.css" type="text/css"/>
      <link rel="stylesheet" href="/portal/images/css/go-top-ws.css" type="text/css"/>



<div class="categories-collapse autosize_wrap en-us" id="page">
  <div class="grid-c2-s5">
  <!-- 页面的中间部分 的中间位置 -->
    ${screens.render("component://portal/widget/CatalogScreens.xml#keywordsearchBrand")}
  <!-- 页面的中间部分 的中间位置 -->
    <!--左侧分类-->
    ${screens.render("component://portal/widget/CatalogScreens.xml#keywordsearchCategories")}
	 <!-- and -->
	
    <!-- 右边-->
     ${screens.render("component://portal/widget/CatalogScreens.xml#keywordsearchRightCate")}
  </div>
</div>















