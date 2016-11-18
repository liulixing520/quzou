<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head> 
  <meta http-equiv="Content-Type" content="text/html; 

charset=utf-8" /> 
  <title>上架的产品 </title> 
   <script type="text/javascript">
  	 $(function(){ 
		$(".breadcrumb").append("<li class='active'>交易管理</li><li class='active'>已卖出的宝贝</li>")
	}); 
  </script> 
	<link rel="stylesheet" href="../seller/css/jquery-calendar.css">
	<link rel="stylesheet" type="text/css" href="../seller/css/my-products.css">
	<link rel="stylesheet" type="text/css" href="../seller/css/syi_pop.css">
	<link rel="stylesheet" type="text/css" href="../seller/css/seller_button.css">
	<link rel="stylesheet" type="text/css" href="../seller/css/general_popup_box.css">
	<link rel="stylesheet" type="text/css" href="../seller/css/product.css">
  <div class="content">  
   <div class="layout clearfix"> 
    <div class="col-main"> 
     <div class="col-main-warp"> 
      <div id="right"> 
        <div class="col-boxpd col-linebom"> 
         <h2>管理产品 - 已上架</h2> 
        </div> 
        <div class="col-sailtips clearfix"> 
         <span class="leftcol-tip">温馨提示： </span> 
         <div class="rightcol-tip"> 
          <p id="hideTipsBox" class="addheight"> 1.您添加的产品需要通过审 核后才能上架交易，审核时间通常在24-28个小时之内，遇特殊情况会稍有 延迟，敬请谅解<br /> 2.请核对您添加的产品是否 符合<a href="http://edu.dhgate.com/s65201d426c7deedbe040007f010020ec.h

tml" target="_blank" class="lkundeline">商城产品发布规则</a>， 不符合规则的产品将不能通过审核<br /> 3.现在起您发布的上架产品 都能够展示在店铺中了！同时还能设置加载搜索产品，获取更多曝光率！<a href="http://help.dhgate.com/dhgate/sellerhelpcn.php?

catid=0303&amp;cate=我的产品

&amp;artid=952624E6721930F3E0400A0AD40A6747" target="_blank" class="lkundeline">了解更多</a> </p> 
          <span class="viewticps viewshow 

" id="viewTips">展开</span> 
         </div> 
        </div>
        <form action="<@ofbizUrl>goodsMgnt</@ofbizUrl>" method="post"> 
        <div class="condbox clearfix searchConditions" id="newGuideTarget3"> 
         <span class="tname">产品编号：</span> 
         <input type="text" id="searchItemcode" name="productNum" class="cond-input condwid1 defaultcolor" data-value="输入完整产品编号" value="" /> 
         <span class="tname">产品名称：</span> 
         <input type="text" id="productName" name="productName" class="cond-input condwid1s defaultcolor" data-value="输入产品名或关键词" value="" />
		<#--
         <span class="tname">更新日期：</span> 
         <input type="text" class="cond-input condwid3 calendarFocus" name="downShelfForm.operateDateBeginStr" id="operateDateBegin" value="" readonly="" /> 
         <span>到</span> 
         <input type="text" class="cond-input condwid3 calendarFocus" name="downShelfForm.operateDateEndStr" id="operateDateEnd" value="" readonly="" /> 
         <div class="padline15"></div> 
         <span class="tname">产品组：</span> 
         <select name="" id="firSelectprouctgroup" class="j-select-root mksearchselect 

addwid113"></select> 
         <select name="" id="secSelectprouctgroup" class="j-select-sub mksearchselect 

addwid113" style="display:none;"></select> 
         <input type="hidden" class="j-select-

hidden" id="selectproductgroup" name="downShelfForm.selectedProdGroupId" value="" /> 
         <span class="tname">下架时间：</span> 
         <input type="text" class="cond-input condwid3 calendarFocus" name="downShelfForm.forceWithdrawalOnStartStr" id="forceWithdrawalOnStart" value="" readonly="" /> 
         <span>到</span> 
         <input type="text" class="cond-input condwid3 calendarFocus" name="downShelfForm.forceWithdrawalOnEndStr" id="forceWithdrawalOnEnd" value="" readonly="" /> 
         <span class="tname" style="display:none;">营销状态 ：</span> 
         <select class="listing-box 

