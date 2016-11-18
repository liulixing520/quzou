
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head> 
    <title>打印购物清单</title> 
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
	<script type="text/javascript">
		function printWindow() {
	        factory.printing.header = "This is MeadCo";
	        factory.printing.footer = "Printing by ScriptX";
	        factory.printing.portrait = false;
	        factory.printing.leftMargin = 1.0;
	        factory.printing.topMargin = 1.0;  
	        factory.printing.rightMargin = 1.0;
	        factory.printing.bottomMargin = 1.0;
	        factory.printing.Print(false);
		}
	</script> 
</head> 
<body>
<#assign baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()/>
<#assign orh = Static["org.ofbiz.order.order.OrderReadHelper"].getHelper(orderHeader)>
<object  id="factory" viewastext style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" codebase="${baseUrl}/images/redist/smsx.cab#Version=5,60,0,360"></object>
	<div>
		<h1></span>购物清单</h1>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<caption width="100%">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
					<td>订单号：${orderHeader.orderId}</td>
					<td>订购日期：${orderHeader.orderDate.toString()}</td>
					<td>客户姓名：</td>
					<td>商品总数：${orh.getTotalOrderItemsQuantity()?string.number}</td>
				
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
				<th width="15%">小计</th>
			</tr>
			
			 <#list orderItemList as orderItem>
  			 	
                    <#assign product = orderItem.getRelatedOneCache("Product")>
              
				<tr >
					<td></td>
					<td>${product.productId}</td>
					<td>${product.productName!}
	  			  	</td>
					<td><@ofbizCurrency amount=orderItem.unitPrice isoCode=currencyUomId/></td>
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
					<p>订单留言：${noteInfo!}</p>
				</td>
				
				<td colspan="2">
					<p>商品金额总计：<@ofbizCurrency amount=orderSubTotal isoCode=currencyUomId/></p>

					
					<p>配送费用：<@ofbizCurrency amount=shippingAmount isoCode=currencyUomId/></p>
					
					<p>订单总金额：<@ofbizCurrency amount=orderHeader.grandTotal isoCode=orh.getCurrency()/></p>
					
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
				<input type="button" value="打印" onclick="javascript:printWindow();" />		
			</p>
		</form>
	</div> 

</body> 
</html>