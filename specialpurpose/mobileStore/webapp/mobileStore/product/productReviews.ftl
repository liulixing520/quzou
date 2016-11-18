<link rel="apple-touch-icon-precomposed" href="/mobileStore/images/imgs/apple-touch-icon.png?v=jd201505141606it">
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
			document.write('<script src="/mobileStore/images/js/zepto.min.js?v=jd201505141606it"><\/script>');
			document.write('<script type="text/javascript">window.jQuery=window.Zepto;<\/script>');
		}else{
			document.write('<script src="/mobileStore/images/js/jquery-1.6.2.min.js?v=jd201505141606it"><\/script>');
		}
	}else{//如果是非webkit内核直接使用jquery
		document.write('<script src="/mobileStore/images/js/jquery-1.6.2.min.js?v=jd201505141606it"><\/script>');
	}
</script>
<script src="/mobileStore/images/js/zepto.js"></script>
<script type="text/javascript">window.jQuery=window.Zepto;</script>
<script type="text/javascript" src="/mobileStore/images/js/common.js"></script>
<script type="text/javascript" src="/mobileStore/images/js/spin.js"></script><style></style>
<script charset="utf-8" type="text/javascript" src="/mobileStore/images/js/installapp_.js"></script>
</head>

<body id="body">
	<a name="top"></a>
	<header>
		<div class="new-header">
			<a href="javascript:pageBack();" class="new-a-back" id="backUrl"><span>返回</span></a>
			<h2>购买评价</h2>
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
	<!--
	<input id="scoreCount5" value="53148" type="hidden">
	<input id="scoreCount3" value="682" type="hidden">
	<input id="scoreCount1" value="267" type="hidden">
	<input id="sid" value="fbe864d3b1eeab726fa2926f5a871c7c" type="hidden">
	<input id="wareId" value="300734" type="hidden">
	<input id="totalPage" value="3544" type="hidden">
	<input id="commentCount" value="53148" type="hidden">
	<input value="1" id="score" type="hidden">
	-->
	<div class="good-detail sift-mg">
		<div class="new-goods-details" id="_assessContent">
			<div class="new-gd-introduce">
				<div class="new-fl w56 new-mg-r12">
					<span class="new-span-block">
						<span class="new-txt36" id="_assessScale">${highPercentage!'100'}</span>
						<span class="new-txt-sign"></span>
					</span>
					<span class="new-span-block new-mg-t5">好评度</span>
				</div>
				<div class="new-gd-txt3">
					<span class="new-span-block" id="_btnGoodScale">
						<span>好评</span>
						<span class="new-txtb8" id="_goodScale">（${highPercentage!'100'}%）</span>
						<span class="new-gd-bar new-mg-l12">
							<span style="width: ${highPercentage!100}%;" id="_goodScaleImg"></span>
						</span>
					</span>
					<span class="new-span-block" id="_btnMediumScale">
						<span>中评</span>
						<span class="new-txtb8" id="_mediumScale">（${middlePercentage!0}%）</span>
						<span class="new-gd-bar new-mg-l12">
							<span style="width: ${middlePercentage!0}%;" id="_mediumScaleImg"></span>
						</span>
					</span>
					<span class="new-span-block" id="_btnGoodScale">
						<span>差评</span>
						<span class="new-txtb8" id="_badScale">（${lowPercentage!0}%）</span>
						<span class="new-gd-bar new-mg-l12">
							<span style="width: ${lowPercentage!0}%;" id="_badScaleImg"></span>
						</span>
					</span>
				</div>
			</div>
		</div>
	
		<div id="comments_ul" class="sift-tab">
			<input type="hidden" name="productId" value="${parameters.productId!}"/>
			<input type="hidden" name="level" value="positive"/>
			<input type="hidden" name="currentPage" value="1"/>
			<ul class="tab-lst">
				<li><a id="highReviews" class="" onclick='changeReviewLeval(this);'>好评${highCount!'0'}</a></li>
				<li><a id="middleReviews" class="" onclick='changeReviewLeval(this);'><span class="bar"></span>中评${middleCount!'0'}</a></li>
				<li><a id="lowReviews" class="on" onclick='changeReviewLeval(this);'><span class="bar"></span>差评${lowCount!'0'}</a></li>
			</ul>
		</div>
		<div id="spinnerCache" class="spinner" style="height: 240px; margin-left: 456px; transform-origin: 0px 0px 0px; opacity: 1; transform: scale(1, 1); display: none;">
			<div class="wait-text">
			努力加载中...
			</div>
		</div>
	
    	<div id="content">
    		<#--<form method="post" action="replyReview?productReviewId=${productReviewId!}"> 
    			<a href="replyReview?productReviewId=${productReviewId!}">
    				<div class="detail">
    					<p class="tit">
    						<span></span>
    						杜***少${userLoginId!firstName!}
    						评论
						</p>
						<p>
							<span>评分：</span>
							<span class="mu-star"><span class="mu-starv star-width${productRating!0}"></span></span>
						</p>
						<p class="user_id">
							<span class="name">杜***少${userLoginId!firstName!}</span>
							<span class="time">2015-05-15 15:04:54${postedDateTime!}</span>
						</p>
						<p>
							<span>心得：</span>
							<span>${StringUtil.wrapString(productReview!'')}</span>
						</p>
						<span class="more">回复</span>
						<div class="parting-line"></div>
					</div>
				</a>
			</form>
    		-->
    		<form method="post" action="/ware/commentDetail/300734_b0f884ca-333f-40ba-a44b-d3d696062a9e.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"> <a href="/ware/commentDetail/300734_b0f884ca-333f-40ba-a44b-d3d696062a9e.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"><div class="detail"><p class="tit"><span></span>J***8评论</p><p><span>评分：</span><span class="mu-star"><span class="mu-starv star-width4"></span></span></p><p class="user_id"><span class="name">J***8</span><span class="time">2015-05-15 14:53:05</span></p><p><span>心得：</span><span>不错。。。。。。。。。。</span></p><span class="more">回复</span><div class="parting-line"></div></div></a></form><form method="post" action="/ware/commentDetail/300734_32e08fb4-e06a-40cc-8c4c-578da3f23a97.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"> <a href="/ware/commentDetail/300734_32e08fb4-e06a-40cc-8c4c-578da3f23a97.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"><div class="detail"><p class="tit"><span></span>苏***安评论</p><p><span>评分：</span><span class="mu-star"><span class="mu-starv star-width5"></span></span></p><p class="user_id"><span class="name">苏***安</span><span class="time">2015-05-15 14:00:23</span></p><p><span>心得：</span><span>一直吃的这个牌子，放心，</span></p><span class="more">回复</span><div class="parting-line"></div></div></a></form><form method="post" action="/ware/commentDetail/300734_67e4513f-5882-4b81-813c-8bd73605d26e.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"> <a href="/ware/commentDetail/300734_67e4513f-5882-4b81-813c-8bd73605d26e.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"><div class="detail"><p class="tit"><span></span>m***9评论</p><p><span>评分：</span><span class="mu-star"><span class="mu-starv star-width5"></span></span></p><p class="user_id"><span class="name">m***9</span><span class="time">2015-05-15 13:58:41</span></p><p><span>心得：</span><span>一直买京东的牛奶，品质可靠。物流又快，很满意。</span></p><span class="more">回复</span><div class="parting-line"></div></div></a></form><form method="post" action="/ware/commentDetail/300734_9fa770c9-d4bc-4704-ba24-8276fe184c22.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"> <a href="/ware/commentDetail/300734_9fa770c9-d4bc-4704-ba24-8276fe184c22.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"><div class="detail"><p class="tit"><span></span>8***6评论</p><p><span>评分：</span><span class="mu-star"><span class="mu-starv star-width5"></span></span></p><p class="user_id"><span class="name">8***6</span><span class="time">2015-05-15 13:10:55</span></p><p><span>心得：</span><span>宝宝一直都吃这个牌子！很好！又实惠</span></p><span class="more">回复</span><div class="parting-line"></div></div></a></form><form method="post" action="/ware/commentDetail/300734_c3706e4c-590c-45d8-9726-e5200dcdd14d.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"> <a href="/ware/commentDetail/300734_c3706e4c-590c-45d8-9726-e5200dcdd14d.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"><div class="detail"><p class="tit"><span></span>j***q评论</p><p><span>评分：</span><span class="mu-star"><span class="mu-starv star-width5"></span></span></p><p class="user_id"><span class="name">j***q</span><span class="time">2015-05-15 12:29:14</span></p><p><span>心得：</span><span>一直吃它，宝宝喜欢，还会再订的</span></p><span class="more">回复</span><div class="parting-line"></div></div></a></form><form method="post" action="/ware/commentDetail/300734_0335cc28-ccbe-4de3-86ba-5cbf2b8c892d.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"> <a href="/ware/commentDetail/300734_0335cc28-ccbe-4de3-86ba-5cbf2b8c892d.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"><div class="detail"><p class="tit"><span></span>151*****620_p评论</p><p><span>评分：</span><span class="mu-star"><span class="mu-starv star-width5"></span></span></p><p class="user_id"><span class="name">151*****62...</span><span class="time">2015-05-15 12:25:05</span></p><p><span>心得：</span><span>还行，就觉得太淡了，</span></p><span class="more">回复</span><div class="parting-line"></div></div></a></form><form method="post" action="/ware/commentDetail/300734_62244f32-54df-43aa-b9b7-a89f444e9716.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"> <a href="/ware/commentDetail/300734_62244f32-54df-43aa-b9b7-a89f444e9716.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"><div class="detail"><p class="tit"><span></span>落***啊评论</p><p><span>评分：</span><span class="mu-star"><span class="mu-starv star-width5"></span></span></p><p class="user_id"><span class="name">落***啊</span><span class="time">2015-05-15 12:00:44</span></p><p><span>心得：</span><span>不错 不错的商品 价格也合适</span></p><span class="more">回复</span><div class="parting-line"></div></div></a></form><form method="post" action="/ware/commentDetail/300734_c6d71560-6153-40c8-a8ef-785b4b1e6f15.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"> <a href="/ware/commentDetail/300734_c6d71560-6153-40c8-a8ef-785b4b1e6f15.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"><div class="detail"><p class="tit"><span></span>落***啊评论</p><p><span>评分：</span><span class="mu-star"><span class="mu-starv star-width5"></span></span></p><p class="user_id"><span class="name">落***啊</span><span class="time">2015-05-15 12:00:29</span></p><p><span>心得：</span><span>不错 不错的商品 价格也合适</span></p><span class="more">回复</span><div class="parting-line"></div></div></a></form><form method="post" action="/ware/commentDetail/300734_73037f91-bcd2-4314-8c4e-ea96c6063141.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"> <a href="/ware/commentDetail/300734_73037f91-bcd2-4314-8c4e-ea96c6063141.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"><div class="detail"><p class="tit"><span></span>j***l评论</p><p><span>评分：</span><span class="mu-star"><span class="mu-starv star-width5"></span></span></p><p class="user_id"><span class="name">j***l</span><span class="time">2015-05-15 11:37:04</span></p><p><span>心得：</span><span>又吃完了。。。。。。。。。。。。</span></p><span class="more">回复</span><div class="parting-line"></div></div></a></form><form method="post" action="/ware/commentDetail/300734_06aa8031-69c2-461e-8c24-ad6059f477e6.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"> <a href="/ware/commentDetail/300734_06aa8031-69c2-461e-8c24-ad6059f477e6.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"><div class="detail"><p class="tit"><span></span>j***l评论</p><p><span>评分：</span><span class="mu-star"><span class="mu-starv star-width5"></span></span></p><p class="user_id"><span class="name">j***l</span><span class="time">2015-05-15 11:17:03</span></p><p><span>心得：</span><span>哈哈哈哈哈哈哈嘎嘎嘎</span></p><span class="more">回复</span><div class="parting-line"></div></div></a></form><form method="post" action="/ware/commentDetail/300734_98f6cf6d-8a91-43d2-b708-30508b739e17.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"> <a href="/ware/commentDetail/300734_98f6cf6d-8a91-43d2-b708-30508b739e17.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"><div class="detail"><p class="tit"><span></span>j***l评论</p><p><span>评分：</span><span class="mu-star"><span class="mu-starv star-width5"></span></span></p><p class="user_id"><span class="name">j***l</span><span class="time">2015-05-15 11:16:01</span></p><p><span>心得：</span><span>哈哈哈哈哈哈哈嘎嘎嘎</span></p><span class="more">回复</span><div class="parting-line"></div></div></a></form><form method="post" action="/ware/commentDetail/300734_c0aeb87c-fafd-4265-8465-2716ab57c2b2.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"> <a href="/ware/commentDetail/300734_c0aeb87c-fafd-4265-8465-2716ab57c2b2.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"><div class="detail"><p class="tit"><span></span>j***l评论</p><p><span>评分：</span><span class="mu-star"><span class="mu-starv star-width5"></span></span></p><p class="user_id"><span class="name">j***l</span><span class="time">2015-05-15 11:14:09</span></p><p><span>心得：</span><span>哈哈哈哈哈哈哈嘎嘎嘎</span></p><span class="more">回复</span><div class="parting-line"></div></div></a></form><form method="post" action="/ware/commentDetail/300734_5369747b-8667-46bd-80ad-9bab3890052f.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"> <a href="/ware/commentDetail/300734_5369747b-8667-46bd-80ad-9bab3890052f.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"><div class="detail"><p class="tit"><span></span>j***l评论</p><p><span>评分：</span><span class="mu-star"><span class="mu-starv star-width5"></span></span></p><p class="user_id"><span class="name">j***l</span><span class="time">2015-05-15 11:13:23</span></p><p><span>心得：</span><span>哈哈哈哈哈哈哈嘎嘎嘎</span></p><span class="more">回复</span><div class="parting-line"></div></div></a></form><form method="post" action="/ware/commentDetail/300734_8069158d-c506-45aa-bae2-6c24b6a96e84.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"> <a href="/ware/commentDetail/300734_8069158d-c506-45aa-bae2-6c24b6a96e84.html?sid=fbe864d3b1eeab726fa2926f5a871c7c"><div class="detail"><p class="tit"><span></span>j***l评论</p><p><span>评分：</span><span class="mu-star"><span class="mu-starv star-width5"></span></span></p><p class="user_id"><span class="name">j***l</span><span class="time">2015-05-15 11:10:25</span></p><p><span>心得：</span><span>哈哈哈哈哈哈哈嘎嘎嘎</span></p><span class="more">回复</span><div class="parting-line"></div></div></a></form>
    		
		</div>
		<div id="loading" class="list-state" style="transform-origin: 0px 0px 0px; opacity: 1; transform: scale(1, 1); display: none;">
            <p class="list-loading"><span></span>加载中...</p>
    	</div>
		<div class="new-load-more" style="text-align:center;" id="con_more_hi"><span style="font-size:12px;" id="tips">向上滑动加载更多</span></div>
	</div>
	<!--
		<field name="productReviewId" type="id-ne"></field>
	    <field name="productStoreId" type="id-ne"></field>
	    <field name="productId" type="id-ne"></field>
	    <field name="userLoginId" type="id-vlong-ne"></field>
	    <field name="statusId" type="id"></field>
	    <field name="postedAnonymous" type="indicator"></field>
	    <field name="postedDateTime" type="date-time"></field>
	    <field name="productRating" type="fixed-point"></field>
	    <field name="productReview" type="very-long"></field>
		<field name="parentProdReviewId" type="id">
	-->
	<script type="text/javascript">
		var reviewsJson = eval('(${StringUtil.wrapString(jsonStr!)})');
		var productIdDom = $("#comments_ul input[name=productId]");
		var levelDom = $("#comments_ul input[name=level]");
		var currentPageDom = $("#comments_ul input[name=currentPage]");
		function changeReviewLeval(obj){
			var objId = obj.id;
			levelDom.val(objId);
			currentPageDom.val("1");
			loadReviewContent();
		}
		function loadReviewContent(){
			var level = levelDom.val();
			var currentPage = parseInt(currentPageDom.val());
			if(currentPage==1){
				//$("#content").empty();
			}
			if(reviewsJson){
				
			}
		}
		$(function(){
			loadReviewContent();
		});
	</script>
	<script type="text/javascript" src="/mobileStore/images/js/comments.js?v=jd201505141606it"></script>
		<div class="login-area" id="footer">
			<div class="login">
				<#if userLogin??>
				<a rel="nofollow" href="memberCenter">${(userLogin.userLoginId)!'---'}</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="logout">退出</a>
			<#else>
				<a rel="nofollow" href="login">登录</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="register">注册</a>
			</#if>
				<span class="new-fr"><a href="javascript:void(0);">反馈</a><span class="lg-bar">|</span><a href="javascript:void(0);">回到顶部</a></span>
			</div>
			<div class="version">
				<a href="javascript:void(0);">标准版</a><a href="javascript:void(0)" class="on">触屏版</a>
				<a onclick="skip();" href="javascript:void(0);" id="toPcHome">电脑版</a>
			</div>
			<div id="clientArea">
				<a href="javascript:void(0);" id="toClient" class="openJD">客户端</a>
			</div>
			<div class="copyright">© medref.cn</div>
		</div>

		<div style="display:none;">
			<img src="/mobileStore/images/imgs/ja.jsp">
		</div>
    	<div style="display:none;">
			<img src="/mobileStore/images/imgs/ja.jsp?&amp;utmn=509943480&amp;utmr=http%3A%2F%2Fitem.m.jd.com%2Fware%2Fview.action%3FwareId%3D300734%26sid%3D78aa79508938b7250f79812e9b808ce7%26resourceType%3Dhome_floor%26resourceValue%3D15713&amp;utmp=%2Fware%2Fcomments.action%3Fsid%3Dfbe864d3b1eeab726fa2926f5a871c7c%26wareId%3D300734&amp;guid=ON&amp;jav=html5&amp;pin=-&amp;utmac=MO-J2011-1&amp;provinceId=&amp;cityId=&amp;countryId=&amp;townId=&amp;skuId=300734&amp;skuPrice=&amp;stockState=">
	    </div>

    	<script type="text/javascript" src="/mobileStore/images/js/mping.min.js"></script>
	    <script type="text/javascript">
	        try{
	            var pv= new MPing.inputs.PV();   //构造pv 请求
	            var mping = new MPing();        //构造上报实例
	            mping.send(pv);                //上报pv
	        } catch (e){}
	    </script>
		<script src="/mobileStore/images/js/downloadAppPlugIn.js?v=jd201505141606it" type="text/javascript"></script>

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
//	syncCart('fbe864d3b1eeab726fa2926f5a871c7c',true);
	location.href='/cart/cart.action';
});

