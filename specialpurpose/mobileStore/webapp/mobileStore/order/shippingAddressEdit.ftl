<meta name="author" content="m.jd.com">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="Expires" content="-1">           
<meta http-equiv="Cache-Control" content="no-cache">           
<meta http-equiv="Pragma" content="no-cache">           
	  				
				
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
<script src="/mobileStore/images/js/zepto.min.js"></script>
<script type="text/javascript">window.jQuery=window.Zepto;</script>
<script type="text/javascript" src="/mobileStore/images/js/common.js"></script>
<script type="text/javascript" src="/mobileStore/images/js/spin.min.js"></script><style></style>
<script src="/mobileStore/images/js/installapp.js" type="text/javascript" charset="utf-8"></script></head>

<body id="body">
<a name="top"></a>
<header>
			    						<div class="new-header">
        	<a href="javascript:pageBack();" class="new-a-back" id="backUrl"><span>返回</span></a>
							<h2>编辑收货人信息</h2>
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
    <div style="height:100%;width:100%;z-index:1001;position:absolute;overflow:hidden;background:rgba(145, 145, 145, .1);display:none" id="background">
</div>
<p style="color:red;">  </p>
<form action="shippingAddressCU" method="post" id="editAddressForm">
    <input type="hidden" name="contactMechTypeId" id="contactMechTypeId" value="POSTAL_ADDRESS">
    <input type="hidden" name="contactMechPurposeTypeId" id="contactMechPurposeTypeId" value="SHIPPING_LOCATION">
    <input type="hidden" name="contactMechId" id="contactMechId" value="${parameters.contactMechId!}">
