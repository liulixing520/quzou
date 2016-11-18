<div class="pageContent">
<div class="pageContent" layoutH="42">
<form name="order_status_form" id="order_status_form" method="post" action='quickRefundOrder' class="order_form">
	<input type='hidden' value='${orderId!}' name='orderId'>
	<input type="hidden" name="receiveReturn" value="false"/><!--自动退回货运 -->
    <input type="hidden" name="returnHeaderTypeId" value="CUSTOMER_RETURN"/><!--来自客户退货、另一个为BILL_FROM_VENDOR -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03" >
	<tr><td>操作备注:</td></tr>
	<tr><td><textarea rows='6' cols='60' name='changeReason'></textarea></td></tr>
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
		jQuery.ajax({
	    	        url: jQuery("#order_status_form").attr("action"),
	    	        type: 'POST',
	    	        data:jQuery("#order_status_form").serializeArray(),
	    	        error: function(msg) {
	    	           //alert(msg);
	    	        },
	    	        success: function(msg) {
	   					alert('操作成功!');
	   					closeDialog();
	    	        }
	    	    });
}
</script>	