<div class="pageContent">
<div class="pageContent" layoutH="42">
<form name="order_status_form" id="order_status_form" method="post" action='quickShipOrder' class="order_form">
	<input type='hidden' value='${orderId!}' name='orderId'>
	<input type='hidden' value='${shipGroupSeqId?default("00001")}' name='shipGroupSeqId'>
	<input type="hidden"  name="shipping_method"  id="shipping_method" value="NO_SHIPPING@_NA_">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="basic-table" >
	<tr><td>操作备注:</td><td><textarea rows='6' cols='55' name='shippingInstructions'></textarea></td></tr>
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