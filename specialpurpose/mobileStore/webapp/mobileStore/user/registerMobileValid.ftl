<link rel="apple-touch-icon-precomposed" href="http://m.jd.com/images/apple-touch-icon.png">
<body id="body">
	<a name="top"></a>
	<header>
		<div class="new-header">
			<a href="javascript:pageBack();" class="new-a-back"><span>返回</span></a>
			<h2>京东注册</h2>
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
	<link rel="stylesheet" type="text/css" href="/mobileStore/images/css/_base.css" charset="utf-8">
	<link rel="stylesheet" type="text/css" href="/mobileStore/images/css/_login.css" charset="utf-8">
	<#assign registerInfoMap = sessionAttributes._CAPTCHA_CODE_!/>
	<#if registerInfoMap??>
		<#assign registerMobile = registerInfoMap.registerMobile!>
	</#if>
	<#--<#if !registerMobile??>
		<script>
			//alert("注册的手机号码丢失！");
			//location.href='register2'
		</script>
	</#if>-->
	<input name="sid" id="sid" value="cb778200e91e22544e2553a1c7beb84a" type="hidden">
	<input name="mobile" id="mobile" value="${registerMobile!}" type="hidden">
	<input name="tgId" id="tgId" value="" type="hidden">
	<input name="unbindMobile" id="unbindMobile" value="${parameters.unbindMobile!}" type="hidden">
	<div class="common-wrapper" style="min-height:300px;">
	    <div class="main">
			<input id="pwd" name="pwd" value="" type="hidden">
	        <h2 id='sendCodeMSG'>
		        <#if registerMobile?? && registerMobile!=''>
					注册需要短信验证，已发送校验码至<span>${registerMobile!}</span>
				</#if>
			</h2>
			<div class="item item-sms-captcha" style="margin-bottom:10px;">
	            <input name="smscode" id="smscode" class="txt-input txt-sms-captcha" size="11" maxlength="6" autocomplete="off" placeholder="输入收到的验证码" type="tel">
	            <a href="javascript:void(0);" id="btn_getcode" class="btn-retransmit btn-retransmit-disabled">重新发送<span id="second">(8)</span></a>
	            <b style="display: block;" class="input-close code_close" onclick="cleartxt(1);" id="code_close"></b>
	        </div>
			
			<div class="item item-password password" style="margin-bottom:30px;">
	            <input class="txt-input txt-password" maxlength="20" placeholder="设置密码:6位以上数字或字母" required="" type="password">
	            <b class="tp-btn btn-off"></b>
	            <b style="display: none;" class="input-close pwd_close" onclick="cleartxt(0);" id="pwd_close"></b>
	        </div>
			<div class="item item-password text" style="margin-bottom:30px;display:none;">
	            <input class="txt-input txt-password" maxlength="20" placeholder="设置密码:6位以上数字或字母" required="" type="text">
	            <b class="tp-btn btn-on"></b>
	            <b style="display: none;" class="input-close pwd_close" onclick="cleartxt(0);" id="pwd_close"></b>
	        </div>
			
            <div class="item item-btns">
                <a href="javascript:void(0);" class="btn-login btn-disabled">注册</a>
            </div>
            <div style="text-align:right;">
				<a style="font-size: 14px; color: rgb(37, 37, 37); text-decoration: underline;" href="http://passport.m.jd.com/findloginpassword/fillAccountName.action?sid=cb778200e91e22544e2553a1c7beb84a">找回密码</a>
			</div>
	    </div>
	</div>
	<div class="pop-bg" style="display: none;"></div>
	<div class="pop pop1" style="display: none;">
		<p class="error"></p>
	</div>

	<form action="/myJd/home.action?sid=cb778200e91e22544e2553a1c7beb84a" method="post" id="frm_login">
	</form>
		<div id="autoLoginHeight"></div>
