<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<META name="在线支付、网上支付、支付平台、网上支付平台、在线支付平台、电子支付、首信支付平台，提供商户入住、在线支付服务、电子商务解决方案，政府背景、安全认证的电子商务支付平台，便民缴费与代收费系统提供商,广泛用于BtoC、BtoB、CtoC、GtoC等领域,支持网上支付,短信支付,会员帐户支付" />
<title>首信易支付平台，欢迎使用</title>
<link href="../images/pay/beijing.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../images/pay/customer_ui.js"></script>
<script language="JavaScript">
  function OnSelectBank(BankHelpUrl){
	  window.open(BankHelpUrl);
  }
</script>
</head>
<body>

<script language="JavaScript" src="/customer/gb/include/public.js"></script>
<script language="javascript">
    var http_request = false;
    function send_request(url) {//初始化、指定处理函数、发送请求的函数
        http_request = false;
        //开始初始化XMLHttpRequest对象
        if(window.XMLHttpRequest) { //Mozilla 浏览器
            http_request = new XMLHttpRequest();
            if (http_request.overrideMimeType) {//设置MiME类别
                http_request.overrideMimeType("text/xml");
            }
        }else if (window.ActiveXObject) { // IE浏览器
            try {
                http_request = new ActiveXObject("Msxml2.XMLHTTP");
            } catch (e) {
                try {
                    http_request = new ActiveXObject("Microsoft.XMLHTTP");
                } catch (e) {}
            }
        }
        if (!http_request) { // 异常，创建对象实例失败
            window.alert("不能创建XMLHttpRequest对象实例.");
            return false;
        }
        http_request.onreadystatechange = processRequest;
        // 确定发送请求的方式和URL以及是否同步执行下段代码
        http_request.open("GET", url, true);
        http_request.send(null);
    }


    // 处理返回信息的函数
        function processRequest() {
            var retStr;
            var flag = false;
            if (http_request.readyState == 4) { // 判断对象状态
                if (http_request.status == 200) { // 信息已经成功返回，开始处理信息
                    retStr=http_request.responseText;
                    if(getElement(retStr,"Status")=="0"){
                        fontid.innerHTML=getElement(retStr,"StatusDesc");
                        flag = true;
                    }else if(getElement(retStr,"Status")=="20050"){
                        //订单中已经有会员信息
                        flag = true;
                    }else{
                        fontid.innerHTML = "";
                        alert(getElement(retStr,"StatusDesc"));
                        flag = false;
                        MemberForm.submit1.disabled=false;
                    }
                }else{
                    //页面不正常
                    fontid.innerHTML = "";
                    //alert("您所请求的页面有异常。");
                    MemberForm.submit1.disabled=false;
                    return false;
                }
            }
            if(flag){
                //如果会员信息保存结束后,提交表单
                document.bankform.submit();
            }
        }

        //返回xml中的element
        function getElement(xmlStr,elementStr){
            var p1 = xmlStr.toLowerCase().indexOf("<" + elementStr.toLowerCase() + ">");
            var p2 = xmlStr.toLowerCase().indexOf("</"+ elementStr.toLowerCase() + ">");
        if(p1==-1 || p2 == -1){
                return "";
            }else{
                return xmlStr.substring(p1+elementStr.length+2,p2);
            }
        }


    function MemberFormSubmit(){
            var url;
            var order_cd=MemberForm.order_cd.value;
            var mer_id=MemberForm.mer_id.value;
            var order_money=MemberForm.order_money.value;
            var currency_id=MemberForm.currency_id.value;
            var order_cd_mac=MemberForm.order_cd_mac.value;

            var user_name=MemberForm.user_name.value;
            var force_member_yn = MemberForm.force_member_yn.value;

            var x1=document.getElementById("radio_1");
            var x2=document.getElementById("radio_2");

            if(x1!=null && x1.checked){
                var email=MemberForm.email.value;
                if(email=="" || email=="请输入邮箱"){
                    //判断是否强制输入会员信息
                    if(force_member_yn=="Y"){
                        alert("非会员：请输入您的有效邮箱\n会　员：请输入“首信易支付”会员名\n本次支付如有任何问题，我们将通过您留下的联系方式进行通知。");
                        return;
                    }
                    document.bankform.submit();
                    return;
                }
                var pattern = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+$/;
                if(pattern.test(email)==false){
                    alert("请输入正确的邮件地址.");
                    return;
                }
                url="http://pay.beijing.com.cn/customer/gb/saveOrderEmail.jsp";
            }else if(x2!=null && x2.checked){
                if(user_name=="" || user_name=="请输入“首信易支付”用户名"){
                    //判断是否强制输入会员信息
                    if(force_member_yn=="Y"){
                        alert("非会员：请输入您的有效邮箱\n会　员：请输入“首信易支付”会员名\n本次支付如有任何问题，我们将通过您留下的联系方式进行通知。");
                        return;
                    }
                    document.bankform.submit();
                    return;
                }
                url="http://pay.beijing.com.cn/customer/gb/saveOrderUser.jsp";
            }else{
                document.bankform.submit();
                return;
            }

            url+="?order_cd=" + order_cd ;
            url+="&mer_id=" + mer_id ;
            url+="&order_money="+order_money ;
            url+="&currency_id="+currency_id ;
            url+="&order_cd_mac="+order_cd_mac;
            url+="&email="+email;
            url+="&user_name="+user_name;

            MemberForm.submit1.disabled=true;
            fontid.innerHTML = "正在发送...";

            send_request(url);
    }


        function OnUserInputClick(txt,arg2){
            if(txt.value==arg2){
                txt.value="";
            }else if(txt.value==""){
                txt.value=arg2;
            }
        }