<div class="new-ct shouhuo">
    <div class="title">收货人地址</div>
    <div class="info-list">
        <div class="info pd">
        	<div class="tbl-type">
            	<span class="tbl-cell w80"><span>收货人姓名：</span></span>
                <span class="tbl-cell"><span><input type="text" maxlength="20" class="new-input" name="attnName" id="address_name" value="${(postalAddress.attnName)!}" style="width:100%;"></span></span>
            </div>
        </div>
        <div class="info pd" style="display:none" id="nameErrorMsg">
        	<div class="tbl-type">
            	<span class="tbl-cell w80"><span style="color:red">收货人姓名不能为空</span></span>
            </div>
        </div>
        <div class="info pd">
        	<div class="tbl-type">
            	<span class="tbl-cell w100"><span>收货人手机号：</span></span>
                <span class="tbl-cell"><span><input type="text" maxlength="11" class="new-input" name="mobileExd" id="address_mobile" value="${(postalAddress.mobileExd)!}" style="width:100%;"></span></span>
            </div>
        </div>
        <div class="info pd" id="mobileErrorMsgDiv" style="display:none">
        	<div class="tbl-type">
            	<span class="tbl-cell w80"><span style="color:red" id="mobileErrorMsg"></span></span>
            </div>
        </div>
		<div class="info pd">
        	<div class="tbl-type">
        		<#if postalAddress??&&postalAddress.stateProvinceGeoId??>
					<#assign geo = delegator.findByPrimaryKey("Geo",{"geoId":postalAddress.stateProvinceGeoId})>
				</#if>
            	<span class="tbl-cell w50"><span>省份：</span></span>
                <span class="tbl-cell">                	
                    <span class="new-input-span">
                        <span class="new-sel-box new-p-re">
                            <label id="province_label">${(geo.geoName)!'请选择'}</label>
                            <select name="stateProvinceGeoId" id="address_province" class="new-select" style="width:200px;" onchange="getArea(this, '', 'address_city', 'address_area')">
                            	<#--<option selected="" id="option_add_1" value="1">北京</option><option id="option_add_2" value="2">上海</option><option id="option_add_3" value="3">天津</option><option id="option_add_4" value="4">重庆</option><option id="option_add_5" value="5">河北</option><option id="option_add_6" value="6">山西</option><option id="option_add_7" value="7">河南</option><option id="option_add_8" value="8">辽宁</option><option id="option_add_9" value="9">吉林</option><option id="option_add_10" value="10">黑龙江</option><option id="option_add_11" value="11">内蒙古</option><option id="option_add_12" value="12">江苏</option><option id="option_add_13" value="13">山东</option><option id="option_add_14" value="14">安徽</option><option id="option_add_15" value="15">浙江</option><option id="option_add_16" value="16">福建</option><option id="option_add_17" value="17">湖北</option><option id="option_add_18" value="18">湖南</option><option id="option_add_19" value="19">广东</option><option id="option_add_20" value="20">广西</option><option id="option_add_21" value="21">江西</option><option id="option_add_22" value="22">四川</option><option id="option_add_23" value="23">海南</option><option id="option_add_24" value="24">贵州</option><option id="option_add_25" value="25">云南</option><option id="option_add_26" value="26">西藏</option><option id="option_add_27" value="27">陕西</option><option id="option_add_28" value="28">甘肃</option><option id="option_add_29" value="29">青海</option><option id="option_add_30" value="30">宁夏</option><option id="option_add_31" value="31">新疆</option><option id="option_add_32" value="32">台湾</option><option id="option_add_42" value="42">香港</option><option id="option_add_43" value="43">澳门</option><option id="option_add_84" value="84">钓鱼岛</option>-->
                            	<#assign stateAssocs = Static["org.ofbiz.system.ContactMechTools"].getAssociatedStateList(delegator,'CHN')>
								<#list stateAssocs as stateAssoc>
									<option <#if (postalAddress.stateProvinceGeoId)?? && postalAddress.stateProvinceGeoId==stateAssoc.geoId>selected</#if> value="${stateAssoc.geoId}">${stateAssoc.geoName?default(stateAssoc.geoId)}</option>
								</#list>
                            </select>
                        </span>
                    </span>
                </span>
            </div>
        </div>
        <div class="info pd">
        	<div class="tbl-type">
        		<#if (postalAddress.stateProvinceGeoId)??>
					<#assign cityAssocs = delegator.findByAnd("GeoAssoc",{"geoId":postalAddress.stateProvinceGeoId})/>
				</#if>
				<#if (postalAddress.cityGeoId)??>
					<#assign geoCity = delegator.findByPrimaryKey("Geo",{"geoId":postalAddress.cityGeoId})/>
				</#if>
            	<span class="tbl-cell w50"><span>城市：</span></span>
                <span class="tbl-cell">
                	<span class="new-input-span">
                        <span class="new-sel-box new-p-re">
                            <label id="city_label">${(geoCity.geoName)!'请选择'}</label>
                            <select name="cityGeoId" id="address_city" class="new-select" style="width:200px;" onchange="getArea(this, '', 'address_area', 'null')">
                            	<#--<option id="option_add_72" value="72">朝阳区</option><option id="option_add_2800" value="2800">海淀区</option><option id="option_add_2801" value="2801">西城区</option><option id="option_add_2802" value="2802">东城区</option><option id="option_add_2803" value="2803">崇文区</option><option id="option_add_2804" value="2804">宣武区</option><option id="option_add_2805" value="2805">丰台区</option><option id="option_add_2806" value="2806">石景山区</option><option id="option_add_2807" value="2807">门头沟</option><option id="option_add_2808" value="2808">房山区</option><option id="option_add_2809" value="2809">通州区</option><option id="option_add_2810" value="2810">大兴区</option><option id="option_add_2812" value="2812">顺义区</option><option id="option_add_2814" value="2814">怀柔区</option><option id="option_add_2816" value="2816">密云区</option><option id="option_add_2901" value="2901">昌平区</option><option id="option_add_2953" value="2953">平谷区</option><option id="option_add_3065" value="3065">延庆县</option>-->
                            	<#if cityAssocs??>
									<#list cityAssocs as cityAssoc>
										<#assign city = delegator.findByPrimaryKey("Geo",{"geoId":cityAssoc.geoIdTo})/>
										<option <#if (postalAddress.cityGeoId)?? && postalAddress.cityGeoId==city.geoId>selected</#if> value="${city.geoId}">${city.geoName?default(city.geoId)}</option>
									</#list>
								</#if>
                        	</select>
                        </span>
                    </span>
                </span>
            </div>
        </div>
        <div class="info pd">
        	<div class="tbl-type">
				<#if (postalAddress.cityGeoId)??>
					<#assign countyAssocs = delegator.findByAnd("GeoAssoc",{"geoId":postalAddress.cityGeoId})/>
				</#if>
				<#if (postalAddress.countyGeoId)??>
					<#assign geoCounty = delegator.findByPrimaryKey("Geo",{"geoId":postalAddress.countyGeoId})/>
				</#if>
            	<span class="tbl-cell w50"><span>区县：</span></span>
                <span class="tbl-cell">
                	<span class="new-input-span">
                        <span class="new-sel-box new-p-re">
                            <label id="area_label">${(geoCounty.geoName)!'请选择'}</label>
                            <select class="new-select" name="countyGeoId" id="address_area" onchange="getArea(this, '', 'null', 'null')" style="width:200px;">
                            	<#--<option id="option_add_2799" value="2799">三环以内</option><option id="option_add_2819" value="2819">三环到四环之间</option><option id="option_add_2839" value="2839">四环到五环之间</option><option id="option_add_2840" value="2840">五环到六环之间</option><option id="option_add_4137" value="4137">管庄</option><option id="option_add_4139" value="4139">北苑</option><option id="option_add_4211" value="4211">定福庄</option>-->
                            	<#if countyAssocs??>
									<#list countyAssocs as countyAssoc>
										<#assign county = delegator.findByPrimaryKey("Geo",{"geoId":countyAssoc.geoIdTo})/>
										<option <#if (postalAddress.countyGeoId)?? && postalAddress.countyGeoId==county.geoId>selected</#if> value="${county.geoId}">${county.geoName?default(county.geoId)}</option>
									</#list>
								</#if>
                        	</select>
                        </span>
                    </span>
                </span>
            </div>
        </div>
		<#--
        <div class="info pd" id="townaddress" style="display: none;">
        	<div class="tbl-type">
            	<span class="tbl-cell w50"><span>乡镇：</span></span>
                <span class="tbl-cell">
                	<span class="new-input-span">
                        <span class="new-sel-box new-p-re">
                            <label id="town_label"></label>
                            <select class="new-select" name="address.idTown" id="address_town" style="width:200px;"></select>
                        </span>
                    </span>
                </span>
            </div>
        </div>
        -->
        <div class="info border-b-none pd">
        	<div class="tbl-type">
            	<span class="tbl-cell w70"><span>地址信息：</span></span>
                <span class="tbl-cell"><span><label id="address_label"></label><textarea rows="2" style="height:auto;width:100%;" type="text" class="new-input" name="address1" id="address_where">${(postalAddress.address1)!}</textarea></span></span>
            </div>
        </div>
    </div>
		<div class="info pd" style="display:none" id="addressErrorMsg">
        	<div class="tbl-type">
            	<span class="tbl-cell w80"><span style="color:red">地址信息不能为空</span></span>
            </div>
        </div>
    <!--[D] 默认时加  new-abtn-default 把a标签换成span-->
    <a href="javascript:submitEditAddressForm()" class="new-abtn-type mgn">下一步</a>	
