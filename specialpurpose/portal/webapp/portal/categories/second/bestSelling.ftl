<h3 class="title-bar"><font title="${uiLabelMap.PortalBestSelling?if_exists}">
${uiLabelMap.PortalBestSelling}
</font></h3>
<div class="box-bd">

     ${screens.render("component://portal/widget/SecondCategoriesScreensToFor.xml#bestSellingtoFor")}  <!-- 通过solr方式，   查询分类下的所有 产品  -->
</div>