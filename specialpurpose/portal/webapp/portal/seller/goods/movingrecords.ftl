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
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202">产品</a><span>&gt;</span><a href="/mydhgate/product/crawlstore.do?act=pageload&amp;dhpath=10001,22001">一键达</a><span>&gt;</span><a href="/mydhgate/product/crawlertask.do?act=findcrawlsource&amp;dhpath=10001,22001,0222">搬家记录</a><span>&gt;</span>一键达 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="col-main-warp">
        <div id="right">
          <div class="col-boxpd col-linebom">
            <h2>一键达搬家</h2>
            <span class="col-rigtit"><a href="http://ued.dhgate.com/dhsurvey/index.php?sid=77337&amp;lang=zh-Hans" target="_blank">
            <!--说说我对一键达的意见-->
            </a></span></div>
          <div class="col-sailtips clearfix"> <span class="leftcol-tip">温馨提示：</span>
            <div class="rightcol-tip">
              <p id="hideTipsBox"> 1、搬家中：代表搬家任务正在执行当中，请耐心等待搬家。<br>
                完成：代表搬家任务执行完毕。<br>
                搬家任务不能解析：代表所提供的商铺、类目、产品地址无法访问，请核对地址URL是否正确后，重新搬家。<br>
                2、产品总数：当次搬家任务所解析到的产品总数量。<br>
                成功搬家产品数：当次成功搬家的产品数量。<br>
                理论上，成功搬家产品数小于等于产品总数。<br>
                原因：若存在原已经搬家的产品，则不再搬家该产品，可导致成功搬家数量小于产品总数；若某产品多次搬家抓取失败，则也可导致成功搬家数量小于产品总数。 </p>
              <span id="viewTips" class="viewticps">收起</span> </div>
          </div>
          <form id="crawlTaskForm" method="post" name="crawlTaskForm" action="/mydhgate/product/crawlertask.do?act=findcrawlsource">
            <div class="mkcreatedatebox"> <span>创建时间：</span>
              <input id="createTimeStart" class="mkcreateinput cond-input condwid3 calendarFocus" name="createTimeStart" readOnly="" value="" type="text">
              <span class="calendar_append"></span> <span>到</span>
              <input id="createTimeEnd" class="mkcreateinput cond-input condwid3 calendarFocus" name="createTimeEnd" readOnly="" value="" type="text">
              <span class="calendar_append"></span> <span class="yellowBtn valmiddle">
              <input id="searchcrawlitem" name="searchcrawlitem" value="搜 索" type="button">
              </span> </div>
            <!-- 列表 开始 -->
            <div class="bg-list">
              <div class="tipmkbox"> <span class="promptcolor"> 没有找到符合条件的信息，建议您调整搜索条件重新检索！ </span>
                <div class="tipmkclose"></div>
              </div>
            </div>
            <!-- 列表 结束 -->
            <!--分页 开始-->
            <!--分页 结束-->
          </form>
        </div>
      </div>
    </div>
   
   <#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#goodsLeftbar")}
 

  </div>
</div>
