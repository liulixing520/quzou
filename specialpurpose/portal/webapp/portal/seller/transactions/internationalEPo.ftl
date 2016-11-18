<SCRIPT type=text/javascript src="http://www.dhresource.com/seller/js/common.js"></SCRIPT>
<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery-1.5.1.min.js"></script>
<SCRIPT type=text/javascript src="http://stats.g.doubleclick.net/dc.js" async="true"></SCRIPT>
<SCRIPT type=text/javascript src="http://image.dhgate.com/dhs/mos/js/public/menu-common_20111226.js"></SCRIPT>
<SCRIPT type=text/javascript src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery.simplemodal2.js?ver=2012-09-27"></SCRIPT>
<LINK rel=stylesheet type=text/css href="../seller/css/seller.css">
<LINK rel=stylesheet type=text/css href="../seller/css/common20111215.css">
<LINK rel=stylesheet type=text/css href="../seller/css/eyb-delivery.css">
<!--E邮宝 新加的样式-->
<SCRIPT type=text/javascript src="http://www.dhresource.com/dhs/mos/js/eyb/e-listpage.js"></SCRIPT>
<!--E邮宝 新加的脚本-->
<SCRIPT type=text/javascript> <!--E邮宝 新加的脚本-->
<!--
$(document).ready(function(){
	hideTicpBox("viewTips","hideTipsBox");
	var oneshow = showbox('takeStoreWrap', 'c-store-tab', 'c-store-main');
});
var deliveryList = new Object();
//相应点击查询按钮
deliveryList.searchList = function(){
	if($("#selectValue").val() == ""){
		alert("请填写查询内容！");
		return;
	}
	if($.trim($("#selectParam").val()) == "1"){
		$("#searchRfxid").val($.trim($("#selectValue").val()));
	}
	$("#deliveryListForm").submit();
}
-->
</SCRIPT>
<div class="content">
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/sellerordmng/orderList/list.do?params.linkType=102&amp;dhpath=10002,06,0601">交易</a><span>&gt;</span><a href="/logistics/onlinedeliveryinfo/findOnlineDeliveryList.do?onlineDelivery.status=0&amp;dhpath=10002,05,0501">在线物流</a><span>&gt;</span><a href="/logistics/onlinedeliveryinfo/findOnlineDeliveryList.do?onlineDelivery.status=0&amp;dhpath=10002,05,0501">国际E邮宝</a><span>&gt;</span>国际E邮宝-epacket </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="content">
        <div class="layout clearfix">
          <div class="col-main">
            <div class="col-main-warp">
              <div id="right">
                <!-- 右侧始内容 开始 -->
                <div class="page-topic e-top-title clearfix"> <span class="c-question"><a href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0409&amp;artid=DBCC9DD3A3CCD283E04010AC0C642B36" target="_blank">如何使用国际E邮宝？</a></span>
                  <h2>国际E邮宝</h2>
                </div>
                <div style="margin-top: 10px;" id="takeStoreWrap">
                  <ul class="c-store-tab clearfix">
                    <li class="current"><span onclick="window.location.href='/logistics/onlinedeliveryinfo/findOnlineDeliveryList.do?onlineDelivery.status=0'">待发货发货单</span></li>
                    <li><span onclick="window.location.href='/logistics/onlinedeliveryinfo/findOnlineDeliveryList.do?onlineDelivery.status=1'">已发货发货单</span></li>
                  </ul>
                  <!--待发货发货单 内容-->
                  <div style="display: block;" class="c-store-main">
                    <form id="deliveryListForm" method="post" action="/logistics/onlinedeliveryinfo/findOnlineDeliveryList.do">
                      <input id="type" name="type" type="hidden">
                      <input id="page" name="page" type="hidden">
                      <input name="onlineDelivery.status" value="0" type="hidden">
                      <input id="searchRfxid" name="onlineDelivery.rfxno" value="" type="hidden">
                      <div class="e-invoice"> 查询发货单：
                        <select id="selectParam" class="e-invoice-select">
                          <option value="1">订单号</option>
                        </select>
                        <input id="selectValue" class="e-invoice-input" value="" size="40" type="text">
                        <span class="yellowBtn valmiddle">
                        <input onclick="deliveryList.searchList();" value="搜 索" type="button">
                        </span> </div>
                    </form>
                    <div class="e-invoice-list">
                      <table cellSpacing="0" cellPadding="0" width="100%">
                        <thead>
                          <tr>
                            <th width="18%">运单号</th>
                            <th width="17%">订单号</th>
                            <th width="15%">申请日期</th>
                            <th width="15%">交运方式</th>
                            <th width="15%">运单状态</th>
                            <th width="20%">操作</th>
                          </tr>
                        </thead>
                        <tbody>
                        </tbody>
                      </table>
                      <div class="e-no-info">您暂时没有
                        待发货单
                        信息</div>
                    </div>
                    <div class="commonpage"> </div>
                  </div>
                </div>
                <div class="studybox"> <span class="studyicon">国际E邮宝使用不方便？</span><a href="http://survey.dhgate.com/index.php?sid=46173&amp;lang=zh-Hans" target="_blank">我要提意见</a> </div>
                <!-- 右侧始内容 结束 -->
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    
	<#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#orderLeftbar")}


  </div>
</div>
