<link rel="apple-touch-icon-precomposed" href="/mobileStore/images/imgs/apple-touch-icon.png?v=jd2015010420">
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
		_locationList.push('/ware/view.action');
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
		
		_locationList.push('/seckill/');//秒杀
		
		_locationList.push('/sale/act/');//sale
		_locationList.push('/sale/mall/');//sale
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
			document.write('<script src="/mobileStore/images/js/zepto.min.js?v=jd2015010420"><\/script>');
			document.write('<script type="text/javascript">window.jQuery=window.Zepto;<\/script>');
		}else{
			document.write('<script src="/mobileStore/images/js/jquery-1.6.2.min.js?v=jd2015010420"><\/script>');
		}
	}else{//如果是非webkit内核直接使用jquery
		document.write('<script src="/mobileStore/images/js/jquery-1.6.2.min.js?v=jd2015010420"><\/script>');
	}
</script>
<script src="/mobileStore/images/imgs/h5api.htm"></script>
<body style="margin: 0px auto;" id="body">
	<a name="top"></a>
	<header>
		<#--><div class="download-con" id="down_app" style="position: relative;">
			<div class="down_app">
				<div class="download-logo"></div>
				<div class="alogo">
					<p class="client-name">客户端首单满59元送59元！</p>
					<p class="client-logon"></p>
				</div>
				<div class="open_now">
					<a id="openJD" app_href="openApp.jdMobile://virtual?params={&quot;category&quot;:&quot;jump&quot;,&quot;des&quot;:&quot;productDetail&quot;,&quot;skuId&quot;:&quot;652887&quot;,&quot;sourceType&quot;:&quot;JSHOP_SOURCE_TYPE&quot;,&quot;sourceValue&quot;:&quot;JSHOP_SOURCE_VALUE&quot;}" href="http://item.m.jd.com/download/downApp.html?sid=572ca887fd536ebe97b6e2ba8a2a5618"><span class="open_btn">立即打开</span></a>
				</div>
				<div class="close-btn-con close-btn">
					<span class="close-btn-icon"></span>
				</div>
			</div>
		</div>-->
		<div class="new-header">
			<a href="javascript:pageBack();" class="new-a-back" id="backUrl"><span>返回</span></a>
			<h2>详细介绍</h2>
			<a href="javascript:void(0)" id="btnJdkey" class="new-a-jd"><span>京东键</span></a>
		</div>
		<div class="new-jd-tab" style="display:none" id="jdkey">
			<div class="new-tbl-type">
				<a href="http://item.m.jd.com/index.html?sid=572ca887fd536ebe97b6e2ba8a2a5618" class="new-tbl-cell">
					<span class="icon">首页</span>
					<p style="color:#6e6e6e;">首页</p>
				</a>
				<a href="http://m.jd.com/category/all.html?sid=572ca887fd536ebe97b6e2ba8a2a5618" class="new-tbl-cell">
					<span class="icon2">分类搜索</span>
					<p style="color:#6e6e6e;">分类搜索</p>
				</a>
				<a href="javascript:void(0)" id="html5_cart" class="new-tbl-cell">
					<span class="icon3">购物车</span>
					<p style="color:#6e6e6e;">购物车</p>
				</a>
				<a href="http://item.m.jd.com/user/home.action?sid=572ca887fd536ebe97b6e2ba8a2a5618" class="new-tbl-cell">
					<span class="icon4">用户中心</span>
					<p style="color:#6e6e6e;">用户中心</p>
				</a>
			</div>
		</div>
	</header>
	<script type="text/javascript" src="/mobileStore/images/js/nav.js"></script>
	<style type="text/css">
		.nav-fixed{position:fixed;background-color:rgba(222,222,222,0.7);top:0;zoom:1;z-index:10;}
		*{
	      margin:0;padding:0;
	    }
	    table{
	     max-width: 100% !important;
		 width: auto !important;
	    }
	    img{
	     display: block;
		 max-width: 100%;
		 width: auto !important;
		 height: auto !important;
	    }
	</style>

	<div class="good-detail sift-mg">
		<div style="height: 42px;" class="sift-tab">
			<div style="height: 42px; width: 1072px;" id="fixed" class="sift-tab">
				<ul class="tab-lst">
					<li><a href="javascript:void(0)" value="wareInfo" class="on">商品介绍</a></li>
					<li><a class="" href="javascript:void(0)" value="wareStandard"><span class="bar"></span>规格参数</a></li>
					<li><a class="" href="javascript:void(0)" value="warePack"><span class="bar"></span>包装售后</a></li>
				</ul>
			</div>
		</div>
		<div style="display: block;" class="detail" id="wareInfo">
			<p>
				<span>	
				</span>
			</p>
			<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="content_tpl">
				<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork">
					<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork_img"><img style="max-width: 270px;" src="/mobileStore/images/imgs/rBEhWlMde9MIAAAAAAI-L2foKr8AAJxOwIHhYMAAj5H568.jpg"></div>
				</div>
				<table style="width: 300px;" align="center" border="0" cellpadding="0" cellspacing="6" width="750">
					<tbody>
						<tr style="max-width: 300px;">
							<td style="background-size: 300px auto; max-width: 300px;"><p class="formwork_titleleft">维达抽取式面巾纸150抽*8连包</p><p class="formwork_titleleft2">品牌：维达<br>
							原材料：100%原木浆<br>
							箱规：8提/箱
							规格：162mm×195mm×2层×150抽×8包<br>
							保质期：三年
							</p></td>
						</tr>
						<tr style="max-width: 300px;">
							<td style="background-size: 300px auto; max-width: 300px;"><img style="max-width: 270px;" src="/mobileStore/images/imgs/rBEQWVEm6v0IAAAAAABP0Bx3RfIAAA4bwM0wNoAAE_o202.jpg"></td>
						</tr>
						<tr style="max-width: 300px;">
						</tr>
					</tbody>
				</table>
				<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork">
					<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork_img"><img style="max-width: 270px;" src="/mobileStore/images/imgs/5451bf0fNf255a04e.jpg"></div>
				</div>
				<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork">
					<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork_img"><img style="max-width: 270px;" src="/mobileStore/images/imgs/rBEhVFMde-oIAAAAAAUd7I9FnM8AAJzTwLGGQgABR4E939.jpg"></div>
				</div>
				<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork">
					<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork_img"><img style="max-width: 270px;" src="/mobileStore/images/imgs/rBEhUlMde_EIAAAAAAbbB2PeaNoAAJzUAGc970ABtsf896.jpg"></div>
				</div>
				<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork">
					<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork_img"><img style="max-width: 270px;" src="/mobileStore/images/imgs/rBEhVlMdfAEIAAAAAAWI1ZS6u2EAAJ6AAIyz3cABYjt023.jpg"></div>
				</div>
				<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork">
					<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork_img"><img style="max-width: 270px;" src="/mobileStore/images/imgs/rBEhVVMdfBAIAAAAAAWNCa7epskAAJ6AQH2DsoABY0h241.jpg"></div>
				</div>
				<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork">
					<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork_img"><img style="max-width: 270px;" src="/mobileStore/images/imgs/rBEhVlMdfBoIAAAAAAcmTY9FT34AAJ6AgG35RUAByZl679.jpg"></div>
				</div>
				<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork">
					<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork_img"><img style="max-width: 270px;" src="/mobileStore/images/imgs/rBEhVVMdfCkIAAAAAAdsDUNJwTsAAJ6AwLOfQgAB2wl257.jpg"></div>
				</div>
				<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork">
					<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork_img"><img style="max-width: 270px;" src="/mobileStore/images/imgs/rBEhU1MdfFAIAAAAAAPge7tYeGsAAJzUAOrPQoAA-CT574.jpg"></div>
				</div>
				<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork">
					<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork_img"><img style="max-width: 270px;" src="/mobileStore/images/imgs/rBEhU1MdfG0IAAAAAAcX_H2AkqkAAJzUwGdwxUABxgU377.jpg"></div>
				</div>
				<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork">
					<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork_img"><img style="max-width: 270px;" src="/mobileStore/images/imgs/rBEhWVMdfHkIAAAAAAglp0ZWbuwAAJxPwBitrwACCW_562.jpg"></div>
				</div>
				<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork">
					<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork_img"><img style="max-width: 270px;" src="/mobileStore/images/imgs/rBEhWFMdfIMIAAAAAAcs9zScA_cAAJxPwJ0WeoABy0P704.jpg"></div>
				</div>
				<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork">
					<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork_img"><img style="max-width: 270px;" src="/mobileStore/images/imgs/rBEhU1MdfMkIAAAAAAJjW2zNCB8AAJzVQMdo_8AAmNz155.jpg"></div>
				</div>
				<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork">
					<div style="width: 300px; height: auto; max-width: 300px; word-break: break-all;" class="formwork_text">
						维达集团创建于1985年。二十多年来，维达坚持「勇于开拓，不断创新」 
						的方针，专注研产高级生活用纸。时至今天，维达已从一个地方性民企成长为一个以「维达」品牌作核心的中国名牌企业。 
						维达时刻力求创新和进步，并以敏锐的目光洞察市场需求，产品推陈出新以满足消费者不断变化的需求。除了专注生产高品质生活用纸系列产品，包括卫生卷纸、纸
						巾、盒装面巾、软包抽取式面巾，还积极研发新产品，如采用环保可再生原料的纸品以及湿巾等个人护理用品。正是这种创新的精神和贴心的服务，使维达一直广受
						欢迎，在消费者中赢得了高度的品牌忠诚度和美誉度。 
						维达将继续努力不懈，用专业的技术、一流的产品、务实的态度，大踏步走向世界，成长为生活用纸领域的领导品牌。
					</div>
				</div>
			</div>
			<p></p>
		</div>
		<div style="display: none;" class="detail" id="wareStandard">
			<style>
				.Ptable{border-spacing:0px;border-collapse:collapse;}
				.Ptable td{height:10px;padding:0 5px;line-height:20px;font-size:12px;color:#333;word-break:break-all;}
				.Ptable th{height:10px;line-height:40px;padding-left:20px;font-size:18px;text-align:left}
				.Ptable td.td-txtlft{padding-left:10px;text-align:left}
				.Ptable .w130{width:130px}
				.tdTitle{text-align:center;padding-left:20px;width:130px}
			</style>
			<p>
				<span></span>
			</p>
			<table class="Ptable" border="1" cellpadding="0" cellspacing="1" width="100%"><tbody><tr><th class="tdTitle" colspan="2">主体</th></tr><tr></tr><tr><td class="tdTitle">品牌</td><td>维达</td></tr><tr><td class="tdTitle">类别</td><td>维达抽取式面巾纸</td></tr><tr><td class="tdTitle">材质</td><td>100%原木浆</td></tr><tr><td class="tdTitle">产品规格</td><td>320×95×260mm</td></tr><tr><td class="tdTitle">产品包装尺寸（cm）</td><td>160×95×65mm</td></tr><tr><td class="tdTitle">产品包装重量（kg)</td><td>1.13724kg</td></tr><tr><td class="tdTitle">适用范围</td><td>日常生活用品</td></tr></tbody></table>
			<p></p>
		</div>
		<div style="display: none;" class="detail" id="warePack">
			<p>
				<span>	
					维达抽取式面巾纸150抽8连包  × 1<br>
				</span>
				<span>	
				 	本产品全国联保，享受三包服务，质保期为:七天质保<br>
				</span>
			</p>
		</div>
		<div style="display: none;" class="detail" id="wareService">
			<p>
				<span>	
				 	本产品全国联保，享受三包服务，质保期为:七天质保<br>
				</span>
			</p>
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
	    	$(".detail").hide();
	    		$("#bookInfo").show();
	    		$("#wareInfo").show();
	    		$("li>a").click(function(){
					if($('#fixed').has('nav-fixed')){
						$('#fixed').removeClass('nav-fixed');
					}
	    			$(".detail").hide();
	    			$("li>a").removeClass("on");
	    			$(this).addClass("on");
	    			var id=$(this).attr("value");
	    			$("#"+id).show();
	    	});
			$("body").css("margin","0 auto");
			if($("#wareInfo").html()){
	    		$("#wareInfo").html($("#wareInfo").html().replace(/<\/td>/g,'</td></tr><tr>'));
	    		$("#wareInfo").html($("#wareInfo").html().replace(/item.jd.com/g,'m.jd.com/product'));
	    		$("#wareInfo").html($("#wareInfo").html().replace(/www.360buy.com/g,'m.jd.com'));
			}
			$("#wareInfo img").css("max-width","270px");
			$("#wareInfo table").css("width","300px");
			$("#wareInfo td").css("background-size","300px");
			$("#wareInfo td").css("max-width","300px");
			$("#wareInfo tr").css("max-width","300px");
			$("#wareInfo div").css("width","300px");
			$("#wareInfo div").css("height","auto");
			$("#wareInfo div").css("max-width","300px");
			$("#wareInfo div").css("word-break","break-all");
			$("#wareInfo ul").css("width","300px");
		});
		
				
		$('#fixed').floatNav({
			fixedClass: 'nav-fixed',
	    	range: 30
		}); 
		
	</script>
   
	<div class="login-area" id="footer">
		<div class="login">
			<a href="https://passport.m.jd.com/user/login.action?sid=572ca887fd536ebe97b6e2ba8a2a5618">登录</a><span class="lg-bar">|</span><a href="https://passport.m.jd.com/user/mobileRegister.action?v=t&amp;sid=572ca887fd536ebe97b6e2ba8a2a5618">注册</a>
			<span class="new-fr"><a href="http://item.m.jd.com/showvote.html?sid=572ca887fd536ebe97b6e2ba8a2a5618">反馈</a><span class="lg-bar">|</span><a href="#top">回到顶部</a></span>
		</div>
		<div class="version"><a href="http://wap.jd.com/index.html?v=w&amp;sid=572ca887fd536ebe97b6e2ba8a2a5618">标准版</a><a href="javascript:void(0)" class="on">触屏版</a>
			<a onclick="skip();" href="javascript:void(0);" id="toPcHome">电脑版</a>
		</div>
		<div id="clientArea">
			<a href="http://item.m.jd.com/download/downApp.html?sid=572ca887fd536ebe97b6e2ba8a2a5618" id="toClient" class="openJD">客户端</a>
		</div>
		<div class="copyright">© medref.cn</div>
	</div>
	
	<div style="display:none;">
		<img src="/mobileStore/images/imgs/ja.gif">
	</div>
	
	
	<script type="text/javascript" src="/mobileStore/images/js/ping.js"></script>
	<script type="text/javascript">
	    try{
	        ping.init();
	    }catch(e){
	    }
	</script>
	
	
	<script type="text/javascript">
		$("#unsupport").hide();
		if(!testLocalStorage()){ //not support html5
		    if(0!=0 && !$clearCart && !$teamId){
				$("#html5_cart_num").text(0>0>0);
			}
		}else{
			updateToolBar('');
		}
		
		$("#html5_cart").click(function(){
		//	syncCart('572ca887fd536ebe97b6e2ba8a2a5618',true);
			location.href='/cart/cart.action';
		});
		
		function reSearch(){
		var depCity = window.sessionStorage.getItem("airline_depCityName");
			if(testSessionStorage() && isNotBlank(depCity) && !/^\s*$/.test(depCity) && depCity!=""){
		    	var airStr = '<form action="/airline/list.action" method="post" id="reseach">'
		        +'<input type="hidden" name="sid"  value="572ca887fd536ebe97b6e2ba8a2a5618"/>'
		        +'<input type="hidden" name="depCity" value="'+ window.sessionStorage.getItem("airline_depCityName") +'"/>'
		        +'<input type="hidden" name="arrCity" value="'+ window.sessionStorage.getItem("airline_arrCityName") +'"/>'
		        +'<input type="hidden" name="depDate" value="'+ window.sessionStorage.getItem("airline_depDate") +'"/>'
		        +'<input type="hidden" name="depTime" value="'+ window.sessionStorage.getItem("airline_depTime") +'"/>'
		        +'<input type="hidden" name="classNo" value="'+ window.sessionStorage.getItem("airline_classNo") +'"/>'
		        +'</form>';
		    	$("body").append(airStr);
		    	$("#reseach").submit();
			}else{
		    	window.location.href='/airline/index.action?sid=572ca887fd536ebe97b6e2ba8a2a5618';
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
				_loadScript("http://st.360buyimg.com/item/js/2013/installapp.js?v=jd2015010420",{},function(){
					 $("#clientArea").length && downcheck($("#clientArea"),false);
				});
			}
					
		})
		function skip(){
			addCookie('pcm', '1' ,3, '', 'jd.com');
			var localurl = 'http://www.jd.com/#m';
			if(localurl == 'http://www.jd.com/#m'){
				var localurl = document.location.href;
	    		if(localurl.indexOf('http://m.jd.com/sale/mall') == 0){
	    			var saleurl = localurl.replace('http://m.jd.com/sale/mall', 'http://sale.jd.com/mall');
	    			saleurl = saleurl+'#m'
	    			window.location.href = saleurl;
					return;
	    		}else if(localurl.indexOf('http://m.jd.com/sale/act') == 0){
	    			var saleurl = localurl.replace('http://m.jd.com/sale/act', 'http://sale.jd.com/act');
	    			saleurl = saleurl+'#m'
	    		 	window.location.href = saleurl;
					return;
	    		}else{
	    			 window.location.href = 'http://www.jd.com/#m';
					 return;
	    		}
			}
			window.location.href = localurl;
		}
		
		function addCookie(name, value, expires, path, domain){ 
	        var str=name+"="+escape(value); 
	        if(expires!=""){ 
	            var date=new Date(); 
	            date.setTime(date.getTime()+expires*24*3600*1000);//expires单位为天 
	            str+=";expires="+date.toGMTString(); 
	        } 
	        if(path!=""){ 
	        	str+=";path="+path;//指定可访问cookie的目录 
	        } 
	        if(domain!=""){ 
	        	str+=";domain="+domain;//指定可访问cookie的域 
	        } 
	        document.cookie=str; 
	    } 
		function search_new(){
			var a = $("#newkeyword").val();
			addSearchHistory(a);
			$('#searchForm').submit();
		}
	</script>
	<iframe style="display: none; width: 0px; height: 0px;"></iframe><iframe style="display: none; width: 0px; height: 0px;"></iframe>
</body>