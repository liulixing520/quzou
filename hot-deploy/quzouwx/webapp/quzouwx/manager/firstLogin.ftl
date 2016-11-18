<script type="text/javascript" src="../quzouwx/js/main.js"></script>

<body>
<div class="big_div">
<div class="R_main posR">
 <div class="allbg1"><img src="../quzouwx/images/bg.png" width="100%" /></div>
	 <div class="uinfo_bg1">
	    </div>
	    <div class="uinfo_bg2">
	    </div>
	    <div class="uinfo_bg3">
	    </div>
	</div>
	<div class="R_main1 posR" id="scdl">
	   <img src="../quzouwx/images/id.png" />
	   <input type="text" name="name" id="userLoginId" placeholder="请输入用户名" />&nbsp;
	  <div id="scdl_qd">&nbsp;确定</div>
	  <div id="zj"><a href="">直接进入</a></div>
	</div>
</div>
</body>
<script>
	$("#scdl_qd").click(function(){
		var  userLoginId = $("#userLoginId").val();
		if(!userLoginId){
			alert("请输入用户名");
			$("#userLoginId").focus();
		}else{
			$.ajax({
		       url: '<@ofbizUrl>bandingPartyId</@ofbizUrl>',
		       data: {userLoginId:userLoginId},
		       type: "POST",
		       async:false,
		       success: function(data) {
		             if(data.errorMessage){
		             	alert(data.errorMessage);
		             }else{
		             	window.location.reload();
		             }
		       }
		   });
		}
	})
	
	$("#zj").click(function(){
		$.ajax({
	       url: '<@ofbizUrl>goInSystem</@ofbizUrl>',
	       data: {},
	       type: "POST",
	       async:false,
	       success: function(data) {
             	window.location.reload();
	       }
	   });
	})
</script>
</html>
