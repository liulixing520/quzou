  <link href="../seller/css/seller.css" rel="stylesheet" type="text/css" />   
  <link rel="stylesheet" type="text/css" href="../seller/css/review.css" /> 
   <script type="text/javascript">
  	 $(function(){ 
		$(".breadcrumb").append("<li class='active'>交易</li><li class='active'>评价管理</li>");
	}); 
  </script>
  <style type="text/css">
  #right{float:left; width:auto; padding-left:6px;} 
  </style>
  <br/> 
  <div class="content">
   <div class="layout clearfix"> 
    <div class="col-main"> 
     <div class="col-main-warp"> 
      <div id="right">
       <!-- 右侧开始 --> 
       <div class="review-info-wrap clearfix"> 
        <div class="review-info-show"> 
         <div class="review-info-title"> 
          <h3>全部买家评价</h3> 
         </div>  
         <div class="info-show-table"> 
          <table width="100%" cellpadding="0" cellspacing="0"> 
           <thead> 
            <tr> 
             <th></th> 
             <th>最近2个月评价次数</th> 
             <th>最近6个月评价次数</th> 
             <th>最近一年评价次数</th> 
             <th>总计评价次数</th> 
            </tr> 
           </thead> 
           <tbody> 
            <tr> 
             <td>好评 </td> 
             <td></td> 
             <td></td> 
             <td></td> 
             <td></td> 
            </tr> 
            <tr> 
             <td>中评 </td> 
             <td></td> 
             <td></td> 
             <td></td> 
             <td></td> 
            </tr> 
            <tr> 
             <td>差评 </td> 
             <td></td> 
             <td></td> 
             <td></td> 
             <td></td> 
            </tr> 
           </tbody> 
          </table> 
         </div>
         <br/> 
         <div class="review-info-title"> 
          <h3>买家对您的服务评价（主营行业：--）</h3> 
         </div> 
         <div class="info-show-table"> 
          <table width="100%" cellpadding="0" cellspacing="0"> 
           <thead> 
            <tr> 
             <th>评价项</th> 
             <th>平均得分</th> 
             <th>与同行业相比</th> 
             <th>评价次数</th> 
            </tr> 
           </thead> 
           <tbody> 
            <tr> 
             <td>实物与描述相符程度</td> 
             <td> <span class="info-show-scroe"> <span style="width:0%;"></span> </span> <span class="info-show-text">--/--</span> </td> 
             <td class="align-left"> <span class="info-show-compare"> <b class=""></b>-- </span> </td> 
             <td>--</td> 
            </tr> 
            <tr> 
             <td>卖家的沟通容易程度</td> 
             <td> <span class="info-show-scroe"> <span style="width:0%;"></span> </span> <span class="info-show-text">--/--</span> </td> 
             <td class="align-left"> <span class="info-show-compare"> <b class=""></b>-- </span> </td> 
             <td>--</td> 
            </tr> 
            <tr> 
             <td>交付时间</td> 
             <td> <span class="info-show-scroe"> <span style="width:0%;"></span> </span> <span class="info-show-text">--/--</span> </td> 
             <td class="align-left"> <span class="info-show-compare"> <b class=""></b>-- </span> </td> 
             <td>--</td> 
            </tr> 
            <tr> 
             <td>运费</td> 
             <td> <span class="info-show-scroe"> <span style="width:0%;"></span> </span> <span class="info-show-text">--/--</span> </td> 
             <td class="align-left"> <span class="info-show-compare"> <b class=""></b>-- </span> </td> 
             <td>--</td> 
            </tr> 
           </tbody> 
          </table> 
         </div> 
        </div> 
        <div class="review-info-credit"> 
         <div class="review-info-title"> 
          <h3>卖家信用</h3> 
         </div> 
         <div class="info-credit-main"> 
          <ul class="info-credit-show"> 
           <li>商家名称：sunvsoft</li> 
           <li>信用度：</li> 
           <li> 12个月内好评率： 
            <div class="info-rate j-tipbox"> 
             <strong class="info-rate-btn j-tip-trigger">0.0 %</strong> 
             <div class="info-rate-pop j-tip-content" style="display:none"> 
              <div class="info-rate-main"> 
               <p class="info-rate-title"> <strong>好评率计算公式</strong>（新增VIP买家特权） <a href="#" class="info-rate-detail" target="_blank">查看详情</a> </p> 
               <div class="info-rate-formula clearfix"> 
                <div class="formula-left">
                  好评率 = 
                </div> 
                <div class="formula-right"> 
                 <p class="molecule">VIP好评*2 + 普好评*1</p> 
                 <p>(VIP好评+VIP差评)*2+(普好评+普差评)*1</p> 
                </div> 
               </div> 
              </div> 
              <b class="info-rate-arrow"></b> 
              <div class="info-rate-shadow"></div> 
             </div> 
          </ul> 
          <ul class="info-credit-list"> 
           <li> <b class="review-point-icon"></b> <a href="#" target="_blank">什么是评价？</a> </li> 
           <li> <b class="review-point-icon"></b> <a href="#" target="_blank">如何删除评价？</a> </li> 
           <li> <b class="review-point-icon"></b> <a href="#" target="_blank">评价修改规则</a> </li> 
          </ul> 
         </div> 
        </div> 
       </div> 
       <div class="rtab-warp"> 
        <ul class="nav-tabs" style="padding-top:10px; padding-bottom:20px; border:none;"> 
         <li > <a href="#"><span>来自买家的评价</span></a> </li> 
         <li> <a href="#"><span>待评价的订单(<b class="text-orange">0</b>)</span></a> </li> 
        </ul> 
       </div> 
       <form name="sellerReviewsForm" id="sellerReviewsForm" action="#" method="post"> 
        <div class="review-search-area">
          评价： 
         <select class="select-w" name="score" id="score"> <option value="-2" selected="">全部</option> <option value="1">好评</option> <option value="0">中评</option> <option value="-1">差评</option> </select> 
         <select class="review-search-period select-w" name="datecycle" id="datecycle"> <option value="30" selected="">最近30天</option> <option value="60">最近60天</option> <option value="90">最近90天</option> <option value="180">最近180天</option> <option value="365">1年</option> <option value="-1">全部</option> </select> 
        </div> 
        <div class="no-result">
         没有来自买家的评价
        </div> 
        <div class="commonpage"> 
        </div> 
        <input type="hidden" name="isVIP" id="isVIP" value="" /> 
        <input type="hidden" name="page" id="page" value="1" /> 
        <input name="fbtype" type="hidden" id="fbtype" value="2" /> 
        <!--    —————————————— 以下为review项目的弹层      ——————————————--> 
        <!--{start: 评价 dialog --> 
        <div class="dialog-main write-pop j-dialog-review-appraise" style="display:none"> 
         <dl class="review-common-tip"> 
          <dt> 
           <b class="review-common-icon"></b>评价提示： 
          </dt> 
          <dd>
           请使用英文进行评价，为了您的交易安全，评价中勿留下联系方式（如：电话、电子邮件、网址等）
          </dd> 
         </dl> 
         <div class="review-to-buyer"> 
          <dl class="clearfix"> 
           <dt>
            交易评价：
           </dt> 
           <dd> 
            <span class="review-m-r20"> <input type="radio" checked="checked" value="1" class="review-radio" id="Positive" name="rate" /> <label for="Positive"> <b class="review-rating-icon"></b>好评 </label> </span> 
            <span class="review-m-r20"> <input type="radio" class="review-radio" value="0" id="Neutral" name="rate" /> <label for="Neutral"> <b class="review-rating-icon neutral"></b>中评 </label> </span> 
            <span> <input type="radio" class="review-radio" value="-1" id="Negative" name="rate" /> <label for="Negative"> <b class="review-rating-icon negative"></b>差评 </label> </span> 
           </dd> 
          </dl> 
          <dl class="clearfix"> 
           <dt>
            评价内容：
           </dt> 
           <dd> 
            <textarea class="j-textarea-review" maxlength="1000" rows="5" cols="33"></textarea> 
           </dd> 
           <dd> 
            <p class="text-gray2">您还可以输入<strong class="text-orange j-review-maxtext">1000</strong>/1000个字符</p> 
           </dd> 
          </dl> 
         </div> 
         <div class="review-dialog-button"> 
          <a class="yellowbutton2 review-m-r j-buyer-review-submit" href="javascript:;"> <span>提 交</span> </a> 
          <a class="greybutton2 j-review-cancel" href="javascript:;"> <span>取 消</span> </a> 
         </div> 
        </div> 
       </form> 
      </div> 
     </div> 
    </div> 