</script>


<script language="JavaScript">
  function OnSelectBank(BankHelpUrl){
    window.open(BankHelpUrl);
  }

  //选择支付银行
  function selectbank(bank_id,direct_pmode_id,direct_card_id) {
    //alert("bank_id:" +  bank_id + "\r\n" + "direct_pmode_id:" +  direct_card_id + "\r\n"+ "direct_card_id:" +  direct_card_id + "\r\n");
    //alert("/customer/gb/payNotes.jsp?bankId=" + bank_id);
    var payNotes = getElement(httpRequest("GET",null,"/customer/gb/payNotes.jsp?bankId=" + bank_id),"PayNotes");

    if(payNotes=="null"){
        payNotes = "";
    }

    payNotes = replaceAll(payNotes,"\r\n","<BR>");
    payNotes = replaceAll(payNotes," ","&nbsp;");

    document.selectform.bank_id.value=bank_id;
    document.bankform.bank_id.value=bank_id;
    document.bankform.direct_pmode_id.value=direct_pmode_id;
    document.bankform.direct_card_id.value=direct_card_id;

    document.getElementById("divMessage").innerHTML = payNotes;


    if(bank_id==1||bank_id==196){
        document.bankform.action="/customer/gb/select_paycard.jsp";
        document.bankform.submit();
    }
    if(bank_id==108){
        document.bankform.action="/customer/gb/select_brand.jsp";
        document.bankform.submit();
    }
  }
  function selectpmode(cardid,pmodeid) {
    document.payform.card_id.value=cardid;
    document.payform.pmode_id.value=pmodeid;
    document.payform.submit();
  }

  //用户提交
  function OnSubmitClick(){
    fontid.innerHTML = "";

    if(document.bankform.bank_id.value==""){
        alert("请选择支付银行！");
        return false;
    }

    //if(document.bankform.need_member.value=="true"){
        //MemberFormSubmit();
    //}else{
        document.bankform.submit();
    //}
  }


   function onDivHidd(){
          document.getElementById("cardf").style.display="";
          document.getElementById("jfdl").style.display="none";
   }
   
   function onDivShow(){
          document.getElementById("cardf").style.display="none";
          document.getElementById("jfdl").style.display="";
   }
</script>

<script>
    function OnVisaLogoClick(){
        payform.pmode_id.value="38";
        payform.card_id.value="113";
        payform.submit();
    }
</script>



