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
<link rel="stylesheet" type="text/css" href="../seller/css/orderList.css">
<div class="content">
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/sellerordmng/orderList/list.do?params.linkType=102&amp;dhpath=10002,06,0601">交易</a><span>&gt;</span><a href="http://seller.dhgate.com/sellerordmng/orderList/list.do?params.linkType=102&amp;dhpath=10002,06,0601">我的订单</a><span>&gt;</span><a href="/sellerordmng/orderList/disputeOrderList.do?params.linkType=200&amp;dhpath=10002,06,0602">纠纷订单</a><span>&gt;</span>全部纠纷中订单
    <!--<p class="increment-serve">增值服务专享客服电话：<strong>400-706-6600</strong></p>-->
  </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="col-main-warp">
        <div id="right">
          <div class="page-topic clearfix">
            <h2>纠纷订单</h2>
            <span class="return-link"> <a href="http://seller.dhgate.com/help/seller-help/c0302/a87001.html" target="_blank">新版订单帮助</a> </span> </div>
          <div class="order-type">
            <div class="order-type-list first-line"> <strong>纠纷中订单：</strong> <a href="/sellerordmng/orderList/disputeOrderList.do?params.linkType=201">协议纠纷<em>(0)</em></a> <a href="/sellerordmng/orderList/disputeOrderList.do?params.linkType=202">平台纠纷<em>(0)</em></a> <a href="/sellerordmng/orderList/disputeOrderList.do?params.linkType=203">售后纠纷<em>(0)</em></a> </div>
            <div class="order-type-list"> <strong>纠纷关闭订单：</strong> <a href="/sellerordmng/orderList/disputeOrderList.do?params.linkType=204">90天内纠纷关闭<em>(0)</em></a> </div>
          </div>
          <div style="overflow: hidden;" id="J_searchWarp" class="search-warp">
            <form id="orderQueryForm" method="GET" name="orderQueryForm" action="/sellerordmng/orderList/disputeOrderList.do">
              <input name="params.linkType" value="205" type="hidden">
              <div class="search-condition">
                <ul class="clearfix">
                  <li><span>订单号：</span>
                    <input class="input1" name="params.orderNo" value="" type="text">
                  </li>
                  <li><span>买家名称：</span>
                    <input class="input1" name="params.buyerName" value="" type="text">
                  </li>
                  <li><span>纠纷类型：</span>
                    <select name="params.orderStatus">
                      <option value="200">全部纠纷中订单</option>
                      <option value="201">协议纠纷中订单</option>
                      <option value="202">平台纠纷中订单</option>
                      <option value="203">售后纠纷中订单</option>
                      <option value="204">纠纷关闭订单</option>
                    </select>
                  </li>
                </ul>
              </div>
              <div class="search-operate"> <a id="J_SearchBtn" class="greybutton2" href="javascript:;"><span>搜 索</span></a> </div>
            </form>
          </div>
          <div class="rtab-warp">
            <ul class="clearfix">
              <li class="current"><span>全部纠纷中订单</span></li>
            </ul>
          </div>
          <div id="J_OrderContent">
            <div class="sixcols">
              <div class="order-list-title">
                <table>
                  <tbody>
                    <tr>
                      <th class="col1  multiple ">产品</th>
                      <th class="col2">产品数量</th>
                      <th class="col3">订单金额</th>
                      <th class="multi-col">纠纷开启时间</th>
                      <th class="col4">状态</th>
                      <th class="col5">操作</th>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="order-list-warp">
                <div class="without-remind">您暂时没有符合条件的订单，请更改条件后重试。</div>
              </div>
            </div>
          </div>
          <!--翻页form-->
          <form id="orderQueryPageForm" method="GET" name="orderQueryPageForm" action="/sellerordmng/orderList/disputeOrderList.do">
            <input name="params.linkType" value="200" type="hidden">
            <input id="page" name="params.page" value="1" type="hidden">
            <input id="params_orderDateFilter" name="params.orderDateFilter" type="hidden">
            <input id="params_orderStatusFilter" name="params.orderStatusFilter" type="hidden">
            <input id="params_orderSort" name="params.orderSort" value="08;0" type="hidden">
            <input id="params_notracking" name="params.notracking" value="1" type="hidden">
          </form>
          <!-- tracking信息跟踪 Start-->
          <script type="text/javascript" src="http://www.dhresource.com/dhs/fob/js/common/track/dhta.js"></script>
          <script type="text/javascript">(function(){
         try{
             _dhq.push(["setVar","pt", "seller"]);
             _dhq.push(["event", "Public_S0003"]);
         } catch(e){}
         })();
