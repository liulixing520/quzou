<#if (requestAttributes.externalLoginKey)??><#assign externalKeyParam = "?externalLoginKey=" + requestAttributes.externalLoginKey!></#if>
<div class="content my_account">
	<h2 class="title" style='font-size:20px'>销售订单</h2>
	<div class="search_area">
		<table>
				<tr>
					<td>
						<form  id='forms' action="FindOrderEn" method="post">
							  <input type="hidden" name="hideFields" id="hideFields"  value="Y"/>
							  <input type='hidden' name='correspondingPoId' value='${requestParameters.correspondingPoId?if_exists}'/>
							  <input type='hidden' name='internalCode' value='${requestParameters.internalCode?if_exists}'/>
							  <input type='hidden' name='productId' value='${requestParameters.productId?if_exists}'/>
							  <input type='hidden' name='inventoryItemId' value='${requestParameters.inventoryItemId?if_exists}'/>
							  <input type='hidden' name='serialNumber' value='${requestParameters.serialNumber?if_exists}'/>
							  <input type='hidden' name='softIdentifier' value='${requestParameters.softIdentifier?if_exists}'/>
							  <input type='hidden' name='partyId'  id='partyId' value='${requestParameters.partyId?if_exists}'/>
							  <input type='hidden' name='billingAccountId' value='${requestParameters.billingAccountId?if_exists}'/>
							  <input type='hidden' name='createdBy' value='${requestParameters.createdBy?if_exists}'/>
							  <input type='hidden' name='minDate' value='${requestParameters.minDate?if_exists}'/>
							  <input type='hidden' name='maxDate' value='${requestParameters.maxDate?if_exists}'/>
							  <input type='hidden' name='roleTypeId' value="${requestParameters.roleTypeId?if_exists}"/>
							  <input type='hidden' name='orderTypeId' value='${requestParameters.orderTypeId?if_exists}'/>
							  <input type='hidden' name='salesChannelEnumId' value='${requestParameters.salesChannelEnumId?if_exists}'/>
							  <input type='hidden' name='productStoreId' value='${productStoreId?if_exists}'/>
							  <input type='hidden' name='orderWebSiteId' value='${requestParameters.orderWebSiteId?if_exists}'/>
							  <input type='hidden' name='orderStatusId' value='${requestParameters.orderStatusId?if_exists}'/>
							  <input type='hidden' name='hasBackOrders' value='${requestParameters.hasBackOrders?if_exists}'/>
							  <input type='hidden' name='filterInventoryProblems' value='${requestParameters.filterInventoryProblems?if_exists}'/>
							  <input type='hidden' name='filterPartiallyReceivedPOs' value='${requestParameters.filterPartiallyReceivedPOs?if_exists}'/>
							  <input type='hidden' name='filterPOsOpenPastTheirETA' value='${requestParameters.filterPOsOpenPastTheirETA?if_exists}'/>
							  <input type='hidden' name='filterPOsWithRejectedItems' value='${requestParameters.filterPOsWithRejectedItems?if_exists}'/>
							  <input type='hidden' name='countryGeoId' value='${requestParameters.countryGeoId?if_exists}'/>
							  
							  <input type='hidden' name='stateGeoId' value='${requestParameters.stateGeoId?if_exists}'/>
							  <input type='hidden' name='cityGeoId' value='${requestParameters.cityGeoId?if_exists}'/>
							  <input type='hidden' name='countyGeoId' value='${requestParameters.countyGeoId?if_exists}'/>
							  <input type='hidden' name='shipmentStatusId' value='${requestParameters.shipmentStatusId?if_exists}'/>
							  
							  <input type='hidden' name='includeCountry' value='${requestParameters.includeCountry?if_exists}'/>
							  <input type='hidden' name='isViewed' value='${requestParameters.isViewed?if_exists}'/>
							  <input type='hidden' name='shipmentMethod' value='${requestParameters.shipmentMethod?if_exists}'/>
							  <input type='hidden' name='gatewayAvsResult' value='${requestParameters.gatewayAvsResult?if_exists}'/>
							  <input type='hidden' name='gatewayScoreResult' value='${requestParameters.gatewayScoreResult?if_exists}'/>
							  <input type='hidden' name='showAll' id='showAll' value="Y"/>
							  <input type='hidden' name='aotuSearch' id='aotuSearch' value="Y"/>
							  <input type="hidden" name="lookupFlag" value="Y"/>
							<table class="searchContent">
								<tr>
									<td>
									           订单号：<input type="text" name="orderId" value='${requestParameters.orderId!}'/>
										<input type="hidden" value="Y" name="orderId_ic">
										<input type="hidden" value="contains" name="orderId_op">
									</td>
									<td>
									           下单人：<input type="text" name="userLoginId" value='${requestParameters.userLoginId!}'/>
										<input type="hidden" value="Y" name="userLoginId_ic">
										<input type="hidden" value="contains" name="userLoginId_op">
									</td>
									<td>&nbsp;&nbsp;&nbsp;&nbsp;
										<input class="border_btn" type="submit" value="查询">
									</td>
								</tr>
							</table>
						</form>
					<td>
					</td>
				</tr>
			</table>
		<div>
		</div>
		
	</div>
       <div class="listheight">
   			<table class="points_table tab_content" cellspacing="0" width="100%">
	          <thead>
	          	<tr  class='header-row-2'>
	            
	            <th width="10%"><input type="checkBox" class="checkboxCtrl" group="orderIndexs">订单号</th>
	            <th width="13%" >
	            	下单时间
	            </th>
	            <!-- <th width="13%">交易成功时间</th> -->
	            <th width="10%">下单人</th>
	            <th width="10%">收货人</th> 
	            <th width="10%">订单金额</th>
	            <th width="10%">支付方式</th>
	            <th width="10%">订单状态</th>
	            <th width="10%">佣金</th>
	            <th width="5%">操作</th>
	            <#--<td width="8%">支付状态</td>
	            <td width="8%">货运状态</td>
	       		<td  width="8%">打印</td>-->
	            
	          </tr>
	          </thead>
          <tbody>
           <#if orderList?has_content>
          <#assign alt_row = false>
          <#list orderList![] as orderHeader>
            <#assign orh = Static["org.ofbiz.order.order.OrderReadHelper"].getHelper(orderHeader)>
            <#assign statusItem = orderHeader.getRelatedOneCache("StatusItem")>
            <#assign orderType = orderHeader.getRelatedOneCache("OrderType")>
            <#assign orderItemShipGroups =orh.getOrderItemShipGroups()>
            <#if orderType.orderTypeId == "PURCHASE_ORDER">
              <#assign displayParty = orh.getSupplierAgent()?if_exists>
            <#else>
              <#assign displayParty = orh.getPlacingParty()?if_exists>
            </#if>
            <#assign partyId = displayParty.partyId?default("_NA_")>
            <tr valign="middle"<#if alt_row> class="alternate-row"</#if>>
             

              <td>
              <input type="checkbox" name="orderIndexs"  value="${orderHeader.orderId}" />
              <a href="<@ofbizUrl>OrderDetail?orderId=${orderHeader.orderId}</@ofbizUrl>" target='_blank'>${orderHeader.orderId}</a></td>
              <td >${orderHeader.getString("orderDate")} </td>
              <td ><#assign userId =Static["org.ofbiz.ebiz.order.OrderServices"].getOrderUserLoginIdFromParty(delegator, orderHeader.orderId,'PLACING_CUSTOMER')>
              ${userId!} </td>
              <!-- <td>${orderHeader.getString("orderDate")} </td>-->
              <td >
               <#list orderItemShipGroups as shipGroup>
        			<#assign postalAddress = shipGroup.getRelatedOne("PostalAddress", false)?if_exists>
                			<#assign AddressGeoAllCn =Static["org.ofbiz.system.ContactMechTools"].
                           			 getAddressGeoAllCn(delegator,postalAddress.stateProvinceGeoId,postalAddress.cityGeoId,postalAddress.countyGeoId)>
                			${AddressGeoAllCn}-${(postalAddress.address1)?if_exists}-${(postalAddress.attnName)?if_exists}
               </#list>		
              </td>
              <td ><@ofbizCurrency amount=orderHeader.grandTotal isoCode=orh.getCurrency()/></td>
              
              <td ><#assign payType =Static["org.ofbiz.ebiz.order.OrderServices"].getOrderPayTypeCn(delegator, orderHeader.orderId)>
              ${payType!}</td>
              
              
              <td>${statusItem.get("description",locale)?default(statusItem.statusId?default("N/A"))}</td>
              </td>
              <td>0</td>
               <td>
              	 <#if orderHeader.statusId??>
	              	 <#if orderHeader.statusId=='ORDER_CREATED'><!--待付款-->
	              	 	<#assign payTypeId =Static["org.ofbiz.ebiz.order.OrderServices"].getOrderPayType(delegator, orderHeader.orderId)>
	              	 	<#if payTypeId=='EXT_COD'>
	              	 		<a class="red" href="<@ofbizUrl>changeOrderStatus</@ofbizUrl>?orderId=${orderHeader.orderId}&statusId=ORDER_APPROVED&setItemStatus=Y">确认</a>
	              	 	<#else>
	              	 		
	              	 	</#if>
	              	 <#elseif orderHeader.statusId=='ORDER_PROCESSING'><!--待确认-->
	              	 	<#if orderHeader.applyForRefund?? && !orderHeader.ifRefuse??>
                        	<a class="red" href="<@ofbizUrl>orderRemark?orderId=${orderHeader.orderId}&operName=refuseRefund</@ofbizUrl>">驳回申请</i></a>
                        	<a class="red" href="<@ofbizUrl>FindOrderEn?orderId=${orderHeader.orderId}&statusId2=ORDER_CANCELLED&statusId=${orderHeader.statusId}</@ofbizUrl>">通过申请</i></a>
                        <#else>
                            <a class="red" href="<@ofbizUrl>FindOrderEn?orderId=${orderHeader.orderId}&statusId2=ORDER_APPROVED&statusId=${orderHeader.statusId}</@ofbizUrl>">确认</i></a>
                        </#if>
	              	 <#elseif orderHeader.statusId=='ORDER_APPROVED'><!--待发货-->
	              	 	<#if orderHeader.applyForRefund?? && !orderHeader.ifRefuse??>
                        	<a class="red" href="<@ofbizUrl>orderRemark?orderId=${orderHeader.orderId}&operName=refuseRefund</@ofbizUrl>">驳回申请</i></a>
                        	<a class="red" href="<@ofbizUrl>FindOrderEn?orderId=${orderHeader.orderId}&statusId2=ORDER_CANCELLED&statusId=${orderHeader.statusId}</@ofbizUrl>">通过申请</i></a>
                        <#else>
                            <a class="red" href="javascript:submitpayment('${orderHeader.orderId}','${productStoreId!}');">发货</a>
                        </#if>
	              	 <#elseif orderHeader.statusId=='ORDER_SENT'><!--已发货-->
	              	 	<#if orderHeader.applyForRefund?? && !orderHeader.ifRefuse??>
                        	<a class="red" href="<@ofbizUrl>orderRemark?orderId=${orderHeader.orderId}&operName=refuseRefund</@ofbizUrl>">驳回申请</i></a>
                        	<a class="red" href="<@ofbizUrl>FindOrderEn?orderId=${orderHeader.orderId}&statusId2=ORDER_CANCELLED&statusId=${orderHeader.statusId}</@ofbizUrl>">通过申请</i></a>
                        </#if>
	              	 <#elseif orderHeader.statusId=='ORDER_COMPLETED'><!--已收货-->
	              	 	
              	 	</#if>
              	 </#if>
              </td>
              <#--
			  <td>
			  <#if orderHeader.paymentStatus?has_content>
			  <#if orderHeader.paymentStatus == "1">未支付
			  <#elseif orderHeader.paymentStatus == "2">部分支付
			  <#elseif orderHeader.paymentStatus == "3" || orderHeader.paymentStatus == "5">已支付
			  <#elseif orderHeader.paymentStatus == "4">已退款
			  </#if>
			  </#if>
			  </td>
			  <td><#assign shipmentStatus =Static["org.ofbiz.ebiz.order.OrderServices"].getOrderShipmentStateCn(delegator, orderHeader.orderId)>
			  ${shipmentStatus!}
			  </td>
			  -->
             <#-- <td><a href="<@ofbizUrl>printShipment?orderId=${orderHeader.orderId}</@ofbizUrl>" target="_blank"  >快递单</a></td>-->
            </tr>
            <#-- toggle the row color -->
            <#assign alt_row = !alt_row>
          </#list>
        <#else>
          
        </#if>
        </tbody>
        </table>