<div align="center">


  <script language="JavaScript" src="../images/pay/popadvert.js"></script>
  
  <table width="774" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="150" align="center"><A HREF="#" target="_blank"><img src="../images/pay/logo.gif" border=0/></A></td>
      <td width="30" align="right" valign="bottom"><img src="../images/pay/top_pay_a.gif" /></td>
      <td width="240" align="center" valign="bottom" background="../images/pay/top_pay_c.gif" style="background-repeat:repeat-x; background-position:bottom;"><img src="../images/pay/top_pay_b.gif" /></td>
      <td valign="top" background="../images/pay/top_pay_c.gif" style="background-repeat:repeat-x; background-position:bottom;"><table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td align="right">
            <span class="txt_ga">
                <A HREF="#" target="_blank">首信易支付首页</A> | 
                <A HREF="#" target="_blank">客服</A> | 
                <A HREF="#" target="_blank">帮助</A>
            </span>
          </td>
        </tr>
      </table></td>
      <td width="6" align="right" valign="bottom"><img src="../images/pay/top_pay_d.gif" /></td>
    </tr>
  </table>



<table width="774" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
    <tr>
      <td><table width="100%" height="100%" border="1" cellpadding="0" cellspacing="3" bordercolor="#b9b9b9" bgcolor="#e9e9e9">
        <tr>
          <td width="335" bordercolor="#e9e9e9"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="4"><img src="../images/pay/mid_tit_a.gif" /></td>
                  <td width="200" background="../images/pay/mid_tit_b.gif">&nbsp;&nbsp;<strong>订单信息</strong></td>
                  <td align="left"><img src="../images/pay/mid_tit_c.gif" /></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              	
                <tr>
                  <td width="86" height="20" class="txt_14">商　户：</td>
                  <td width="237" class="txt_14_r"><strong>商城</strong></td>
                </tr>
                
                <tr>
                  <td width="86" height="20" class="txt_14">商户订单号：</td>
                  <td width="237" class="txt_14_r"><strong>20141124-7733-1416797580854100045</strong></td>
                </tr>
<!--
                <tr>
                  <td height="20" class="txt_14">商户名：</td>
                  <td class="txt_14_r">北京数字</td>
                </tr>
-->
                <tr>
                  <td height="20" class="txt_14">金　额：</td>
                  <td class="txt_14_r">${request.getParameter("amount")?if_exists}</td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td height="5"></td>
            </tr>
          </table></td>
          <td width="1" bordercolor="#e9e9e9" bgcolor="#cecece"></td>
          <td width="216" align="center" bordercolor="#e9e9e9" background="/images/customer/gb/img/bk_01.gif"><table width="216" height="100%" border="0" cellpadding="0" cellspacing="0">
          	
            <tr>
              <td>&middot;<FONT COLOR='red'>游学新西兰，假期体验《指环王》神秘“中土世界”</FONT><br /><br />&middot;<FONT COLOR='blue'>使用易支付帐户支付除享受商家给予的优惠外，还可以享受到额外折扣，让您的购物折上加折。</FONT><br /></td>
            </tr>
            <tr>
            <td>&middot;<FONT COLOR='red'>工商银行推出“手机短信认证”和“登录短信提醒”两项安全服务工具，了解详情请点击进入。</fond></td>
            </tr>

            <tr>
              <td align="center"><A HREF="#" target="_blank"><img src="../images/pay/but_hythq.gif" width="115" height="36" border="0"/></A></td>
            </tr>
          </table></td>
        </tr>
      </table></td>
      <td width="1"></td>
      <td width="205" height="1"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="1" valign="top" bgcolor="#cbcbcb"><img src="/images/customer/gb/img/line_w_01.gif" width="1" height="11" /></td>
          <td height="18"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="/images/customer/gb/img/line_g_01.gif" style="background-repeat:repeat-x; background-position:0px 11px;">
              <tr>
                <td width="6">&nbsp;</td>
                <td width="27"><img src="../images/pay/sub_a.gif" /></td>
                <td valign="top" background="../images/pay/sub_b.gif" class="txt_w" style="background-position:0px 0px; line-height:22px;">会员优惠</td>
                <td width="28"><img src="../images/pay/sub_c.gif" /></td>
                <td>&nbsp;</td>
              </tr>
          </table></td>
          <td width="1" valign="top" bgcolor="#cbcbcb"><img src="/images/customer/gb/img/line_w_01.gif" width="1" height="11" /></td>
        </tr>
        <tr>
          <td bgcolor="#cbcbcb"></td>
          <td align="center"><table width="90%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
              <tr>
                <td>
