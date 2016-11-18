<body style="background:#eaeaea;">
<div class="jcqs_all">
  <ul>
	<#if listIt?has_content>
		<#list listIt as item>
			 <li>
			 <div class="jcqs_list">
			   <div class="jcqs_list_name">
			      <span class="name">${item.cName!}</span>
			      <span class="bs">${item.publishDate!}</span>
			   </div>
			  <div class="jcqs_list_center"><img src="/quzou/upload/${item.cPic!}" /></div>
			   <div class="jcqs_list_bottom">${item.shortDescription!}</div>
			   <div class="jcqs_list_qw" id="${item.cId!}">
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
 	$(".jcqs_list_qw").click(function(){
 		var cId = $(this).attr("id");
 		window.location.href="competitionDetail?cId="+cId;
      });
</script>