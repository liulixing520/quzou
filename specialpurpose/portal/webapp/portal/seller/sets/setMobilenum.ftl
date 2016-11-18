<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href="http://image.dhgate.com/2008/web20/seller/css/seller.css"
        rel="stylesheet" type="text/css" />
        <link href="http://image.dhgate.com/dhs/mos/css/public/common20111215.css"
        rel="stylesheet" type="text/css" />
        <link href="http://image.dhgate.com/2008/web20/seller/css/general_popup_box.css"
        rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="http://www.dhresource.com/seller/js/common.js">
        </script>
        <script type="text/javascript" src="http://image.dhgate.com/dhs/mos/js/public/menu-common_20111226.js">
        </script>
        <script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery.simplemodal2.js?ver=2012-09-27">
        </script>
        <title>
            免费短信服务-绑定手机号码
        </title>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <!-- <link href="http://image.dhgate.com/2008/web20/seller/css/seller.css"
        rel="stylesheet" type="text/css" />
        <link href="http://image.dhgate.com/dhs/mos/css/public/common20111215.css"
        rel="stylesheet" type="text/css" />
        <link href="http://image.dhgate.com/2008/web20/seller/css/general_popup_box.css"
        rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="http://www.dhresource.com/seller/js/common.js">
        </script>
        <script type="text/javascript" src="http://image.dhgate.com/dhs/mos/js/public/menu-common_20111226.js">
        </script>
        -->
        <link href="http://www.dhresource.com/dhs/mos/css/sms/sms.css" rel="stylesheet"
        type="text/css" />
        <!--短信服务样式-->
        <script type="text/javascript" src="http://www.dhresource.com/dhs/mos/js/sms/sms.js">
        </script>
        <!--短信服务脚本-->
        <script type="text/javascript" src="http://www.dhresource.com/dhs/mos/js/sms/js/jquery/jquery-1.7.2.min.js">
        </script>
        <script type="text/javascript" src="http://www.dhresource.com/dhs/mos/js/sms/js/jquery/jquery.alert.js">
        </script>
        <link href="http://www.dhresource.com/dhs/mos/js/sms/css/jquery.alert.css"
        type="text/css" rel="stylesheet" />
        <script type="text/javascript" src="http://www.dhresource.com/dhs/mos/js/sms/js/common/userset.js">
        </script>
        <script type="text/javascript">
            $(document).ready(function() {
                PlaceHolder.class_input('accPlaceholder');
                getCheckCode();
                //手机输入字段绑定校验事件
                sms.user.bindChangeOfMobile("mobileId");
            });
            function bindSubmit() {
                var check = sms.user.checkVerifyCode("verifycodeId");
                if (!check) {
                    $("#verifycodeId").alert('提示：短信验证码不正确,请检查后重新输入!');
                    return false;
                }
                $("#bindFormId").submit();
            }
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
        <div class="content">
            <div class="crumb">
                <a href='http://seller.dhgate.com/mydhgate/index.do'>
                    我的DHgate
                </a>
                <span>
                    &gt;
                </span>
                <a href='/merchant/changepwd.do?dhpath=10008,31,3101'>
                    设置
                </a>
                <span>
                    &gt;
                </span>
                <a href='/sms/userset/smspageload.do?dhpath=10008,13,1301'>
                    手机服务
                </a>
                <span>
                    &gt;
                </span>
                <a href='/sms/userset/smspageload.do?dhpath=10008,13,1301'>
                    短信提醒服务
                </a>
                <span>
                    &gt;
                </span>
            </div>
            <div class="layout clearfix">
                <div class="col-main">
                    <div class="col-main-warp">
                        <div id="right">
                            <!--右侧内容 开始-->
                            <div class="page-topic clearfix">
                                <h2>
                                    免费短信提醒服务
                                </h2>
                            </div>
                            <ul class="sms-binding-area">
                                <form name="bindForm" action="/sms/userset/bindmobile.do" method="post"
                                id="bindFormId">
                                    <li class="sms-binding-title">
                                        绑定手机号码，开通免费服务
                                    </li>
                                    <li>
                                        <input class="accPlaceholder sms-input sms-binding-w1" name="mobile" id="mobileId"
                                        type="text" placeholder="请输入11位手机号码" />
                                        <span class="sms-erroe-tip1 sms-m-l" style="display:none;">
                                            <span>
                                                请输入有效的11位手机号码
                                            </span>
                                        </span>
                                    </li>
                                    <li>
                                        <span id="getCodeBtn" class="sms-code-button">
                                            <input type="button" value="免费获取验证码" onclick='sms.user.sendVerifyCode("mobileId");'
                                            />
                                        </span>
                                        <input class="accPlaceholder sms-input sms-binding-w2" id="verifycodeId"
                                        name="verifycode" type="text" placeholder="输入短信验证码" />
                                        <span class="sms-erroe-tip1 sms-m-l" style="display:none;">
                                            <span>
                                                请输入有效4位短信验证码
                                            </span>
                                        </span>
                                        <span id="CodeSendTip" class="sms-color1 sms-m-l" style="display:none;">
                                            手机验证码已发送，请查询手机短信
                                        </span>
                                    </li>
                                    <li style="display:none">
                                        <input class="accPlaceholder sms-input sms-binding-w3" type="text" placeholder="请输入图内文字"
                                        />
                                        <span class="sms-checking-code">
                                            <img src="http://www.dhresource.com/dhs/mos/image/sms/checking-code.gif"
                                            width="100" height="32" />
                                        </span>
                                        <a class="sms-m-l" href="javascript:;">
                                            看不清?
                                        </a>
                                    </li>
                                    <li>
                                        <a class="sms-binding-button" href="javascript:;">
                                            <input class="sms-text3" type="button" value="绑 定" onclick="bindSubmit();">
                                        </a>
                                    </li>
                                </form>
                            </ul>
                            <div class="sms-serve-wrap">
                                <p class="sms-serve-title">
                                    绑定手机将免费享受四项短信服务，并可自由定制
                                </p>
                                <div class="sms-serve-con clearfix">
                                    <div class="sms-serve-main">
                                        <dl>
                                            <dt>
                                                订单相关短信通知
                                            </dt>
                                            <dd>
                                                最新待发货订单
                                            </dd>
                                            <dd>
                                                订单退款
                                            </dd>
                                            <dd>
                                                备货截止前1天仍未填写运单号
                                            </dd>
                                        </dl>
                                    </div>
                                    <div class="sms-serve-main">
                                        <dl class="sms-serve-list2 sms-serve-h1">
                                            <dt>
                                                结算银行账户状态异常通知
                                            </dt>
                                            <dd>
                                                银行账户暂停提醒
                                            </dd>
                                        </dl>
                                    </div>
                                    <div class="sms-serve-main">
                                        <dl class="sms-serve-list3 sms-serve-h2">
                                            <dt>
                                                资金账户变动相关通知
                                            </dt>
                                            <dd>
                                                订单结算
                                            </dd>
                                            <dd>
                                                充值
                                            </dd>
                                            <dd>
                                                提现
                                            </dd>
                                            <dd>
                                                金额冻结
                                            </dd>
                                            <dd>
                                                资金账户冻结
                                            </dd>
                                            <dd>
                                                资金账户解冻
                                            </dd>
                                        </dl>
                                    </div>
                                    <div class="sms-serve-main" style="height:197px">
                                        <dl class="sms-serve-list4">
                                            <dt>
                                                处罚与纠纷相关通知
                                            </dt>
                                            <!-- <dd>3个月内有效黄牌累积到2张时</dd>
                                            <dd>3个月内有效黄牌累积到5张时</dd>
                                            -->
                                            <dd>
                                                平台账户被冻结
                                            </dd>
                                            <dd>
                                                受到平台账户被关闭的处罚
                                            </dd>
                                            <dd>
                                                受到平台账户被终止的处罚
                                            </dd>
                                            <dd>
                                                买家对订单开启普通协议纠纷时
                                            </dd>
                                            <dd>
                                                买家对订单纠纷升级到平台时
                                            </dd>
                                        </dl>
                                    </div>
                                </div>
                            </div>
                            <!--右侧内容 结束-->
                        </div>
                    </div>
                </div>
				<#-- left bar -->
  				${screens.render("component://portal/widget/SellerScreens.xml#setsLeft")}
            </div>
        </div>
    </body>

</html>