<#assign price = priceMap?if_exists />
<#assign productImageList = productImageList?if_exists />
<#assign productStore1 = productStore?if_exists />
<#assign baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()/>
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
	
	<#if featuresMapJsonStr??>
		var featuresMap = eval('${StringUtil.wrapString(featuresMapJsonStr)}');
	</#if>
	<#if defaultFeatureCombineJsonStr??>
		var defaultFeatureCombine = eval('${StringUtil.wrapString(defaultFeatureCombineJsonStr)}');
	</#if>
	<#if productFeatureCategoryIdSet??>
		var productFeatureCategoryIdSet = [];
		<#list productFeatureCategoryIdSet as productFeatureCategoryId>
			productFeatureCategoryIdSet.push("${productFeatureCategoryId}");
		</#list>
	</#if>
	function checkThisFeature(productFeatureCategoryId ,productFeatureId ,element ){
		var oldId = $("#"+productFeatureCategoryId).data("productFeatureId");
		$("#"+productFeatureCategoryId).data("productFeatureId",productFeatureId);
		var prodInfo = getChoseProduct();
		if(prodInfo){
			var productId = prodInfo.productId;
			var price = prodInfo.productPrice.defaultPrice;
			if(oldId!=productFeatureId && productId){
				$("#"+productFeatureCategoryId).find("a").removeClass("active");
				$(element).addClass("active");
				$("#add_product_id").val(productId);
				$("#price").html(price||'暂无报价');
			}
		}
		if(false){
			location.href="productDetail?product_id="+productId;
		}
	}
	function getChoseProduct(){
		if(featuresMap && productFeatureCategoryIdSet){
			prodInfo = featuresMap;
			for(var i = 0;i < productFeatureCategoryIdSet.length; i++){
				var productFeatureCategoryId = productFeatureCategoryIdSet[i]
				var productFeatureId = $("#"+productFeatureCategoryId).data("productFeatureId");
				prodInfo = prodInfo[productFeatureId]
			}
			return prodInfo;
		}
	}
	$(function(){
		if(productFeatureCategoryIdSet && defaultFeatureCombine){
			for(var i = 0;i < productFeatureCategoryIdSet.length; i++){
				var productFeatureCategoryId = productFeatureCategoryIdSet[i];
				var productFeatureId = defaultFeatureCombine[productFeatureCategoryId];
				$("#"+productFeatureCategoryId).data("productFeatureId",productFeatureId);
			}
		}
		adjustFnameWidth();
	});
