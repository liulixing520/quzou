
<link rel="apple-touch-icon-precomposed" href="/mobileStore/images/imgs/apple-touch-icon.png?v=20141231">
<script type="text/javascript">
	var _winLocation=window.location.href;//获得当前页面的路径，根据路径规则进行逐页替换
	var _isWebKit = '__proto__' in {};//是否是webkit内核
	if(_isWebKit){//如果是webkit内核，则分模块使用zepto
		//要使用zeptojs的路径列表，可以做为分模块替换的开关
		var _locationList=new Array();
		//活动模块
		_locationList.push('/activity/proActList');
		_locationList.push('/activity/proActWareList');
		_locationList.push('/activity/list');
		//商品分类模块
		_locationList.push('/category/');
		//京东快讯模块
		_locationList.push('/newslist.html');
		_locationList.push('/newslist/');
		_locationList.push('/news/');
		//机票模块
		_locationList.push('/airline/');
		//酒店模块
		_locationList.push('/hotel/');
		//团购模块
		_locationList.push('/tuan/');
		//首页相关
		_locationList.push('/hotbrand.html');//品牌馆
		//商品筛选相关
		_locationList.push('/ware/expandSort.action');
		_locationList.push('/ware/categoryFilter.action');
		_locationList.push('/ware/search.action');
		_locationList.push('/products/');
		_locationList.push('/index/getWare.action')//热门特惠
		_locationList.push('/notice/');//通告模块
		_locationList.push('/coupons/');//随地惠模块
		_locationList.push('/chongzhi/');//手机充值模块
		_locationList.push('/comment/');//手机推荐模块
		_locationList.push('/pay/');//支付
		_locationList.push('/order/');//订单
		_locationList.push('/norder/');//订单
		//_locationList.push('/market/floorWare.action');//掌上专享
		
		var _needReplace = false;
		//如果当前路径符合要使用的路径规则，则进行替换
		for(var i=0;i<_locationList.length;i++){
			if(_winLocation.indexOf(_locationList[i])!=-1){
				_needReplace=true;
				break;
			}
		}
		//如果是首页的话，则使用zepto
		var _tmp = _winLocation.replace(/(^http:\/\/)|(\/*$)/g,'');
		if(_tmp.indexOf('/')<0 || (_tmp.split('/').length<=2 && _tmp.indexOf('/index')>=0)){
			_needReplace=true;
		}
		//如果是商品详情页的话，则使用zepto
        var _dlocationList=new Array();
        _dlocationList.push(/\/product\/([0-9]+)\.html/);
        _dlocationList.push(/\/orderComment\/([0-9]+)\.html/);
        _dlocationList.push(/\/consultations\/([0-9]+)\.html/);
        _dlocationList.push(/\/consultations\/([0-9]+)-([0-9]+)\.html/);
        _dlocationList.push(/\/comments\/([0-9]+)\.html/);
        for(var i=0,len=_dlocationList.length;i<len;i++){
        	if(_dlocationList[i].test(_winLocation)){
        		_needReplace=true;
       			 break;
       		 }
        }
		if(_needReplace){
			document.write('<script src="/mobileStore/images/js/zepto.min.js?v=20141231"><\/script>');
			document.write('<script type="text/javascript">window.jQuery=window.Zepto;<\/script>');
		}else{
			document.write('<script src="/mobileStore/images/js/jquery-1.6.2.min.js?v=20141231"><\/script>');
		}
	}else{//如果是非webkit内核直接使用jquery
		document.write('<script src="/mobileStore/images/js/jquery-1.6.2.min.js?v=20141231"><\/script>');
	}
</script>
<script src="/mobileStore/images/js/zepto.js"></script><script type="text/javascript">window.jQuery=window.Zepto;</script>
<script type="text/javascript" src="/mobileStore/images/js/common.js"></script>
<script type="text/javascript" src="/mobileStore/images/js/spin.js"></script><style></style>
<script charset="utf-8" type="text/javascript" src="/mobileStore/images/js/installapp.js"></script>

<body class="orderList" id="body">
	<a name="top"></a>
	<header>
		<div class="header w">
			<div class="header-btn fr">
				<a href="http://p.m.jd.com/user/home.action?sid=492d676d6b8c7a712a40a694cd44dfe0">
					<img src="/mobileStore/images/imgs/avatar.png" style="margin-bottom:3px;" height="21" width="22">
				</a>
                <a href="http://m.jd.com/index.html?sid=492d676d6b8c7a712a40a694cd44dfe0">
					<img src="/mobileStore/images/imgs/home.png" style="margin-bottom:3px;"><span></span>
				</a>
    		</div>
    	</div>
	</header>
	<div class="mt" style="text-align:center"><h2>提交订单失败</h2></div>
	<div class="order-tip">
        <h3>${showMsg!}</h3>
	</div>		
    <a class="sub_btn" href="main">返回首页</a>
	<input autocomplete="off" id="sid" value="492d676d6b8c7a712a40a694cd44dfe0" type="hidden">
	<#--><div class="download-con" id="down_app" style="">
		<div class="down_app">
			<div class="download-logo"></div>
			<div class="alogo">
				<p class="client-name">
					下载客户端，随时随地查物流
				</p>
				<p class="client-logon"></p>
			</div>
			<div class="open_now">
				<a id="openJD" href="http://p.m.jd.com/download/downApp.html?sid=492d676d6b8c7a712a40a694cd44dfe0"><span class="open_btn">立即打开</span></a>
			</div>
			<div class="close-btn-con close-btn">
				<span class="close-btn-icon"></span>
			</div>
		</div>
	</div>-->
	<script type="text/javascript" src="/mobileStore/images/js/touch_order_common.js"></script>
	<script>
        $("#body").addClass("orderList");
        initVar('','','','','492d676d6b8c7a712a40a694cd44dfe0');
		
		if(false){
			clearCart();
		}
		
	    if (false && window.androidPad) { //androidpad下单成功清除购物车
             window.androidPad.clearShoppingCart();			 
        }
		function goAndroidPad(){
		     window.androidPad.orderFinish();	
		}
    </script>
	
	   
	<div class="login-area" id="footer">
    	<div class="login">
			<#if userLogin??>
				<a rel="nofollow" href="memberCenter">${(userLogin.userLoginId)!'---'}</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="logout">退出</a>
			<#else>
				<a rel="nofollow" href="login">登录</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="register">注册</a>
			</#if>
			<span class="new-fr"><a href="http://m.jd.com/showvote.html?sid=492d676d6b8c7a712a40a694cd44dfe0">反馈</a><span class="lg-bar">|</span><a href="#top">回到顶部</a></span>
        </div>
		<div class="version">
			<a href="http://wap.jd.com/index.html?v=w&amp;sid=492d676d6b8c7a712a40a694cd44dfe0">标准版</a><a href="javascript:void(0)" class="on">触屏版</a>
			<a href="http://www.jd.com/#m" id="toPcHome">电脑版</a>
		</div>
    	<div id="clientArea">
        	<a href="http://m.jd.com/download/downApp.html?sid=492d676d6b8c7a712a40a694cd44dfe0" id="toClient" class="openJD">客户端</a>
    	</div>
        <div class="copyright">© medref.cn</div>
    </div>

	<div style="display:none;">
		<img src="/mobileStore/images/imgs/ja.gif">
	</div>
	<script type="text/javascript" src="/mobileStore/images/js/ping.js"></script>
	<script type="text/javascript">
	    try{
	        ping.init({"userPin":"242991761-26336401"});
	    }catch(e){
	    }
	</script>
	            
	
	<script type="text/javascript">
	$("#unsupport").hide();
	if(!testLocalStorage()){ //not support html5
	    if(0!=0 && !false && !$teamId){
			$("#html5_cart_num").text(0>0>0);
		}
	}else{
		updateToolBar('');
	}
	
	$("#html5_cart").click(function(){
	//	syncCart('492d676d6b8c7a712a40a694cd44dfe0',true);
		location.href='/cart/cart.action';
	});
	
	function reSearch(){
	var depCity = window.sessionStorage.getItem("airline_depCityName");
		if(testSessionStorage() && isNotBlank(depCity) && !/^\s*$/.test(depCity) && depCity!=""){
	    	var airStr = '<form action="/airline/list.action" method="post" id="reseach">'
	        +'<input type="hidden" name="sid"  value="492d676d6b8c7a712a40a694cd44dfe0"/>'
	        +'<input type="hidden" name="depCity" value="'+ window.sessionStorage.getItem("airline_depCityName") +'"/>'
	        +'<input type="hidden" name="arrCity" value="'+ window.sessionStorage.getItem("airline_arrCityName") +'"/>'
	        +'<input type="hidden" name="depDate" value="'+ window.sessionStorage.getItem("airline_depDate") +'"/>'
	        +'<input type="hidden" name="depTime" value="'+ window.sessionStorage.getItem("airline_depTime") +'"/>'
	        +'<input type="hidden" name="classNo" value="'+ window.sessionStorage.getItem("airline_classNo") +'"/>'
	        +'</form>';
	    	$("body").append(airStr);
	    	$("#reseach").submit();
		}else{
	    	window.location.href='/airline/index.action?sid=492d676d6b8c7a712a40a694cd44dfe0';
		}
	}
	 //banner 关闭点击
	    $('.div_banner_close').click(function(){
	        $('#div_banner_header').unbind('click');
	        jQuery.post('/index/addClientCookieVal.json',function(d){
	              $('#div_banner_header').slideUp(500);
	        });
	    });
	    //banner 下载点击
	    $('.div_banner_download').click(function(){
	         var downloadUrl = $(this).attr('url');
	         jQuery.post('/index/addClientCookieVal.json',function(d){
	               window.location.href=downloadUrl;
	        });
	    });
	    window._clientVersion_ = '';
	    
		$(document).ready(function(){
			var _loadScript = function(url, options,cb){
				var script = document.createElement("script");
				var def = {
					type: "text/javascript",
					charset:"utf-8"
				}
				options= options|| {
				}
				for(var i in options){
					def[i] = options[i];
				}
				script.src = url;
				
				for(var i in def){
					script.setAttribute(i,def[i]);
				}
				script.addEventListener("load",function(){
					cb && cb();
				},false)
				document.getElementsByTagName("head")[0].appendChild(script);
			}
					if($(".download-con").length || $("#clientArea").length){
				_loadScript("/mobileStore/images/js/installapp.js?v=20141231",{},function(){
					 $("#clientArea").length && downcheck($("#clientArea"),false);
				});
			}
					
		})
	</script>
	<iframe style="display: none; width: 0px; height: 0px;"></iframe>
	<iframe style="display: none; width: 0px; height: 0px;"></iframe>
</body>