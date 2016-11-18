<link rel="stylesheet" type="text/css" href="../seller/css/seller.css">
<link rel="stylesheet" type="text/css" href="../seller/css/common20111215.css?version=2014-10-13">
<script type="text/javascript" src="http://stats.g.doubleclick.net/dc.js"></script>
<script type="text/javascript" src="http://www.dhresource.com/2008/web20/seller/js/syi/matrix/jquery-1.5.1.min.js?version=2014-10-13"></script>
<script type="text/javascript" src="http://www.dhresource.com/dhs/mos/js/public/menu-common_20111226.js?ver=2013&amp;version=2014-10-13"></script>
<!--<script type="text/javascript" src="http://seller.dhgate.com/js/publish/menu-common_20111226.js"></script>-->
<link rel="stylesheet" href="../seller/css/jquery-calendar.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/my-products.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/syi/syi_pop.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/seller_button.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/general_popup_box.css?version=2014-10-13">
<!--<link href="http://www.dhresource.com/dhs/mos/css/stockingmanagement/stockingsyipop.css?version=2014-10-13" rel="stylesheet" type="text/css"/>-->
<!--<script type="text/javascript" src="http://seller.dhgate.com/js/publish/menu-common_20111226.js"></script>-->
<link rel="stylesheet" type="text/css" href="../seller/css/seller_button.css">
<link rel="stylesheet" type="text/css" href="../seller/css/jquery-calendar.css">
<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/jquery-time.js"></script>
<script type="text/javascript">     
          $(document).ready(function(){
		  	jQuery.ajaxSetup({
				cache:false
			});
          	$('.calendarFocus').calendar();
			$("#searchItemcode").keyup(function(){
				$(this).val($(this).val().replace(/^[0]|\D/g, ""));
				var itemcode = $(this).val();
				if(itemcode.length > 18){
					$(this).val(itemcode.substr(0,18));
				}
			});
			$("#searchItemcode").change(function(){
				$(this).val($(this).val().replace(/^[0]|\D/g, ""));
				var itemcode = $(this).val();
				if(itemcode.length > 18){
					$(this).val(itemcode.substr(0,18));
				}
			});
          });
   		</script>
<div class="content">
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202">产品</a><span>&gt;</span>申诉管理 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="col-main-warp">
        <div id="right">
          <form id="prodAppealForm" method="post" name="prodAppealForm" action="/prodmanage/appeal/prodAppeal.do">
            <div id="right">
              <ul id="tbt">
                <li class="libg"><span>申诉管理</span></li>
              </ul>
              <div class="s_notice_1">
                <dl>
                  <dd>本月已申诉 <b>0</b> 次，可用申诉机会 <b>10</b> 次，累计申诉成功率：<b>0%</b></dd>
                  <dt><a href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0202&amp;cate=产品审核规则&amp;artid=8C475ADFF2B3F299E0400A0AD20A26F3">了解申诉规则</a>
                  <dt> </dt>
                </dl>
              </div>
              <div class="seller-form">
                <table border="0" cellSpacing="0" cellPadding="0" width="100%">
                  <tbody>
                    <tr>
                      <td class="le"> 产品编号：
                        <input id="searchItemcode" class="input1" name="prodAppealForm.itemcode" value="" size="20" type="text">
                        <select style="width: 130px;" id="istate" size="1" name="prodAppealForm.istate">
                          <option value="">选择处理状态</option>
                          <option value="0">待处理</option>
                          <option value="1">已处理</option>
                        </select>
                      </td>
                    </tr>
                    <tr>
                      <td class="le">申诉时间：
                        <input id="searchBeginDate" class="but3 calendarFocus" name="prodAppealForm.searchBeginDateStr" readOnly="" value="" type="text">
                        <span class="calendar_append"></span> 到
                        <input id="searchEndDate" class="but3 calendarFocus" name="prodAppealForm.searchEndDateStr" readOnly="" value="" type="text">
                        <span class="calendar_append"></span></td>
                    </tr>
                    <tr>
                      <td class="le"><button onclick="document.prodAppealForm.submit();" type="button"><span style="color: rgb(255, 255, 255);" class="button1_lt"><span class="button1_ri">搜 索</span></span></button></td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <table border="1" cellSpacing="0" borderColor="#c8d9e9" cellPadding="0" width="100%">
                <tbody>
                  <tr class="bbg">
                    <td>产品图片</td>
                    <td>产品编号</td>
                    <td>产品名称</td>
                    <td width="90">申诉时间</td>
                    <td width="20%">申诉理由</td>
                    <td width="90">处理状态</td>
                    <td width="20%">处理结果说明</td>
                  </tr>
                </tbody>
              </table>
              <div id="page"> </div>
            </div>
          </form>
        </div>
      </div>
    </div>
   
   <#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#goodsLeftbar")}
 
  </div>
</div>