function reSearch(){
var depCity = window.sessionStorage.getItem("airline_depCityName");
	if(testSessionStorage() && isNotBlank(depCity) && !/^\s*$/.test(depCity) && depCity!=""){
    	var airStr = '<form action="/airline/list.action" method="post" id="reseach">'
        +'<input type="hidden" name="sid"  value="fbe864d3b1eeab726fa2926f5a871c7c"/>'
        +'<input type="hidden" name="depCity" value="'+ window.sessionStorage.getItem("airline_depCityName") +'"/>'
        +'<input type="hidden" name="arrCity" value="'+ window.sessionStorage.getItem("airline_arrCityName") +'"/>'
        +'<input type="hidden" name="depDate" value="'+ window.sessionStorage.getItem("airline_depDate") +'"/>'
        +'<input type="hidden" name="depTime" value="'+ window.sessionStorage.getItem("airline_depTime") +'"/>'
        +'<input type="hidden" name="classNo" value="'+ window.sessionStorage.getItem("airline_classNo") +'"/>'
        +'</form>';
    	$("body").append(airStr);
    	$("#reseach").submit();
	}else{
    	window.location.href='/airline/index.action?sid=fbe864d3b1eeab726fa2926f5a871c7c';
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
			_loadScript("http://st.360buyimg.com/item/js/2013/installapp.js?v=jd201505141606it",{},function(){
				 $("#clientArea").length && downcheck($("#clientArea"),false);
			});
		}
				
	})
			function skip(){
		addCookie('pcm', '1' ,1, '', 'jd.com');
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
	
	window.onload = function(){
		$('#close').downloadAppPlugInClose('down_app');
	}
</script>


<iframe style="display: none; width: 0px; height: 0px;"></iframe><iframe style="display: none; width: 0px; height: 0px;"></iframe>