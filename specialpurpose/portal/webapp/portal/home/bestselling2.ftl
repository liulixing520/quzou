
<!--推荐品类-->
<div class="tuijian2">
    <div class="mod-hd">
        <h3>${uiLabelMap.PortalRecommendCategory!}</h3>
    </div>
    <div class="bestSelling clearfix">
        <ul class="clearfix clearfix2">
        	<#if list?has_content>
        		<#list list as parentCategory>
        			<li>
        				<#assign smallImageUrl = parentCategory.parentCategory.categoryImageUrl?if_exists>
    					<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
                			<div class="bs-pro-img">
                    			<img width="170" height="170" src="${smallImageUrl}">
                			</div>
                			<#assign catInfo = Static["org.ofbiz.product.category.EbizCategoryContentWrapper"].getProdCatNameByLocale(parentCategory.parentCategory, request)/>
                		<p class="bs-pro-piece3" style="font-weight:bold; color:#000;">${catInfo!}</p>
                		<#list parentCategory.categoryList as category>
                				<a style="padding:0;" href="<@ofbizCatalogAltUrl productCategoryId='${category.productCategoryId}' previousCategoryId='${category.primaryParentCategoryId}'/>">
                					<#assign catInfo = Static["org.ofbiz.product.category.EbizCategoryContentWrapper"].getProdCatNameByLocale(category, request)/>
                					<p class="bs-pro-piece3">${catInfo!}</p>
                				</a>
                		</#list>
                		
                	</li>
        		</#list>
        	</#if>
        </ul>
    </div>
  </div>
