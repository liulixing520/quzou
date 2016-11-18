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
<script src="/mobileStore/images/js/zepto.min.js"></script>
<script type="text/javascript">window.jQuery=window.Zepto;</script>
<script type="text/javascript" src="/mobileStore/images/js/common.js"></script>
<script type="text/javascript" src="/mobileStore/images/js/spin.min.js"></script>
<body id="body" style="overflow-x:hidden;margin: 0 auto;">
	<a name="top"></a>
	<header>
		<div class="new-header">
	    	<a href="http://m.jd.com/cart/cart.action?sid=e05342df03dd29ae84a48b2e06c03af7" class="new-a-back" id="backUrl"><span>返回</span></a>
				<h2>填写订单</h2>
	        <a href="javascript:void(0)" id="btnJdkey" class="new-a-jd"><span>京东键</span></a>
		</div>
		<div class="new-jd-tab" style="display:none" id="jdkey">
	    	<div class="new-tbl-type">
	            <a href="http://m.jd.com/index.html?sid=e05342df03dd29ae84a48b2e06c03af7" class="new-tbl-cell">
	            	<span class="icon">首页</span>
					<p style="color:#6e6e6e;">首页</p>
	            </a>
	            <a href="http://m.jd.com/category/all.html?sid=e05342df03dd29ae84a48b2e06c03af7" class="new-tbl-cell">
	            	<span class="icon2">分类搜索</span>
					<p style="color:#6e6e6e;">分类搜索</p>
	            </a>
	            <a href="javascript:void(0)" id="html5_cart" class="new-tbl-cell">
	            	<span class="icon3">购物车</span>
					<p style="color:#6e6e6e;">购物车</p>
	            </a>
	            <a href="http://m.jd.com/user/home.action?sid=e05342df03dd29ae84a48b2e06c03af7" class="new-tbl-cell">
	            	<span class="icon4">用户中心</span>
					<p style="color:#6e6e6e;">用户中心</p>
	            </a>
	        </div>
	    </div>
	</header>
	
	<div style="height:100%;width:100%;z-index:1001;position:absolute;overflow:hidden;background:rgba(145, 145, 145, .1);display:none" id="background">
	</div>

	<div style="width:100%;overflow:scroll;" id="tab">
		<form method="post" action="createOrderFromMobile?checkOutPaymentId=EXT_PAYEASE" id="orderForm">
			<div class="new-ct" style="height:100%;width:100%;float:left;" id="parent1Content">
				<slidercontent>
					<div class="title">收货人信息</div>
					<#if defaultContactMech??>
						<#assign postalAddress = delegator.findOne("PostalAddress",{"contactMechId":defaultContactMech.contactMechId},false)?if_exists />
						<#assign telecomNumber = delegator.findOne("TelecomNumber",{"contactMechId":defaultContactMech.contactMechId},false)?if_exists />
						<div class="info">
				    		<a href="shippingAddressMgr" id="addressLink">
					            <span class="text">${(postalAddress.toName)!(postalAddress.attnName)!}<span style="margin-left:5px;" class="phone-num">${(postalAddress.mobileExd)!}</span></span>
					            <span class="text2">${(postalAddress.address1)!}</span>            
					        </a>
			                <span class="icon-arr"></span>
					    </div>
					<#else>
					    <div class="info"> 
					    	<a id="addressLink" href="shippingAddressMgr">
					            <span class="text">点击选择收货地址</span>
					        </a> 
					        <span class="icon-arr"></span>
					    </div>
				    </#if>
					
				    <div class="title">支付信息</div>
				        <div class="info">
				            <a href="javascript:void(0);">
				                <span class="text">在线支付</span>
				            </a>        
				            <span class="icon-arr"></span>
				        </div>
				      	<#--
				      	<div class="info">
							<a href="http://m.jd.com/norder/coupons.action?sid=e05342df03dd29ae84a48b2e06c03af7">
								<div class="tbl-type">
									<span class="tbl-cell"><span class="text">优惠券/京东卡</span></span>
				                </div>
							</a>
							<span class="icon-arr"></span>
						</div>
					 	<div class="info">		
				            <div class="info pd" id="useJdbean" onclick="jdBeanHandler()">  				
					            <div class="tbl-type">
									<span class="tbl-cell"><span class="text">京豆支付</span></span>
							        <span class="tbl-cell"><span class="text3">可用40京豆，抵￥0.40</span></span>
									<span class="tbl-cell text-right"><span class="text4"></span>
							        <span id="useJdbeanIcon" class="icon"></span></span>
						        </div>
						    </div>     
						</div>
				        -->
			      		<div class="title">快递运输</div>
			            <div class="info">
		            		<a href="javascript:void(0);"> 
				                 <span class="text">送货时间<span class="text3">1-7天 </span></span>            
		             		</a>
		           			<span class="icon-arr"></span>
		          		</div>
		          		<div class="title">发票信息</div>
						<div class="info">
		                	<a href="javascript:void(0);">
			                 	<span class="text">
									普通发票
							    </span>
		                	</a>
			                <span class="icon-arr"></span>
			           	</div>
			   	   
		         		<div class="pw-input" id="payPwdDiv" style="display:none">
		      				<div class="tbl-type">
								<span class="tbl-cell"> 
									<span class="new-input-span mg-b15">  
				                    	<!-- [D] 点击输入框时加on （字体颜色会变黑色） -->
				                    	<input type="password" name="order.securityPayPassword" class="new-input on" placeholder="请输入支付密码" id="payPassword">
				                    </span>
		                		</span>
								<span class="tbl-cell text-center w80" id="findPayPassword">
		                           	<a href="https://passport.m.jd.com/payPassword/validateFindPayPassword.action?urlFrom=2&sid=e05342df03dd29ae84a48b2e06c03af7" class="link-pw">忘记密码</a>  				
		                       	</span>
		        			
								<span class="tbl-cell text-center w80" id="openPayPassword" style="display:none">
		        					<a href="https://passport.m.jd.com/payPassword/openPayPassword.action?urlFrom=2&sid=e05342df03dd29ae84a48b2e06c03af7" class="link-pw">开启密码&gt;&gt;</a>
			        			</span>
							</div>
			        	</div>
				
						<div class="totle" id="yunfei">
							<span class="bg-border"><span class="icon"></span></span>
							<div class="totle-cont">
								<div class="tbl-type">
									<span class="tbl-cell">商品金额</span><span class="tbl-cell text-right">￥${totalPrice?if_exists?string(',###.##')}</span>
								</div>
								<div class="tbl-type">
									<span class="tbl-cell">运<span class="w10"></span>费</span><span class="tbl-cell text-right">￥${totalShip?if_exists?string(',###.##')}</span>
								</div>
								<div class="tbl-type">
									<span class="tbl-cell">应付金额</span><span class="tbl-cell text-right"><span class="text-red">￥${grandTotal?if_exists?string(',###.##')}</span></span>
								</div>
							</div>
							<span class="bg-border2"></span>
							  	<input type="hidden" id="showPayPassword" value="false">
							  	<input type="hidden" id="userPayPassword" value="true">
							</div>
							<!--[D] 默认时加  new-abtn-default 把a标签换成span-->
							<span onclick="submitOrder()" class="new-abtn-type mgn">提交订单</span>	
							<input type="hidden" id="sid" value="e05342df03dd29ae84a48b2e06c03af7">
							<input type="hidden" id="wareId" value="">
							<input type="hidden" id="isIdTown" value="false">  
							<footer>
								<div class="new-footer" id="footer">
									<div class="new-f-login">
										<#if userLogin??>
											<a rel="nofollow" href="memberCenter">${(userLogin.userLoginId)!'---'}</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="logout">退出</a>
										<#else>
											<a rel="nofollow" href="login">登录</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="register">注册</a>
										</#if>
										<span class="new-back-top"><a href="http://m.jd.com/showvote.html?sid=e05342df03dd29ae84a48b2e06c03af7">反馈</a><span class="new-bar2">|</span><a href="http://m.jd.com/norder/order.action?enterOrder=true&sid=e05342df03dd29ae84a48b2e06c03af7#top">回到顶部</a></span>
									</div>
									<div class="new-f-section"><a href="http://wap.jd.com/index.html?v=w&sid=e05342df03dd29ae84a48b2e06c03af7">标准版</a><a href="javascript:void(0)" class="on">触屏版</a><a href="http://m.jd.com/index/pcsite.action" id="toPcHome">电脑版</a></div>
									<div class="new-f-section2">Copyright © 2012-2014 m.jd.com 版权所有</div>
								</div>
							</footer>
						</slidercontent>
					</div>
				</form>
			</div>
			<div class="order-pop" id="showIdTown" style="display:none;position:absolute;bottom:50%;z-index:9999">
				<div class="ico-succ">
					<span class="cart-succ" style="font-size:1.2em;margin-bottom:5px">即刻升级地址</span>
				</div>
				<div class="cp-lnk">
					<div style="font-size:0.8em;margin: 0.5em 0.8em 0.2em 1.2em">为了让您享受更为精准的配送服务，我们提供了四级地址选项，请您立刻完善地址信息以免影响正常下单 </div>
					<div style="margin: 0.1em 0.5em 0.5em 0.5em"> <a id="add_cart" href="http://m.jd.com/order/editAddress.action?vtuanOrder=false&addressId=-1&sid=e05342df03dd29ae84a48b2e06c03af7" class="btn-edit-address">立刻完善信息</a></div>
				</div>
			</div>
  
			<script type="text/javascript" src="/mobileStore/images/js/norder.js"></script>
			<script type="text/javascript" src="/mobileStore/images/js/address.js"></script>
			<script>
				function backListener(hash,next){
						if(next!=null){
							$("#backUrl").attr("href","javascript:backListener('"+next+"')");
						}
						if(hash!=null){
			    			var backUrl = window.location.href;
			    			backUrl = backUrl.replace(window.location.hash,"");
			    			window.location.href=backUrl+"#"+hash;
						}
						if(hash==null || hash.indexOf('parent')!=-1){
							if($("#wareId").val()!=null&&$("#wareId").val()!=""){
			        			$("#backUrl").attr("href",'/ware/view.action?wareId=&sid=e05342df03dd29ae84a48b2e06c03af7');
			    			}else{
			        			$("#backUrl").attr("href","/cart/cart.action?sid=e05342df03dd29ae84a48b2e06c03af7");
			    			}
						}
				}
					
				window.onload=sliderLoad;
				
				$("body").attr("style","overflow-x:hidden;margin: 0 auto;");
				
			    $(document).ready(function(){
				        if($("#showPayPassword").val()=="true" && $("#userPayPassword").val()=="true" ){
				               $("#submiOrder").addClass("new-abtn-default");
						}
			    		$('#payPassword').bind('input',function(){
							var pwd = $("#payPassword").val(); 
							if(pwd!=null&&pwd.length>0){
			    	        	$("#submiOrder").removeClass("new-abtn-default");
							}else{
			    				$("#submiOrder").addClass("new-abtn-default");
							}
			    		}); 
						
						backListener();
			    });
			 </script>	


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


</body></html>