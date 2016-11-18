<div id="all_main" class='pageContent'>
<script language='javascript'>
	function closeReturnOrderialog() {
		 	navTab.reload();
		  	return true;
	}
</script>
  <!--功能区域-->
  <div id="head_main" class='head_main'>
   <div class="main_nav">
   		<span>退换货单<strong style="margin:0 10px"> #${returnId!}</strong> 的信息</span>
   		<div style="text-align:left">
    	</div>
   </div>
    <#if returnHeader.statusId != "RETURN_CANCELLED">
    <div class="main_soso">
    <table cellspacing="0" cellpadding="0" border="0" width="100%">
  		<tbody><tr>
    <td width="450px" height="30" align="right">&nbsp;</td>
    <td align="right">
    <#if returnHeader.statusId == "RETURN_REQUESTED">
	 	<a close="closeReturnOrderialog" href="<@ofbizUrl>toChangeReturnStatus?returnId=${returnId!}&statusId=RETURN_ACCEPTED</@ofbizUrl>" target="dialog" mask="true" title="退货单接受处理" class="button"><span>接受</span></a>
	 	<a close="closeReturnOrderialog" href="<@ofbizUrl>toChangeReturnStatus?returnId=${returnId!}&statusId=RETURN_CANCELLED</@ofbizUrl>" target="dialog" mask="true" title="退货单取消处理" class="button"><span>取消</span></a>
    <#elseif returnHeader.statusId == "RETURN_ACCEPTED">
	   	<a class="button" close="closeReturnOrderialog" href="<@ofbizUrl>toChangeReturnStatus?returnId=${returnId!}&statusId=RETURN_RECEIVED</@ofbizUrl>" target="dialog" mask="true" title="退货单接收处理" class="button"><span>接收</span></a>
	 	<a close="closeReturnOrderialog" href="<@ofbizUrl>toChangeReturnStatus?returnId=${returnId!}&statusId=RETURN_CANCELLED</@ofbizUrl>" target="dialog" mask="true" title="退货单取消处理" class="button"><span>取消</span></a>
    <#elseif returnHeader.statusId == "RETURN_RECEIVED">
	   	<#if returnHeader.returnTypeId == "RTN_REFUND">
	 		<a close="closeReturnOrderialog" href="<@ofbizUrl>toChangeReturnStatus?returnId=${returnId!}&statusId=RETURN_MAN_REFUND</@ofbizUrl>" target="dialog" mask="true" title="退货单手工退款处理" class="button"><span>手工退款</span></a>
	 	<#else>
		   	<a close="closeReturnOrderialog" href="<@ofbizUrl>toChangeReturnStatus?returnId=${returnId!}&statusId=RETURN_COMPLETED</@ofbizUrl>" target="dialog" mask="true" title="退货单完成处理" class="button"><span>完成</span></a>
	 	</#if>
	 	<a close="closeReturnOrderialog" href="<@ofbizUrl>toChangeReturnStatus?returnId=${returnId!}&statusId=RETURN_CANCELLED</@ofbizUrl>" target="dialog" mask="true" title="退货单取消处理" class="button"><span>取消</span></a>
    </#if>
 </td>
    </tr>
</tbody></table>
</div>
</#if>
  </div>
  <!--主要内容-->
  <div id="list" layouth="15" class="pageFormContent" style="height: 158px; overflow: auto;">
  <div id="cont02" style="">
  	<div class="content_temp">
    <!--订单基本信息 start-->
        
<#macro displayReturnAdjustment returnAdjustment adjEditable>
    <#assign returnHeader = returnAdjustment.getRelatedOne("ReturnHeader")>
    <#assign adjReturnType = returnAdjustment.getRelatedOne("ReturnType")?if_exists>
    <tr>
        <td colspan="8" align="center"><span class="label">${returnAdjustment.get("description",locale)?default("N/A")}</span>
            <#if returnAdjustment.comments?has_content>: ${returnAdjustment.comments}</#if>
        </div>
        <@ofbizCurrency amount=returnAdjustment.amount?default(0) isoCode=returnHeader.currencyUomId/>
        </td>
       <#assign returnTotal = returnTotal + returnAdjustment.amount?default(0)>
    </tr>