</div>
</div>
<input value="hehe" type="button" style="display:none" onclick="dakai()" id="submitpayment"/>
<link rel="stylesheet" href="/portal/seller/images/product/easydialog.css" type="text/css"/>
<script type="text/javascript" src="/portal/seller/images/product/easydialog.js"></script>
<script type="text/javascript" src="/portal/seller/images/product/easydialog.min.js"></script>
<style type="text/css">
.easyDialog_wrapper{width:500px;}
.easyDialog_wrapper .easyDialog_title{margin:0;}
.easyDialog_wrapper .easyDialog_text{padding-left:50px;}

</style>
<div id="imgBox" style="display:none">
	<div class="easyDialog_footer" style="padding-left:100px; padding-bottom:10px;">
	<a href="javascript:sendOrder();" class="btn_highlight" style="float:left; margin-left:20px; height:30px; line-height:30px; padding:0 20px;text-decoration:none;">提交</a>
	<a href="javascript:location.reload();" class="btn_normal" style="float:left; height:30px; line-height:30px; padding:0 20px;text-decoration:none;">取消</a>
	</div>
</div>
<script>
function dakai(){
	easyDialog.open({
		container : {
			header : '${uiLabelMap.Pleaseorder}',
			content : $('#imgBox').html()
		}
	});
	$("#closeBtn").attr("href","javascript:location.reload()");
};
	function submitpayment(oderID,partyId){
		jQuery.ajax({
	            type: "get",//使用get方法访问后台
	            url: "ajaxSendOrder?orderId="+oderID+"&partyId="+partyId+"&backUrl=/manage/control/mng_ShowOrder",//要访问的后台地址
	            data:{},//要发送的数据
	            success: function (msg) {//msg为返回的数据，在这里做数据绑定
	                $('#imgBox').html(msg+$('#imgBox').html());
	                document.getElementById('submitpayment').click();
	                //document.getElementsByName("form")[0].submit();
	            }
	      });
	}
	function sendOrder(){
			
			var trackingNumber = $("input[id='trackingNumber']")[1].value;
			
			var contactMecheId = $("select[id='contactMecheId']")[1].value;
			
			var orderId = $("#orderId").val();
			if(!trackingNumber){
				alert("快递单号不能为空！");
				return;
			}
			if(!orderId){
				alert("订单信息丢失！");
				return;
			}
			if(!contactMecheId){
				alert("请选择发货地址！");
				return;
			}
			jQuery.ajax({
				url:'doSendOrder',
				type:'POST',
				data:{trackingNumber:trackingNumber,contactMecheId:contactMecheId,orderId:orderId},
				success:function(r){
					if(r._ERROR_MESSAGE_){
						alert(r._ERROR_MESSAGE_);
					}else{
						alert('发货成功');
						location.reload();
					}
				}
			});
		}
</script>