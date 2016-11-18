<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery-1.5.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="../seller/css/seller.css">
<link rel="stylesheet" type="text/css" href="../seller/css/common20111215.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/jquery-calendar.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/my-products.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/syi_pop.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/seller_button.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/general_popup_box.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/product.css">
<link rel="stylesheet" type="text/css" href="../seller/css/relatedproduct.css">
<link rel="stylesheet" type="text/css" href="../seller/css/menu-common_20111226.js">
<div class="content">
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/sellerordmng/orderList/list.do?params.linkType=102&amp;dhpath=10002,06,0601">交易</a><span>&gt;</span><a href="/mydhgate/mybuyer/mybuyer.do?dhpath=10002,04,0401">我的买家</a><span>&gt;</span>买家黑名单 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="col-main-warp">
        <div id="right">
          <div class="common_tab">
            <ul>
              <li class="common_tab_current"><a href="/mydhgate/mybuyer/mybuyer.do"><span> 买家黑名单 </span></a></li>
            </ul>
          </div>
          <div style='background: url("http://image.dhgate.com/2008/web20/seller/img/bg_buyer.gif") no-repeat; height: 36px; line-height: 38px; padding-left: 102px;'>您可以通过我的买家，整体了解并管理买家的交易状况，帮助您开展营销推广，即时发送相关信息。<a href="http://cs.dhgate.com/announce/610.html" target="_blank">查看详情</a></div>
          <form id="mybuyerformid" method="post" name="MybuyerForm" action="/mydhgate/mybuyer/mybuyer.do">
            <input id="selectedBuyerIds" name="selectedBuyerIds" value="" type="hidden">
            <!-- 添加群发按钮 start -->
            <div class="our_button clearfix">
              <div style="float: right;"> 排序查看：
                <select id="orderbycount" onchange="orderbyrfxcount()" class="oSelect1" size="1" name="orderbycount">
                  <option value="0">选择交易次数</option>
                  <option value="1">低到高</option>
                  <option value="2">高到低</option>
                </select>
                <select id="orderbyGMV" onchange="orderbygmv()" class="oSelect2" size="1" name="orderbyGMV">
                  <option value="0">选择交易总额数</option>
                  <option value="1">低到高</option>
                  <option value="2">高到低</option>
                </select>
              </div>
            </div>
            <!-- 添加群发按钮 end -->
            <table border="1" cellSpacing="0" borderColor="#c8d9e9" cellPadding="0" width="100%">
              <tbody>
                <tr class="bbg">
                  <td width="40"><input value="" type="checkbox"></td>
                  <td width="70">买家</td>
                  <td>昵称</td>
                  <td>买家级别</td>
                  <td>信用度</td>
                  <td>12个月内好评率</td>
                  <td>交易次数</td>
                  <td>交易总金额</td>
                  <td>最后一次交易时间</td>
                  <td>操作</td>
                  <td>备注</td>
                </tr>
              </tbody>
            </table>
            <div id="page"> </div>
            <div style="display: none;" id="basicModalContent">
              <table class="listtext" border="0" cellSpacing="1" cellPadding="0">
                <tbody>
                  <tr>
                    <td class="top" colSpan="2">备注</td>
                  </tr>
                  <tr>
                    <td colSpan="2"><textarea id="comments" onkeyup="caculate_length()" cols="40" rows="5" name="comments"></textarea>
                    </td>
                  </tr>
                  <tr>
                    <td class="buttle"><div id="body_length"><span class="red">最多输入字符数为500</span></div></td>
                    <td class="buttri" align="right"><input onclick="saveComments()" name="Submit" value="提交" type="button">
                      <input class="modalClose" name="Submit2" value="取消 " type="button">
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
            <div style="display: none;" id="basicModalNickname">
              <div style="padding-top: 8px;" class="tc_main">
                <div class="tc_content">
                  <table border="0" cellSpacing="0" cellPadding="0" width="400">
                    <tbody>
                      <tr>
                        <td height="6" colSpan="2"></td>
                      </tr>
                      <tr>
                        <td width="45%" align="right">买家名称：</td>
                        <td id="nickname"></td>
                      </tr>
                      <tr>
                        <td align="right">昵称：</td>
                        <td><input id="mybuyernicknameid" name="mybuyernickname" size="9" type="text"></td>
                      </tr>
                      <tr>
                        <td height="36" colSpan="2" align="center"><button onclick="saveNickname()" type="button"><span class="button1_lt"><span class="button1_ri">提 交</span></span></button>
                             
                          <button class="modalClose" typpe="buttong"><span class="button2_lt "><span class="button2_ri">取 消</span></span></button></td>
                      </tr>
                      <tr>
                        <td height="6" colSpan="2"></td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
            <div style="width: 366px; display: none;" id="removeBlackList" class="tc_warp">
              <div class="tc_title">
                <dl>
                  <dt>移出黑名单</dt>
                  <dd> </dd>
                </dl>
              </div>
              <div class="tc_main">
                <div class="tc_content">
                  <div class="box1">
                    <p style="text-align: left;" class="clear">将买家移出黑名单后，该买家将进入我的买家中，交易不受任何限制。确实要将买家&nbsp;&nbsp;<span id="removeBuyerId"></span>&nbsp;&nbsp;移出黑名单吗？</p>
                    <div class="tc_content_button center">
                      <button onclick="removeBuyer();" type="button"><span style="color: rgb(255, 255, 255);" class="button1_lt"><span class="button1_ri">确认提交</span></span></button>
                        
                      <button class="modalClose" type="button"><span style="color: rgb(0, 0, 0);" class="button2_lt"><span class="button2_ri">关闭</span></span></button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <input id="act" name="act" value="pageload" type="hidden">
            <input id="buyerid" name="buyerid" value="" type="hidden">
            <input id="inpcomments" name="inpcomments" value="" type="hidden">
            <input id="inpmybuyernickname" name="inpmybuyernickname" value="" type="hidden">
            <input id="lastpage" name="lastpage" value="" type="hidden">
            <input id="isBlackBuyer" name="isBlackBuyer" value="1" type="hidden">
            <input id="inpBlackReason" name="inpBlackReason" value="" type="hidden">
          </form>
          <form id="answer1" method="POST" action="/messageweb/loadmessagetobuller.do">
            <input name="dhpath" value="10005,0301" type="hidden">
            <input name="_M" value="5" type="hidden">
            <input id="fromurl" name="fromurl" type="hidden">
            <input name="msgtype" value="4" type="hidden">
            <input id="to" name="to" type="hidden">
            <input id="parm" name="parm" type="hidden">
            <input id="k" name="K" type="hidden">
          </form>
          <form id="answer2" method="POST" action="/messageweb/batchsendpage.do">
            <input name="dhpath" value="10005,0301" type="hidden">
            <input name="msgtype" value="4" type="hidden">
            <input id="tosysids" name="tosysids" type="hidden">
          </form>
          <script type="text/javascript" src="http://image.dhgate.com/dhs/mos/js/vip.js"></script>
          <link rel="stylesheet" type="text/css" href="http://image.dhgate.com/dhs/mos/css/vip.css">
          <div style="display: none; visibility: hidden;" id="vipContent">
            <div class="vippop">
              <div class="helppane_right"></div>
              <p><strong class="fl">VIP买家<span class="color3">新增如下特权</span></strong><a class="closepop closeme" href="javascript:void(0);"></a></p>
              <p>金银牌买家给卖家的Feedback打分翻倍计算</p>
              <p><a class="fl" href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0701&amp;artid=792EC2EE9187CC68E0400A0A2B0A2BD8" target="_blank">查看详情&gt;&gt;</a><a class="closeme" href="javascript:void(0);">我知道啦！</a></p>
            </div>
          </div>
          <script type="text/javascript">
	$(document).ready(function() {
		var viphover = new VipicoHover();
		$("#vipContent").css({visibility: "hidden"});
		$(".tc_warp").hide();
	});
</script>
        </div>
      </div>
    </div>
    
	<#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#orderLeftbar")}

  </div>
</div>
