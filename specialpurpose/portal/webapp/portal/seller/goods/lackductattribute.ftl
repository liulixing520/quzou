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
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202">产品</a><span>&gt;</span><a href="/prodmanage/attrDefect/prodAttrDefect.do?dhpath=10001,70,7001">产品诊断</a><span>&gt;</span>属性缺失产品 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="col-main-warp">
        <div id="right">
          <form id="prodAttrDefectForm" method="post" name="prodAttrDefectForm" action="/prodmanage/attrDefect/prodAttrDefect.do?dhpath=10001,70,7001">
            <input id="dispatcheOperation" name="prodAttrDefectForm.dispatcheOperation" value="prodAttrDefect" type="hidden">
            <input id="hasOperationTip" name="prodAttrDefectForm.hasOperationTip" value="0" type="hidden">
            <input id="operationTip" name="prodAttrDefectForm.operationTip" value="" type="hidden">
            <input id="sortType" name="prodAttrDefectForm.sortType" value="0" type="hidden">
            <input id="sortField" name="prodAttrDefectForm.sortField" value="" type="hidden">
            <input id="visitType" name="visitType" value="1" type="hidden">
            <div class="col-boxpd col-linebom">
              <h2>属性缺失产品</h2>
            </div>
            <div class="col-sailtips clearfix"> <span class="leftcol-tip">温馨提示：</span>
              <div class="rightcol-tip">
                <p id="hideTipsBox" class="addheight"> 1.产品的类目及属性会根据买家市场需求和行业趋势进行调整，从而使部分商品属性缺失。属性缺失会影响买家了解产品信息，降低买家购买的意愿。<br>
                  2.完善的产品信息有助于买家浏览，提升产品曝光率及转换率，请广大卖家积极补充属性缺失的产品信息。<a class="lkundeline" href="http://seller.dhgate.com/help/seller-help/c0324/a108806.html" target="_blank">了解更多</a> </p>
                <span id="viewTips" class="viewticps viewshow ">展开</span> </div>
            </div>
            <div id="newGuideTarget3" class="condbox clearfix searchConditions"> <span class="tname">产品编号：</span>
              <input id="searchItemcode" class="cond-input condwid1 defaultcolor" name="prodAttrDefectForm.itemcode" value="输入完整产品编号" type="text" data-value="输入完整产品编号">
              <span class="tname">关键词：</span>
              <input id="productName" class="cond-input condwid1s defaultcolor" name="prodAttrDefectForm.productName" value="输入产品名或关键词" type="text" data-value="输入产品名或关键词">
              <span class="marginright5">产品状态：</span>
              <select id="productStatus" name="prodAttrDefectForm.productStatus">
                <option value="0">--- 请选择 ---</option>
                <option selected="" value="1">已上架</option>
                <option value="2">待审核</option>
                <option value="3">审核未通过</option>
                <option value="4">已下架 </option>
              </select>
              <div class="padline15"></div>
              <span class="tname">产品组：</span>
              <select id="firSelectproductgroup" class="j-select-root mksearchselect addwid113">
                <option title="请选择产品分组" value="">请选择产品分组</option>
                <option title="未分组" value="nogroup">未分组</option>
              </select>
              <select style="display: none;" id="secSelectprouctgroup" class="j-select-sub mksearchselect addwid113">
              </select>
              <input id="selectproductgroup" class="j-select-hidden" name="prodAttrDefectForm.selectedProdGroupId" value="" type="hidden">
              <span class="yellowBtn valmiddle">
              <input id="searchSubmitbtn" value="搜索" type="button">
              </span> <span class="tourBtn valmiddle">
              <input id="searchResetbtn" value="重置" type="button">
              </span> </div>
            <div id="newGuideTarget2" class="rtab-warp">
              <ul class="clearfix">
                <li class="current"> <a href="/prodmanage/attrDefect/prodAttrDefect.do?dhpath=10001,70,7001"> <span id="attrDefectProductNum"> 属性缺失产品(<b>0</b>) </span> </a> </li>
              </ul>
              <div class="propbox tipstion"> <span class="yellowBtn">
                <input class="j-btn-batchattr" value="批量修改属性值" type="button">
                </span>
                <!-- 新增一键修改tip -->
                <span style="left: -90px; top: -58px; display: none;" class="tiparrow-posbox j-batchattr-tip">
                <div style="width: 210px; color: rgb(255, 85, 0);" class="tiparrow-box clearfix">通过批量添加属性值，可以增强产品的完整度，提高产品的曝光量。 <a class="tiparrow-close j-closer" href="javascript:;"></a> <a class="tiparrow-iknow j-know" href="javascript:;">我知道了</a>
                  <div style="left: 140px;" class="tiparrow-b"></div>
                </div>
                </span> </div>
            </div>
            <!-- 列表 开始 -->
            <div class="bg-list">
              <table border="0" cellSpacing="0" cellPadding="0" width="100%">
                <tbody>
                  <tr>
                    <th width="35%" colSpan="3">产品信息</th>
                    <th width="13%">产品组</th>
                    <th width="13%">价格</th>
                    <th class="cursor" width="13%"> <span id="sort_expireDate">有效期</span> </th>
                    <!--<th width="12%" class="cursordesc"><span>有效期</span></th>-->
                    <th width="13%">产品状态</th>
                    <th class="last" width="13%">操作</th>
                  </tr>
                  <tr>
                    <td class="tipmktd" colSpan="9"><div class="tipmkbox"> 您暂时没有属性缺失产品。 </div></td>
                  </tr>
                </tbody>
              </table>
            </div>
            <!-- 列表 结束 -->
          </form>
          <input id="showAttributeDefectGuide" value="0" type="hidden">
          <!--丢失属性产品提示弹层 开始-->
          <div style="display: none;" class="new-guide-step1 png_bg j-dialog-missattribute">
            <div class="guidetxtbox">为了提高产品的曝光量、平台对类目进行调整。您有部分产品必填属性缺失。您可在"<span class="rcolor">产品诊断 — 属性缺失产品</span>"中修改，建议您立即完善。</div>
            <span class="guide-iknow j-closer" conduct="iknow">我知道了~</span>
            <div class="guide-arrow1 png_bg"></div>
            <a class="guide-close-button png_bg j-closer" href="javascript:void(0);" conduct="iknow"></a> </div>
          <!--丢失属性产品提示弹层 结束-->
          <script type="text/javascript" src="http://js.dhresource.com/seller/repairproduct/missattribute.js?version=2014-10-13"></script>
        </div>
      </div>
    </div>
   
   <#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#goodsLeftbar")}
 

  </div>
</div>
