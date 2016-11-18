<h1> <a href="<@ofbizUrl>sellerIndex</@ofbizUrl>"> <#if sessionAttributes.overrideLogo?exists> <img src="<@ofbizContentUrl>${sessionAttributes.overrideLogo}</@ofbizContentUrl>" alt="Logo"/> <#elseif catalogHeaderLogo?exists> <img src="<@ofbizContentUrl>${catalogHeaderLogo}</@ofbizContentUrl>" alt="Logo"/> <#elseif layoutSettings.VT_HDR_IMAGE_URL?has_content> <img src="<@ofbizContentUrl>${layoutSettings.VT_HDR_IMAGE_URL.get(0)}</@ofbizContentUrl>" alt="Logo"/> </#if> </a> </h1>
  <div class="nav-container">
    <ul class="nav clearfix" id="topNav">
      <li index="0" id="Menu_mydhgate"  class="current" > <a class="nav-item first" href="<@ofbizUrl>sellerIndex</@ofbizUrl>">我的首页</a> </li>
      <li id="Menu_10001"  > <a class="nav-item" href="<@ofbizUrl>goodsMgnt</@ofbizUrl>"   >产品</a>
        <div class="nav-directory two-col clearfix">
          <div class="column"> <a href="<@ofbizUrl>goodsMgnt</@ofbizUrl>"  >产品管理</a> <a href="<@ofbizUrl>lackductattribute</@ofbizUrl>"   >产品诊断</a> <a href="<@ofbizUrl>keyupmove</@ofbizUrl>"    >一键达</a> <a href="<@ofbizUrl>freightemplatemanage</@ofbizUrl>"    >运费模板管理</a> <a href="<@ofbizUrl>store</@ofbizUrl>"   >商铺</a> </div>
          <div class="column"> <a href="<@ofbizUrl>stockmanage</@ofbizUrl>" >备货管理</a> <a href="<@ofbizUrl>overseaservice</@ofbizUrl>"    >产品服务设定</a> <a href="<@ofbizUrl>ductphotoalbum</@ofbizUrl>"    >产品相册</a> <a href="<@ofbizUrl>complaintmanage</@ofbizUrl>"  >申诉管理</a> <a href="<@ofbizUrl>brandmanage</@ofbizUrl>"   >经营品牌</a> </div>
          <iframe scrolling="no" frameborder="0" class="naviframe"></iframe>
        </div>
      </li>
      <li id="Menu_10002"  > <a class="nav-item" href="<@ofbizUrl>myorder</@ofbizUrl>">交易</a>
        <div class="nav-directory"> <a href="<@ofbizUrl>myorder</@ofbizUrl>"  >我的订单</a> <a href="<@ofbizUrl>rebate</@ofbizUrl>"  >返还佣金</a> <a href="<@ofbizUrl>internationalEPo</@ofbizUrl>"  >在线物流</a> <a href="<@ofbizUrl>transmanagevaluation</@ofbizUrl>"  >评价和评论管理</a> <a href="<@ofbizUrl>buyerslist</@ofbizUrl>"  >我的买家</a>
          <iframe scrolling="no" frameborder="0" class="naviframe"></iframe>
        </div>
      </li>
      <li id="Menu_10003"  > <a class="nav-item" href="/mydhgate/service/serviceaction.do?act=myservice&dhpath=10003,1002"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-增值服务']);  ">增值服务</a>
        <div class="nav-directory"> <a href="/mydhgate/service/serviceaction.do?act=allservice&dhpath=10003,1001"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-增值服务','服务简介']);  " >服务简介</a> <a href="/mydhgate/service/serviceaction.do?act=myservice&dhpath=10003,1002"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-增值服务','我的增值礼包']);  " >我的增值礼包</a> <a href="/mydhgate/premium/premiumInfo.do?act=getMyPremiumInfo&dhpath=10003,1005"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-增值服务','我的功能包']);  " >我的功能包</a> <a href="/mydhgate/edm/edmentrance.do?&dhpath=10003,1201"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-增值服务','EDM推荐']);  " >EDM推荐</a> <a href="/wantitnow/wantitnowseller/wantindex.do?dhpath=10003,18,1801"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-增值服务','国外求购信息']);  " >国外求购信息</a>
          <iframe scrolling="no" frameborder="0" class="naviframe"></iframe>
        </div>
      </li>
      <li id="Menu_10004"  > <a class="nav-item" href="/promoweb/platformacty/actylist.do?ptype=1&dhpath=10004,30,3001"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-推广营销']);  ">推广营销</a>
        <div class="nav-directory two-col clearfix">
          <div class="column"> <a href="/promoweb/platformacty/actylist.do?ptype=1&dhpath=10004,30,3001"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-推广营销','促销活动']);  " >促销活动</a> <a href="http://adcenter.dhgate.com" target="_blank"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-推广营销','敦煌产品营销系统']);  " >敦煌产品营销系统</a> <a href="http://seller.dhgate.com/marketweb/trafficbus/pageload.do?dhpath=10004,33"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-推广营销','流量快车']);  " >流量快车</a> <a href="http://seller.dhgate.com/marketing/signup/spread"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-推广营销','GoogleShopping推广']);  " >GoogleShopping推广</a> <a href="/marketweb/vaslisting/pageload.do?dhpath=10004,34,3401"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-推广营销','视觉精灵']);  " >视觉精灵</a> </div>
          <div class="column"> <a href="/union/supplier/getprods.do?dhpath=10004,37,3701"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-推广营销','敦煌联盟']);  " >敦煌联盟</a> </div>
          <iframe scrolling="no" frameborder="0" class="naviframe"></iframe>
        </div>
      </li>
      <li id="Menu_10005"  > <a class="nav-item" href="<@ofbizUrl>buyersMessage</@ofbizUrl>"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-消息']);  ">消息</a>
        <div class="nav-directory"> <a href="<@ofbizUrl>buyersMessage</@ofbizUrl>" >站内信<span id="dhunreadall2" style="display:none;">(0)</span></a> <a href="<@ofbizUrl>onlineMessage</@ofbizUrl>"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-消息','客服留言']);  " >客服留言<span id="dhunreadCsMsg2" style="display:none;">(0)</span></a>
          <iframe scrolling="no" frameborder="0" class="naviframe"></iframe>
        </div>
      </li>
      <li id="Menu_10006"  > <a class="nav-item" href="/fundaccounting/accountDetail/detailList.do?dhpath=10006,0901"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-资金账户']);  ">资金账户</a>
        <div class="nav-directory two-col clearfix">
          <div class="column"> <a href="/fundaccounting/accountDetail/detailList.do?dhpath=10006,0901"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-资金账户','交易记录']);  " >交易记录</a> <a href="/pria/service/priaOrderList.do?dhpath=10006,0907"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-资金账户','提前放款']);  " >提前放款</a> <a href="/mydhgate/guaranteefund/securityaccount.do?act=pageload&dhpath=10006,0904"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-资金账户','保障金管理']);  " >保障金管理</a> <a href="/mydhgate/dhb/dhblist.do?dhpath=10006,0902"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-资金账户','敦煌币管理']);  " >敦煌币管理</a> <a href="/mydhgate/dhaccount/productcoupon.do?act=pageload&dhpath=10006,0903"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-资金账户','优惠券管理']);  " >优惠券管理</a> </div>
          <div class="column"> <a href="/mydhgate/ccb/ccbuseraction.do?act=allservice&dhpath=10006,90,9003"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-资金账户','建行敦煌“e保通”']);  " >建行敦煌“e保通”</a> <a href="/bankcorp/cmb/onlineloan.do?dhpath=10006,0905"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-资金账户','在线贷款']);  " >在线贷款</a> <a href="/fundaccounting/ba/cnyAccInfo.do?dhpath=10006,0906"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-资金账户','账户设置']);  " >账户设置</a> </div>
          <iframe scrolling="no" frameborder="0" class="naviframe"></iframe>
        </div>
      </li>
      <li id="Menu_10007"  > <a class="nav-item" href="/wisdom/shopanalysis/toprofile.do?dhpath=10007,60,6001"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-数据智囊']);  ">数据智囊</a>
        <div class="nav-directory"> <a href="/wisdom/shopanalysis/toprofile.do?dhpath=10007,60,6001"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-数据智囊','商铺解析']);  " >商铺解析</a> <a href="/wisdom/industryanalysis/toprofile.do?dhpath=10007,61,6101"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-数据智囊','行业动态']);  " >行业动态</a> <a href="/wisdom/keyword/analysis.do?dhpath=1007,62"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-数据智囊','搜索词追踪']);  " >搜索词追踪</a>
          <iframe scrolling="no" frameborder="0" class="naviframe"></iframe>
        </div>
      </li>
      <li id="Menu_10009"  > <a class="nav-item" href="/dmrs/dmrsaction.do"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-商户管理']);  ">商户管理</a>
        <div class="nav-directory"> <a href="/punish/punishManage/getPunishInfo.do?dhpath=10009,32"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-商户管理','处罚管理']);  " >处罚管理</a> <a href="/dmrs/dmrsaction.do"  onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'head-商户管理','商户评级']);  " >商户评级</a>
          <iframe scrolling="no" frameborder="0" class="naviframe"></iframe>
        </div>
      </li>
      <li id="Menu_10008"   class="last"  > <a class="nav-item" href="<@ofbizUrl>modityPassword</@ofbizUrl>" >设置</a>
        <div class="nav-directory"> <a href="<@ofbizUrl>modityPassword</@ofbizUrl>">安全设置</a> <a href="<@ofbizUrl>identityAuthentication</@ofbizUrl>">身份认证</a> <a href="<@ofbizUrl>returnAddress</@ofbizUrl>">我的地址</a> <a href="<@ofbizUrl>merchantsInfo</@ofbizUrl>">资料设置</a> <a href="<@ofbizUrl>shortmessageService</@ofbizUrl>">手机服务</a>
          <iframe scrolling="no" frameborder="0" class="naviframe"></iframe>
        </div>
      </li>
    </ul>
    <div class="left-line"></div>
    <div class="right-line"></div>
  </div>