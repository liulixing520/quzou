<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery-1.5.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="../seller/css/seller.css">
<link rel="stylesheet" type="text/css" href="../seller/css/common20111215.css">
<link rel="stylesheet" href="../seller/css/jquery-calendar.css">
<link rel="stylesheet" type="text/css" href="../seller/css/my-products.css">
<link rel="stylesheet" type="text/css" href="../seller/css/syi_pop.css">
<link rel="stylesheet" type="text/css" href="../seller/css/seller_button.css">
<link rel="stylesheet" type="text/css" href="../seller/css/general_popup_box.css">
<link rel="stylesheet" type="text/css" href="../seller/css/product.css">
<!-- 代码 开始 -->
<div class="content">
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a
				href="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202">产品</a><span>&gt;</span><a
				href="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202">产品管理</a><span>&gt;</span>管理产品组 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="col-main-warp">
        <div id="right">
          <div id="right">
            <div class="col-boxpd col-linebom">
              <h2>管理产品组</h2>
            </div>
            <div class="col-sailtips clearfix"> <span class="leftcol-tip">温馨提示：</span>
              <div class="rightcol-tip">
                <p id="hideTipsBox" class="j-fold-content"> 1、您可自主命名店铺产品分组英文名。创建英文名—&gt;店铺分组会显示英文组名。提示：产品组英文名称中不能含有禁销词、品牌词。<br>
                  2、产品英文组名创建成功后，会在3小时后显示在店铺分组.上架产品数量排名前20的一级产品组将显示为店铺产品。<br>
                  3、产品组增加二级分组功能，1个产品组最多可以增加10个分组。 </p>
                <span id="viewTips" class="viewticps j-folder">收起</span> </div>
            </div>
            <div class="dsbbtitle2 clearfix"> <span class="yellowBtn valmiddle">
              <input
									id="addProdGroup" value="添加产品组" type="button">
              </span> </div>
            <div class="rtab-warp">
              <ul class="clearfix">
                <li class="current"><span>我的产品组</span> </li>
                <li id="sortpage"><a
										href="/prodmanage/group/prodGroupSort.do"><span>产品组排序</span> </a> </li>
              </ul>
              <div class="propbox tipstion"> <span class="yellowBtn">
                <input class="j-onekey"
										value="一键修改" type="button" data-target=".j-tab-productgroup">
                </span>
                <!-- 新增一键修改tip 
                <span class="tiparrow-posbox j-onekey-tip" style="display: none; left:-120px; top:-53px;">
                  <div class="tiparrow-box clearfix" style="width:180px">可以一键修改价格、延长有效期、修改备货期和调整产品组
					<a href="javascript:;" class="tiparrow-close j-closer"></a>
                    <a class="tiparrow-iknow j-know" href="javascript:;">我知道了</a>
                    <div class="tiparrow-b" style="left:150px;"></div>
                  </div>
                </span>
                -->
              </div>
            </div>
            <div class="dsbbtitle2 clearfix"> 已创建 <b id="groupCurrentCount" class="fontsc">0</b> 个产品组，还能创建 <b
									class="fontsc">60</b> 个！ </div>
            <form id="prodGroupForm" method="post" name="prodGroupForm"
								action="/prodmanage/group/prodGroup.do">
              <input id="isStudentSupplier" name="isStudentSupplier" value="0"
									type="hidden">
              <div class="productmanagementlist">
                <!-- 列表 开始 -->
                <div class="bg-list dathnoborder">
                  <table border="0" cellSpacing="0" cellPadding="0" width="100%">
                    <thead>
                      <tr>
                        <th width="8%">序号</th>
                        <th width="34%">产品组</th>
                        <th width="12%">产品数量</th>
                        <th width="12%">店铺可见否</th>
                        <th width="14%">创建时间</th>
                        <th class="last" width="14%">操作</th>
                      </tr>
                    </thead>
                    <tbody>
                    </tbody>
                  </table>
                </div>
                <!-- 列表 结束 -->
              </div>
              <div style="display: none;" id="orderbypage"
									class="productmanagementlist productsort">
                <!-- 列表 开始 -->
                <div class="bg-list dathnoborder"> <span style="left: 60px; display: none;" class="editol">
                  <input
											class="txt-val" value="2" type="text">
                  <span
											id="tourBtn" class="tourBtn marginl5">
                  <input
												value="确认" type="button">
                  </span> </span>
                  <table id="tableProductGroup" border="0" cellSpacing="0"
											cellPadding="0" width="100%">
                    <thead>
                      <tr class="thead">
                        <th width="20%">序号</th>
                        <th width="25%">产品组</th>
                        <th class="last" width="35%">创建时间</th>
                      </tr>
                    </thead>
                    <tbody>
                    </tbody>
                  </table>
                </div>
                <!-- 列表 结束 -->
              </div>
            </form>
          </div>
          <!--新手指引蒙版弹层 开始-->
          <div style="display: none;" id="newGuideStep1"
							class="new-guide-step1 png_bg">
            <div class="txtcontent"> 产品组升级了。接下来您需要：<br>
              1、补充您的产品组英文名，并确保名称中不含<br>
              <span class="textindent">有禁销词、品牌词，否则影响分组在店铺中的显示</span> <br>
              2、尽量使用产品分组，分组数量不要太多，建议不要<br>
              <span class="textindent">超过20个。</span> </div>
            <div class="txtconval"> <span id="guideNextButton3" class="guide-next-button"
									conduct="iknow">立即体验</span> </div>
            <div class="guide-arrow1 png_bg"></div>
            <a class="guide-close-button png_bg" href="javascript:void(0);"
								conduct="iknow"></a>
            <div class="guide-pos1"></div>
          </div>
          <!--新手指引蒙版弹层 结束-->
          <script
							src="http://www.dhresource.com/dhs/fob/js/global/dhgate.cookie-1.0.js?version=2014-10-13"></script>
          <script
							src="http://www.dhresource.com/dhs/mos/js/productgroup/dialog.js?version=2014-10-13"></script>
          <script
							src="http://www.dhresource.com/dhs/mos/js/productgroup/prodgrouplist.js?version=2014-10-13"></script>
          <script
							src="http://js.dhresource.com/seller/stusyi/stusyiAuth.js?version=2014-10-13"></script>
        </div>
      </div>
    </div>
    
   <#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#goodsLeftbar")}
 
  </div>
</div>
<!-- 代码 结束 -->
