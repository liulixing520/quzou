<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery-1.5.1.min.js"></script>

<script type="text/javascript">

var dh_survey_params = {
         ptype: "MyDHgate-S" ,
		 other: "slevel|S"
}

$(document).ready(function () {
  //招行银行在线贷款弹出层处理
  bankcorp.cmb.showCmbLoanPopWin();
	initSummary();
	getProductVaildday3R7();
	getProductVaildday30();
	getProductTS();
	getProductXJ();
	getProductBJ();
	getOrderInfo();
	getMarketInfo();
	getProductDefect();
    
    $("#apply_remark").click(function(){
       var remark = $("#apply_remark").val();
       if(remark=="请输入内容"){
          $("#apply_remark").attr('value','');
       }
    });

    $("#apply_remark").blur(function(){
    chkApplyRemark();
    });
	
	//增加跟踪代码 20120606 去掉
	//pt("idx_n");
	readWantitnow();
});

/*
function pt(idx){
    try {
    var t = _dht.getTracker();
    t.setVar('vd',idx);
    t.pageview('sidx'); 
    } catch(e) {} 
}*/

function showDivFrozenApply(){
   $("#div_frozen_apply").modal({close:false});
}

function showDivFrozenDetail(){
   $("#div_frozen_detail").modal({close:false});
}

function applyFormSummit(){
   var bool = chkApplyRemark();
   if(bool){
     $("#applyForm").submit();
   }
}



function chkApplyRemark(){
   var remark = $("#apply_remark").val();
   var ret = '';
   //alert(remark.length);
   if(remark.length>200){
	 ret = '<font color=red>申请原因不能大于200个字符！</font>';
     $("#error_apply_remark").html(ret);
	 $("#error_apply_remark").show();
     $("#apply_remark").focus();
	 return false;
   }else{
     $("#error_apply_remark").hide();
     $("#error_apply_remark").html(ret);
   }
   
    remark = remark.replace(/</g,"&lt;").replace(/>/g,"&gt;");
    $("#apply_remark").attr('value',remark);
   
   return true;
}

//已确认服务更新数据
function readservice(serviceid){

var strURL ="/usr/signin.do?act=readservice&id="+serviceid; 
jQuery.ajax({
   		type: "GET",
   		url: strURL,
   		dataType: "json",
   		async : true,
	    success: function(data){
	  		
	    },
	    error: function (data, status, e)
       {
       }
	}); 
}

initChart();


//获取求购信息
function readWantitnow(){
var wantURL ="/usr/wantitnowfive.do"; 
        jQuery.ajax({
       		type: "GET",
       		url: wantURL,
       		dataType: "html",
       		async : true,
    	    success: function(data){
    	  		$("#wantitnowid").html(data);
    	    }
    	}); 
       }
 

</script>
<!-- Google Analytics Tracking Code - 20111216 - START -->
<script type="text/javascript"> 
var _gaq = _gaq || [];
_gaq.push(
	['_setAccount', 'UA-425001-1'],
	['_setDomainName', '.dhgate.com'],
	['_trackPageview', location.pathname + location.search + escape(location.hash)]
);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
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
		var url = "http://seller.dhgate.com/mydhgate/sellerauth.do?act=ajaxCheckFuncAuth";
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

