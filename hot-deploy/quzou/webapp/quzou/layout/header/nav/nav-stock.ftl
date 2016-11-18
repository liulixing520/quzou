<div class="nav_wrap">
    <div class="nav clearfix">
        <div class="wrap">
            <ul class="nav_ul fl goods_nav navUlInfo">
                <li class="cur"><a href="orderGoods.html">进货</a></li>
                <li><a href="returnGoods">退货</a></li>
                <li><a href="useGoods.html">领用</a></li>
                <li><a href="damage.html">报损</a></li>
                 <li><a href="budan.html">补单</a></li>
                <li><a href="inventory.html">盘点</a></li>
                <li><a href="Stock.html">库存</a></li>
                <li><a href="#">结存</a></li>
            </ul>
            <div class="nav_r ri tr navTarget" data-text="+添加"><a href="#" id="new"></a></div>
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