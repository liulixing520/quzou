<#if orderId??>
<div class="order_pos_print_div" >
		<ul>
		<li><input type="button" onclick="window.open('<@ofbizUrl>printPosOrderItem</@ofbizUrl>?orderId=${orderId!}','小票打印','status=yes,toolbar=yes,menubar=yes,location=yes,fullscreen=yes,scrollbars=yes')" value="小票打印" class="input01" name="input"></li>
		</ul>
	</div>  
</div>
</#if>