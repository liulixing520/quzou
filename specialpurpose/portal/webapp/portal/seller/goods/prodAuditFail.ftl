<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head> 
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
  <title>未通过审核的产品 </title>  
  <script type="text/javascript" src="http://www.dhresource.com/2008/web20/seller/js/syi/matrix/jquery-1.5.1.min.js?version=2014-10-13"></script> 
  <script type="text/javascript" src="http://www.dhresource.com/dhs/mos/js/public/menu-common_20111226.js?ver=2013&amp;version=2014-10-13"></script> 
  <!--<script type="text/javascript" src="http://seller.E岸通.com/js/publish/menu-common_20111226.js"></script>--> 
	<link rel="stylesheet" href="../seller/css/jquery-calendar.css">
	<link rel="stylesheet" type="text/css" href="../seller/css/my-products.css">
	<link rel="stylesheet" type="text/css" href="../seller/css/syi_pop.css">
	<link rel="stylesheet" type="text/css" href="../seller/css/seller_button.css">
	<link rel="stylesheet" type="text/css" href="../seller/css/general_popup_box.css">
	<link rel="stylesheet" type="text/css" href="../seller/css/product.css">
  <!--<link href="http://www.dhresource.com/dhs/mos/css/stockingmanagement/stockingsyipop.css?version=2014-10-13" rel="stylesheet" type="text/css"/>--> 
  <!--<script type="text/javascript" src="http://seller.E岸通.com/js/publish/menu-common_20111226.js"></script>--> 
  <meta charset="utf-8" /> 
  <style type="text/css">
			#panelgroup {
				display: none;
				position: absolute;
				width: 360px; *	
				border-bottom: 2px #f1f1f1 solid;
				border-left: 2px #f1f1f1 solid
			}
			#panel{
				display: none;
				position: absolute;
				width: 364px; *
				border-bottom: 2px #f1f1f1 solid;
				border-left: 2px #f1f1f1 solid
			}
		</style> 
 </head> 
 <body> 
  <link href="http://www.dhresource.com/dhs/mos/css/inbox/remind.css" rel="stylesheet" type="text/css" /> 
  <script type="text/javascript" src="http://js.dhresource.com/seller/message/listener.js"></script> 
  <!-- Google Analytics Tracking Code - 20111216 - START --> 
  <script type="text/javascript"> 
	$(function(){ 
		$(".breadcrumb").append("<li class='active'>管理产品</li><li class='active'>审核未通过的产品</li>")
	}); 
 </script> 
  <!-- Google Analytics Tracking Code - 20111216 - END --> 
  <script type="text/javascript"> 
