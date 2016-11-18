<div class="pageContent">
<div class="pageContent" layoutH="42">
<form name="shipment_status_form" id="shipment_status_form" method="post" action='changeRoiShipmentStatus' class="order_form">
	<input type='hidden' value='${orderId!}' name='orderId'>
	<input type='hidden' value='${statusId!}' name='statusId'>
	<input type='hidden' value='${shipmentId!}' name='shipmentId'>
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
	    	        url: jQuery("#shipment_status_form").attr("action"),
	    	        type: 'POST',
	    	        data:jQuery("#shipment_status_form").serializeArray(),
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