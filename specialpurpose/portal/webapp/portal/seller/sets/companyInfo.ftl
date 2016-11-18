<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0069)http://seller.dhgate.com/merchant/companyinfo.do?dhpath=10008,14,1402
-->
<html xmlns="http://www.w3.org/1999/xhtml">
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- <link href="../seller/css/seller.css" rel="stylesheet" type="text/css">
        <link href="../seller/css/common20111215.css" rel="stylesheet" type="text/css">
        <link href="../seller/css/general_popup_box.css" rel="stylesheet" type="text/css">
        -->
        <script type="text/javascript" async="" src="../seller/js/dc.js">
        </script>
        <script type="text/javascript" async="" src="../seller/js/dc.js">
        </script>
        <script type="text/javascript" src="../seller/js/common.js">
        </script>
        <script type="text/javascript" src="../seller/js/menu-common_20111226.js">
        </script>
        <script type="text/javascript" src="../seller/js/jquery.simplemodal2.js">
        </script>
        <title>
            公司信息
        </title>
        <meta charset="utf-8">
        <link href="../seller/css/ui.tabs.css" rel="stylesheet" type="text/css">
        <link href="../seller/css/setauthentication.css" rel="stylesheet" type="text/css">
        <script>
            function checkform() {

                var skeyproducts = document.CompanyprofilecontentForm.keyproducts;
                var scompanyintroduction = document.CompanyprofilecontentForm.companyintroduction;
                var syearestablished = document.CompanyprofilecontentForm.yearestablished;
                //alert("请输入核心产品/服务!=="+skeyproducts);
                if (skeyproducts.value.length == 0) {
                    alert("请输入核心产品/服务!");
                    skeyproducts.focus();
                    return false;
                } else if (!checkLength(skeyproducts.value, 200)) {
                    alert("核心产品/服务,字数过多!");
                    skeyproducts.focus();
                    return false;
                }

                if (scompanyintroduction.value.length == 0) {
                    alert("请输入公司介绍!");
                    scompanyintroduction.focus();
                    return false;
                } else if (!checkLength(scompanyintroduction.value, 4000)) {
                    alert("公司介绍,字数过多!");
                    companyintroduction.focus();
                    return false;
                }

                if (syearestablished.value.length != 4) {
                    alert("请输入正确的公司成立年!");
                    syearestablished.focus();
                    return false;
                }

                if (syearestablished.value.length == 4) {
                    if (!isInt(syearestablished.value)) {
                        alert('请输入正确的公司成立年!');
                        return false;
                    }
                }

                document.getElementById('CompanyprofilecontentForm').submit();

            }

            function isInt(s) {
                var patrn = /^([1-9]\d{0,9})$/;
                if (!patrn.exec(s)) return false;
                else return true;
            }

            function checkLength(strContent, maxNum) {
                var totallength = 0;
                for (var i = 0; i < strContent.length; i++) {
                    var str = strContent;
                    var intCode = str.charCodeAt(i);
                    if (intCode >= 0 && intCode <= 128) totallength++;
                    else {
                        if (totallength == 0) totallength += 2;
                        else totallength += 3;
                    }
                }
                if (totallength >= maxNum) return false;
                return true;
            }
            function testjie(obj, maxlimit, type) {
                var len = obj.value.length;

                if (len > maxlimit) {
                    document.getElementById('maxlimitdiv').innerHTML = "已超出100个字";
                } else {
                    if (type == 1) {
                        document.getElementById('maxlimitdiv').innerHTML = "您还可以输入<span class='spantitle'><b>" + parseInt((maxlimit - len)) + "</b>/100</span>个字符";
                    } else {
                        document.getElementById('maxlimitdiv2').innerHTML = "您还可以输入<span class='spantitle'><b>" + parseInt((maxlimit - len)) + "</b>/100</span>个字符";
                    }

                }
            }

            function byteLength(sStr) {
                aMatch = sStr.match(/[^\x00-\x80]/g);
                return (sStr.length + (!aMatch ? 0 : aMatch.length));
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
                <a href="http://seller.dhgate.com/merchant/lianxi.do?dhpath=10008,14,1404">
                    资料设置
                </a>
                <span>
                    &gt;
                </span>
                <a href="./公司信息_files/公司信息.htm">
                    公司信息
                </a>
                <span>
                    &gt;
                </span>
                公司信息
            </div>
            <div class="layout clearfix">
                <div class="col-main">
                    <div id="right">
                        <form name="CompanyprofilecontentForm" id="CompanyprofilecontentForm"
                        action="http://seller.dhgate.com/merchant/savejianjie.do" method="post">
                            <div class="col-boxpd col-linebom">
                                <h2>
                                    公司信息
                                </h2>
                            </div>
                            <div class="setauthtable setauthtable02">
                                <table>
                                    <tbody>
                                        <tr>
                                            <td class="txttitle" width="30%">
                                                公司名称：
                                            </td>
                                            <td class="txtcontent" width="70%">
                                                北京叁角弈软件技术有限公司
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                企业法人：
                                            </td>
                                            <td class="txtcontent">
                                                孟旭东
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                <span class="required">
                                                    *
                                                </span>
                                                公司员工数：
                                            </td>
                                            <td class="txtcontent">
                                                <select class="seta-select" name="employeesnumber">
                                                    <option value="000000000000000000000000000001">
                                                        1000 - 3000 People
                                                    </option>
                                                    <option value="000000000000000000000000000002">
                                                        Over 3000 People
                                                    </option>
                                                    <option value="402880060248f319010248f42f1c0005">
                                                        Less than 5 People
                                                    </option>
                                                    <option value="402880060248f319010248f42f1c0006">
                                                        5 - 10 People
                                                    </option>
                                                    <option value="402880060248f319010248f42f1c0007">
                                                        11 - 50 People
                                                    </option>
                                                    <option value="402880060248f319010248f42f1c0008" selected="">
                                                        51 - 100 People
                                                    </option>
                                                    <option value="402880060248f319010248f42f1c0009">
                                                        500 - 1000 People
                                                    </option>
                                                    <option value="492880060248f319010248f42f1c0006">
                                                        101 - 500 People
                                                    </option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                <span class="required">
                                                    *
                                                </span>
                                                核心产品/服务：
                                            </td>
                                            <td class="txtcontent">
                                                <div class="tareaw clearfix">
                                                    <textarea class="seta-text tareawh" name="keyproducts" onkeyup="testjie(this, 100,1)"
                                                    maxlength="100">
                                                        预付费卡系统、客户忠诚度管理系统、加油站管理系统、清结算平台系统、会员卡系统、银行卡收单系统等等
                                                    </textarea>
                                                    <div class="marg-t10">
                                                        <span class="fltrig spweaken" id="maxlimitdiv">
                                                            您还可以输入
                                                            <span class="spantitle">
                                                                <b>
                                                                    100
                                                                </b>
                                                                /100
                                                            </span>
                                                            个字符
                                                        </span>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                <span class="required">
                                                    *
                                                </span>
                                                公司介绍：
                                            </td>
                                            <td class="txtcontent">
                                                <div class="marg-b5">
                                                    请详细、真实、正确填写有关您公司的产品、服务、历史、成就等信息，不支持HTML格式。
                                                </div>
                                                <div class="tareaw clearfix">
                                                    <textarea class="seta-text tareawh" name="companyintroduction" onkeyup="testjie(this, 100)"
                                                    maxlength="100">
                                                        创建于北京，是一家从事预付费卡系统、客户忠诚度管理系统、加油站管理系统、清结算平台系统、会员卡系统、银行卡收单系统等的专业软件公司。经营各种软件设备，技术培训，技术转让等业务。
                                                    </textarea>
                                                    <div class="marg-t10">
                                                        <span class="fltrig spweaken" id="maxlimitdiv2">
                                                            您还可以输入
                                                            <span class="spantitle">
                                                                <b>
                                                                    100
                                                                </b>
                                                                /100
                                                            </span>
                                                            个字符
                                                        </span>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                年营业额：
                                            </td>
                                            <td class="txtcontent">
                                                <select name="range" class="seta-select">
                                                    <option value="000000000000000000000000000001" selected="">
                                                        US$100 Million - US$300 Million
                                                    </option>
                                                    <option value="000000000000000000000000000002">
                                                        Above US$300 Million
                                                    </option>
                                                    <option value="402880060248f319010248f42f1c0007">
                                                        Below US$1 Million
                                                    </option>
                                                    <option value="402880060248f319010248f42f1c0008">
                                                        US$1 Million - US$2.5 Million
                                                    </option>
                                                    <option value="402880060248f319010248f42f1c0009">
                                                        US$2.5 Million - US$5 Million
                                                    </option>
                                                    <option value="412880060248f319010248f42f1c0006">
                                                        US$50 Million - US$100 Million
                                                    </option>
                                                    <option value="412880060248f319010248f42f1c0007">
                                                        US$10 Million - US$50 Million
                                                    </option>
                                                    <option value="412880060248f319010248f42f1c0008">
                                                        US$5 Million - US$10 Million
                                                    </option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                <span class="required">
                                                    *
                                                </span>
                                                公司成立年：
                                            </td>
                                            <td class="txtcontent">
                                                <input class="seta-text addwid130" type="text" name="yearestablished"
                                                value="2011" id="yearestablishedid">
                                                <span class="setaprompt">
                                                    （例如:1952）
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                            </td>
                                            <td class="txtcontent02">
                                                <span class="btBtn">
                                                    <input value="保存" name="button" type="button" onclick="javascript:checkform()">
                                                </span>
                                                <font color="#FF0000">
                                                </font>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </form>
                    </div>
                    <!-- Google Analytics Tracking Code - 20111206 - START -->
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
                    <!-- Google Analytics Tracking Code - 20111206 - END -->
                    <script type="text/javascript">
                        try {
                            var pageTracker = _gat._getTracker("UA-425001-1");
                            pageTracker._setDomainName(".dhgate.com");
                            pageTracker._setAllowHash("false");
                            pageTracker._trackPageview(location.pathname + location.search + escape(location.hash));
                        } catch(err) {}
                    </script>
                </div>
				<#-- left bar -->
  				${screens.render("component://portal/widget/SellerScreens.xml#setsLeft")}
            </div>
        </div>