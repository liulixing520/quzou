<#assign flag = request.getAttribute("flag")?if_exists/>
<script>window.close();</script>
<#--
<#if flag == "true"||true> 
	<#assign order_id = request.getAttribute("out_trade_no")?if_exists/>
	<#assign total_fee = request.getAttribute("total_fee")?if_exists/>
	<#assign subject = request.getAttribute("subject")?if_exists/>
	<#assign body = request.getAttribute("body")?if_exists/>
	<#assign result = request.getAttribute("result")?if_exists/>
	<#assign trade_status = request.getAttribute("trade_status")?if_exists/>
	<#assign return_url = request.getAttribute("return_url")?if_exists/>
		显示订单信息如下<br>
		订单号:${order_id?if_exists}  <br>
		订单总价:${total_fee?if_exists} <br>
		商品名称:${subject?if_exists} <br>
		商品描述:${body?if_exists}  <br>
		交易状态:${result?if_exists}[${trade_status?if_exists}]
		<br>
		<br><a href="${return_url?if_exists}">返回继续购物</a>
<#elseif flag=="fail">
	支付失败
</#if>
-->
				