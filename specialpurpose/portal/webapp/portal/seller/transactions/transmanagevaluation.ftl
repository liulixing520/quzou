<SCRIPT type=text/javascript src="http://image.dhgate.com/seller/js/common.js"></SCRIPT>
<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery-1.5.1.min.js"></script>
<LINK rel=stylesheet type=text/css href="../seller/css/seller.css">
<LINK rel=stylesheet type=text/css href="../seller/css/common20140922.css">
<LINK rel=stylesheet type=text/css href="../seller/css/general_popup_box.css">
<SCRIPT type=text/javascript src="http://stats.g.doubleclick.net/dc.js" async="true"></SCRIPT>
<SCRIPT type=text/javascript src="http://image.dhgate.com/dhs/mos/js/public/menu-common_20111226.js?ver=2013"></SCRIPT>
<SCRIPT type=text/javascript src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery.simplemodal2.js?ver=2012-09-27"></SCRIPT>
<!--<script type="text/javascript" src="http://seller.dhgate.com/js/publish/menu-common_20111226.js"></script>-->
<!--yangqin1129<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/jquery.js"></script> -->
<SCRIPT type=text/javascript src="http://image.dhgate.com/dhs/mos/js/vip.js"></SCRIPT>
<LINK rel=stylesheet type=text/css href="../seller/css/vip.css">
<LINK rel=stylesheet type=text/css href="../seller/css/seller_0829.css">
<LINK rel=stylesheet type=text/css href="../seller/css/translate.css">
<SCRIPT type=text/javascript src="http://image.dhgate.com/2008/web20/seller/js/syi/jquery.simplemodal2.js"></SCRIPT>
<LINK rel=stylesheet type=text/css href="../seller/css/feedback_1018.css">
<SCRIPT language=javascript>	        	      
	function deletefeedback(rfxid){
		//alert(rfxid);
		if(confirm('确定删除？')){  
			var url ="/mydhgate/feedback/feedbackaddandmodif.do?act=delete&pagesource=feedbacklist&rfxId="+rfxid;
			window.document.location.href=url;
		}
	}	
	
	function showTranslateWin(strFBId,strHL,strSrc){
		jQuery.modal.close();
        window.open('http://translate.google.cn/');
	}
