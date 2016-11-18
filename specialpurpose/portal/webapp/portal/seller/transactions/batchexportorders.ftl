<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery-1.5.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="../seller/css/seller.css">
<link rel="stylesheet" type="text/css" href="../seller/css/common20140922.css">
<link rel="stylesheet" type="text/css" href="../seller/css/jquery-calendar.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/my-products.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/syi_pop.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/seller_button.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/general_popup_box.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/product.css">
<link rel="stylesheet" type="text/css" href="../seller/css/relatedproduct.css">
<link rel="stylesheet" type="text/css" href="../seller/css/order-export_css.css">
<div class="content">
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/sellerordmng/orderList/list.do?params.linkType=102&amp;dhpath=10002,06,0601">交易</a><span>&gt;</span><a href="http://seller.dhgate.com/sellerordmng/orderList/list.do?params.linkType=102&amp;dhpath=10002,06,0601">我的订单</a><span>&gt;</span><a href="/mydhgate/order/batchexportorder.do?act=pageload&amp;dhpath=10002,06,0603">批量导出订单</a><span>&gt;</span>批量订单导出 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="col-main-warp">
        <div id="right">
          <div class="page-topic clearfix">
            <h2>批量订单导出</h2>
          </div>
          <form id="ExportOrderForm" method="post" name="ExportOrderForm" action="/mydhgate/order/batchexportorder.do" target="_self">
            <input id="act" name="act" value="export" type="hidden">
            <input id="randomNum" name="randomNum" value="" type="hidden">
            <div class="order-export-list">
              <h3>设置需要导出的订单条件</h3>
              <div class="order-export-warp">
                <dl class="clearfix">
                  <dt>订单状态：</dt>
                  <dd>
                    <select id="rfxStatus" name="rfxStatus">
                      <option selected="" value="110">全部订单</option>
                      <option value="101">未付款订单</option>
                      <option value="103">待发货订单</option>
                      <option value="104">已发货订单</option>
                      <option value="105">已入账订单</option>
                      <option value="106">退款&amp;纠纷订单</option>
                      <option value="108">正常关闭订单</option>
                      <option value="109">取消及退款订单</option>
                    </select>
                  </dd>
                </dl>
                <dl class="clearfix">
                  <dt>
                    <select name="timeType">
                      <option selected="" value="XIADANTIME">下单时间</option>
                      <option value="FUKUANTIME">付款确认时间</option>
                    </select>
                    ： </dt>
                  <dd class="calendar-interval">
                    <div class="clearfix">
                      <input id="createDate" class="calendar-input" name="beginDate" readOnly="" value="2014-09-24" size="15" type="text" placeholder="2014-09-24">
                      <select id="beginHour" name="beginHour">
                        <option selected="" value="00">00</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                      </select>
                      <span>：</span>
                      <select id="beginMinute" name="beginMinute">
                        <option selected="" value="00">00</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>
                        <option value="32">32</option>
                        <option value="33">33</option>
                        <option value="34">34</option>
                        <option value="35">35</option>
                        <option value="36">36</option>
                        <option value="37">37</option>
                        <option value="38">38</option>
                        <option value="39">39</option>
                        <option value="40">40</option>
                        <option value="41">41</option>
                        <option value="42">42</option>
                        <option value="43">43</option>
                        <option value="44">44</option>
                        <option value="45">45</option>
                        <option value="46">46</option>
                        <option value="47">47</option>
                        <option value="48">48</option>
                        <option value="49">49</option>
                        <option value="50">50</option>
                        <option value="51">51</option>
                        <option value="52">52</option>
                        <option value="53">53</option>
                        <option value="54">54</option>
                        <option value="55">55</option>
                        <option value="56">56</option>
                        <option value="57">57</option>
                        <option value="58">58</option>
                        <option value="59">59</option>
                      </select>
                      <span>至</span>
                      <input id="expireDate" class="calendar-input" name="endDate" readOnly="" value="2014-10-24" size="15" type="text" placeholder="2014-10-24">
                      <select id="endHour" name="endHour">
                        <option value="00">00</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option selected="" value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                      </select>
                      <span>：</span>
                      <select id="endMinute" name="endMinute">
                        <option selected="" value="00">00</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>
                        <option value="32">32</option>
                        <option value="33">33</option>
                        <option value="34">34</option>
                        <option value="35">35</option>
                        <option value="36">36</option>
                        <option value="37">37</option>
                        <option value="38">38</option>
                        <option value="39">39</option>
                        <option value="40">40</option>
                        <option value="41">41</option>
                        <option value="42">42</option>
                        <option value="43">43</option>
                        <option value="44">44</option>
                        <option value="45">45</option>
                        <option value="46">46</option>
                        <option value="47">47</option>
                        <option value="48">48</option>
                        <option value="49">49</option>
                        <option value="50">50</option>
                        <option value="51">51</option>
                        <option value="52">52</option>
                        <option value="53">53</option>
                        <option value="54">54</option>
                        <option value="55">55</option>
                        <option value="56">56</option>
                        <option value="57">57</option>
                        <option value="58">58</option>
                        <option value="59">59</option>
                      </select>
                    </div>
                    <p class="calendar-remind"><span id="calendarRemind">时间间隔不能超过三个月！</span></p>
                  </dd>
                </dl>
              </div>
            </div>
            <div class="order-export-list">
              <h3>设置需要导出的订单字段</h3>
              <div id="orderExportWarp" class="order-export-warp">
                <dl class="order-fields-one clearfix">
                  <dt> 交易订单信息：<br>
                    <span>
                    <label>
                    <input name="showOrderInfoAll" value="true" type="checkbox" _state="N" rel="tradeall">
                    全选</label>
                    </span> </dt>
                  <dd>
                    <ul class="clearfix">
                      <li>
                        <label>
                        <input disabled="disabled" CHECKED="checked" type="checkbox" _state="Y">
                        订单号</label>
                      </li>
                      <li>
                        <label>
                        <input name="showRfxStatus" value="true" type="checkbox" _state="N" rel="trade">
                        订单状态</label>
                      </li>
                      <li>
                        <label>
                        <input name="showBuyername" value="true" type="checkbox" _state="N" rel="trade">
                        买家名称</label>
                      </li>
                      <li>
                        <label>
                        <input name="showOrderDate" value="true" type="checkbox" _state="N" rel="trade">
                        下单时间</label>
                      </li>
                      <li>
                        <label>
                        <input name="showPayDate" value="true" type="checkbox" _state="N" rel="trade">
                        付款时间</label>
                      </li>
                      <li>
                        <label>
                        <input name="showProductTotalCost" value="true" type="checkbox" _state="N" rel="trade">
                        产品总计金额</label>
                      </li>
                      <li>
                        <label>
                        <input name="showShipCost" value="true" type="checkbox" _state="N" rel="trade">
                        运费</label>
                      </li>
                      <li>
                        <label>
                        <input name="showOrderTotalCost" value="true" type="checkbox" _state="N" rel="trade">
                        订单总额</label>
                      </li>
                      <li>
                        <label>
                        <input name="showYongJin" value="true" type="checkbox" _state="N" rel="trade">
                        佣金金额</label>
                      </li>
                      <li>
                        <label>
                        <input name="showSellerCoupon" value="true" type="checkbox" _state="N" rel="trade">
                        Seller优惠券</label>
                      </li>
                      <li>
                        <label>
                        <input name="showActualCost" value="true" type="checkbox" _state="N" rel="trade">
                        实收金额</label>
                      </li>
                      <li>
                        <label>
                        <input name="showProductInfo" value="true" type="checkbox" _state="N" rel="trade">
                        产品信息</label>
                      </li>
                      <li>
                        <label>
                        <input name="showBuyerMemo" value="true" type="checkbox" _state="N" rel="trade">
                        订单备注</label>
                      </li>
                    </ul>
                  </dd>
                </dl>
                <dl class="order-fields-two clearfix">
                  <dt> 交易物流信息：<br>
                    <span>
                    <label>
                    <input name="showDeliveInfoAll" value="true" type="checkbox" _state="N" rel="logisticsall">
                    全选</label>
                    </span> </dt>
                  <dd>
                    <ul class="clearfix">
                      <li>
                        <label>
                        <input name="showShipAddr" value="true" type="checkbox" _state="N" rel="logistics">
                        收货地址</label>
                      </li>
                      <li>
                        <label>
                        <input name="showBuyerTrackType" value="true" type="checkbox" _state="N" rel="logistics">
                        买家选择物流方式</label>
                      </li>
                      <li>
                        <label>
                        <input name="showDeliveEndDate" value="true" type="checkbox" _state="N" rel="logistics">
                        发货截止时间</label>
                      </li>
                      <li>
                        <label>
                        <input name="showTrackNo" value="true" type="checkbox" _state="N" rel="logistics">
                        实际发货物流&amp;运单号</label>
                      </li>
                      <li>
                        <label>
                        <input name="showDeliveDate" value="true" type="checkbox" _state="N" rel="logistics">
                        发货时间</label>
                      </li>
                      <li>
                        <label>
                        <input name="showConfirmDate" value="true" type="checkbox" _state="N" rel="logistics">
                        确认收货时间</label>
                      </li>
                    </ul>
                  </dd>
                </dl>
              </div>
            </div>
            <div class="order-export-list">
              <h3>设置导出的文件格式和维度</h3>
              <div class="order-export-warp">
                <dl class="clearfix">
                  <dt>选择文件格式：</dt>
                  <dd>
                    <select name="fileType">
                      <option selected="" value="xls">Excel文件</option>
                      <option value="csv">CSV文件</option>
                    </select>
                  </dd>
                </dl>
                <dl class="clearfix">
                  <dt>选择导出维度：</dt>
                  <dd>
                    <select name="exportDimension">
                      <option selected="" value="order">订单</option>
                      <option value="product">产品</option>
                    </select>
                  </dd>
                </dl>
              </div>
            </div>
            <div class="order-export-button"> <a id="orderExportButton" class="bigyellow-button" onclick="_gaq.push(['_trackEvent', '我的订单', '批量导出订单',,, false]);" href="javascript:void(0)"><span>批量导出订单</span></a> </div>
          </form>
        </div>
      </div>
    </div>
  	<#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#orderLeftbar")}

  </div>
</div>