//初始化数量信息（站内信，客服留言）
$(document).ready(function (){
	//产品管理黄金展位菜单提示
	$(document).ready(function(e) {
		var text = $("#Menu_10004 .nav-directory a:last").text();
		if(text =="类目黄金展位产品"){
			$("#Menu_10004 .nav-directory a:last").attr("title","增值卖家专属的类目黄金展位产品")
		}
	});

	jQuery.ajax({
       	url: "http://seller.dhgate.com/usr/signin.do?act=ajaxmessage&beforeday=150",
       	data:{"isblank":true},
       	dataType: 'json',
       	async:true ,
        timeout: 10000,
        type: 'POST',
       	success: function(result){
    		try{
				//客服留言-未读
				if(result.unreadcsmsg>0 ){
					$("#customServiceMessage").text(result.unreadcsmsg).show();//页头
    				$("#dhunreadCsMsg1").text( result.unreadcsmsg );//摘要首页 v1 & v2
    				$("#dhunreadCsMsg2").text( '('+result.unreadcsmsg+')' ).show();//横向一级菜单
    				$("#dhunreadCsMsg3").text( '('+result.unreadcsmsg+')' ).show();//左侧二级菜单
				}
				//所有站内信-未读
				if( result.unReadOfAll>0 ){
    				$("#newsletter").text( result.unReadOfAll ).show();//页头
					$("#dhunreadall1").text( result.unReadOfAll );//摘要首页 v1 & v2
					$("#dhunreadall1").addClass("a1");
    				$("#dhunreadall2").text( '('+result.unReadOfAll+')' ).show();//横向一级菜单
    				$("#dhunreadall3").text( '('+result.unReadOfAll+')' ).show();//左侧二级菜单
				}
				//买家消息-未读
				if(result.unReadOfSellerBuyer>0){
    				$("#dhunReadProduct1").text( '('+result.unReadOfSellerBuyer+')' ).show();//左侧二级菜单
				}
				//系统消息-未读
				if(result.unReadOfSystem>0){
    				$("#dhunReadOrder1").text( '('+result.unReadOfSystem+')' ).show();//左侧二级菜单
				}
				//平台公告-未读
				if(result.unReadOfDhgate>0){
    				$("#dhunReadPayment1").text( '('+result.unReadOfDhgate+')' ).show();//左侧二级菜单
				}
				//垃圾箱-未读
				if(result.unReadOfDustbin>0){
    				$("#dhunReadDustbin1").text( '('+result.unReadOfDustbin+')' ).show();//左侧二级菜单
				}
				/*
				var phpmail = result.phpmail;
    	     	var unreadmsg = result.unreadcsmsg;
    			var noReadOrder = result.noReadOrder;
    			var noReadProduct = result.noReadProduct;
    			var noReadSystem = result.noReadSystem;
    			var noReadDustbin = result.noReadDustbin;
    			var noReadPayment = result.noReadPayment;
    			var noReadAll = result.noReadAll;
    			if($("#customServiceMessage").length > 0){
    				$("#customServiceMessage").html(unreadmsg);
    			}
    			if($("#dhunreadCsMsg2").length > 0){
    				$("#dhunreadCsMsg2").html(unreadmsg);
    			}
    			if($("#dhunReadProduct1").length > 0){
    				$("#dhunReadProduct1").html(noReadProduct);
    			}
    			if($("#dhunReadOrder1").length > 0){
    				$("#dhunReadOrder1").html(noReadOrder);
    			}
    			if($("#dhunReadPayment1").length > 0){
    				$("#dhunReadPayment1").html(noReadPayment);
    			}
    			if($("#dhunReadDustbin1").length > 0){
    				$("#dhunReadDustbin1").html(noReadDustbin);
    			}
				*/
			}catch(err){
			}
       	},
       	error: function(xhr, status, error){
        }
   	});
});

</script>

