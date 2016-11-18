
<link href="../images/css/product-to-one.css" rel="stylesheet" type="text/css" media="all"/>
<link href="../images/css/product-to-two.css" rel="stylesheet" type="text/css" media="all"/>
<#--<link href="../images/css/product-to-third.css" rel="stylesheet" type="text/css" media="all"/>-->
<#--<link href="../images/css/translateelement.css" rel="stylesheet" type="text/css" media="all"/>-->

<link href="../images/css/header-all.css" rel="stylesheet" type="text/css" media="all" />

<div class="detail-page">
    <div class="en-us">
      <div class="ui-breadcrumb"> 
      <a rel="nofollow" href="<@ofbizUrl>main</@ofbizUrl>">${uiLabelMap.PortalHome}</a> <span class="divider">&gt;</span> 
	  <#-- <a href="#">${uiLabelMap.PortalAllCategories}</a> <span class="divider">&gt;</span> -->
	  <#if categoryId?has_content>
	  	<#assign catInfo = Static["org.ofbiz.product.category.EbizCategoryContentWrapper"].getProdCatNameByLocale(categoryId, request)?if_exists/>
	  	<#assign prodCatWithLevel = Static["org.ofbiz.ebiz.product.CategoryLevelWorker"].getProductCategoryWithLevel(request,categoryId)?if_exists/>
	  	<#if prodCatWithLevel?has_content>
	  	<#assign parentProductCategory = prodCatWithLevel.getParentProductCategory()?if_exists/>
	    <#assign parentCatInfo = Static["org.ofbiz.product.category.EbizCategoryContentWrapper"].getProdCatNameByLocale(categoryId, request)?if_exists/>
	  	<#-- <a href="<@ofbizCatalogAltUrl productCategoryId=parentProductCategorycategoryId.productCategoryId previousCategoryId=""/>">${parentCatInfo!}</a>
	  	 <span class="divider">&gt;</span> -->
	  	</#if>
	  	<a href="<#if categoryId?has_content><@ofbizCatalogAltUrl productCategoryId=categoryId previousCategoryId="${(parentProductCategory.productCategoryId)!}"/></#if>">
	  
	    <#if catInfo?length gt 64>
	  	${(catInfo[0..42])?if_exists}..
	  	<#else>
	  	${(catInfo)!}
	  	</#if>
	  	
	  	</a> 
      </#if>
      </div>
    </div>

	 <!--skylight-wholesale/promotion/we_top_festival_banner.html -start --><!-- -->
	 <!--skylight-wholesale/promotion/we_top_festival_banner.html -end --> 
	 <div id="base" class="base util-clearfix">
	 <!--coupon1-->
	${setRequestAttribute("optProductStoreId","${(product.primaryProductStoreId)!}")} <!-- 店铺的ID -->
	
	 <!--商品详情页面的 中间部分 分成 3个页面   这是top -->  
	    ${screens.render("component://portal/widget/CatalogScreens.xml#showProTop" )} 
	 <!--商品详情页面的 中间部分 分成 3个页面   这是top  end -->  
	 
	
	 	<div id="magnet-plug"></div>
		 <div id="extend" class="extend util-clearfix">
		 
		 <div class="col-main">
		  <!--商品详情页面的 中间部分 分成 3个页面   这是Right -->  
		    ${screens.render("component://portal/widget/CatalogScreens.xml#showProRight" )} 
		 <!--商品详情页面的 中间部分 分成 3个页面   这是Right end -->  
		 </div> 
		 
		 <!--商品详情页面的 中间部分 分成 3个页面   这是left -->		 	
		    ${screens.render("component://portal/widget/CatalogScreens.xml#showProLeft" )} 
		 <!--商品详情页面的 中间部分 分成 3个页面   这是left end -->  
		 </div>
	 
	 </div>
</div>
<!-- 登录页面-->
<#include "component://portal/webapp/portal/product/userlogin.ftl" />



