<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head> 
    <title>打印配货单</title> 
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
		caption,.bd td{border-bottom:2px solid #000;}
		caption,.list th,.list td{text-indent:5pt}
		caption{font-weight:bold;padding:5px 0}
		p{margin:0;padding:5px 10px 0 0;}
		.b{font-weight:bold}
		.tleft{ text-align:left}
		.tright{ text-align:right}
		h1{font-size:21px;font-weight:normal}
		h1 span{font-size:12px;}
	</style>
	
</head> 
<body> 

<#assign baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()/>
<object id="factory"style="display:none" viewastext classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" codebase="${baseUrl}/images/redist/smsx.cab#Version=5,60,0,360"></object>
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
	<div class="tright">
		<input type="checkbox" checked="checked" onclick="doAddress()" id="print">
		打印配送地址
	</div>

	<div>
		<p class="tleft"><img src="/back/skins/default/admin/order/images/s.gif" /></p>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<caption style="font-weight:normal">
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
					<td style="text-indent:0">订单号 ${orderHeader.orderId}
						
						<br />订购日期：${orderHeader.orderDate.toString()}
					</td>
					<td class="tright">
						客户姓名：
						<br />
						电话：
					</td>
				
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
                            
  			 <#assign orderItemPriceInfos = orderReadHelper.getOrderItemPriceInfos(orderItem)>
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
			<tr class="bd">
				<td colspan="4">
					<p>订单留言：${noteInfo!}</p>
				</td>
				<#list orderContactMechValueMaps as orderContactMechValueMap>
			       <#assign contactMech = orderContactMechValueMap.contactMech>
			      
			  			  	<#if contactMech.contactMechTypeId == "POSTAL_ADDRESS">
			  			  		<#assign postalAddress = contactMech.getRelatedOne("PostalAddress")?if_exists />
			  			  	</#if>
		  			  	
			      </#list>
						
				<td colspan="2">
					<div id="address">
						<p>配送方式：
							<#list shipGroups as shipGroup>
							  	<#assign shipmentMethodType = shipGroup.getRelatedOne("ShipmentMethodType")?if_exists>
							</#list>
							${shipmentMethodType.description!}
					    </p>
						<p>收货人：<#if postalAddress?has_content>${postalAddress.toName!}</#if></p>
						<p>电话：<#if postalAddress?has_content>${postalAddress.phoneExd!}</#if></p>
						<p>手机：<#if postalAddress?has_content>${postalAddress.mobileExd!}</#if></p>
						<p>地址：<#if postalAddress?has_content>${postalAddress.address1!}</#if></p>
						<p>邮编：<#if postalAddress?has_content>${postalAddress.postalCode!}</#if></p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
					</div>
				</td>
			</tr>
			<tr class="bd">
				<td colspan="6">
					<p class="b" style="font-size:19px;">签字：</p>
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
<script>
	function doAddress() {
		var checkAdd = document.getElementById("print");
		var add = document.getElementById("address");
		if (checkAdd.checked == true) {
			add.style.display="" ;
		} else {
			add.style.display="none"
		}
	}
</script>