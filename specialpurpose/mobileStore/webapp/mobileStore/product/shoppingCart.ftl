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

<body id="body">
	<a name="top"></a>
	<header>
		<div class="new-header">
			<a href="javascript:pageBack();" class="new-a-back" id="backUrl"><span>返回</span></a>
			<h2>购物车</h2>
			<a href="javascript:void(0)" id="btnJdkey" class="new-a-jd"><span>京东键</span></a>
		</div>
		<div class="new-jd-tab" style="display: none;" id="jdkey">
			<div class="new-tbl-type">
				<a href="main" class="new-tbl-cell">
					<span class="icon">首页</span>
					<p style="color:#6e6e6e;">首页</p>
				</a>
				<a href="category" class="new-tbl-cell">
					<span class="icon2">分类搜索</span>
					<p style="color:#6e6e6e;">分类搜索</p>
				</a>
				<a href="javascript:void(0);" id="html5_cart" class="new-tbl-cell">
					<span class="icon3 on">购物车</span>
					<p class="on" style="color:#6e6e6e;">购物车</p>
				</a>
				<a href="memberCenter" class="new-tbl-cell">
					<span class="icon4">用户中心</span>
					<p style="color:#6e6e6e;">用户中心</p>
				</a>
			</div>
		</div>
	</header>
	<link href="/mobileStore/images/css/title-bar.css" media="all" rel="stylesheet" type="text/css">
	<link href="/mobileStore/images/css/btn.css" media="all" rel="stylesheet" type="text/css">
	<link href="/mobileStore/images/css/checkbox.css" media="all" rel="stylesheet" type="text/css">
	<link href="/mobileStore/images/css/spinner.css" media="all" rel="stylesheet" type="text/css">
	<link href="/mobileStore/images/css/shopping-cart.css" media="all" rel="stylesheet" type="text/css">
	
	<style>
		.cart_item_text{
		    font-size:13px;
		    font-weight: bold;
			overflow:hidden;
			display: -webkit-box;
			-webkit-line-clamp: 2;
			-webkit-box-orient: vertical;
		}
		.cart_item_title{
		    font-size:14px;
		}
		.cart_item_gift{
		    font-size:13px;
			color: #999;
		}
		.cart_item_price{
		    font-size:12px;
		}
		.cart_cutwords{
			overflow:hidden;
			display: -webkit-box;
			-webkit-line-clamp: 1;
			-webkit-box-orient: vertical;
		}
	</style>
	<#--
	<div class="login-wrapper">
        <div class="header-login-info">
            <div class="header-login-info-left">登录后可同步电脑与手机购物车中的商品</div>
            <div class="header-login-info-right">
                <a class="btn-jd-red" href="https://passport.m.jd.com/user/login.action?sid=33a8a5e2836dc8c2f597d4a8cddf4673">
                	登录
                </a>
            </div>
        </div>
    </div>
    -->
	<div style="width: 100%; z-index: 1001; position: absolute; overflow: hidden; background: none repeat scroll 0% 0% rgba(145, 145, 145, 0.4); display: none; height: 379px;" id="background">
	</div>
	<div class="pop" id="giftWares11" style="margin-top:45px;margin-bottom:5%;z-index:1005;position: absolute;display:none"></div>
	<#if shoppingCartMap?has_content && shoppingCartMap.getShoppingCartList()?has_content && (shoppingCartMap.size()&gt;0)>
		<div id="notEmptyCart" style="display:block">
			<ul class="shp-cart-list">
	            <#list shoppingCartMap.getShoppingCartList() as innerCart>
	            	<#if (innerCart.size()>0)>
		        		<#assign cartCurrency= "CNY"/>
                 		<#assign cartCurrency = innerCart.getCurrency()/>
                 		<#assign productStoreId= innerCart.getProductStoreId()/>
						<#assign productStorePrefix = Static["org.ofbiz.base.util.UtilHttpExt"].getProductStorePrefix(request,productStoreId)?if_exists />
		               	<#assign productStore = Static["org.ofbiz.product.store.ProductStoreWorker"].getProductStore(productStoreId, delegator)?if_exists />
         		        <#list innerCart.items() as cartLine>
            				<#assign cartLineIndex = innerCart.getItemIndex(cartLine) />
            				<#if cartLine.getParentProductId()?exists>
		                        <#assign parentProductId = cartLine.getParentProductId() />
		                    <#else>
		                        <#assign parentProductId = cartLine.getProductId() />
		                    </#if>
		                    <#assign smallImageUrl = Static["org.ofbiz.product.product.ProductContentWrapper"].getProductContentAsText(cartLine.getProduct(), "SMALL_IMAGE_URL", locale, dispatcher)?if_exists />
		                    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/mobileStore/images/imgs/543699aeN04b5258e.jpg" /></#if>
		                    <li id="product${cartLine.getProductId()!}">
								<div class="items">
									<div class="check-wrapper">
										<span id="checkIcon1333963139" class="cart-checkbox checked" onclick="changeSelected(cartLine.getProductId(),1)"></span>
									</div>
									<div class="shp-cart-item-core">
										<div class="cart-product-cell-3">
											<span class="shp-cart-item-price" id="price${cartLine.getProductId()}"><@ofbizCurrency amount=cartLine.getDisplayPrice() isoCode=innerCart.getCurrency()/></span>
										</div>
										<a class="cart-product-cell-1" href="productDetail?product_id=${cartLine.getProductId()!}">
											<img class="cart-photo-thumb" alt="" src="${smallImageUrl!}" onerror="/mobileStore/images/imgs/error-jd.gif">
										</a>
										<div class="cart-product-cell-2">
											<div class="cart-product-name">
												<a href="productDetail?product_id=${cartLine.getProductId()!}">
													<span>
									                   	<#-- 判断商品语种-->
									 					<#assign product=cartLine.getProduct() />
														<#assign productName = Static["org.ofbiz.product.product.EbizProductContentWrapper"].getProductTitleByLocale(product, request)/>
														${productName!}
									                    
									                    : ${cartLine.getDescription()?if_exists}</a>
									                    <#if cartLine.getConfigWrapper()?exists>
									                        <#assign selectedOptions = cartLine.getConfigWrapper().getSelectedOptions()?if_exists />
									                        <#if selectedOptions?exists>
									                            <div>&nbsp;</div>
									                            <#list selectedOptions as option>
									                                <div>
									                                ${option.getDescription()}
									                                </div>
									                            </#list>
									                        </#if>
									                    </#if>
													</span>
												</a>
											</div>
											<div class="shp-cart-opt">
												<div class="quantity-wrapper">
													<input id="limitSukNum${cartLine.getProductId()!}" value="200" type="hidden">
													<a class="quantity-decrease <#if cartLine.getQuantity() &lt; 2>disabled</#if>" id="subnum${cartLine.getProductId()!}" href="javascript:subWareBybutton('num${cartLine.getProductId()!}')">-</a>
													<input class="quantity" size="4" onchange="modifyWareIII('${cartLine.getProductId()!}','oldQuantity${cartLine.getProductId()!}',this)" value="${cartLine.getQuantity()?string.number}" name="PS${productStoreId!}_update_${cartLine_index}" id="num${cartLine.getProductId()!}" type="text">
													<input type="hidden" id="oldQuantity${cartLine.getProductId()!}" value="${cartLine.getQuantity()?string.number}"/>
													<a class="quantity-increase" id="addnum${cartLine.getProductId()!}" href="javascript:addWareBybutton('num${cartLine.getProductId()!}')">+</a>
												</div>
												<a class="shp-cart-icon-remove" href="javascript:deleteWareII('${productStoreId!}','DELETE_${cartLine_index}')"></a>
											</div>
										</div>
									</div>
								</div>
							</li>
                 		</#list>
					</#if>
				</#list>
				<#--
				<li id="product181956465">
					<a id="shopping181956465" href="javascript:beActPage('act/XYcDsFpqUHu4dJ2T.html',11,'',1)" class="shp-cart-conditions-link" style="display: none">
					</a>
					<span id="spanshopping181956465" class="shp-cart-conditions-span" style="overflow:hidden;">
						<span class="icon-condition" id="gift-info-sign181956465">
							满减
						</span>
						<span class="condition-description">
							<span id="sTip181956465">
								已购满1件，已减14.4元
							</span>
							<a id="notGivenGift181956465" style="display:none" href="javascript:showChooseGifts('1'%20,'181956465','1','11','652887','1',)" class="btn-white">
							领取赠品
							</a>
						</span>
					</span>
					<div class="diver-hr-dashed clear"></div>
					<div class="items" id="product652887" name="item181956465">
						<div class="check-wrapper">
							<span class="cart-checkbox checked" id="checkIcon652887" onclick="changeSelected('181956465','1','11',652887,1)"></span>
						</div>
						<div class="shp-cart-item-core">
							<div class="cart-product-cell-3">
								<span class="shp-cart-item-price" id="price181956465652887">￥36.00</span>
							</div>
							<a class="cart-product-cell-1" href="http://m.jd.com/product/652887.html?sid=ab5f2d88b7213177bb0d817d9be78b11">
								<img class="cart-photo-thumb" alt="" src="/mobileStore/images/imgs/rBEhVlMdXWYIAAAAAAIekN-ec4kAAJ5GwKrIhQAAh6o265.jpg" onerror="http://misc.360buyimg.com/lib/skin/e/i/error-jd.gif">
							</a>
							<div class="cart-product-cell-2">
								<div class="cart-product-name">
									<a href="http://m.jd.com/product/652887.html?sid=ab5f2d88b7213177bb0d817d9be78b11"><span>维达 抽纸 倍韧2层150抽面巾纸*8包</span></a>
								</div>
								<div class="shp-cart-opt">
									<div class="quantity-wrapper">
										<input id="limitSukNum652887" value="200" type="hidden">
										<a class="quantity-decrease disabled" id="subnum652887" href="javascript:subWareBybutton('181956465','1',11,652887,1)">-</a>
										<input size="4" value="1" name="num" id="num652887" class="quantity" onchange="modifyWare('181956465','1',11,652887,1)" type="text">
										<a class="quantity-increase" id="addnum652887" href="javascript:addWareBybutton('181956465','1',11,652887,1,1)">+</a>
									</div>
									<a class="shp-cart-icon-remove" id="addnum652887" href="javascript:deleteWare('181956465','1',11,652887,1)"></a>
								</div>
							</div>
						</div>
					</div>
				</li>
				-->
			</ul>
			<div class="tips tips-save-money" id="pay-tip">钻石会员满39元免运费，钻石会员以下满59元免运费</div>
		</div>
		<div id="payment_p" style="display:block">
			<div id="paymentp"></div>
			<div class="payment-total-bar" id="payment">
				<div class="shp-chk">
					<span onclick="checkAllHandler();" class="cart-checkbox checked" id="checkIcon-1"></span>
				</div>
				<div class="shp-cart-info">
					<strong class="shp-cart-total">总计:<span class="" id="cart_realPrice"><@ofbizCurrency amount=shoppingCartMap.getGrandTotal() isoCode=cartCurrency/></span></strong>
					<span class="sale-off">商品总额:￥<span class="bottom-bar-price" id="cart_oriPrice">---</span> 返现:￥<span class="bottom-bar-price" id="cart_rePrice">---</span></span>
				</div>
				<a style="background: none repeat scroll 0% 0% rgb(192, 0, 0);" href="checkoutCart" class="btn-right-block" id="submit">结算(<span id="checkedNum">${shoppingCartMap.getTotalQuantity()!}</span>)</a>
			</div>
		</div>
	<#else>
		<div id="emptyCart">
			<div class="empty-sign"></div>
			<div class="empty-warning-text">购物车空空如也，快去购物吧</div>
			<div class="empty-btn-wrapper">
				<a href="main" class="btn-jd-darkred btn-large">去逛逛</a>
			</div>
		</div>
	</#if>
	<div id="mask" style="visibility: hidden">
		<div id="mask-wraper">
			<div id="mask-con">
			</div>
		</div>
	</div>

	<input id="newOrderServer" value="true" type="hidden">
	<input id="cartNum" value="2" type="hidden">
	<input id="limitWareNum" value="1000" type="hidden">
	<input id="limitCartNum" value="50" type="hidden">
	<input id="limitBookNum" value="1000" type="hidden">
	<input id="limitNotBookNum" value="200" type="hidden">
	<input id="resourceType" value="" type="hidden">
	<input id="resourceValue" value="" type="hidden">
	<input id="sid" value="ab5f2d88b7213177bb0d817d9be78b11" type="hidden">
	<script type="text/javascript" src="/mobileStore/images/js/cart.js"></script>
	<script>
	var cartUse =  'true';
	$(document).ready(function(){
		document.getElementById("background").style.height=document.getElementById("body").scrollHeight+20+"px";
		judgeSubmit($("#cart_realPrice").text());
	    //重新设置字体大小
	    //resizePriseFontSize();
	    //resizeBottomPriseFontSize();
	
	    //判断屏幕旋转
	    //doOnOrientationChange();
	});
	</script>

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
		    if(2!=0 && !$clearCart && !$teamId){
				$("#html5_cart_num").text(2>0>0);
			}
		}else{
			updateToolBar('');
		}
		
		$("#html5_cart").click(function(){
			//syncCart('ab5f2d88b7213177bb0d817d9be78b11',true);
			//location.href='/cart/cart.action';
		});
		
		function reSearch(){
		var depCity = window.sessionStorage.getItem("airline_depCityName");
			if(testSessionStorage() && isNotBlank(depCity) && !/^\s*$/.test(depCity) && depCity!=""){
		    	var airStr = '<form action="/airline/list.action" method="post" id="reseach">'
		        +'<input type="hidden" name="sid"  value="ab5f2d88b7213177bb0d817d9be78b11"/>'
		        +'<input type="hidden" name="depCity" value="'+ window.sessionStorage.getItem("airline_depCityName") +'"/>'
		        +'<input type="hidden" name="arrCity" value="'+ window.sessionStorage.getItem("airline_arrCityName") +'"/>'
		        +'<input type="hidden" name="depDate" value="'+ window.sessionStorage.getItem("airline_depDate") +'"/>'
		        +'<input type="hidden" name="depTime" value="'+ window.sessionStorage.getItem("airline_depTime") +'"/>'
		        +'<input type="hidden" name="classNo" value="'+ window.sessionStorage.getItem("airline_classNo") +'"/>'
		        +'</form>';
		    	$("body").append(airStr);
		    	$("#reseach").submit();
			}else{
		    	window.location.href='/airline/index.action?sid=ab5f2d88b7213177bb0d817d9be78b11';
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
				_loadScript("/js/2013/installapp.js?v=20141231",{},function(){
					 $("#clientArea").length && downcheck($("#clientArea"),false);
				});
			}
					
		})
		function addWareBybutton(quantityInputId){
			spinerShow();
			var quantityInputObj = $("#"+quantityInputId);
			var oldQuantity = quantityInputObj.val();
			var name = quantityInputObj.attr("name");
			try{
				var quantity = parseInt(oldQuantity)+1;
				if(name && quantity){
					location.href = "modifyProductQuantityII?"+name+"="+quantity
				}
			}catch(e){
			}
		}
		function subWareBybutton(quantityInputId){
			var quantityInputObj = $("#"+quantityInputId);
			var oldQuantity = quantityInputObj.val();
			var name = quantityInputObj.attr("name");
			if(oldQuantity=='1'){
				return;
			}
			spinerShow();
			try{
				var quantity = parseInt(oldQuantity)-1;
				if(name && quantity>0){
					location.href = "modifyProductQuantityII?"+name+"="+quantity
				}
			}catch(e){
				spinerHide();
			}
		}
		function deleteWareII(productStoreId,indexName){
			if(indexName && productStoreId && confirm("确定删除此商品？")){
				spinerShow();
				location.href = "removeCartItem?"+indexName+"=Y&productStoreId="+productStoreId;
			}
		}
		function modifyWareIII(productId,oldProductId,obj){
			spinerShow();
			var oldQuantity = $("#"+oldProductId).val();
			var nowQuantity = obj.value;
			var name = obj.name;
			try{
				if(nowQuantity && name){
					location.href = "modifyProductQuantityII?"+name+"="+nowQuantity
				}else{
					spinerHide();
				}
			}catch(e){
				obj.value=oldQuantity;
				spinerHide();
			}
		}
	</script>
</body>