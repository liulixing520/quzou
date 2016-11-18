<div class="pageContent">
<div class="pageContent" layoutH="42">
<form name="order_status_form" id="order_status_form" method="post" action='changeOrderStatus' class="order_form">
	<input type='hidden' value='${orderId!}' name='orderId'>
	<input type='hidden' value='${statusId!}' name='statusId'>
	<input type='hidden' value='${statusId!}' name='setItemStatus'>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03" >
	<tr><td>操作备注:</td></tr>
	<tr><td><textarea rows='6' cols='60' name='changeReason'></textarea></td></tr>
	</table>
</form>
</div>
<br/>
<div class="formBar" >
	<a class="btn btn-info" href="#" onclick="javascript:addProToOrder();"  ><span>确定</span></a> <a class="btn btn-info" href="#" onclick='javascript:window.close();'><span>关闭</span></a>
				
	</div> 
</div>	 
<script language='javascript'>
function addProToOrder(){
		jQuery.ajax({
	    	        url: jQuery("#order_status_form").attr("action"),
	    	        type: 'POST',
	    	        data:jQuery("#order_status_form").serializeArray(),
	    	        error: function(msg) {
	    	           //alert(msg);
	    	        },
	    	        success: function(msg) {
	   					alert('操作成功!');
	   					window.opener.location.reload();
	   					window.close();
	   					
	    	        }
	    	    });
}
</script>	