</SCRIPT>
<div class="content">
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/sellerordmng/orderList/list.do?params.linkType=102&amp;dhpath=10002,06,0601">交易</a><span>&gt;</span><a href="/mydhgate/feedback/feedbacklist.do?act=pageload&amp;dhpath=10002,07,0701">评价和评论管理</a><span>&gt;</span><a href="/mydhgate/feedback/feedbacklist.do?act=pageload&amp;dhpath=10002,07,0701">交易评价管理</a><span>&gt;</span>我的评价管理 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="col-main-warp">
        <div id="right">
          <form id="feedbacklistForm" method="post" name="feedbacklistForm" action="/mydhgate/feedback/feedbacklist.do">
            <div id="right">
              <div id="credit_l">
                <ul id="tbt">
                  <b style="margin-right: 10px; float: left;">信用度</b>
                  <li id="allcredit" class="libg"><a onclick="showFeedbackTable('','','ToSupplier','');" href="#"><span>全部买家评价</span></a></li>
                  <li id="vipcredit"><a onclick="showFeedbackTable('','','ToSupplier','vip');" href="#"><span>VIP买家评价</span></a></li>
                </ul>
                <table border="1" cellSpacing="0" borderColor="#c8d9e9" cellPadding="0" width="100%">
                  <tbody>
                    <tr class="bbg">
                      <td></td>
                      <td>最近2个月评价次数</td>
                      <td>最近6个月评价次数</td>
                      <td>最近一年评价次数</td>
                      <td>总计评价次数</td>
                    </tr>
                    <tr>
                      <td><img alt="好评" src="http://image.dhgate.com/images/ico/a01.gif" width="18" height="18"> 好评</td>
                      <td><a onclick='showFeedbackTable("60","1","ToSupplier","");' href="#"></a></td>
                      <td><a onclick='showFeedbackTable("180","1","ToSupplier","");' href="#"></a></td>
                      <td><a onclick='showFeedbackTable("365","1","ToSupplier","");' href="#"></a></td>
                      <td><a onclick='showFeedbackTable("","1","ToSupplier","");' href="#"></a></td>
                    </tr>
                    <tr>
                      <td><img alt="中评" src="http://image.dhgate.com/images/ico/a02.gif" width="18" height="18"> 中评</td>
                      <td><a onclick='showFeedbackTable("60","0","ToSupplier","");' href="#"></a></td>
                      <td><a onclick='showFeedbackTable("180","0","ToSupplier","");' href="#"></a></td>
                      <td><a onclick='showFeedbackTable("365","0","ToSupplier","");' href="#"></a></td>
                      <td><a onclick='showFeedbackTable("","0","ToSupplier","");' href="#"></a></td>
                    </tr>
                    <tr>
                      <td><img alt="差评" src="http://image.dhgate.com/images/ico/a03.gif" width="18" height="18"> 差评</td>
                      <td><a onclick='showFeedbackTable("60","-1","ToSupplier","");' href="#"></a></td>
                      <td><a onclick='showFeedbackTable("180","-1","ToSupplier","");' href="#"></a></td>
                      <td><a onclick='showFeedbackTable("365","-1","ToSupplier","");' href="#"></a></td>
                      <td><a onclick='showFeedbackTable("","-1","ToSupplier","");' href="#"></a></td>
                    </tr>
                    <tr class="bbggg">
                      <td colSpan="5"><b class="s-color3">New！</b> 新增VIP买家特权：金银牌买家的评价打分翻倍计算。请您多重视对VIP买家的服务！ <a href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0701&amp;artid=792EC2EE9187CC68E0400A0A2B0A2BD8" target="_blank"> 查看详情&gt;&gt; </a> </td>
                    </tr>
                  </tbody>
                </table>
                <table border="1" cellSpacing="0" borderColor="#c8d9e9" cellPadding="0" width="100%">
                  <tbody>
                    <tr>
                      <td class="credit_h" colSpan="5">买家对您的服务评价  （主营行业 ： 无 ）</td>
                    </tr>
                    <tr class="bbg">
                      <td>评价项</td>
                      <td>平均得分</td>
                      <td>与同行业相比</td>
                      <td>评价次数</td>
                    </tr>
                    <tr>
                      <td class="le">实物与描述相符程度</td>
                      <td class="stars"><a href="#">
                        <div><b style="width: 0%;"></b></div>
                        <span>0/5.0</span> </a> </td>
                      <td><span></span> -- </td>
                      <td> 0 </td>
                    </tr>
                    <tr>
                      <td class="le">卖家的沟通容易程度</td>
                      <td class="stars"><a href="#">
                        <div><b style="width: 0%;"></b></div>
                        <span>0/5.0</span> </a> </td>
                      <td><span></span> -- </td>
                      <td> 0 </td>
                    </tr>
                    <tr>
                      <td class="le">发货速度</td>
                      <td class="stars"><a href="#">
                        <div><b style="width: 0%;"></b></div>
                        <span>0/5.0</span> </a> </td>
                      <td><span></span> -- </td>
                      <td> 0 </td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div id="credit_r">
                <table border="0" cellSpacing="0" cellPadding="0" width="100%">
                  <tbody>
                    <tr>
                      <td class="seller_title">卖家信用</td>
                    </tr>
                    <tr>
                      <td>商家名称：sunvsoft</td>
                    </tr>
                    <tr>
                      <td> 信用度： </td>
                    </tr>
                    <tr>
                      <td> 12个月内好评率：<b style="text-decoration: underline; cursor: pointer;" class="countper">%</b> <a href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0701&amp;cate=评价规则&amp;artid=792EC2EE9187CC68E0400A0A2B0A2BD8" target="_blank"><img title="评价体系帮助" src="http://image.dhgate.com/2008/web20/seller/img/product_biao.gif"></a> </td>
                    </tr>
                    <tr>
                      <td><ul>
                          <li><a href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0701&amp;cate=评价规则&amp;artid=792EC2EE9187CC68E0400A0A2B0A2BD8" target="_blank">什么是评价？</a></li>
                          <li><a href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0701&amp;cate=评价规则&amp;artid=792E9C49A7BCE906E0400A0A2B0A48E8" target="_blank">如何删除评价？ </a></li>
                          <li><a href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0701&amp;cate=评价规则&amp;artid=8DFDEEBD50BC2A82E0400A0AD40A19FD" target="_blank">评价修改规则 </a></li>
                          <li><a href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0701&amp;artid=792EC2EE9187CC68E0400A0A2B0A2BD8" target="_blank">VIP买家评价翻倍规则</a></li>
                        </ul></td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <table class="cleartop" border="0" cellSpacing="0" cellPadding="0" width="280">
                <tbody>
                  <tr>
                    <td class="feebackbiaoqiang"><a onclick="showFeedbackTable('','','ToSupplier','');" href="#">收到的评价</a> | </td>
                    <td><a onclick="showFeedbackTable('','','ToBuyer','');" href="#">给他人的评价</a> | </td>
                    <td><a onclick="showFeedbackTable('','','Wait','');" href="#">待评价的订单</a></td>
                  </tr>
                </tbody>
              </table>
              <table class="pingjia" border="1" cellSpacing="0" borderColor="#c8d9e9" cellPadding="0" width="100%">
                <tbody>
                  <tr class="bbg">
                    <td width="10%">评　价</td>
                    <td class="le" width="32%">评价内容</td>
                    <td width="5%"></td>
                    <td width="13%">评价人</td>
                    <td width="15%">计分说明</td>
                    <td width="10%">评价日期</td>
                    <td width="15%">操　作</td>
                  </tr>
                </tbody>
              </table>
              <input id="act" name="act" value="pageload" type="hidden">
              <input id="pagetype" name="performtype" value="ToSupplier" type="hidden">
              <input id="datecycle" name="datecycle" value="" type="hidden">
              <input id="score" name="score" value="" type="hidden">
              <input id="isVIP" name="isVIP" value="" type="hidden">
              <!--分页-->
              <div id="page"> </div>
            </div>
          </form>
          <div id="vipContent">
            <div class="vippop">
              <div class="helppane_right"></div>
              <p><strong class="fl">VIP买家<span class="color3">新增如下特权</span></strong><a class="closepop closeme" href="javascript:void(0);"></a></p>
              <p>金银牌买家给卖家的Feedback打分翻倍计算</p>
              <p><a class="fl" href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0701&amp;artid=792EC2EE9187CC68E0400A0A2B0A2BD8" target="_blank">查看详情&gt;&gt;</a><a class="closeme" href="javascript:void(0);">我知道啦！</a></p>
            </div>
          </div>
          <div style="left: 593px; top: 233px; padding-right: 19px; visibility: hidden;" id="countperpop">
            <div style="width: 360px;" class="vippop">
              <div class="helppane_left"></div>
              <div class="clearfix"><strong class="fl">好评率计算公式<span class="color3">（新增VIP买家特权）</span></strong><a class="fr" href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0701&amp;artid=792EC2EE9187CC68E0400A0A2B0A2BD8">查看详情&gt;&gt;</a></div>
              <div class="textcen">
                <p>G好评×3+S好评×2+B好评+C好评</p>
                <div style="height: 1px; margin-bottom: 1px; border-bottom-color: rgb(102, 102, 102); border-bottom-width: 1px; border-bottom-style: solid;"></div>
                <p>(G好评+G差评)×3+(S好评+S差评)×2+B好评+B差评+C好评+C差评</p>
              </div>
              <p><span class="color3">[说明]</span> <strong>G:</strong>金牌买家 <strong>S:</strong>银牌买家 <strong>B:</strong>铜牌买家 <strong>C:</strong>普通买家 </p>
            </div>
          </div>
          <script type="text/javascript">
	var settime=30;
	var isVIP="${form.bean.isVIP}";
	$(document).ready(function() {
		if(isVIP=='vip'){
			$("#vipcredit").addClass("libg");
		}else{
			$("#allcredit").addClass("libg");
		}
		var viphover = new VipicoHover();
		var counthover = new VipicoHover({ iButton:"countper" , iContent:"countperpop" , leftrigmove:-434 });
		for(var i=1;i<=settime;i++)   {
	     	setTimeout("autoClose("+i+")",i*1000);
	  	}
		$("#countperpop").css({visibility: "hidden"});
	});
	function autoClose(num) {
	   if(num==settime) {
			$("#vipContent").css({visibility: "hidden"});
    	}
    }
	function showFeedbackTable(datecycle,score,performtype,isVIP)
	{
		document.feedbacklistForm.datecycle.value=datecycle;
		document.feedbacklistForm.score.value=score;
		document.feedbacklistForm.performtype.value=performtype;
		document.feedbacklistForm.isVIP.value=isVIP;
		document.feedbacklistForm.submit();
	}
</script>
        </div>
      </div>
    </div>
   
	<#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#orderLeftbar")}



  </div>
</div>
