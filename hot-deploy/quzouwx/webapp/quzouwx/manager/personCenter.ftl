<body>
<div class="big_div">
<div class="R_main posR">
	<div class="allbg"><img src="../quzouwx/images/bg.jpg" width="100%" style="min-height:700px"/></div>
    <div class="uinfo_bg1">
    </div>
    <div class="uinfo_bg2">
    </div>
    <div class="uinfo_bg3">
    </div>
</div>
<div class="R_main posR">
  <div class="top_div">
    <div class="pic">
	  <div style="overflow:hidden; width:100%; height:70px;">
	    <div class="jbrz"<#if customer?has_content><#if customer.partyId == 'system'>style="display:none;"</#if></#if> ><img src="../quzouwx/images/rizhi.png"/><p class="jb_p">健步日志</p></div>
	    <div class="shezhi" <#if customer?has_content><#if customer.partyId == 'system'>style="display:none;"</#if></#if> ><img src="../quzouwx/images/shezhi.png"/><p class="jb_p">设置</p></div>
	  </div>
	  
	  <div class="left"><img src="${(userInfo.headimgurl)!}" width="24%" id="tx" /></div>
	  <div class="wz"><h1><a href="#" mce_href="#">${(userInfo.nickname)!}</a></h1>  </div>
	</div>
    <div class="jbxx">
      <ul>
        <li><span class="name">姓名</span><span class="mz"><#if customer.userLoginId !='system'>${(customer.userLoginId)!}</#if></span></li>
        <li><span class="name">手机号码</span><span class="mz">${(customer.telephone)!}</span></li>
        <li><span class="name">单位</span><span class="mz">${(customer.companyName)!}</span></li>
      </ul>      
    </div>
  </div>
  <div style="clear:both; border-bottom:1px solid #fff; border-top:1px solid #fff; height:20px;"></div>
  <div class="center">
    <div class="jbxx">
      <ul>
        <li><span class="name">计步器</span><span class="mz">${(customer.cardId)!}</span></li>
        <li><span class="name">步数</span><span class="mz"><font color="#a9ff00"></font>${(customerStatic.stepNumber)!}步</span></li>
        <li><span class="name">积分</span><span class="mz"><font color="#a9ff00">${(customerStatic.integral)!}</font>分</span></li>
        <li><span class="name">排名</span><span class="mz">第<font color="#fb2e67" class="mingci">${(customerStatic.ranking)!}</font>名</span></li>
      </ul>      
    </div>
  </div>
  <div style="clear:both; border-bottom:1px solid #fff; height:23px;"></div>
   <div class="bot2">
    <div >查看活动中心</div>
  </div>
  <div style="clear:both; border-top:1px solid #fff;"></div>
  <div class="bot">
    <div>客户服务电话: 18001225023</div>
  </div>
  <div style="clear:both; height:80px;border-top:1px solid #fff;"></div>
</div>
<div style="position:fixed; bottom:0;"></div>
<script>
	$(".shezhi").click(function(){
		window.location.href="setCenter";
	})
	$(".bot2").click(function(){
		window.location.href="listCompetitionJoined";
	})
	$(".bot").click(function(){
		window.location.href="tel:18001225023";
	})
	$(".jbrz").click(function(){
		window.location.href="customerLog";
	})
	$("#tx").click(function(){
		$.ajax({
	       url: '<@ofbizUrl>removeCache</@ofbizUrl>',
	       data: {},
	       type: "POST",
	       async:false,
	       success: function(data) {
             	alert(data.message);
	       }
	   });
	})
</script>