<script src="/mobileStore/images/js/autoHeight.js" type="text/javascript"></script>
<script type="text/javascript">

	var content;
	var endTime = new Date().getTime()/1000 + 60;
	$().ready(function() {
		autoHeight_login();
		$('#pwd').val('');
		$('#smscode').val('');
		$('.pwd_close').hide();
		$('.code_close').hide();
		<#if registerMobile?? && registerMobile!=''>
			getCode();
		<#else>
			//没找到手机号码就返回注册页面
			location.href="register2";
		</#if>
	});
	
	//获取短信验证码
	function getCode(){
		var mobileNum = $('#mobile').val();
		jQuery.post('sendSmsCode',
			{mobile:mobileNum},
			function(data){
				if(data.flag){
					cleartxt(1);
        			$('#btn_getcode').addClass("btn-retransmit-disabled");
					endTime = new Date().getTime()/1000 + 60;
					errShow(data.info);
					timer60();
					return true;
				}else{
					$('#btn_getcode').removeClass("btn-retransmit-disabled");
        			$('.btn-login').addClass("btn-disabled");
					$("#second").html('');
        			errShow(data.info);
					return false;
				}
			}
		);
	}
	
	//验证短信验证码
	function validCode(){
		var param;
		var smscode = $('#smscode').val().trim();
		var mobile = $('#mobile').val();
		var mobileFlag = 0;
        var pwd = $('#pwd').val();
        var sid = $('#sid').val();
        var tgId = $('#tgId').val();
        var sid = $('#sid').val();
        var unbindMobile = $('#unbindMobile').val();
		if(sid == ''){
    		param = {mobile:mobile,smscode:smscode,mobileFlag:0,pwd:pwd,tgId:tgId,unbindMobile:unbindMobile};
    	}else{
    		param = {mobile:mobile,smscode:smscode,mobileFlag:0,pwd:pwd,tgId:tgId,sid:sid,unbindMobile:unbindMobile};
    	}

		//先灰-改字，超时完成-改字
		//$('.btn-login').addClass("btn-disabled");
	 	$('.btn-login').addClass("btn-disabled");
		$('.btn-login').text('提交中');
		jQuery.ajax({
		　　	url:'validSmsCode',  //请求的URL
		　　	timeout : 30000, //超时时间设置，单位毫秒
		　　	type : 'post',  //请求方式，get或post
		　　	data :param,  //请求所传参数，json格式
		　　	dataType:'json',//返回的数据格式
		　　	success:function(data){ //请求成功的回调函数
		　　　　	if(data.info||data._ERROR_MESSAGE_||data._ERROR_MESSAGE_LIST_){
        			errShow(data.info||data._ERROR_MESSAGE_||data._ERROR_MESSAGE_LIST_);
					return false;
				}else{
					content = '注册成功';
					//+ '<br/>'
                    //+ '马上去登录';
					errShow(content);
					setTimeout("dologin()",2000);
				}
	　　		},
		　　	complete : function(){ //请求完成后最终执行参数
				posttimeout();
	　　		}
		});
		
	}
	//2355684669@QQ.com
	function dologin(){
		//$('#frm_login').submit();
		location.href="main";
	}
	function posttimeout(){
		$('.btn-login').removeClass("btn-disabled");
		$('.btn-login').text('注册');
	}
	
	 //60秒按钮停顿
    var timer60 = function(){
    	var nowTime = new Date().getTime()/1000;
    	var time = Math.floor( endTime- nowTime);
    	$("#second").html('('+time+')');
    	if(time > 0){
    		setTimeout("timer60()",1000);
    	}else{
    		$("#second").html('');
			$('#btn_getcode').removeClass("btn-retransmit-disabled");
    	}
    };

	function checkPwd(pwd){
		//可包含字母,数字及特殊字符
		//var reg = new RegExp("^(?=.*[a-zA-Z])(?=.*[0-9])(?=(?:.*?[-!@#$%*()=_+^&}{:;?.><]){1}).*$", "g");
		//var reg = new RegExp("^[\u0000-\u00FF]+$", "g");//全为半角字符
		var reg = /^([a-z|A-Z|0-9]*)+$/;
		var len = pwd.length;
		if(len==0){
			content = '密码不能为空';
			errShow(content);
			return false;
		}else if(len<6){
			content = '密码少于6位'
					+ '<br/>'
                    + '请重新输入';
			errShow(content);
			return false;
		}else if(!reg.test(pwd)){
			content = '请输入数字或字母的组合';
			errShow(content);
			return false;
		}
		return true;
	}
	
	function checkCode(){
		var reg = /^\w{4,6}$/;
		var smscode = $('#smscode').val();
		var len = smscode.length;
		if(len==0){
			content = '请输入短信验证码';
			errShow(content);
			return false;
		}else if(!reg.test(smscode)){
			content = '验证码不合规'
					+ '<br/>'
					+ '请重新输入';
			errShow(content);
			return false;
		}
		return true;
	}
	
	$('.txt-password').bind('input',function(){
		var pw = $(this).val().trim();
		$('#pwd').val(pw);
		if(pw != ""){
			var rule = /^[\x1B-\x7F]$/;
    		if(!rule.test(pw.substring(pw.length-1))){
    			$(this).val(pw.substring(0,pw.length-1));
    		}else{
    			$(this).val(pw);
    		}
			$('#pwd').val($(this).val());
			pw = $('#pwd').val();
			cleantxt("pwd_close", $(this).val());
			if(pw.length>=6 && $('#smscode').val().length==6){
    			$('.btn-login').removeClass("btn-disabled");
    		}else{
    			$('.btn-login').addClass("btn-disabled");
    		}
		}
		else{
			$('.pwd_close').hide();
		}
	});
	 
	$('#btn_getcode').click(function(){
		if(!$('#btn_getcode').hasClass("btn-retransmit-disabled")){
			getCode();
		}else{
			return false;
		}
	});
	
	function cleartxt(type){
		if(type == 0){
			$('.txt-password').val('');
			$('#pwd').val('');
			$('.pwd_close').hide();
		}else{
			$('#smscode').val('');
			$('.code_close').hide();
		}
		$('.btn-login').addClass("btn-disabled");
	}

	$('#smscode').bind('input',function(){
		var smscode = $('#smscode').val().trim();
		$('#smscode').val(smscode);
		cleantxt("code_close", smscode);
		var pw = $('#pwd').val();
		if(smscode.length==6 && pw.length>=6){
			$('.btn-login').removeClass("btn-disabled");
		}else{
			$('.btn-login').addClass("btn-disabled");
		}
	});
	
	$('.btn-login').click(function(){
		if($(this).hasClass("btn-disabled")){
			return false;
		}else{
			var pwd = $('#pwd').val();
			if(checkPwd(pwd) && checkCode()){
				validCode();
			}
		}
	});

	function errShow(content){
		$('.error').html(content);
		$('.pop-bg').show();
		$('.pop1').show();
		setTimeout("errHide()",3000);
	}
	
	function errHide(){
		$('.pop-bg').hide();
		$('.pop1').hide();
		$('.error').text('');
	}
	
	$('.btn-on').live('click',function(){
		$('.txt-password').val($('#pwd').val());
		$('.text').hide();
		$('.password').show();
		cleantxt("pwd_close", $('#pwd').val());
	});
	
	$('.btn-off').live('click',function(){
		$('.txt-password').val($('#pwd').val());
		$('.password').hide();
		$('.text').show();
		cleantxt("pwd_close", $('#pwd').val());
	});
	
	function cleantxt(n, v){
	 	if(v.trim()!="")
			$('.'+n).show();
		else
			$('.'+n).hide();
	 }
