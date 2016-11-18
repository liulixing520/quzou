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
			document.write('<script src="/mobileStore/images/js/zepto.min.js?v=jd2015010820"><\/script>');
			document.write('<script type="text/javascript">window.jQuery=window.Zepto;<\/script>');
		}else{
			document.write('<script src="/mobileStore/images/js/jquery-1.6.2.min.js?v=jd2015010820"><\/script>');
		}
	}else{//如果是非webkit内核直接使用jquery
		document.write('<script src="/mobileStore/images/js/jquery-1.6.2.min.js?v=jd2015010820"><\/script>');
	}
</script>
<style>
	.pay-tip{
		width:85%;
		margin:15px auto;
		padding:10px;
		background:#f0ead4;
		border:1px solid #a4a4a4;
		border-radius:5px;
		-webkit-border-radius:5px;
		-moz-border-radius:5px;
	}
</style>
<script src="/mobileStore/images/js/zepto.min.js"></script>
<script type="text/javascript">window.jQuery=window.Zepto;</script>
<script type="text/javascript" src="/mobileStore/images/js/common.js"></script>
<script type="text/javascript" src="/mobileStore/images/js/spin.min.js"></script>
<script src="/mobileStore/images/js/installapp.js" type="text/javascript" charset="utf-8"></script>

<body id="body" class="orderList">
	<a name="top"></a>
	<header>
		<div class="header w">
			<div class="header-btn fr">
				<a href="http://m.jd.com/user/home.action?sid=e05342df03dd29ae84a48b2e06c03af7"><img width="22" height="21" src="/mobileStore/images/imgs/avatar.png" style="margin-bottom:3px;"></a>
	            <a href="http://m.jd.com/index.html?sid=e05342df03dd29ae84a48b2e06c03af7">
					<img src="/mobileStore/images/imgs/home.png" style="margin-bottom:3px;"><span></span>
				</a>
			</div>
		</div>
	</header>
	<#assign totalPay = Static["java.math.BigDecimal"].ZERO/>
    <#assign totalCurrency = "CNY"/>
    <#if orderList?has_content>
    	<#list orderList as orderHeader>
    		<#assign orh = Static["org.ofbiz.order.order.OrderReadHelper"].getHelper(orderHeader)/>
    		<#--
    		<#assign shipGroups = orh.getOrderItemShipGroups()/>
    		<#assign totalOrderItemsQuantity= orh.getTotalOrderItemsQuantity()>
    		${orderHeader.orderId!}${totalOrderItemsQuantity}${uiLabelMap.PortalUserCarNumber}
    		<@ofbizCurrency amount=orh.getOrderGrandTotal() isoCode=orh.getCurrency()/>
    		<#if shipGroups?has_content>
				<#assign shipGroup = shipGroups.get(0)/>
 				<#assign shipmentMethodType = shipGroup.getRelatedOne("ShipmentMethodType", false)?if_exists>
    			<#assign shipGroupAddress = shipGroup.getRelatedOne("PostalAddress", false)?if_exists>
    			<#if shipmentMethodType?has_content>
    				${shipmentMethodType.get("description",locale)!}
    			</#if>
    			<#if shipGroupAddress?has_content>
        			${shipGroupAddress.toName!}
	                ${shipGroupAddress.address1!}
                </#if>
    		</#if>
    		<@ofbizCurrency amount=orh.getOrderAdjustmentsTotal() isoCode=orh.getCurrency()/>-->
    		<#assign totalPay=totalPay.add(orh.getOrderGrandTotal())/>
    		<#assign totalCurrency=orh.getCurrency()/>
    	</#list>
    </#if>
    <div class="order-tip">
		<h3>订单提交成功</h3>
		<p>订单号：${orderIdStr!}</p>
		<p>应付金额：<font style="color:#cc0000; font-weight:bold;"><@ofbizCurrency amount=totalPay isoCode=totalCurrency/></font></p>
		<p>支付方式：在线支付</p>
    </div>
    <div class="pay-tip">
        <p>请在24小时内完成支付，否则订单将会被自动取消。<br></p>
    </div>
	<a href="paymentOrders"><p><input type="button" value="在线支付" class="sub_btn" autocomplete="off"></p></a>
	<a href="orderDetail?orderId=${(orderList[0].orderId)!}"><p><input type="submit" value="查看订单" class="sub_btn_y sub_btn" autocomplete="off"></p></a>
	<div style="display:none;"><img height="1" width="1" alt="" src="/mobileStore/images/imgs/imp.gif"></div>

	<input type="hidden" id="sid" value="e05342df03dd29ae84a48b2e06c03af7" autocomplete="off">
	<#--><div class="download-con" id="down_app">
		<div class="down_app">
			<div class="download-logo"></div>
			<div class="alogo">
				<p class="client-name">
					下载客户端，支持更多支付方式
				</p>
				<p class="client-logon"></p>
			</div>
			<div class="open_now">
				<a id="openJD" href="http://m.jd.com/download/downApp.html?sid=e05342df03dd29ae84a48b2e06c03af7"><span class="open_btn">立即打开</span></a>
			</div>
			<div class="close-btn-con close-btn">
				<span class="close-btn-icon"></span>
			</div>
		</div>
	</div>-->
	<script type="text/javascript" src="/mobileStore/images/js/touch_order_common.js"></script>
	<script>
        $("#body").addClass("orderList");
        initVar('','','','','e05342df03dd29ae84a48b2e06c03af7');
		
		if(true){
			clearCart();
		}
		
	    if (true && window.androidPad) { //androidpad下单成功清除购物车
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
			<span class="new-fr"><a href="http://m.jd.com/showvote.html?sid=e05342df03dd29ae84a48b2e06c03af7">反馈</a><span class="lg-bar">|</span><a href="http://m.jd.com/norder/submit.action?sid=e05342df03dd29ae84a48b2e06c03af7#top">回到顶部</a></span>
        </div>
    	<div class="version"><a href="http://wap.jd.com/index.html?v=w&sid=e05342df03dd29ae84a48b2e06c03af7">标准版</a><a href="javascript:void(0)" class="on">触屏版</a>
			<a onclick="skip();" href="javascript:void(0);" id="toPcHome">电脑版</a>
    	</div>
    	<div id="clientArea">
        	<a href="http://m.jd.com/download/downApp.html?sid=e05342df03dd29ae84a48b2e06c03af7" id="toClient" class="openJD">客户端</a>
    	</div>
        <div class="copyright">© medref.cn</div>
    </div>

    <div style="display:none;">
		<img src="/mobileStore/images/imgs/ja.jsp">
    </div>

    <script type="text/javascript" src="/mobileStore/images/js/ping.min.js"></script>
    <script type="text/javascript">
        try{
            ping.init({"userPin":"242991761-26336401"});
        }catch(e){
        }
    </script>

	<script type="text/javascript">
		$("#unsupport").hide();
		if(!testLocalStorage()){ //not support html5
		    if(0!=0 && !true && !$teamId){
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
</body>