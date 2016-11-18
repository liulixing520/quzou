<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0077)http://seller.dhgate.com/fundaccounting/ba/cnyAccInfo.do?dhpath=10008,14,1403
-->
<html xmlns="http://www.w3.org/1999/xhtml">
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--
        <link href="./账户设置_files/seller.css" rel="stylesheet" type="text/css">
        -->
        <script type="text/javascript" async="" src="../seller/js/dc.js">
        </script>
        <script type="text/javascript" src="../seller/js/common.js">
        </script>
        <style type="text/css">
        </style>
        <script type="text/javascript" src="../seller/js/menu-common_20111226.js">
        </script>
        <script type="text/javascript" src="../seller/js/jquery.simplemodal2.js">
        </script>
        <title>
            账户设置
        </title>
        <link href="../seller/css/common20111215.css" rel="stylesheet" type="text/css">
        <link href="../seller/css/general_popup_box.css" rel="stylesheet" type="text/css">
        <link href="../seller/css/upload.css" rel="stylesheet" type="text/css">
        <link href="../seller/css/set-account.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="./账户设置_files/bankcny.js">
        </script>
        <!--资金账户上传样式开始-->
        <script type="text/javascript" src="../seller/js/jquery.simplemodal2(1).js">
        </script>
        <script type="text/javascript" src="../seller/js/companybanknewrmb.js">
        </script>
        <script type="text/javascript" src="../seller/js/validdatatools.js">
        </script>
        <script type="text/javascript" src="../seller/js/jquery.uploadify.v2.1.4.min.js">
        </script>
        <script type="text/javascript" src="../seller/js/jquery.history_remote.pack.js">
        </script>
        <script type="text/javascript" src="../seller/js/jquery.tabs.pack.js">
        </script>
        <script type="text/javascript" src="../seller/js/swfobject.js">
        </script>
        <script type="text/javascript" src="../seller/js/json2.min.js">
        </script>
        <script type="text/javascript" src="../seller/js/ajaxfileupload.js">
        </script>
        <!--资金账户上传样式结束-->
        <script type="text/javascript">
            $(document).ready(function() {
                var tipPop = new accountPopUp({
                    accountPopWrap: 'accountTipPop'
                });
                $("[name='verifyMoney']").each(function() {
                    $(this).click(function() {
                        var input = $(this).siblings("input");
                        var money = $(input).val();
                        money = money.replace(/\s/g, '');
                        $(input).val(money);
                        if (checkMoney(money)) {
                            $(this).parents("form").submit();
                        }
                    });
                });
            });
        </script>
        <style type="text/css" media="screen">
            #pic_file1Uploader {visibility:hidden}#pic_file2Uploader {visibility:hidden}#pic_file3Uploader
            {visibility:hidden}
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
                <a href="http://seller.dhgate.com/fundaccounting/accountDetail/detailList.do?dhpath=10006,0901">
                    资金账户
                </a>
                <span>
                    &gt;
                </span>
                <a href="http://seller.dhgate.com/fundaccounting/ba/cnyAccInfo.do?dhpath=10006,0906">
                    账户设置
                </a>
                <span>
                    &gt;
                </span>
                账户设置
            </div>
            <div class="layout clearfix">
                <div class="col-main">
                    <div class="col-main-warp">
                        <div id="right">
                            <!--右侧内容 开始 -->
                            <div class="page-topic clearfix">
                                <h2>
                                    账户设置
                                </h2>
                                <span class="return-link">
                                    <a href="http://seller.dhgate.com/help/seller-help/c2003/a66601.html"
                                    target="_blank">
                                        查看银行验证流程
                                    </a>
                                </span>
                            </div>
                            <div class="rtab-warp">
                                <ul class="tabW clearfix">
                                    <li class="current">
                                        <a href="javascript:void(0);">
                                            <span>
                                                人民币
                                            </span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="http://seller.dhgate.com/fundaccounting/ba/usdAccInfo.do">
                                            <span>
                                                外币
                                            </span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="acc-common-tip">
                                <b class="acc-tip-icon acc-common">
                                </b>
                                您还没有成交的订单，暂时不能设置银行账户
                            </div>
                            <div class="acc-set-wrap">
                                <span class="acc-not-add">
                                    <span class="acc-not-con">
                                        <b>
                                        </b>
                                        <span>
                                            添加银行卡
                                        </span>
                                    </span>
                                </span>
                            </div>
                            <!--弹层部分 开始-->
                            <!--查看信息弹层 开始-->
                            <!--查看信息弹层 结束-->
                            <!--修改信息弹层 开始-->
                            <!--修改信息弹层 结束-->
                            <!--提示弹层 开始-->
                            <!--提示弹层 结束-->
                            <!--弹层部分 结束-->
                            <!--右侧内容 结束 -->
                        </div>
                    </div>
                </div>
                <div class="col-left">
                    <input type="hidden" id="currentPath" value="10006,0901">
                    <!--资金账户新添加内容 开始-->
                    <div class="capital-account">
                        <div class="capital-number">
                            <!-- 正常账户-->
                            <table class="capital-table" cellpadding="0" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <td>
                                            可提现
                                        </td>
                                        <td class="number">
                                            <span class="acc-t-color1">
                                                US $0.00
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            冻结中
                                        </td>
                                        <td class="number">
                                            US $0.00
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="capital-button">
                                <a class="capital-graybtn s-margin3 unclickbtn" href="javascript:void(0);">
                                    <span>
                                        提 现
                                    </span>
                                </a>
                            </div>
                        </div>
                    </div>
                 </div>
    			<#-- left bar -->
  				${screens.render("component://portal/widget/SellerScreens.xml#setsLeft")}
            </div>
        </div>

        <div id="viewInfoPop" class="acc-pop-wrap" style="display:none;">
            <table class="noshade-pop-table" style="width:430px;">
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
                                            您的申请信息已保存：
                                        </span>
                                    </div>
                                    <div class="noshade-pop-inner">
                                        <div class="box1">
                                            <dl class="acc-pop-save clearfix">
                                                <dt>
                                                    <b class="acc-star">
                                                        *
                                                    </b>
                                                    开户人：
                                                </dt>
                                                <dd id="viewPayee">
                                                </dd>
                                            </dl>
                                            <dl class="acc-pop-save clearfix">
                                                <dt>
                                                    <b class="acc-star">
                                                        *
                                                    </b>
                                                    银行账号：
                                                </dt>
                                                <dd id="viewBankCard">
                                                </dd>
                                            </dl>
                                            <dl class="acc-pop-save clearfix">
                                                <dt>
                                                    <b class="acc-star">
                                                        *
                                                    </b>
                                                    开户行：
                                                </dt>
                                                <dd id="viewBankName">
                                                </dd>
                                            </dl>
                                        </div>
                                    </div>
                                    <div class="noshade-pop-bot">
                                    </div>
                                </div>
                                <a class="noshade-pop-close" href="javascript:void(0)" attr-close="close">
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
        <div id="modifyInfoPop" class="acc-pop-wrap" style="display:none;">
            <form name="mdform" id="mdform" action="http://seller.dhgate.com/fundaccounting/ba/bankInfoModifyRequest.do?reqeustType=3"
            method="post" onsubmit="return checkReqModifyRAData();">
                <input type="hidden" id="uuid" name="uuid" value="ff808081482fd3fd01485e24266e5056">
                <input type="hidden" id="token" name="token" value="256c3341-531f-42c1-b1c9-082ac7d4f47b">
                <input type="hidden" id="bankAccountId" name="bankAccountId" value="">
                <table class="noshade-pop-table" style="width:490px;">
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
                                                修改申请：
                                            </span>
                                        </div>
                                        <div class="noshade-pop-inner">
                                            <div class="box1">
                                                <dl class="acc-pop-list clearfix">
                                                    <dt>
                                                        修改内容：
                                                    </dt>
                                                    <dd>
                                                        <select id="mdreason" name="mdreason" size="1" style="width:270px;" onchange="showMdReasonMark(this.value);">
                                                            <option value="" selected="">
                                                                -请选择您要修改账户的原因-
                                                            </option>
                                                            <option value="03">
                                                                需更换开户行地址
                                                            </option>
                                                            <option value="02">
                                                                银行账号
                                                            </option>
                                                            <option value="00">
                                                                其他原因
                                                            </option>
                                                        </select>
                                                    </dd>
                                                </dl>
                                                <dl class="acc-pop-list clearfix">
                                                    <dd>
                                                        <p>
                                                            <textarea name="mdreasonRemark" id="mdremark" cols="" rows="" onkeyup="showResLen(this,50);"
                                                            style="height:60px; width:360px;display:none;" class="color1" onfocus="if(this.value==&#39;请输入您要修改的内容&#39;){this.value=&#39;&#39;;}">
                                                                请输入您要修改的内容
                                                            </textarea>
                                                        </p>
                                                        <p id="mdremarkTip">
                                                        </p>
                                                    </dd>
                                                </dl>
                                                <dl class="acc-pop-list clearfix">
                                                    <dt>
                                                        需要提交的资料：
                                                    </dt>
                                                    <dd>
                                                        请选择注册人身份证正反面图片
                                                    </dd>
                                                    <dd>
                                                        <ul class="clearfix">
                                                            <li class="acc-m1">
                                                                <p>
                                                                </p>
                                                                <div class="selectBtnContainer">
                                                                    <div class="selectBtn">
                                                                        <input id="pic_file1" type="file" class="color1" size="30" style="display: none;">
                                                                        <object type="application/x-shockwave-flash" data="http://seller.dhgate.com/fundaccounting/assets/js/userset/uploadalbums.swf"
                                                                        width="120" height="30" id="pic_file1Uploader" style="visibility: visible;">
                                                                            <param name="quality" value="high">
                                                                            <param name="wmode" value="opaque">
                                                                            <param name="allowScriptAccess" value="always">
                                                                            <param name="flashvars" value="uploadifyID=pic_file1&amp;pagepath=/fundaccounting/ba/&amp;script=http://upload.dhgate.com/resourceServ&amp;folder=uploaddify&amp;scriptData=functionname%3Dother%26isunique%3D0%26uuid%3Dff808081482fd3fd01485e24266e5056&amp;width=120&amp;height=30&amp;wmode=opaque&amp;method=GET&amp;queueSizeLimit=999&amp;simUploadLimit=1&amp;fileDesc=jpg,jpeg,gif&amp;fileExt=*.jpg;*.jpeg;*.gif;&amp;auto=true&amp;sizeLimit=200000&amp;fileDataName=Filedata&amp;queueID=custom-queue1">
                                                                        </object>
                                                                        <p>
                                                                            正面图片
                                                                        </p>
                                                                    </div>
                                                                    <div class="selectQuery uploadifyQueue" id="custom-queue1">
                                                                    </div>
                                                                    <div class="loadingImg" id="loadingImg1">
                                                                        <img src="./账户设置_files/load_syi.gif">
                                                                    </div>
                                                                    <input id="idcardpic1" name="idcardpic" type="text" value="" size="30"
                                                                    class="pic_files" readonly="">
                                                                    <div style="clear:both;">
                                                                    </div>
                                                                </div>
                                                                <p>
                                                                </p>
                                                                <div class="acc-pop-card">
                                                                    <span>
                                                                        <img id="img1" src="./账户设置_files/space.png" width="145" height="90">
                                                                    </span>
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <p>
                                                                </p>
                                                                <div class="selectBtnContainer">
                                                                    <div class="selectBtn">
                                                                        <input id="pic_file2" type="file" class="color1" size="30" style="display: none;">
                                                                        <object type="application/x-shockwave-flash" data="http://seller.dhgate.com/fundaccounting/assets/js/userset/uploadalbums.swf"
                                                                        width="120" height="30" id="pic_file2Uploader" style="visibility: visible;">
                                                                            <param name="quality" value="high">
                                                                            <param name="wmode" value="opaque">
                                                                            <param name="allowScriptAccess" value="always">
                                                                            <param name="flashvars" value="uploadifyID=pic_file2&amp;pagepath=/fundaccounting/ba/&amp;script=http://upload.dhgate.com/resourceServ&amp;folder=uploaddify&amp;scriptData=functionname%3Dother%26isunique%3D0%26uuid%3Dff808081482fd3fd01485e24266e5056&amp;width=120&amp;height=30&amp;wmode=opaque&amp;method=GET&amp;queueSizeLimit=999&amp;simUploadLimit=1&amp;fileDesc=jpg,jpeg,gif&amp;fileExt=*.jpg;*.jpeg;*.gif;&amp;auto=true&amp;sizeLimit=200000&amp;fileDataName=Filedata&amp;queueID=custom-queue2">
                                                                        </object>
                                                                        <p>
                                                                            反面图片
                                                                        </p>
                                                                    </div>
                                                                    <div class="selectQuery uploadifyQueue" id="custom-queue2">
                                                                    </div>
                                                                    <div class="loadingImg" id="loadingImg2">
                                                                        <img src="./账户设置_files/load_syi.gif">
                                                                    </div>
                                                                    <input id="idcardpic2" name="idcardpic" type="text" value="" size="30"
                                                                    class="pic_files" readonly="">
                                                                    <div style="clear:both;">
                                                                    </div>
                                                                </div>
                                                                <p>
                                                                </p>
                                                                <div class="acc-pop-card">
                                                                    <span>
                                                                        <img id="img2" src="./账户设置_files/space.png" width="145" height="90">
                                                                    </span>
                                                                </div>
                                                            </li>
                                                        </ul>
                                                    </dd>
                                                    <dd id="bankdetaildiv">
                                                        请上传银行账户明细
                                                        <ul class="clearfix">
                                                            <li class="acc-m1">
                                                                <div class="markWrap acc-mark-wrap">
                                                                    <p>
                                                                    </p>
                                                                    <div class="selectBtnContainer">
                                                                        <div class="selectBtn">
                                                                            <input id="pic_file3" type="file" class="color1" size="30" style="display: none;">
                                                                            <object type="application/x-shockwave-flash" data="http://seller.dhgate.com/fundaccounting/assets/js/userset/uploadalbums.swf"
                                                                            width="120" height="30" id="pic_file3Uploader" style="visibility: visible;">
                                                                                <param name="quality" value="high">
                                                                                <param name="wmode" value="opaque">
                                                                                <param name="allowScriptAccess" value="always">
                                                                                <param name="flashvars" value="uploadifyID=pic_file3&amp;pagepath=/fundaccounting/ba/&amp;script=http://upload.dhgate.com/resourceServ&amp;folder=uploaddify&amp;scriptData=functionname%3Dother%26isunique%3D0%26uuid%3Dff808081482fd3fd01485e24266e5056&amp;width=120&amp;height=30&amp;wmode=opaque&amp;method=GET&amp;queueSizeLimit=999&amp;simUploadLimit=1&amp;fileDesc=jpg,jpeg,gif&amp;fileExt=*.jpg;*.jpeg;*.gif;&amp;auto=true&amp;sizeLimit=200000&amp;fileDataName=Filedata&amp;queueID=custom-queue3">
                                                                            </object>
                                                                        </div>
                                                                        <div class="selectQuery uploadifyQueue" id="custom-queue3">
                                                                        </div>
                                                                        <div class="loadingImg" id="loadingImg3">
                                                                            <img src="./账户设置_files/load_syi.gif">
                                                                        </div>
                                                                        <input id="idcardpic3" name="idcardpic" type="text" value="" size="30"
                                                                        class="pic_files" readonly="">
                                                                        <div style="clear:both;">
                                                                        </div>
                                                                    </div>
                                                                    <p>
                                                                    </p>
                                                                </div>
                                                                <div class="acc-pop-card">
                                                                    <span>
                                                                        <img id="img3" src="./账户设置_files/space.png" width="145" height="90">
                                                                    </span>
                                                                </div>
                                                            </li>
                                                        </ul>
                                                    </dd>
                                                    <dd>
                                                        <span class="acc-upload-tip">
                                                            <b class="acc-tip-icon acc-upload">
                                                            </b>
                                                            请上传jpg,jpeg,gif格式，200k以下的图片。
                                                        </span>
                                                    </dd>
                                                </dl>
                                                <p id="mdreasonTip" style="color:red;">
                                                </p>
                                                <div class="align-center pop-button">
                                                    <a href="javascript:void(0)" class="yellowbutton2" attr-close="close">
                                                        <span id="submitSpan" attr-close="">
                                                            确 定
                                                        </span>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="noshade-pop-bot">
                                        </div>
                                    </div>
                                    <a class="noshade-pop-close" href="javascript:void(0)" attr-close="close">
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
            </form>
        </div>
        <div id="accountTipPop" class="acc-pop-wrap" style="display:none;">
            <table class="noshade-pop-table" style="width:300px;">
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
                                            操作提示：
                                        </span>
                                    </div>
                                    <div class="noshade-pop-inner">
                                        <div class="box1">
                                            <p class="align-center" id="tipMsg">
                                            </p>
                                            <div class="align-center pop-button">
                                                <a href="javascript:void(0)" class="yellowbutton2" attr-close="close">
                                                    <span attr-close="close">
                                                        确 定
                                                    </span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="noshade-pop-bot">
                                    </div>
                                </div>
                                <a class="noshade-pop-close" href="javascript:void(0)" attr-close="close">
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
        <div id="accountMask" style="display:none;">
            <iframe id="accountMaskIframe">
            </iframe>
        </div>
    </body>

</html>