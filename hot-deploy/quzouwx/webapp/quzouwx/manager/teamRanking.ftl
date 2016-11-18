<body style="background:#eaeaea;">
<div class="jcqs">
  <div class="jcqs_title">${(entity.cName)!}</div>
  <div class="jcqs_gr">
     <span class="gr_left"><img style="width: 60%;" src="../quzouwx/images/tuandui.png" /></span>
	 <span class="gr_right">团队成绩排行榜</span>
	 <span class="gr_right" style="float:right; padding-right:3%;">第${teamRank!}名</span>
  </div>

  <ul>
  <#if statisticsList?has_content>
  	<#assign statistics = statisticsList[0]>
  	<#assign firstNum = 1>
  	<#if statistics?has_content && statistics.integral??>
	  	<#assign firstNum = statistics.integral>
  	</#if>
  	<#list statisticsList as item>
		
		 <li>
		 <div class="jcqs_td_left<#if item_index < 3 >${item_index + 1}<#else>4</#if>" style="text-align:center;">${item_index + 1}</div>
		 <div class="jcqs_td_right">
		   <div class="jcqs_name">
		      <span class="name">${(item.deptName)!}</span>
		      <span class="bs">${(item.integral?default(0))!}分</span>
		   </div>
		  <div class="jcqs_center"><span style="width:<#if item_index==0 ><#if item.integral?default(0) == 0 >0%<#else>100%</#if><#else>${((item.integral?default(0) / firstNum) * 100)!}%</#if>;"></span></div>
		   <div class="jcqs_bottom">
		      <span class="qs">${(item.companyName)!}</span>
		      <span class="qs_right" deptId="${(item.deptId)!}" ><p id="relations_${(item.deptId)!}">${(item.relations)!}</p></span>
		   </div>
		 </div>
		 <div style="clear:both;"></div>
		</li>
			
  	</#list>
  </#if>
	
  </ul>
</div>
<div style="clear:both; height:80px;border-top:1px solid #fff;"></div>

<script>
$(".qs_right").click(function (){
	var cId = '${(entity.cId)!}';
	var deptId = $(this).attr("deptId");
	var fromPartyId = '${(customer.partyId)!}';
	var ralations = $("#relations_"+deptId).html();
	$("#relations_"+deptId).html(parseInt(ralations)+1);
	$(this).attr("class","qs_right1");
	jQuery.ajax({
           url: 'createRelation',
           data: {deptId:deptId,cId:cId,fromPartyId:fromPartyId},
           type: "POST",
           success: function(data) {
           }
       });
})
</script>