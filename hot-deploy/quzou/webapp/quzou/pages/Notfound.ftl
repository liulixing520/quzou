<div class="notFoundMain">
	<div><img src="/ofcupload/images/images/common/404.jpg" style="width:100%;height:100%;"/></div>
	<div class="countdown"><span class="col_f83976 number">5</span>　秒后，返回首页</div>
	<#--<div class="errorTips">
		<textarea style="width:1012px;min-height:300px;"></textarea>
	</div>-->
</div>

<script type="text/javascript">
/*function setHeight(){
	var scrollHight = $(window).scrollTop();
	var winHight = $(window).height();
	var winWidth = $(window).width();
	var _height = winHight - 141;
	$(".notFoundMain").height(_height).width(winWidth + "px");
}
setHeight();
	
$(function(){	
	$(window).resize(function(){
		setHeight();
	});
});*/
var i = $(".countdown .number").text();
(function(){
    var args = arguments;
    setTimeout(function(){
       $(".countdown .number").text(i);
        if(--i === 0){
            window.location.href = "findProduct";
        }
        args.callee();
    },1000);
})();
</script>