<div id=demo style="overflow:hidden;height:60px; line-height:15px">

  <div id=demo1>
&middot;“梦幻潘多拉”环球城国际大马戏抢票中<br>
&middot;用中行网银，做双赢考生<br>
<br>
</div>


  <div id=demo2></div>
</div>

<script>
	var speed=200;
	demo2.innerHTML=demo1.innerHTML
	function Marquee(){
		if(demo2.offsetTop-demo.scrollTop<=0)
			demo.scrollTop-=demo1.offsetHeight;
		else
			demo.scrollTop++;
	}
/*
	var MyMar=setInterval(Marquee,speed)

	demo.onmouseover=function() {
		clearInterval(MyMar)
	}

	demo.onmouseout=function() {
		MyMar=setInterval(Marquee,speed)
	}
*/
</script>

				</td>
              </tr>



            </table>
              <table width="90%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="30" align="center"><span class="txt_r"><A HREF="#" target="_blank">需要帮助？</A></span><A HREF="#" target="_blank"><img src="../images/pay/but_xssl.gif" align="absmiddle" border="0" /></A></td>
                </tr>
            </table></td>
          <td bgcolor="#cbcbcb"></td>
        </tr>
        <tr>
          <td height="1" bgcolor="#cbcbcb"></td>
          <td bgcolor="#cbcbcb"></td>
          <td bgcolor="#cbcbcb"></td>
        </tr>
      </table></td>
    </tr>
  </table>





 



  <table width="774" border="0" cellspacing="0" cellpadding="0" style="margin-top:5px;">
    <tr>
      <td valign="top"><table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#6d6d6d">
        <tr>
          <td bordercolor="#e9e9e9" bgcolor="#e9e9e9"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="150" height="21" background="../images/pay/tit_a.gif">&nbsp;&nbsp;<strong>请选择支付方式</strong></td>
              <td width="21"><img src="../images/pay/tit_b.gif" /></td>
              <td>&nbsp;　　&nbsp;

                <input type="radio" name="radiobutton" value="bank" onclick="onDivHidd()" checked />
                    <span class="txt_ga">银行卡支付</span>
               
                &nbsp;&nbsp;&nbsp;
                <input type="radio" name="radiobutton" value="member" onclick="onDivShow()" />
	                <span class="txt_ga">易支付帐户支付/积分支付</span>
                

              </td>
            </tr>
          </table></td>
        </tr>
      </table>
    </td>
  </tr>
 </table> 

