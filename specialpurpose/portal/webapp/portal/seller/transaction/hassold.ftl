
<script src="/images/jquery/plugins/validate/jquery.validate.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/jeditable/jquery.jeditable.js" type="text/javascript"></script>
<script src="/images/jquery/ui/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/datetimepicker/jquery-ui-timepicker-addon.min-1.4.3.js" type="text/javascript"></script>


<style type="text/css">
body,ul,li{margin: 0;padding: 0;font: 10px normal "宋体", Arial, Helvetica, sans-serif;list-style: none;}
a{text-decoration: none;font-size: 14px;}

#tabbox{ width: 950px;overflow: hidden;margin: 0 auto;margin-left: 0px;}
.tab_conbox{border: 1px solid #999;border-top: none;}
.tab_con{ display:none;}

.tabs{height: 32px;border-bottom:1px solid #999;border-left: 1px solid #999;width: 100%;}
.tabs li{height:31px;line-height:25px;float:left;border:1px solid #999;border-left:none;margin-bottom: -1px;background: #e0e0e0;overflow: hidden;position: relative;}
.tabs li a {display: block;padding: 0 15px;border: 1px solid #fff;outline: none;}
.tabs li a:hover {background: #ccc;}    
.tabs .thistab,.tabs .thistab a:hover{background: #fff;border-bottom: 1px solid #fff;}

.tab_con {padding:12px;font-size: 14px; line-height:175%;}

.expanded{height:30px;line-height:30px;font-weight:bold;}
td{line-height:30px; height:30px;}
.label{color: #000000; background-color: #ffffff !important; line-height:20px;}

.table {font-size:11px;}

</style>
 <script type="text/javascript"> 
	 $(function(){ 
		$(".breadcrumb").append("<li class='active'>交易管理</li><li class='active'>已卖出宝贝</li>")
	});   

$(document).ready(function() {
    jQuery.jqtab = function(tabtit,tabcon) {
        $(tabcon).hide();
        $(tabtit+" li:first").addClass("thistab").show();
        $(tabcon+":first").show();
    
        $(tabtit+" li").click(function() {
            $(tabtit+" li").removeClass("thistab");
            $(this).addClass("thistab");
            $(tabcon).hide();
            var activeTab = $(this).find("a").attr("tab");
            $("#"+activeTab).fadeIn();
            return false;
        });
        
    };
    /*调用方法如下：*/
    $.jqtab("#tabs",".tab_con");
    
});
</script>
<form method="post" name="queryConditionForm" id="queryConditionForm">
			<div id="trade-search-box" data-spm="10">
				<div class="bd" id="J_SearchBox">
					<table>
						<tbody>
							<tr>
								<td><label>宝贝名称：</label><input
									type="text" size="15" style="width: 200px;height: 35px;font-size: 15px;" id="auctionTitle" name="auctionTitle"
									value="">
								</td>
								<td   colspan="2"><label>成交时间：从</label> <input
									type="text" size="10" id="bizOrderDateBegin" style="width: 100px;height: 35px;font-size: 15px;"
									name="bizOrderTimeBegin" value="">日
									 <select
										class="hour" id="bizOrderHourBegin" name="bizOrderHourBegin">
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
											<option value="17">17</option>
											<option value="18">18</option>
											<option value="19">19</option>
											<option value="20">20</option>
											<option value="21">21</option>
											<option value="22">22</option>
											<option value="23">23</option>
									</select>时 <input class="minute" type="text" size="2"
										id="bizOrderMinBegin" name="bizOrderMinBegin" style="width: 50px;height: 35px;font-size: 15px;" value="">分

											<label>到</label><input type="text" size="10"
											id="bizOrderDateEnd" name="bizOrderTimeEnd" style="width: 100px;height: 35px;font-size: 15px;" value="">日
												<select class="hour" id="bizOrderHourEnd"
												name="bizOrderHourEnd">
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
													<option value="17">17</option>
													<option value="18">18</option>
													<option value="19">19</option>
													<option value="20">20</option>
													<option value="21">21</option>
													<option value="22">22</option>
													<option value="23">23</option>
											</select>时 <input class="minute" type="text" size="2"
												id="bizOrderMinEnd" name="bizOrderMinEnd" style="width: 50px;height: 35px;font-size: 15px;" value="">分

													<script src="../seller/images/simplecalendar-min.js"></script>
													<link rel="stylesheet" type="text/css"
														href="./已卖出的宝贝_files/calendar.css">
														<script src="../seller/images/calendar-min.js"
															type="text/javascript"></script>

														<script src="../seller/images/saved_resource(3)"></script>
								</td>

							</tr>
							<tr>
								<td  ><label>买家昵称：</label><input
									type="text" size="15" id="J_BuyNick" name="buyerNick" style="width: 200px;height: 35px;font-size: 15px;" value="">
								</td>
								<td  ><label>订单状态：</label> <select
									id="auctionStatus" name="auctionStatus" value="">
										<option value="ALL">全部</option>
										<option value="NOT_PAID">等待买家付款</option>
										<option value="PAID">买家已付款</option>
										<option value="SEND">卖家已发货</option>
										<option value="SUCCESS">交易成功</option>
										<option value="DROP">交易关闭</option>
										<option value="NOT_PAID_AND_NOT_SEND">待付款和待发货订单</option>
										<option value="REFUNDING">退款中的订单</option>
										<option value="FRONT_PAID">定金已付</option>
										<option value="EXCEPTIONAL">异常订单</option>
								</select> <script type="text/javascript">setSelectOption('auctionStatus','')</script>
								</td>
								<td  ><label>评价状态：</label> <select
									id="commentStatus" name="commentStatus" value="">
										<option value="ALL">全部</option>
										<option value="I_HAS_NOT_COMMENT">需我评价</option>
										<option value="I_HAS_COMMENT">我已评价</option>
										<option value="OTHER_HAS_COMMENT">对方已评</option>
										<option value="ALL_COMMENT">双方已评</option>
								</select> <script type="text/javascript">setSelectOption('commentStatus','')</script>
								</td>
							</tr>
							<!-- add -->
							<tr>
								<td  ><label>订单编号：</label><input
									type="text" size="11" id="bizOrderId" name="bizOrderId" style="width: 200px;height: 35px;font-size: 15px;"
									value="">
								</td>
								<td  ><label>物流服务：</label> <select
									id="logisticsService" name="logisticsService" value="">
										<option value="ALL">全部</option>
										<option value="COD">货到付款</option>
								</select> <script type="text/javascript">setSelectOption('logisticsService','')</script>
								</td>
								<td  ><label>售后服务：</label> <select
									id="tradeDissension" name="tradeDissension" value="">
										<option value="ALL">全部</option>
										<option value="BUYER_SUIT">买家投诉</option>
										<option value="SELLER_SUIT">我已投诉</option>
										<option value="REFUNDING">退款中</option>
								</select> <script type="text/javascript">setSelectOption('tradeDissension','')</script>
								</td>
							</tr>
							<tr>
								<td  ><label>交易类型：</label><select
									id="auction-type" name="auctionType">
										<option value="0">所有类型</option>
										<option value="1">一口价</option>
										<option value="2">拍卖</option>
								</select></td>
								<!-- 店铺名称搜索框 Ajax异步请求加载-->
								<td class="hidden"><label>店铺名称：</label> <select
									id="J_SearchShopNames" name="shopName" value="">
										<option value="All">全部</option>
										<option value="TAOBAO_INNER_SHOP">淘宝店铺</option>
								</select> <script type="text/javascript">setSelectOption('J_SearchShopNames','')</script>
								</td>
							</tr>
							<tr>
								<td colspan="3" class="search-export"><span
									class="skin-gray">
										<button id="J_SearchOrders" class="small-btn J_MakePoint"
											type="button"
											onclick="durexCheck(function(){changePage(0)}, this)"
											data-point-url=" http://gm.mmstat.com/listsold.1.1"
											data-durex="{&quot;durexUrl&quot;: &quot;http://aq.taobao.com/durex/validate&quot;, &quot;authUrl&quot;: &quot;/trade/security/auth_user_info.htm&quot;}"
											data-durex-urlparam="{&quot;redirecturl&quot;: &quot;http://trade.taobao.com/trade/itemlist/mid/durex.htm&quot;}">
											搜索</button>
										<button id="J_BatchExportBtn" class="small-long-btn"
											type="button">批量导出</button> </span></td>
							</tr>
						</tbody>
					</table>


					<div class="msg" id="J_TipAndFeedbackForDateSelect"></div>
					<div id="J_BatchExportPanel" class="batch-export skin-gray"
						style="display: none">
						<strong>为了给你提供更好的查询性能以及体验，我们对导出功能进行了改进：</strong>
						<ul>
							<li>为了保证您的查询性能，两次导出的时间间隔请保持在 5 分钟以上。</li>
							<li>我们将为您保留30天内导出的数据，便于您随时导出。</li>
						</ul>
						<div class="actions">
							<a class="long-btn generate-sheets"
								onclick="durexCheck(function(){applyExport()}, this)"
								data-durex="{&quot;durexUrl&quot;: &quot;http://aq.taobao.com/durex/validate&quot;, &quot;authUrl&quot;: &quot;/trade/security/auth_user_info.htm&quot;}"
								data-durex-urlparam="{&quot;redirecturl&quot;: &quot;http://trade.taobao.com/trade/itemlist/mid/durex.htm&quot;}"
								data-durex-authparam="{&quot;createReport&quot;: 1}"> 生成报表 </a>
							<a class="long-btn view-sheets"
								href="http://trade.taobao.com/trade/itemlist/list_export_order.htm"
								target="_blank">查看已生成报表</a>
						</div>

						<a id="J_BatchExportPanelCloseBtn" class="close-btn"
							href="http://trade.taobao.com/trade/itemlist/list_sold_items.htm?spm=a1z09.1.0.0.MX4Rzu&mytmenu=ymbb&utkn=g%2C2csmzq6h3a1415762796233&scm=1028.1.1.201#"
							title="关闭">关闭</a>
					</div>
				</div>

			</div>
		</form>

<!-- 代码 开始 -->
<div class="col-main">
  <div id="tabbox">
    <ul class="tabs" id="tabs">
      <li><a href="#" tab="tab1">近三个月订单</a></li>
      <li><a href="#" tab="tab2">等待买家付款</a></li>
      <li><a href="#" tab="tab3">等待发货</a></li>
      <li><a href="#" tab="tab4">已发货</a></li>
      <li><a href="#" tab="tab5">退款中</a></li>
      <li><a href="#" tab="tab6">需要评价</a></li>
      <li><a href="#" tab="tab7">成功的订单</a></li>
      <li><a href="#" tab="tab8">关闭的订单</a></li>
      <li><a href="#" tab="tab9">三个月前订单</a></li>
    </ul>
    <ul class="tab_conbox">
      <li id="tab1" class="tab_con">
      ${screens.render("component://portal/widget/SellerScreens.xml#recentThreeMonths")}
       </li>
    </ul>
  </div>
</div>