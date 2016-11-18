<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0061)http://seller.dhgate.com/merchant/identity.do?dhpath=10008,50
-->
<html xmlns="http://www.w3.org/1999/xhtml">
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
        <link href="../seller/css/seller.css" rel="stylesheet" type="text/css">
        <link href="../seller/css/common20111215.css" rel="stylesheet" type="text/css">
        <link href="../seller/css/general_popup_box.css" rel="stylesheet" type="text/css">
       
        <script type="text/javascript" async="" src="../seller/js/dc.js">
        </script>
        <script type="text/javascript" src="../seller/js/common.js">
        </script>
        <script type="text/javascript" src="../seller/js/menu-common_20111226.js">
        </script>
        <script type="text/javascript" src="../seller/js/jquery.simplemodal2.js">
        </script>
        <title>
            身份认证
        </title>
        <meta charset="utf-8">
        <style type="text/css">
        </style>
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
                <a href="http://seller.dhgate.com/mydhgate/index.do">
                    我的DHgate
                </a>
                <span>
                    &gt;
                </span>
                <a href="http://seller.dhgate.com/merchant/changepwd.do?dhpath=10008,31,3101">
                    设置
                </a>
                <span>
                    &gt;
                </span>
                <a href="./身份认证_files/身份认证.htm">
                    身份认证
                </a>
                <span>
                    &gt;
                </span>
                身份认证
            </div>
            <div class="layout clearfix">
                <div class="col-main">
                    <link href="../seller/css/micidentity.css" rel="stylesheet" type="text/css">
                    <link href="../seller/css/setauthentication.css" rel="stylesheet" type="text/css">
                    <div id="right">
                        <div class="col-boxpd col-linebom">
                            <h2>
                                身份认证
                            </h2>
                        </div>
                        <!-- <div class="col-sailtips clearfix">
                        <p>敦煌网为提高买家购物体验，打通专业供应商和采购商成功交易通道，建立“卖家身份认证系统”。完成卖家身份识别后，您可以对您的订单进行提款操作（如果不进行身份认证，则无法进行提款），为您在敦煌网的成功交易打好基础，并且您能更早参与敦煌网各项促销活动，赢得更多买家和交易！</p>
                        </div>-->
                        <div class="rg-tip-com tipwarning">
                            <span class="tips-correct">
                                您的身份认证申请已通过审核。卖家身份类别：
                                <strong>
                                    大陆企业
                                </strong>
                            </span>
                        </div>
                    </div>
                    <script type="text/javascript" src="./身份认证_files/micidentity.js">
                    </script>
                    <script type="text/javascript" src="./身份认证_files/identity.js">
                    </script>
                </div>
				<#-- left bar -->
  				${screens.render("component://portal/widget/SellerScreens.xml#setsLeft")}
            </div>
        </div>
    </body>

</html>