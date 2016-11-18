<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>会员注册页面</title>
<link rel="stylesheet" href="/ofcupload/images/style/common.css" />
<link rel="stylesheet" href="/ofcupload/images/style/register.css" />
<link rel="stylesheet" href="/ofcupload/images/style/employee.css" />
</head>

<body>
<div class="bgwhite clearfix">
    <div class="wrap main_top ">
        <div class="logo fl">
           <a href="jingmai.html"><img src="/ofcupload/images/images/common/logo.png" /></a>
        </div>
    </div>
</div>

<div id="register">
	<div class="register_content">
    	<form action="jingmai.html">
    	<div class="register_row">
        	<input class="inp-text kingkong-input name" type="text" value="" name="name"/>
            <i>姓名</i>
        </div>
        <div class="register_row">
        	<input class="inp-text kingkong-input phone" type="text" value="" name="phone"/>
            <i>手机号</i>
        </div>
        <div class="register_row">
        	<input class="inp-text kingkong-input username" type="text" value="" name="username"/>
            <i>用户名或邮箱</i>
        </div>
        <div class="register_row">
        	<input class="inp-text kingkong-input password" type="text" value="" name="password"/>
            <i>密码</i>
        </div>
        <div class="register_row">
        	<input class="inp-text kingkong-input repassword" type="text" value="" name="repassword"/>
            <i>确认密码</i>
        </div>
        <div class="register_row">
            <label class="radio cur">女</label>
            <label class="radio">男</label>
            <input class="sex" type="hidden" />
        </div>
        <div class="register_row">
        	<input class="kingkong-input ecode" type="text" value="" name="ecode"/>
            <i>验证码</i>
            <a href="#">验证码图片</a>
        </div>
        <div class="xieyi">
        	<span><input type="checkbox" /></span>
            <span>我已阅读并同意《<a href="#">越美用户注册协议</a>》</span>
        </div>
        <input type="submit" class="regis_submit" value="立即注册"/>
        <div class="person_photo" style="right:160px;">
            <div class="pic"><img width="110" height="110" src="/ofcupload/images/images/img/avatar.jpg"></div>
            <a class="modify_photo" href="setEmployeeHead">修改头像</a>
        </div>
        </form>
    </div>
</div>


</body>
</html>
<script type="text/javascript" src="/ofcupload/images/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/ofcupload/images/js/public.js"></script>
<script type="text/javascript">
$(function(){
	$(".register_row").kingkongInput();
})
</script>


<!-- end:Modal -->
<script>
	function checkMobile(){
	var regcellmobile = /^[0-9]*$/;
	var mobileReg = /^1[3|5|8][0-9]\d{4,8}$/;
	var mobile=$("#contactNumber").val();
	var utype=0;
	var isOk = false;
	//验证手机格式
	$("#conform_mobile").attr("style","color:#FF0000");
	if(mobile!= "" &&mobile!= undefined){
		if(!regcellmobile.test(mobile)){//如果是纯数字 则是电话号码
			alert("手机号码只能为纯数字!");
			$("#contactNumber").focus();
		}else{
			if(!(mobileReg.test(mobile)) || mobile.length != 11){ //检查是不是电话号码
			alert("手机号码不正确,或者号码没有11位!");			
			$("#contactNumber").focus();
		 	}else{
		 	//验证手机号码是否已使用
		 	utype=1;	
		 	}
		}
	}else{
		alert("请您填写有效的手机号码");
	}
	if(utype==1){
			$.ajax({
				           url: '<@ofbizUrl>findUserByUserLogin</@ofbizUrl>',
				           data: {mobile:mobile},
				           type: "POST",
				           async:false,
				           success: function(data) {
			           			 if(data.isExist ==0){
			           			 	isOk=true;
									
			           			 }else{
			           			 	alert("该手机号码已经被注册,请更换!");
			           			 }
				           }
				       });
	}
	return isOk;
	}
	
	function checkPersonName(){
	var isOk=false;
	var userIdreg =/^[a-zA-Z]\w{4,18}$/;
	var utype=0;
	var userLoginId=$("#userLoginId").val();
	//验证用户名格式
	if(userLoginId!= "" &&userLoginId!= undefined){
		if(!userIdreg.test(userLoginId)){
			alert("用户名格式错误!(只允许字母、数字，首位只能为字母，且长度在5 - 19位。)");	
			$("#userLoginId").focus();
		}else{
		 	utype=1;	
		}
	}else{
		alert("请输入用户名,只允许字母、数字，首位只能为字母，且长度在5 - 19位。");
	}
	if(utype==1){
			$.ajax({
				           url: '<@ofbizUrl>findUserByUserLogin</@ofbizUrl>',
				           data: {userLoginId:userLoginId},
				           type: "POST",
				           async:false,
				           success: function(data) {
			           			 if(data.isExist ==0){
			           			 	isOk=true;
			           			 }else{
			           			 	alert("该用户名已经被注册,请更换!");
			           			 }
				           }
				       });
				}
		return isOk;	
	}
	
	function checkPwd(){
	var isOk=false;
	var currentPassword=$("#currentPassword").val();
	var currentPasswordVerify=$("#currentPasswordVerify").val();
	$("#currentPassword_notice").attr("style","color:#FF0000");
	$("#currentPasswordVerify_notice").attr("style","color:#FF0000");
	
	var currentPasswordreg =/^^.[^*%"]{5,14}$/;
	
	if(currentPassword!=""&currentPassword!=undefined){
		if(!currentPasswordreg.test(currentPassword)){
			alert("密码格式错误!(密码只能为 6 - 15 位数字，字母及常用符号组成。)");
			$("#currentPassword").focus();
		}else{
			if(currentPasswordVerify!=""&currentPasswordVerify!=undefined){
				if(currentPassword!=currentPasswordVerify){
					alert("两次密码不一致");
					$("#currentPasswordVerify").focus();
				}else{
					isOk=true;
				}
			}else{
				alert("请再次输入密码");
			}
		}
	}else{
		alert("请输入密码,密码只能为 6 - 15 位数字，字母及常用符号组成。");
	}
	return isOk;
	//验证第一次密码是否过于简单
	//验证两次密码是否一致.
	}
	function changeVerifyCodeReg2(){
        $("#randomCode_img2").attr("src", ('/pcpos/select/getCodeImage?r=' + Math.round(Math.random() * 1000000)));
    }
	$(function(){
    	changeVerifyCodeReg2();
    });
    
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
	
	
	
		function checkHezi(){
			var isOk=false;
			var str=""; 
			$("input[name='hezi']:checkbox").each(function(){ 
                if($(this).attr("checked")){
                    str += $(this).val();
                }
            }) 
           
			if(str!=""&str!=undefined){
			}else{
				alert("请勾选同意越美用户注册协议.");
			} 
			if(str=="Y"){
				isOk=true;
			}
			return isOk;   
	     }
	function register(){
	    if(!checkMobile()){
	        return false;
	    }
	    
	    if(!checkPersonName()){
	        return false;
	    }
	    
	    if(!checkPwd()){
	        return false;
	    }
	    
	    if(!checkRegRandomCode()){
	        return false;
	    }
	    
	    if(!checkHezi()){
	        return false;
	    }
	   	$("#MyForm").submit();
	       // registerInfo();
	    } 
</script>	