</div>
<script type="text/javascript" src="/mobileStore/images/js/norder.js"></script>
<script type="text/javascript" src="/mobileStore/images/js/address.js"></script>
<script type="text/javascript">

var submitEditAddressForm = function(){
	spinerShow();
	$("#editAddressForm").submit();
	spinerHide();
}

$(document).ready(function(){
		$("#editAddressForm").submit(validateSubmit);
    	//$("#address_province").change(citychange);
    	//$("#address_city").change(areachange);
    	//$("#address_area").change(townchange);
    	//$("#address_town").change(labelchange);
		$("#address_name").blur(validateName);
		$("#address_where").blur(validateWhere);
		$("#address_mobile").blur(validateAddressMobile);
	
		var type=$("#addresssType").val();
		if(type==0){
			idprovince=1;
			//provinceData(idprovince);	
		}else if(type>0||type==-1){
		    getData(type,'','','','','','1','72','2799','0');
		}
		
		if($("#parent1").text()!=""&&$("#parent1").text()!=null){
			$("#backUrl").attr("href","javascript:backListener('child1','parent1')");
		}
});
    </script>
</form>

   
	<div class="login-area" id="footer">
        	<div class="login">
				                	<a rel="nofollow" href="http://p.m.jd.com/user/home.action?sid=7d8f481f9badb00a6c23b2d751032cd5">
						        					24299176..
        									</a>
    				<span class="lg-bar">|</span>
											<a rel="nofollow" href="https://passport.m.jd.com/user/logout.action?sid=7d8f481f9badb00a6c23b2d751032cd5">退出</a>
													<span class="new-fr"><a href="http://m.jd.com/showvote.html?sid=7d8f481f9badb00a6c23b2d751032cd5">反馈</a><span class="lg-bar">|</span><a href="http://p.m.jd.com/norder/editAddress.action?vtuanOrder=false&addressId=0&sid=7d8f481f9badb00a6c23b2d751032cd5#top">回到顶部</a></span>
            </div>
        	<div class="version"><a href="http://wap.jd.com/index.html?v=w&sid=7d8f481f9badb00a6c23b2d751032cd5">标准版</a><a href="javascript:void(0)" class="on">触屏版</a>
									<a href="http://www.jd.com/#m" id="toPcHome">电脑版</a>
				        	</div>
        	<div id="clientArea">
	        	<a href="http://m.jd.com/download/downApp.html?sid=7d8f481f9badb00a6c23b2d751032cd5" id="toClient" class="openJD">客户端</a>
        	</div>
            <div class="copyright">© medref.cn</div>
        </div>

    <div style="display:none;">
        				<img src="/mobileStore/images/imgs/ja.jsp">
			    </div>
            <script type="text/javascript" src="/mobileStore/images/js/mping.min.js"></script>
        <script type="text/javascript">
            var userPin = '242991761-26336401';
            try{
                var pv= new MPing.inputs.PV();   //构造pv 请求
                if(userPin&&userPin!=''){
                    pv.userPin=userPin;
                }
                var mping = new MPing();        //构造上报实例
                mping.send(pv);                //上报pv
            } catch (e){}
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

	function reSearch(){
		var depCity = window.sessionStorage.getItem("airline_depCityName");
		if(testSessionStorage() && isNotBlank(depCity) && !/^\s*$/.test(depCity) && depCity!=""){
	    	var airStr = '<form action="/airline/list.action" method="post" id="reseach">'
	        +'<input type="hidden" name="sid"  value="7d8f481f9badb00a6c23b2d751032cd5"/>'
	        +'<input type="hidden" name="depCity" value="'+ window.sessionStorage.getItem("airline_depCityName") +'"/>'
	        +'<input type="hidden" name="arrCity" value="'+ window.sessionStorage.getItem("airline_arrCityName") +'"/>'
	        +'<input type="hidden" name="depDate" value="'+ window.sessionStorage.getItem("airline_depDate") +'"/>'
	        +'<input type="hidden" name="depTime" value="'+ window.sessionStorage.getItem("airline_depTime") +'"/>'
	        +'<input type="hidden" name="classNo" value="'+ window.sessionStorage.getItem("airline_classNo") +'"/>'
	        +'</form>';
	    	$("body").append(airStr);
	    	$("#reseach").submit();
		}else{
	    	window.location.href='/airline/index.action?sid=7d8f481f9badb00a6c23b2d751032cd5';
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
		/*if($(".download-con").length || $("#clientArea").length){
			_loadScript("/js/2013/installapp.js?v=20141231",{},function(){
				 $("#clientArea").length && downcheck($("#clientArea"),false);
			});
		}*/
	})
	
	// 设置省县市,传入出发的对象this,请求地址,表单ID,替换内容的name
	function getArea(thisObj, url, replaceDivId, childAreaDiv) {
		var selVal = $(thisObj).find("option:selected").html();
		$(thisObj).prev().html(selVal);
		var area = document.getElementById(replaceDivId + "");
		var childArea = document.getElementById(childAreaDiv + "");
		$.ajax({
			url:'ajaxArea',
			type:'POST',
			data:{parentId:thisObj.value},
			success:function(r){
				if ( r.areaList ) {
					var areaList = r.areaList;
					var optStr = '';
					for ( var i = 0, end = areaList.length; i < end; i++) {
						optStr += '<option value="'+areaList[i].geoId+'">'+areaList[i].geoName+'</option>';
					}
					$("#"+replaceDivId).html(optStr);
					if(childAreaDiv=='null'){
						$("#area_label").html('请选择');
					}else{
						$("#city_label").html('请选择');
						$("#area_label").html('请选择');				
						$("#"+childAreaDiv).html('');
					}
				}
			}
		});
	}
</script>
</body>
</html>