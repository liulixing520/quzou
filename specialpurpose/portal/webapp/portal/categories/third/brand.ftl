<div class="col-main">
    <div class="main-wrap " id="main-wrap">
        <style type="text/css">
            .narrow-down-bg {
                margin-right: 10px
            }
        </style>
        <div id="hot-tag" class="hot-tag util-clearfix">
        <#assign refList = delegator.findByAnd("CategoryRefTypeAttribute", {"productCategoryId" : productCategory.productCategoryId}) />
        <#list refList as ref>
			<#assign attr = delegator.findByPrimaryKey("TypeAttribute", {"attributeId" : ref.attributeId}) />
			<#if "SELECT"==attr.entryWay>
				<span class="hot-tag-title">${attr.attributeName}:</span>
				<span class="hot-tag-list show-more" style='height:30px'>
				<#assign attrOptions = delegator.findByAnd("AttrOptionalValue", {"attributeId" : attr.attributeId})>
				<#if attrOptions?has_content>
					<#list attrOptions as e>
						<a href="${e.optionalId!}" class="tag-items "><span>${e.optionalName!}</span></a>
					</#list>
				</#if>	
				</span>
			</#if>
		</#list>	
		 <#assign productFeatureCategoryApplList = delegator.findByAnd("ProductFeatureCategoryAppl", {"productCategoryId" : productCategory.productCategoryId}) />
		<#list productFeatureCategoryApplList as featureCategory>
			<#assign featureCategoryGeneriv = featureCategory.getRelatedOne("ProductFeatureCategory")?if_exists>
			<#assign productFeatures = featureCategoryGeneriv.getRelated("ProductFeature", Static["org.ofbiz.base.util.UtilMisc"].toList("defaultSequenceNum"))>
			<span class="hot-tag-title">${featureCategoryGeneriv.description}:</span>
				<span class="hot-tag-list show-more" style='height:30px'>
				<#if productFeatures?has_content>
					<#list productFeatures as pf>
						<a href="${pf.productFeatureId!}" class="tag-items "><span>${pf.description!}</span></a>
					</#list>
				</#if>	
				</span>						
		</#list>	
        <i style="display: inline;" class="hot-tag-view-more hidden-more"></i>
</div>
        <div data-widget-cid="widget-59" id="view-filter" class="view-filter">
        <#assign eavAttrnameUrl=Static["org.ofbiz.ebiz.product.ProductCategoryCondFilter"].getFullRequestUrl(request,productCategory.productCategoryId,"orderByName")/>
            <div class="narrow-down-bg"><a href="${eavAttrnameUrl!}"><span
                    class="best-match-on"><font>${uiLabelMap.PortalGoods111Cf}</font></span></a></div>
            <div class="narrow-down-bg"><a href="${eavAttrnameUrl!}&orderByName=totalQuantityOrdered"><span
                    class="narrow-down"><font>${uiLabelMap.PortalGoods222Cf}</font></span></a></div>
            <!--<div class="narrow-down-bg"><a href=""><span class="narrow-down"><font>新品</font></span></a></div>-->
            <div class="narrow-down-bg"><a href="${eavAttrnameUrl!}&orderByName=introductionDate"><span
                    class="narrow-down"><font>${uiLabelMap.PortalGoods333Cf}</font></span></a></div>
            <div class="narrow-down-bg"><a href="${eavAttrnameUrl!}&orderByName=defaultPrice"><span
                    class="narrow-price"><font>${uiLabelMap.PortalPriceCf}</font></span></a></div>
            <a style="display: none;" id="narrow-down-close" class="narrow-close-btn" href="javascript:void(0)"> </a>
        </div>
        <!--产品列表-->
        <div id="proList" class="prolist">

        <#if productIds?has_content>
          <#list productIds as productId>
        ${setRequestAttribute("optProductId",productId)}
        ${screens.render("component://portal/widget/CatalogScreens.xml#productsummaryCatThird")}
        ${setRequestAttribute("optProductId","")}
        </#list>
          </#if>
        </div>

        <!--end-->
        <!--分页-->
        <div class="page">
            <#if viewSize?has_content && (viewSize > 10)>
                <#assign varViewSize=viewSize>

                <#assign totalPage=((listSize!0)/(varViewSize!10))?ceiling>
                <#assign eavVIEW_SIZEUrl=Static["org.ofbiz.ebiz.product.ProductCategoryCondFilter"].getFullRequestUrl(request,"${(productCategory.productCategoryId)!}","VIEW_INDEX")/>
                <span class="unpre"></span>
                <span class="pagelist">
                    <#list 1..totalPage as curViewNum>
                      <#if (curViewNum<21)>
                        <@anchorEachPage vPaginaUrl=eavVIEW_SIZEUrl vTotalPage=totalPage varViewIndex=curViewNum curViewIndex=viewIndex/>
                    <#else>

                    </#if>
                    </#list>
                </span>
                <a class="next" href=""></a>
            </#if>
        </div>

    <#macro anchorEachPage vPaginaUrl vTotalPage varViewIndex curViewIndex>
        <#if (varViewIndex==curViewIndex)>
            <#assign vFontDisp="<b><font>${varViewIndex}</font></b>"/>
        <#else>
            <#assign vFontDisp="<font>${varViewIndex}</font>"/>
        </#if>
        <#if (vTotalPage >= varViewIndex)>
            <a href="${vPaginaUrl!}&VIEW_INDEX=${varViewIndex}">${vFontDisp!}</a>
        </#if>
    </#macro>
    <#--分页 end-->

    <#--猜您喜欢-->
    ${screens.render("component://portal/widget/thirdCategoriesScreens.xml#thirdPopular")}
    <#--猜您喜欢 end-->

    </div>
</div>