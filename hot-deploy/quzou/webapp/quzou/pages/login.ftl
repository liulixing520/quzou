<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>登录</title>
    <link rel="stylesheet" href="../images/style/common.css" />
    <link rel="stylesheet" href="../images/style/login.css" />
    <script type="text/javascript" src="../images/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="../images/js/public.js"></script>
	<script type="text/javascript">
	    $(".login_row").kingkongInput();
	</script>
</head>

<body style="">
<!--<img src="../images/images/common/newYear.gif" style="width:1660px;position:absolute;left:50%;margin-left:-830px;height:100%;max-height:1000px;min-height:1000px;z-index:-1;">-->
<div id="login">
	<div class="logoHead">
		<span class="logo">
			<img src="../images/images/common/logo.png" />
		</span>
		<span class="welcome">欢迎登录</span>
	</div>
	<#if !errorMessageList?has_content>
    <#assign errorMessageList = requestAttributes._ERROR_MESSAGE_LIST_?if_exists>
    </#if>
    <#if (errorMessage?has_content || errorMessageList?has_content)>
        <#if errorMessageList?has_content>
          <#list errorMessageList as errorMsg>
          <#--${errorMsg}-->
            <div class="control-label" style="margin-top:10px;">
	            <span style="color:#FF0000;display:none;text-align:center;" id="tishi1">系统异常，请稍后再试或与系统管理人员联系！</span>
	            <span style="color:#FF0000;display:none;text-align:center;" id="tishi2">${errorMsg}</span>
            </div>
            <script>
                $(document).ready(function(){
                	<#--var zwzifuc=/^[\u2E80-\uFE4F]+$/;-->
                	var zwzifuc = /[\u4E00-\u9FA5\uF900-\uFA2D]/;
                	var tishinr=$("#tishi2").html();
                	if(!zwzifuc.test(tishinr)) {
						$("#tishi1").css("display","block");
					}else{
						$("#tishi2").css("display","block");
					}
                    $("#PASSWORD").focus();
                });
            </script>
          </#list>
        </#if>
    </#if>
	<div class="logoMain clearfix">
		<form action="checkLogin" name="form1" id="form1" method="post">		            
	    <div class="login">
	    	<#--<div class="login_top">用户名</div>-->
	        <div class="login_row">
	            <label class="user"></label>
	            <input type="text" name="USERNAME" id="USERNAME" value="" placeholder="请输入登陆用户名"/>
	            <#--<i>请输入用户名</i>-->
	        </div>
	        <#--<div class="login_top">密码</div>-->
	        <div class="login_row">
	            <label class="psw"></label>
	            <input type="password" name="PASSWORD" id="PASSWORD" placeholder="请输入密码"/>
	            <#--<i>请输入密码</i>-->
	        </div>
	        <#--<div class="login_top">验证码</div>
	        <div class="login_row2 code">
	         
	            <input type="text" name="randomCode" id="randomCode" />
	            <em>
	            <img id="randomCode_img2" width="100px;" alt="点击刷新" onclick="changeVerifyCodeReg2()" align="absmiddle" style="ime-mode:disabled;cursor:pointer" class="valid" data-val="true" data-val-length="必须为4位" data-val-length-max="4" data-val-required="验证码不可为空。">
				<a href="javascript:void(0)" onclick="changeVerifyCodeReg2()">换一换</a>
	            </em>
	        </div>-->
	       
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
</div>
<script>
 
      function login(){
          var str="";
          var userName=$("#USERNAME").val();
          var pwd = $("#PASSWORD").val();
          if(userName==""||userName==undefined){
            str+="请输入用户名\n";
          }
          /*if(!checkUserLoginId(userName)){
            return false;
          }*/
          if(pwd==""||pwd==undefined){
            str+="请输入密码\n";
          }
          if(str!=""){
            alert(str);
            return false;
          }else{
            $("#form1").submit();
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
</body>
</html>
