<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>登录</title>
    <link rel="stylesheet" href="/ofcupload/images/style/common.css" />
    <link rel="stylesheet" href="/ofcupload/images/style/login.css" />
    <script type="text/javascript" src="/ofcupload/images/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/ofcupload/images/js/public.js"></script>
	<script type="text/javascript">
	    $(".login_row").kingkongInput();
	</script>
</head>

<body>
<div id="login">
	<div class="logoHead">
		<span class="logo">
			<img src="/ofcupload/images/images/common/logo.png" />
		</span>
		<span class="welcome">欢迎登录</span>
	</div>
	<div class="loginMain clearfix">
		<div class="login-ad"><img src="/ofcupload/images/images/login/login.png" /></div>
	    <#if !errorMessageList?has_content>
				            <#assign errorMessageList = requestAttributes._ERROR_MESSAGE_LIST_?if_exists>
				            </#if>
				            <#if (errorMessage?has_content || errorMessageList?has_content)>
				                <#if errorMessageList?has_content>
				                  <#list errorMessageList as errorMsg>
				                    <label class="control-label"><span style="color:#FF0000">${errorMsg}</span></label>
				                    <script>
				                        $(document).ready(function(){
				                            $("#PASSWORD").focus();
				                        });
				                    </script>
				                  </#list>
				                </#if>
				            </#if>
		<form action="checkLogin" name="form1" id="form1" method="post">		            
	    <div class="login">
	    	<div class="login_top">用户名</div>
	        <div class="login_row">
	            <label class="user"></label>
	            <input type="text" name="USERNAME" id="USERNAME" value="" />
	            <#--<i>请输入用户名</i>-->
	        </div>
	        <div class="login_top">密码</div>
	        <div class="login_row">
	            <label class="psw"></label>
	            <input type="password" name="PASSWORD" id="PASSWORD" />
	            <#--<i>请输入密码</i>-->
	        </div>
	        <div class="login_top">验证码</div>
	        <div class="login_row2 code">
	            <#--<label class="ecode"></label>-->
	            <input type="text" name="randomCode" id="randomCode" />
	            <#--<i>请输入验证码</i>-->
	            <em>
	            <img id="randomCode_img2" width="100px;" alt="点击刷新" onclick="changeVerifyCodeReg2()" align="absmiddle" style="ime-mode:disabled;cursor:pointer" class="valid" data-val="true" data-val-length="必须为4位" data-val-length-max="4" data-val-required="验证码不可为空。">
				<a href="javascript:void(0)" onclick="changeVerifyCodeReg2()">换一换</a>
	            </em>
	        </div>
	        <!-- 暂不开放
	        <div class="login_remember">
	            <div class="fl">
	                <span><input type="checkbox" /></span>
	                <span>自动登录</span>
	            </div>
	            <!--<div class="ri"><a href="#">忘记密码？</a></div>-->
	            <!--<div class="ri"><a href="register">注册&nbsp;&nbsp;</a></div>-->
	        <!--
	        </div>
	        -->
	        <button type="button" id="login_btn" class="login_btn" onclick="login();">登录</button>
	    </div>
	    </form>
	</div>
    <div class="loginBotImg"></div>
</div>


       
<script>
 function checkUserLoginId(id){
    var isOK = true;
    if(id==null || id ==""){
    	alert("请输入用户名"); return false;
    }
    $.ajax({
       url: '<@ofbizUrl>findUserByUserLogin</@ofbizUrl>',
       data: {userLoginId:id},
       type: "POST",
       async:false,
       success: function(data) {
         if(data.isExist ==0){
            isOK = false;
            alert("用户名没有找到");
         }
       }
   });  
   return isOK;
}
 
 
 	$(document).ready(function(){
	        changeVerifyCodeReg2();
	});
 	
 	function changeVerifyCodeReg2(){
        $("#randomCode_img2").attr("src", ('/pcpos/select/getCodeImage?r=' + Math.round(Math.random() * 1000000)));
    }
    
	
    
     function checkRegRandomCode(){
            var isOK = true;
            var randomCode =  $("#randomCode").val();
            if(randomCode == ''){
                isOK = false;
                alert("请输入验证码");
            }
            if(isOK){
                $.ajax({
                    url: '<@ofbizUrl>checkRandomCode</@ofbizUrl>',
                    type: "POST",
                    async : false,
                    data: {
                        randomCode : randomCode
                    },
                    success: function(data) {
                        var isError=data;
                        if(isError != "success"){
                            isOK = false;
                            alert("验证码错误!");
                            changeVerifyCodeReg2();
                        }
                    }
                });
            }
            return isOK;
        }
      function login(){
      var str="";
      var userName=$("#USERNAME").val();
      var pwd = $("#PASSWORD").val();
      if(userName==""||userName==undefined){
        str+="请输入用户名\n";
      }
      if(!checkUserLoginId(userName)){
        return false;
      }
      if(pwd==""||pwd==undefined){
        str+="请输入密码\n";
      }
      if(str!=""){
        alert(str);
        return false;
      }else{
        if(checkRegRandomCode()){
            $("#form1").submit();
        }else{
            return false;
        }
      }
      }  
      
      document.onkeydown = function (e) {
            var code;
            if (!e) {
              e = window.event;
            }
            if (e.keyCode) {
                code = e.keyCode;
            }
            else if (e.which) {
                code = e.which;
            }
            if (code == 13) {
                document.getElementById("login_btn").click();
            }
        }
      
 </script>

<div id="footer">
    <div class="footer">
        <#--
        <div class="footer_list">
            <dl>
                <dt>底部栏目</dt>
                <dd><em></em><a href="#">栏目一</a></dd>
                <dd><em></em><a href="#">栏目一</a></dd>
                <dd><em></em><a href="#">栏目一</a></dd>
                <dd><em></em><a href="#">栏目一</a></dd>
            </dl>
            <dl>
                <dt>底部栏目</dt>
                <dd><em></em><a href="#">栏目一</a></dd>
                <dd><em></em><a href="#">栏目一</a></dd>
                <dd><em></em><a href="#">栏目一</a></dd>
                <dd><em></em><a href="#">栏目一</a></dd>
            </dl>
            <dl>
                <dt>底部栏目</dt>
                <dd><em></em><a href="#">栏目一</a></dd>
                <dd><em></em><a href="#">栏目一</a></dd>
                <dd><em></em><a href="#">栏目一</a></dd>
                <dd><em></em><a href="#">栏目一</a></dd>
            </dl>
            <dl>
                <dt>底部栏目</dt>
                <dd><em></em><a href="#">栏目一</a></dd>
                <dd><em></em><a href="#">栏目一</a></dd>
                <dd><em></em><a href="#">栏目一</a></dd>
                <dd><em></em><a href="#">栏目一</a></dd>
                <dd><em></em><a href="#">栏目一</a></dd>
                <dd><em></em><a href="#">栏目一</a></dd>
            </dl>
        </div>
        -->
       <#-- <div class="bottom"> 2003-2014 Tmall.com 版权所有 增值电信业务经营许可证：浙B2-20110446网络文化经营许可证：浙网文[2012]0234-028号</div>-->
    </div>
</div>
</body>
</html>
