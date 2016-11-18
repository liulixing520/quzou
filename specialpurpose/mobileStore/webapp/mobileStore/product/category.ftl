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
			document.write('<script src="/mobileStore/images/js/jquery-1.11.1.js?v=jd2015010820"><\/script>');
		}
	}else{//如果是非webkit内核直接使用jquery
		document.write('<script src="/mobileStore/images/js/jquery-1.11.1.js?v=jd2015010820"><\/script>');
	}
</script>
<script type="text/javascript">window.jQuery=window.Zepto;</script>
<style></style>
<script src="/mobileStore/images/imgs/h5api.htm"></script>
<body id="body">
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
				<a href="javascript:void(0)" class="new-tbl-cell">
					<span class="icon2 on">分类搜索</span>
					<p class="on" style="color:#6e6e6e;">分类搜索</p>
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
	<form action="/ware/search.action" id="searchForm">
		<input name="sid" value="e05342df03dd29ae84a48b2e06c03af7" type="hidden">
		<div class="new-cate-srch">
			<div class="new-srch-box">
				<input style="color:#999999;" autocomplete="off" name="keyword" id="newkeyword" required="" class="new-srch-input" value="血糖仪" type="text"><a href="javascript:void(0);" target="_self" onclick="cancelHotWord()" class="new-s-close"></a><a href="javascript:void(0)" target="_self" onclick="search_new()" class="new-s-srch"><span></span></a>
			</div>
			<div style="position:relative;">
				<!--<div class="new-srch-lst" id="shelper" style="position: absolute; width: 100%; left: 0px; z-index: 9; overflow: hidden; word-wrap: break-word; transform-origin: 0px 0px 0px; opacity: 1; transform: scale(1, 1);">
					<ul>
						<li>
							<a onclick="writeSuggestion('2')" href="javascript:void(0);">2</a></li><li><a onclick="writeSuggestion('100%纯羊绒')" href="javascript:void(0);">100%纯羊绒</a>
						</li>
					</ul>
					<div class="new-tbl-type">
						<a href="javascript:void(0);" onclick="clearHistory()" class="new-tbl-cell">清除历史记录</a>
						<span class="new-bar"></span>
						<a href="javascript:void(0)" onclick="closeTip()" class="new-tbl-cell">关闭</a>
					</div>
				</div>-->
				<div style="position: absolute; width: 100%; left: 0px; z-index: 9; overflow: hidden; word-wrap: break-word; transform-origin: 0px 0px 0px; opacity: 1; transform: scale(1, 1); display: none;" id="shelper" class="new-srch-lst">
				
				</div>
			</div>
		</div>
	</form>
	    
	<div class="new-ct">
		<div class="new-category">
			<ul class="new-category-lst">
				<#assign firstLevelChildren = delegator.findByAnd("ProductCategory",{"primaryParentCategoryId":"PortalRootCat"})?if_exists />
				<#list firstLevelChildren![] as firstLevelChild>
					<li class="new-category-li">
						<a href="javascript:void(0)" id="${firstLevelChild.productCategoryId!}" class="new-category-a"><span class="icon"></span>${firstLevelChild.categoryName!}</a>
						<ul class="new-category2-lst" id="category${firstLevelChild.productCategoryId!}" style="display:none">
							<#assign secondLevelChildren = delegator.findByAnd("ProductCategory",{"primaryParentCategoryId":firstLevelChild.productCategoryId})?if_exists />
							<#assign secondChildrenQuantity = secondLevelChildren?size />
							<#assign secondGroup = 1 />
							<#if secondChildrenQuantity%3==0>
								<#assign secondGroup = secondChildrenQuantity/3 />
							<#else>
								<#assign secondGroup = (secondChildrenQuantity/3)?int+1 />
							</#if>
							<#list 0..secondGroup as groupNum>
								<#if groupNum&lt;secondGroup>
									<li class="new-category2-li">
										<#assign startIdx = groupNum*3>
										<#assign cate1 = secondLevelChildren[startIdx]?if_exists />
										<a href="categoryProdType?primaryParentCategoryId=${cate1.productCategoryId!}" class="new-category2-a"><span class="new-bar"></span>${cate1.categoryName!}</a>
										<#if secondChildrenQuantity&gt;startIdx+1>
											<#assign cate2 = secondLevelChildren[startIdx+1]?if_exists />
											<a href="categoryProdType?primaryParentCategoryId=${cate2.productCategoryId!}" class="new-category2-a"><span class="new-bar"></span>${cate2.categoryName!}</a>
											<#if secondChildrenQuantity&gt;startIdx+2>
												<#assign cate3 = secondLevelChildren[startIdx+2]?if_exists />
												<a href="categoryProdType?primaryParentCategoryId=${cate3.productCategoryId!}" class="new-category2-a"><span class="new-bar"></span>${cate3.categoryName!}</a>
											<#else>
												<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
											</#if>
										<#else>
											<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
											<a href="javascript:void(0)" class="new-category2-a"></a>
										</#if>
									</li>
								</#if>
							</#list>
						</ul>
					</li>
				</#list>
				<#--
				<li class="new-category-li">
					<a href="javascript:void(0)" id="1315" class="new-category-a"><span class="icon"></span>服饰内衣</a>
					<ul class="new-category2-lst" id="category1315" style="display:none">
						<li class="new-category2-li">
						<a href="http://m.jd.com/products/1315-1342-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>男装</a>
						<a href="http://m.jd.com/products/1315-1343-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>女装</a>
						<a href="http://m.jd.com/products/1315-1345-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>内衣</a>
						</li>
						<li class="new-category2-li">
						<a href="http://m.jd.com/products/1315-1346-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>服饰配件</a>
						<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
						<a href="javascript:void(0)" class="new-category2-a"></a>
						</li>
					</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="11729" class="new-category-a"><span class="icon"></span>鞋靴</a>
				<ul class="new-category2-lst" id="category11729" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/11729-11730-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>流行男鞋</a>
				<a href="http://m.jd.com/products/11729-11731-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>时尚女鞋</a>
				<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="9987" class="new-category-a"><span class="icon"></span>手机</a>
				<ul class="new-category2-lst" id="category9987" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/9987-653-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>手机通讯</a>
				<a href="http://m.jd.com/products/9987-830-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>手机配件</a>
				<a href="http://m.jd.com/products/9987-6880-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>运营商</a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="737" class="new-category-a"><span class="icon"></span>家用电器</a>
				<ul class="new-category2-lst" id="category737" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/737-1276-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>个护健康</a>
				<a href="http://m.jd.com/products/737-738-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>生活电器</a>
				<a href="http://m.jd.com/products/737-752-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>厨房电器</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/737-794-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>大 家 电</a>
				<a href="http://m.jd.com/products/737-1277-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>五金家装</a>
				<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="652" class="new-category-a"><span class="icon"></span>数码</a>
				<ul class="new-category2-lst" id="category652" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/652-654-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>摄影摄像</a>
				<a href="http://m.jd.com/products/652-829-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>数码配件</a>
				<a href="http://m.jd.com/products/652-828-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>时尚影音</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/652-12346-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>电子教育</a>
				<a href="http://m.jd.com/products/652-12345-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>智能设备</a>
				<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="670" class="new-category-a"><span class="icon"></span>电脑、办公</a>
				<ul class="new-category2-lst" id="category670" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/670-671-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>电脑整机</a>
				<a href="http://m.jd.com/products/670-677-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>电脑配件</a>
				<a href="http://m.jd.com/products/670-686-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>外设产品</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/670-699-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>网络产品</a>
				<a href="http://m.jd.com/products/670-716-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>办公设备</a>
				<a href="http://m.jd.com/products/670-729-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>文具/耗材</a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="1316" class="new-category-a"><span class="icon"></span>个护化妆</a>
				<ul class="new-category2-lst" id="category1316" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1316-1381-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>面部护肤</a>
				<a href="http://m.jd.com/products/1316-1383-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>身体护肤</a>
				<a href="http://m.jd.com/products/1316-1384-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>口腔护理</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1316-1385-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>女性护理</a>
				<a href="http://m.jd.com/products/1316-1387-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>香水彩妆</a>
				<a href="http://m.jd.com/products/1316-1386-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>洗发护发</a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="1713" class="new-category-a"><span class="icon"></span>图书</a>
				<ul class="new-category2-lst" id="category1713" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1713-3258-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>小说</a>
				<a href="http://m.jd.com/products/1713-3259-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>文学</a>
				<a href="http://m.jd.com/products/1713-3260-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>青春文学</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1713-3261-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>传记</a>
				<a href="http://m.jd.com/products/1713-3262-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>艺术</a>
				<a href="http://m.jd.com/products/1713-3263-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>少儿</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1713-3264-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>经济</a>
				<a href="http://m.jd.com/products/1713-3265-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>金融与投资</a>
				<a href="http://m.jd.com/products/1713-3266-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>管理</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1713-3267-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>励志与成功</a>
				<a href="http://m.jd.com/products/1713-3269-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>健身与保健</a>
				<a href="http://m.jd.com/products/1713-3270-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>家教与育儿</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1713-3271-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>旅游/地图</a>
				<a href="http://m.jd.com/products/1713-3272-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>动漫</a>
				<a href="http://m.jd.com/products/1713-3273-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>历史</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1713-3274-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>哲学/宗教</a>
				<a href="http://m.jd.com/products/1713-3275-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>国学/古籍</a>
				<a href="http://m.jd.com/products/1713-3276-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>政治/军事</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1713-3277-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>法律</a>
				<a href="http://m.jd.com/products/1713-3279-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>心理学</a>
				<a href="http://m.jd.com/products/1713-3280-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>文化</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1713-3281-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>社会科学</a>
				<a href="http://m.jd.com/products/1713-3282-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>工业技术</a>
				<a href="http://m.jd.com/products/1713-3284-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>建筑</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1713-3285-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>医学</a>
				<a href="http://m.jd.com/products/1713-3286-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>科学与自然</a>
				<a href="http://m.jd.com/products/1713-3287-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>计算机与互联网</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1713-3288-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>体育/运动</a>
				<a href="http://m.jd.com/products/1713-3289-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>中小学教辅</a>
				<a href="http://m.jd.com/products/1713-3290-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>考试</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1713-3291-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>外语学习</a>
				<a href="http://m.jd.com/products/1713-3294-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>字典词典/工具书</a>
				<a href="http://m.jd.com/products/1713-3296-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>套装书</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1713-4758-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>杂志/期刊</a>
				<a href="http://m.jd.com/products/1713-4855-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>英文原版书</a>
				<a href="http://m.jd.com/products/1713-6929-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>港台图书</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1713-7176-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>满200减100专区</a>
				<a href="http://m.jd.com/products/1713-9278-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>烹饪/美食</a>
				<a href="http://m.jd.com/products/1713-9291-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>时尚/美妆</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1713-9301-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>家居</a>
				<a href="http://m.jd.com/products/1713-9309-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>婚恋与两性</a>
				<a href="http://m.jd.com/products/1713-9314-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>娱乐/休闲</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1713-9340-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>科普读物</a>
				<a href="http://m.jd.com/products/1713-9351-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>电子与通信</a>
				<a href="http://m.jd.com/products/1713-9368-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>农业/林业</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1713-11047-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>大中专教材教辅</a>
				<a href="http://m.jd.com/products/1713-11745-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>文化用品</a>
				<a href="http://m.jd.com/products/1713-11799-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>图书促销专区</a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="1319" class="new-category-a"><span class="icon"></span>母婴</a>
				<ul class="new-category2-lst" id="category1319" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1319-1524-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>营养辅食</a>
				<a href="http://m.jd.com/products/1319-1525-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>尿裤湿巾</a>
				<a href="http://m.jd.com/products/1319-1526-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>喂养用品</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1319-1527-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>洗护用品</a>
				<a href="http://m.jd.com/products/1319-1528-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>童车童床</a>
				<a href="http://m.jd.com/products/1319-11842-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>童装童鞋</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1319-4979-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>赠品</a>
				<a href="http://m.jd.com/products/1319-4997-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>妈妈专区</a>
				<a href="http://m.jd.com/products/1319-6313-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>寝居服饰</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1319-1523-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>奶粉</a>
				<a href="http://m.jd.com/products/1319-12193-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>安全座椅</a>
				<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="1320" class="new-category-a"><span class="icon"></span>食品饮料</a>
				<ul class="new-category2-lst" id="category1320" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1320-1581-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>地方特产</a>
				<a href="http://m.jd.com/products/1320-1583-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>休闲食品</a>
				<a href="http://m.jd.com/products/1320-1585-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>饮料冲调</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1320-2641-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>食品礼券</a>
				<a href="http://m.jd.com/products/1320-1584-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>粮油调味</a>
				<a href="http://m.jd.com/products/1320-5019-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>进口食品</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1320-12202-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>茗茶</a>
				<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
				<a href="javascript:void(0)" class="new-category2-a"></a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="1620" class="new-category-a"><span class="icon"></span>家居家装</a>
				<ul class="new-category2-lst" id="category1620" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1620-1621-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>家纺</a>
				<a href="http://m.jd.com/products/1620-1623-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>灯具</a>
				<a href="http://m.jd.com/products/1620-1624-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>生活日用</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1620-1625-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>清洁用品</a>
				<a href="http://m.jd.com/products/1620-11158-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>家装软饰</a>
				<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="6728" class="new-category-a"><span class="icon"></span>汽车用品</a>
				<ul class="new-category2-lst" id="category6728" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/6728-6740-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>车载电器</a>
				<a href="http://m.jd.com/products/6728-6742-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>维修保养</a>
				<a href="http://m.jd.com/products/6728-6743-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>美容清洗</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/6728-6745-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>汽车装饰</a>
				<a href="http://m.jd.com/products/6728-6747-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>安全自驾</a>
				<a href="http://m.jd.com/products/6728-12402-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>线下服务</a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="1672" class="new-category-a"><span class="icon"></span>礼品箱包</a>
				<ul class="new-category2-lst" id="category1672" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1672-2599-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>礼品</a>
				<a href="http://m.jd.com/products/1672-2576-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>精品男包</a>
				<a href="http://m.jd.com/products/1672-2575-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>潮流女包</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1672-2577-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>功能箱包</a>
				<a href="http://m.jd.com/products/1672-12059-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>婚庆</a>
				<a href="http://m.jd.com/products/1672-2615-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>奢侈品</a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="1318" class="new-category-a"><span class="icon"></span>运动户外</a>
				<ul class="new-category2-lst" id="category1318" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1318-1462-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>户外装备</a>
				<a href="http://m.jd.com/products/1318-1463-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>健身训练</a>
				<a href="http://m.jd.com/products/1318-1464-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>纤体瑜伽</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1318-1466-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>体育用品</a>
				<a href="http://m.jd.com/products/1318-12099-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>运动鞋包</a>
				<a href="http://m.jd.com/products/1318-12102-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>运动服饰</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1318-12115-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>骑行运动</a>
				<a href="http://m.jd.com/products/1318-2628-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>户外鞋服</a>
				<a href="http://m.jd.com/products/1318-12147-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>垂钓用品</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/1318-12154-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>游泳用品</a>
				<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
				<a href="javascript:void(0)" class="new-category2-a"></a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="6233" class="new-category-a"><span class="icon"></span>玩具乐器</a>
				<ul class="new-category2-lst" id="category6233" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/6233-6234-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>适用年龄</a>
				<a href="http://m.jd.com/products/6233-6235-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>遥控/电动</a>
				<a href="http://m.jd.com/products/6233-6236-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>毛绒布艺</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/6233-6237-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>娃娃玩具</a>
				<a href="http://m.jd.com/products/6233-6253-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>模型玩具</a>
				<a href="http://m.jd.com/products/6233-6260-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>健身玩具</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/6233-6264-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>动漫玩具</a>
				<a href="http://m.jd.com/products/6233-6271-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>益智玩具</a>
				<a href="http://m.jd.com/products/6233-6275-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>积木拼插</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/6233-6279-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>DIY玩具</a>
				<a href="http://m.jd.com/products/6233-6289-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>创意减压</a>
				<a href="http://m.jd.com/products/6233-6291-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>乐器相关</a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="5025" class="new-category-a"><span class="icon"></span>钟表</a>
				<ul class="new-category2-lst" id="category5025" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/5025-5026-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>钟表</a>
				<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
				<a href="javascript:void(0)" class="new-category2-a"></a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="6196" class="new-category-a"><span class="icon"></span>厨具</a>
				<ul class="new-category2-lst" id="category6196" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/6196-6197-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>烹饪锅具</a>
				<a href="http://m.jd.com/products/6196-6198-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>刀剪菜板</a>
				<a href="http://m.jd.com/products/6196-6214-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>厨房配件</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/6196-6219-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>水具酒具</a>
				<a href="http://m.jd.com/products/6196-6227-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>餐具</a>
				<a href="http://m.jd.com/products/6196-11143-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>茶具/咖啡具</a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="6144" class="new-category-a"><span class="icon"></span>珠宝首饰</a>
				<ul class="new-category2-lst" id="category6144" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/6144-6145-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>纯金K金饰品</a>
				<a href="http://m.jd.com/products/6144-6146-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>金银投资</a>
				<a href="http://m.jd.com/products/6144-6155-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>银饰</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/6144-6160-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>钻石</a>
				<a href="http://m.jd.com/products/6144-6167-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>翡翠玉石</a>
				<a href="http://m.jd.com/products/6144-6172-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>水晶玛瑙</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/6144-6174-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>彩宝</a>
				<a href="http://m.jd.com/products/6144-6182-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>时尚饰品</a>
				<a href="http://m.jd.com/products/6144-12040-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>铂金</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/6144-12041-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>天然木饰</a>
				<a href="http://m.jd.com/products/6144-12042-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>珍珠</a>
				<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="4051" class="new-category-a"><span class="icon"></span>音乐</a>
				<ul class="new-category2-lst" id="category4051" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4051-4054-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>颁奖典礼获奖专辑</a>
				<a href="http://m.jd.com/products/4051-4055-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>内地流行</a>
				<a href="http://m.jd.com/products/4051-4056-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>华语流行</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4051-4057-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>欧美流行</a>
				<a href="http://m.jd.com/products/4051-4058-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>日韩流行</a>
				<a href="http://m.jd.com/products/4051-4059-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>进口CD</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4051-4060-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>古典</a>
				<a href="http://m.jd.com/products/4051-4061-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>经典怀旧音乐</a>
				<a href="http://m.jd.com/products/4051-4062-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>摇滚</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4051-4063-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>爵士/蓝调</a>
				<a href="http://m.jd.com/products/4051-4064-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>民歌民谣</a>
				<a href="http://m.jd.com/products/4051-4065-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>休闲、功能音乐</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4051-4066-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>影视音乐</a>
				<a href="http://m.jd.com/products/4051-4067-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>HIFI发烧碟</a>
				<a href="http://m.jd.com/products/4051-4068-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>有声读物</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4051-4069-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>儿童音乐</a>
				<a href="http://m.jd.com/products/4051-4070-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>音乐教育</a>
				<a href="http://m.jd.com/products/4051-4071-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>音乐DVD/VCD</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4051-4072-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>民族音乐</a>
				<a href="http://m.jd.com/products/4051-4073-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>相声/戏曲/曲艺</a>
				<a href="http://m.jd.com/products/4051-4074-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>中国民族乐器</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4051-4075-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>西洋乐器</a>
				<a href="http://m.jd.com/products/4051-4076-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>宗教/庆典音乐</a>
				<a href="http://m.jd.com/products/4051-4077-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>汽车音乐</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4051-4078-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>瑜伽音乐</a>
				<a href="http://m.jd.com/products/4051-4079-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>独立音乐</a>
				<a href="http://m.jd.com/products/4051-4080-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>网络歌曲</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4051-4081-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>特色分类</a>
				<a href="http://m.jd.com/products/4051-4082-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>音乐套装</a>
				<a href="http://m.jd.com/products/4051-4084-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>其他分类</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4051-4890-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>中国摇滚</a>
				<a href="http://m.jd.com/products/4051-9100-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>艺人周边</a>
				<a href="http://m.jd.com/products/4051-11390-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>文娱周边</a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="6994" class="new-category-a"><span class="icon"></span>宠物生活</a>
				<ul class="new-category2-lst" id="category6994" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/6994-6995-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>宠物主粮</a>
				<a href="http://m.jd.com/products/6994-6996-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>宠物零食</a>
				<a href="http://m.jd.com/products/6994-6997-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>医疗保健</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/6994-6998-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>家居日用</a>
				<a href="http://m.jd.com/products/6994-6999-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>宠物玩具</a>
				<a href="http://m.jd.com/products/6994-7000-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>出行装备</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/6994-7001-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>洗护美容</a>
				<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
				<a href="javascript:void(0)" class="new-category2-a"></a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="4052" class="new-category-a"><span class="icon"></span>影视</a>
				<ul class="new-category2-lst" id="category4052" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4052-4085-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>电影</a>
				<a href="http://m.jd.com/products/4052-4086-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>电视剧</a>
				<a href="http://m.jd.com/products/4052-4087-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>专题栏目/纪录片</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4052-4088-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>瑜伽/塑身</a>
				<a href="http://m.jd.com/products/4052-4089-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>生活/百科</a>
				<a href="http://m.jd.com/products/4052-4090-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>亲子幼教启蒙</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4052-4091-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>卡通/动画</a>
				<a href="http://m.jd.com/products/4052-4092-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>儿童影视</a>
				<a href="http://m.jd.com/products/4052-4093-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>戏剧/综艺</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4052-4094-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>教育音像</a>
				<a href="http://m.jd.com/products/4052-4095-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>经典电影</a>
				<a href="http://m.jd.com/products/4052-4097-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>其他分类</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4052-9105-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>影视/动漫周边</a>
				<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
				<a href="javascript:void(0)" class="new-category2-a"></a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="4053" class="new-category-a"><span class="icon"></span>教育音像</a>
				<ul class="new-category2-lst" id="category4053" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4053-4100-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>英语学习</a>
				<a href="http://m.jd.com/products/4053-4101-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>非英语语种/汉语学习</a>
				<a href="http://m.jd.com/products/4053-4102-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>幼儿/少儿英语</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4053-4103-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>幼儿与学前启蒙</a>
				<a href="http://m.jd.com/products/4053-4104-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>教材/教辅</a>
				<a href="http://m.jd.com/products/4053-4105-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>考试/考级</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4053-4106-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>经营管理培训</a>
				<a href="http://m.jd.com/products/4053-4107-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>电脑培训/考试/考级</a>
				<a href="http://m.jd.com/products/4053-4108-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>职业教育</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4053-4109-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>成人高考教育</a>
				<a href="http://m.jd.com/products/4053-4110-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>文学</a>
				<a href="http://m.jd.com/products/4053-4111-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>艺术</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4053-4112-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>体育</a>
				<a href="http://m.jd.com/products/4053-4113-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>健身</a>
				<a href="http://m.jd.com/products/4053-4114-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>专业舞蹈</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4053-4115-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>时尚靓妆</a>
				<a href="http://m.jd.com/products/4053-4116-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>生活百科</a>
				<a href="http://m.jd.com/products/4053-4117-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>农业生产</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4053-4118-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>教育名家</a>
				<a href="http://m.jd.com/products/4053-4119-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>其他</a>
				<a href="http://m.jd.com/products/4053-4901-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>游戏</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/4053-4902-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>软件</a>
				<a href="http://m.jd.com/products/4053-9110-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>周边产品</a>
				<a href="http://m.jd.com/products/4053-12323-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>在线教育/学习卡</a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="9847" class="new-category-a"><span class="icon"></span>家具</a>
				<ul class="new-category2-lst" id="category9847" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/9847-9848-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>卧室家具</a>
				<a href="http://m.jd.com/products/9847-9849-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>客厅家具</a>
				<a href="http://m.jd.com/products/9847-9850-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>餐厅家具</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/9847-9851-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>书房家具</a>
				<a href="http://m.jd.com/products/9847-9852-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>储物家具</a>
				<a href="http://m.jd.com/products/9847-9853-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>阳台/户外</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/9847-9854-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>商业办公</a>
				<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
				<a href="javascript:void(0)" class="new-category2-a"></a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="9855" class="new-category-a"><span class="icon"></span>家装建材</a>
				<ul class="new-category2-lst" id="category9855" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/9855-9856-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>灯饰照明</a>
				<a href="http://m.jd.com/products/9855-9857-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>厨房卫浴</a>
				<a href="http://m.jd.com/products/9855-9858-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>五金工具</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/9855-9859-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>电工电料</a>
				<a href="http://m.jd.com/products/9855-9860-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>墙地面材料</a>
				<a href="http://m.jd.com/products/9855-9861-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>装饰材料</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/9855-9862-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>装修服务</a>
				<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
				<a href="javascript:void(0)" class="new-category2-a"></a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="9192" class="new-category-a"><span class="icon"></span>营养保健</a>
				<ul class="new-category2-lst" id="category9192" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/9192-9196-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>成人用品</a>
				<a href="http://m.jd.com/products/9192-9197-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>保健器械</a>
				<a href="http://m.jd.com/products/9192-12190-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>急救卫生</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/9192-9193-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>营养健康</a>
				<a href="http://m.jd.com/products/9192-9194-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>营养成分</a>
				<a href="http://m.jd.com/products/9192-9195-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>传统滋补</a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="12218" class="new-category-a"><span class="icon"></span>生鲜</a>
				<ul class="new-category2-lst" id="category12218" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/12218-12219-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>产地直供</a>
				<a href="http://m.jd.com/products/12218-12220-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>环球美食</a>
				<a href="http://m.jd.com/products/12218-12221-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>水果/蔬菜</a>
				</li>
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/12218-12222-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>海鲜水产</a>
				<a href="http://m.jd.com/products/12218-12223-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>肉禽蛋奶</a>
				<a href="http://m.jd.com/products/12218-12224-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>熟食腊味</a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="12259" class="new-category-a"><span class="icon"></span>酒类</a>
				<ul class="new-category2-lst" id="category12259" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/12259-12260-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>中外名酒</a>
				<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
				<a href="javascript:void(0)" class="new-category2-a"></a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="12379" class="new-category-a"><span class="icon"></span>整车</a>
				<ul class="new-category2-lst" id="category12379" style="display:none">
				<li class="new-category2-li">
				<a href="http://m.jd.com/products/12379-12380-000.html?resourceType=&amp;resourceValue=&amp;sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>全新整车</a>
				<a href="javascript:void(0)" class="new-category2-a"><span class="new-bar"></span></a>
				<a href="javascript:void(0)" class="new-category2-a"></a>
				</li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="$category.cid" class="new-category-a"><span class="icon"></span>生活旅行</a>
				<ul class="new-category2-lst" id="category$category.cid" style="display:none">
				<li class="new-category2-li"><a href="http://vm.m.jd.com/chongzhi/index.action?sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>充值</a><a href="http://caipiao.m.jd.com/?sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>彩票</a><a href="http://jipiao.m.jd.com/?sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>机票</a></li>
				<li class="new-category2-li"><a href="http://hotel.m.jd.com/?sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>酒店</a><a href="http://menpiao.m.jd.com/?sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>景点</a><a href="http://movie.m.jd.com/?sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>电影票</a></li>
				</ul>
				</li>
				<li class="new-category-li">
				<a href="javascript:void(0)" id="$category.cid" class="new-category-a"><span class="icon"></span>数字娱乐</a>
				<ul class="new-category2-lst" id="category$category.cid" style="display:none">
				<li class="new-category2-li"><a href="http://e.m.jd.com/?sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>电子书</a><a href="http://music.m.jd.com/?sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>数字音乐</a><a href="http://app.m.jd.com/?sid=e05342df03dd29ae84a48b2e06c03af7" class="new-category2-a"><span class="new-bar"></span>应用商店</a></li>
				</ul>
				</li>
				-->
			</ul>
		</div>
	</div>
	<script language="javascript">
		$(function(){
			$("li.new-category-li>a").click(function(){
	    		var obj = $(this).parent().children().eq(1);
	    		if(obj.css('display')=='none'){
	    			$(".new-category2-lst").hide();
	    			obj.fadeIn();
	    			$("li.new-category-li>a").removeClass("new-category-a new-on").addClass("new-category-a");
	    			$(this).addClass("new-category-a new-on");
	    		}else{
	    			obj.fadeOut();
	    			$("li.new-category-li>a").removeClass("new-category-a new-on").addClass("new-category-a");
	    			$(this).removeClass("new-category-a new-on").addClass("new-category-a");
	    		}
	    	})
		});
	</script>
	   
	<div class="login-area" id="footer">
		<div class="login">
			<a href="https://passport.m.jd.com/user/login.action?sid=e05342df03dd29ae84a48b2e06c03af7">登录</a>
			<span class="lg-bar">|</span>
			<a href="https://passport.m.jd.com/user/mobileRegister.action?v=t&amp;sid=e05342df03dd29ae84a48b2e06c03af7">注册</a>
			<span class="new-fr">
				<a href="http://m.jd.com/showvote.html?sid=e05342df03dd29ae84a48b2e06c03af7">反馈</a>
				<span class="lg-bar">|</span>
				<a href="#top">回到顶部</a>
			</span>
		</div>
		<div class="version">
			<a href="http://wap.jd.com/index.html?v=w&amp;sid=e05342df03dd29ae84a48b2e06c03af7">标准版</a>
			<a href="javascript:void(0)" class="on">触屏版</a>
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
</html>