
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
<object  id="factory" viewastext style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" codebase="${baseUrl}/images/redist/smsx.cab#Version=5,60,0,360"></object>
	<div>
	<table width="300px" border="0" cellspacing="0" cellpadding="0">
	<tr><td><h1></span>|</h1></td></tr>
	</table>
	
	<table width="300px" border="0" cellspacing="0" cellpadding="0">
	<tr><td>店名：</td><td><#if productStore??>${productStore.storeName!}</#if></td></tr>
	<tr><td>地址：</td><td><#if postalAddressView??>  ${postalAddressView.address1!} </#if></td></tr>
	<tr><td>电话：</td><td><#if telecomPhoneNumber?has_content>${telecomPhoneNumber.countryCode!}-${telecomPhoneNumber.areaCode!}-${telecomPhoneNumber.contactNumber!}</#if></td></tr>
	<tr><td colspan="2">------------------------------------------</td></tr>
	</table>
	
	<table width="300px" border="0" cellspacing="0" cellpadding="0">
	<tr><td>订单号：${orderHeader.orderId}</td><td>时间：${orderHeader.orderDate.toString()}</td></tr>
	<tr><td>收银员：123${orderHeader.placingPartyRole!}456</td><td>会员：654321</td></tr>
	<tr><td colspan="2">------------------------------------------</td></tr>
	
	</table>
		<table width="300px" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="20%">商品</td><td width="20%">单价</td><td width="20%">数量</td><td width="20%">折扣</td><td width="20%">金额</td></tr>
	 <#list orderItemList as orderItem>
  			 	
                    <#assign product = orderItem.getRelatedOneCache("Product")>
	<tr><td width="20%">${product.productName}</td>
	<td width="20%"><@ofbizCurrency amount=orderItem.unitPrice isoCode=currencyUomId/></td>
	<td width="20%">${orderItem.quantity?default(0)?string.number}</td>
	<td width="20%">0</td>
	<td width="20%"><#if orderItem.statusId != "ITEM_CANCELLED">
                                        <@ofbizCurrency amount=Static["org.ofbiz.order.order.OrderReadHelper"].getOrderItemSubTotal(orderItem, orderAdjustments) isoCode=currencyUomId/>
                                    <#else>
                                        <@ofbizCurrency amount=0.00 isoCode=currencyUomId/>
               </#if>
               
</td>
</tr>
	
	
	</#list>
	<tr><td colspan="2">------------------------------------------</td></tr>
	</table>
		
		<table width="300px" border="0" cellspacing="0" cellpadding="0">
			<tbody>
			<tr  class="bd">
				<td colspan="4">
					<p>总数量：</p>
				</td>
				<td colspan="2">
					<p>商品金额总计：<@ofbizCurrency amount=orderSubTotal isoCode=currencyUomId/></p>
					
					<p>配送费用：<@ofbizCurrency amount=shippingAmount isoCode=currencyUomId/></p>
				</td>
			</tr>
			</tbody>
		</table>
	<table width="300px" border="0" cellspacing="0" cellpadding="0">
		<tr><td>感谢惠顾，欢迎再次光临！</td></tr>
		<tr><td>www.rossoerosso.cn</td></tr>
	</table>
	<table width="300px" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<form>
					<p>
						<input type="button" value="打印" onclick="javascript:printWindow();" />		
					</p>
				</form>
				</td>
		</tr>
	</table>
	

	
	
		
	</div> 
</body> 
</html>