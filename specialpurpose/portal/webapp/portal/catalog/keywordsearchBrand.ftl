<style type="text/css">
    .narrow-down-bg{ margin-right:10px }
</style>
    <div class="col-main">
      <div class="main-wrap " id="main-wrap">
<#--        <form action="/wholesale" method="get" id="narrow-form">
          <input type="hidden" value="us" name="shipCountry" id="shipCountry">
          <input type="hidden" value="" name="shipCompanies" id="shipCompanies">
          <input type="hidden" value="100005062" name="CatId" id="narrowDownCate">
        </form>-->
        <div data-widget-cid="widget-59" id="view-filter" class="view-filter"> 

          <#assign eavAttrnameUrl=Static["org.ofbiz.ebiz.product.ProductCategoryCondFilter"].getFullRequestUrl(request,"${(productCategory.productCategoryId)!}","orderByName")/>         

          <div class="narrow-down-bg"><a href="${eavAttrnameUrl!}"><span class="best-match-on"><font>${uiLabelMap.PortalGoods111Cf}</font></span></a></div>
          <div class="narrow-down-bg"><a href="${eavAttrnameUrl!}&orderByName=totalQuantityOrdered"><span class="narrow-down"><font>${uiLabelMap.PortalGoods222Cf}</font></span></a></div>
          <!--<div class="narrow-down-bg"><a href=""><span class="narrow-down"><font>新品</font></span></a></div>-->
          <div class="narrow-down-bg"><a href="${eavAttrnameUrl!}&orderByName=introductionDate"><span class="narrow-down"><font>${uiLabelMap.PortalGoods333Cf}</font></span></a></div>
          <div class="narrow-down-bg"><a href="${eavAttrnameUrl!}&orderByName=defaultPrice"><span class="narrow-price"><font>${uiLabelMap.PortalPriceCf}</font></span></a></div>
          <a style="display: none;" id="narrow-down-close" class="narrow-close-btn" href="javascript:void(0)"> </a> 
          
          <div class="narrow-down-bg"><a href="${eavAttrnameUrl!}&orderByName=defaultPrice"><span class="narrow-price"><font>发货地</font></span></a></div>
          <a style="display: none;" id="narrow-down-close" class="narrow-close-btn" href="javascript:void(0)"> </a> 
          </div>
        <!--产品列表-->
        <div id="proList" class="prolist">
          <#if productIds?has_content>
          <#list productIds as productId>
          	${setRequestAttribute("optProductId",productId)}
          	${screens.render("component://portal/widget/CatalogScreens.xml#productsummaryCatThird")}
          </#list>
          </#if>
        </div>
        <!--分页-->
        <div class="page">					
        <#if viewSize?has_content && (viewSize!=0)>
        	<#assign varViewSize=viewSize>
        </#if>
        <#assign totalPage=((listSize!0)/(varViewSize!10))?ceiling>
        <#assign eavVIEW_SIZEUrl=Static["org.ofbiz.ebiz.product.ProductCategoryCondFilter"].getFullRequestUrl(request,"${(productCategory.productCategoryId)!}","VIEW_INDEX")/>       				
        <span class="unpre"></span><span class="pagelist">
        <#list 1..totalPage as curViewNum>
            <#if curViewNum<21>
              <@anchorEachPage vPaginaUrl=eavVIEW_SIZEUrl vTotalPage=totalPage varViewIndex=curViewNum curViewIndex=viewIndex/>

            </#if>
        </#list>
        </span><a class="next" href=""></a>
        </div>
        <#macro anchorEachPage vPaginaUrl vTotalPage varViewIndex curViewIndex>
        	<#if (varViewIndex==curViewIndex)>
        		<#assign vFontDisp="<b><font>${varViewIndex}</font></b>"/>
        	<#else>
        		<#assign vFontDisp="<font>${varViewIndex}</font>"/>
        	</#if>
        	<#if (vTotalPage >= varViewIndex)>
	        	<#if (varViewIndex<21)>
	        	<a href="${vPaginaUrl!}&VIEW_INDEX=${varViewIndex}">${vFontDisp!}</a>
	        	</#if>
        	</#if>
        </#macro>
        <#--分页 end-->
        <#--猜您喜欢-->
    	${screens.render("component://portal/widget/thirdCategoriesScreens.xml#thirdPopular")}
        <#--猜您喜欢 end-->
      </div>
    </div>