</script>
          <!-- tracking信息跟踪 End-->
          <!-- 备注 dialog -->
          <div style="display: none;" class="add-remark j-dialog-remark">
            <textarea id="J_RemarkTextarea"></textarea>
            <p class="color999">您还可以输入<span id="J_SurplusCharacters">1000</span>/1000个字符</p>
            <div class="operate-module"><a class="yellowbutton2 mr10 j-remark-submit" href="javascript:;"><span> 提 交 </span></a><a class="greybutton2 j-remark-cancel" href="javascript:;"><span> 取 消 </span></a></div>
          </div>
          <!-- 发送催款信 dialog -->
          <div style="display: none;" class="send-dunning-letters j-dialog-payremind">
            <p>如果买家在付款截止日前未完成支付，此订单将被自动取消。</p>
            <div class="payment-deadline">
              <dl class="choose-reason">
                <dt><strong>请您选择付款截止期限：</strong></dt>
                <dd>
                  <ul class="clearfix">
                    <li>
                      <label>
                      <input name="paymentdeadline" value="5" CHECKED="true" type="radio">
                      5天</label>
                    </li>
                    <li>
                      <label>
                      <input name="paymentdeadline" value="10" type="radio">
                      10天</label>
                    </li>
                    <li>
                      <label>
                      <input name="paymentdeadline" value="15" type="radio">
                      15天</label>
                    </li>
                    <li>
                      <label>
                      <input name="paymentdeadline" value="30" type="radio">
                      30天</label>
                    </li>
                  </ul>
                </dd>
              </dl>
              <div class="operate-module"><a class="yellowbutton2 mr10 j-dunletter-send" href="javascript:;"><span> 发 送 </span></a><a class="greybutton2 j-dunletter-cancel" href="javascript:;"><span> 取 消 </span></a></div>
            </div>
          </div>
          <!-- 发送催款信 dialog end-->
          <!-- 请款 dialog -->
          <div style="display: none;" class="request-payment j-dialog-payrequest"></div>
          <!-- 延长买家付款截止日 dialog -->
          <div style="display: none;" class="payment-extension j-dialog-delaypaydeadline">
            <ul>
              <li><strong>当前买家付款截止日：</strong> <span id="J_deadlineOld"></span></li>
              <li> <strong>延长付款截止日：</strong>
                <select id="J_delayDayOption" onchange=" " name="delayDay">
                  <option value="1">1天</option>
                  <option value="3">3天</option>
                  <option value="5">5天</option>
                  <option value="7">7天</option>
                  <option value="10">10天</option>
                  <option value="15">15天</option>
                  <option value="30">30天</option>
                </select>
                到 <span id="J_deadlineNew"></span> </li>
            </ul>
            <div class="operate-module"><a class="yellowbutton2 mr10 j-delay-pay-submit" href="javascript:;"><span> 确 定 </span></a><a class="greybutton2 j-delay-pay-cancel" href="javascript:;"><span> 取 消 </span></a></div>
          </div>
          <!-- 延长买家付款截止日 dialog end-->
          <!-- 延长交货截止日协议 dialog -->
          <div style="display: none;" class="delay-delivery-agreement j-dialog-delayshipdeadline">
            <div class="delay-delivery-remind">请根据需要延长天数，平台会将您的协议发送给买家。建议您先与买家沟通，协商好延长天数后再使用此功能，因为您只可以向买家提出一次修改协议。一旦买家同意了您的协议，平台将自动为您延长交货截止日。如果买家拒绝了您的协议，您不能再提出修改协议。</div>
            <ul class="clearfix">
              <li> <span class="leftcol">交货截止日：</span>
                <div id="J_delayDeadline"></div>
              </li>
              <li> <span class="leftcol"><em class="colorf00">*</em>延长天数：</span>
                <div>
                  <input id="J_delayNaturalNum" class="input1" type="text">
                  个自然日
                  <p class="color999">延长天数需小于100个自然日</p>
                </div>
              </li>
              <li> <span class="leftcol"><em class="colorf00">*</em>原因：</span>
                <select id="J_delayExtendReason" class="select1">
                  <option>选择原因</option>
                  <option>仓库断货</option>
                </select>
              </li>
            </ul>
            <div class="operate-module"><a class="yellowbutton2 mr10 j-delay-ship-submit" href="javascript:;"><span> 提 交 </span></a><a class="greybutton2 j-delay-ship-cancel" href="javascript:;"><span> 取 消 </span></a></div>
          </div>
          <div style="display: none;" class="delay-delivery-agreement j-dialog-delaygoodsagreement">
            <div class="delay-delivery-tips">以下是您向买家提出延长交货截止日的协议内容，请详细核实，一旦买家同意您的协议，平台将根据协商内容自动延长交货截止日，且此时间只可以被修改一次，您确定吗？</div>
            <ul class="clearfix">
              <li> <span class="leftcol">预延长截止日：</span>
                <div id="J_predelayDeadline"></div>
              </li>
              <li> <span class="leftcol">原因：</span>
                <p id="J_delayExtendReasonDetail"></p>
              </li>
            </ul>
            <div class="operate-module"><a class="yellowbutton2 mr10 j-delay-agreement-submit" href="javascript:;"><span> 确 定 </span></a><a class="greybutton2 j-delayshipClose" href="javascript:;"><span> 取 消 </span></a></div>
          </div>
          <!-- 延长交货截止日协议 dialog end-->
          <!-- 立即发货方式选择 dialog -->
          <div style="display: none;" class="shiptype-choose j-dialog-shiptypechoose">
            <dl>
              <dt>请选择您的发货方式：</dt>
              <dd>
                <div class="clearfix">
                  <div class="awb">
                    <label>
                    <input name="shiptype" type="radio">
                    填写运单号</label>
                  </div>
                  <div class="epacket-ship j-ePacket">
                    <label>
                    <input name="shiptype" type="radio">
                    国际E邮宝(ePacket)</label>
                    <div style="display: none;" class="bubble-layer-grey j-remind-layer"><i></i>无法发往您的收货国家</div>
                  </div>
                  <div class="storehouse-ship">
                    <label>
                    <input name="shiptype" type="radio">
                    DHlink(原仓库发货)</label>
                    <div style="display: none;" class="bubble-layer-grey j-remind-layer"><i></i>可能超出备货时间，请慎重选择 </div>
                  </div>
                </div>
              </dd>
            </dl>
            <div class="operate-module"><a class="yellowbutton2 mr10 j-delivery-submit" href="javascript:;"><span> 确 定 </span></a><a class="greybutton2 j-delivery-cancel" href="javascript:;"><span> 取 消 </span></a></div>
          </div>
          <!-- 立即发货方式选择 dialog end-->
          <script type="text/javascript" src="http://js.dhresource.com/seller/transaction/order/20140804/orderList.js"></script>
        </div>
      </div>
    </div>
    
	<#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#orderLeftbar")}


  </div>
</div>
