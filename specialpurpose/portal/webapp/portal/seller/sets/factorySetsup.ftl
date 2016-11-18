<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0069)http://seller.dhgate.com/merchant/facpageload.do?dhpath=10008,14,1406
-->
<html xmlns="http://www.w3.org/1999/xhtml">
    <!--buzhidaoshizenmehuishi-->
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" async="" src="../seller/js/dc.js">
        </script>
        <script type="text/javascript" src="js/common.js">
        </script>
        <script type="text/javascript" src="../seller/js/menu-common_20111226.js">
        </script>
        <script type="text/javascript" src="../seller/js/jquery.simplemodal2.js">
        </script>
        <title>
            工厂设置
        </title>
        <meta charset="utf-8">
        <link href="../seller/css/setauthentication.css" rel="stylesheet" type="text/css">
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
                <a href="img/工厂设置.htm">
                    工厂设置
                </a>
                <span>
                    &gt;
                </span>
                工厂设置
            </div>
            <div class="layout clearfix">
                <div class="col-main">
                    <script>
                        $(document).ready(function() {
                            document.getElementById("manufactoryname").value = "";
                            document.getElementById("manufactoryno").value = "";
                            document.getElementById("provincestate").value = "";
                            document.getElementById("industryid").value = "";
                        });
                    </script>
                    <div id="right">
                        <form action="http://seller.dhgate.com/merchant/facpageload.do" name="ManagemanufactorycnForm"
                        id="ManagemanufactorycnForm">
                            <input type="hidden" name="pageno" id="pageno">
                            <div class="col-boxpd col-linebom">
                                <h2>
                                    工厂设置
                                </h2>
                            </div>
                            <div class="rtab-warp">
                                <ul class="clearfix">
                                    <li class="current">
                                        <a href="http://seller.dhgate.com/merchant/facpageload.do?dhpath=10008,14,1406#">
                                            <span>
                                                工厂列表
                                            </span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="autsearchbox">
                                工厂名称：
                                <input type="text" class="seta-text addwid130 marg-r10" value="" name="manufactoryname"
                                id="manufactoryname" />
                                工厂编号：
                                <input type="text" class="seta-text addwid65 marg-r10" value="" name="manufactoryno"
                                id="manufactoryno" />
                                所在城市：
                                <input type="text" class="seta-text addwid65 marg-r10" value="" name="provincestate"
                                id="provincestate" />
                                <select class="seta-select addwid200s marg-r10" name="industryid" id="industryid">
                                    <option value="">
                                        全部
                                    </option>
                                    <option value="1">
                                        Agricultur
                                        <wbr>
                                        e
                                    </option>
                                    <option value="10">
                                        Environmen
                                        <wbr>
                                        t
                                    </option>
                                    <option value="11">
                                        Excess Inventory
                                    </option>
                                    <option value="12">
                                        Food and Beverage
                                    </option>
                                    <option value="13">
                                        Gifts and Crafts
                                    </option>
                                    <option value="14">
                                        Health and Beauty
                                    </option>
                                    <option value="15">
                                        Home Appliances
                                        <wbr>
                                    </option>
                                    <option value="16">
                                        Home Supplies
                                    </option>
                                    <option value="17">
                                        Industrial
                                        <wbr>
                                        Supplies
                                    </option>
                                    <option value="18">
                                        Minerals, Metals and Materials
                                    </option>
                                    <option value="19">
                                        Office Supplies
                                    </option>
                                    <option value="2">
                                        Apparel and Fashion
                                    </option>
                                    <option value="20">
                                        Packaging and Paper
                                    </option>
                                    <option value="21">
                                        Printing and Publishing
                                        <wbr>
                                    </option>
                                    <option value="22">
                                        Security and Protection
                                        <wbr>
                                    </option>
                                    <option value="23">
                                        Sports and Entertainm
                                        <wbr>
                                        ent
                                    </option>
                                    <option value="24">
                                        Telecommun
                                        <wbr>
                                        ications
                                    </option>
                                    <option value="25">
                                        Textiles and Leather Products
                                    </option>
                                    <option value="26">
                                        Toys
                                    </option>
                                    <option value="27">
                                        Transporta
                                        <wbr>
                                        tion
                                    </option>
                                    <option value="3">
                                        Automobile
                                        <wbr>
                                    </option>
                                    <option value="4">
                                        Business Services
                                    </option>
                                    <option value="5">
                                        Chemicals
                                    </option>
                                    <option value="6">
                                        Computer Hardware and Software
                                    </option>
                                    <option value="7">
                                        Constructi
                                        <wbr>
                                        on and Real Estate
                                    </option>
                                    <option value="8">
                                        Electronic
                                        <wbr>
                                        s and Electrical
                                        <wbr>
                                    </option>
                                    <option value="9">
                                        Energy
                                    </option>
                                </select>
                                <span class="yellowBtn valmiddle">
                                    <input type="submit" value="搜 索" name="" />
                                </span>
                            </div>
                            <div class="bg-list">
                                <table width="100%" cellspacing="0" cellpadding="0" border="0" class="suncoins">
                                    <tbody>
                                        <tr>
                                            <th width="20%">
                                                工厂编号
                                            </th>
                                            <th width="35%">
                                                工厂名称
                                            </th>
                                            <th width="15%">
                                                商务电话
                                            </th>
                                            <th width="15%">
                                                手机
                                            </th>
                                            <th width="15%">
                                                操作
                                            </th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--分页 开始-->
                            <!--分页 结束-->
                            <div class="fltrig pad-t20">
                                <span class="btBtn">
                                    <input type="button" value="添加工厂" onclick="JavaScript:window.location.href =&#39;/merchant/addfacinput.do&#39;;return false;">
                                </span>
                            </div>
                        </form>
                        <script language="javascript" type="text/javascript" defer="defer">
                            javascript: (function() {
                                var D = document;
                                F(D.body);
                                function F(n) {
                                    var u, r, c, x;
                                    if (n.nodeType == 3) {
                                        u = n.data.search(/\S{10}/);
                                        if (u >= 0) {
                                            r = n.splitText(u + 10);
                                            n.parentNode.insertBefore(D.createElement("WBR"), r);
                                        }
                                    } else if (n.tagName != "STYLE" && n.tagName != "SCRIPT") {
                                        for (c = 0; x = n.childNodes[c]; ++c) {
                                            F(x);
                                        }
                                    }
                                }
                            })();
                        </script>
                        <script type="text/javascript">
                            function aa() {
                                document.getElementById("manufactoryname").value = "";
                                document.getElementById("manufactoryno").value = "";
                                document.getElementById("provincestate").value = "";
                                document.getElementById("industryid").value = "";
                            }
                        </script>
                    </div>
                </div>
				<#-- left bar -->
  				${screens.render("component://portal/widget/SellerScreens.xml#setsLeft")}
            </div>
        </div>