<div class="content">
  <div class="crumb"> 您的当前位置：我的商城 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="col-main-warp">
        <div class="seller-information"> <a  href="http://seller.dhgate.com/dmrs/dmrsaction.do" class="greybutton1"> <span>查看商户评级指标</span> </a>
          <div class="seller-center">
            <p>您好，<strong>sunvsoft</strong>&nbsp;!&nbsp;
              您有<a id="newletter1" href="/messageweb/newmessagecenter.do?msgtype=001,002,003&dhpath=10005,0301,51001" class="number-link">(<span id="dhunreadall1">0</span>)</a>封未读站内信 <a href="/mydhgate/csmsg/leavemsg.do?act=showListMsg" class="number-link" >(<span id="dhunreadCsMsg1">0</span>)</a>封未读客服留言 </p>
            <div class="seller-type">
              <dl class="clearfix">
                <dt>商户评级：</dt>
                <dd> <a href="http://seller.dhgate.com/dmrs/dmrsaction.do" >标准商户</a> </dd>
              </dl>
            </div>
            <!-- start:卖家后台展示纠纷率退款率 -->
            <div class="seller-percentage"> <span>纠纷率:<em>0.00%</em></span> <span>商户责任纠纷率:<em>0.00%</em></span> <span>退款率:<em>0.00%</em></span> <span>商户原因退款率:<em>0.00%</em></span> </div>
            <p class="ruleMsg"><a href="http://policy.dhgate.com/policy-list/c110803.html" target='_blank'>查看纠纷率/退款率规则</a></p>
            <!-- end:卖家后台展示纠纷率退款率 -->
          </div>
          <div class="dashed-line"></div>
          <div class="info-cue">
            <ul>
              <li id="bankverifyid" style="display:none" >[DHgate验证] 恭喜您！已经有买家购买了您的产品，您需要去做 <a href="#" class="a1" target="_blank">申请银行验证</a></li>
              <li>[DHgate验证] <span class="s-color8">身份认证成功</span>&nbsp; 您的身份认证申请已通过审核！ <a href="/merchant/identity.do?dhpath=10008,50">查看详情</a></li>
              <li> 上次登录：<span class="sign-time">2014-10-25 09:20</span> <a href="http://bbs.dhgate.com/thread-34786-1-1.html" title='安全提示' target="_blank">安全提示</a> </li>
              <li style="display:none;" id="sellerAuthPunishId">[账户相关] 您的账户已被处罚</li>
              <li id='b_accountid' style="display:none"> [虚拟账户] 您的虚拟账户余额目前小于0，暂不能使用订单贷款功能，虚拟账户充值完成后将恢复此功能。<a href="http://seller.dhgate.com/mydhgate/dhaccount/supplierpayment.do?act=pageload">去看看虚拟账户</a> <img style="display:none;" id="m0" src="http://image.dhgate.com/2008/web20/seller/img/blank.gif" width="11" height="11" class="m-new" /> </li>
              <li id="adcenterid" style="display:none"> [会员服务] 您的广告费余额为××元，有效期至2010年×月×日，请在有效期前使用。 </li>
              <li id="adcenterid" style="display:none"> [会员服务] 您的广告费余额为××元，有效期至2010年×月×日，请在有效期前使用。 <img style="display:none;" id="m1" src="http://image.dhgate.com/2008/web20/seller/img/blank.gif" width="11" height="11" class="m-new" /> </li>
              <li id="sellerstoreid" style="display:none"> [商铺相关] 目前，您的店铺橱窗中没有可以显示的产品，
                <!--<a href="/mydhgate/store/create.do?act=pageload&status=store">-->
                <a href="http://seller.dhgate.com/store/storeWindowManage.do?dhpath=10001,08,0803">现在就去管理商铺！</a> <img style="display:none;" id="m8" src="http://image.dhgate.com/2008/web20/seller/img/blank.gif" width="11" height="11" class="m-new" /> </li>
            </ul>
          </div>
        </div>
        <div class="common-box">
          <div class="main-title">
            <h2>我需要关注的</h2>
          </div>
          <div class="need-attent">
            <dl class="clearfix" id="myPunish" style="display:none">
              <dt>我的处罚：</dt>
              <dd>
                <ul class="my-product" id="myPunishUl">
                </ul>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>我的订单：</dt>
              <dd>
                <ul class="order-form">
                  <li id="thisdayId">今日新订单(0)</li>
                  <li id="waitdeliveryid">待发货(0)</li>
                  <li id="disputeid">纠纷中(0)</li>
                  <li id="nopayid">未付款(0)</li>
                  <li id="payoutid">已入账(0)</li>
                  <li id="applyid">可请款(0)</li>
                </ul>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>我的产品：</dt>
              <dd>
                <ul class="my-product">
                  <li  id="productvailddaynumid">3天内将过期(0)</li>
                  <li  id="productvailddaynum1id">30天内已过期(0)</li>
                  <li  id="productwithdrawaltypenumid">30天内有问题被下架(0)</li>
                  <li  id="productbrandcomplainnumid">被品牌商投诉(0)</li>
                  <li  id="notUserCrawlProdNumId" style="display:none">未修改的一键达(0)</li>
                  <li  id="prodRepeatId">重复产品管理(0)</li>
                  <li  id="needinventory">需补充备货(0)</li>
                  <li  id="productdefectnum">属性缺失产品(0)</li>
                </ul>
              </dd>
            </dl>
          </div>
        </div>
        <div class="common-box" >
          <div class="main-title">
            <h2>营销资源</h2>
          </div>
          <div class="market-resource">
            <ul class="order-form clearfix">
              <li><a href="http://adcenter.dhgate.com/index/">广告投放</a></li>
              <li  id="trafficbus"><a href='http://seller.dhgate.com/marketweb/trafficbus/pageload.do?dhpath=10004,33'>流量快车</a></li>
              <li  id="promo"><a href='http://seller.dhgate.com/promoweb/platformacty/actylist.do?ptype=1&dhpath=10004,30,30'>促销活动</a></li>
              <li  id="tuiguang"><a href='http://seller.dhgate.com/marketweb/vaslisting/pageload.do?dhpath=10004,34'>视觉精灵</a></li>
              <li  id="union"><a href='http://seller.dhgate.com/union/supplier/getprods.do?dhpath=10004,37,3701'>敦煌联盟</a></li>
              <li  id="gold" style="display:none"><a href='http://seller.dhgate.com/prodmanage/shelf/prodGoldStall.do?dhpath=10004,2610'>类目黄金展位</a></li>
              <li  id="tuiguang"><a href='http://seller.dhgate.com/marketing/signup/spread'>站外推广</a></li>
            </ul>
          </div>
        </div>
        <div class="common-box"  >
          <div class="main-titledata clearfix">
            <h2>数据智囊<span class="time" id ="lsdate"></span></h2>
            <a class="more" href="http://seller.dhgate.com/wisdom/shopanalysis/toprofile.do">查看更多?</a> </div>
          <!-- 数据图 开始 -->
          <div class="main-boxdata clearfix">
            <div class="marginb10 clearfix">
              <select id="indictor_select_id" onchange="selectIndicator();">
                <option value="1" selected >产品浏览量</option>
                <option value="2" >产品入篮量</option>
                <option value="3" >成交量</option>
                <option value="4" >成交金额</option>
                <option value="5" >订单量</option>
                <option value="6" >客单价</option>
                <option value="7" >成交人数</option>
                <option value="8" >产品浏览人数</option>
                <option value="9" >人均产品浏览量</option>
                <option value="10" >产品入篮人数</option>
              </select>
            </div>
            <div class="clearfix">
              <div id="chartdiv" align="center"></div>
            </div>
            <!-- 数据图 结束 -->
          </div>
        </div>
        <div id="mNotice"  class="newseller-remind">
          <div class="remind-con">
            <div class="flow-infor">
              <div class="flow-title">
                <h3>DHgate外贸交易流程</h3>
                <a id="newsellerRemindClose" class="newseller-remind-close"   onclick="closeNewBuyer();$('#mNotice').css({ display: 'none' });"  href="javascript:void(0)"></a> </div>
              <div class="step-pic"><img src="http://image.dhgate.com/dhs/mos/image/summary/step.png" /></div>
            </div>
            <div class="notice-infor">
              <ul>
                <li>您已经有了买家尚未付款的订单，<a href="http://bbs.dhgate.com/thread-7849-1-59.html" target="_blank">跟进未付款订单转化为付款订单！</a></li>
                <li><a href="http://seller.dhgate.com/seller/pro/98lp.html" target="_blank">怎样获取更多订单！</a></li>
              </ul>
            </div>
          </div>
        </div>
        <div class="common-box" id="wantitnowid"> </div>
        <div id="messagePop">
          <div class="message-con">
            <div class="message-title">
              <h3>贴心小管家</h3>
              <a href="javascript:void(0)" class="message-close" id="messageClose"></a> </div>
            <div class="message-main">
              <h4 id="noticetitle"></h4>
              <p class="newmessage" id="noticedetail"></p>
            </div>
          </div>
        </div>
        <!-- im自动登录 -->
        <script type="text/javascript" language="javascript">
	try{
		var v = new ActiveXObject("Zregproccom.LooyuCheck");
		if(v!= null){
			//得到客户端版本号
		    var version = v.GetLooyuVersion(); 
		    var dhtalkurl  = "";
		    if(dhtalkurl.indexOf("dhtalk") > -1){
				v.runClientProgram(dhtalkurl);		    
		    }
	 	}
	}catch(e){}
