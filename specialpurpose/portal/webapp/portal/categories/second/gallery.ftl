
<#assign secondCatList = Static["org.ofbiz.product.category.CategoryWorker"].getRelatedCategoriesRet(request, "secondCatList", productCategoryId, true)>

<#if secondCatList?has_content>
<#assign productIndex = 1>
    <#list secondCatList as secondCat>
       <#if productIndex <= 3>
    	<#assign catInfo = Static["org.ofbiz.product.category.EbizCategoryContentWrapper"].getProdCatNameByLocale(secondCat, request)/>
	     <div class="omod-title-bar-b-3px clearfix" style="width:982px;">
	      <h2 class="c_title_bar">
	        <span class="c_title"><font>${(catInfo)!}</font></span>
	      </h2>
	    </div>
           ${setRequestAttribute("optProductCategoryId",  secondCat.productCategoryId)}   <!-- 得到下一级的分类    ID号  -->
           ${screens.render("component://portal/widget/SecondCategoriesScreensToFor.xml#gallerytoFor")}  <!-- 通过solr方式，   查询分类下的所有 产品  -->
		   ${setRequestAttribute("optProductCategoryId",  "")}
		   <#assign productIndex = productIndex + 1>
		</#if>
       </#list>
</#if>



