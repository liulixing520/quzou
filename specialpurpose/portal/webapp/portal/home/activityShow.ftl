<div class="activity-show-main">
    <div id="key-visual-wrap" data-spm="5809261" class="sub-visual-expand"
         data-widget-cid="widget-37">
        <!--TMS:1086189-->
        <div id="sub-visual" data-role="sub" class="hidden-sm hidden-md">
        	 <#assign categoryText = delegator.findOne("ProductCategory", {"productCategoryId" : "C002003"}, true)>
        	<#assign smallImageUrl = categoryText.categoryImageUrl?if_exists>
        	<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
            <a href="<@ofbizCatalogAltUrl productCategoryId="C002003" previousCategoryId="C002"/>"><img src="${smallImageUrl}" width="209" height="116">
                <span><b>${categoryText.description?if_exists}</b></span><!--<i>从20%</i>-->
            </a>
        	<#assign categoryText = delegator.findOne("ProductCategory", {"productCategoryId" : "C001003"}, true)?if_exists>
        	<#assign smallImageUrl = (categoryText.categoryImageUrl)?if_exists>
        	<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
            <a href="<@ofbizCatalogAltUrl productCategoryId="C001003" previousCategoryId="C001"/>"><img src="${smallImageUrl}" width="209" height="116">
                <span style="top: 94px;"><b>${categoryText.description?if_exists}</b></span>
            </a>
            <#assign categoryText = delegator.findOne("ProductCategory", {"productCategoryId" : "C001002"}, true)>
        	<#assign smallImageUrl = categoryText.categoryImageUrl?if_exists>
        	<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
            <a href="<@ofbizCatalogAltUrl productCategoryId="C001002" previousCategoryId="C001"/>"><img src="${smallImageUrl}" width="209" height="116">
                <span><b>${categoryText.description?if_exists}</b></span>
            </a>
           
           
        </div>
        <a style="overflow: hidden;"></a>

       <!--  <div id="key-visual" data-role="key" class="ui-switchable">
            <ul class="key-visual-content ui-switchable-content"
                style="position: relative; width: 3579119px; left: -1530px;">
                <li id="new-user-banner" style="float: left;" class="ui-switchable-panel">
                    <a href=""><img alt="new user guide" src="../images/510x370_130916_newbuyer.jpg" width="510"
                                    height="370"></a>
                </li>
                <li class="ui-switchable-panel" style="float: left;">
                    <a href=""><img alt="" src="../images/TB1C6uiGFXXXXc5XpXXZ_bnPFXX-510-370.jpg" width="510"
                                    height="370"></a>
                </li>
                <li class="ui-switchable-panel" style="float: left;">
                    <a href=""><img alt="" src="../images/TB19.R5GFXXXXXVXVXXZ_bnPFXX-510-370.jpg" width="510"
                                    height="370"></a>
                </li>
                <li class="ui-switchable-panel" style="float: left;">
                    <a href=""><img alt="" src="../images/TB1J34SGFXXXXXKXFXXZ_bnPFXX-510-370.jpg" width="510"
                                    height="370"></a>
                </li>
            </ul>
            <a class="ui-switchable-prev-btn" data-role="prev" style="display: none;"></a>
            <a class="ui-switchable-next-btn" data-role="next" style="display: none;"></a>
            <ul class="ui-switchable-nav">
                <li class="ui-switchable-trigger ui-switchable-active"></li>
                <li class="ui-switchable-trigger"></li>
                <li class="ui-switchable-trigger"></li>
                <li class="ui-switchable-trigger"></li>
                <li class="ui-switchable-trigger"></li>
            </ul>
        </div>  -->
 
 <!--start--->