condwid2" name="" style="display:none;"> <option value="选择产品

分组">请选择营销状态</option> <option value="选择产品

分组1">选择营销状态1</option> <option value="选择产品

分组2">选择营销状态2</option> <option value="选择产品

分组3">选择营销状态3</option> </select>
--> 
         <span class="yellowBtn valmiddle"><input type="submit" value="搜索" id="searchSubmitbtn" /></span> 
         <span class="tourBtn valmiddle"><input type="button" value="重置" id="searchResetbtn" /></span> 
        </div>
        </form> 
        <div class="rtab-warp" id="newGuideTarget2"> 
         <ul class="nav nav-tabs" style="padding-top:10px; padding-bottom:10px;"> 
          <li class="current"> <a href="<@ofbizUrl>goodsMgnt</@ofbizUrl>"> <span id="shelfProductNum"> 已上架(<b>10</b>) </span> </a> </li> 
          <li> <a href="<@ofbizUrl>prodAudit</@ofbizUrl>"> <span id="auditProductNum"> 待审核(<b>0</b>) </span> </a> </li> 
          <li> <a href="<@ofbizUrl>prodAuditFail</@ofbizUrl>"> <span id="auditFailProductNum"> 审核未通过(<b>0</b>) </span> </a> </li> 
          <li> <a href="<@ofbizUrl>prodDownShelf</@ofbizUrl>"> <span id="downShelfProductNum"> 已下架(<b>0</b>) </span> </a> </li> 
          <li style="display:none;"> <a href="javascript:void(0);"> <span>草稿箱 (<b>20</b>)</span> </a> </li> 
         </ul> 
         <div class="propbox tipstion"> 
         <!-- 
          <span class="yellowBtn"><input type="button" class="j-onekey" value="一键修改" /></span> 
          新增一键修改tip 
                <span class="tiparrow-posbox j-onekey-tip" 

style="display: none; left:-120px; top:-53px;">
                  <div class="tiparrow-box clearfix" 

style="width:180px">可以一键修改价格、延长有效期、修改备货期和调

整产品组
					<a href="javascript:;" 

class="tiparrow-close j-closer"></a>
                    <a class="tiparrow-iknow j-know" 

href="javascript:;">我知道了</a>
                    <div class="tiparrow-b" 

style="left:150px;"></div>
                  </div>
                </span>
                --> 
         </div> 
        </div> 
<div class="table-header"> Results for "Latest Registered Domains" </div>
        <!-- 列表 开始 --> 
        <div class="col-xs-12"> 
        <table border="0" cellSpacing="0" cellPadding="0" width="100%" class="table-bordered">
        <thead>
          <tr>
            <th class="center"> <label class="position-relative">
              <input type="checkbox" class="ace">
              <span class="lbl"></span> </label>
            </th>
            <th class="center">图片</th>
            <th class="center">商品名称</th>
            <th>产品组</th>
            <th class="hidden-480">价格</th>
            <th> <i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i> 订单数</th>
            <th class="hidden-480">有效期</th>
            <th>营销状态</th>
            <th>操作</th>
          </tr>
        </thead>
          <tbody>
            <#if productList?has_content> 
				<#assign productIndex = 1>
				<#list productList as productCategoryMember>
					${setRequestAttribute("optProductId", productCategoryMember.productId)}
					${setRequestAttribute("productIndex", productIndex)}
					${screens.render("component://portal/widget/SellerScreens.xml#productsummaryForList")}
					<#assign productIndex = productIndex + 1>
				</#list>
           </#if> 
          </tbody>
         </table> 
        </div> 
        <!-- 列表 结束 --> 
        <div class="sailhistory" style="display:none;"> 
         <input type="hidden" name="downShelfForm.isLastThreeMonth" value="1" id="isLastThreeMonth" /> 以下为最近三个月更新过 的产品： 
         <a id="earlyMonthHref" href="javascript:void(0);">查看更早的产品</a> 
        </div> 
        <!-- 调研入口 开始 --> 
        <div class="studybox studypad margintop10"> 
         <span class="studyicon">产品管理不方便？</span>
         <a href="http://ued.dhgate.com/dhsurvey/index.php?