</script>
    <footer>
		<div class="login-area" id="footer">
        	<div class="login">
				<a href="https://passport.m.jd.com/user/login.action?sid=cb778200e91e22544e2553a1c7beb84a">登录</a><span class="lg-bar">|</span><a href="https://passport.m.jd.com/user/mobileRegister.action?sid=cb778200e91e22544e2553a1c7beb84a">注册</a>
    				<span class="new-fr"><a href="http://m.jd.com/showvote.html?sid=cb778200e91e22544e2553a1c7beb84a">反馈</a><span class="lg-bar">|</span><a href="#top">回到顶部</a></span>
            </div>
        	<div class="version"><a href="http://m.jd.com/index.html?v=w&amp;sid=cb778200e91e22544e2553a1c7beb84a">标准版</a><a href="javascript:void(0)" class="on">触屏版</a><a href="http://www.jd.com/" id="toPcHome">电脑版</a></div>
            <div class="copyright">© medref.cn </div>
        </div>
    </footer>


    <div style="display:none;">
        	<img src="/mobileStore/images/imgs/ja.gif">
        </div>

            <script type="text/javascript" src="/mobileStore/images/js/mping.js"></script>
        <script type="text/javascript">
            try{
                var pv= new MPing.inputs.PV();
                var mping = new MPing();
                mping.send(pv);
            } catch (e){
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
//	syncCart('cb778200e91e22544e2553a1c7beb84a',true);
	location.href='http://m.jd.com/cart/cart.action';
});

function reSearch(){
var depCity = window.sessionStorage.getItem("airline_depCityName");
	if(testSessionStorage() && isNotBlank(depCity) && !/^\s*$/.test(depCity) && depCity!=""){
    	var airStr = '<form action="/airline/list.action" method="post" id="reseach">'
        +'<input type="hidden" name="sid"  value="cb778200e91e22544e2553a1c7beb84a"/>'
        +'<input type="hidden" name="depCity" value="'+ window.sessionStorage.getItem("airline_depCityName") +'"/>'
        +'<input type="hidden" name="arrCity" value="'+ window.sessionStorage.getItem("airline_arrCityName") +'"/>'
        +'<input type="hidden" name="depDate" value="'+ window.sessionStorage.getItem("airline_depDate") +'"/>'
        +'<input type="hidden" name="depTime" value="'+ window.sessionStorage.getItem("airline_depTime") +'"/>'
        +'<input type="hidden" name="classNo" value="'+ window.sessionStorage.getItem("airline_classNo") +'"/>'
        +'</form>';
    	$("body").append(airStr);
    	$("#reseach").submit();
	}else{
    	window.location.href='http://m.jd.com/airline/index.action?sid=cb778200e91e22544e2553a1c7beb84a';
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
         jQuery.post('http://m.jd.com/index/addClientCookieVal.json',function(d){
               window.location.href=downloadUrl;
        });
    });




	
</script>



</body>
</html>