</script>
<body id="body">
	<span style="display:none;">
	  	<!--RF_PRODINFO  区分 作用 -->
	  	<input type="hidden" name="custRequestTypeId" id="custRequestTypeId" value="${custRequestTypeId!parameters.custRequestTypeId!}">
	  	<!--卖家的ID 或者说是店铺的ID--> 
	  	<input type="hidden" name="productStoreId" id="productStoreId" value="${productStoreId!parameters.productStoreId!}">
	  	<!--买家的ID--> 
	  	<input type="hidden" name="fromPartyId" id="fromPartyId" value="${fromPartyId!parameters.fromPartyId!}">
	   	<!--商品的ID--> 
	  	<input type="hidden" name="productId" id="productId" value="${productId!parameters.productId!}">
        <input type="hidden" name="add_product_id" id="add_product_id" value="<#if (product.isVirtual)?? && product.isVirtual == 'Y'>${add_product_id!(defaultProductInfo.productId)!}<#else>${productId!parameters.productId!}</#if>"/>
	</span>
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
					<a id="openJD" app_href="openApp.jdMobile://virtual?params={&quot;category&quot;:&quot;jump&quot;,&quot;des&quot;:&quot;productDetail&quot;,&quot;skuId&quot;:&quot;854234&quot;,&quot;sourceType&quot;:&quot;JSHOP_SOURCE_TYPE&quot;,&quot;sourceValue&quot;:&quot;JSHOP_SOURCE_VALUE&quot;}" href="http://item.m.jd.com/download/downApp.html?sid=e05342df03dd29ae84a48b2e06c03af7"><span class="open_btn">立即打开</span></a>
				</div>
				<div class="close-btn-con close-btn">
					<span class="close-btn-icon"></span>
				</div>
			</div>
		</div>-->
		<div class="new-header">
			<a href="javascript:pageBack();" class="new-a-back" id="backUrl"><span>返回</span></a>
			<h2>商品详情</h2>
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
	<script type="text/javascript" src="/mobileStore/images/js/view.js"></script>
	<!--<script type="text/javascript" src="/mobileStore/images/js/jdslider.js"></script>-->
	<button id="tempforsuite" style="display:none;"></button>
	<div id="mainLayout">
		<div id="mainStay" class="new-wt">
			<div class="miblebox" id="goods-img-box">
				<div class="new-p-re">
					<div class="detail-img">
						<div id="_zoom" class="imgbox">
							<div id="imgSlider" class="imgbox-i" style="position:relative;left:0px;"> 
								<span class="tbl-cell">
									<#assign imgMap = Static["org.ofbiz.ebiz.product.ProductHelper"].getProdImgPaths(productId,"EB_PRODIMG_INFO",delegator)/>
							    	<#assign flag=imgMap.flag />
							     	<#assign imgList = imgMap.imgPathList/>
									<img width="320" height="292" seq="0" src="${baseUrl+(imgList?first)}">
								</span>
							</div>
							<div class="last-msg-txt" id="tips"></div>
						</div>
						<input type="hidden" value="${baseUrl+(imgList?first)}" id="imgs">
						<div class="detail-price">
							<span id="price" class="p-price">
								<#assign prices = delegator.findByAnd("ProductPrice",{"productId":parameters.product_id},["currencyUomId"],false)?if_exists />
								<#if prices?size &gt; 0>
									<@ofbizCurrency amount=prices[0].price isoCode=prices[0].currencyUomId />
								<#else>
									${(defaultProductInfo.productPrice.defaultPrice)!}
								</#if>
								<#--￥${(prices[0].price)!'暂无报价'}-->
								<#--
								<#if price.competitivePrice?exists && price.price?exists && price.price &lt; price.competitivePrice>
				           			<@ofbizCurrency amount=price.competitivePrice isoCode=price.currencyUsed />
					         	</#if>
			          			<#if price.listPrice?exists && price.price?exists && price.price &lt; price.listPrice>
			          				<@ofbizCurrency amount=price.listPrice isoCode=price.currencyUsed />
			          				<@ofbizCurrency amount=price.listPrice isoCode=price.currencyUsed />
			          			</#if>
			          			<#if price.listPrice?exists && price.defaultPrice?exists && price.price?exists && price.price &lt; price.defaultPrice && price.defaultPrice &lt; price.listPrice>
			         				<@ofbizCurrency amount=price.defaultPrice isoCode=price.currencyUsed />
			        			</#if>
			          			<#if price.specialPromoPrice?exists>
			            			<@ofbizCurrency amount=price.specialPromoPrice isoCode=price.currencyUsed />
			           			</#if>
			           			-->
							</span>
							<span id="imgpage" class="pagenum">1/1</span>
							<a id="attention" class="btn-sc"></a>
						</div>
					</div>
				</div>
				<div id="spinner1" class="spinner" style="left:50%;position: absolute;height:120px;margin-top:50px;z-index:1000"></div>
				<div class="goodsinfo">
					<h1 class="detail-title" id="title"> 
						<a id="wareName" class="dis-blk" href="javascript:void(0);">
						<#assign productName = Static["org.ofbiz.product.product.EbizProductContentWrapper"].getProductTitleByLocale(product, request)/>
				          	${productName!}
						</a>
					</h1>
				 	<p class="subtitle" id="promotionInfo">&nbsp;</p> 							
			 	</div>
			</div>
			<span class="pop-attention" style="position:absolute;z-index:9999;display:none" id="save">
				<span class="icon-succ" id="guanzhu">关注成功</span>
			</span>
			<div class="saleinfo miblebox">
				<#--促销
				<dl class="list-entry"> 
					<dt class="row01" id="promotionitem">
						<span class="col01">促销：</span>
						<span class="col02 reverse-cell" id="sale"><i class="icon-bg02">加价购</i></span>
						<em class="icon-up"></em>
					</dt>
					<dd class="row02">
						<ul class="list-saleinfo" id="saleInfo">
							<li><span class="col02"><em class="icon-bg02">加价购</em><span class="txt01">满8.00另加15.90元，或满38.00另加1.00元，或满69.00另加13.90元</span></span></li>
						</ul>
					</dd>
				</dl>
				-->
				<dl class="list-entry"> 
					<dt class="row01">
						<span class="col01">规格：</span><!---->
						<span class="col02" id="guige">
							<#if product.isVirtual?if_exists?upper_case == "Y">
							</#if>
							<span id="amount">
								1件<span></span>
								<em class="icon-up"></em>
							</span>
						</span>
					</dt>
					<dd class="row02">
						<#if product.isVirtual?if_exists?upper_case == "Y" && cateFeatureInfo?? && productFeatureCategoryIdSet??>
							<#list productFeatureCategoryIdSet as key>
								<#assign featureInfo = cateFeatureInfo[key]?if_exists/>
								<#assign featureIds = featureInfo.featureIds?if_exists/>
								<section class="select" id="proSize">
									<p class="label" name="featureInfo_name">${featureInfo.name!}</p>
									<p class="option" id="${key}">
										<#if featureIds?? && featureIds?size &gt; 0>
											<#list featureIds as featureId>
												<#assign feature = delegator.findOne("ProductFeature",true,{"productFeatureId":featureId})?if_exists/>
												<a href="javascript:void(0);" onclick="checkThisFeature('${key}','${featureId}',this);" date="noCurrent" wareid="652887" class="link-check<#if defaultFeatureCombine?? && defaultFeatureCombine[key]==featureId> active</#if>">${feature.description!}</a>&nbsp;
											</#list>
										</#if>
										<#--<a title="150抽8包（中）" href="http://item.m.jd.com/product/652887.html?resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7" date="noCurrent" wareid="652887" class="link-check">150抽8包（中）</a>
										&nbsp;
										<a title="200抽3包（小）" class="link-check active" date="currentSize">200抽3包（小）</a>
										&nbsp;
										<a title="200抽3包（中）" href="http://item.m.jd.com/product/854238.html?resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7" date="noCurrent" wareid="854238" class="link-check">200抽3包（中）</a>
										&nbsp;
										<a title="150抽3包（中）" href="http://item.m.jd.com/product/854263.html?resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7" date="noCurrent" wareid="854263" class="link-check">150抽3包（中）</a>
										&nbsp;
										<a title="180抽6包（中）" href="http://item.m.jd.com/product/1075090.html?resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7" date="noCurrent" wareid="1075090" class="link-check">180抽6包（中）</a>
										&nbsp;
										<a title="180抽6包（小）" href="http://item.m.jd.com/product/1075096.html?resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7" date="noCurrent" wareid="1075096" class="link-check">180抽6包（小）</a>
										&nbsp;
										<a title="150抽3包（大）" href="http://item.m.jd.com/product/1241850.html?resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7" date="noCurrent" wareid="1241850" class="link-check">150抽3包（大）</a>
										&nbsp;-->
									</p>
								</section>
							</#list>
							<script type="text/javascript">
								function adjustFnameWidth(){
									var pElems = $("p[name=featureInfo_name]");
									var maxWidth = 0;
									if(pElems){
										for(var i=0;i<pElems.length;i++){
											var ctt = pElems[i].innerHTML;
											var testWidthSpan = $("#testWidth");
											testWidthSpan.html(ctt);
											var w = testWidthSpan[0].offsetWidth;
											if(w>maxWidth){
												maxWidth = w;
											}
										}
										$("p[name=featureInfo_name]").css("width",maxWidth+'px');
									}
								}
							</script>
						</#if>
						<section class="select">
							<p class="label">数量</p>
							<p class="option">
								<a class="btn-del" id="minus" onclick="minus();">-</a>
								<input type="text" class="fm-txt" value="1" id="number" autocomplete="off" onblur="modify();">
								<a class="btn-add" id="plus" onclick="plus();">+</a>
							</p>
						</section>
					</dd>
				</dl>
				<dl class="list-entry-extra">
					<#--
					<dt class="row01">
						<span class="col01">送至：</span>
						<span class="col02">
							<div class="address address01">
								<span class="fm-sele-box" id="provincetip">
									<select class="fm-select" id="province"><script language="javascript">$(document).ready(function(){$('#pShow').text('北京');});</script><option value="1" selected="selected"> 北京</option><option value="2"> 上海</option><option value="3"> 天津</option><option value="4"> 重庆</option><option value="5"> 河北</option><option value="6"> 山西</option><option value="7"> 河南</option><option value="8"> 辽宁</option><option value="9"> 吉林</option><option value="10"> 黑龙江</option><option value="11"> 内蒙古</option><option value="12"> 江苏</option><option value="13"> 山东</option><option value="14"> 安徽</option><option value="15"> 浙江</option><option value="16"> 福建</option><option value="17"> 湖北</option><option value="18"> 湖南</option><option value="19"> 广东</option><option value="20"> 广西</option><option value="21"> 江西</option><option value="22"> 四川</option><option value="23"> 海南</option><option value="24"> 贵州</option><option value="25"> 云南</option><option value="26"> 西藏</option><option value="27"> 陕西</option><option value="28"> 甘肃</option><option value="29"> 青海</option><option value="30"> 宁夏</option><option value="31"> 新疆</option><option value="32"> 台湾</option><option value="42"> 香港</option><option value="43"> 澳门</option><option value="84"> 钓鱼岛</option></select>
									<i id="pShow" style="font-style:normal;">北京</i>
								</span>
								<span class="fm-sele-box" id="citytip">
									<select class="fm-select" id="city"><script language="javascript">$('#citytip').append('朝阳区');</script><option value="72" selected="selected"> 朝阳区</option><option value="2800"> 海淀区</option><option value="2801"> 西城区</option><option value="2802"> 东城区</option><option value="2803"> 崇文区</option><option value="2804"> 宣武区</option><option value="2805"> 丰台区</option><option value="2806"> 石景山区</option><option value="2807"> 门头沟</option><option value="2808"> 房山区</option><option value="2809"> 通州区</option><option value="2810"> 大兴区</option><option value="2812"> 顺义区</option><option value="2814"> 怀柔区</option><option value="2816"> 密云区</option><option value="2901"> 昌平区</option><option value="2953"> 平谷区</option><option value="3065"> 延庆县</option></select>朝阳区
								</span>
								<span class="fm-sele-box" id="countrytip">
									<select class="fm-select" id="country"><option value="2799"> 三环以内</option><option value="2819"> 三环到四环之间</option><option value="2839"> 四环到五环之间</option><option value="2840"> 五环到六环之间</option><script language="javascript">$('#countrytip').append('管庄');</script><option value="4137" selected="selected"> 管庄</option><option value="4139"> 北苑</option><option value="4211"> 定福庄</option></select>管庄
								</span>
							</div>
							<p class="row01col03" id="stockStatus">现货，23:00前完成下单，预计明日（01月19日）送达</p>
						</span>
					</dt>-->
					<dt class="row03" id="fare">
						<!--<span class="col01">运费：</span>-->
						<span class="col02" id="fareMoney"></span>
					</dt> 
					<div class="promise-ico">
						<span class="txt02">
							<i class="icon-bg03"><img src="/mobileStore/images/imgs/rBEhWlLL0iUIAAAAAAAGR2aPiNQAAHq0gJ8jrQAAAZf583.jpg" width="15" height="15">211限时达</i> 
							<span class="txt">上午下单，下午送达</span>
						</span>
						<span class="txt02">
							<i class="icon-bg03"><img src="/mobileStore/images/imgs/rBEhUlLL13kIAAAAAAAEeT_oUHcAAHskQP_-boAAASR577.jpg" width="15" height="15">货到付款</i> 
							<span class="txt">支持送货上门后再收款，支持现金、POS机刷卡等方式</span>
						</span>
						<span class="txt02">
							<i class="icon-bg03"><img src="/mobileStore/images/imgs/rBEhWlLL0P8IAAAAAAAETM3054QAAHqzwGz1eAAAARk092.jpg" width="15" height="15">自提</i> 
							<span class="txt">自提免运费，支持自提点，自助提货柜，移动自提车等自提服务。</span>
						</span>
						<em class="icon-up"></em>
					</div>
				</dl>
				<dl class="list-entry">
					<dt class="row01"><a href="javascript:void(0);" id="wareInfo"><span class="col01">商品详情</span><em class="icon-arr"></em></a></dt>
				</dl>
			</div>
			<div class="miblebox goodseval">
				<div class="info"><a id="btnAssess" href="productReviews?productId=${productId!}"><span class="text">商品评价</span><span class="text-fr"><em id="comments">296325</em> 人评价<em id="goods">98%</em> 好评</span></a><i class="icon-arr"></i></div>
					<!--<div class="eval-box">
						<div class="eval-box-i"><a id="orderComment" class="btn-good" href="javascript:void(0);"><span class="icon icon-sd"></span> 商品晒单(2131)</a><a id="consultations" class="btn-ser" href="javascript:void(0);"><span class="icon icon-cons"></span> 购买咨询(85)</a></div>
					</div>-->
				</div>
			
				<div class="miblebox img-list-border">
					<div class="img-list">
						<h3 class="mible-title">猜你还喜欢：</h3>
						<div id="guessing" class="jd-slider-wrapper">
							<div class="jd-slider-container" style="width: 1224px; height: 298px;">
								<!--<a href="http://item.m.jd.com/product/854240.html?resourceType=recommend_productDetail&csku=854234&expid=90200700014090201&index=0&rid=902007&sid=e05342df03dd29ae84a48b2e06c03af7" class="jd-slider-item" style="width: 102px;">
									<div class="pro-img">
										<span class="img">
											<img width="80" height="80" alt="img" src="/mobileStore/images/imgs/rBEQWFF2UyoIAAAAAAJO-QbmZeAAAEyWwEh7gIAAk8R367.jpg">
										</span>
										<span class="pro-title">维达 抽纸 超韧3层130抽面巾纸*6包(小规格)</span>
										<span class="pro-price">
											<span class="pro-price">¥13.90</span>
										</span>
									</div>
								</a>
								<a href="http://item.m.jd.com/product/854238.html?resourceType=recommend_productDetail&csku=854234&expid=90200700014090201&index=1&rid=902007&sid=e05342df03dd29ae84a48b2e06c03af7" class="jd-slider-item" style="width: 102px;">
									<div class="pro-img">
										<span class="img">
											<img width="80" height="80" alt="img" src="/mobileStore/images/imgs/rBEQWFF2UxwIAAAAAAIMUrp8SDMAAEyWgOwa1cAAgxq091.jpg">
										</span>
										<span class="pro-title">维达 抽纸 倍韧2层200抽面巾纸*3包（中规格）</span>
										<span class="pro-price">
											<span class="pro-price">¥9.90</span>
										</span>
									</div>
								</a>
								<a href="http://item.m.jd.com/product/1003074.html?resourceType=recommend_productDetail&csku=854234&expid=90200700014090201&index=23&rid=902007&sid=e05342df03dd29ae84a48b2e06c03af7" class="jd-slider-item" style="width: 102px;">
								<div class="pro-img"><span class="img"><img width="80" height="80" alt="img" src="/mobileStore/images/imgs/rBEhWFJzZMkIAAAAAAJEWGBgLp8AAE3kwGDgIAAAkRw121.jpg"></span>
								<span class="pro-title">清风（APP） 抽取式面纸 紫罗兰香 200抽3包</span><span class="pro-price"><span class="pro-price">¥14.90</span>
								</span></div>
								</a>-->
							</div>
						</div>
					</div>
				</div>
				<div id="cart1" class="cart-btns-fixed" style="display: table;">
					<div class="cart-btns-fixed-box">
						<a class="btn btn-buy" id="directorder" href="javascript:void(0);" onclick="addItemBuy();">立即购买</a>
						<a class="btn btn-cart" id="add_cart" href="javascript:void(0);" onclick="addItem();">加入购物车</a>
						<a href="shoppingCart" id="toCart" class="btn cart-num"></a>
					</div>
				</div>
				<div id="yuyuecart" style="width:100%;position:fixed;bottom:0;display:none">
					<div class="tbl-type detail-tbn2">
						<div class="tbl-cell">
							<a class="btn-cart-1" id="cartyuyue"><span></span>加入购物车</a>
						</div>
					</div>
				</div>
				<div id="yuyueing" style="width:100%;position:fixed;bottom:0;display:none">
					<div class="tbl-type detail-tbn2">
						<div class="tbl-cell">
							<a class="btn-yuyue" data=""><span class="icon-clock"></span><span id="yuyuetime"></span><span class="txt-yuyue" id="yuyuecontext"><span></span>开始预约</span></a>
						</div>
					</div>
				</div>
				<div id="yuyuenow" style="width:100%;position:fixed;bottom:0;display:none">
					<div class="tbl-type detail-tbn2">
						<div class="tbl-cell">
							<a class="btn-yuyue2" href="http://item.m.jd.com/yuyue/854234.html?sid=e05342df03dd29ae84a48b2e06c03af7" id="nowyuyue"><span class="icon-clock"></span><span class="txt-yuyue" id="yuyuenowcontext"><span></span>立即预约</span></a>
						</div>
					</div>
				</div>
				<div id="yuyueend" style="position:fixed;width:100%;bottom:0;display:none">
					<div class="tbl-type detail-tbn2">
						<div class="tbl-cell">
							<a class="btn-yuyue2"><span class="icon-clock"></span><span class="txt-yuyue" id="yuyueendcontext"><span>抢购已结束</span></span></a>
						</div>
					</div>
				</div>
				<div class="pop" style="position:absolute;z-index:9999;display:none" id="tip">
					<p>
						<span class="pop-txt"></span>
					</p>
					<div class="pop-txt-area">
						<span class="pop-txt2" id="tips">
						</span>
					</div>
					<div class="tbl-type">
						<a href="javascript:void(0)" onclick="$(&#39;#tip&#39;).hide();$(&#39;#_mask&#39;).hide();" class="tbl-cell" style="width:50%">知道啦</a>
						<a href="javascript:void(0)" id="myyuyue" class="tbl-cell" style="width:50%">我的预约</a>
					</div>
				</div>
				<div class="cart-pop" id="cart" style="display: none; position: absolute; bottom: 50%; z-index: 9999; left: 356px;">
					<div class="ico-succ">
						<span class="att-succ">添加成功！</span>
						<span class="cart-succ">商品已成功加入购物车</span>
					</div>
				</div>	
				<div class="menu-fixed"> 
					<ul class="menu-fixed-list">
						<li class="fore01"><a href="http://item.m.jd.com/index.html?sid=e05342df03dd29ae84a48b2e06c03af7">首页</a></li>
						<li class="fore02"><a href="http://m.jd.com/category/all.html?sid=e05342df03dd29ae84a48b2e06c03af7">搜索</a></li>
						<li class="fore03"><a href="http://item.m.jd.com/cart/cart.action?sid=e05342df03dd29ae84a48b2e06c03af7"> 购物车</a></li>
						<li class="fore04"><a href="http://item.m.jd.com/user/home.action?sid=e05342df03dd29ae84a48b2e06c03af7">用户中心</a></li>
					</ul>
					<div class="menu-fixed-mini"><a href="javascript:void(0)"></a></div>
				</div>
			</div>
			<input type="hidden" id="currentWareId" value="854234">
			
			<input type="hidden" id="onlineService" value="true">
			<input type="hidden" id="newOrderServer" value="true">
			<input type="hidden" id="sid" value="e05342df03dd29ae84a48b2e06c03af7">
			<input type="hidden" id="resourceType" value="search">
			<input type="hidden" id="resourceValue" value="">
			<input type="hidden" id="stockFlag" value="true">
			<input type="hidden" id="teamSign" value="0">
			<input type="hidden" id="imgUrl" value="http://img14.360buyimg.com/n5/g10/M00/18/10/rBEQWFF2Uw8IAAAAAAHI0WUQrRkAAEyWgIXSvAAAcjp107.jpg!q50.jpg">
			<input type="hidden" id="goodName" name="goodName" value="维达 抽纸 倍韧2层200抽面巾纸*3包(小规格)">
			<input type="hidden" id="jdPrice" name="jdPrice" value="7.90">
			<input type="hidden" id="jshop" value="">
			<input type="hidden" id="passportUse" value="true">
			<input type="hidden" id="yuyueType" value="5">
			<input type="hidden" id="onlineService" value="true">
			<input type="hidden" id="cartFlag" value="true">
			<input type="hidden" id="yuYueStartTime" value="-1">
			<input type="hidden" id="yuYueEndTime" value="-1">
			<input type="hidden" id="buyStartTime" value="-1">
			<input type="hidden" id="buyEndTime" value="-1">
			<input type="hidden" id="ybId">
			<input type="hidden" id="pingUse" value="true">
	   
			<div class="login-area" id="footer">
				<div class="login">
					<#if userLogin??>
					<a rel="nofollow" href="memberCenter">${(userLogin.userLoginId)!'---'}</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="logout">退出</a>
				<#else>
					<a rel="nofollow" href="login">登录</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="register">注册</a>
				</#if>
					<span class="new-fr"><a href="http://item.m.jd.com/showvote.html?sid=e05342df03dd29ae84a48b2e06c03af7">反馈</a><span class="lg-bar">|</span><a href="http://item.m.jd.com/ware/view.action?wareId=854234&sid=e05342df03dd29ae84a48b2e06c03af7&resourceType=search#top">回到顶部</a></span>
				</div>
				<div class="version">
					<a href="http://wap.jd.com/index.html?v=w&sid=e05342df03dd29ae84a48b2e06c03af7">标准版</a><a href="javascript:void(0)" class="on">触屏版</a>
					<a onclick="skip();" href="javascript:void(0);" id="toPcHome">电脑版</a>
				</div>
				<div id="clientArea">
					<a href="http://item.m.jd.com/download/downApp.html?sid=e05342df03dd29ae84a48b2e06c03af7" id="toClient" class="openJD">客户端</a>
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
						_loadScript("http://st.360buyimg.com/item/js/2013/installapp.js?v=jd2015010420",{},function(){
							 $("#clientArea").length && downcheck($("#clientArea"),false);
						});
					}
							
				})
				function skip(){
					addCookie('pcm', '1' ,3, '', 'jd.com');
					var localurl = 'http://item.jd.com/854234.html#m';
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
				function addItemBuy() {
					var add_product_id = $("#add_product_id").val();
			       	if (!add_product_id) {
			           	alert("产品标识丢失，请刷新页面重试!");
			           	return;
			       	} else {
			       		var settleUrl = 'orderFromProdDetail?add_product_id='+add_product_id;
			       		var quantity = $("#number").val();
			       		if(!quantity)quantity = 1;
			       		document.location = settleUrl+"&quantity="+quantity;
			       	}
		    	}
				function addItem() {
					var id = $("#add_product_id").val();
		       		var number = $("#number").val();
					if (!id) {
			           	alert("产品标识丢失，请刷新页面重试!");
			           	return;
			       	} else {
			       		$.ajax({
			       			url:'addItemToCart',
			       			type:'POST',
			       			data:{
			       				add_product_id:id,
			       				quantity:number
			       			},
			       			success:function(r){
			       				$("#cart").show();
								setTimeout(function(){$("#cart").hide()},3000)
			       			}
			       		});
			       	}
				}
			</script>
		</div>
		<span id="testWidth" style="visibility:hidden;position:fixed;left:5px;top:5px;z-index:-999">222</span>
	</body>
	