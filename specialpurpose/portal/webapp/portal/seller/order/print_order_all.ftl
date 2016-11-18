<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>打印订单</title>

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
		.dotd td{border-bottom:1px dotted #000;}
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

	<div>
		<p style="float:right"></p>
		<h1><#if storeBaseSetBean?? && storeBaseSetBean.name??>${storeBaseSetBean.name!}</#if><span><#if storeBaseSetBean?? && storeBaseSetBean.url??>（${storeBaseSetBean.url!}）</#if></span>订单详情</h1>
	</div>
	<div>
<table width="100%" cellpadding="0" cellspacing="0">
	<tr class="bd">
		<td colspan="2">订单号：${orderHeader.orderId}</td>
		<td colspan="2" class="tright">下单时间：${orderHeader.orderDate.toString()}</td>
	</tr>
	<#list orderContactMechValueMaps as orderContactMechValueMap>
       <#assign contactMech = orderContactMechValueMap.contactMech>
	  	<#if contactMech.contactMechTypeId == "POSTAL_ADDRESS">
	  		<#assign postalAddress = contactMech.getRelatedOne("PostalAddress")?if_exists />
	  	</#if>
    </#list>
	<tr class="dotd">
		<td>
			收货人：
			
			<#if postalAddress?has_content>${postalAddress.toName!}</#if>
		</td>
		<td>
		
			电话：
			<#if postalAddress?has_content>${postalAddress.phoneExd!}</#if>
		</td>
		<td>
			手机：
			<#if postalAddress?has_content>${postalAddress.mobileExd!}</#if>
		</td>
		<td>
			送货时间：${shippmentDateType!}
			
		</td>
  	</tr>
  	<tr class="dotd">
		<td>
			邮政编码：
			<#if postalAddress?has_content>${postalAddress.postalCode!}</#if>
		</td>
		<td>
			送货地址：
			<#if postalAddress?has_content>
  			  <#assign AddressGeoAllCn =Static["org.ofbiz.iteamgr.party.ContactMechTools"].
  			  getAddressGeoAllCn(delegator,postalAddress.stateProvinceGeoId,postalAddress.cityGeoId,postalAddress.countyGeoId)>
  			  ${AddressGeoAllCn!}
		    </#if>
		    <#if postalAddress?has_content>${postalAddress.address1!}</#if>
		</td>
		<td align="right" colspan="2"></td>
  	</tr>
  	<tr  class="dotd">
		<td>
			支付方式：
			<#assign payType =Static["org.ofbiz.iteamgr.order.OrderServices"].getOrderPayTypeCn(delegator, orderHeader.orderId)>
              ${payType!}
			</td>
		<td >
			支付状态：
			<#assign status =Static["org.ofbiz.iteamgr.order.OrderServices"].getOrderPayStatusCn(delegator, orderHeader.orderId)>
			  ${status!}</td>
		<td align="right" colspan="2"></td>
  	</tr>
  	<tr class="dotd">
  		
  		<td>发票内容：${invoiceText!}
		
		</td>
    	<td>发票抬头：${invoiceTitle!}
		
		</td>
        <td colspan="2"></td>
    </tr>
  	<tr class="bd">
  		<td colspan="4">客户留言：
		${noteInfo!}
		</td>
  	</tr>
</table>
</div>
	<div>
		<table width="100%" cellpadding="0" cellspacing="0">
			<tr>
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
			<tr  class="bd"><td colspan="6" style="height:5px;overflow:hidden"></td></tr>
		</table>
	</div>
 
<div>
<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
    	<td >商品金额总计：
		<@ofbizCurrency amount=orderSubTotal isoCode=currencyUomId/>元
		</td>
		<td class="tright">配送费用：
		
		<@ofbizCurrency amount=shippingAmount isoCode=currencyUomId/></td>
		<td class="tright">订单总金额：<@ofbizCurrency amount=orderHeader.grandTotal isoCode=currencyUomId/></td>
    </tr>
	
</table>
<form>
			<p>
				<input type="button" value="打印" onclick="javascript:printWindow();" />		
			</p>
		</form>	
</div>
</body>
</html>

