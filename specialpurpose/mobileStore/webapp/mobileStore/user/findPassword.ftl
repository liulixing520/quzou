<link rel="apple-touch-icon-precomposed" href="http://m.jd.com/images/apple-touch-icon.png">
<body id="body">
	<a name="top"></a>
	<header>
		<div class="new-header">
			<a href="javascript:pageBack();" class="new-a-back"><span>返回</span></a>
			<h2>找回密码</h2>
			<a href="javascript:void(0)" id="btnJdkey" class="new-a-jd"><span>京东键</span></a>
		</div>
		<div class="new-jd-tab" style="display:none" id="jdkey">
			<div class="new-tbl-type">
				<a href="http://m.jd.com/index.html" class="new-tbl-cell">
					<span class="icon">首页</span>
					<p style="color:#6e6e6e;">首页</p>
				</a>
				<a href="http://m.jd.com/category/all.html" class="new-tbl-cell">
					<span class="icon2">分类搜索</span>
					<p style="color:#6e6e6e;">分类搜索</p>
				</a>
				<a href="javascript:void(0)" id="html5_cart" class="new-tbl-cell">
					<span class="icon3">购物车</span>
					<p style="color:#6e6e6e;">购物车</p>
				</a>
				<a href="https://passport.m.jd.com/user/home.action" class="new-tbl-cell">
					<span class="icon4">用户中心</span>
					<p style="color:#6e6e6e;">用户中心</p>
				</a>
			</div>
		</div>
	</header>
	
	<div class="new-ct bind">
		<div class="new-pay-pw">
			<div class="new-set-info">
				<form id="form_fillAccountName" name="form_fillAccountName" action="" method="post">
					<span class="new-input-span mg-b15">
						<input id="userInput" class="new-input" name="userInput" placeholder="用户名/邮箱/已验证手机号" type="text">
					</span>
					<div style="display: block;" id="username_error" class="new-txt-err">输入不能为空</div>
					<span class="new-tbl-type new-mg-b5">
						<span class="new-tbl-cell w100">
							<span class="new-input-span">
								<input name="validateCode" id="validateCode" class="new-input" placeholder="请输入验证码" tip="请输入验证码" errorlabel="codeError" notblank="notBlank" valuemissingtxt="未输入验证码" "="" type="text">
							</span>
						</span>
						<span class="new-tbl-cell">
							<span class="new-abtn-code">
								<a href="javascript:void(0)" onclick="com_jd_passport_m_validateCode('code','codeKey','3');">
									<img id="code" style="width:100px;height:40px;" src="/mobileStore/images/imgs/authCodeImg.jpg">
								</a>
							</span>
							<a href="javascript:void(0);" onclick="com_jd_passport_m_validateCode('code','codeKey','3');" class="new-txt-rd2">换一张</a>
							<input value="ced921db1dcf390dd9351082a119fc36" name="codeKey" id="codeKey" type="hidden">
						</span>
					</span>
									
					<a class="new-abtn-type new-mg-t30" href="javascript:void(0);" id="btnFillAccountName">下一步</a>
				</form>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="/mobileStore/images/js/validateCode.js"></script>
	<script type="text/javascript" src="/mobileStore/images/js/findLoginPassword.js"></script>
	<script type="text/javascript">
		var sid = '';
		
		var formSubmit = function(){
			if(userInputBlur()){
	    		var param;
	    		if(sid == ''){
	    			param = {userInput:$("#userInput").val(),validateCode:$("#validateCode").val(),codeKey:$("#codeKey").val()};
	    		}else{
	    			param = {userInput:$("#userInput").val(),validateCode:$("#validateCode").val(),codeKey:$("#codeKey").val(),sid:sid};
	    		}	
	    		jQuery.get('/findloginpassword/checkUserInputUsername.json?',
	    			param,
	    			function(data){ 
						com_jd_passport_m_validateCode('code','codeKey','3');
	    				if(data.isSuccess=="T" ){
							form_fillAccountName.action = '/findloginpassword/selectAuthenticationPattern.action';
	    					form_fillAccountName.submit();
	    				}else{
	    					if(data.returnCode=="needUserName"){
								//邮箱不唯一
								form_fillAccountName.action = '/findloginpassword/emailNotUnique.action';
								form_fillAccountName.submit();
	    					}
	    					else if(data.returnCode=="chooseEmailOrUsername"){
								//用户名和邮箱相同且唯一
								form_fillAccountName.action = '/findloginpassword/usernameSameWithEmailUnique.action';
								form_fillAccountName.submit();
	    					}
	    					else if(data.returnCode=="chooseNeedEmailOrUsername"){
								//用户名和邮箱相同不唯一
								form_fillAccountName.action = '/findloginpassword/usernameSameWithEmailNotUnique.action';
								form_fillAccountName.submit();
	    					}
							else if(data.returnCode=="chooseMobileOrUsername"){
								//用户名和手机相同
								form_fillAccountName.action = '/findloginpassword/usernameSameWithMobile.action';
								form_fillAccountName.submit();
	    					}
							else if(data.returnCode=="none"){
								$("#username_error").show();
								$("#username_error").html("用户名 不存在");
	    					}
							else if(data.returnCode=="codeError"){
								$("#username_error").show();
								$("#username_error").html("验证码错误");
							}
							else{
								$("#username_error").show();
								$("#username_error").html("系统异常");
							}
							
	    				}
    				}
    			);
			}
		}
		var userInputBlur = function(){
			if($("#userInput").val()==''){
				$("#username_error").show();
				$("#username_error").html("输入不能为空");
				return false;
			}
			return true;
		}
		var userInputFocus = function(){
			$("#username_error").hide();
		}
	    $(document).ready(function(){
			$('#userInput').blur(userInputBlur);
			$('#userInput').focus(userInputFocus);
			$('#btnFillAccountName').click(formSubmit);
	    }); 
	</script>
	
	
	
	
	
	<footer>
		<div class="login-area" id="footer">
			<div class="login">
				<a href="https://passport.m.jd.com/user/login.action">登录</a><span class="lg-bar">|</span><a href="https://passport.m.jd.com/user/mobileRegister.action">注册</a>
				<span class="new-fr"><a href="http://m.jd.com/showvote.html">反馈</a><span class="lg-bar">|</span><a href="#top">回到顶部</a></span>
			</div>
			<div class="version"><a href="http://m.jd.com/index.html?v=w">标准版</a><a href="javascript:void(0)" class="on">触屏版</a><a href="http://www.jd.com/" id="toPcHome">电脑版</a></div>
			<div class="copyright">© medref.cn</div>
		</div>
	</footer>
	
	
	<div style="display:none;">
	<img src="/mobileStore/images/imgs/ja.gif">
	</div>
	
	<script type="text/javascript" src="/mobileStore/images/js/pingJS.js"></script>
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
			//syncCart('',true);
			location.href='http://m.jd.com/cart/cart.action';
		});
		
		function reSearch(){
		var depCity = window.sessionStorage.getItem("airline_depCityName");
			if(testSessionStorage() && isNotBlank(depCity) && !/^\s*$/.test(depCity) && depCity!=""){
		    	var airStr = '<form action="/airline/list.action" method="post" id="reseach">'
		        +'<input type="hidden" name="sid"  value=""/>'
		        +'<input type="hidden" name="depCity" value="'+ window.sessionStorage.getItem("airline_depCityName") +'"/>'
		        +'<input type="hidden" name="arrCity" value="'+ window.sessionStorage.getItem("airline_arrCityName") +'"/>'
		        +'<input type="hidden" name="depDate" value="'+ window.sessionStorage.getItem("airline_depDate") +'"/>'
		        +'<input type="hidden" name="depTime" value="'+ window.sessionStorage.getItem("airline_depTime") +'"/>'
		        +'<input type="hidden" name="classNo" value="'+ window.sessionStorage.getItem("airline_classNo") +'"/>'
		        +'</form>';
		    	$("body").append(airStr);
		    	$("#reseach").submit();
			}else{
		    	window.location.href='http://m.jd.com/airline/index.action';
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