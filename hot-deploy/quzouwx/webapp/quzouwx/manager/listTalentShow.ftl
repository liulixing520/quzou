<body style="background:#eaeaea;">
<div class="jcqs_all">
  <ul>
	<#if listIt?has_content>
		<#list listIt as item>
			 <li id="${(item.showId)!}">
			 <div class="jcqs_list">
			   <div class="jcqs_list_name">
			      <span class="name">${(item.showTitle)!}</span>
			      <span class="bs">${(item.publishDate?string('yyyy-MM-dd'))!}</span>
			   </div>
			  <div class="jcqs_list_center"><img src="/quzou/upload/${item.showPic!}" /></div>
			   <div class="jcqs_list_bottom">${item.description!}</div>
			   <div class="jcqs_list_qw">
			      <span class="name">查看全文</span>
			      <span class="bs"><img style="width:50%" src="../quzouwx/images/youjiantou.png" /></span>
			   </div>
			 </div>
			</li>
		</#list>
	</#if>
  </ul>
</div>
<script>
 	$(".jcqs_all li").click(function(){
 		var showId = $(this).attr("id");
 		window.location.href="talentDetail?showId="+showId;
      });
</script>