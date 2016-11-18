<link href="/portal/images/css/seller.css" rel="stylesheet" type="text/css" />
<link href="/portal/images/css/public/common20140922.css" rel="stylesheet" type="text/css" />
<link href="/portal/images/css/general_popup_box.css" rel="stylesheet" type="text/css"/>
<link href="/portal/images/css/summary/summary-page20140416.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/portal/images/js/common.js"></script>
<script type="text/javascript" src="/portal/images/js/public/menu-common_20111226.js?ver=2013"></script>
<script type="text/javascript" src="/portal/images/js/syi/matrix/jquery.simplemodal2.js?ver=2012-09-27"></script>
<script type="text/javascript" src="/portal/images/js/summary/summaryPage.js"></script>
<!--招行贷款新加的脚本-->
<script src="/portal/images//js/bankcorp/bankcorp.js" type="text/javascript"></script>
<!--招行贷款新加的脚本-->
<script type="text/javascript" src="/portal/images/js/jquery/jquery.cookie.js"></script>
<script type="text/javascript" src="/portal/images/js/FusionCharts.js"></script>
<script src="/portal/images//js/mydhgateV2.js?ver=20130909" type="text/javascript"></script>

<div class="top-inner">
	<div class="top-ri">
		<div id="loginState" class="login-state">
			<#if sessionAttributes.autoName?has_content> <span>您好!&nbsp;${sessionAttributes.autoName?html}</span>
			</#if> (<a title="站内信" class="number-link"
				href="/messageweb/newmessagecenter.do?msgtype=001,002,003&dhpath=10005,0301,51001"
				id="newsletter">0</a> <a title="客服留言" class="number-link"
				href="/mydhgate/csmsg/leavemsg.do?act=showListMsg&dhpath=10005,52000,2702"
				id="customServiceMessage">0</a>) <a
				href="<@ofbizUrl>logout</@ofbizUrl>">&nbsp;&nbsp;退出</a>
		</div>
		<ul class="top-nav clearfix">
			<li class="combination">
				<dl>
					<dt>
						<span>卖家频道</span>
					</dt>
					<dd class="seller-channel">
						<div class="column">
							<a href="http://seller.dhgate.com/logincn.html">卖家首页</a> <a
								href="http://seller.dhgate.com/logincn3.html">敦煌一站通</a> <a
								href="http://seller.dhgate.com/valueadded.html">财富D<sup>+</sup>计划
							</a> <a href="http://seller.dhgate.com/edu">敦煌动力营</a> <a
								href="http://seller.dhgate.com/microloan">敦煌贷款</a>
						</div>
						<div class="column">
							<a href="http://adcenter.dhgate.com">推广营销</a> <a
								href="http://seller.dhgate.com/wuliu.html">物流服务</a> <a
								href="http://bbs.dhgate.com/">论坛</a>
						</div>
					</dd>
				</dl>
			</li>
			<li class="backstage-sitemap"><a
				href="/mydhgate/menuv2.do?act=sitemap&dhpath=10000" class="site-map"
				onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', '导航','后台地图']);">后台地图</a>
			</li>
			<li class="combination">
				<dl>
					<dt>
						<span>工具下载</span>
					</dt>
					<dd>
						<a class="red"
							href="http://seller.dhgate.com/seller/pro/377lp.html"
							onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', '导航','Mobile App-Top']); ">手机版
						</a> <a
							href="http://seller.dhgate.com/seller/dhtalk/dhtalkupload.html">敦煌通</a>
						<a href="http://seller.dhgate.com/html/dhgatehelp.htm">敦煌助理</a>
					</dd>
				</dl>
				<div style="display: none;">
					<div class="map-remind">
						<p>在这下载手机版！</p>
						<a id="iKnow">我知道了</a> <b></b>
					</div>
					<div class="map-shadow" id="mapRemind"></div>
				</div>
			</li>
			<li class="combination help-w">
				<dl>
					<dt>
						<span>帮助</span>
					</dt>
					<dd>
						<a href="http://help.dhgate.com/dhgate/sellerhelpcn.php">帮助中心</a><a
							href="http://seller.dhgate.com/help/contactService.html">联系客服</a>
					</dd>
				</dl>
			</li>
			<li><a href="<@ofbizUrl>main</@ofbizUrl>">买家首页</a></li>
		</ul>
	</div>
</div>