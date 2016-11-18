
<#-- <html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>${title?if_exists}</title>
        <link rel="stylesheet" href="${baseUrl}/images/maincss.css" type="text/css"/>
    </head>
    <body>
        <h1>${title?if_exists}</h1>
        <p>Thank you for registering. Please click the link below to complete your registration.</p>
        <br/><br/>
        <a href="${baseUrl}/cmssite/cms/verifyEmailAddress?verifyHash=${parameters.verifyHash}">www.cmssite.com/cms/registration.html</a>
    </body>
</html>  -->


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>邮件激活</title>
<style type="text/css">
*{padding:0; margin:0; text-decoration:none; list-style:none;}
.mail{}
.mail_bj{width:660px; height:auto; background:url(../portal/images/mail_a.png) no-repeat; margin:0 auto; margin-top:20px; margin-bottom:20px; padding-top:100px; padding-left:38px;}
.mail_content{min-height:380px; border:3px solid #ddd; border-top:none;}
.mail_text{padding:10px 30px; line-height:2; font-size:14px; padding-left:55px;}
.mail_text h2{font-size:16px;}
.mail_text p{padding-top:8px;}
.mail_text .a_list{display:block; width:185px; height:50px; background:#f2804a; border:1px solid #f26522; font-size:20px; color:#fff; font-weight:bold;-moz-border-radius:3px;-webkit-border-radius:3px;border-radius:3px; margin-top:25px; text-align:center; line-height:48px;}
.mail_text .a_lista{margin-top:15px; display:block; font-size:14px;}
.mail_cent{height:60px; border-top:2px solid #ddd; margin-top:20px; background:#eee; padding:0 50px; line-height:58px; font-size:14px;}
</style>
</head>

<body>
<div class="mail">
  <div class="mail_bj">
    <div class="mail_content">
      <div class="mail_text">
        <h2>尊敬的 q1234rew:</h2>
        <p>谢谢您选择了商城。</p>
		<p>为了给您提供最新的平台信息，提供更好的服务，我们需要确认您的邮箱是有效的！<br />
		请您点击以下链接完成邮件激活：</p>
        <a href="${baseUrl}/portal/control/verifyEmailAddress?verifyHash=${parameters.verifyHash}" class="a_list">点击激活账户</a>
        <a href="#" class="a_lista">http://www.maiyitong.com/store/product/32-pcs-Cosmetic-Facial-Make-up-Brush-Kit-Makeup-Brushes-Tools-Set-Black-Leather-Free-Shipping</a>
      </div>
     <!--
      <div class="mail_cent">国际站点:<a href="#">http://www.dhgate.com/</a>　　传真号码:86-10-82025922</div>
    -->
    </div>
  </div>
</div>
</body>
</html>
