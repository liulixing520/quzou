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
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202">产品</a><span>&gt;</span><a href="/store/pageload.do?dhpath=10001,08,0801">商铺</a><span>&gt;</span><a href="/store/pageload.do?dhpath=10001,08,0801">商铺信息</a><span>&gt;</span>创建店铺 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div id="right">
        <form id="createSellerStoreForm" method="post" name="createSellerStoreForm" action="/store/createStore.do">
          <div class="col-boxpd col-linebom">
            <h2>商铺信息</h2>
          </div>
          <div class="createshop"> <span class="tipbigicon"></span>您尚未创建自己的店铺 </div>
          <div class="createshoptrip">
            <p class="marginbottom10">创建店铺的好处：<br>
              <span class="color666">店铺可以帮助您更好的管理自己的产品，提高产品的展示机会。</span></p>
            <p class="marginbottom10">创建店铺前需要做以下的工作：<br>
              <span class="color666">（系统已做检测，以下<b class="color-g">√</b>为已经完成，<b class="color-f00">？</b>为尚未完成）</span><br>
              <b class="color-f00">？</b>上架的产品必须大于或等于10件 <a class="under-line" href="http://cs.dhgate.com/cms/55.html#4" target="_blank">了解产品规定</a><br>
              <span class="color666">请确认您已经完成上述准备工作，点击下面按钮创建您的店铺</span><br>
            </p>
            <div> <span class="bigyellow-button marginright20">
              <input onclick="window.location.href='http://seller.dhgate.com/syi/category.do'" value="上传产品" type="button">
              </span> </div>
          </div>
        </form>
      </div>
    </div>
    
   <#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#goodsLeftbar")}
 

  </div>
</div>
