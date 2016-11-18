<div class="pageContent">
<div class="pageContent" layoutH="42">
<form name="return_status_form" id="return_status_form" method="post" action='changeReturnStatus' class="order_form">
	<input type='hidden' value='${returnId!}' name='returnId' id='returnId'>
	<input type='hidden' value='${statusId!}' name='statusId'>
	<input type='hidden' value='${returnHeader.fromPartyId!}' name='fromPartyId'>
	<input type='hidden' value='${returnHeader.toPartyId!}' name='toPartyId'>

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td>操作备注:</td></tr>
	<tr><td><textarea rows='6' cols='60' name='changeReason' maxlength="60"></textarea></td></tr>
	</table>
</form>
</div>
<div class="formBar" >
		<ul>
		<li><a class="button" href="#" onclick="javascript:addProToOrder();"  ><span>确定</span></a></li>
		<li><a class="button" href="#" onclick='javascript:closeDialog();'><span>关闭</span></a></li>
		</ul>
				
	</div> 
</div>	 
<script language='javascript'>
function addProToOrder(){
	form = document.getElementById("return_status_form");
	if(validateForm(form)==undefined){
		$.ajax({
          type: "Post",
          url: "<@ofbizUrl>/changeReturnStatus</@ofbizUrl>",
          data: jQuery('#return_status_form').serialize(),
          success: function(data) {alert
              if(data._ERROR_MESSAGE_) {
					 alert(data._ERROR_MESSAGE_);
				 }
				 else{
					 alert('操作成功!');closeDialog();
				 }
          },
          error: function(err) {
              alert(err);
          }
      });
	}
}
</script>	