</#macro>


<div class="screenlet">
    <div class="screenlet-body">
	<!-- if we're called with loadOrderItems or createReturn, then orderId would exist -->
	<#if !requestParameters.orderId?exists>
      <form method="post" action="<@ofbizUrl>updateReturnItems</@ofbizUrl>">
      	<input type="hidden" name="_useRowSubmit" value="Y" />
        <table cellspacing="0" cellspacing="0" cellpadding="0" border="0" width="100%" style="margin-top:15px" class="border04 overall_03">
          <#assign readOnly = (returnHeader.statusId == returnHeader.statusId)>
          <tr class="title02">
    			<td colspan="2">退换货单明细信息</td><td colspan="3">申请时间：${returnHeader.entryDate?string('yyyy-MM-dd HH:mm:ss')!}</td>
	             <#assign rt = delegator.findOne("ReturnType", {"returnTypeId" : returnHeader.returnTypeId}, true)>
	             <td colspan="3">退换货类型：${rt.get("description",locale)?if_exists}</td>
		  </tr>
          <tr class="background_tr">
            <td class="border06 width15">${uiLabelMap.OrderOrderItems}</td>
            <td class="border06 width15">商品编号</td>
            <td class="border06 width15">${uiLabelMap.CommonDescription}</td>
            <td class="border06 width15">${uiLabelMap.OrderQuantity}</td>
            <td class="border06 width15">${uiLabelMap.OrderPrice}</td>
            <td class="border06 width15">${uiLabelMap.OrderSubTotal}</td>
            <td class="border06 width15">${uiLabelMap.OrderReturnReason}</td>
            <td class="border06 width15">备注</td>
          </tr>
          <#assign returnTotal = 0.0>
          <#assign rowCount = 0>
          <#assign rowCountForAdjRemove = 0>
          <#if returnItems?has_content>
            <#assign alt_row = false>
            <#list returnItems as item>
              <#assign relatedOrderId = item.orderId>
              <#assign orderItem = item.getRelatedOne("OrderItem")?if_exists>
              <#assign orderHeader = item.getRelatedOne("OrderHeader")?if_exists>
              <#assign returnReason = item.getRelatedOne("ReturnReason")?if_exists>
              <#assign returnType = item.getRelatedOne("ReturnType")?if_exists>
              <#assign status = item.getRelatedOne("InventoryStatusItem")?if_exists>
              <#assign shipmentReceipts = item.getRelated("ShipmentReceipt")?if_exists>
              <#if (item.get("returnQuantity")?exists && item.get("returnPrice")?exists)>
                 <#assign returnTotal = returnTotal + item.get("returnQuantity") * item.get("returnPrice") >
                 <#assign returnItemSubTotal = item.get("returnQuantity") * item.get("returnPrice") >
              <#else>
                 <#assign returnItemSubTotal = null >  <#-- otherwise the last item's might carry over -->
              </#if>
              <tr valign="middle"<#if alt_row> class="background_tr"</#if>>
                <td class="border06 width15"><a href="<@ofbizUrl>OrderDetail?orderId=${item.orderId}</@ofbizUrl>"  rel="OrderDetail" title="详情"><span>${item.orderId}</span></a> - ${item.orderItemSeqId?default("N/A")}
                  <input name="orderId_o_${rowCount}" value="${item.orderId}" type="hidden" />
                  <input name="returnId_o_${rowCount}" value="${item.returnId}" type="hidden" />
                  <input name="returnItemTypeId_o_${rowCount}" value="${item.returnItemTypeId}" type="hidden" />
                  <input name="returnItemSeqId_o_${rowCount}" value="${item.returnItemSeqId}" type="hidden" />
                  <input type="hidden" name="_rowSubmit_o_${rowCount}" value="Y" />
                </td>
                <td class="border06 width15"><div>
                    <#if item.get("productId")?exists>
                        ${item.productId}
                    <#else>
                        N/A
                    </#if></div></td>
                <td class="border06 width15"><div>
                    <#if readOnly>
                        ${item.description?default("N/A")}
                    <#else>
                        <input name="description_o_${rowCount}" value="${item.description?if_exists}" type="text" size="15" />
                    </#if>
                    </div></td>
                <td class="border06 width15"><div>
                    <#if readOnly>
                        ${item.returnQuantity?string.number}
                    <#else>
                        <input name="returnQuantity_o_${rowCount}" value="${item.returnQuantity}" type="text" size="8" align="right" />
                    </#if>
                    <#if item.receivedQuantity?exists>
                    <br />${uiLabelMap.OrderTotalQuantityReceive}: ${item.receivedQuantity}
                        <#list shipmentReceipts?if_exists as shipmentReceipt>
                            <br />${uiLabelMap.OrderQty}: ${shipmentReceipt.quantityAccepted}, ${shipmentReceipt.datetimeReceived}, ${shipmentReceipt.inventoryItemId}
                        </#list>
                    </#if>
                    </div></td>
                <td class="border06 width15"><div>
                    <#if readOnly>
                        <@ofbizCurrency amount=item.returnPrice isoCode=orderHeader.currencyUom/>
                    <#else>
                        <input name="returnPrice_o_${rowCount}" value="${item.returnPrice}" type="text" size="8" align="right" />
                    </#if>
                    </div></td>
                <td class="border06 width15">
                    <#if returnItemSubTotal?exists><@ofbizCurrency amount=returnItemSubTotal isoCode=orderHeader.currencyUom/></#if>
                </td>
                <td class="border06 width15"><div>
                    <#if readOnly>
                        ${returnReason.get("description",locale)?default("N/A")}
                    <#else>
                        <select name="returnReasonId_o_${rowCount}">
                            <#if (returnReason?has_content)>
                                <option value="${returnReason.returnReasonId}">${returnReason.get("description",locale)?if_exists}</option>
                                <option value="${returnReason.returnReasonId}">--</option>
                            </#if>
                            <#list returnReasons as returnReasonItem>
                                <option value="${returnReasonItem.returnReasonId}">${returnReasonItem.get("description",locale)?if_exists}</option>
                            </#list>
                        </select>
                    </#if>
                    </div></td>
                <td class="border06 width15"><div> ${item.comments?if_exists}
                </div>
                </td>
              </tr>
              <#assign rowCount = rowCount + 1>
	          	<#assign returnItemAdjustments = item.getRelated("ReturnAdjustment")>
				<#if (returnItemAdjustments?has_content)>
					<#list returnItemAdjustments as returnItemAdjustment>
						<#if returnItemAdjustment.amount&gt;0>
				        	<@displayReturnAdjustment returnAdjustment=returnItemAdjustment adjEditable=false/>
				        </#if>
				    </#list>
				</#if>
              <#-- toggle the row color -->
              <#assign alt_row = !alt_row>
            </#list>
        <#else>
            <tr>
              <td colspan="8"><div>${uiLabelMap.OrderNoReturnItemsFound}</div></td>
            </tr>
        </#if>
            <#-- show the return total -->
        </table>
        </form>
