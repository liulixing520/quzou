
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head> 
    <title>打印退货单</title> 
    <meta charset="utf-8"> 
	<style type="text/css">
		body{
			font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
			font-size:10pt;
			color:black;
			background:#fff;
			text-align:center
			}
		div{width:90%;margin:0 auto;}
		table{border-collapse:collapse;border-spacing:0;}
		table,caption,td,th{text-align:left}
		table td,table th{vertical-align:top;padding:3px 0;}
		.fright{float:right}
		caption,.bd td{border-bottom:3px solid #000;}
		caption,.list th,.list td{text-indent:5pt}
		caption{font-weight:bold;padding:5px 0}
		caption span{display:block;float:left}
		p{margin:0;padding:5px 10px 0 0}
		.b{font-weight:bold}
		.tright{ text-align:right}
		h1{font-size:21px;font-weight:normal}
		h1 span{font-size:12px;}
	</style>
</head> 
<body> 
	<div>
		<h1></span>退货单打印</h1>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<caption width="100%">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
					<td>订单号：${orderHeader.orderId}</td>
					<td>订购日期：${orderHeader.orderDate.toString()}</td>
					<td>客户姓名：</td>
					<td>商品总数：${num!}</td>
				
					</tr>

				</table>
			</caption>
			
			<tbody class="list">
			<tr  class="bd">
				<th width="5%">No</th>
				<th width="20%">商品编号</th>
				<th width="35%">商品名称</th>
				<th width="15%">单价</th>
				<th width="10%">数量</th>
				<th width="15%">小记</th>
			</tr>
			
			 <#list orderItemList as orderItem>
  			 	
                    <#assign product = orderItem.getRelatedOneCache("Product")>
                            
  			 <#assign orderItemPriceInfos = orderReadHelper.getOrderItemPriceInfos(orderItem)>
				<tr >
					<td></td>
					<td>${product.productId}</td>
					<td>${product.productName!}
	  			  	</td>
					<td><#if orderItemPriceInfos?exists && orderItemPriceInfos?has_content>
  			  <#list orderItemPriceInfos as orderItemPriceInfo>
  			  	<@ofbizCurrency amount=orderItemPriceInfo.modifyAmount isoCode=currencyUomId/>
  			  </#list>
  			  </#if></td>
					<td>${orderItem.quantity?default(0)?string.number}</td>
					<td>
				<#if orderItem.statusId != "ITEM_CANCELLED">
                                        <@ofbizCurrency amount=Static["org.ofbiz.order.order.OrderReadHelper"].getOrderItemSubTotal(orderItem, orderAdjustments) isoCode=currencyUomId/>
                                    <#else>
                                        <@ofbizCurrency amount=0.00 isoCode=currencyUomId/>
               </#if>
				</td>
				</tr>
				</#list>
		
			</tbody>
			
			<tbody>
			<tr  class="bd">
				<td colspan="4">
					<p>订单留言：<#if orderNotes?has_content>
  			  	<#assign orderNote = orderNotes.get(0)>
  			  	${orderNote.noteInfo?replace("\n", "<br/>")}
  			  </#if></p>
				</td>
				
				<td colspan="2">
					<p>商品金额总计：<@ofbizCurrency amount=orderSubTotal isoCode=currencyUomId/></p>
					<p>礼券优惠：</p>
					<p>促销优惠：</p>
					<p>账户余额支付：元</p>
					<p>积分抵用： 元</p>
					<p>其他优惠： 元</p>
					
					<p>配送费用：<@ofbizCurrency amount=shippingAmount isoCode=currencyUomId/></p>
					<p>您已经支付：</p>
				</td>
			</tr>
			<tr  class="bd">
				<td colspan="4">
					<p>目前您的总积分为<#if userAccount??> ${userAccount.integral!0}</#if>，累计购物次数<#if userHistoryInfo?? &&userHistoryInfo[0]??>${userHistoryInfo[0]!0} <#else>0 </#if>次，累计购物金额<#if userHistoryInfo?? &&userHistoryInfo[1]??>${userHistoryInfo[1]?string.currency!} <#else> 0 </#if>元</p>
					
				</td>
				
				<td colspan="2" class="b tright">
				
				应支付总金额：￥ 元
				
				</td>
			</tr>
			<tr  class="bd">
				<td colspan="4">
					<p>服务商：<#if storeBaseSetBean?? && storeBaseSetBean.name??>${storeBaseSetBean.name!}</#if></p>
					<p>电话：<#if storeBaseSetBean?? && storeBaseSetBean.telephone??>${storeBaseSetBean.telephone!}</#if></p>
					<p>邮箱：<#if storeBaseSetBean?? && storeBaseSetBean.email??>${storeBaseSetBean.email!}</#if></p>
				</td>
				
				<td colspan="2" class="b tright">
				
				
				
				</td>
			</tr>
			</tbody>
		</table>
		
		<form>
			<p>
				<input type="button" value="打印" onclick="javascript:window.print();" />		
			</p>
		</form>
	</div> 

</body> 
</html>