<div class="mod bestselling-area" id="weekly-bestsellings">
<div class="mod-hd">
    <h3>${uiLabelMap.PortalBestSelling}</h3>
</div>
<div class="mod-box">
<div class="ui-slidebox util-clearfix" data-widget-cid="widget-39">
<div class="ui-slidebox-wrap">
<div class="ui-slidebox-container">
<div class="ui-slidebox-slider" data-role="slider" style="margin-left: 0px;">



<ul id="sellingGoodsRoll">
<#if productIds?has_content>
	<#assign productIndex = 1>
	<#list productIds as productCategoryMember>
		<li style="width: 180px; visibility: visible;">
		${setRequestAttribute("optProductId", productCategoryMember)}
		${setRequestAttribute("productIndex", productIndex)}
		${screens.render("component://portal/widget/CatalogScreens.xml#productsummaryForWeekly")}
		</li>
		<#assign productIndex = productIndex + 1>
	</#list>
</#if>
</ul>
</div>
</div>
</div>
<div class="ui-slidebox-prev" style="">
    <a class="" href="javascript:void(0)" data-role="prev" onclick="leftRun();">
        <span>上一个</span>
    </a>
</div>
<div class="ui-slidebox-next" style="">
    <a class="" href="javascript:void(0)" data-role="next" onclick="rightRun();">
        <span>下一个</span>
    </a>
</div>
</div>
</div>

</div>

<script>
    var show = 0;
    var everyW=180;	//每个商品的宽度
    var everyN=5;	//每次滑动几格
    var sellingGoodsRollWidth=document.getElementById("sellingGoodsRoll").offsetWidth;
    var sellingGoodsRollW=everyW*5*-1
    function rightRun(){
    if((sellingGoodsRollWidth*-1)>sellingGoodsRollW){
       	return;
       }
      show-=everyW*everyN;
      if(show<=sellingGoodsRollW){
      	show=sellingGoodsRollW;
      }
      document.getElementById("sellingGoodsRoll").style.marginLeft = show+"px";
   }
    function leftRun(){
        if((sellingGoodsRollWidth*-1)>sellingGoodsRollW){
       	return;
       }
      show+=everyW*everyN;
      if(show>=0){
      show=0;
      }
      document.getElementById("sellingGoodsRoll").style.marginLeft= show+"px";
   }
</script>
                    