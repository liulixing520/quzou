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
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202">产品</a><span>&gt;</span><a href="/prodmanage/attrDefect/prodAttrDefect.do?dhpath=10001,70,7001">产品诊断</a><span>&gt;</span><a href="/prodrepeat/prodrepeatgroup/grouplist.do?dhpath=10001,70,7002">违规待处理产品</a><span>&gt;</span>重复产品组管理 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="col-main-warp">
        <div id="right">
          <form id="form1" method="post" name="form1" action="/prodrepeat/prodrepeatgroup/grouplist.do">
            <input id="page" name="page" type="hidden">
            <div class="col-boxpd col-linebom">
              <h2>违规待处理产品 - 重复产品组</h2>
            </div>
            <div class="col-sailtips clearfix"> <span class="leftcol-tip">温馨提示：</span>
              <div class="rightcol-tip">
                <p id="hideTipsBox" class="addheight">1.重复产品组：每个保留产品对应的产品组中，您需进行处理，若超30天未处理，将会被搜索降权和下架处理。<br>
                  <a class="lkundeline" href="http://policy.dhgate.com/policy_list.php?catalogno=110301" target="_blank">了解《禁止发布重复产品规则》</a><br>
                  2.疑似侵权产品：您可以通过修改产品信息并提交，进入平台进一步的审核。<br>
                  3.品牌投诉产品：若有相关品牌商对您的产品进行了投诉，敦煌网将在1个工作日内对投诉产品进行核实，核实无误后将<br>
                  进行下架处理。<a class="lkundeline" href="mailto:sellerservice@dhgate.com" target="_blank">有疑问请联系敦煌客服</a> </p>
                <span id="viewTips" class="viewticps viewshow">展开</span> </div>
            </div>
            <div style="display: none;" class="authenticn-box">
              <div class="aut-title">重复产品组列表(<span class="color-ry">0</span>)</div>
            </div>
            <div class="rtab-warp">
              <ul class="clearfix">
                <li class="current"> <a href="javascript:void(0);"> <span> 重复产品组(<b>0</b>) </span> </a> </li>
                <li> <a href="/prodmanage/audit/prodViolate.do?dhpath=10001,70,7002"> <span id="violateProductNum"> 疑似侵权产品(<b>0</b>) </span> </a> </li>
                <li> <a href="/prodmanage/audit/prodfreeze.do?dhpath=10001,70,7002"> <span id="freezeProductNum"> 冻结产品(<b>0</b>) </span> </a> </li>
                <li> <a href="/prodmanage/audit/prodBrandComplaint.do?dhpath=10001,70,7002"> <span id="brandComplaintProductNum"> 品牌商投诉产品(<b>0</b>) </span> </a> </li>
                <li style="display: none;"><a href="javascript:void(0);"><span>冻结产品(<b>20</b>)</span></a></li>
              </ul>
            </div>
            <div class="mksearchbox"> 产品名称：
              <input id="searchProductName" class="mksearchinput marg-r10" name="groupQvo.retainProdDto.productName" value="" type="text">
              保留产品状态：
              <select class="mksearchselect marg-r10" name="groupQvo.retainProdDto.retainSource">
                <option value="">全部</option>
                <option value="1">系统推荐</option>
                <option value="2">手动设置</option>
              </select>
              <span class="yellowBtn valmiddle">
              <input id="btn_query" value="搜 索" type="button">
              </span> </div>
            <div class="movekeyd"><span class="marg-r10">您目前共有<b class="promptcolor">0</b>个重复产品组，共计<b class="promptcolor">0</b>个重复产品，请在<b class="promptcolor"> 0 </b>天内进行修改，逾期将系统自动删除未处理的重复产品。</span></div>
            <!-- 列表 开始 -->
            <div class="bg-list">
              <table border="0" cellSpacing="0" cellPadding="0" width="100%">
                <tbody>
                  <tr>
                    <th width="40%" colSpan="2">产品信息</th>
                    <th width="30%">保留产品的状态</th>
                    <th class="last" width="30%">操作</th>
                  </tr>
                </tbody>
              </table>
            </div>
            <!-- 列表 结束 -->
            <!--分页 开始-->
            <!--分页 结束-->
          </form>
          <script src="http://js.dhresource.com/seller/searchfilter/filter.js?version=2014-10-13"></script>
          <script language="JavaScript" type="text/javascript"> 
$('#searchProductName').searchFilter({
       keyword: ['<','>', ' ', '&nbsp;'],
       form: '#form1'
})
</script>
          <script language="JavaScript" type="text/javascript"> 
jQuery(function($) {

    
	$("#btn_query").click(function() {
		document.getElementById("form1").submit();
	}); 
	
	
});

</script>
        </div>
      </div>
    </div>
    
   <#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#goodsLeftbar")}
 

  </div>
</div>
