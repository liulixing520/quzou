<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery-1.5.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="../seller/css/seller.css">
<link rel="stylesheet" type="text/css" href="../seller/css/common20111215.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/jquery-calendar.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/my-products.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/syi_pop.css">
<link rel="stylesheet" type="text/css" href="../seller/css/seller_button.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/general_popup_box.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/product.css">
<link rel="stylesheet" type="text/css" href="../seller/css/relatedproduct.css">
<link rel="stylesheet" type="text/css" href="../seller/css/reviewlist_css.css">
<link rel="stylesheet" type="text/css" href="../seller/css/review_css.css">
<div class="content">
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/sellerordmng/orderList/list.do?params.linkType=102&amp;dhpath=10002,06,0601">交易</a><span>&gt;</span><a href="/mydhgate/feedback/feedbacklist.do?act=pageload&amp;dhpath=10002,07,0701">评价和评论管理</a><span>&gt;</span>产品评论管理 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="col-main-warp">
        <div id="right">
          <form id="reviewForm" method="post" name="reviewForm" action="/mydhgate/review/reviewlist.do">
            <div id="right">
              <div class="evaluation_top">
                <dl>
                  <dt> <span class="a1"><strong>产品评论</strong></span> | 下列产品在最近被评论过： <strong><font color="red">未回复评论</font></strong> | <a href="/mydhgate/review/reviewlist.do?reviewType=1&amp;timeType=3"><strong>已回复评论</strong></a> | <a href="/mydhgate/review/reviewlist.do?reviewType=3&amp;timeType=3"><strong> 举报的评论</strong></a> | <a href="/mydhgate/review/reviewlist.do?reviewType=2&amp;timeType=3"><strong>全部评论</strong></a> </dt>
                  <dd>
                    <select style="width: 154px;" id="review_time_type" class="ver" size="1" name="review_time_type">
                      <option value="1">当日</option>
                      <option value="2">7&nbsp;&nbsp;日</option>
                      <option selected="" value="3">30日</option>
                      <option value="4">全部时间</option>
                    </select>
                  </dd>
                </dl>
              </div>
              <!-- 如果没有评价，则显示提示信息-->
              <div style="padding-top: 15px; padding-right: 305px; padding-left: 285px;">
                <div style="font-size: 13pt;"><b>没有未回复的评论</b></div>
              </div>
              <!--分页-->
              <input id="page" name="page" value="0" type="hidden">
              <input id="reviewType" name="reviewType" value="0" type="hidden">
              <input id="timeType" name="timeType" value="3" type="hidden">
              <input id="complainReviewid" name="complainReviewid" type="hidden">
            </div>
            <!--  ----------------------  层内容开始  -------------   -->
            <link rel="stylesheet" type="text/css" href="http://image.dhgate.com/2008/web20/seller/css/seller.css">
            <link rel="stylesheet" type="text/css" href="http://image.dhgate.com/dhs/mos/css/public/common20111215.css">
            <link rel="stylesheet" type="text/css" href="http://image.dhgate.com/2008/web20/seller/css/seller_button.css">
            <link rel="stylesheet" type="text/css" href="http://image.dhgate.com/2008/web20/seller/css/general_popup_box.css">
            <table style="width: 500px; display: none;" id="show_html" class="noshade-pop-table">
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
                        <div class="noshade-pop-title"> <span>举报此评论：</span> </div>
                        <div class="noshade-pop-inner">
                          <div class="box1">
                            <div class="report-reviews">
                              <dl class="choose-reason">
                                <dt>请选择举报原因：</dt>
                                <dd>
                                  <select id="complainType" name="complainType">
                                    <option value="1">评论和产品无关，比如对卖家或货运的反馈</option>
                                    <option value="2">电话号码、邮件地址或DHgate.com以外的链接</option>
                                    <option value="3">利用中差评进行威胁，提出不合理要求或谋取额外财物</option>
                                    <option value="4">亵渎和色情材料</option>
                                    <option value="5">推广非法或不道德行为</option>
                                    <option value="6">图片涉及色情、暴力、反动</option>
                                    <option value="7">视频和产品无关</option>
                                    <option value="8">图片和产品无关</option>
                                    <option value="9">视频涉及色情、暴力、反动</option>
                                  </select>
                                </dd>
                              </dl>
                              <dl>
                                <dt>&nbsp;</dt>
                                <dd> <a class="yellowbutton1 margin-r20" onclick="javascript:saveInfo();" href="javascript:void(0)"> <span>提交</span> </a> <a class="greybutton1" onclick="javascript:delInfo();" href="javascript:void(0)"> <span>取消</span> </a> </dd>
                              </dl>
                            </div>
                          </div>
                        </div>
                        <div class="noshade-pop-bot"></div>
                      </div>
                      <a class="noshade-pop-close" onclick="javascript:delInfo();" href="javascript:void(0)"></a> </div></td>
                  <td class="m-ri"></td>
                </tr>
                <tr>
                  <td class="b-lt"></td>
                  <td class="b-mid"></td>
                  <td class="b-ri"></td>
                </tr>
              </tbody>
            </table>
            <script language="javascript">
		function delInfo(){
        	jQuery.modal.close();
            jQuery('#popcon').html("");		
		}
		function saveInfo(){
		var complainType=jQuery("#complainType").val();
		var complainReviewid=jQuery("#complainReviewid").val();
			jQuery.ajax({
    			type:"post",
    			async : false,
         	    url:"/mydhgate/review/reviewlist.do?isblank=true&act=saveComplain&now="+new Date().getTime(),
         	    data:"complainType="+complainType+"&complainReviewid="+complainReviewid,
           	    success:function(msg){
           	        if(msg=="1"){
						jQuery.modal.close();
						jQuery('#popcon').html("");		
						
						jQuery(ok_html).modal({close:false});
           	 	    }
          	    }
			});
		}
		
		function button_close(){
			jQuery.modal.close();
			jQuery('#ok_html').html("");
		
		    var myform = document.reviewForm;
			myform.action = "/mydhgate/review/reviewlist.do?reviewType=3";
			myform.submit();
		}
