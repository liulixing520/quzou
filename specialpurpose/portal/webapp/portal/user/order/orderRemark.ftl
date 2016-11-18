<#if parameters.operName?? >
	<#if parameters.operName=='applyForRefund'>
		<form action='user_myorder' method='POST' id="refundReasonForm">
			<#if parameters.orderId??>
				<input type="hidden" name="orderId" value="${parameters.orderId!}"/>
				<input type="hidden" name="applyForRefund" value="Y"/>
				退款理由：<textarea name="refundReason"></textarea><br/>
				<input type="button" onclick="if($('input[name=refundReason]').val()){$('#refundReasonForm').submit();}else{alert('请输入理由！');}" value="提交"/>
				<input type="button" onclick="location.href='/portal/control/user_myorder'" value="取消"/>
			<#else>
				<script>
					$(function(){
						$('#refundReasonForm').submit();
					});
				</script>
			</#if>
		</form>
	<#elseif parameters.operName=='cancelRefund'>
		<#if parameters.orderId??>
			<#assign cancelResult = Static["org.ofbiz.ebiz.order.OrderHelper"].cancelRefundOrder(delegator,parameters.orderId)?if_exists/>
		</#if>
		<script>
			$(function(){
				location.href="/portal/control/user_myorder";
			});
		</script>
	<#elseif parameters.operName=='refuseRefund'>
		<form action='FindOrderEn' method='POST' id="refuseReasonForm">
			<#if parameters.orderId??>
				<input type="hidden" name="orderId" value="${parameters.orderId!}"/>
				<input type="hidden" name="ifRefuse" value="Y"/>
				拒绝理由：<textarea name="refuseReason"></textarea><br/>
				<input type="button" onclick="if($('input[name=refuseReason]').val()){$('#refuseReasonForm').submit();}else{alert('请输入理由！');}" value="提交"/>
				<input type="button" onclick="location.href='/portal/control/FindOrderEn'" value="取消"/>
			<#else>
				<script>
					$(function(){
						$('#refuseReasonForm').submit();
					});
				</script>
			</#if>
		</form>
	<#elseif parameters.operName=='sendOrder'>
		<#if parameters.orderId?? && parameters.trackingNumber??>
			<#assign mgrResult = Static["org.ofbiz.ebiz.order.OrderHelper"].updateTrackingNumber(delegator,parameters.orderId,parameters.trackingNumber)?if_exists/>
		</#if>
		<script>
			$(function(){
				location.href="/portal/control/FindOrderEn?orderId=${parameters.orderId}&statusId2=ORDER_SENT&statusId=ORDER_APPROVED";
			});
		</script>
	</#if>
<#else>
	<script>
		$(function(){
			window.history.go(-1);
		});
	</script>
</#if>