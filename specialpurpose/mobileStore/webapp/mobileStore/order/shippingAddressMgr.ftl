	<link rel="apple-touch-icon-precomposed" href="http://p.m.jd.com/images/apple-touch-icon.png?v=20141231">
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
	<script src="/mobileStore/images/js/jquery-1.6.2.min.js?v=20141231"></script>
	<script src="/mobileStore/images/js/zepto.min.js"></script>
	<script type="text/javascript">window.jQuery=window.Zepto;</script>
	<script type="text/javascript" src="/mobileStore/images/js/common.js"></script>
	<script type="text/javascript" src="/mobileStore/images/js/spin.min.js"></script>
	<script src="/mobileStore/images/js/installapp.js" type="text/javascript" charset="utf-8"></script>
	<script src="/mobileStore/images/js/installapp.js?v=20141231" type="text/javascript" charset="utf-8"></script>
</head>
<body id="body">
	<a name="top"></a>
	<header>
		<div class="new-header">
			<a href="javascript:pageBack();" class="new-a-back" id="backUrl"><span>返回</span></a>
			<h2>收货地址</h2>
			<a href="javascript:void(0)" id="btnJdkey" class="new-a-jd"><span>京东键</span></a>
		</div>
		<div class="new-jd-tab" style="display:none" id="jdkey">
			<div class="new-tbl-type">
				<a href="http://m.jd.com/index.html?sid=e830beda275396f1cae8bd184e257a05" class="new-tbl-cell">
					<span class="icon">首页</span>
					<p style="color:#6e6e6e;">首页</p>
				</a>
				<a href="http://m.jd.com/category/all.html?sid=e830beda275396f1cae8bd184e257a05" class="new-tbl-cell">
					<span class="icon2">分类搜索</span>
					<p style="color:#6e6e6e;">分类搜索</p>
				</a>
				<a href="javascript:void(0)" id="html5_cart" class="new-tbl-cell">
					<span class="icon3">购物车</span>
					<p style="color:#6e6e6e;">购物车</p>
				</a>
				<a href="http://p.m.jd.com/user/home.action?sid=e830beda275396f1cae8bd184e257a05" class="new-tbl-cell">
					<span class="icon4">用户中心</span>
					<p style="color:#6e6e6e;">用户中心</p>
				</a>
			</div>
		</div>
	</header>
	    
	<div style="height: 1024.75px; width: 100%; z-index: 1001; position: absolute; overflow: hidden; background-color: rgba(145, 145, 145, 0.0980392); display: none;" id="background">
	</div>
	<div class="err_msg" id="errorMessage" style="display:block;color:red;margin-top:0.5em;margin-left:0.5em"></div>	
	<div class="new-ct">
	<form action="http://p.m.jd.com/norder/updateOrderAddressTouch.action?sid=e830beda275396f1cae8bd184e257a05" method="post" id="addressForm">
		
		<div class="addr-add">
			<a href="shippingAddressEdit" class="btn-addr">+添加收货地址</a>
		</div>
		
		<div class="err_msg" id="errorMessage" style="display:block;color:red;margin-bottom:0.5em;margin-top:0.5em;"></div>	
		<#if contactMeches?has_content>
	        <#list contactMeches as contactMechMap>
	            <#assign contactMech = contactMechMap.contactMech>
	            <#list contactMechMap.partyContactMechPurposes as partyContactMechPurpose>
	                <#assign contactMechPurposeType = partyContactMechPurpose.getRelatedOne("ContactMechPurposeType", true)>
	            </#list>
	            <#if "POSTAL_ADDRESS" = contactMech.contactMechTypeId && "Shipping Destination Address" = contactMechPurposeType.get("description")>
                    <#if contactMechMap.postalAddress?has_content>
                        <#assign postalAddress = contactMechMap.postalAddress>
                    </#if>
                    <#if contactMechMap.telecomNumber?has_content>
                        <#assign telecomNumber = contactMechMap.telecomNumber>
                    </#if>
	                <div class="addr-info">
						<div class="addr-border">
							<div class="pd-tb10">
								<p>${(postalAddress.toName)!(postalAddress.attnName)!}<span>&nbsp; ${(postalAddress.mobileExd)!}</span></p>
								<p class="text-f14-c6">${(postalAddress.address1)!}</p>
							</div>
							<div class="bg-border3"></div>
							<div class="addr-btn">
								<span class="tbl-type">
									<span class="tbl-cell" onmousedown="keyDown('${contactMech.contactMechId!}')">
										<!-- [D] 被选中状态时加 on -->
										<a href="javascript:void(0)" class="btn-chk" name="selSpan" id="selSpan${contactMech.contactMechId!}" style="width:100%"><span></span>送到这里去</a>
									</span>
									<span class="tbl-cell text-right">
										<a href="shippingAddressEdit?contactMechId=${contactMech.contactMechId!}" class="btn-update"><span></span>修改</a>
										<a href="javascript:confirmDel('${contactMech.contactMechId!}');" class="btn-del"><span></span>删除</a>
										<a id="delHref137599534" href="http://p.m.jd.com/norder/delAddress.action?addressId=137599534&amp;sid=e830beda275396f1cae8bd184e257a05" style="display:none"></a>
									</span>
								</span>
							</div>
						</div>
					</div>
	            </#if>
	        </#list>
	    </#if>
		<#--
		<div class="addr-info">
			<div class="addr-border">
				<div class="pd-tb10">
					<p>赵霞 <span>&nbsp; 13882778725</span>  </p>
					<p class="text-f14-c6">四川泸州市合江县合江镇建设路 22号 以纯专卖店</p>
				</div>
				<div class="bg-border3"></div>
				<div class="addr-btn">
					<span class="tbl-type">
						<span class="tbl-cell" onclick="selectAddress('137599534')" onmousedown="keyDown(137599534)">
							<!-- [D] 被选中状态时加 on -- >
							<a href="javascript:void(0)" name="selSpan" id="selSpan137599534" class="btn-chk" style="width:100%"><span></span>送到这里去</a>
						</span>
						<span class="tbl-cell text-right">
							<a href="http://p.m.jd.com/norder/editAddress.action?vtuanOrder=false&amp;addressId=137599534&amp;sid=e830beda275396f1cae8bd184e257a05" class="btn-update"><span></span>修改</a>
							<a href="javascript:confirmDel(" 137599534")"="" class="btn-del"><span></span>删除</a>
							<a id="delHref137599534" href="http://p.m.jd.com/norder/delAddress.action?addressId=137599534&amp;sid=e830beda275396f1cae8bd184e257a05" style="display:none"></a>
						</span>
					</span>
				</div>
			</div>
		</div>
		-->
		<input type="hidden" name="vtuanOrder" value="false">
		<input type="hidden" id="addressId" name="addressId" value="">
	</form>
	</div>
	<script type="text/javascript" src="/mobileStore/images/js/norder.js"></script>
	<script type="text/javascript" src="/mobileStore/images/js/address.js"></script>
	<script>
		function selectAddress(addressId){
	    	$("#addressId").val(addressId);
			spinerShow();
			$("#addressForm").submit();
			spinerHide();
	   	}
		function confirmDel(id){
			if(confirm("确定删除吗")){
				spinerShow();
				$("#delHref"+id).click();
				spinerHide();
			}
		}
		function keyDown(id){
			$("a[name='selSpan']").removeClass("on");
			$("#selSpan"+id).addClass("on");
			location.href='setDefaultContactMechId?contactMechId='+id;
		}
	   	$(document).ready(function(){
	    	$("#background").css("height",$("#body").css("height"));;
			if($("#parent1").text()!=""&&$("#parent1").text()!=null){
				$("#backUrl").attr("href","javascript:backListener('parent1')");
			}
		});
	</script>
	
	   
	<div class="login-area" id="footer">
		<div class="login">
			<#if userLogin??>
				<a rel="nofollow" href="memberCenter">${(userLogin.userLoginId)!'---'}</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="logout">退出</a>
			<#else>
				<a rel="nofollow" href="login">登录</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="register">注册</a>
			</#if>
			<span class="new-fr"><a href="http://m.jd.com/showvote.html?sid=e830beda275396f1cae8bd184e257a05">反馈</a><span class="lg-bar">|</span><a href="http://p.m.jd.com/norder/address.action?sid=e830beda275396f1cae8bd184e257a05#top">回到顶部</a></span>
		</div>
		<div class="version"><a href="http://wap.jd.com/index.html?v=w&amp;sid=e830beda275396f1cae8bd184e257a05">标准版</a><a href="javascript:void(0)" class="on">触屏版</a>
			<a href="http://www.jd.com/#m" id="toPcHome">电脑版</a>
		</div>
		<div id="clientArea">
			<a href="http://m.jd.com/download/downApp.html?sid=e830beda275396f1cae8bd184e257a05" id="toClient" class="openJD">客户端</a>
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
		//	syncCart('e830beda275396f1cae8bd184e257a05',true);
			location.href='/cart/cart.action';
		});
		
		function reSearch(){
		var depCity = window.sessionStorage.getItem("airline_depCityName");
			if(testSessionStorage() && isNotBlank(depCity) && !/^\s*$/.test(depCity) && depCity!=""){
		    	var airStr = '<form action="/airline/list.action" method="post" id="reseach">'
		        +'<input type="hidden" name="sid"  value="e830beda275396f1cae8bd184e257a05"/>'
		        +'<input type="hidden" name="depCity" value="'+ window.sessionStorage.getItem("airline_depCityName") +'"/>'
		        +'<input type="hidden" name="arrCity" value="'+ window.sessionStorage.getItem("airline_arrCityName") +'"/>'
		        +'<input type="hidden" name="depDate" value="'+ window.sessionStorage.getItem("airline_depDate") +'"/>'
		        +'<input type="hidden" name="depTime" value="'+ window.sessionStorage.getItem("airline_depTime") +'"/>'
		        +'<input type="hidden" name="classNo" value="'+ window.sessionStorage.getItem("airline_classNo") +'"/>'
		        +'</form>';
		    	$("body").append(airStr);
		    	$("#reseach").submit();
			}else{
		    	window.location.href='/airline/index.action?sid=e830beda275396f1cae8bd184e257a05';
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
	</script>
</body>