function know(){
	$("#iKnow").click(function(){
		
		$("#mapRemind").hide();
	})
}
var sellerAuth={};
sellerAuth = {alert :function(title,msg,isClose){
    	$("#auth_alert_content").html(msg);
		
		if(title==''){
			title = '提示信息';
		}
		$("#auth_alert_title").html(title);
		
    	$("#auth_alert_btn1").hide();
    	$("#auth_alert_btn2").hide();
    	
    	if(isClose){
    		$("#auth_alert_btn1").show();
    		$("#auth_alert_btn2").show();
    		
    	}
    	$("#auth_alert").modal({close:false});
	},
	checkAuth:function(funcid,catePubId){
		var result = true;		
		var url = "http://seller.TradeEase.com/myTradeEase/sellerauth.do?act=ajaxCheckFuncAuth";
		jQuery.ajax({
	       	url: url,
	       	data:{"funcid":funcid,"catePubId":catePubId,"isblank":true},
	       	dataType: 'json',
	       	async:false ,
	       	 //timeout: 3000,
	        type: 'POST',
	       	success: function(data) {
				if(data.result =='1'){
					var msg = data.authLimitFuncDto.limitMsg;
					msg="您的账户已被“"+msg +"”无法进行此操作";
					sellerAuth.alert('',msg,true);
					result = false;
				}

	       	},
	       	error: function(xhr, status, error) {
           }            
   		});
		
		return result;
	},
	getCurrentModelid:function(){
		var result = "";
		result = $("#currentPath").val();
		if(result){
			if(result.indexOf(",")>0){
				var models = result.split(",");
				result = models[models.length-1]
			}
		}
		return result;
	}	
	
}
</script> 
  <div class="content"> 
   <div class="layout clearfix"> 
    <div class="col-main"> 
     <div class="col-main-warp"> 
      <div id="right"> 
        <div class="col-boxpd col-linebom"> 
         <h2>管理产品 - 未通过审核</h2> 
        </div> 
        <div class="col-sailtips clearfix"> 
         <span class="leftcol-tip">温馨提示：</span> 
         <div class="rightcol-tip"> 
          <p id="hideTipsBox" class="addheight">
              1.您添加的产品需要通过审核后才能上架交易，审核时间通常在24-28个小时之内，遇特殊情况会稍有延迟，敬请谅解<br />
              2.请核对您添加的产品是否符合<a href="http://edu.TradeEase.com/" class="lkundeline">商城网产品发布规则</a>，不符合规则的产品将不能通过审核<br />
              3.现在起您发布的上架产品都能够展示在店铺中了！同时还能设置加载搜索产品，获取更多曝光率！<a href="http://help.TradeEase.com/" class="lkundeline">了解更多</a> </p>
          <span class="viewticps viewshow " id="viewTips">展开</span> 
         </div> 
        </div>
        <form action="<@ofbizUrl>prodAuditFail</@ofbizUrl>" method="post"> 
        <div class="condbox clearfix searchConditions" id="newGuideTarget3"> 
         <span class="tname">产品编号：</span> 
         <input type="text" id="searchItemcode" name="productNum" class="cond-input condwid1 defaultcolor" data-value="输入完整产品编号" value="" /> 
         <span class="tname">产品名称：</span> 
         <input type="text" id="productName" name="productName" class="cond-input condwid1s defaultcolor" data-value="输入产品名或关键词" value="" />
         <#-- 
         <span class="tname">更新日期：</span> 
         <input type="text" class="cond-input condwid3 calendarFocus" name="prodAuditFailForm.operateDateBeginStr" id="operateDateBegin" value="" readonly="" /> 
         <span>到</span> 
         <input type="text" class="cond-input condwid3 calendarFocus" name="prodAuditFailForm.operateDateEndStr" id="operateDateEnd" value="" readonly="" /> 
         <div class="padline15"></div> 
         <span class="tname">产品组：</span> 
         <select name="" id="firSelectproductgroup" class="j-select-root mksearchselect addwid113"></select> 
         <select name="" id="secSelectproductgroup" class="j-select-sub mksearchselect addwid113" style="display:none;"></select> 
         <input type="hidden" class="j-select-hidden" id="selectproductgroup" name="prodAuditFailForm.selectedProdGroupId" value="" /> 
         <span class="tname" style="display:none;">营销状态：</span> 
         <select class="listing-box condwid2" name="" style="display:none;"> <option value="选择产品分组">请选择营销状态</option> <option value="选择产品分组1">选择营销状态1</option> <option value="选择产品分组2">选择营销状态2</option> <option value="选择产品分组3">选择营销状态3</option> </select>
         --> 
         <span class="yellowBtn valmiddle"><input type="submit" value="搜索" id="searchSubmitbtn" /></span> 
         <span class="tourBtn valmiddle"><input type="button" value="重置" id="searchResetbtn" /></span> 
        </div>
        </form> 
        <div class="rtab-warp" id="newGuideTarget2"> 
         <ul class="nav nav-tabs" style="padding-top:10px; padding-bottom:10px;"> 
          <li> <a href="<@ofbizUrl>goodsMgnt</@ofbizUrl>"> <span id="shelfProductNum"> 已上架(<b>10</b>) </span> </a> </li> 
          <li> <a href="<@ofbizUrl>prodAudit</@ofbizUrl>"> <span id="auditProductNum"> 待审核(<b>0</b>) </span> </a> </li> 
          <li class="current"> <a href="<@ofbizUrl>prodAuditFail</@ofbizUrl>"> <span id="auditFailProductNum"> 审核未通过(<b>0</b>) </span> </a> </li> 
          <li> <a href="<@ofbizUrl>prodDownShelf</@ofbizUrl>"> <span id="downShelfProductNum"> 已下架(<b>0</b>) </span> </a> </li> 
          <li style="display:none;"> <a href="javascript:void(0);"> <span>草稿箱(<b>20</b>)</span> </a> </li> 
         </ul> 
         <div class="propbox tipstion">  
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
            <th>未通过原因</th>
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
         <input type="hidden" name="prodAuditFailForm.isLastThreeMonth" value="1" id="isLastThreeMonth" /> 以下为最近三个月更新过的产品： 
         <a id="earlyMonthHref" href="javascript:void(0);">查看更早的产品</a> 
        </div> 
        <!-- 调研入口 开始 --> 
        <div class="studybox studypad margintop10"> 
         <span class="studyicon">产品管理不方便？</span>
         <a href="http://ued.E岸通.com/dhsurvey/index.php?sid=56887&amp;newtest=Y&amp;lang=zh-Hans" target="_blank">我要提意见</a> 
        </div> 
        <!-- 调研入口 结束 --> 
       </form> 
       <div id="panelgroup" style="display:none;"> 
        <div class="list"> 
         <div style="cursor:hand;" name="panelgroupselected" groupid="nogroup" groupname="nogroup" class="">
          未分组
         </div> 
         <!--       ===============================结果列表显示部分==========开始                   --> 
         <!--     ============================结果列表显示部分=====完===========         --> 
         <div style="text-align:right"> 
          <button type="button" class="button1 closebtn"> <span class="button6_lt" style="color:#2B2B2B;"> <span class="button6_ri">取消</span></span> </button>&nbsp; 
         </div> 
        </div> 
       </div> 
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
                <span class="yellowBtn valmiddle"><input type="button" id="btn_submitChangeGroup" value="确 定" /></span> 
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
       <div class="tc_warp" style="width:480px;display:none;" id="appealsubmit"> 
        <form name="productAppealForm" action="/myE岸通/product/productappeal.do?act=pageload&amp;biztype=" id="productAppealForm" method="post"> 
         <div class="tc_title"> 
          <dl> 
           <dt>
            我要申诉
           </dt> 
           <dd> 
            <a href="#blank" onclick="jQuery.modal.close();return false;"> <img src="http://image.E岸通.com/2008/web20/seller/img/reg_image/new_tc_close.gif" alt="close" /> </a> 
           </dd> 
          </dl> 
         </div> 
         <div class="tc_main"> 
          <div class="tc_content"> 
           <div class="box2"> 
            <p class="p1" id="appealsubmittip"></p> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
             <tbody>
              <tr class="tr1"> 
               <td width="80" valign="top">申诉理由：</td> 
               <td> <textarea class="color5" style="height: 60px; width: 355px;" rows="" cols="" name="appealreson" id="appealreson"></textarea> <input type="hidden" name="appealproductItemcode" id="appealproductItemcode" value="" /> </td> 
              </tr> 
              <tr class="tr1"> 
               <td height="36" align="center" colspan="2"> <button class="button1" type="button" id="btn_appealSub"> <span style="color:#fff" class="button1_lt"><span class="button1_ri">确定</span></span></button>&nbsp;&nbsp; <button class="button1" type="button" onclick="jQuery.modal.close();" id="appealCancel"> <span style="color:#6C6C6C" class="button2_lt"><span class="button2_ri">取消</span></span></button> </td> 
              </tr> 
             </tbody>
            </table> 
           </div> 
          </div> 
         </div> 
        </form> 
       </div> 
       <!--申诉成功提示窗口start zhlw--> 
       <div class="tc_warp" style="width:480px;display:none" id="appealsuccess"> 
        <div class="tc_title"> 
         <dl> 
          <dt>
           我要申诉
          </dt> 
         </dl> 
        </div> 
        <div class="tc_main"> 
         <div class="tc_content"> 
          <div class="box2"> 
           <p class="p3" id="appealsuccesstip"></p> 
           <div class="tc_content_button center" id="subupdateproduct"> 
            <button class="button1" type="button" onclick="this.disabled='disabled';window.location='/prodmanage/audit/prodAuditFail.do?dhpath=10001,21001,0215&amp;prodAuditFailForm.isNewVersion=1'"> <span style="color:#fff" class="button1_lt"><span class="button1_ri">确定</span></span> </button> 
           </div> 
          </div> 
         </div> 
        </div> 
       </div> 
       <!--申诉成功提示窗口end zhlw--> 
       <table id="banned" style="width:600px;display:none;" class="noshade-pop-table"> 
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
              <span>原因详情</span> 
             </div> 
             <div class="noshade-pop-inner"> 
              <div class="box1"> 
               <p class="s-margin2">尊敬的E岸通网商户，您好！</p> 
               <p class="s-margin2">欢迎您使用“我的E岸通”！您所发布产品信息由于涉嫌销售禁售产品而未能发布成功，禁售产品不能修改和申诉，建议您直接删除该产品。</p> 
               <p class="s-margin2">禁售产品信息包含但不仅限于：电子烟；虚拟物品；药品；医疗器械；化工产品；保健品；动植物提取物；管制刀具；警用品等。</p> 
               <p class="s-margin2">禁限售规则请参考：<br /><a href="http://policy.E岸通.com/policy_list.php?catalogno=110306" target="_blank">http://policy.E岸通.com/policy_list.php?catalogno=110306</a></p> 
               <p class="s-margin2">更多规则内容，请参阅E岸通网政策规则频道：<br /><a href="http://policy.E岸通.com/" target="_blank">http://policy.E岸通.com/</a></p> 
               <p class="s-margin2">如果您有任何疑问，请使用“在线留言”。</p> 
               <div class="align-center clearfix"> 
                <span class="tourBtn"><input type="button" value="关闭" name="btn_closeDetailInfo" detailinfoid="banned" /></span> 
               </div> 
              </div> 
             </div> 
             <div class="noshade-pop-bot"></div> 
            </div> 
            <a href="javascript:void(0)" class="noshade-pop-close" name="ahref_closeDetailInfo" detailinfoid="banned"></a> 
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
       <table id="violation" style="width:600px;display:none;" class="noshade-pop-table"> 
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
              <span>原因详情</span> 
             </div> 
             <div class="noshade-pop-inner"> 
              <div class="box1"> 
               <p class="s-margin2">尊敬的E岸通网商户，您好！</p> 
               <p class="s-margin2">欢迎您使用“我的E岸通”！您所发布产品信息内容涉及有关商标近似文字或包含其产品型号，涉嫌侵犯该商标所有人知识产权。您需要获得商标所有人的授权方可发布。</p> 
               <p class="s-margin2">如果您发布的是品牌产品，有相关授权许可证明，请将您的证明发送到：<a href="mailto:shouquan@E岸通.com" target="_blank">shouquan@E岸通.com</a>，并注明您的sellerID。我们在2个工作日内进行处理，如果您的授权证明真实有效，您可以正常发布。</p> 
               <p class="s-margin2">品牌列表请参考：<br /><a href="http://policy.E岸通.com/policy_list.php?catalogno=110307&amp;tab=1#" target="_blank">http://policy.E岸通.com/policy_list.php?catalogno=110307&amp;tab=1# </a></p> 
               <p class="s-margin2">更多规则内容，请参阅E岸通网政策规则频道：<br /><a href="http://policy.E岸通.com/" target="_blank">http://policy.E岸通.com/</a></p> 
               <p class="s-margin2">√ 如需删除或者修改产品信息，请按如下步骤：</p> 
               <p class="s-margin2">1.登陆“我的E岸通”，查看“我的产品”，点击“未通过审核产品”；</p> 
               <p class="s-margin2">2.删除信息或者点击“修改产品信息”对产品信息进行修改。</p> 
               <p class="s-margin2">√ 如果您觉得你的产品无违规问题，可以点击“我要申诉”</p> 
               <p class="s-margin2">如果您有任何疑问，请使用“在线留言”。</p> 
               <div class="align-center clearfix"> 
                <span class="tourBtn"><input type="button" value="关闭" name="btn_closeDetailInfo" detailinfoid="violation" /></span> 
               </div> 
              </div> 
             </div> 
             <div class="noshade-pop-bot"></div> 
            </div> 
            <a href="javascript:void(0)" class="noshade-pop-close" name="ahref_closeDetailInfo" detailinfoid="violation"></a> 
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
       <table id="repeat" style="width:600px;display:none;" class="noshade-pop-table"> 
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
              <span>原因详情</span> 
             </div> 
             <div class="noshade-pop-inner"> 
              <div class="box1"> 
               <p class="s-margin2">尊敬的E岸通网商户，您好！</p> 
               <p class="s-margin2">欢迎您使用“我的E岸通”！您所发布产品信息涉嫌图片重复/名称重复而未能发布成功，建议您调整对应的产品信息。</p> 
               <p class="s-margin2">重复产品规则请参考：<br /><a href="http://policy.E岸通.com/policy_list.php?catalogno=110301&amp;tab=0#" target="_blank">http://policy.E岸通.com/policy_list.php?catalogno=110301&amp;tab=0# </a></p> 
               <p class="s-margin2">更多规则内容，请参阅E岸通网政策规则频道：<br /><a href="http://policy.E岸通.com/" target="_blank">http://policy.E岸通.com/</a></p> 
               <p class="s-margin2">√ 如需查看或修改，请按如下步骤：</p> 
               <p class="s-margin2">1.登陆“我的E岸通”，查看“我的产品”，点击“未通过审核产品”；</p> 
               <p class="s-margin2">2.删除信息或者点击“修改产品信息”对产品信息进行修改。</p> 
               <p class="s-margin2">√ 如果您觉得你的产品无重复问题，可以点击“我要申诉”</p> 
               <p class="s-margin2">如果您有任何疑问，请使用“在线留言”。</p> 
               <div class="align-center clearfix"> 
                <span class="tourBtn"><input type="button" value="关闭" name="btn_closeDetailInfo" detailinfoid="repeat" /></span> 
               </div> 
              </div> 
             </div> 
             <div class="noshade-pop-bot"></div> 
            </div> 
            <a href="javascript:void(0)" class="noshade-pop-close" name="ahref_closeDetailInfo" detailinfoid="repeat"></a> 
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
       <table id="tort" style="width:600px;display:none;" class="noshade-pop-table"> 
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
              <span>原因详情</span> 
             </div> 
             <div class="noshade-pop-inner"> 
              <div class="box1"> 
               <p class="s-margin2">尊敬的E岸通网商户，您好！</p> 
               <p class="s-margin2">欢迎您使用“我的商城”！您所发布产品信息内容涉及有关商标相同或包含其产品型号，涉嫌侵犯该商标所有人知识产权。您需要获得商标所有人的授权方可发布。</p>
               <p class="s-margin2">如果您发布的是品牌产品，有相关授权许可证明，请将您的证明发送到：<a href="mailto:shouquan@TradeEase.com" target="_blank">shouquan@TradeEase.com</a>，并注明您的sellerID。我们在2个工作日内进行处理，如果您的授权证明真实有效，您可以正常发布。</p>
               <p class="s-margin2">品牌列表请参考：<br /><a href="http://policy.TradeEase.com/policy_list.php?catalogno=110307&amp;tab=1#" target="_blank">http://policy.E岸通.com/policy_list.php?catalogno=110307&amp;tab=1# </a></p>
               <p class="s-margin2">更多规则内容，请参阅E岸通网政策规则频道：<br /><a href="http://policy.E岸通.com/" target="_blank">http://policy.E岸通.com/</a></p> 
               <p class="s-margin2">√ 如需删除或者修改产品信息，请按如下步骤：</p> 
               <p class="s-margin2">1.登陆“我的E岸通”，查看“我的产品”，点击“未通过审核产品”；</p> 
               <p class="s-margin2">2.删除信息或者点击“修改产品信息”对产品信息进行修改。</p> 
               <p class="s-margin2">√ 如果您觉得你的产品无侵权问题，可以点击“我要申诉”</p> 
               <p class="s-margin2">如果您有任何疑问，请使用“在线留言”。</p> 
               <div class="align-center clearfix"> 
                <span class="tourBtn"><input type="button" value="关闭" name="btn_closeDetailInfo" detailinfoid="tort" /></span> 
               </div> 
              </div> 
             </div> 
             <div class="noshade-pop-bot"></div> 
            </div> 
            <a href="javascript:void(0)" class="noshade-pop-close" name="ahref_closeDetailInfo" detailinfoid="tort"></a> 
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
         <span class="tips-information">每次只能选择一个产品组</span>
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
          <span class="bigyellow-button valmiddle marg-r10"><input type="button" class="j-dialog-confirm" value="确 定" /></span> 
          <span class="biggrey-button"><input type="button" class="j-dialog-closer" value="取 消" /></span> 
         </div> 
        </div> 
       </div> 
       <!-- 产品组弹层 结束 --> 
       <script src="http://www.dhresource.com/dhs/mos/js/productgroup/dialog.js?version=2014-10-13"></script> 
       <script src="http://www.dhresource.com/dhs/mos/js/productgroup/pager.js?version=2014-10-13"></script> 
       <script src="http://www.dhresource.com/dhs/mos/js/productgroup/prodmanage.js?version=2014-10-13"></script> 
       <script type="text/javascript" src="http://js.dhresource.com/seller/pricesystem/prodmanage.js?version=2014-10-13"></script> 
       <script src="http://js.dhresource.com/seller/stusyi/stusyiAuth.js?version=2014-10-13"></script> 
      </div> 
     </div> 
    </div> 
 
   </div> 
  </div>   
 </body>
</html>