</script>
        <!-- 是否有7天内到期的产品 zhlw -->
        <!-- 提交更新请求start -->
        <div id="sevendayproduct" class="tc_warp" style="width:366px;display:none;">
          <div class="tc_title">
            <dl>
              <dt>产品过期提醒</dt>
              <dd><a href="javascript:void(0)" onclick="jQuery.modal.close();return false;"><img src="http://image.dhgate.com/2008/web20/seller/img/reg_image/new_tc_close.gif" alt="close" /></a></dd>
            </dl>
          </div>
          <div class="tc_main">
            <div class="tc_content">
              <div class="box1">
                <p id="sevendayproductinfo" class="p1"></p>
                <div class="tc_content_button center" id="subupdateproduct">
                  <button class="button1" type="button" onclick="jQuery.modal.close();sevendayproductupdate();"> <span style="color:#fff" class="button1_lt"><span class="button1_ri">确认提交</span></span> </button>
                    
                  <button class="button1" type="button" onclick="jQuery.modal.close();"> <span style="color:#000" class="button2_lt"><span class="button2_ri">取消</span></span> </button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- 提交更新请求end -->
        <!-- 更新结果start -->
        <div id="updateproduct" class="tc_warp" style="width:366px;display:none;">
          <div class="tc_title">
            <dl>
              <dt>有效期更新成功</dt>
              <dd><a href="javascript:void(0)" onclick="jQuery.modal.close();return false;"><img src="http://image.dhgate.com/2008/web20/seller/img/reg_image/new_tc_close.gif" alt="close" /></a></dd>
            </dl>
          </div>
          <div class="tc_main">
            <div class="tc_content">
              <div class="box1">
                <p id="updateproductresult" class="p1"></p>
                <div class="tc_content_button center" id="subupdateproduct">
                  <button class="button1" type="button" onclick="jQuery.modal.close();"> <span style="color:#fff" class="button1_lt"><span class="button1_ri">确定</span></span> </button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- 更新结果end -->
        <!-- 用户名包含错误字符 start -->
        <div id="currectchartid" class="tc_warp" style="width:366px;display:none;">
          <div class="tc_title">
            <dl>
              <dt>用户名修改提醒</dt>
              <dd><a href="javascript:void(0)" onclick="jQuery.modal.close();return false;"><img src="http://image.dhgate.com/2008/web20/seller/img/reg_image/new_tc_close.gif" alt="close" /></a></dd>
            </dl>
          </div>
          <div class="tc_main" id="modify_mess_id">
            <div class="tc_content" >
              <div class="box1">
                <p class="p1">由于您目前的登录名不符合平台规则,会影响到某些功能的正常使用(如IM功能),您可以现在修改登录名。</p>
                <div class="tc_content_button center" id="subupdateproduct">
                  <button class="button1" type="button" onclick="$('#modify_do_id').show();$('#modify_mess_id').hide();"> <span style="color:#fff" class="button1_lt"><span class="button1_ri">修改登录名</span></span> </button>
                </div>
              </div>
            </div>
          </div>
          <div class="tc_main" id="modify_success_id" style="display:none;">
            <div class="tc_content" >
              <div class="box1">
                <p class="p1" id="modify_success_mess_id"></p>
                <div class="tc_content_button center" id="subupdateproduct">
                  <button class="button1" type="button" onclick="jQuery.modal.close();return false;"> <span style="color:#fff" class="button1_lt"><span class="button1_ri">关闭</span></span> </button>
                </div>
              </div>
            </div>
          </div>
          <div class="tc_main"  id="modify_do_id" style="display:none;">
            <div class="tc_content">
              <div class="box1">
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="120" class="ri">原登录名：</td>
                    <td>sunvsoft</td>
                  </tr>
                  <tr>
                    <td class="ri"><span class="red">*</span>新登录名：</td>
                    <td><input type="text" name="new_username" id="new_username_id" size="20" maxlength="30"/></td>
                  </tr>
                  <tr>
                    <td class="ri"><span class="red">*</span>重复登录名：</td>
                    <td><input type="text" name="r_username" id="r_username_id" size="20" maxlength="30" /></td>
                  </tr>
                </table>
                <div class="tc_content_button center" id="subupdateproduct">
                  <button class="button1" type="button" onclick="modify_domain();"> <span style="color:#fff" class="button1_lt"><span class="button1_ri">确认修改</span></span> </button>
                </div>
                <p class="p1" id="error_id"></p>
              </div>
            </div>
          </div>
        </div>
        <input type="hidden" id="chart_flag_id" value="">
        <!-- 用户名包含错误字符 end -->
        <div class="tc_warp" id="div_servicenotice" style="width:380px;display:none;">
          <div class="tc_title">
            <dl>
              <dt>服务提醒</dt>
              <dd><a href="#blank" onclick="jQuery.modal.close();return false;"><img src="http://image.dhgate.com/2008/web20/seller/img/reg_image/new_tc_close.gif" alt="close" /></a></dd>
            </dl>
          </div>
          <div class="tc_main">
            <div class="tc_content">
              <div class="box1">
                <p class="p3"><b class="color7 s-size2" id="serviceid">您的“敦煌商务通”增值服务已成功开通。</b></p>
                <p id="servicetime">现在就可以享受该服务带来的便利了。</p>
                <div class="tc_content_button center">
                  <button type="button" id="servnamebutton" ><span style="color:#6C6C6C" class="button2_lt"><span class="button2_ri">关闭</span></span></button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div id="div_frozen_apply" class="tc_warp" style="width:480px;display:none">
          <form name="applyForm"  id="applyForm" method="post" action="/usr/applyfrozen.do?act=apply">
            <div class="tc_title">
              <dl>
                <dt>申请解冻</dt>
                <dd><a href="#blank"><img src="http://image.dhgate.com/2008/web20/seller/img/reg_image/new_tc_close.gif" alt="close" onclick="jQuery.modal.close();"/></a></dd>
              </dl>
            </div>
            <div class="tc_main">
              <div class="tc_content">
                <div class="box2">
                  <p class="p1">您于日因原因被冻结，如果已经修正违规行为，可以提交解冻申请，平台会根据情况执行解冻操作。</p>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr class="tr1">
                      <td width="100" valign="top">申请解冻理由：</td>
                      <td><textarea style="height: 60px; width: 335px;" rows="" cols="" name="apply_remark" id="apply_remark"></textarea>
                        <input type="hidden" name="onceid" value=""/>
                        <input type="hidden" name="supplierId" value="ff808081482fd3fd01485e24266e5056"/>
                        <input type="hidden" name="currentstate" value=""/>
                        <input type="hidden" name="frozentype" value=""/>
                        <input type="hidden" name="applyNum" value=""/>
                      </td>
                    </tr>
                    <tr class="tr1">
                      <td></td>
                      <td id="error_apply_remark"></td>
                    </tr>
                    <tr class="tr1">
                      <td valign="top">&nbsp;</td>
                      <td height="36"><button type="button" onclick="applyFormSummit();"> <span style="color:#fff" class="button1_lt"> <span class="button1_ri">提交</span> </span> </button>
                          
                        <button type="button" onclick="jQuery.modal.close();"> <span style="color:#6C6C6C" class="button2_lt"> <span class="button2_ri">取消</span> </span> </button></td>
                    </tr>
                  </table>
                </div>
              </div>
            </div>
          </form>
        </div>
        <div id="div_frozen_detail" class="tc_warp" style="width:600px;display:none">
          <div class="tc_title">
            <dl>
              <dt>了解详情</dt>
              <dd><a href="#"> <img src="http://image.dhgate.com/2008/web20/seller/img/reg_image/new_tc_close.gif" alt="close" onclick="jQuery.modal.close();"/></a></dd>
            </dl>
          </div>
          <div class="tc_main">
            <div class="tc_content">
              <div class="box2">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tc-table">
                  <tr class="bg2">
                    <td>操作类型</td>
                    <td>操作时间</td>
                    <td>细节信息</td>
                  </tr>
                </table>
                <p><a href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0805&artid=B9120EAFB2C020F0E04010AC0B64373A" target="_blank">敦煌网卖家解冻规则</a></p>
              </div>
            </div>
          </div>
        </div>
        <table class="noshade-pop-table" style="width:460px;display:none" id="pop_punishDetail" >
          <tr>
            <td class="t-lt"></td>
            <td class="t-mid"></td>
            <td class="t-ri"></td>
          </tr>
          <tr>
            <td class="m-lt"></td>
            <td class="m-mid"><div class="mid-warp">
                <div class="noshade-pop-content">
                  <div class="noshade-pop-title"> <span id="pop_punishDetail_title">黄牌：</span> </div>
                  <div class="noshade-pop-inner">
                    <div class="box1">
                      <table width="100%" class="general_popup" id="pop_punishDetail_content">
                        <tr> </tr>
                      </table>
                      <p>您可以<a href="http://seller.dhgate.com/messageweb/newmessagecenter.do?msgtype=001,002,003&dhpath=10005,0301,51001" target="_blank">查看站内信处罚通知</a>或<a href="http://policy.dhgate.com/policy_list.php?catalogno=110701" target="_blank">《敦煌网卖家通用处罚规则》</a></p>
                      <div class="align-center pop-button"> <a href="javascript:void(0)" class="greybutton1" onclick='jQuery.modal.close();'><span>关闭</span></a> </div>
                    </div>
                  </div>
                  <div class="noshade-pop-bot"></div>
                </div>
                <a class="noshade-pop-close" href="javascript:void(0)" onclick='jQuery.modal.close();'></a> </div></td>
            <td class="m-ri"></td>
          </tr>
          <tr>
            <td class="b-lt"></td>
            <td class="b-mid"></td>
            <td class="b-ri"></td>
          </tr>
        </table>
        <table id="E_6_publish" style="width:435px;display:none;" class="noshade-pop-table" >
          <tbody>
            <tr>
              <td class="t-lt"></td>
              <td class="t-mid"></td>
              <td class="t-ri"></td>
            </tr>
            <tr>
              <td class="m-lt"></td>
              <td class="m-mid"><div class="mid-warp">
                  <div class="noshade-pop-content">
                    <div class="noshade-pop-title"> <span>受处罚商户</span> </div>
                    <div class="noshade-pop-inner">
                      <div class="box1"> 由于您的账户连续6次被评定为“低于标准商户”，您的账户已被关闭。<br />
                        如有疑问，请联系敦煌网客服。 </div>
                    </div>
                    <div class="noshade-pop-bot"></div>
                  </div>
                </div></td>
              <td class="m-ri"></td>
            </tr>
            <tr>
              <td class="b-lt"></td>
              <td class="b-mid"></td>
              <td class="b-ri"></td>
            </tr>
          </tbody>
        </table>
        <table id="E_7_tips" style="width:435px;display:none;" class="noshade-pop-table" >
          <tbody>
            <tr>
              <td class="t-lt"></td>
              <td class="t-mid"></td>
              <td class="t-ri"></td>
            </tr>
            <tr>
              <td class="m-lt"></td>
              <td class="m-mid"><div class="mid-warp">
                  <div class="noshade-pop-content">
                    <div class="noshade-pop-title"> <span>提示</span> </div>
                    <div class="noshade-pop-inner">
                      <div class="box1"> 您的账户手机和邮箱至少有一项未通过敦煌网验证，请您尽快验证。否则将会影响您的交易。<br>
                        <a  href="http://seller.dhgate.com/merchant/changemobile.do?dhpath=10008,31,3103">立即去验证</a> </div>
                      <div class="align-center pop-button"> <a href="javascript:void(0)" class="greybutton1" onclick='jQuery.modal.close();'><span>关闭</span></a> </div>
                    </div>
                    <div class="noshade-pop-bot"></div>
                  </div>
                </div></td>
              <td class="m-ri"></td>
            </tr>
            <tr>
              <td class="b-lt"></td>
              <td class="b-mid"></td>
              <td class="b-ri"></td>
            </tr>
          </tbody>
        </table>
        <table style="width:410px;display:none;" class="noshade-pop-table" id="identitytips">
          <tbody>
            <tr>
              <td class="t-lt"></td>
              <td class="t-mid"></td>
              <td class="t-ri"></td>
            </tr>
            <tr>
              <td class="m-lt"></td>
              <td class="m-mid"><div class="mid-warp">
                  <div class="noshade-pop-content">
                    <div class="noshade-pop-title"> <span>提示信息：</span> </div>
                    <div class="noshade-pop-inner">
                      <div class="box1">
                        <p class="padbottom10 marginlf10"><b class="colorf60">您尚未申请身份认证！</b></p>
                        <p class="padbottom10 marginlf10">为了不影响您的正常提款，建议您立即申请，认证通过后将会赢得更多交易！</p>
                        <div class="align-center pop-button"> <span class="yellowBtn valmiddle">
                          <input type="button" value="申请身份认证" onclick="_dhq.push(['event', 'Seller_U0014']);window.location.href='/merchant/identity.do?dhpath=10008,50'">
                          </span> <span class="tourBtn">
                          <input type="button" value="取消" onclick="_dhq.push(['event', 'Seller_U0015']);jQuery.modal.close();return false;">
                          </span> </div>
                      </div>
                    </div>
                    <div class="noshade-pop-bot"></div>
                  </div>
                  <a href="javascript:void(0)" class="noshade-pop-close" onclick="jQuery.modal.close();return false;"></a> </div></td>
              <td class="m-ri"></td>
            </tr>
            <tr>
              <td class="b-lt"></td>
              <td class="b-mid"></td>
              <td class="b-ri"></td>
            </tr>
          <input type="hidden" name="sessionid" value=""/>
          </tbody>
        </table>
        <!--招行贷款弹层 开始-->
        <div id="popMask" style="display:none;">
          <iframe id="popMaskIframe"></iframe>
        </div>
        <div id="loanPopWrap" class="pop-up-wrap" style="display:none;">
          <table class="noshade-pop-table" style="width:500px;">
            <tr>
              <td class="t-lt"></td>
              <td class="t-mid"></td>
              <td class="t-ri"></td>
            </tr>
            <tr>
              <td class="m-lt"></td>
              <td class="m-mid"><div class="mid-warp">
                  <div class="noshade-pop-content">
                    <div class="noshade-pop-title"> <span><strong>在线贷款：</strong></span> </div>
                    <div class="noshade-pop-inner">
                      <div class="box1">
                        <div class="loan-pop">
                          <div class="loan-tip">
                            <ul class="loan-tip-con">
                              <li class="loan-tip-title">您已经满足在线申请贷款的条件！</li>
                              <li>您的可贷款金额：<span id="cmbPopWinTrustAmount" class="loan-tip-sum"></span>元</li>
                              <li id="cmbPopWinTrustValidDate" class="color-999"></li>
                            </ul>
                            <b class="loan-tip-arrow"></b>
                            <div class="loan-tip-shadow"></div>
                          </div>
                          <dl class="loan-tip-list">
                            <dt>您可以：</dt>
                            <dd>1. 通过“资金账户”下的“<a href="/bankcorp/cmb/onlineloan.do?dhpath=10006,0905" class="under-line">在线贷款</a>”申请贷款；</dd>
                            <dd>2. 或<a href="http://seller.dhgate.com/promotion/83-zhsloan.html" class="under-line">点击此链接</a>了解在线贷款的流程与规则；</dd>
                          </dl>
                          <p> <span class="loan-pop-button"> <a href="javascript:;" class="greybutton1 s-margin3" attr-close="close"><span attr-close="close">稍后再说</span></a><a href="/bankcorp/cmb/onlineloan.do?dhpath=10006,0905" class="yellowbutton1" attr-close="close"><span attr-close="close">立刻去看看</span></a> </span>
                            <input id="cmbNolongerPopWin" type="checkbox" class="loan-checkbox" onclick="bankcorp.cmb.noLongerPopWin();"/>
                            不再显示 </p>
                        </div>
                      </div>
                    </div>
                    <div class="noshade-pop-bot"></div>
                  </div>
                  <a class="noshade-pop-close" href="javascript:void(0)" attr-close="close"></a> </div></td>
              <td class="m-ri"></td>
            </tr>
            <tr>
              <td class="b-lt"></td>
              <td class="b-mid"></td>
              <td class="b-ri"></td>
            </tr>
          </table>
        </div>
        <!--招行贷款弹层 结束-->
        <!--   新版跟踪码                       -->
        <script language="JavaScript" type="text/javascript" >
        var _dhq = _dhq || [];
        (function() {
            var dha = document.createElement('script'); dha.type = 'text/javascript'; dha.async = true;
            dha.src = ('https:' == document.location.protocol ? 'https://secure.dhgate.com/scripts/dhta.js' : 'http://www.dhresource.com/dhs/fob/js/common/track/dhta.js');
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(dha, s);
        })();
</script>
        <script type="text/javascript" src="http://www.dhresource.com/dhs/fob/js/common/track/dhta2.js"></script>
        <script type="text/javascript">
(function(){  
try{  
_dhq2.push(["setVar","pt", "mydhgate"]);  
_dhq2.push(["event", "Public_S0003"]);  
} catch(e){}
    })();
</script>
        <script type="text/javascript" src="http://js.dhresource.com/survey/satisfaction/seller-init.js?ver=1411452766959"></script>
      </div>
    </div>
    
     <#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#mainLeftbar")}
  	
  	 <#-- right bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#mainRightbar")}
  </div>
</div>
