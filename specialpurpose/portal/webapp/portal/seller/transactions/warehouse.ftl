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
<link rel="stylesheet" type="text/css" href="../seller/css/eyb-delivery.css">
<div class="content"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/sellerordmng/orderList/list.do?params.linkType=102&amp;dhpath=10002,06,0601">交易</a><span>&gt;</span><a href="/logistics/onlinedeliveryinfo/findOnlineDeliveryList.do?onlineDelivery.status=0&amp;dhpath=10002,05,0501">在线物流</a><span>&gt;</span><a href="/logistics/setofgoods/findDeliveryListByStatus.do?onlineDelivery.wareHouseStatus=12&amp;dhpath=10002,05,0502">仓库发货</a><span>&gt;</span>
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/sellerordmng/orderList/list.do?params.linkType=102&amp;dhpath=10002,06,0601">交易</a><span>&gt;</span><a href="/logistics/onlinedeliveryinfo/findOnlineDeliveryList.do?onlineDelivery.status=0&amp;dhpath=10002,05,0501">在线物流</a><span>&gt;</span><a href="/logistics/setofgoods/findDeliveryListByStatus.do?onlineDelivery.wareHouseStatus=12&amp;dhpath=10002,05,0502">仓库发货</a><span>&gt;</span>仓库发货 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="content">
        <div class="layout clearfix">
          <div class="col-main">
            <div class="col-main-warp">
              <div id="right">
                <!-- 右侧始内容 开始 -->
                <div class="page-topic e-top-title clearfix"> <span class="c-question"><a href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0409&amp;artid=DBB4EA64A8DC9946E04010AC0C6446F9" target="_blank">如何使用仓库发货？</a></span>
                  <h2>仓库发货</h2>
                </div>
                <!-- 温馨提示 开始 -->
                <div class="col-sailtips"> <span class="leftcol-tip">温馨提示：</span>
                  <div class="rightcol-tip">
                    <p>1.仓库发货流程：在线申请仓库发货<span class="e-text-fam">→</span>自行发货至仓库<span class="e-text-fam">→</span>支付国际运费<span class="e-text-fam">→</span>仓库发货；<br>
                      2.请您自行发货至最近的仓库，仓库收到货物后，会通过电子邮件通知您交纳国际物流运费，请您及时支付运费以免延误发货时间。</p>
                    <p style="display: none;" id="hideUpDownBox">3.多个订单同一收货人，只需通过其中一个订单申请在线发货即可，待取得国际运单号之后，请在24小时内将国际单号填写到相应的多个订单中；（申请时，每个订单所对应的商品信息请填写在备注中）<br>
                      4.使用同一国内快递包裹，运输多个订单货物到仓库，请将每个订单单独包装完整，并在包装上标注订单号，再打包整体发往仓库；<br>
                      5.货物名称请勿填写为礼物（GIFT）。 </p>
                  </div>
                  <span id="viewTipsBtn" class="viewshow">展开</span> </div>
                <div id="takeStoreWrap">
                  <ul class="c-store-tab clearfix">
                    <li class="current"><span onclick="window.location.href='/logistics/setofgoods/findDeliveryListByStatus.do?onlineDelivery.wareHouseStatus=12'">等待仓库收货</span></li>
                    <li><span onclick="window.location.href='/logistics/setofgoods/findDeliveryListByStatus.do?onlineDelivery.wareHouseStatus=14'">等待支付运费</span></li>
                    <li><span onclick="window.location.href='/logistics/setofgoods/findDeliveryListByStatus.do?onlineDelivery.wareHouseStatus=16'">等待仓库发货</span></li>
                    <li><span onclick="window.location.href='/logistics/setofgoods/findDeliveryListByStatus.do?onlineDelivery.wareHouseStatus=20'">仓库已发货</span></li>
                  </ul>
                  <!--等待仓库收货 内容-->
                  <div style="display: block;" class="c-store-main">
                    <form id="deliveryListForm" method="post" action="/logistics/setofgoods/findDeliveryListByStatus.do">
                      <input id="type" name="type" type="hidden">
                      <input name="onlineDelivery.wareHouseStatus" value="12" type="hidden">
                      <input id="deliveryId" name="onlineDelivery.deliveryId" value="" type="hidden">
                      <input id="rfxNO" name="onlineDelivery.rfxno" value="" type="hidden">
                      <input id="intTrackNo" name="onlineDelivery.intTrackNo" value="" type="hidden">
                      <input id="inlandTrackNo" name="onlineDelivery.inlandTrackNo" value="" type="hidden">
                      <div class="e-invoice">
                        <select id="selectParam" class="e-invoice-select">
                          <option value="1">物流编号</option>
                          <option value="2">订单编号</option>
                          <option value="3">国际运单号</option>
                          <option value="4">国内运单号</option>
                        </select>
                        <input id="selectValue" class="e-invoice-input" size="30" type="text">
                        <span class="yellowBtn valmiddle">
                        <input class="e-text-fam" onclick="selectJiHuoList();" value="搜 索" type="button">
                        </span> </div>
                      <div class="e-invoice-list">
                        <table cellSpacing="0" cellPadding="0" width="100%">
                          <thead>
                            <tr>
                              <th width="20%">物流编号</th>
                              <th width="20%">订单编号</th>
                              <th width="20%">仓库名称</th>
                              <th class="text-left" width="20%">国内运单号</th>
                              <th width="20%">操作</th>
                            </tr>
                          </thead>
                          <tbody>
                          </tbody>
                        </table>
                        <div class="e-no-info">您暂时没有等待仓库收货信息</div>
                      </div>
                    </form>
                  </div>
                </div>
                <!-- 右侧始内容 结束 -->
                <div class="studybox">
                  <!-- <span class="studyicon">仓库发货使用不方便？</span><a href="http://ued.dhgate.com/dhsurvey/index.php?sid=31466&lang=zh-Hans" target="_blank">我要提意见</a>-->
                </div>
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
