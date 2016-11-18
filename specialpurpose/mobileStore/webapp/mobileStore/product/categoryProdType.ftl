<head>
	<link rel="apple-touch-icon-precomposed" href="/mobileStore/images/imgs/apple-touch-icon.png?v=jd2015010820">
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
			_locationList.push('/chongzhi/');//${child.categoryName!}充值模块
			_locationList.push('/comment/');//${child.categoryName!}推荐模块
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
				document.write('<script src="/mobileStore/images/js/zepto.min.js?v=jd2015010820"><\/script>');
				document.write('<script type="text/javascript">window.jQuery=window.Zepto;<\/script>');
			}else{
				document.write('<script src="/mobileStore/images/js/jquery-1.11.1.js?v=jd2015010820"><\/script>');
			}
		}else{//如果是非webkit内核直接使用jquery
			document.write('<script src="/mobileStore/images/js/jquery-1.11.1.js?v=jd2015010820"><\/script>');
		}
	</script>		
	<script src="/mobileStore/images/imgs/h5api.htm"></script>
	<script type="text/javascript">window.jQuery=window.Zepto;</script>
</head>
<body style="background-color: rgb(255, 255, 255);" id="body">
	<a name="top"></a>
	<header>
		<div class="new-header">
			<a href="javascript:pageBack();" class="new-a-back" id="backUrl"><span>返回</span></a>
			<h2>商品分类</h2>
			<a href="javascript:void(0)" id="btnJdkey" class="new-a-jd"><span>京东键</span></a>
		</div>
		<div class="new-jd-tab" style="display:none" id="jdkey">
			<div class="new-tbl-type">
				<a href="main" class="new-tbl-cell">
					<span class="icon">首页</span>
					<p style="color:#6e6e6e;">首页</p>
				</a>
				<a href="category" class="new-tbl-cell">
					<span class="icon2">分类搜索</span>
					<p style="color:#6e6e6e;">分类搜索</p>
				</a>
				<a href="shoppingCart" id="html5_cart" class="new-tbl-cell">
					<span class="icon3">购物车</span>
					<p style="color:#6e6e6e;">购物车</p>
				</a>
				<a href="memberCenter" class="new-tbl-cell">
					<span class="icon4">用户中心</span>
					<p style="color:#6e6e6e;">用户中心</p>
				</a>
			</div>
		</div>
	</header>
	<script language="javascript">$('body').css('background-color','#fff');</script>
	<#assign children = delegator.findByAnd("ProductCategory",{"primaryParentCategoryId":parameters.primaryParentCategoryId})?if_exists />
	<#if children?? && children?has_content>
	<div class="list p-sort radius">
		<div class="mc">
			<ul>
				<#list children as child>
					<a href="search?cid=${child.productCategoryId}">
						<li class="first">
							<input class="str1" value="${child.categoryName!}" type="hidden">
							<strong class="name1">${child.categoryName!}</strong>
							<span class="menu-botton-arrow"></span>
						</li>
					</a>
					<#--
					<a href="http://m.jd.com/products/9987-653-655.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7">
						<li class="first">
							<input class="str1" value="${child.categoryName!}" type="hidden">
							<strong class="name1">手机</strong>
							<span class="menu-botton-arrow"></span>
						</li>
					</a>
					<a href="http://m.jd.com/products/9987-653-659.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7">
						<li class="first">
							<input class="str1" value="对讲机" type="hidden">
							<strong class="name1">对讲机</strong>
							<span class="menu-botton-arrow"></span>
						</li>
					</a>
					-->
				</#list>
			</ul>
		</div>
	</div>
	</#if>
	<script type="text/javascript" src="/mobileStore/images/js/strCut.js"></script>
	   
	<div class="login-area" id="footer">
		<div class="login">
			<a href="https://passport.m.jd.com/user/login.action?sid=e05342df03dd29ae84a48b2e06c03af7">登录</a><span class="lg-bar">|</span><a href="https://passport.m.jd.com/user/mobileRegister.action?v=t&amp;sid=e05342df03dd29ae84a48b2e06c03af7">注册</a>
			<span class="new-fr"><a href="http://m.jd.com/showvote.html?sid=e05342df03dd29ae84a48b2e06c03af7">反馈</a><span class="lg-bar">|</span><a href="#top">回到顶部</a></span>
		</div>
		<div class="version">
			<a href="http://wap.jd.com/index.html?v=w&amp;sid=e05342df03dd29ae84a48b2e06c03af7">标准版</a><a href="javascript:void(0)" class="on">触屏版</a>
			<a onclick="skip();" href="javascript:void(0);" id="toPcHome">电脑版</a>
		</div>
		<div id="clientArea">
			<a href="http://m.jd.com/download/downApp.html?sid=e05342df03dd29ae84a48b2e06c03af7" id="toClient" class="openJD">客户端</a>
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
		//	syncCart('e05342df03dd29ae84a48b2e06c03af7',true);
			location.href='/cart/cart.action';
		});
		
		function reSearch(){
			var depCity = window.sessionStorage.getItem("airline_depCityName");
			if(testSessionStorage() && isNotBlank(depCity) && !/^\s*$/.test(depCity) && depCity!=""){
		    	var airStr = '<form action="/airline/list.action" method="post" id="reseach">'
		        +'<input type="hidden" name="sid"  value="e05342df03dd29ae84a48b2e06c03af7"/>'
		        +'<input type="hidden" name="depCity" value="'+ window.sessionStorage.getItem("airline_depCityName") +'"/>'
		        +'<input type="hidden" name="arrCity" value="'+ window.sessionStorage.getItem("airline_arrCityName") +'"/>'
		        +'<input type="hidden" name="depDate" value="'+ window.sessionStorage.getItem("airline_depDate") +'"/>'
		        +'<input type="hidden" name="depTime" value="'+ window.sessionStorage.getItem("airline_depTime") +'"/>'
		        +'<input type="hidden" name="classNo" value="'+ window.sessionStorage.getItem("airline_classNo") +'"/>'
		        +'</form>';
		    	$("body").append(airStr);
		    	$("#reseach").submit();
			}else{
		    	window.location.href='/airline/index.action?sid=e05342df03dd29ae84a48b2e06c03af7';
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
				_loadScript("http://st.360buyimg.com/m/js/2013/installapp.js?v=jd2015010820",{},function(){
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
	</script>
	<iframe style="display: none; width: 0px; height: 0px;"></iframe>
</body>