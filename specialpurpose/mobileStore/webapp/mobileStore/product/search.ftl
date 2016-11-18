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
</head>
<body id="body">
	<a name="top"></a>
	<header>
		<div class="new-header" id="_jdBox">
			<a href="javascript:pageBack();" class="new-a-back"><span>返回</span></a>
			<a href="javascript:void(0)" id="btnJdBox" class="new-srch-box2" style="overflow: hidden;">${parameters.keyword!}</a>
			<a href="javascript:void(0)" id="btnJdkey" class="new-a-jd"><span>京东键</span></a>
		</div>
		<div class="new-header" id="_jdSearch" style="display:none">
			<form action="search" id="searchForm">
				<input name="sid" value="" type="hidden">
				<a href="javascript:void(0)" id="_cancelSearch" class="new-a-cancel">取消</a>
				<div class="new-srch-box new-srch-box-v1">
					<input type="text" class="new-srch-input" autocomplete="off" name="keyword" id="newkeyword" cleardefault="no" required="" value="${parameters.keyword!}">
					<a href="javascript:void(0);" target="_self" onclick="cancelHotWord()" class="new-s-close new-s-close-v1"></a>
					<a href="javascript:void(0)" target="_self" onclick="search_new()" class="new-s-srch">
						<span></span>
					</a>
					<div class="new-srch-lst" id="shelper" style="position: absolute;left: 0px;z-index: 9;overflow: hidden;word-wrap:break-word;display:none">
					</div>
				</div>
			</form>
		</div>
		<div class="new-jd-tab" style="display:none" id="jdkey">
			<div class="new-tbl-type">
				<a href="main" class="new-tbl-cell">
					<span class="icon">首页</span>
					<p style="color:#6e6e6e;">首页</p>
				</a>
				<a href="category" class="new-tbl-cell">
					<span class="icon2">搜索</span>
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
	<style type="text/css">
		.keyword_append{margin:1px 0 0;padding:0 0}
	</style>
	<#--><div class="download-con" id="down_app">
		<div class="down_app">
			<div class="download-logo"></div>
			<div class="alogo">
				<p class="client-name">客户端首单满59元送59元！</p>
				<p class="client-logon"></p>
			</div>
			<div class="open_now">
				<a id="openJD" href="javascript:void(0);"><span class="open_btn">立即打开</span></a>
			</div>
			<div class="close-btn-con close-btn">
				<span class="close-btn-icon"></span>
			</div>
		</div>
	</div>-->
	<div style="position: absolute;top:0px;width: 190px;height: 100%;right: 0px;top: 0;z-index: 9999;overflow:hidden;display:none;" id="filterbar">
		<div class="new-tab-type">
			<div class="new-srch-pop" id="slidebar" style="-webkit-transition: -webkit-transform 0.4s;-webkit-transform-origin: 0px 0px; -webkit-transform-style: preserve-3d;-webkit-transform: translate(190px, 0);">
				<div class="new-pop-option">
					<div class="new-tbl-type new-p-re">
						<a href="javascript:void(0)" id="btn_prop" class="new-tbl-cell on">属性</a>
						<a href="javascript:void(0)" id="btn_cat" class="new-tbl-cell">分类</a>
					</div>
				</div>
				
				<#--
				>>>>>>>>>>>>>>>>>allAttries:${allAttries.class.simpleName}
				>>>>>>>>>>>>>>>>>allCategoriesTree:${allAttries.class.simpleName}
				-->
				<div class="new-pop-ul new-p-re" id="filter_prop">
					<ul class="new-ul-lst">
						<#if allAttries?? && attrieHeads??>
							<#list attrieHeads as attributeId>
								<#assign typeAttr = delegator.findOne("TypeAttribute",true,{'attributeId':attributeId})?if_exists />
								<#assign optionalIdList = allAttries[attributeId]?if_exists />
								<#if typeAttr?? && optionalIdList??>
									<li class="new-ul-li">
										<a href="javascript:void(0)" onclick="showHideFilter(this)" class="new-li-a on">${typeAttr.attributeName!'---'}</a>
										<div class="new-pop-sel" style="display:none">
											<ul>
												<li><a href="javascript:void(0)" onclick="selectCategoryFilter(this)" <#if !filterAttrMap?? || !filterAttrMap[attributeId]??>class=" on "</#if> data="" parent="${attributeId}"><span>全部</span></a></li>
												<#list optionalIdList as optionalId>
													<#if optionalId??>
														<#assign attrOptionalVal = delegator.findOne("AttrOptionalValue",true,{'optionalId':optionalId})?if_exists/>
														<#if attrOptionalVal??>
															<li><a href="javascript:void(0)" onclick="selectCategoryFilter(this)" <#if filterAttrMap?? && filterAttrMap[attributeId]?? && filterAttrMap[attributeId]==optionalId >class=" on "</#if> data="${optionalId}" parent="${attributeId}"><span>${(attrOptionalVal.optionalName)!'---'}</span></a></li>
														</#if>
													</#if>
												</#list>
											</ul>
										</div>
									</li>
								</#if>
							</#list>
						</#if>
						<#--
						<li class="new-ul-li">
							<a href="javascript:void(0)" onclick="showHideFilter(this)" class="new-li-a ">品牌</a>
							<div class="new-pop-sel" style="display: ">
								<ul>
									<li><a href="javascript:void(0)" onclick="selectCategoryFilter(this)" class=" on " data="" parent="品牌" type="1"><span>全部</span></a></li>
									<li><a href="javascript:void(0)" onclick="selectCategoryFilter(this)" data="洁柔（C&amp;S）" parent="品牌" type="1"><span>洁柔（C&amp;S）</span></a></li>
									<li><a href="javascript:void(0)" onclick="selectCategoryFilter(this)" data="洁云" parent="品牌" type="1"><span>洁云</span></a></li>
								</ul>
							</div>
						</li>
					    -->
					</ul>
				</div>
				<#if allCategoriesTree?? && allCateHeads??>
					<div class="new-pop-ul new-p-re" id="filter_cat" style="display:none">
						<ul class="new-ul-lst">
							<#list allCateHeads as productCategoryId>
								<#assign firstCateInfo = allCategoriesTree[productCategoryId]?if_exists>
								<#if firstCateInfo??>
									<li class="new-ul-li">
										<a href="javascript:void(0)" onclick="showHideFilter(this)" class="new-li-a on">${firstCateInfo.categoryName!'---'}</a>
										<div class="new-pop-sel" style="display:none">
											<ul>
												<#assign childCateInfo=firstCateInfo.child?if_exists />
												<#assign childIds=firstCateInfo.childKeySet?if_exists />
												<#if childCateInfo?? && childIds??>
													<#list childIds as cccid>
														<#assign childCate = childCateInfo[cccid]?if_exists />
														<li><a href="search?filed=cid3&cid=${cccid}&sort=${parameters.sort!'0'}&page=1&keyword=${parameters.keyword!}&resourceType=search&resourceValue=&sid=${parameters.sid!}" onclick="selectCategory(this)" class="<#if parameters.cid?? && parameters.cid==cccid>on</#if>"><span>${(childCate.categoryName)!'---'}</span></a></li>
													</#list>
												</#if>
											</ul>
										</div>
									</li>
								</#if>
							</#list>
						</ul>
						<a href="search" class="new-abtn-reset">重置</a>
					</div>
				</#if>
				<#--
				<div class="new-pop-ul new-p-re" id="filter_cat" style="display:none">
					<ul class="new-ul-lst">
						<li class="new-ul-li">
							<a href="javascript:void(0)" onclick="showHideFilter(this)" class="new-li-a ">清洁用品</a>
							<div class="new-pop-sel" style="display:">
							<ul>
							<li><a href="http://m.jd.com/ware/search.action?filed=cid3&cid=1671&sort=0&page=1&keyword=2&resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7" onclick="selectCategory(this)" class=""><span>纸品湿巾</span></a></li>
							<li><a href="http://m.jd.com/ware/search.action?filed=cid3&cid=1663&sort=0&page=1&keyword=2&resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7" onclick="selectCategory(this)" class=""><span>家庭清洁</span></a></li>
							</ul>
							</div>
						</li>
					</ul>
					<a href="http://m.jd.com/ware/search.action?keyword=2&resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7" class="new-abtn-reset">重置</a>
				</div>-->
			</div>
		</div>
	</div>
	<!--类型筛选结束-->
	<div class="new-ct new-p-re">
		<div class="new-search">
			<div class="new-tab-type">
				<div class="new-tbl-type">
					<a href="javascript:void(0)" id="btn_sort" f="1" class="new-tbl-cell on"><span class="new-bar"></span><span class="new-p-re">排序<span class="new-icon-down"></span></span></a>
					<a href="javascript:void(0)" id="btn_stock" f="1" class="new-tbl-cell"><span class="new-bar"></span><span class="new-p-re">库存<span class="new-icon-down"></span></span></a>
					<#--><a href="javascript:void(0)" id="btn_delivery" f="1" class="new-tbl-cell"><span class="new-bar"></span><span class="new-p-re">配送<span class="new-icon-down"></span></span></a>-->
					<a href="javascript:void(0)" id="btn_filter" f="1" class="new-tbl-cell"><span class="new-bar"></span><span class="icon">筛选<span></span></span></a>
				</div>
			</div>
			<div class="new-tab-type2" style="overflow:hidden;height:34px">
				<div class="new-tbl-type">
					<a href="search?cid=${parameters.cid!}&sort=0&keyword=${parameters.keyword!}&page=${parameters.page!}&expressionKey=${parameters.expressionKey!}&expandName=${parameters.expandName!}&minprice=${parameters.minprice!}&maxprice=${parameters.maxprice!}&stock=${parameters.stock!}&resourceType=${parameters.resourceType!}&resourceValue=${parameters.resourceValue!}&sid=${parameters.sid!}" class="new-tbl-cell w60"><span class="on">相关度</span></a>
					<a href="search?cid=${parameters.cid!}&sort=1&keyword=${parameters.keyword!}&page=${parameters.page!}&expressionKey=${parameters.expressionKey!}&expandName=${parameters.expandName!}&minprice=${parameters.minprice!}&maxprice=${parameters.maxprice!}&stock=${parameters.stock!}&resourceType=${parameters.resourceType!}&resourceValue=${parameters.resourceValue!}&sid=${parameters.sid!}" class="new-tbl-cell w60"><span class="on">销量</span></a>
					<a href="search?cid=${parameters.cid!}&sort=<#if parameters.sort?? && parameters.sort=='2'>3<#else>2</#if>&keyword=${parameters.keyword!}&page=${parameters.page!}&expressionKey=${parameters.expressionKey!}&expandName=${parameters.expandName!}&minprice=${parameters.minprice!}&maxprice=${parameters.maxprice!}&stock=${parameters.stock!}&resourceType=${parameters.resourceType!}&resourceValue=${parameters.resourceValue!}&sid=${parameters.sid!}" class="new-tbl-cell w60"><span class="on">价格<#if parameters.sort??><#if parameters.sort=='2'>↓<#elseif parameters.sort=='3'>↑</#if></#if></span></a>
					<a href="search?cid=${parameters.cid!}&sort=4&keyword=${parameters.keyword!}&page=${parameters.page!}&expressionKey=${parameters.expressionKey!}&expandName=${parameters.expandName!}&minprice=${parameters.minprice!}&maxprice=${parameters.maxprice!}&stock=${parameters.stock!}&resourceType=${parameters.resourceType!}&resourceValue=${parameters.resourceValue!}&sid=${parameters.sid!}" class="new-tbl-cell w60"><span class="on">评价数</span></a>
				</div>
			</div>
			<div class="new-tab-type3" style="overflow:hidden;display:none;height:34px">
				<div class="new-tbl-type">
					<#--<span class="new-tbl-cell">
						<div class="new-city-option">
							<span>地区</span>
							<span class="new-sel-box new-p-re">
								<div id="regionShow">全部<span></span></div>
								<select class="new-select" id="select_region">
									<option value="0">全部</option>
									<option value="1">北京</option>
									<option value="2">上海</option>
									<option value="3">天津</option>
									<option value="4">重庆</option>
									<option value="5">河北</option>
									<option value="6">山西</option>
									<option value="7">河南</option>
									<option value="8">辽宁</option>
									<option value="9">吉林</option>
									<option value="10">黑龙江</option>
									<option value="11">内蒙古</option>
									<option value="12">江苏</option>
									<option value="13">山东</option>
									<option value="14">安徽</option>
									<option value="15">浙江</option>
									<option value="16">福建</option>
									<option value="17">湖北</option>
									<option value="18">湖南</option>
									<option value="19">广东</option>
									<option value="20">广西</option>
									<option value="21">江西</option>
									<option value="22">四川</option>
									<option value="23">海南</option>
									<option value="24">贵州</option>
									<option value="25">云南</option>
									<option value="26">西藏</option>
									<option value="27">陕西</option>
									<option value="28">甘肃</option>
									<option value="29">青海</option>
									<option value="30">宁夏</option>
									<option value="31">新疆</option>
									<option value="32">台湾</option>
									<option value="42">香港</option>
									<option value="43">澳门</option>
								</select>
							</span>
						</div>
					</span>-->
					<a href="javascript:void(0)" id="checkbox_stock" class="new-tbl-cell  new-chk-default "><span class="new-chk <#if parameters.stock?? && parameters.stock=='1'>on<#--<#else>default--></#if>"></span>仅显示有货</a>
				</div>
			</div>
			<div class="new-tab-type4" style="overflow:hidden;display:none;height:34px">
				<div class="new-tbl-type">
					<a href="javascript:void(0)" id="self_all" class="new-tbl-cell"><span class="new-rdo  on "></span>全部</a>
					<a href="javascript:void(0)" id="self_jd" class="new-tbl-cell"><span class="new-rdo "></span>京东配送</a>
					<a href="javascript:void(0)" id="self_other" class="new-tbl-cell"><span class="new-rdo "></span>第三方配送</a>
				</div>
			</div>
			<form id="condtion" action="search" type="post">
				<input name="keyword" value="${parameters.keyword!}" type="hidden">
				<input name="cid" value="${parameters.cid!}" type="hidden" id="cid">
				<input name="filed" value="${parameters.filed!}" type="hidden" id="filed">
				<input name="sort" value="${parameters.sort!}" type="hidden">
				<input name="sid" value="${parameters.sid!}" type="hidden">
				<input type="hidden" name="expressionKey" value="${parameters.expressionKey!}" id="expressionKey">
				<input type="hidden" name="minprice" value="${parameters.minprice!}" id="minprice">
				<input type="hidden" name="maxprice" value="${parameters.maxprice!}" id="maxprice">
				<input type="hidden" name="expandName" value="${parameters.expandName!}" id="expandName">
				<input name="region" id="region" value="${parameters.region!}" type="hidden">
				<input name="stock" id="stock" value="${parameters.stock!}" type="hidden">
				<input name="self" id="self" value="${parameters.self!}" type="hidden">
				<input type="hidden" name="resourceType" value="search">
				<input type="hidden" name="resourceValue" value="${parameters.resourceValue!}">
			</form>
			<ul class="new-mu_l2w">
				<#if showProdInfoList?? && showProdInfoList?size &gt; 0>
					<#list showProdInfoList as showProdInfo>
						<li class="new-mu_l2">
							<a href="productDetail?product_id=${showProdInfo.productId!}" class="new-mu_l2a">
								<span class="new-mu_tmb"><img src="${showProdInfo.imgPath!}" width="100" height="100"></span>
								<span class="new-mu_l2cw">
								<strong class="new-mu_l2h">${showProdInfo.productName!'---'}</strong>
								<span class="new-mu_l2h"><span class="new-txt-rd2 new-elps"></span></span>
								<span class="new-mu_l2c"><strong class="new-txt-rd2">￥${showProdInfo.price!'0.00'}</strong></span>
								<span class="new-mu_l2c new-p-re"><span class="new-txt">已售出${showProdInfo.saleQuantity!'0'}件</span><span class="new-sale-icon"></span></span>
								</span>
							</a>
						</li>
					</#list>
				<#else>
					<div class="new-cp-prom2">
				        <span class="new-logo2"></span>
				        <strong class="new-span-block">抱歉暂时没有相关结果，换个词试试吧</strong>
				    </div>
				</#if>
			</ul>
			<div id="loading" class="list-state">
				<p style="display:none" class="list-loading"><span></span>加载中...</p>
				<p style="display:none" class="list-nomore"><span>已到尾页</span></p>
			</div>
		</div>
		<div id="page" class="new-paging" style="display:none">
			<div class="new-tbl-type">
				<div class="new-tbl-cell"></div>
				<div class="new-tbl-cell new-p-re">
					<div id="loadmore" class="new-a-page">
						<span class="new-open">加载更多...</span>
					</div>
				</div>
				<div class="new-tbl-cell"></div>
			</div>
		</div>
		<#--
		<div class="new-relevance-srch">
			<p class="new-rele-tit">
				相关搜索：
			</p>
			<p class="new-rele-cont">
				<a href="http://m.jd.com/ware/search.action?keyword=1&resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7">1</a>
				<a href="http://m.jd.com/ware/search.action?keyword=%E6%89%8B%E6%9C%BA&resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7">手机</a>
				<a href="http://m.jd.com/ware/search.action?keyword=3&resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7">3</a>
				<a href="http://m.jd.com/ware/search.action?keyword=2t&resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7">2t</a>
				<a href="http://m.jd.com/ware/search.action?keyword=4&resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7">4</a>
				<a href="http://m.jd.com/ware/search.action?keyword=%E7%BA%A2%E7%B1%B32&resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7">红米2</a>
			</p>
		</div>
		-->
	</div>
	<div id="runtop" class="right-opera" style="display: none;">
		<ul>
			<li id="goToTop"></li>
			<li id="geToIndex"></li>
		</ul>
	</div>
	<script language="javascript">
		var columnHigth,//列高
			pageNum=${parameters.page!1},
			totalPage= ${totalPage!1},//总页数
			reloadNum = 1,//加载次数
			loading = false,//是否在加载中
			provinceId = '',
			resourceType = '${parameters.resourceType!'search'}',
			resourceValue='',
			sid='${parameters.sid!}',
			keyword = '${parameters.keyword!}';
		function showHideFilter(obj){
			var hasClass = $(obj).hasClass('on');
			$(obj).parent().siblings().children('div').hide();
			$(obj).siblings().hide();
			$(obj).addClass('on');
			$(obj).parent().siblings().children('a').addClass('on');
			if(hasClass){
				$(obj).removeClass('on');
				$(obj).siblings().show();
			}
		}
		function selectExpandSort(obj){
			$(obj).parent().siblings().children('a').removeClass('on');
			$(obj).addClass('on');
			var div = $('#filter_prop a.on[data]');
			var esId = '';
			for(var i=0,len=div.size();i<len;i++){
				if(esId!='')esId+='-';
				esId+=$(div[i]).attr('data');
			}
			var more = 7-div.length;
			if(more>0){
				for(var i=0;i<more;i++){
					if(esId!='')esId+='-0';
				}
			}
			$('#expandSortId').val(esId);
			$('#condtion').submit();
			closeFilter();
		}
		function selectCategory(obj){
			$(obj).parent().siblings().children('a').removeClass('on');
			$(obj).addClass('on');
			closeFilter();
		}
		function selectCategoryFilter(obj){
			$(obj).parent().siblings().children('a').removeClass('on');
			$(obj).addClass('on');
			
			var param = '';
			var express = $('#filter_prop a.on[data]');
			for(var i=0,len=express.size();i<len;i++){
				if($(express[i]).attr('data')!=''){
					if(param!='')param+=',';
					param+=($(express[i]).attr('parent')+":"+$(express[i]).attr('data'));
				}
			}
			$('#expressionKey').val(param);
			
			/*
				var price = $('#filter_prop a.on[data][type="2"]');
				$('#minprice').val('');
		        $('#maxprice').val('');
				for(var i=0,len=price.size();i<len;i++){
					if($(price[i]).attr('data')!=''){
						content = $(price[i]).attr('data');
						if(content){
		        			var tmpPrice = content.split('-');
		        			if(tmpPrice.length==2){
		        				$('#minprice').val(tmpPrice[0]);
		        				$('#maxprice').val(tmpPrice[1]);
		        			}
						}
					}
				}
				param = '';
				var expand = $('#filter_prop a.on[data][type="3"]');
				for(var i=0,len=expand.size();i<len;i++){
					if($(expand[i]).attr('data')!=''){
						if(param!='')param+=',';
						param+=($(expand[i]).attr('parent')+":"+$(expand[i]).attr('data'));
					}
				}
				$('#expandName').val(param);
				$('#condtion').submit();
			*/
			var param = jQuery('#condtion').serialize();
			jQuery.ajax({
		        url: "AjaxFilterProdList?oper=ATTR_FILTER",
		        type: 'POST',
		        data: param,
		        error: function(msg) {
		        },
		        success: function(r) {
		        	$('.new-mu_l2w').html(r);
		        }
		    });
			closeFilter();
		}
		function closeFilter(){
			(document.body||document.documentElement).removeChild(document.getElementById('_mask'));
			(document.body||document.documentElement).removeChild(document.getElementById('_maskArrow'));
			//$('a[f="1"]').removeClass('on');
			document.getElementById('slidebar').setAttribute('style','-webkit-transition: -webkit-transform 0.4s;-webkit-transform-origin: 0px 0px; -webkit-transform-style: preserve-3d;-webkit-transform: translate(190px, 0);');
			setTimeout(function(){
				$('#filterbar').hide();
			},400);
		}
		
		/**悬浮回到顶部开关
		 *
		 *
		**/
		function operaSwitch(){
			if($('.new-mu_l2w').length >0){
				if( $(window).scrollTop() >= $(window).height() && totalPage >0){
					if($('#runtop').css('display') != 'block' || $('#runtop').css('display') != ''){
						$('#runtop').show();
					}
				}else{
					if($('#runtop').css('display') != 'none'){
						$('#runtop').hide();
					}
				}
			}
		}
		/**加载新页
		 *
		 *
		**/
		function loadPage(){
			if(reloadNum< 4){ //加载次数小于4
	    		if((columnHigth * $('.new-mu_l2w').length * 15 - columnHigth * 6)< $(window).scrollTop()){
	    			if(!loading && (pageNum+1)<= totalPage){
	    				loadData();
	    			}
	    		}
			}else{
				if((pageNum+1)<= totalPage){ //如果是最后一页
					$('.list-loading').hide();
					$('.list-nomore').hide()
					$('#page').show();
				}else{
					$('#page').hide();
					$('.list-loading').hide();
					$('.list-nomore').show()
				}
			}
		}
		/**加载数据
		 *reload 重置加载次数
		*/
		function loadData(reload){
			var loadImg = window.onscroll;// 见/js/html5/common.js
			loading = true;
			$('#page').hide();
			$('.list-nomore').hide();
			$('.list-loading').show();
			var param = jQuery('#condtion').serialize();
			var url = "AjaxFilterProdList?page="+(pageNum+1)+"&oper=PAGE_ADD";
			jQuery.ajax({
		        url: url,
		        type: 'POST',
		        data: param,
		        error: function(msg) {
		        },
		        success: function(r) {
		        	$('.new-mu_l2w').eq(-1).after(r);
		        	reloadNum++;
		        	pageNum++;
		        	if(pageNum >= totalPage){
						$('.list-nomore').show();
						$('#page').hide();
					}else{
						loading = false;
					}
		        }
		    });
			/*Zepto.getJSON(getUrl(pageNum+1), function(data, status, xhr){
				var json = Zepto.parseJSON(data);
				renderColumn(json.wares);
				pageNum++;
				if(reload){
					reloadNum = 1;
				}else{
					reloadNum++;
				}
				loadImg()
				$('.list-loading').hide();
				if(pageNum >= totalPage){
					$('.list-nomore').show();
					$('#page').hide();
				}else{
					loading = false;
				}
			})*/
		}
		
		function renderColumn(json){
			var html = ''; 
			html+='<ul class="new-mu_l2w">';
			for(var i = 0 ;i< json.length ; i++){
				var ware = json[i];
				var adword = ware.adword.length >0 ? ware.adword.replace(/<[^>]*>/g,'') : '';
				var price = parseFloat(ware.jdPrice,10);
				price = price =='NaN'?'':price;
				html+='<li class="new-mu_l2">';
				html+='<a href="/product/'+ware.wareId+'.html?provinceId=' + provinceId + '&resourceType=' + resourceType + '&resourceValue='+ resourceValue +'&sid='+ sid +'" class="new-mu_l2a">';
				html+='<span class="new-mu_tmb"><img src="/mobileStore/images/imgs/no_100_100.png?v=jd2015010820" imgsrc="' + ware.imgUrlN5.replace('/n4/','/n7/') + '" width="100" height="100" /></span>';
	            html+='<span class="new-mu_l2cw">';
	            html+='<strong class="new-mu_l2h">'+ware.wname+'</strong>';
	            html+='<span class="new-mu_l2h"><span class="new-txt-rd2 new-elps">' + adword + '</span></span>';
	            html+='<span class="new-mu_l2c"><strong class="new-txt-rd2">' + (price?('￥'+price):'暂无报价') + '</strong></span>';
	            html+='<span class="new-mu_l2c new-p-re">';
				html+='<span class="new-txt">' + ware.totalCount + '人评价' + ((ware.good && !ware.good.indexOf('%')>0)?(ware.good+'好评') : '') +'</span>';
				html+='<span class="new-sale-icon">' + getShortPromotion(ware.promotionFlag) + '</span>';
				html+='</span>';
				html+=(ware.canFreeRead?'<span class="new-mu_l2c"><span class="new-online-rd">可在线试读</span></span>':'');
				html+='</span>';
				html+='</a>';
	            html+='</li>';
			}
			html+='</ul>';
			$('.new-mu_l2w').eq(-1).after(html);
		}
		
		function getShortPromotion(promotionFlag){
			var html ='';
			for(var k in promotionFlag){
				if(k == 100){
					html += '<span class="new-add">享</span>';
				}else if(k == 1){
					html += '<span class="new-del">降</span>';
				}else if(k == 5){
					html += '<span class="new-add2">赠</span>';
				}else if(k == 4){
					html += '<span class="new-del2">豆</span>';
				}else if(k == 3){
					html += '<span class="new-add">券</span>';
				}else{
					html += '<span class="new-add">'+promotionFlag[k]+'</span>';
				}
			}
			return html;
		}
		function getUrl(page){
			var url='';
			if(keyword){
				url = '/ware/search.json?cid=0&keyword=2&sort=0&page=' + page + '&expressionKey=&expandName=&minprice=&maxprice=&stock=&resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7';
			}else{
				url='/products/----1-0-' + page + '.html?cid=&stock=&resourceType=search&resourceValue=&sid=e05342df03dd29ae84a48b2e06c03af7&_format_=json';
			}
			return url;
		}
		$(function(){
			columnHigth = $('.new-mu_l2w').eq(0).find('li').eq(0).height();
			$('a[f="1"]').click(function(e){
	    		var cobj = e.srcElement || e.target;
	    		var id = $(cobj).attr('id');
	    		if(!id)id=$(cobj).parent('a').attr('id')||$(cobj).parent('span').parent('a').attr('id');
				if($('#'+id).hasClass('on')){return;}
				if(id!='btn_filter'){
	    			$('.new-tab-type2').hide();
	        		$('.new-tab-type3').hide();
	        		$('.new-tab-type4').hide();
				}
				if($('#'+id).hasClass('on')){
					//$('a[f="1"]').removeClass('on');
				}else{
					var tagSort = !$('#btn_sort').hasClass('on');
					var tagStock = !$('#btn_stock').hasClass('on');
					var tagDelivery = !$('#btn_delivery').hasClass('on');
					if(id!='btn_filter'){
						$('a[f="1"]').removeClass('on');
						$('#'+id).addClass('on');
					}
	        		if(id=='btn_sort'){
						if(tagStock && tagDelivery){
	    					$('.new-tab-type2').css({'display':'block','height':'0px'});
	        				$('.new-tab-type2').animate({'height':'34px'},{'duration':'fast'});
						}else{
							//$('.new-tab-type2').css({'display':'block'});
							$('.new-tab-type2').css({'opacity':'0','display':'block'});
							$('.new-tab-type2').animate({'opacity':10},'slow');
						}
	        		}else if(id=='btn_stock'){
						if(tagSort && tagDelivery){
	    					$('.new-tab-type3').css({'display':'block','height':'0px'});
	        				$('.new-tab-type3').animate({'height':'34px'},{'duration':'fast'});
						}else{
							//$('.new-tab-type3').css({'display':'block'});
							$('.new-tab-type3').css({'opacity':'0','display':'block'});
							$('.new-tab-type3').animate({'opacity':10},'slow');
						}
	        		}else if(id=='btn_delivery'){
						if(tagSort && tagStock){
	    					$('.new-tab-type4').css({'display':'block','height':'0px'});
	        				$('.new-tab-type4').animate({'height':'34px'},{'duration':'fast'});
						}else{
							//$('.new-tab-type4').css({'display':'block'});
							$('.new-tab-type4').css({'opacity':'0','display':'block'});
							$('.new-tab-type4').animate({'opacity':10},'slow');
						}
	        		}else if(id=='btn_filter'){
						$('#filterbar').show();
						var height = ((document.body||document.documentElement).clientHeight+20)+'px';
						if(parseInt($('#slidebar').css('height').replace('px',''))>parseInt(height.replace('px',''))-20){
							height = (parseInt($('#slidebar').css('height').replace('px',''))+50)+'px';
						}
						$('#filterbar').css('height',(parseInt(height.replace('px',''))-50)+"px");
						var width = '100%';
						var maskArrow = document.createElement("a");
						maskArrow.setAttribute('class','new-abtn-slid');
						maskArrow.setAttribute('style','z-index:8889;left:auto;right:185px;');
						maskArrow.setAttribute('id','_maskArrow');
	        			var mask = document.createElement("div");
						mask.setAttribute('id','_mask');
						mask.setAttribute('style','position:absolute;left:0px;top:0px;background-color:rgb(13, 13, 13);filter:alpha(opacity=60);opacity: 0.6;width:'+width+';height:'+height+';z-index:8888;');
						(document.body||document.documentElement).appendChild(mask);
						(document.body||document.documentElement).appendChild(maskArrow);
						var scrolltop = (document.body||document.documentElement).scrollTop;
						$('#filterbar').css("top",(scrolltop-28)+"px");
						document.getElementById('slidebar').setAttribute('style',' -webkit-transform-style: preserve-3d; -webkit-transition: -webkit-transform 0.4s; -webkit-transform-origin: 0px 0px; -webkit-transform: translate(0px, 0); ');
						$('#_maskArrow').click(function(){
	            			closeFilter();
	            		});
						$('#_mask').click(function(){
	            			closeFilter();
	            		});
	        		}
				}
	    	});
			/*区域
			$('#select_region').change(function(){
				var text = document.getElementById('select_region').options[document.getElementById('select_region').selectedIndex].text;
				$('#regionShow').html(text+'<span></span>');
				var val = $('#select_region').val();
				$('#region').val(val);
				if(val=='0'){
					$('#stock').val('');
				}
				$('#condtion').submit();
			});
			
			if($('#region').val()!='' && $('#region').val()!='0'){
	    		$('#checkbox_stock').click(function(){
	    			if($('#checkbox_stock').children('span').hasClass('on')){
	    				$('#checkbox_stock').children('span').removeClass('on')
	    				$('#stock').val("");
	    			}else{
	    				$('#checkbox_stock').children('span').addClass('on')
	    				$('#stock').val("1");
	    			}
	    			$('#condtion').submit();
	    		});
			}*/
			$('#checkbox_stock').click(function(){
    			if($('#checkbox_stock').children('span').hasClass('on')){
    				$('#checkbox_stock').children('span').removeClass('on')
    				$('#stock').val("");
    			}else{
    				$('#checkbox_stock').children('span').addClass('on')
    				$('#stock').val("1");
    			}
    			$('#condtion').submit();
    		});
    		/*配送
			$('#self_all').click(function(){
				$('#self_all').children('span').removeClass('on');
				$('#self_jd').children('span').removeClass('on');
				$('#self_other').children('span').removeClass('on');
				$('#self_all').children('span').addClass('on');
				$('#self').val("");
				$('#condtion').submit();
			});
			$('#self_jd').click(function(){
				$('#self_all').children('span').removeClass('on');
				$('#self_jd').children('span').removeClass('on');
				$('#self_other').children('span').removeClass('on');
				$('#self_jd').children('span').addClass('on');
				$('#self').val("1");
				$('#condtion').submit();
			});
			$('#self_other').click(function(){
				$('#self_all').children('span').removeClass('on');
				$('#self_jd').children('span').removeClass('on');
				$('#self_other').children('span').removeClass('on');
				$('#self_other').children('span').addClass('on');
				$('#self').val("2");
				$('#condtion').submit();
			});
			*/
			$('#btn_prop').click(function(){
				$(this).addClass('on');
				$('#btn_cat').removeClass('on');
				$('#filter_prop').show();
				$('#filter_cat').hide();
			});
			$('#btn_cat').click(function(){
				$(this).addClass('on');
				$('#btn_prop').removeClass('on');
				$('#filter_prop').hide();
				$('#filter_cat').show();
			});
			$('#runtop').hide();
			$('#loadmore').on('click', function(){
				loadData(true);
			});
			$('#goToTop').on('click', function(){
				window.location.href='#top';
			});
			$('#geToIndex').on('click', function(){
				window.location.href='main?sid='+sid;
			});
			$('.new-fr').remove();
			operaSwitch();
			$(window).scroll(function(){
				operaSwitch();
				loadPage();
			}); 
		})
	</script>
	   
	<div class="login-area" id="footer">
		<div class="login">
			<#if userLogin??>
				<a rel="nofollow" href="memberCenter">${(userLogin.userLoginId)!'---'}</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="logout">退出</a>
			<#else>
				<a rel="nofollow" href="login">登录</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="register">注册</a>
			</#if>
		</div>
		<div class="version">
			<a href="http://wap.jd.com/index.html?v=w&sid=e05342df03dd29ae84a48b2e06c03af7">标准版</a><a href="javascript:void(0)" class="on">触屏版</a>
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
</html>
 				