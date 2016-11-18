<body style="background:#eaeaea;">
<div class="jcqs_ca">
  <div class="jcqs_xq_tb">
     <span class="jcqs_xq_title_left"><img style="width:19%;float:left;" src="../quzouwx/images/logo.png" /></span>
	 <span class="jcqs_xq_title_right">${(entity.startDate?string('MM月dd日'))!}</span>
  </div>
  <div class="jcqs_xq_tb_title"><span class="jcqs_xq_title_center">${(entity.cName)!}</span></div>
  <ul class="jcqs_xq">
    <li>
	 <div class="jcqs_list">
	  <div class="jcqs_list_center"><img src="/quzou/upload/${(entity.cPic)!}" /></div>
	   <div class="jcqs_xq_bottom">
	     <div class="left_span" >
	     	<div style="width:15%; float:left;"><img style="width: 75%;" src="../quzouwx/images/jcqs_bushu.png" /></div>
		    <div style="text-align:left; padding-left:3px; width:25%; float:left;font-size: 16px;">步数</div>
	    </div>
		 <div class="right_span">
		 	<div style="width:15%; float:left;"><img style="width: 100%;" src="../quzouwx/images/jcqs_mingci.png" /></div>
		    <div style="text-align:left; padding-left:10px; width:25%; float:left;font-size: 16px;">名次</div>
		</div>
	   </div>
	   <div class="jcqs_list_qw">
	      <div style="float:left; width:52%;">
		    <ul class="jcqs_xq_mc">
		    <#assign number = 0>
		    <#if statistics?has_content>
			    <#assign number = statistics.stepNumber>
		    </#if>
		    <#assign listString= Static["org.ofbiz.base.util.StringUtil"].numberToString(number) />
		    <#if listString?has_content>
		    	<#list listString as str>
				  <li>${str}</li>
		    	</#list>
		    </#if>
			</ul>
		  </div>
	      <div class="mc_nm" style="font-size: 8px;">No.<font size="+2">${(statistics.ranking)!}</font></div>
	   </div>
	 </div>
	</li>
	<div style="overflow:hidden; margin:5% 0;">
	  <div class="jcqs_grph">团队排行榜</div>
	  <div class="jcqs_td">个人排行榜</div>
	</div>
	<li style=" padding:3% 0; ">
	 <div style="background:url(../quzouwx/images/xxxxx.png) center no-repeat;text-align:center;font-size:20px;">活动详情</div>
	 <p class="jcqs_qz">${StringUtil.wrapString(entity.description)}</p>
	  <#--<div class="jcqs_list_qw" style="width:92%; margin:auto;border-top:1px solid #EFEFEF;padding-top: 2%;">
	      <span class="name">查看全文</span>
	      <span class="bs"><img style="width: 60%;" src="../quzouwx/images/xiajiantou.png" /></span>
	   </div>
	   -->
	</li>
	<div style="background:#eaeaea;clear:both; height:40px;"></div>
  </ul>
</div>
<script>
	$(".jcqs_td").click(function(){
 		window.location.href="personRanking?cId=${(entity.cId)!}";
      });
	$(".jcqs_grph").click(function(){
 		window.location.href="teamRanking?cId=${(entity.cId)!}";
      });
</script>