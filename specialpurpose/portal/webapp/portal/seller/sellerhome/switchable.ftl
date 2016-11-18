<script src="/portal/images/js/jquery.min.js" type="text/javascript"></script>
<script src="/portal/images/js/jquery-powerSwitch.js" type="text/javascript"></script>
<script src="/portal/images/js/jquery-powerSwitch-min.js" type="text/javascript"></script>
<link rel="stylesheet" href="/portal/categories/second/css/lbgg.css">

<style>
.zxx_body .zxx_constr {width: 1210px;}
</style>
<div class="zxx_body">
	<div class="zxx_constr">
    	<!--  body of jd.html -->
        <div class="jd_body">
        	<div id="jdAdSlide" class="jd_ad_slide">
            	<img  src="<@ofbizUrl>../categories/second/images/TB1asp2FVXXXXb.XXXXTvAHMXXX-790-220.jpg</@ofbizUrl>" class="jd_ad_img">
                <img  data-src="<@ofbizUrl>../categories/second/images/790x220_130117_e.jpg</@ofbizUrl>" class="jd_ad_img">
                <img  data-src="<@ofbizUrl>../categories/second/images/banner790x220.jpg</@ofbizUrl>" class="jd_ad_img">
                <img data-src="<@ofbizUrl>../categories/second/images/790x220.jpg</@ofbizUrl>" class="jd_ad_img">
                <div id="jdAdBtn" class="jd_ad_btn"></div><!-- add active -->
            </div>
        </div>
    </div>
</div>

<script>
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
<ol class="slide-pics clearfix ui-switchable-content"
    style="position: relative; width: 3579119px; left: -960px;">
    <li class="ui-switchable-panel" style="float: left;">
        <a href="http://www.aliexpress.com/store/group/HUAWEI/609089_256813077.html"><img
                src="http://img.alibaba.com/kf/HTB1oQ3XFVXXXXcWXpXXq6xXFXXXI.jpg" alt=""></a>
    </li>
    <li class="ui-switchable-panel" style="float: left;">
        <a href="http://www.aliexpress.com/store/product/Original-THL-5000-Mobile-Phone-MTK6592-Octa-Core-2GHz-Android-5-1080P-IPS-Coning-Gorilla-Glass/609089_1979072899.html"><img
                src="http://img.alibaba.com/kf/HTB1NQDWFVXXXXcqXVXXq6xXFXXXT.jpg" alt=""></a>
    </li>
    <li class="ui-switchable-panel" style="float: left;">
        <a href="http://www.aliexpress.com/store/group/Original-Brand-Xiaomi-Meizu-ZTE/609089_251187740.html"><img
                src="http://img.alibaba.com/kf/HT1srfIFBtXXXagOFbXs.jpg" alt=""></a>
    </li>
    <li class="ui-switchable-panel" style="float: left;">
        <a href="http://www.aliexpress.com/store/group/Original-Brand-THL/609089_100085528.html"><img
                src="http://img.alibaba.com/kf/HT1sTOoFNhcXXagOFbXo.jpg" alt=""></a>
    </li>
    <li class="ui-switchable-panel" style="float: left;">
        <a href="http://www.aliexpress.com/store/group/Original-Brand-JIAYU/609089_100085529.html"><img
                src="http://img.alibaba.com/kf/HT1bnGyFRJXXXagOFbXf.jpg" alt=""></a>
    </li>
</ol>
<a href="javascript:;" class="prev-btn ui-switchable-prev-btn"></a>
<a href="javascript:;" class="next-btn ui-switchable-next-btn"></a>
<ul class="ui-switchable-nav">
    <li class="ui-switchable-trigger"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-97"
                                            rel="97">1
    </font></li>
    <li class="ui-switchable-trigger ui-switchable-active"><font class="OUTFOX_JTR_TRANS_NODE"
                                                                 id="OUTFOX_JTR_TRANS_NODE-98" rel="98">2
    </font></li>
    <li class="ui-switchable-trigger"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-99"
                                            rel="99">3
    </font></li>
    <li class="ui-switchable-trigger"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-100"
                                            rel="100">4
    </font></li>
    <li class="ui-switchable-trigger"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-101"
                                            rel="101">5
    </font></li>
</ul>-->