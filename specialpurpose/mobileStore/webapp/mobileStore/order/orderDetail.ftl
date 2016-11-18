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
<body id="body">
	<a name="top"></a>
	<header>
		<div class="new-header">
			<a href="javascript:pageBack();" class="new-a-back" id="backUrl"><span>返回</span></a>
			<h2>订单详情</h2>
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
					<span class="icon4 on">用户中心</span>
					<p style="color:#6e6e6e;" class="on">用户中心</p>
				</a>
			</div>
		</div>
	</header>
	
	<input type="hidden" id="orderId" name="orderId" value="${parameters.orderId!}">
	<input type="hidden" id="sid" name="sid" value="e05342df03dd29ae84a48b2e06c03af7">
	<div class="wrap">
		<section class="order-con">
			<ul class="order-list">
				<li>
					<div class="order-box">
						<div class="order-width">
							<p>订单编号：${parameters.orderId!}</p>
							<p>订单金额：<@ofbizCurrency amount=orderGrandTotal isoCode=currencyUomId/></p>
							<p>订单日期：${orderHeader.orderDate.toString()}</p>
						</div>
						<div class="pay-button">
							<a href="payOrder?orderId=${orderHeader.orderId!}" class="pay-order">在线支付</a>
            				<a href="orderCancel?orderId=${orderHeader.orderId!}" id="cancelOrder" class="pay-order">取消订单</a>
						</div>
					</div>
				</li>
				<li>
					<div class="order-box">
						<ul class="book-list">
                			<#if orderItems??>
				                <#list orderItems as orderItem>
				                    <#assign product = orderItem.getRelatedOne("Product", true)?if_exists/>
				                    <#assign productStore = delegator.findOne("ProductStore", {"productStoreId" : (product.primaryProductStoreId)!''}, true)?if_exists/>
						        	<#assign smallImageUrl = product.smallImageUrl?if_exists>
						        	<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/mobileStore/images/imgs/53cf721bN254a8804.jpg"></#if>
		                			<li class="border-bottom">
									   	<a href="productDetail?product_id=${(product.productId)!}">
									   		<div class="order-msg">
												<img src="${smallImageUrl!}" class="img_ware">
												<div class="order-msg">
													<p class="title">${(product.internalName)!(product.productNameZh)!(product.productNameRu)!}</p>
													<p class="price">
														<#assign prices = delegator.findByAnd("ProductPrice",{"productId":product.productId},["currencyUomId"],false)?if_exists />
														<@ofbizCurrency amount=prices[0].price isoCode=prices[0].currencyUomId />
														<span></span>
													</p>
													<p class="order-data">
														<#if orderItem.quantity??>X${orderItem.quantity}</#if>
													</p>
												</div>
											</div>
										</a>
									</li>
								</#list>
							</#if>
						 	<#--
						 	<li class="border-bottom">
							   <a href="http://m.jd.com/product/209954.html?sid=e05342df03dd29ae84a48b2e06c03af7">
							   <div class="order-msg">
									<img src="/mobileStore/images/imgs/rBEhVFMQPc0IAAAAAAJ2_1mJZesAAJPAwCU-0wAAncX667.jpg" class="img_ware">
									<div class="order-msg">
										<p class="title"> 维达 厨房用纸 水滴花纹 75节*2卷</p>
										<p class="price">￥8.30<span></span></p>
										<p class="order-data">X1</p>
									</div>
								</div>
								</a>
							</li>
							-->
						</ul>
					</div>
				</li>
   		  		<li>
					<div class="order-box">
						<div class="order-width">
							<#assign oisg = delegator.findByAnd("OrderItemShipGroup",{"orderId":parameters.orderId})?if_exists/>
							<#if oisg??>
								<#assign contactMech = delegator.findOne("ContactMech",false,{"contactMechId":oisg[0].contactMechId})?if_exists>
								<#assign address = delegator.findOne("PostalAddress",false,{"contactMechId":oisg[0].contactMechId})?if_exists>
								<#assign phone = delegator.findOne("TelecomNumber",false,{"contactMechId":oisg[0].contactMechId})?if_exists>
							</#if>
							<p class="border-bottom usr-name">
								${(address.toName)!(address.attnName)!}
								<#--<span class="fr">${(phone.contactNumber)!}</span>-->
								<span class="fr">${(address.mobileExd)!}</span>
							</p>
							<p class="usr-addr">${(address.address1)!}</p>
						</div>
					</div>
				</li>
	  			<li>
					<div class="order-box">
						<div class="order-width">
							<p class="border-bottom usr-name">付款方式:<span class="fr">在线支付</span></p>
							<p>商品金额:<span class="fr red"><@ofbizCurrency amount=orderSubTotal isoCode=currencyUomId/></span></p>
							<#--<p>返现:<span class="fr red">￥0.00</span></p>-->
							<p class="border-bottom">运费:<span class="fr red"><@ofbizCurrency amount=orderShippingTotal isoCode=currencyUomId/></span></p>
							<p>应支付金额:<span class="fr red"><@ofbizCurrency amount=orderGrandTotal isoCode=currencyUomId/></span></p>
						</div>
					</div>
				</li>
				<li>
					<div class="order-box">
						<div class="order-width">
							<p class="border-bottom usr-name">配送信息<span class="fr"></span></p>
							<p>配送方式: 普通快递</p>
							<p>送货时间： 2015-01-18</p>
							<p>配送时间： 19:00-22:00</p>
						</div>
					</div>
				</li>
											
				<li>
					<div class="order-box">
						<div class="order-width">
							<p class="border-bottom usr-name">发票信息<span class="fr"></span></p>
							<p>发票类型:  电子发票</p>
							<p></p>
							<p>发票抬头:  个人</p>
							<p></p>
							<p>发票内容:  明细</p>
							<p></p>
						</div>
					</div>
				</li>	
			</ul>
		</section>
	</div>

	<script type="text/javascript">
		$(function(){
			$("#cancelOrder").click(function(){
				if (confirm("是否确定取消该订单")){
		    		var can=$("#cancelOrder").index($(this));
					jQuery.get(
						"/user/cancelOrder.json",
						{"orderId":$("#orderId").val(),"sid":$("#sid").val()},
		               function(data){
					        $("#cancelOrder").eq(can).html(data.message);
		    				$("#cancelOrder").eq(can).unbind('click');
							var url = "https://passport.m.jd.com/user/userAllOrderList.action";
							if(!!$('#sid').val())
								url += '?sid='+$('#sid').val();
							window.location.href = url;
						}, "json");
					}
				else
		    		 {
		    		   return false;
		    	     }
				})
		
			$("#confirmGoods").click(function(){
				if(confirm("是否确认收货")){
					var can=$("#confirmGoods").index($(this));
					jQuery.get(
						"/user/confirmGoods.json",
						{"orderId":$("#orderId").val(),"sid":$("#sid").val()},
						function(data){
		                    $("#confirmGoods").eq(can).html('<font color="red">'+data.message+'</font>');
							$("#confirmGoods").eq(can).unbind('click');
						},"json");
				}
				else{
					return false;
				}
			});
		});
	</script>		
   
	<div class="login-area" id="footer">
    	<div class="login">
        	<#if userLogin??>
				<a rel="nofollow" href="memberCenter">${(userLogin.userLoginId)!'---'}</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="logout">退出</a>
			<#else>
				<a rel="nofollow" href="login">登录</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="register">注册</a>
			</#if>
			<span class="new-fr"><a href="http://m.jd.com/showvote.html?sid=e05342df03dd29ae84a48b2e06c03af7">反馈</a><span class="lg-bar">|</span><a href="http://m.jd.com/user/oneorderdetail.action?orderId=8202049629&passKey=e8712cdd8f27e487d1e895abb6f33167&sid=e05342df03dd29ae84a48b2e06c03af7#top">回到顶部</a></span>
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
</body>