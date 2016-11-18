<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0097)http://seller.dhgate.com/mydhgate/order/refund/selleraddress.do?act=pageload&dhpath=10008,40,1408
-->
<html xmlns="http://www.w3.org/1999/xhtml">
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>
            退货地址管理
        </title>
        <!-- <link href="css/seller.css" rel="stylesheet" type="text/css">
        <link href="css/common20140922.css" rel="stylesheet" type="text/css">
        <link href="css/general_popup_box.css" rel="stylesheet" type="text/css">
        -->
        <script type="text/javascript" async="" src="js/dc.js">
        </script>
        <script type="text/javascript" src="js/common.js">
        </script>
        <script type="text/javascript" src="js/menu-common_20111226.js">
        </script>
        <script type="text/javascript" src="js/jquery.simplemodal2.js">
        </script>
        <!--<script type="text/javascript" src="http://seller.dhgate.com/js/publish/menu-common_20111226.js"></script>-->
        <link href="../seller/css/seller_button.css" rel="stylesheet" type="text/css">
        <link href="../seller/css/general_popup_box.css" rel="stylesheet" type="text/css">
        <link href="../seller/css/order-information.css" rel="stylesheet" type="text/css">
        <script src="../seller/js/formValidator.js" type="text/javascript" charset="UTF-8">
        </script>
        <script src="../seller/js/orderutil.js" type="text/javascript" charset="UTF-8">
        </script>
        <script type="text/javascript" src="../seller/js/selleraddress.js">
        </script>
        <script type="text/javascript" src="../seller/js/jquery.livequery.js">
        </script>
        <script type="text/javascript" src="../seller/js/jquery.simplemodal2(1).js">
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
                <a href="http://seller.dhgate.com/merchant/changepwd.do?dhpath=10008,31,3101">
                    设置
                </a>
                <span>
                    &gt;
                </span>
                <a href="./退货地址管理_files/退货地址管理.htm">
                    我的地址
                </a>
                <span>
                    &gt;
                </span>
                退货地址管理
            </div>
            <div class="layout clearfix">
                <div class="col-main">
                    <div class="col-main-warp">
                        <div id="right">
                            <div class="page-topic clearfix">
                                <h2>
                                    退货地址管理
                                </h2>
                            </div>
                            <div id="add-english" class="add-english-address">
                                <div class="module-title">
                                    <span>
                                        添加英文退货地址
                                    </span>
                                </div>
                                <div class="tips-common">
                                    <span class="tips-information">
                                        因为以下地址信息要发给买家，请您一定要用英文填写，带
                                        <b class="color-f00">
                                            *
                                        </b>
                                        号的为必填项。
                                    </span>
                                </div>
                                <div class="add-detail-address">
                                    <form id="SellerAddressForm" action="http://seller.dhgate.com/mydhgate/order/refund/selleraddress.do?act=pageload&dhpath=10008,40,1408#">
                                        <dl class="clearfix">
                                            <dt>
                                                <span class="color-f00">
                                                    *
                                                </span>
                                                收货人姓名：
                                            </dt>
                                            <dd>
                                                <input name="contactname" type="text" id="contactname" size="40" maxlength="14">
                                                <span class="onShow" id="contactnameTip">
                                                    &nbsp;
                                                </span>
                                            </dd>
                                        </dl>
                                        <dl class="clearfix">
                                            <dt>
                                                <span class="color-f00">
                                                    *
                                                </span>
                                                国家：
                                            </dt>
                                            <dd>
                                                <select id="add-country" name="country">
                                                    <option value="China">
                                                        China
                                                    </option>
                                                    <option value="United States">
                                                        United States
                                                    </option>
                                                    <option value="United Kingdom">
                                                        United Kingdom
                                                    </option>
                                                </select>
                                            </dd>
                                        </dl>
                                        <dl class="clearfix">
                                            <dt>
                                                <span class="color-f00">
                                                    *
                                                </span>
                                                省、州或直辖市：
                                            </dt>
                                            <dd>
                                                <input name="state" type="text" id="state" size="40" maxlength="20">
                                                <span class="onShow" id="stateTip">
                                                    &nbsp;
                                                </span>
                                            </dd>
                                        </dl>
                                        <dl class="clearfix">
                                            <dt>
                                                <span class="color-f00">
                                                    *
                                                </span>
                                                城市：
                                            </dt>
                                            <dd>
                                                <input name="city" type="text" id="city" size="40" maxlength="22">
                                                <span class="onShow" id="cityTip">
                                                    &nbsp;
                                                </span>
                                            </dd>
                                        </dl>
                                        <dl class="clearfix">
                                            <dt>
                                                <span class="color-f00">
                                                    *
                                                </span>
                                                详细地址：
                                            </dt>
                                            <dd>
                                                <input name="address" type="text" id="address" size="40" maxlength="100">
                                                <span class="onShow" id="addressTip">
                                                    &nbsp;
                                                </span>
                                            </dd>
                                        </dl>
                                        <dl class="clearfix">
                                            <dt>
                                                <span class="color-f00">
                                                    *
                                                </span>
                                                邮政编码：
                                            </dt>
                                            <dd>
                                                <input name="zipcode" type="text" id="zipcode" size="40" maxlength="20">
                                                <span class="onShow" id="zipcodeTip">
                                                    &nbsp;
                                                </span>
                                            </dd>
                                        </dl>
                                        <dl class="clearfix">
                                            <dt>
                                                <span class="color-f00">
                                                    *
                                                </span>
                                                联系电话：
                                            </dt>
                                            <dd>
                                                +86
                                                <input id="tel-phone" type="text" size="35" maxlength="30">
                                                <span class="onShow" id="phoneTip">
                                                    &nbsp;
                                                </span>
                                            </dd>
                                        </dl>
                                        <dl class="clearfix">
                                            <dt>
                                                手机号码：
                                            </dt>
                                            <dd>
                                                +86
                                                <input name="mobilephone" type="text" id="mobilephone" maxlength="11"
                                                size="35">
                                                <span class="onShow" id="mobilephoneTip">
                                                    &nbsp;
                                                </span>
                                            </dd>
                                        </dl>
                                        <dl class="clearfix">
                                            <dt>
                                                &nbsp;
                                            </dt>
                                            <dd>
                                                <input name="check_default" id="check_default" type="checkbox">
                                                设置为默认地址
                                            </dd>
                                        </dl>
                                        <input type="hidden" name="adressId" id="adressId">
                                    </form>
                                </div>
                                <div class="b-zline10">
                                </div>
                                <div class="align-center button-operate">
                                    <a href="javascript:void(0)" class="yellowbutton2" id="saveAddressA">
                                        <span id="saveAddress">
                                            保存地址
                                        </span>
                                    </a>
                                    <span class="loading-button clearfix" id="save-savingBtn" style="display:none">
                                        <img src="img/loadings.gif">
                                        <span class="loading-matter">
                                            正在保存
                                        </span>
                                    </span>
                                </div>
                            </div>
                            <div id="show-eng" class="add-english-address" style="display:none;">
                                <div class="module-title">
                                    <span>
                                        已保存的英文退货地址
                                    </span>
                                </div>
                                <div class="add-more-address" id="addEnAddrBtnWapper">
                                    <p>
                                        <span>
                                            您还能添加
                                            <strong class="prompt-letter" id="lastNo">
                                                4
                                            </strong>
                                            个退货地址
                                        </span>
                                        <span>
                                            <input type="button" id="addEnAddrBtn" value="添加英文退货地址">
                                        </span>
                                    </p>
                                </div>
                                <div class="tips-common">
                                    <span class="tips-information">
                                        当产生平台纠纷且裁决为退货退款时，在5天到期后如果您仍然没有提供退货地址，则系统默认该地址为退货地址。
                                    </span>
                                </div>
                                <table class="rowline-table" id="englishAddrList">
                                    <tbody>
                                        <tr class="tr-first">
                                            <td width="40%">
                                                详细地址
                                            </td>
                                            <td width="15%">
                                                收货人姓名
                                            </td>
                                            <td width="10%">
                                                邮编
                                            </td>
                                            <td width="23%">
                                                联系电话/手机
                                            </td>
                                            <td width="12%">
                                                操作
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div id="add-chinese" class="add-chinese-address">
                                <div class="module-title">
                                    <span>
                                        添加中文退货地址
                                    </span>
                                </div>
                                <div class="tips-common">
                                    <span class="tips-information">
                                        如敦煌网收到买家寄回的包裹，我们会将货物寄到您预留的中文退货地址。
                                    </span>
                                </div>
                                <div class="without-remind">
                                    <p class="prompt-letter">
                                        您还没有添加中文退货地址，请
                                        <a href="javascript:void(0)" id="showAddChinaAddrBtn" class="under-line">
                                            添加中文退货地址
                                        </a>
                                    </p>
                                </div>
                            </div>
                            <div id="show-ch" class="add-chinese-address" style="display:none;">
                                <div class="module-title">
                                    <span>
                                        中文退货地址
                                    </span>
                                </div>
                                <div class="tips-common">
                                    <span class="tips-information">
                                        如敦煌网收到买家寄回的包裹，我们会将货物寄到您预留的中文退货地址。
                                    </span>
                                </div>
                                <table class="rowline-table" id="chAddrList">
                                    <tbody>
                                        <tr class="tr-first">
                                            <td width="40%">
                                                详细地址
                                            </td>
                                            <td width="15%">
                                                收货人姓名
                                            </td>
                                            <td width="10%">
                                                邮编
                                            </td>
                                            <td width="23%">
                                                联系电话/手机
                                            </td>
                                            <td width="12%">
                                                操作
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div id="save-eng-wraper" style="display:none">
                                <div id="save-eng">
                                    <table class="noshade-pop-table" style="width:660px;">
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
                                                                    修改退货地址：
                                                                </span>
                                                            </div>
                                                            <div class="noshade-pop-inner">
                                                                <div class="tips-common">
                                                                    <span class="tips-information">
                                                                        因为以下地址信息要发给买家，请您一定要用英文填写，带
                                                                        <b class="color-f00">
                                                                            *
                                                                        </b>
                                                                        号的为必填项。
                                                                    </span>
                                                                </div>
                                                                <div class="box1">
                                                                    <div class="supply-address clearfix">
                                                                        <form id="saveEngForm" action="http://seller.dhgate.com/mydhgate/order/refund/selleraddress.do?act=pageload&dhpath=10008,40,1408#">
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    <span class="color-f00">
                                                                                        *
                                                                                    </span>
                                                                                    收货人姓名：
                                                                                </dt>
                                                                                <dd>
                                                                                    <input name="contactname" type="text" id="save-contactname" size="40"
                                                                                    maxlength="14">
                                                                                    <span class="onShow" id="save-contactnameTip">
                                                                                        &nbsp;
                                                                                    </span>
                                                                                </dd>
                                                                            </dl>
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    <span class="color-f00">
                                                                                        *
                                                                                    </span>
                                                                                    国家：
                                                                                </dt>
                                                                                <dd>
                                                                                    <select id="save-country" onchange="setZipCode()">
                                                                                        <option value="China">
                                                                                            China
                                                                                        </option>
                                                                                        <option value="United States">
                                                                                            United States
                                                                                        </option>
                                                                                        <option value="United Kingdom">
                                                                                            United Kingdom
                                                                                        </option>
                                                                                    </select>
                                                                                    <!--<input name="country" type="hidden" id="save-country" value="China"/>
                                                                                    -->
                                                                                </dd>
                                                                            </dl>
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    <span class="color-f00">
                                                                                        *
                                                                                    </span>
                                                                                    省、州或直辖市：
                                                                                </dt>
                                                                                <dd>
                                                                                    <input name="state" type="text" id="save-state" size="40" maxlength="20">
                                                                                    <span class="onShow" id="save-stateTip">
                                                                                        &nbsp;
                                                                                    </span>
                                                                                </dd>
                                                                            </dl>
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    <span class="color-f00">
                                                                                        *
                                                                                    </span>
                                                                                    城市：
                                                                                </dt>
                                                                                <dd>
                                                                                    <input name="city" type="text" id="save-city" size="40" maxlength="22">
                                                                                    <span class="onShow" id="save-cityTip">
                                                                                        &nbsp;
                                                                                    </span>
                                                                                </dd>
                                                                            </dl>
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    <span class="color-f00">
                                                                                        *
                                                                                    </span>
                                                                                    详细地址：
                                                                                </dt>
                                                                                <dd>
                                                                                    <input name="address" type="text" id="save-address" size="40" maxlength="100">
                                                                                    <span class="onShow" id="save-addressTip">
                                                                                        &nbsp;
                                                                                    </span>
                                                                                </dd>
                                                                            </dl>
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    <span class="color-f00">
                                                                                        *
                                                                                    </span>
                                                                                    邮政编码：
                                                                                </dt>
                                                                                <dd>
                                                                                    <input name="zipcode" type="text" id="save-zipcode" size="40" maxlength="20">
                                                                                    <span class="onShow" id="save-zipcodeTip">
                                                                                        &nbsp;
                                                                                    </span>
                                                                                </dd>
                                                                            </dl>
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    <span class="color-f00">
                                                                                        *
                                                                                    </span>
                                                                                    联系电话：
                                                                                </dt>
                                                                                <dd>
                                                                                    +86
                                                                                    <input id="save-tel-phone" type="text" size="35" maxlength="30">
                                                                                    <span class="onShow" id="save-phoneTip">
                                                                                        &nbsp;
                                                                                    </span>
                                                                                </dd>
                                                                            </dl>
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    手机号码：
                                                                                </dt>
                                                                                <dd>
                                                                                    +86
                                                                                    <input name="mobilephone" type="text" id="save-mobilephone" maxlength="11"
                                                                                    size="35">
                                                                                    <span class="onShow" id="save-mobilephoneTip">
                                                                                        &nbsp;
                                                                                    </span>
                                                                                </dd>
                                                                            </dl>
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    &nbsp;
                                                                                </dt>
                                                                                <dd>
                                                                                    <input name="check_default" id="save-check_default" type="checkbox">
                                                                                    设置为默认地址
                                                                                </dd>
                                                                            </dl>
                                                                        </form>
                                                                    </div>
                                                                    <input type="hidden" name="adressId" id="save-adressId">
                                                                    <input type="hidden" name="act" id="save-act" value="">
                                                                    <div class="align-center pop-button">
                                                                        <a href="javascript:void(0)" class="yellowbutton2" id="saveEnBtn">
                                                                            <span>
                                                                                保存地址
                                                                            </span>
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="noshade-pop-bot">
                                                            </div>
                                                        </div>
                                                        <a class="noshade-pop-close" href="javascript:void(0)">
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
                            </div>
                            <a href="http://seller.dhgate.com/mydhgate/order/refund/selleraddress.do?act=pageload&dhpath=10008,40,1408#save-cn-wraper"
                            id="save-chBtn" class="nyroModalCh">
                            </a>
                            <div id="save-cn-wraper" style="display:none">
                                <div id="save-ch">
                                    <table class="noshade-pop-table" style="width:660px;">
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
                                                                    修改退货地址：
                                                                </span>
                                                            </div>
                                                            <div class="noshade-pop-inner">
                                                                <div class="tips-common">
                                                                    <span class="tips-information">
                                                                        如敦煌网收到买家寄回的包裹，我们会将货物寄到您预留的中文退货地址，请您使用中文进行填写。
                                                                    </span>
                                                                </div>
                                                                <div class="box1">
                                                                    <div class="supply-address clearfix">
                                                                        <form action="http://seller.dhgate.com/mydhgate/order/refund/selleraddress.do?act=pageload&dhpath=10008,40,1408#">
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    <span class="color-f00">
                                                                                        *
                                                                                    </span>
                                                                                    收货人姓名：
                                                                                </dt>
                                                                                <dd>
                                                                                    <input type="text" size="40" id="cn-contactname" maxlength="14">
                                                                                    <span class="onShow" id="cn-contactnameTip">
                                                                                        &nbsp;
                                                                                    </span>
                                                                                </dd>
                                                                            </dl>
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    <span class="color-f00">
                                                                                        *
                                                                                    </span>
                                                                                    国家：
                                                                                </dt>
                                                                                <dd>
                                                                                    <select disabled="true">
                                                                                        <option>
                                                                                            China
                                                                                        </option>
                                                                                    </select>
                                                                                    <input name="country" type="hidden" id="cn-country" value="China">
                                                                                </dd>
                                                                            </dl>
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    <span class="color-f00">
                                                                                        *
                                                                                    </span>
                                                                                    省或直辖市：
                                                                                </dt>
                                                                                <dd>
                                                                                    <select id="cn-province" onchange="changeProvince(this.value);">
                                                                                        <option value="">
                                                                                            -请选择省市-
                                                                                        </option>
                                                                                        <option value="64C1EDCCA357BC5BE040007F01004020">
                                                                                            上海市
                                                                                        </option>
                                                                                        <option value="64C1EDCCA367BC5BE040007F01004020">
                                                                                            云南省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA354BC5BE040007F01004020">
                                                                                            内蒙古
                                                                                        </option>
                                                                                        <option value="64C1EDCCA365BC5BE040007F01004020">
                                                                                            北京市
                                                                                        </option>
                                                                                        <option value="64C1EDCCA372BC5BE040007F01004020">
                                                                                            台湾省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA35BBC5BE040007F01004020">
                                                                                            吉林省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA35FBC5BE040007F01004020">
                                                                                            四川省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA366BC5BE040007F01004020">
                                                                                            天津市
                                                                                        </option>
                                                                                        <option value="64C1EDCCA364BC5BE040007F01004020">
                                                                                            宁夏
                                                                                        </option>
                                                                                        <option value="64C1EDCCA369BC5BE040007F01004020">
                                                                                            安徽省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA355BC5BE040007F01004020">
                                                                                            山东省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA36FBC5BE040007F01004020">
                                                                                            山西省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA368BC5BE040007F01004020">
                                                                                            广东省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA35DBC5BE040007F01004020">
                                                                                            广西
                                                                                        </option>
                                                                                        <option value="64C1EDCCA36ABC5BE040007F01004020">
                                                                                            新疆
                                                                                        </option>
                                                                                        <option value="64C1EDCCA371BC5BE040007F01004020">
                                                                                            江苏省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA36CBC5BE040007F01004020">
                                                                                            江西省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA370BC5BE040007F01004020">
                                                                                            河北省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA362BC5BE040007F01004020">
                                                                                            河南省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA358BC5BE040007F01004020">
                                                                                            浙江省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA375BC5BE040007F01004020">
                                                                                            海南省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA36DBC5BE040007F01004020">
                                                                                            湖北省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA35ABC5BE040007F01004020">
                                                                                            湖南省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA374BC5BE040007F01004020">
                                                                                            澳门
                                                                                        </option>
                                                                                        <option value="64C1EDCCA356BC5BE040007F01004020">
                                                                                            甘肃省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA35CBC5BE040007F01004020">
                                                                                            福建省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA360BC5BE040007F01004020">
                                                                                            西藏
                                                                                        </option>
                                                                                        <option value="64C1EDCCA361BC5BE040007F01004020">
                                                                                            贵州省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA36EBC5BE040007F01004020">
                                                                                            辽宁省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA36BBC5BE040007F01004020">
                                                                                            重庆市
                                                                                        </option>
                                                                                        <option value="64C1EDCCA363BC5BE040007F01004020">
                                                                                            陕西省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA35EBC5BE040007F01004020">
                                                                                            青海省
                                                                                        </option>
                                                                                        <option value="64C1EDCCA373BC5BE040007F01004020">
                                                                                            香港
                                                                                        </option>
                                                                                        <option value="64C1EDCCA359BC5BE040007F01004020">
                                                                                            黑龙江省
                                                                                        </option>
                                                                                    </select>
                                                                                    <span class="onShow" id="cn-provinceTip">
                                                                                        &nbsp;
                                                                                    </span>
                                                                                </dd>
                                                                            </dl>
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    <span class="color-f00">
                                                                                        *
                                                                                    </span>
                                                                                    城市：
                                                                                </dt>
                                                                                <dd>
                                                                                    <select name="citystate" id="cn-city">
                                                                                        <option>
                                                                                            -请选择-
                                                                                        </option>
                                                                                    </select>
                                                                                    <span class="onShow" id="cn-cityTip">
                                                                                        &nbsp;
                                                                                    </span>
                                                                                </dd>
                                                                            </dl>
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    <span class="color-f00">
                                                                                        *
                                                                                    </span>
                                                                                    详细地址：
                                                                                </dt>
                                                                                <dd>
                                                                                    <input type="text" size="40" id="cn-address" maxlength="50">
                                                                                    <span class="onShow" id="cn-addressTip">
                                                                                        &nbsp;
                                                                                    </span>
                                                                                </dd>
                                                                            </dl>
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    <span class="color-f00">
                                                                                        *
                                                                                    </span>
                                                                                    邮政编码：
                                                                                </dt>
                                                                                <dd>
                                                                                    <input type="text" size="40" id="cn-postcode" maxlength="6">
                                                                                    <span class="onShow" id="cn-postcodeTip">
                                                                                        &nbsp;
                                                                                    </span>
                                                                                </dd>
                                                                            </dl>
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    <span class="color-f00">
                                                                                        *
                                                                                    </span>
                                                                                    联系电话：
                                                                                </dt>
                                                                                <dd>
                                                                                    <input type="text" size="40" id="cn-tel-phone" maxlength="30">
                                                                                    <span class="onShow" id="cn-phoneTip">
                                                                                        &nbsp;
                                                                                    </span>
                                                                                </dd>
                                                                            </dl>
                                                                            <dl class="clearfix">
                                                                                <dt>
                                                                                    手机号码：
                                                                                </dt>
                                                                                <dd>
                                                                                    <input type="text" size="40" id="cn-mobile" maxlength="11">
                                                                                    <span class="onShow" id="cn-mobileTip">
                                                                                        &nbsp;
                                                                                    </span>
                                                                                </dd>
                                                                            </dl>
                                                                        </form>
                                                                    </div>
                                                                    <div class="align-center pop-button">
                                                                        <input type="hidden" id="cn-adressId" value="" name="adressId">
                                                                        <input type="hidden" id="cn-act" name="act">
                                                                        <a href="javascript:void(0)" class="yellowbutton2" id="saveCnBtn">
                                                                            <span>
                                                                                保存地址
                                                                            </span>
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="noshade-pop-bot">
                                                            </div>
                                                        </div>
                                                        <a class="noshade-pop-close" href="javascript:void(0)">
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
                            </div>
                        </div>
                    </div>
                </div>
				<#-- left bar -->
  				${screens.render("component://portal/widget/SellerScreens.xml#setsLeft")}
            </div>
        </div>