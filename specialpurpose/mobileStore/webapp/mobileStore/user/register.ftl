<link rel="apple-touch-icon-precomposed" href="/mobileStore/images/imgs/apple-touch-icon.png">
<link href="/mobileStore/images/css/login.css" type="text/css" rel="stylesheet">
<body id="body">
	<a name="top"></a>
	<header>
		<div class="new-header">
			<a href="javascript:pageBack();" class="new-a-back"><span>返回</span></a>
			<h2>手机快速注册</h2>
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
				<a href="https://passport.m.jd.com/user/home.action?sid=e830beda275396f1cae8bd184e257a05" class="new-tbl-cell">
					<span class="icon4 on">用户中心</span>
					<p style="color:#6e6e6e;" class="on">用户中心</p>
				</a>
			</div>
		</div>
	</header>
	<div class="new-ct bind">
		<form action="https://passport.m.jd.com/user/mobileRegisterEnd.action?sid=e830beda275396f1cae8bd184e257a05" method="post" id="form">
		
			<div class="new-pay-pw">   		
				<div class="new-set-info">
					<input type="hidden" id="sid" value="e830beda275396f1cae8bd184e257a05">
					<input type="hidden" name="returnurl" value="">
					<p id="p_msg" style="display:none;"></p>
					<div class="new-txt-err" id="errormsg" style="display: none;"></div>
					
					<span class="new-tbl-type new-mg-b5">
						<span class="new-tbl-cell w100">
							<span class="new-input-span">
								<input name="validateCode" type="text" id="validateCode" class="new-input" placeholder="请输入验证码" tip="请输入验证码" onkeydown="changeColor(2,event)">
							</span>
						</span>
						<span class="new-tbl-cell">
							<span class="new-abtn-code">
								<img onclick="reloadCaptcha('captchaImage');" id="captchaImage" style="width:100px;height:40px;" src="<@ofbizUrl>captcha.jpg?captchaCodeId=captchaImage&unique=${nowTimestamp.getTime()}</@ofbizUrl>">
							</span>
							<a href="javascript:void(0);" onclick="reloadCaptcha('captchaImage');" class="new-txt-rd2">换一张</a>
							<input type="hidden" value="c6862c621999971f294bff8d57b9aabb" name="codeKey" id="codeKey">
							<script type="text/javascript" language="JavaScript">
			                    function reloadCaptcha(fieldName) {
			                        var captchaUri = "<@ofbizUrl>captcha.jpg?captchaCodeId=" + fieldName + "&amp;unique=_PLACEHOLDER_</@ofbizUrl>";
			                        var unique = Date.now();
			                        captchaUri = captchaUri.replace("_PLACEHOLDER_", unique);
			                        document.getElementById(fieldName).src = captchaUri;
			                    }
			            	</script>
			            	<#--
			            	session.setAttribute("_CAPTCHA_CODE_", captchaCodeMap);
				            captchaCodeMap.put(captchaCodeId, captchaCode);
			            	-->
						</span>
					</span>
					
					<div class="new-txt-err" id="validateCodeNull" style="display: none;"></div>
					
					<span class="new-input-span new-input-span-v1 new-mg-b10">
						<input class="new-input" type="tel" id="mobile" name="mobile" placeholder="请输入手机号码" title="请输入手机号码" maxlength="11">
						<a id="sub_btn" href="javascript:void(0);" class="new-get-btn">获取密码</a>
						<span id="second" class="new-get-num" style="display:none;"></span>
					</span>
					
					<div id="nameNull" class="new-txt-err" style="display: none;"></div>
					<span class="new-input-span new-mg-b10">
						<input type="text" class="new-input" name="password" id="password" placeholder="输入您收到的短信登录密码" title="输入您收到的短信登录密码">
					</span>
					<div class="new-txt-err" id="passwordNull" style="display: none;"></div>
					<!--[D] 默认时加  new-abtn-default 把a标签换成span-->
					<a href="javascript:void(0);" class="new-abtn-type new-mg-t15" id="submitMobile">注册</a>
				</div>
			</div>	
		</form>
	</div>
	
	<script type="text/javascript" src="/mobileStore/images/js/validateCode.js"></script>
	<script type="text/javascript" src="/mobileStore/images/js/user.js"></script>
	<script type="text/javascript">
	    var distantTime = 120;
	    var endTime;
		
		var mobileClick = function(){
			var password = $("#password").val();
			var mobile =  $("#mobile").val();
	
			var sid = $("#sid").val();
			if(password == ""){
				$("#passwordNull").text("短信登录密码不能为空");
				$("#passwordNull").show();
				return;
			}
			
			if(validateCode == ""){
				$("#validateCodeNull").text("图片验证码不能为空");
				$("#validateCodeNull").show();
				return;
			}
			
			jQuery.post('/user/doMobileRegister.json',{mobile:mobile,password:password,sid:sid},
				function(data){
					if(data.success!=true){
						$("#passwordNull").text(data.message);
						$("#passwordNull").show();
						com_jd_passport_m_validateCode('code','codeKey','2');
					}else{
					    //注册成功回到returnurl
						$("#form").submit();
					}
				}
			);
		}
		
		var getCode = function(){
			var nowTime = new Date().getTime()/1000;
			var time = Math.floor(endTime - nowTime);
			$("#second").text(time.toString()+'秒');
			if(time > 0){
				setTimeout("getCode()",1000);
			}else{
	           // $("#sub_btn").html("重新发送");
				$("#sub_btn").show();
				$("#second").hide();
				$("#p_msg").hide();
	            com_jd_passport_m_validateCode('code','codeKey','2');
			}
		}
		
		function getPassword(){
	        $("#validateCodeNull").hide();
		    $("#nameNull").hide();
			$("#passwordNull").hide();
			$("#errormsg").hide();
		     
	 		var validateCode = $("#validateCode").val();
		    if(validateCode == ""){
				//$('#sub_btn').css("margin-top","20px");
				$("#validateCodeNull").show();
				$("#validateCodeNull").text("图片验证码不能为空");
				return ;
			}
			var mobile = $("#mobile").val();
			if(mobile == ""){
				//$('#sub_btn').css("margin-top","20px");
				$("#nameNull").show();
				$("#nameNull").text("手机号不能为空");
				return ;
			}
			if(!mobile.match(/^1\d{10}$/)){
				//$('#sub_btn').css("margin-top","20px");
				$("#nameNull").text("手机号格式有误,请重新输入 ");
				$("#nameNull").show();
				return ;
			}
		   
			
			var sid = $("#sid").val();
			var codeKey = $("#codeKey").val();
			var codeLevel = $("#codeLevel").val();
			jQuery.get('/user/getCode.json',
			{mobile:mobile,sid:sid,validateCode:validateCode,codeKey:codeKey,codeLevel:codeLevel},
			function(data){ 
				if(data.success){ //成功
				     // $("#p_msg").text(data.success);
					$("#p_msg").hide();
				    $("#nameNull").hide();
					//发送按钮隐藏
					$("#sub_btn").hide();
					//倒计时显示
					$("#second").show();
					 endTime = new Date().getTime()/1000 + 120;
					getCode();
					
				}else{ //失败
				
								      $("#nameNull").text(data.message);
					$("#nameNull").show();
					 $("#p_msg").hide();
					 //发送按钮隐藏
					 $("#sub_btn").show();
					 //倒计时显示
					 //$("#second").show();
					 //endTime  = new Date().getTime()/1000 + 60;
	                 com_jd_passport_m_validateCode('code','codeKey','2');
								 
				}
			});
		}
		
		var check = function(){
			var mobile = $("#mobile").val();
			if(mobile == ""){
				//$('#sub_btn').css("margin-top","20px");
				$("#nameNull").show();
				$("#nameNull").text("手机号不能为空");
				return false;
			}
			if(!mobile.match(/^1\d{10}$/)){
				//$('#sub_btn').css("margin-top","20px");
				$("#nameNull").text("手机号格式有误,请重新输入 ");
				$("#nameNull").show();
				return false;
			}
				//$('#sub_btn').css("margin-top","0px");
				$("#codeSubmit").submit();
		}
		
		
		$(document).ready(function(){
			$("#mobile").click(function(){
			    $("#validateCodeNull").hide();
			    $("#nameNull").hide();
				$("#passwordNull").hide();
				$("#errormsg").hide();
			});
			
			
			$("#password").click(function(){
			    $("#validateCodeNull").hide();
			    $("#nameNull").hide();
				$("#passwordNull").hide();
				$("#errormsg").hide();
			});
			
			
			$("#validateCode").click(function(){
			    $("#validateCodeNull").hide();
			    $("#nameNull").hide();
				$("#passwordNull").hide();
				$("#errormsg").hide();
			});
			
			
			//获取密码
			$("#sub_btn").click(getPassword);
	
			//注册操作
			$("#submitMobile").click(mobileClick);
		})
		
		function changeColor(type,evt){
		 	evt = (evt) ? evt : ((window.event) ? window.event : "");
			var key = evt.keyCode?evt.keyCode:evt.which;
		 	if(type == 0 ){
				if(key == 8 || key == 46){
					var text = $('#username').val().trim();
					if(text.length == 1){
						$('#username').css("color","#DBDBDB");
					}
				}else{
					$('#username').css("color","black");
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
	<a href="https://passport.m.jd.com/user/login.action?sid=e830beda275396f1cae8bd184e257a05">登录</a><span class="lg-bar">|</span><a href="refister">注册</a>
	<span class="new-fr"><a href="http://m.jd.com/showvote.html?sid=e830beda275396f1cae8bd184e257a05">反馈</a><span class="lg-bar">|</span><a href="https://passport.m.jd.com/user/mobileRegister.action?sid=e830beda275396f1cae8bd184e257a05#top">回到顶部</a></span>
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
</body>