<link href="../images/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../images/js/jquery.jqzoom.js"></script>
<script type="text/javascript">
$(function(){ 
	var oDiv = $("#play");  //外部盒子
	var count = $("#play ul li").length;  //内部图片数量
	var countwidth = $("#play ul li").width();  //图片边框宽度
	var oUl = $("#play ul").css("width",count*countwidth);  //ul li总宽度
	var now = 0;
	var next = $("#next");
	var prev = $("#prev");
	//点击按钮数量
	for(var i = 0; i < count; i++){
		$("#play ol").append("<li>" + Number(i+1) + "</li>");
		$("#play ol li:first").addClass("active");
	}
	//左右点击图片获取
	var nI = $("#play ul li:nth-child(2)").find("img").attr("src");
	$(".nextImg img").attr("src",nI);
	var pI = $("#play ul li:last-child").find("img").attr("src");
	$(".prevImg img").attr("src",pI);
	//按钮点击事件
	var aBtn = $("#play ol li");
	aBtn.each(function(index){
		$(this).click(function(){
			clearInterval(timer);
			tab(index);
			nextImg();
			prevImg();
			timer=setInterval(autoRun,auto);
		});
	});
	//图片循环事件
	function tab(index){
		now = index;
		aBtn.removeClass("active");
		aBtn.eq(index).addClass("active");
		oUl.stop(true,false).animate({"left":-510 * now},400);
	}
	//下一张按钮图片切换
	function nextImg(){
		var d = $("#play ul li").find("img").eq(now+1).attr("src");
		var nI = $("#play ul li:nth-child(1)").find("img").attr("src");
		$(".nextImg").find("img").attr("src",d);
		if(now==count-1){
			$(".nextImg").find("img").attr("src",nI);
		}
	}
	//上一张图片按钮切换
	function prevImg(){
		var f = $("#play ul li").find("img").eq(now-1).attr("src");
		$(".prevImg").find("img").attr("src",f);
	}
	
	//下一张点击事件
	next.click(function(){
		clearInterval(timer);
		now++;
		if(now==count){
			now=0;
		}
		tab(now);
		nextImg();
		prevImg();
		timer=setInterval(autoRun, 2000);
	});
	//上一张点击事件
	prev.click(function(){
		clearInterval(timer);
		now--;
		if(now==-1){
			now=count-1;
		}
		tab(now);
		nextImg();
		prevImg();
		timer=setInterval(autoRun, 2000);
	});
	//自动轮播定义
	function autoRun(){
		now++;
		if(now==count){
			now=0;
		}
		tab(now);
		nextImg();
		prevImg();
	};

	var timer=setInterval(autoRun, 2000);
});
</script>

<div id="key-visual" data-role="key" class="ui-switchable">
		<div class="play" id="play">
	       <a href="javascript:void" id="next"><img src="../images/left.png" /></a>
           <a href="javascript:void" id="prev"><img src="../images/right.png" /></a>
		    <ol>
		    </ol>
		    <#if homeSlideContents?has_content>
			    <ul>
		    	  <!-- from ContentAssoc -->
		    		<#list homeSlideContents as slideContent>
		    			<#assign toContent = slideContent.getRelatedOne("ToContent")>
		    			<li> <a  href="${toContent.description!}"><img src="${toContent.contentName!}"/></a></li>
		    		</#list>
		    	</ul>
		    <#else>
			<ul>
                 <li> <a  href="<@ofbizCatalogAltUrl productCategoryId="C001003001" previousCategoryId="C001003"/>"> <img  src="../images/banneren005.jpg" /> </a> </li>
                 <li> <a  href="<@ofbizCatalogAltUrl productCategoryId="C005003004" previousCategoryId="C005003"/>"> <img  src="../images/banneren002.jpg" /> </a> </li>
                 <li> <a  href="<@ofbizCatalogAltUrl productCategoryId="C002002011" previousCategoryId="C002002"/>"> <img  src="../images/banneren003.jpg" /> </a> </li>
                 <li> <a  href="<@ofbizCatalogAltUrl productCategoryId="C008001" previousCategoryId="C008"/>"> <img  src="../images/banneren004.jpg" /> </a> </li>
                 <li> <a  href="<@ofbizCatalogAltUrl productCategoryId="C002001009" previousCategoryId="C002001"/>"> <img  src="../images/banne-en01r.jpg" /> </a> </li>
			</ul>
			</#if>
		</div>
	
</div>
 <!-- end -->
 
 
 
 
    </div>
</div>