<div class="nav_wrap">
    <div class="nav">
        <div class="wrap">
            <ul class="nav_ul fl navUlInfo">
                <li class="cur" data-url="addProduct.html"><a href="basicsInfo.html">产品</a></li>
                <li data-url="addProduct.html"><a href="projectBasicsInfo.html">项目</a></li>
                <li data-url="addProduct.html"><a href="treatmentBasicsInfo.html">疗程</a></li>
                <li data-url="addProduct.html"><a href="schemeBasicsInfo.html">方案</a></li>
                <li data-url="addProduct.html"><a href="consumablesBasicsInfo.html">消耗品</a></li>
                <li data-url="addProduct.html"><a href="fixedBasicsInfo.html">固定资产</a></li>
            </ul>
            <div class="nav_r ri tr navTarget" data-text="+建立"><a href="addProduct.html"></a></div>
        </div>
    </div>
</div>

<script type="text/javascript">
	$(function(){
			$(".nav").tiptop();
			
			var text = $(".navTarget").data("text");
			
			function getNavInfo(){
				var r = {"text": "", "url": ""};
				
				$(".navUlInfo li").each(function() {
					if($(this).hasClass("cur")) {
						r.text = $(this).text();
						r.url = $(this).data("url");
						
						return false;
					}
				});
				
				return r;
			}
			
			var r = getNavInfo();
			
			$(".navTarget a").text(text+r.text).attr("href", r.url);
	});
</script>