<#if (returnAdjustments?has_content)>
	<table width='100%' border='0' cellspacing='0' cellpadding='0' class='border04 overall_03'>
		<#list returnAdjustments as returnAdjustment>
	        <#assign adjEditable = !readOnly>
	        <#if returnItemAdjustment.amount&gt;0>
	        	<@displayReturnAdjustment returnAdjustment=returnAdjustment adjEditable=adjEditable/>
	        </#if>
	    </#list>
	</table>
</#if>
<table width='100%' border='0' cellspacing='0' cellpadding='0' class='border04 overall_03'>
  <tr class='background_tr'>
    <td height='30' colspan='8'  style='text-align:right'><b>${uiLabelMap.OrderReturnTotal}:</b></td>
    <td height='30' style='text-align:center'><@ofbizCurrency amount=returnTotal isoCode=returnHeader.currencyUomId/></td>
  </tr>
</table>
<!-- if no requestParameters.orderId exists, then show list of items -->
</#if>
    </div>
</div>
<!--订单基本信息 end-->
    <!--用户信息 end-->
  	<#assign emailContactMech = delegator.findByAnd("OrderContactMech", {"orderId" : relatedOrderId, "contactMechPurposeTypeId" : "ORDER_EMAIL"})>
  	<#if emailContactMech?has_content>
    	<#assign email = delegator.findOne("ContactMech", {"contactMechId" : emailContactMech[0].contactMechId}, true)>
  	</#if>
    <#if returnHeader.originContactMechId?has_content>
            <#assign postalAddress = delegator.findOne("PostalAddress", {"contactMechId" : returnHeader.originContactMechId}, true)>
          <#else>
          	<#assign shippingContactMech = delegator.findByAnd("OrderContactMech", {"orderId" : relatedOrderId, "contactMechPurposeTypeId" : "SHIPPING_LOCATION"})>
            <#if shippingContactMech?has_content>
            	<#assign postalAddress = delegator.findOne("PostalAddress", {"contactMechId" : shippingContactMech[0].contactMechId}, true)>
          	</#if>
          </#if>
    	<table cellspacing="0" cellpadding="0" border="0" width="100%" class="border04 overall_03">
    <tbody><tr class="title02">
          <td height="30" style=" border-left:none" colspan="4"><b>用户信息</b></td>
      </tr>
        <tr>
  			  <td class="border03 width15">用户ID：</td>
		    <td class="border02 width35">${orderHeader.createdBy!}</td>
  			  <td class="border10 width15">E-mail：</td>
  			  <td class="border02 width35">
  			  <#if email?has_content>
  			  	${email.infoString}
  			  </#if>
  			  </td>
	      </tr>
  			<tr class="background_tr">
  			  <td class="label">收货人：</td>
  			  <td ><#if postalAddress?has_content>${postalAddress.toName!}</#if></td>
  			  <td class="border10">收货地区：</td>
  			  <td ><#if postalAddress?has_content>
  			  <#assign AddressGeoAllCn =Static["org.ofbiz.iteamgr.party.ContactMechTools"].
  			  getAddressGeoAllCn(delegator,postalAddress.stateProvinceGeoId,postalAddress.cityGeoId,postalAddress.countyGeoId)>
  			  ${AddressGeoAllCn!}
  			  </#if>
			</td>
		  </tr>
  			<tr>
  			  <td class="label">收货地址：</td>
  			  <td ><#if postalAddress?has_content>${postalAddress.address1!}</#if></td>
  			  <td class="border10">邮编：</td>
  			  <td ><#if postalAddress?has_content>${postalAddress.postalCode!}</#if></td>
		  </tr>
  			<tr class="background_tr">
  			  <td class="label">手机：</td>
  			  <td ><#if postalAddress?has_content>${postalAddress.mobileExd!}</#if></td>
  			  <td class="border10">固定电话：</td>
  			  <td ><#if postalAddress?has_content>${postalAddress.phoneAreaExd!}</#if>-<#if postalAddress?has_content>${postalAddress.phoneExd!}</#if></td>
		  </tr>
    </tbody></table>
    <!--用户信息 end-->


    <!--订单基本信息 end-->
    <!--用户信息 end-->
        <table cellspacing="0" cellpadding="0" border="0" width="100%" style="margin-top:15px" class="border04 overall_03">
    		<tbody><tr class="title02">
    			<td colspan="6">操作记录</td>
		    </tr>
  			<tr class="background_tr">
    			<td class="border06 width15">操作人</td>
    			<td class="border07 width20">操作时间</td>
  			  <td class="border07 width25">操作记录</td>
  			  <td class="border07 width40">操作备注</td>
		    </tr>
		    <#if orderReturnStatusHistories?has_content>
                  <#list orderReturnStatusHistories as orderReturnStatus>
                    <#assign loopStatusItem = orderReturnStatus.getRelatedOne("StatusItem")>
                    <tr>
                    <td class='border06'>${orderReturnStatus.changeByUserLoginId!}</td>
					<td class='border06'>${orderReturnStatus.statusDatetime?default("0000-00-00 00:00:00")?string} </td>
                    <td class='border06'>${loopStatusItem.get("description",locale)}</td>
                    <td class='border06'>${orderReturnStatus.changeReason!}</td>
                    </tr>
                  </#list>
             </#if>
		</tbody></table>
		</br></br></br>
  </div>
  </div>
 </div>