<!-- 银行卡支付  -->
<div id ="cardf">
 <table width="774" border="0" cellspacing="0" cellpadding="0" style="margin-top:5px;">
 <input type="hidden" name="need_member" value="true" />
  <tr>
    <td height="150" valign="top">
        <form name="selectform" action="/customer/gb/select_bank.jsp" method="POST">
            <input type="hidden" name="MD5HMAC" value="7cea2eec701fba888f390c406c769d22">
            <input type="hidden" name="order_cd" value="20141124-7733-1416797580854100045">
            <input type="hidden" name="mer_id" value="7733">
            <input type="hidden" name="curr_type" value="156">
            <input type="hidden" name="mer_name" value="www.kingdy.com">
            <input type="hidden" name="order_money" value="100.00">
            <input type="hidden" name="disc_desc" value="">
            <input type="hidden" name="need_inner" value="true">
            <input type="hidden" name="need_oversea" value="false">
            <input type="hidden" name="reply_realtime" value="true">
            <input type="hidden" name="need_member" value="true">
            <input type="hidden" name="need_phone" value="false">
            <input type=hidden name=bank_id value="">
        </form>
        <form method=post name=bankform action="/customer/gb/select_brand.jsp">
            <input type=hidden name=direct_pmode_id value="">
            <input type=hidden name=direct_card_id value="">
            <input type=hidden name=need_inner value="true">
            <input type=hidden name=need_oversea value="false">
            <input type=hidden name=reply_realtime value="true">
            <input type=hidden name=need_show value="true">
            <input type=hidden name=order_cd value="20141124-7733-1416797580854100045">
            <input type=hidden name=mer_id value="7733">
            <input type=hidden name=curr_type value="156">
            <input type=hidden name=MD5HMAC value="7cea2eec701fba888f390c406c769d22">

            <input type=hidden name=mer_name value="www.kingdy.com">
            <input type=hidden name=order_money value="100.00">
            <input type=hidden name=disc_desc value="">
            <input type=hidden name=need_member value="true">
            <input type=hidden name=need_phone value="false">
            <input type=hidden name=bank_id value="">
        </form>
        <form method=post name=payform action="/customer/gb/pay_route.jsp" >
          <input type=hidden name=card_id value="">
          <input type=hidden name=pmode_id value="">
          <input type=hidden name=uid value="">          
          <input type=hidden name=order_cd value="20141124-7733-1416797580854100045">
          <input type=hidden name=mer_id value="7733">
          <input type=hidden name=curr_type value="156">
          <input type=hidden name=need_show value="true">
          <input type=hidden name=MD5HMAC value="7cea2eec701fba888f390c406c769d22">
          
          <input type=hidden name=mer_name value="www.kingdy.com">
          <input type=hidden name=order_money value="100.00">        
          <input type=hidden name=disc_desc value="">             
          <input type="hidden" name="need_phone" value="false">          
        </form>        



        <table width="99%" border="0" cellspacing="0" cellpadding="5">
          <tr>
            <td width="50%" align="center" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="1">

              <tr bgcolor="#f2f2f2">
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(2,85,234)"/></td>
                <td><div >中国银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr >
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(12,28,94)"/></td>
                <td><div >民生银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr bgcolor="#f2f2f2">
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(165,50,166)"/></td>
                <td><div >北京银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr >
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(9,60,188)"/></td>
                <td><div >华夏银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr bgcolor="#f2f2f2">
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(8,67,214)"/></td>
                <td><div >交通银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr >
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(16,33,100)"/></td>
                <td><div >兴业银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr bgcolor="#f2f2f2">
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(6,69,213)"/></td>
                <td><div >浦发银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr >
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(11,40,116)"/></td>
                <td><div >深圳发展银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr bgcolor="#f2f2f2">
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(130,121,257)"/></td>
                <td><div >上海银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr >
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(217,74,219)"/></td>
                <td><div >光大银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr bgcolor="#f2f2f2">
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(230,83,231)"/></td>
                <td><div >渤海银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr >
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(271,157,272)"/></td>
                <td><div >中国农业银行信用卡</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

            </table></td>
            <td align="center" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="1">

              <tr bgcolor="#f2f2f2">
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(3,9,29)"/></td>
                <td><div >中国工商银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr >
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(7,43,151)"/></td>
                <td><div >中国农业银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr bgcolor="#f2f2f2">
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(5,4,152)"/></td>
                <td><div >中国建设银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr >
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(4,3,37)"/></td>
                <td><div >招商银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr bgcolor="#f2f2f2">
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(15,59,186)"/></td>
                <td><div >中国邮政储蓄银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr >
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(17,84,232)"/></td>
                <td><div >中信银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr bgcolor="#f2f2f2">
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(14,44,119)"/></td>
                <td><div >广发银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr >
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(187,14,66)"/></td>
                <td><div >平安银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr bgcolor="#f2f2f2">
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(92,16,93)"/></td>
                <td><div >农村商业银行（广州，珠海，上海，顺德）</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr >
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(218,75,220)"/></td>
                <td><div >北京农商银行</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

              <tr bgcolor="#f2f2f2">
                <td width="40" align="center"><input type="radio" name="selectbank"  value="radiobutton" onclick="javascript:selectbank(252,126,253)"/></td>
                <td><div >银联在线支付</div></td>
                <td width="50"><a href="#" target="_blank"><font siae="10" color="red">帮助</font></a></td>
              </tr>

            </table></td>
          </tr>
        </table>

        </td>
    </tr>


    <tr>
        <td>
          <table width="99%" border="0" cellpadding="0" cellspacing="0" bgcolor="#f2f2f2">
            <form method=post name="MemberForm">
                <input type=hidden name=order_cd value="20141124-7733-1416797580854100045">
                <input type=hidden name=mer_id value="7733">
                <input type=hidden name=order_money value="100.00">
                <input type=hidden name=currency_id value="156">
                <input type=hidden name=order_cd_mac value="5727ecbbb3fe424bb86a60e0afee8f11">
                <input type=hidden name=force_member_yn value="N">

            <tr bgcolor="#b5b5b5">
              <td height="1" colspan="2"></td>
            </tr>

            <tr>
               <td align="center" valign="middle" height="30"  colspan="2">
                    <DIV id=divMessage align="left" Color="red" style="margin-top:10px;margin-bottom:10px;margin-left:20px;"></DIV>
               </td>
            </tr>
            <tr>
               <td align="center" valign="middle" height="30"  colspan="2">
               <a href="<@ofbizUrl>paymentSuccess</@ofbizUrl>" style=" width:120px; font-size:14px; font-weight:bold; color:#000000; background-color:#FFBB32; outline-style:hidden; border:hidden; text-align:center; padding-top:3px;">提  交</a>
                 <#--<input name="submit1" type="button" value="提  交" onclick="" style=" width:120px; font-size:14px; font-weight:bold; color:#000000; background-color:#FFBB32; outline-style:hidden; border:hidden; text-align:center; padding-top:3px;"/>-->
                 &nbsp;&nbsp;<font id="fontid"></font>
               </td>
            </tr>

            <tr bgcolor="#b5b5b5" >
              <td height="1" colspan="2"></td>
            </tr>
            </from>
          </table>

    </tr>

  </table>