</script>
            <table style="width: 400px; display: none;" id="ok_html" class="noshade-pop-table">
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
                        <div class="noshade-pop-inner">
                          <div class="box1">
                            <div class="report-reviews-success">
                              <p class="report-success">谢谢，您的举报提交成功！</p>
                              <p>我们将审核该内容，如果确属不当，它将被删除。</p>
                              <div class="pop-button"> <a class="yellowbutton1" onclick="javascript:button_close();" href="javascript:void(0)"> <span>关闭</span> </a> </div>
                            </div>
                          </div>
                        </div>
                        <div class="noshade-pop-bot"></div>
                      </div>
                      <a class="noshade-pop-close" onclick="javascript:button_close();" href="javascript:void(0)"></a> </div></td>
                  <td class="m-ri"></td>
                </tr>
                <tr>
                  <td class="b-lt"></td>
                  <td class="b-mid"></td>
                  <td class="b-ri"></td>
                </tr>
              </tbody>
            </table>
            <!--  ----------------------  层内容完 -------------   -->
            <link rel="stylesheet" type="text/css" href="http://image.dhgate.com/b/manage/css/basic.css" media="screen">
            <!-- IE 6 hacks -->
            <script type="text/javascript" src="http://image.dhgate.com/b/manage/js/jquery.simplemodal2.js"></script>
            <script type="text/javascript" src="http://image.dhgate.com/b/manage/js/frame_buyer.js"></script>
            <style type="text/css">
	<!--
	#modalContainer{left:40%;top:20%}
	-->	
	</style>
            <link rel="stylesheet" type="text/css" href="http://image.dhgate.com/b/manage/css/syi_pop.css">
            <div id="popcon"></div>
          </form>
        </div>
      </div>
    </div>
   

	<#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#orderLeftbar")}

  </div>
</div>
