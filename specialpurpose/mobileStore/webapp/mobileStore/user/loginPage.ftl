<link rel="apple-touch-icon-precomposed" href="/mobileStore/images/imgs/apple-touch-icon.png">
<body id="body">
	<a name="top"></a>
	<header>
		<div class="new-header">
			<a href="javascript:pageBack();" class="new-a-back"><span>返回</span></a>
			<h2>登录</h2>
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
	
	<div class="new-ct bind">
		<div class="new-pay-pw">
			<div class="new-set-info">
				<form action="<@ofbizUrl>login</@ofbizUrl>" method="post" name="loginform" id="frm_login">
					<input type="hidden" name="returnurl" value="http://passport.m.jd.com/user/home.action?sid=e830beda275396f1cae8bd184e257a05">
					<div class="new-txt-err" id="err" style="display:none;"></div> 
					<span class="new-input-span mg-b15"><input type="text" value="<#if requestParameters.USERNAME?has_content>${requestParameters.USERNAME}<#elseif autoUserLogin?has_content>${autoUserLogin.userLoginId}</#if>" class="new-input" name="USERNAME" id="userName" placeholder="请输入用户名/邮箱/已验证手机" onkeydown="changeColor(0,event)"></span>
					<span class="new-input-span mg-b15"><input type="password" value="" class="new-input" name="PASSWORD" id="password" placeholder="请输入密码" onkeydown="changeColor(1,event)"></span>
					<#--
					<span class="new-tbl-type new-mg-b5">
	                    <span class="new-tbl-cell w100">
	    					<span class="new-input-span">
	    						<input type="text" onkeydown="changeColor(2,event)" valuemissingtxt="未输入验证码" notblank="notBlank" errorlabel="codeError" tip="请输入验证码" placeholder="请输入验证码" class="new-input" id="validateCode" name="validateCode">
	    					</span>
	    				</span>
	    				<span class="new-tbl-cell">
	    				  	<span class="new-abtn-code">
							 	<img src="/authCode/authCodeImg.action?key=599e1fe9b79eaf934d5bad3fba9eee2c" style="width:100px;height:40px;" id="code" onclick="com_jd_passport_m_validateCode('code','codeKey','1');">
	    				  	</span>
						 	<a class="new-txt-rd2" onclick="com_jd_passport_m_validateCode('code','codeKey','1');" href="javascript:void(0);">换一张</a>
						 	<input type="hidden" id="codeKey" name="codeKey" value="599e1fe9b79eaf934d5bad3fba9eee2c">
	                    </span>
	                </span>
	                -->
	                <input type="hidden" id="remember" value="true" name="remember">
					<a class="new-a-txt3" href="javascript:void(0);">
						<span class="new-chk2" onclick="remeber()"></span>
				    	一个月内免登录
					</a>
					<a href="javascript:void(0);" onclick="$('#frm_login').submit();" id="loginSubmit" class="new-abtn-type new-mg-t15">登录</a>
				</form>
					
				<div class="login-register">
					<div class="new-tbl-type">
						<span class="new-tbl-cell">
							<a rel="nofollow" href="register" class="new-fl">免费注册</a>
						</span>
						<span class="new-tbl-cell text-right">
							<a href="javascript:void(0);" class="new-fr"> 找回密码</a>  
						</span>
					</div>
				</div>
				<#--
				<div class="other-login">
					<p>其他方式登录</p>
					<div class="new-tbl-type">
						<a class="new-tbl-cell" href="http://m.jd.com/login/qq.action?sid=e830beda275396f1cae8bd184e257a05">
							<span class="qq">QQ</span>
						</a>
						<a class="new-tbl-cell" href="http://m.jd.com/login/renrengonggao.action?sid=e830beda275396f1cae8bd184e257a05">
							<span class="renren">人人</span>
						</a>
						<a class="new-tbl-cell" href="http://m.jd.com/login/doubangonggao.action?sid=e830beda275396f1cae8bd184e257a05">
							<span class="douban" style="width:90px;">豆瓣</span>
						</a>
						<a class="new-tbl-cell" href="http://m.jd.com/login/weibogonggao.action?sid=e830beda275396f1cae8bd184e257a05">
							<span class="sina">新浪</span>
						</a>
					</div>
				</div>
				-->
			</div>
		</div>	               
	</div>
	
	<script type="text/javascript" src="/mobileStore/images/js/validateCode.js"></script>
	<script type="text/javascript" src="/mobileStore/images/js/user.js"></script>
	<script type="text/javascript">
	   
		function remeber(){
			if($('.new-a-txt3').find('span').hasClass('on')){
				$('.new-a-txt3').find('span').removeClass('on');
				 $('#remember').val("true");
			}else{
				$('.new-a-txt3').find('span').addClass('on');
				$('#remember').val("false");
			}
		}
	    
		function checkUsername(){
			var username = $("#userName").val().trim();
			if(username == ""){
				if(true){
					$("#err").html("\u8d26\u6237\u540d\u4e0d\u80fd\u4e3a\u7a7a");
					$("#err").show();
				}else{
					$("#error").html("\u8d26\u6237\u540d\u4e0d\u80fd\u4e3a\u7a7a");
					$("#error").show();
				}
				return false;
			}
			return true;
		}
	
		function checkPassword(){
			var password = $("#password").val().trim();
			if(password == ""){
				if(true){
					$("#err").html("\u5bc6\u7801\u4e0d\u80fd\u4e3a\u7a7a");
	    			$("#err").show();
				}else{
					$("#error").html("\u5bc6\u7801\u4e0d\u80fd\u4e3a\u7a7a");
	    			$("#error").show();
				}
				return false;
			}
			return true;
		}
		
		function checkCode(){
			if($('#codeLevel').val() && $('#codeLevel').val()!='0' ){
				var code = $('#validateCode').val().trim();
				if(code == ""){
					if(true){
						$("#err").html("\u8bf7\u8f93\u5165\u9a8c\u8bc1\u7801");
	        			$("#err").show();
	    			}else{
	    				$("#error").html("\u8bf7\u8f93\u5165\u9a8c\u8bc1\u7801");
	        			$("#error").show();
					}
					return false;
				}
			}
			return true;
		}
		
		$(':text').focus(function(){
			$("#error").hide();
			$("#err").hide();
		});
	
		$(':password').focus(function(){
			$("#error").hide();
			$("#err").hide();
		});
		
		//非空验证
		$(document).ready(function(){
	      $('#frm_login').bind('submit',function(e){
	       if(!(checkUsername() && checkPassword() && checkCode())){
			   e.preventDefault();
			}
	      });
		  
		  $('#loginSubmit').click(function(){
		     $('#frm_login').submit();
		  });
		  
	    });
		
	 	function changeColor(type,evt){
		 	evt = (evt) ? evt : ((window.event) ? window.event : "");
			var key = evt.keyCode?evt.keyCode:evt.which;
		 	if(type == 0 ){
				if(key == 8 || key == 46){
					var text = $('#userName').val().trim();
					if(text.length == 1){
						$('#userName').css("color","#DBDBDB");
					}
				}else{
					$('#userName').css("color","black");
				}
			}
			if(type == 1 ){
				if(key == 8 || key == 46){
					var text = $('#password').val().trim();
					if(text.length == 1){
						$('#password').css("color","#DBDBDB");
					}
				}else{
					$('#password').css("color","black");
				}
			}
			if(type == 2 ){
				if(key == 8 || key == 46){
					var text = $('#validateCode').val().trim();
					if(text.length == 1){
						$('#validateCode').css("color","#DBDBDB");
					}
				}else{
					$('#validateCode').css("color","black");
				}
			}
		 }
	</script>
	<footer>
		<div class="login-area" id="footer">
			<div class="login">
				<#if userLogin??>
					<a rel="nofollow" href="memberCenter">${(userLogin.userLoginId)!'---'}</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="logout">退出</a>
				<#else>
					<a rel="nofollow" href="login">登录</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="register">注册</a>
				</#if>
				<span class="new-fr"><a href="javascript:void(0);">反馈</a><span class="lg-bar">|</span><a href="https://passport.m.jd.com/user/login.action?sid=e830beda275396f1cae8bd184e257a05&returnurl=http%3A%2F%2Fpassport.m.jd.com%2Fuser%2Fhome.action%3Fsid%3De830beda275396f1cae8bd184e257a05&ipChanged=false#top">回到顶部</a></span>
			</div>
			<div class="version"><a href="http://m.jd.com/index.html?v=w&sid=e830beda275396f1cae8bd184e257a05">标准版</a><a href="javascript:void(0)" class="on">触屏版</a><a href="http://www.jd.com/" id="toPcHome">电脑版</a></div>
			<div class="copyright">© medref.cn</div>
		</div>
	</footer>
		
	<div style="display:none;">
		<img src="/mobileStore/images/imgs/ja.jsp">
	</div>
	
	<script type="text/javascript" src="/mobileStore/images/js/pingJS.1.0.js"></script>
	<script type="text/javascript">
		pingJS( {"pin":""} );
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
			location.href='http://m.jd.com/cart/cart.action';
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
		    	window.location.href='http://m.jd.com/airline/index.action?sid=e830beda275396f1cae8bd184e257a05';
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
	<#--><div class="download-con" id="down_app" style="position: fixed; bottom: 0px;">
		<div class="down_app">
			<div class="download-logo"></div>
			<div class="alogo">
				<p class="client-name">客户端首单满59元送59元！</p>
				<p class="client-logon"></p>
			</div>
			<div class="open_now">
				<a id="openJD" href="http://m.jd.com/download/downApp.html?sid=e830beda275396f1cae8bd184e257a05"><span class="open_btn">立即打开</span></a>
			</div>
			<div class="close-btn-con close-btn">
				<span class="close-btn-icon"></span>
			</div>
		</div>
	</div>-->
	<script type="text/javascript">
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
				_loadScript("/js/html5/installapp.js?v=20140625",{},function(){
				});
			}
		})
	</script>
</body>