</div>


<!-- 易支付帐户支付/积分支付 -->
<div id="jfdl" style="display:none">
    <table width="774" border="1" cellpadding="0" cellspacing="15" bordercolor="#FFD263">
    <tr>
      <td align="center" bordercolor="#FFFFFF">
        <table width="400" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td colspan=2 align="center"><b>会员登录</b></td>
          </tr>



<table border="0" width="300" cellspacing="0" cellpadding="0" align="center">
      <tr>
        <td width="50%" valign="middle" align="right" height="28" style="padding-right: 4px">
          <font style="font-size: 9pt">会员帐户名：</font>
        </td>
        <td align="left">
          <input type="text" maxLength="60" name="uname" size="20">
        </td>
      </tr>
      <tr>
        <td valign="middle" align="right" height="28" style="padding-right: 4px">
          <span style="font-size: 9pt">登录密码：</span>
        </td>
        <td align="left">
          <input type="password" maxLength="40" name="upass" size="20">
        </td>
      </tr>

      <tr>
        <td valign="middle" align="right" height="28" style="padding-right: 4px" colspan="2">
          <strong><span style="font-size: 9pt">傲游用户请使用傲游-易支付帐户直接登陆</span></strong>
        </td>
      </tr>
      <tr>
        <td width="100%" valign="bottom" align="center" height="36" colspan="2">
          <input type="button" value="登 录" onclick="">&nbsp
        </td>
      </tr>
</table>


</form>

</td>
</tr>

      <tr>
        <td width="100%" valign="bottom" align="center" height="36" colspan="2">
<FONT COLOR="#FF0000">提示信息：我们的支付结果显示页为弹出窗口形式，如果您的浏览器设置了“禁止弹出窗口”功能，请关闭它以允许我们的弹出窗，否则无法正常显示您的支付结果页面。谢谢！</FONT>
        </td>
      </tr>


</table>
</div>



<br />

  
  <table width="774" border="0" cellspacing="0" cellpadding="0" style="margin-top:5px;">
    <tr>
      <td align="center" bgcolor="#b00731" class="txt_w">联系电话：(010)82652626-6576/6829/6613（9：00-17：30）,&nbsp;010-59321108（7×24
小时服务）&nbsp;&nbsp;&nbsp;<br>
      <A HREF="#" target="_blank">在线客服</A>&nbsp;&nbsp;&nbsp;&nbsp;邮箱：<A href="#">cs@payeasenet.com</A></td>
    </tr>
    <tr>
      <td height="30" align="center">&copy;1999-2014 首信易支付 [京ICP证080026号]</td>
    </tr>
  </table>


</div>

</body>
</html>