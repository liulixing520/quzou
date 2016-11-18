<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0067)http://seller.dhgate.com/merchant/changepwd.do?dhpath=10008,31,3101
-->
<html xmlns="http://www.w3.org/1999/xhtml">
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- <link href="css/seller.css" rel="stylesheet" type="text/css">
        <link href="css/common20111215.css" rel="stylesheet" type="text/css">
        <link href="css/general_popup_box.css" rel="stylesheet" type="text/css">
        -->
        <script type="text/javascript" async="" src="../seller/js/dc.js">
        </script>
        <script type="text/javascript" src="js/common.js">
        </script>
        <script type="text/javascript" src="../seller/js/menu-common_20111226.js">
        </script>
        <script type="text/javascript" src="../seller/js/jquery.simplemodal2.js">
        </script>
        <title>
            修改密码
        </title>
        <meta charset="utf-8">
        <link href="../seller/css/seller(1).css" rel="stylesheet" type="text/css">
        <link href="../seller/css/common20111215(1).css" rel="stylesheet" type="text/css">
        <link href="../seller/css/setauthentication.css" rel="stylesheet" type="text/css">
        <link href="../seller/css/general_popup_box(1).css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="../seller/js/poplayer.js">
        </script>
        <script type="text/javascript">
            $(document).ready(function() {
                var valPopVid = new Pop({
                    oPop: "valPopVidBox",
                    zIndex: 1001,
                    mode: ["center", "center"],
                    idOpen: "valPopVidBtn",
                    idClose: ["close_popvalVid01", "close_popvalVid02"],
                    cover: true,
                    beCover: false,
                    zIndexCover: 1000,
                    colorCover: "#d8d8d8",
                    opactiyCover: 0.4
                });
            });
        </script>
    </head>
    
    <body>
        <!-- Google Analytics Tracking Code - 20111216 - START -->
        <script type="text/javascript">
            var _gaq = _gaq || [];
            _gaq.push(['_setAccount', 'UA-425001-1'], ['_setDomainName', '.dhgate.com'], ['_trackPageview', location.pathname + location.search + escape(location.hash)]); (function() {
                var ga = document.createElement('script');
                ga.type = 'text/javascript';
                ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://': 'http://') + 'stats.g.doubleclick.net/dc.js';
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(ga, s);
            })();
        </script>
        <!-- Google Analytics Tracking Code - 20111216 - END -->
        <script type="text/javascript">
            function know() {
                $("#iKnow").click(function() {

                    $("#mapRemind").hide();
                })
            }
            var sellerAuth = {};
            sellerAuth = {
                alert: function(title, msg, isClose) {
                    $("#auth_alert_content").html(msg);

                    if (title == '') {
                        title = '提示信息';
                    }
                    $("#auth_alert_title").html(title);

                    $("#auth_alert_btn1").hide();
                    $("#auth_alert_btn2").hide();

                    if (isClose) {
                        $("#auth_alert_btn1").show();
                        $("#auth_alert_btn2").show();

                    }
                    $("#auth_alert").modal({
                        close: false
                    });
                },
                checkAuth: function(funcid, catePubId) {
                    var result = true;
                    var url = "http://seller.dhgate.com/mydhgate/sellerauth.do?act=ajaxCheckFuncAuth";
                    jQuery.ajax({
                        url: url,
                        data: {
                            "funcid": funcid,
                            "catePubId": catePubId,
                            "isblank": true
                        },
                        dataType: 'json',
                        async: false,
                        //timeout: 3000,
                        type: 'POST',
                        success: function(data) {
                            if (data.result == '1') {
                                var msg = data.authLimitFuncDto.limitMsg;
                                msg = "您的账户已被“" + msg + "”无法进行此操作";
                                sellerAuth.alert('', msg, true);
                                result = false;
                            }

                        },
                        error: function(xhr, status, error) {}
                    });

                    return result;
                },
                getCurrentModelid: function() {
                    var result = "";
                    result = $("#currentPath").val();
                    if (result) {
                        if (result.indexOf(",") > 0) {
                            var models = result.split(",");
                            result = models[models.length - 1]
                        }
                    }
                    return result;
                }

            }

            //初始化数量信息（站内信，客服留言）
            $(document).ready(function() {
                //产品管理黄金展位菜单提示
                $(document).ready(function(e) {
                    var text = $("#Menu_10004 .nav-directory a:last").text();
                    if (text == "类目黄金展位产品") {
                        $("#Menu_10004 .nav-directory a:last").attr("title", "增值卖家专属的类目黄金展位产品")
                    }
                });

                jQuery.ajax({
                    url: "http://seller.dhgate.com/usr/signin.do?act=ajaxmessage&beforeday=150",
                    data: {
                        "isblank": true
                    },
                    dataType: 'json',
                    async: true,
                    timeout: 10000,
                    type: 'POST',
                    success: function(result) {
                        try {
                            //客服留言-未读
                            if (result.unreadcsmsg > 0) {
                                $("#customServiceMessage").text(result.unreadcsmsg).show(); //页头
                                $("#dhunreadCsMsg1").text(result.unreadcsmsg); //摘要首页 v1 & v2
                                $("#dhunreadCsMsg2").text('(' + result.unreadcsmsg + ')').show(); //横向一级菜单
                                $("#dhunreadCsMsg3").text('(' + result.unreadcsmsg + ')').show(); //左侧二级菜单
                            }
                            //所有站内信-未读
                            if (result.unReadOfAll > 0) {
                                $("#newsletter").text(result.unReadOfAll).show(); //页头
                                $("#dhunreadall1").text(result.unReadOfAll); //摘要首页 v1 & v2
                                $("#dhunreadall1").addClass("a1");
                                $("#dhunreadall2").text('(' + result.unReadOfAll + ')').show(); //横向一级菜单
                                $("#dhunreadall3").text('(' + result.unReadOfAll + ')').show(); //左侧二级菜单
                            }
                            //买家消息-未读
                            if (result.unReadOfSellerBuyer > 0) {
                                $("#dhunReadProduct1").text('(' + result.unReadOfSellerBuyer + ')').show(); //左侧二级菜单
                            }
                            //系统消息-未读
                            if (result.unReadOfSystem > 0) {
                                $("#dhunReadOrder1").text('(' + result.unReadOfSystem + ')').show(); //左侧二级菜单
                            }
                            //平台公告-未读
                            if (result.unReadOfDhgate > 0) {
                                $("#dhunReadPayment1").text('(' + result.unReadOfDhgate + ')').show(); //左侧二级菜单
                            }
                            //垃圾箱-未读
                            if (result.unReadOfDustbin > 0) {
                                $("#dhunReadDustbin1").text('(' + result.unReadOfDustbin + ')').show(); //左侧二级菜单
                            }
                            /*
				var phpmail = result.phpmail;
    	     	var unreadmsg = result.unreadcsmsg;
    			var noReadOrder = result.noReadOrder;
    			var noReadProduct = result.noReadProduct;
    			var noReadSystem = result.noReadSystem;
    			var noReadDustbin = result.noReadDustbin;
    			var noReadPayment = result.noReadPayment;
    			var noReadAll = result.noReadAll;
    			if($("#customServiceMessage").length > 0){
    				$("#customServiceMessage").html(unreadmsg);
    			}
    			if($("#dhunreadCsMsg2").length > 0){
    				$("#dhunreadCsMsg2").html(unreadmsg);
    			}
    			if($("#dhunReadProduct1").length > 0){
    				$("#dhunReadProduct1").html(noReadProduct);
    			}
    			if($("#dhunReadOrder1").length > 0){
    				$("#dhunReadOrder1").html(noReadOrder);
    			}
    			if($("#dhunReadPayment1").length > 0){
    				$("#dhunReadPayment1").html(noReadPayment);
    			}
    			if($("#dhunReadDustbin1").length > 0){
    				$("#dhunReadDustbin1").html(noReadDustbin);
    			}
				*/
                        } catch(err) {}
                    },
                    error: function(xhr, status, error) {}
                });
            });
        </script>
        <table id="auth_alert" class="noshade-pop-table" style="width:420px;display:none;">
            <tbody>
                <tr>
                    <td class="t-lt">
                    </td>
                    <td class="t-mid">
                    </td>
                    <td class="t-ri">
                    </td>
                </tr>
                <tr>
                    <td class="m-lt">
                    </td>
                    <td class="m-mid">
                        <div class="mid-warp">
                            <div class="noshade-pop-content">
                                <div class="noshade-pop-title">
                                    <span id="auth_alert_title">
                                        提示信息
                                    </span>
                                </div>
                                <div class="noshade-pop-inner">
                                    <div class="box1">
                                        <p id="auth_alert_content" class="p1">
                                        </p>
                                        <div class="align-center pop-button" id="auth_alert_btn1" style="display:none;">
                                            <a href="javascript:void(0)" class="greybutton1 margin-r20" onclick="jQuery.modal.close();">
                                                <span>
                                                    确定
                                                </span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="noshade-pop-bot">
                                </div>
                            </div>
                            <a class="noshade-pop-close" href="javascript:void(0)" id="auth_alert_btn2"
                            style="display:none;" onclick="jQuery.modal.close();">
                            </a>
                        </div>
                    </td>
                    <td class="m-ri">
                    </td>
                </tr>
                <tr>
                    <td class="b-lt">
                    </td>
                    <td class="b-mid">
                    </td>
                    <td class="b-ri">
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="content">
            <div class="crumb">
                <a href="http://seller.dhgate.com/mydhgate/index.do">
                    我的DHgate
                </a>
                <span>
                    &gt;
                </span>
                <a href="./修改密码_files/修改密码.htm">
                    设置
                </a>
                <span>
                    &gt;
                </span>
                <a href="./修改密码_files/修改密码.htm">
                    安全设置
                </a>
                <span>
                    &gt;
                </span>
                <a href="./修改密码_files/修改密码.htm">
                    修改密码
                </a>
                <span>
                    &gt;
                </span>
                修改密码
            </div>
            <div class="layout clearfix">
                <div class="col-main">
                    <div id="right">
                        <div class="col-boxpd col-linebom">
                            <h2>
                                修改密码
                            </h2>
                        </div>
                        <div class="setauthtable" id="showpassword">
                            <table>
                                <tbody>
                                    <tr>
                                        <td class="txttitle" width="40%">
                                            当前密码：
                                        </td>
                                        <td class="txtcontent" width="60%">
                                            <span class="pwd">
                                                ****************
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="txttitle">
                                            密码强度：
                                        </td>
                                        <td class="txtcontent">
                                            <div style="" class="pswstate pswstate-poor">
                                                <span class="s1">
                                                    弱
                                                </span>
                                                <span class="s2">
                                                    中
                                                </span>
                                                <span class="s3">
                                                    强
                                                </span>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="txttitle">
                                        </td>
                                        <td class="txtcontent">
                                            <span class="btBtn">
                                                <input value="修改密码" type="button" id="valPopVidBtn">
                                            </span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="setauthtable" style="display:none;" id="modifypassword">
                            <form name="changePasswordAllForm" id="changePasswordAllForm" action="http://seller.dhgate.com/changepassword.do"
                            method="post">
                                <div class="tips-common">
                                    <span class="tips-error" id="error" style="display:none">
                                    </span>
                                </div>
                                <table>
                                    <tbody>
                                        <tr>
                                            <td class="txttitle" width="40%">
                                                登录名：
                                            </td>
                                            <td class="txtcontent" width="60%">
                                                <input value="sunvsoft" class="seta-text addwid170" type="text" readonly="true"
                                                disabled="true">
                                                <input value="sunvsoft" name="domainname" type="hidden">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle" width="40%">
                                                原密码：
                                            </td>
                                            <td class="txtcontent" width="60%">
                                                <input value="" class="seta-text addwid170" type="password" id="oldpassword"
                                                name="oldpassword">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle" width="40%">
                                                新密码：
                                            </td>
                                            <td class="txtcontent" width="60%">
                                                <input value="" class="seta-text addwid170" type="password" onblur="passwordChange();"
                                                id="password1" name="password1">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                密码强度：
                                            </td>
                                            <td class="txtcontent">
                                                <div id="show_1" class="pswstate pswstate-poor">
                                                    <span class="s1">
                                                        弱
                                                    </span>
                                                    <span class="s2">
                                                        中
                                                    </span>
                                                    <span class="s3">
                                                        强
                                                    </span>
                                                </div>
                                                <div id="show_2" class="pswstate pswstate-normal" style="display:none;">
                                                    <span class="s1">
                                                        弱
                                                    </span>
                                                    <span class="s2">
                                                        中
                                                    </span>
                                                    <span class="s3">
                                                        强
                                                    </span>
                                                </div>
                                                <div id="show_3" class="pswstate pswstate-strong" style="display:none;">
                                                    <span class="s1">
                                                        弱
                                                    </span>
                                                    <span class="s2">
                                                        中
                                                    </span>
                                                    <span class="s3">
                                                        强
                                                    </span>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle" width="40%">
                                                再次输入新密码：
                                            </td>
                                            <td class="txtcontent" width="60%">
                                                <input value="" class="seta-text addwid170" type="password" id="password2"
                                                name="password2">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                            </td>
                                            <td class="txtcontent">
                                                <span class="btBtn">
                                                    <input value="确认修改" type="button" onclick="javascript: checkform();">
                                                </span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </form>
                        </div>
                        <!-- 图片附件弹层 开始 <div id="prodoctImgWarp" class="popup-pro-img" style="display:none;">
                        <iframe></iframe>
                        <div id="proImg" class="proImg"> <b class="img-arrow-up" id="pointer"></b>
                        <div class="product-list-img"> <a id="ImgLink"  class="lazyload"  href="#blank" target="_blank" > <img id="BigImage" src="http://image.dhgate.com/2009/search/images/blank.gif" width="1" height="1" /> </a> </div>
                        </div>
                        </div>-->
                        <div class="rg-tip-com tipcorrect" id="success" style="display:none;">
                            <span class="tip-icon">
                            </span>
                            <h2>
                                修改密码成功
                            </h2>
                            <p>
                                请牢记您的新密码，不要随意泄露给陌生人。
                            </p>
                        </div>
                    </div>
                    <script type="text/javascript" src="js/checkpwd.js">
                    </script>
                </div>
				<#-- left bar -->
  				${screens.render("component://portal/widget/SellerScreens.xml#setsLeft")}
            </div>
        </div>
        <div id="valPopVidBox" style="display: none; position: fixed; z-index: 1001; ">
            <table style="width:510px;" class="noshade-pop-table">
                <tbody>
                    <tr>
                        <td class="t-lt">
                        </td>
                        <td class="t-mid">
                        </td>
                        <td class="t-ri">
                        </td>
                    </tr>
                    <tr>
                        <td class="m-lt">
                        </td>
                        <td class="m-mid">
                            <div class="mid-warp">
                                <div class="noshade-pop-content">
                                    <div class="noshade-pop-title">
                                        <span>
                                            验证安全问题：
                                        </span>
                                    </div>
                                    <div class="noshade-pop-inner">
                                        <div class="box1">
                                            <table class="poptable">
                                                <tbody>
                                                    <tr>
                                                        <td width="30%" class="txt-ali-r">
                                                            安全问题：
                                                        </td>
                                                        <td width="70%">
                                                            <select name="question" id="question">
                                                                <option value="我是谁">
                                                                    我是谁
                                                                </option>
                                                                <option value="我是谁？">
                                                                    我是谁？
                                                                </option>
                                                                <option value="我是？">
                                                                    我是？
                                                                </option>
                                                            </select>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="txt-ali-r">
                                                            答案：
                                                        </td>
                                                        <td>
                                                            <input type="text" class="seta-text addwid150" value="" name="answer"
                                                            id="answer">
                                                            <div class="marg-t5">
                                                                <a href="http://seller.dhgate.com/merchant/loseanswer.do?from=password"
                                                                class="lkundeline">
                                                                    忘记答案点这里
                                                                </a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <div class="tips-common">
                                                <span class="tips-error" id="aaerror" style="display:none">
                                                </span>
                                            </div>
                                            <div class="align-center pop-button clearfix">
                                                <span class="yellowBtn valmiddle">
                                                    <input type="button" value="确 认" onclick="javascript: checkanswer();">
                                                </span>
                                                <span class="tourBtn">
                                                    <input type="button" value="取 消" id="close_popvalVid01">
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="noshade-pop-bot">
                                    </div>
                                </div>
                                <a href="javascript:void(0)" class="noshade-pop-close" id="close_popvalVid02">
                                </a>
                            </div>
                        </td>
                        <td class="m-ri">
                        </td>
                    </tr>
                    <tr>
                        <td class="b-lt">
                        </td>
                        <td class="b-mid">
                        </td>
                        <td class="b-ri">
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>