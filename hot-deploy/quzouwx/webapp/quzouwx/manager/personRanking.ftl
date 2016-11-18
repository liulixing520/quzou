<body style="background:#eaeaea;">
<div class="jcqs">
  <div class="jcqs_title">${(entity.cName)!}</div>
  <div class="jcqs_gr">
     <span class="gr_left"><img style="width: 60%;" src="../quzouwx/images/jcqs_tx.png" /></span>
	 <span class="gr_right">个人成绩排行榜</span>
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
		 <div class="left">
		  <div class="jcqs_left">
		  <#if item.headimgurl?has_content>
			  <img src="${(item.headimgurl)!}" style="margin-top:10px; width:100%" /></div>
		  <#else>
			  <img src="../quzouwx/images/boyHeader_b.png" style="margin-top:10px; width:100%" /></div>
		  </#if>
		  <div class="jcqs_pic<#if item_index < 3 >${item_index + 1}<#else>4</#if>">${item_index + 1}</div>
		 </div>
		 <div class="jcqs_right">
		   <div class="jcqs_name">
		      <span class="name">
			  	  ${(item.userLoginId)!}
		      </span>
		      <span class="bs">${(item.integral?default(0))!}分</span>
		   </div>
		  <div class="jcqs_center"><span style="width:<#if item_index==0 ><#if item.integral?default(0) == 0 >0%<#else>100%</#if><#else>${((item.integral?default(0) / firstNum) * 100)!}%</#if>;" ></span></div>
		   <div class="jcqs_bot">
		      <span class="qs">${(item.deptName)!}</span>
		      <span class="qs_right" customerId="${(item.partyId)!}" ><p id="relations_${(item.partyId)!}">${(item.relations)!}</p></span>
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
	var customerId = $(this).attr("customerId");
	var fromPartyId = '${(customer.partyId)!}';
	var ralations = $("#relations_"+customerId).html();
	$("#relations_"+customerId).html(parseInt(ralations)+1);
	$(this).attr("class","qs_right1");
	jQuery.ajax({
           url: 'createRelation',
           data: {customerId:customerId,cId:cId,fromPartyId:fromPartyId},
           type: "POST",
           success: function(data) {
           }
       });
})
</script>