sid=56887&amp;newtest=Y&amp;lang=zh-Hans" target="_blank">我要提意见 </a> 
        </div> 
        <!-- 调研入口 结束 --> 
       </form> 
       <div id="panelgroup" style="display:none;"> 
        <div class="list"> 
         <div style="cursor:hand;" name="panelgroupselected" groupid="nogroup" groupname="nogroup" class="">
          未分组
         </div> 
         <!--       ===============================结果

列表显示部分==========开始                   --> 
         <!--     

============================结果列表显示部分=====完===========   

      --> 
         <div style="text-align:right"> 
          <button type="button" class="button1 

closebtn"> <span class="button6_lt" style="color:#2B2B2B;"> <span class="button6_ri">取消</span></span> </button>&nbsp; 
         </div> 
        </div> 
       </div> 
       <table id="st_panel" style="width:384px;display:none;" class="noshade-pop-table"> 
        <tbody>
         <tr> 
          <td class="t-lt"></td> 
          <td class="t-mid"></td> 
          <td class="t-ri"></td> 
         </tr> 
         <tr> 
          <td class="m-lt"></td> 
          <td class="m-mid"> 
           <div class="mid-warp"> 
            <div class="noshade-pop-content"> 
             <div class="noshade-pop-title"> 
              <span>为产品选择可用的物流方式：</span> 
             </div> 
             <div class="noshade-pop-inner"> 
              <div class="list"> 
               <ul> 
                <li class="mb"> <select class="but" id="select_shippingmodel"> <option value="">未选择</option> <option value="1000001">新手运费模板</option> <option value="2000001">深圳仓运费模板</option> <option value="2000002">上海浦东仓运费模板</option> <option value="2000003">广州仓运费模板</option> <option value="2000004">无锡仓运费模板</option> <option value="2000005">义乌仓运费模板</option> </select> <span>模板：</span></li> 
                <li> 
                 <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
                  <tbody>
                   <tr class="ee"> 
                    <td width="28%">模板名称</td> 
                    <td width="72%">概要信息</td> 
                   </tr> 
                  </tbody>
                 </table> 
                 <div id="div_shippingmodelcontent" style="display:none"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
                   <tbody>
                    <tr id="st_1000001" style="display:none" name="st_info"> 
                     <td id="td_modelname" width="28%"> 新手运费模板 </td> 
                     <td id="td_modelitems" width="72%"> ePacket(仓) e- ulink(标) JCEX(仓) JILLION(仓) </td> 
                    </tr> 
                    <tr id="st_2000001" style="display:none" name="st_info"> 
                     <td id="td_modelname" width="28%"> 深圳仓运费模板 </td> 
                     <td id="td_modelitems" width="72%"> 暂时停用 </td> 
                    </tr> 
                    <tr id="st_2000002" style="display:none" name="st_info"> 
                     <td id="td_modelname" width="28%"> 上海浦东仓运费模 板 </td> 
                     <td id="td_modelitems" width="72%"> 暂时停用 </td> 
                    </tr> 
                    <tr id="st_2000003" style="display:none" name="st_info"> 
                     <td id="td_modelname" width="28%"> 广州仓运费模板 </td> 
                     <td id="td_modelitems" width="72%"> 暂时停用 </td> 
                    </tr> 
                    <tr id="st_2000004" style="display:none" name="st_info"> 
                     <td id="td_modelname" width="28%"> 无锡仓运费模板 </td> 
                     <td id="td_modelitems" width="72%"> 暂时停用 </td> 
                    </tr> 
                    <tr id="st_2000005" style="display:none" name="st_info"> 
                     <td id="td_modelname" width="28%"> 义乌仓运费模板 </td> 
                     <td id="td_modelitems" width="72%"> 暂时停用 </td> 
                    </tr> 
                   </tbody>
                  </table> 
                 </div> </li> 
                <li class="mm"> <a href="http://seller.dhgate.com/frttemplate/pageload.do?

