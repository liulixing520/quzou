<#assign payeaseRequest=requestAttributes.payeaseRequest>
<form name="form" method="post" action="https://pay.yizhifubj.com/customer/gb/pay_bank.jsp">
<input type="hidden" name="v_mid" value="${(payeaseRequest.getV_mid())!}">
<input type="hidden" name="v_oid" value="${(payeaseRequest.getV_oid())!}">
<input type="hidden" name="v_rcvname" value="${(payeaseRequest.getV_rcvname())!}">
<input type="hidden" name="v_rcvaddr" value="${(payeaseRequest.getV_rcvaddr())!}">
<input type="hidden" name="v_rcvtel" value="${(payeaseRequest.getV_rcvtel())!}">
<input type="hidden" name="v_rcvpost" value="${(payeaseRequest.getV_rcvpost())!}">
<input type="hidden" name="v_amount" value="${(payeaseRequest.getV_amount())!}">
<input type="hidden" name="v_ymd" value="${(payeaseRequest.getV_ymd())!}"> 
<input type="hidden" name="v_orderstatus" value="${(payeaseRequest.getV_orderstatus())!}">
<input type="hidden" name="v_ordername" value="${(payeaseRequest.getV_ordername())!}">
<input type="hidden" name="v_moneytype" value="${(payeaseRequest.getV_moneytype())!}">
<input type="hidden" name="v_url" value="${(payeaseRequest.getV_url())!}">
<input type="hidden" name="v_md5info" value="${(payeaseRequest.getV_md5info())!}">
<input type="hidden" name="v_pmode" value="205">
<#--
<select name="v_pmode">
	<option value="3">3 招商银行</option>
	<option value="9">9 工商银行</option>
	<option value="4">4 建设银行</option>
</select>
-->

<input type="hidden" width="150" height="30" id="zhifu" value ="去支付" onClick="javascript:document.form.submit();">
</form>
<script>
	document.form.submit();
</script>