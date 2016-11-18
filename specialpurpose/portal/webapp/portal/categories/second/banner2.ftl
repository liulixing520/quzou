<script src="/portal/images/js/jquery.min.js" type="text/javascript"></script>
<script src="/portal/images/js/jquery-powerSwitch.js" type="text/javascript"></script>
<script src="/portal/images/js/jquery-powerSwitch-min.js" type="text/javascript"></script>
<link rel="stylesheet" href="/portal/categories/second/css/lbgg.css">

<!--<div style="position: relative; overflow: hidden;" data-config="{'showWay':2}" class="slider-box">
    <div style="position: relative; height: 220px; width: 10000px; left: -790px;" class="slider-main">
        <div style="position: absolute; top: 0px; left: 0px;" class="slider-item">
            <a href="">
                <img width="985" height="220" src="../categories/second/images/TB1asp2FVXXXXb.XXXXTvAHMXXX-790-220.jpg">
            </a>
        </div>
        <div style="position: absolute; top: 0px; left: 985px;" class="slider-item current">
            <a href=""><img width="985" height="220" src="../categories/second/images/790x220_130117_e.jpg"></a>
        </div>
        <div style="position: absolute; top: 0px; left: 1970px;" class="slider-item">
            <a href=""><img width="985" height="220" src="../categories/second/images/banner790x220.jpg"></a>
        </div>
        <div style="position: absolute; top: 0px; left: 2955px;" class="slider-item">
            <a href=""><img width="985" height="220" src="../categories/second/images/790x220.jpg"></a>
        </div>
    </div>
    <div class="slider-nav"><a href="">1</a><a href="">2</a><a href="">3</a><a href="">4</a></div>
</div>-->
<style>
.zxx_constr{width:983px; height:220px; margin-left:0px;}
.jd_body{width:983px; height:220px;}
.jd_ad_slide{width:983px; height:220px;}
.jd_ad_img{width:983px; height:220px;}
</style>

<#assign secondCatList = Static["org.ofbiz.product.category.CategoryWorker"].getRelatedCategoriesRet(request, "secondCatList", productCategoryId, true)>

<#if secondCatList?has_content>
<#assign productIndex = 1>
<div class="zxx_body">
	<div class="zxx_constr">
    	<!--  body of jd.html -->
        <div class="jd_body">
        	<div id="jdAdSlide" class="jd_ad_slide">
        	 <#list secondCatList as secondCat>
        	 <#assign linkImageUrl = secondCat.linkOneImageUrl?if_exists>
             <#if !linkImageUrl?string?has_content><#assign linkImageUrl = "../../images/noPhoto.png"></#if>
        	     <#if productIndex<=2>
	        	    <#if productIndex = 1 >
	            	<img  src="${linkImageUrl}" class="jd_ad_img" onclick="javascript:window.location.href='<@ofbizCatalogAltUrl productCategoryId=secondCat.productCategoryId/>'"  style="cursor:pointer">
	                <#else>
	                <img  data-src="${linkImageUrl}" class="jd_ad_img"  onclick="javascript:window.location.href='<@ofbizCatalogAltUrl productCategoryId=secondCat.productCategoryId/>'"  style="cursor:pointer">
	                </#if>
	             </#if>   
	             <#assign productIndex = productIndex + 1>
             </#list>
                <div id="jdAdBtn" class="jd_ad_btn"></div><!-- add active -->
            </div>
        </div>
    </div>
</div>
</#if>

<script>
function tiaozhuan(url){
	location.herf=url;
}
// 大的图片广告
// 根据图片创建id,按钮元素等，实际开发建议使用JSON数据类似
var htmlAdBtn = '';
$("#jdAdSlide img").each(function(index, image) {
	var id = "adImage" + index;
	htmlAdBtn = htmlAdBtn + '<a href="javascript:" class="jd_ad_btn_a" data-rel="'+ id +'">'+ (index + 1) +'</a>';
	image.id = id;
});
$("#jdAdBtn").html(htmlAdBtn).find("a").powerSwitch({
	eventType: "hover",
	classAdd: "active",
	animation: "fade",
	autoTime: 5000,
	onSwitch: function(image) {
		if (!image.attr("src")) {
			image.attr("src", image.attr("data-src"));	
		}
	}
}).eq(0).trigger("mouseover");

// 便民服务
$("#servNav a").powerSwitch({
	classAdd: "active",
	eventType: "hover",
	onSwitch: function() {
		$("#pointLine").animate({ "left": $(this).position().left}, 200);
	}
});
</script>



<!--
<div class="slider-list">
    <ul>
        <li>
            <div class="g-pic"><a href="">
                <img alt="Pipo M9" src="<@ofbizUrl>../categories/second/images/m9.jpg</@ofbizUrl>"></a>
            </div>
            <span class="g-name"><a href=""><font>雅M9</font></a></span>
            <span class="g-detail"><font>10。 英寸RK3188 ARM cortex - a9四核1.6 ghz</font></span></li>
        <li>
            <div class="g-pic"><a href="">
                <img alt="Bitcoin Miner" src="<@ofbizUrl>../categories/second/images/bit.jpg</@ofbizUrl>"></a>
            </div>
            <span class="g-name"><a href=""><font>比特币商</font></a></span>
            <span class="g-detail"><font>比特币采矿机</font></span></li>
        <li>
            <div class="g-pic"><a href="">
                <img alt="Ainol Novo 8 Dream" src="<@ofbizUrl>../categories/second/images/novol_8.JPG</@ofbizUrl>"></a>
            </div>
            <span class="g-name"><a href=""><font>Ainol Novo 8梦想</font></a></span>
            <span class="g-detail"><font>8.0英寸的行动ATM7029四核心1.5 ghz</font></span></li>
    </ul>
</div>
-->

<!--<div class="slider-list">
<ul>
    <#if productIds?has_content>
      	<#list productIds as productId>
        <li>
        	${setRequestAttribute("optProductId",productId)}
            ${screens.render("component://portal/widget/SecondCategoriesScreens.xml#Banner3")}
        </li>
        </#list>
    </#if>
</ul> -->