<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0064)http://seller.dhgate.com/merchant/lianxi.do?dhpath=10008,14,1404
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
            商户信息
        </title>
        <meta charset="utf-8">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="no-cache">
        <meta http-equiv="Expires" content="-1">
        <meta http-equiv="Cache-Control" content="no-cache">
        <link href="../seller/css/setauthentication.css" rel="stylesheet" type="text/css">
        <script type="text/javascript">
            function setSelect(selectid, value) {
                var selObj = document.getElementById(selectid);
                if (selObj) {
                    for (var i = 0; i < selObj.options.length; i++) {
                        if (selObj.options[i].value == value) {
                            selObj.options[i].selected = true;
                            break;
                        }
                    }
                }
            };

            function setInput(inputid, value) {
                var inputObj = document.getElementById(inputid);
                if (inputObj) {
                    inputObj.value = value;
                }
            }

            $(document).ready(function() {
                setSelect('provincestateform', '64C1EDCCA365BC5BE040007F01004020');
                setSelect('citystateform', '');
                //setInput('telareacode', '');
                //设置电话
                var tel = '';
                if (tel) {
                    var tels = tel.split('-');
                    if (tels.length == 3 && 　tels[2] != "null" && tels[2] != "") {
                        setInput('telareacode', tels[1]);
                        setInput('telnum', tels[2]);
                    }
                }
                //设置FAX
                var fax = '';
                if (fax) {
                    var faxs = fax.split('-');
                    if (faxs.length == 3 && 　faxs[2] != "null" && faxs[2] != "") {
                        setInput('faxareacode', faxs[1]);
                        setInput('faxnum', faxs[2]);
                    }
                }
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
                <a href="http://seller.dhgate.com/merchant/changepwd.do?dhpath=10008,31,3101">
                    设置
                </a>
                <span>
                    &gt;
                </span>
                <a href="./商户信息_files/商户信息.htm">
                    资料设置
                </a>
                <span>
                    &gt;
                </span>
                <a href="./商户信息_files/商户信息.htm">
                    商户信息
                </a>
                <span>
                    &gt;
                </span>
                商户信息
            </div>
            <div class="layout clearfix">
                <div class="col-main">
                    <div id="right">
                        <form name="CompanycontactuscontentForm" id="CompanycontactuscontentForm"
                        action="http://seller.dhgate.com/merchant/savelianxi.do" method="post"
                        onsubmit="return Companycontactuscontentforminfo();">
                            <input type="hidden" name="mobilephone" value="18500339022" id="mobilephone">
                            <input type="hidden" name="email" value="sr_meng@sunvsoft.com" id="email">
                            <input type="hidden" name="companytypede" value="24" id="companytypede">
                            <div class="col-boxpd col-linebom">
                                <h2>
                                    商户信息
                                </h2>
                            </div>
                            <div class="col-sailtips clearfix">
                                <span class="leftcol-tip">
                                    温馨提示：
                                </span>
                                <div class="rightcol-tip">
                                    <p id="hideTipsBox" class="addheight">
                                        亲爱的商户，帐号通过身份认证后，您的身份证姓名及身份证号码将不能修改，且为了您的帐户安全，帐号不可以转让、租借哦。只有通过身份认证，产品审核通过后方可被买家看到。
                                    </p>
                                    <span class="viewticps viewshow" id="viewTips" style="">
                                        展开
                                    </span>
                                </div>
                            </div>
                            <div class="setauthtable setauthtable02">
                                <table>
                                    <tbody>
                                        <tr>
                                            <td width="25%" class="txttitle">
                                                <span class="required">
                                                    *
                                                </span>
                                                身份证姓名：
                                            </td>
                                            <td width="75%" class="txtcontent">
                                                <span id="span_fullname">
                                                    <span id="b_fullname">
                                                        韩秋燕
                                                    </span>
                                                    <img src="img/success-icon.png" class="marg-l10 valmiddle">
                                                    <input id="md_fullname" name="md_fullname" type="checkbox" value="1" style="display:none;">
                                                </span>
                                                <span id="span_efullname" style="display:none;">
                                                    <input id="fullname" name="fullname" type="text" size="30" value="韩秋燕">
                                                    <a href="javascript:void(0);" onclick="return modifyRegInfo(&#39;fullname&#39;, false);">
                                                        取消
                                                    </a>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                <span class="required">
                                                    *
                                                </span>
                                                身份证号码：
                                            </td>
                                            <td class="txtcontent">
                                                <span id="span_idcard">
                                                    <span id="b_idcard">
                                                        4111**********2047
                                                    </span>
                                                    <img src="img/success-icon.png" class="marg-l10 valmiddle">
                                                    <input id="md_idcard" name="md_idcard" type="checkbox" value="1" style="display:none;">
                                                </span>
                                                <span id="span_eidcard" style="display:none;">
                                                    <input id="idcard" name="idcard" type="text" size="20" value="4111**********2047">
                                                    <a href="javascript:void(0);" onclick="return modifyRegInfo(&#39;idcard&#39;, false);">
                                                        取消
                                                    </a>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="17%" class="txttitle">
                                                <span class="required">
                                                    *
                                                </span>
                                                用户类型：
                                            </td>
                                            <td width="83%" class="txtcontent">
                                                <span>
                                                    大陆企业
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="25%" class="txttitle">
                                                所在地：
                                            </td>
                                            <td class="txtcontent">
                                                <select class="seta-select" name="countrynameform" id="countrynameform"
                                                onchange="changeCountry(this.value);">
                                                    <option value="CN">
                                                        中国
                                                    </option>
                                                </select>
                                                <select class="seta-select" name="provincestateform" id="provincestateform"
                                                onchange="changeProvince2(this.value);">
                                                    <option value="0">
                                                        --请选择--
                                                    </option>
                                                    <option value="64C1EDCCA354BC5BE040007F01004020">
                                                        内蒙古
                                                    </option>
                                                    <option value="64C1EDCCA355BC5BE040007F01004020">
                                                        山东省
                                                    </option>
                                                    <option value="64C1EDCCA356BC5BE040007F01004020">
                                                        甘肃省
                                                    </option>
                                                    <option value="64C1EDCCA357BC5BE040007F01004020">
                                                        上海市
                                                    </option>
                                                    <option value="64C1EDCCA358BC5BE040007F01004020">
                                                        浙江省
                                                    </option>
                                                    <option value="64C1EDCCA359BC5BE040007F01004020">
                                                        黑龙江省
                                                    </option>
                                                    <option value="64C1EDCCA35ABC5BE040007F01004020">
                                                        湖南省
                                                    </option>
                                                    <option value="64C1EDCCA35BBC5BE040007F01004020">
                                                        吉林省
                                                    </option>
                                                    <option value="64C1EDCCA35CBC5BE040007F01004020">
                                                        福建省
                                                    </option>
                                                    <option value="64C1EDCCA35DBC5BE040007F01004020">
                                                        广西
                                                    </option>
                                                    <option value="64C1EDCCA35EBC5BE040007F01004020">
                                                        青海省
                                                    </option>
                                                    <option value="64C1EDCCA35FBC5BE040007F01004020">
                                                        四川省
                                                    </option>
                                                    <option value="64C1EDCCA360BC5BE040007F01004020">
                                                        西藏
                                                    </option>
                                                    <option value="64C1EDCCA361BC5BE040007F01004020">
                                                        贵州省
                                                    </option>
                                                    <option value="64C1EDCCA362BC5BE040007F01004020">
                                                        河南省
                                                    </option>
                                                    <option value="64C1EDCCA363BC5BE040007F01004020">
                                                        陕西省
                                                    </option>
                                                    <option value="64C1EDCCA364BC5BE040007F01004020">
                                                        宁夏
                                                    </option>
                                                    <option value="64C1EDCCA365BC5BE040007F01004020">
                                                        北京市
                                                    </option>
                                                    <option value="64C1EDCCA366BC5BE040007F01004020">
                                                        天津市
                                                    </option>
                                                    <option value="64C1EDCCA367BC5BE040007F01004020">
                                                        云南省
                                                    </option>
                                                    <option value="64C1EDCCA368BC5BE040007F01004020">
                                                        广东省
                                                    </option>
                                                    <option value="64C1EDCCA369BC5BE040007F01004020">
                                                        安徽省
                                                    </option>
                                                    <option value="64C1EDCCA36ABC5BE040007F01004020">
                                                        新疆
                                                    </option>
                                                    <option value="64C1EDCCA36BBC5BE040007F01004020">
                                                        重庆市
                                                    </option>
                                                    <option value="64C1EDCCA36CBC5BE040007F01004020">
                                                        江西省
                                                    </option>
                                                    <option value="64C1EDCCA36DBC5BE040007F01004020">
                                                        湖北省
                                                    </option>
                                                    <option value="64C1EDCCA36EBC5BE040007F01004020">
                                                        辽宁省
                                                    </option>
                                                    <option value="64C1EDCCA36FBC5BE040007F01004020">
                                                        山西省
                                                    </option>
                                                    <option value="64C1EDCCA370BC5BE040007F01004020">
                                                        河北省
                                                    </option>
                                                    <option value="64C1EDCCA371BC5BE040007F01004020">
                                                        江苏省
                                                    </option>
                                                    <option value="64C1EDCCA372BC5BE040007F01004020">
                                                        台湾省
                                                    </option>
                                                    <option value="64C1EDCCA373BC5BE040007F01004020">
                                                        香港
                                                    </option>
                                                    <option value="64C1EDCCA374BC5BE040007F01004020">
                                                        澳门
                                                    </option>
                                                    <option value="64C1EDCCA375BC5BE040007F01004020">
                                                        海南省
                                                    </option>
                                                </select>
                                                <select class="seta-select" name="citystateform" id="citystateform">
                                                    <option value="0">
                                                        请选择县、市地区等
                                                    </option>
                                                    <option value="64C1EDCCA45EBC5BE040007F01004020">
                                                        房山区
                                                    </option>
                                                    <option value="64C1EDCCA45FBC5BE040007F01004020">
                                                        郊县
                                                    </option>
                                                    <option value="64C1EDCCA460BC5BE040007F01004020">
                                                        其他地区
                                                    </option>
                                                    <option value="64C1EDCCA461BC5BE040007F01004020">
                                                        通州区
                                                    </option>
                                                    <option value="64C1EDCCA462BC5BE040007F01004020">
                                                        顺义区
                                                    </option>
                                                    <option value="64C1EDCCA463BC5BE040007F01004020">
                                                        昌平区
                                                    </option>
                                                    <option value="64C1EDCCA464BC5BE040007F01004020">
                                                        大兴区
                                                    </option>
                                                    <option value="64C1EDCCA455BC5BE040007F01004020">
                                                        东城区
                                                    </option>
                                                    <option value="64C1EDCCA456BC5BE040007F01004020">
                                                        西城区
                                                    </option>
                                                    <option value="64C1EDCCA457BC5BE040007F01004020">
                                                        崇文区
                                                    </option>
                                                    <option value="64C1EDCCA458BC5BE040007F01004020">
                                                        宣武区
                                                    </option>
                                                    <option value="64C1EDCCA459BC5BE040007F01004020">
                                                        朝阳区
                                                    </option>
                                                    <option value="64C1EDCCA45ABC5BE040007F01004020">
                                                        丰台区
                                                    </option>
                                                    <option value="64C1EDCCA45BBC5BE040007F01004020">
                                                        石景山区
                                                    </option>
                                                    <option value="64C1EDCCA45CBC5BE040007F01004020">
                                                        海淀区
                                                    </option>
                                                    <option value="64C1EDCCA45DBC5BE040007F01004020">
                                                        门头沟区
                                                    </option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                电子邮件：
                                            </td>
                                            <td class="txtcontent">
                                                sr_meng@sunvsoft.com
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                手机：
                                            </td>
                                            <td class="txtcontent">
                                                18500339022
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                性别：
                                            </td>
                                            <td class="txtcontent">
                                                <input name="gender" id="gender" value="M" class="marg-r5" type="radio">
                                                <span class="spantitle">
                                                    男
                                                </span>
                                                <input class="marg-r5" type="radio" name="gender" id="gender" value="F">
                                                <span class="spantitle">
                                                    女
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                详细地址：
                                            </td>
                                            <td class="txtcontent">
                                                <input class="seta-text addwid330" type="text" name="mailingaddress" maxlength="50"
                                                id="mailingaddress" value="">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                邮编：
                                            </td>
                                            <td class="txtcontent">
                                                <input class="seta-text addwid130" type="text" name="zipinfo" maxlength="6"
                                                id="zipinfo" value="">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                电话：
                                            </td>
                                            <td class="txtcontent">
                                                <input class="seta-text addwid40 disabled" disabled="disabled" value="+86"
                                                type="text" name="telcountrycode" id="telcountrycode" maxlength="4" size="5">
                                                <input value="区号" class="seta-text addwid50 marg-r10 df-color" type="text"
                                                id="telareacode" maxlength="4" size="5" name="telareacode" onblur="javascrpit:checktelareacode();"
                                                onfocus="focusInput(this,&#39;区号&#39;);">
                                                <input value="电话号码" class="seta-text addwid170 marg-r10 df-color" type="text"
                                                id="telnum" maxlength="13" size="17" name="telnum" onblur="javascrpit:checktelnum();"
                                                onfocus="focusInput(this,&#39;电话号码&#39;);">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                传真：
                                            </td>
                                            <td class="txtcontent">
                                                <input class="seta-text addwid40 disabled" disabled="disabled" value="+86"
                                                type="text" id="faxcountrycode" maxlength="4" size="5" name="faxcountrycode">
                                                <input value="区号" class="seta-text addwid50 marg-r10 df-color" type="text"
                                                id="faxareacode" maxlength="4" size="5" name="faxareacode" onblur="javascrpit:checkfaxareacode();"
                                                onfocus="focusInput(this,&#39;区号&#39;);">
                                                <input value="电话号码" class="seta-text addwid170 marg-r10 df-color" type="text"
                                                id="faxnum" maxlength="13" size="17" name="faxnum" onblur="javascrpit:checkfaxnum();"
                                                onfocus="focusInput(this,&#39;电话号码&#39;);">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                MSN：
                                            </td>
                                            <td class="txtcontent">
                                                <input class="seta-text addwid130" type="text" name="msn" maxlength="50"
                                                id="msn" value="">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                                QQ：
                                            </td>
                                            <td class="txtcontent">
                                                <input class="seta-text addwid130" type="text" name="qq" maxlength="15"
                                                d="qq" value="">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="txttitle">
                                            </td>
                                            <td class="txtcontent02">
                                                <span class="btBtn">
                                                    <input value="保存信息" type="submit" id="buttonsave">
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
                    <script type="text/javascript" src="js/baseinfo.js">
                    </script>
                </div>
				<#-- left bar -->
  				${screens.render("component://portal/widget/SellerScreens.xml#setsLeft")}
            </div>
        </div>