act=pageload&amp;dhpath=10001,0205">运费模板管理</a> <input name="button3" id="btn_updateShippingModel" type="button" class="bot btn-

slide" value="应用运费" /> <input name="button3" type="button" class="bot closebtn" value="取  消" /> </li> 
               </ul> 
              </div> 
             </div> 
             <div class="noshade-pop-bot"></div> 
            </div> 
            <a href="javascript:void(0)" id="ahref_cancelChangeGroup" class="noshade-pop-close"></a> 
           </div> </td> 
          <td class="m-ri"></td> 
         </tr> 
         <tr> 
          <td class="b-lt"></td> 
          <td class="b-mid"></td> 
          <td class="b-ri"></td> 
         </tr> 
        </tbody>
       </table> 
       <table id="productGroupTable" style="width:480px;display:none;" class="noshade-pop-table"> 
        <tbody>
         <tr> 
          <td class="t-lt"></td> 
          <td class="t-mid"></td> 
          <td class="t-ri"></td> 
         </tr> 
         <tr> 
          <td class="m-lt"></td> 
          <td class="m-mid"> 
           <div class="mid-warp"> 
            <div class="noshade-pop-content"> 
             <div class="noshade-pop-title"> 
              <span>请选择要加入的产品组：</span> 
             </div> 
             <div class="noshade-pop-inner"> 
              <div class="tips-common">
               <span class="tips-information">每次只能选择一个产品组</span>
              </div> 
              <div class="progroupbox"> 
               <ul> 
               </ul> 
              </div> 
              <div class="box1"> 
               <div class="align-center clearfix"> 
                <span class="yellowBtn 

valmiddle"><input type="button" id="btn_submitChangeGroup" value="确 定" /></span> 
                <span class="tourBtn"><input type="button" id="btn_cancelChangeGroup" value="取 消" /></span> 
               </div> 
              </div> 
             </div> 
             <div class="noshade-pop-bot"></div> 
            </div> 
            <a href="javascript:void(0)" id="ahref_cancelChangeGroup" class="noshade-pop-close"></a> 
           </div> </td> 
          <td class="m-ri"></td> 
         </tr> 
         <tr> 
          <td class="b-lt"></td> 
          <td class="b-mid"></td> 
          <td class="b-ri"></td> 
         </tr> 
        </tbody>
       </table> 
       <!-- 产品组弹层 开始 --> 
       <div class="dialog-inner-prodgroup" style="width:622px;display:none;"> 
        <div class="tips-common">
         <span class="tips-information">每次 只能选择一个产品组</span>
        </div> 
        <div class="progroupbox"> 
         <ul class="j-prodgroup-list"></ul> 
        </div> 
        <!--分页 开始--> 
        <div class="commonpage j-prodgroup-pager"></div> 
        <!--分页 结束--> 
        <div class="tips-common" style="display:none;"> 
         <span class="tips-error">错误提示</span> 
        </div> 
        <div class="box1"> 
         <div class="align-center clearfix"> 
          <span class="bigyellow-button valmiddle marg-

r10"><input type="button" class="j-dialog-confirm" value="确 定

" /></span> 
          <span class="biggrey-button"><input type="button" class="j-dialog-closer" value="取 消" /></span> 
         </div> 
        </div> 
       </div> 
       <!-- 产品组弹层 结束 --> 
       <script src="http://www.dhresource.com/dhs/mos/js/productgroup/dialog.j

s?version=2014-10-13"></script> 
       <script src="http://www.dhresource.com/dhs/mos/js/productgroup/pager.js

?version=2014-10-13"></script> 
       <script src="http://www.dhresource.com/dhs/mos/js/productgroup/prodmana

ge.js?version=2014-10-13"></script> 
       <script type="text/javascript" src="http://js.dhresource.com/seller/pricesystem/prodmanage.js?

version=2014-10-13"></script> 
       <script src="http://js.dhresource.com/seller/stusyi/stusyiAuth.js?

version=2014-10-13"></script> 
      </div> 
     </div> 
    </div> 

   </div> 
  </div> 
 </body>
</html>