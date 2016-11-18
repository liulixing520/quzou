<#assign orderStatu=orderHeader.statusId>
<#--assign payStatu =Static["org.ofbiz.ebiz.order.OrderServices"].getOrderPayStatus(delegator, orderHeader.orderId)-->
<#assign payStatu = orderHeader.paymentStatus?if_exists>
<#assign isContainsSaleReward = "N">
<#if orderHeader.isContainsSaleReward?has_content>
    <#assign isContainsSaleReward = orderHeader.isContainsSaleReward?if_exists>
</#if>
<#assign shipmentStatu =Static["org.ofbiz.ebiz.order.OrderServices"].getOrderShipmentState(delegator, orderHeader.orderId)>
 <div class="content profile">
  <h2 class="title">订单信息</h2>
            <div class="profile_detail clearfix">
            <span>
	                订单编号<strong style="margin:0 10px">${orderHeader.orderId}</strong>
	                下单时间:${orderHeader.orderDate.toString()}
	            </span>
	        </div>
        <div class="main_soso">
            <table cellspacing="0" cellpadding="0" border="0" >
                <tbody>
                <tr>
                    <td width="100" align="right">快速处理订单：</td>
                    <td align="left">
                    <#if orderStatu=='ORDER_CREATED'>
                        <#if payStatu=="1"||payStatu=="2"|| (payStatu=="4" && isContainsSaleReward=="N")>
                            <a class="button" close="closeProdialog" width="480"
                               href="<@ofbizUrl>toPaymentOrder</@ofbizUrl>?orderId=${orderHeader.orderId}&statusId=ORDER_APPROVED"
                               target="dialog" mask="true" title="订单处理"><span>支付</span></a>
                        </#if>
                        <a class="button" close="closeProdialog" width="480"
                           href="<@ofbizUrl>toChangeOrderStatus</@ofbizUrl>?orderId=${orderHeader.orderId}&statusId=ORDER_CANCELLED&setItemStatus=Y"
                           target="dialog" mask="true" title="订单处理"><span>无效</span></a>
                    </#if>
                    <#if orderStatu=='ORDER_PROCESSING'>
                        <a class="button" close="closeProdialog" width="480"
                           href="<@ofbizUrl>toChangeOrderStatus</@ofbizUrl>?orderId=${orderHeader.orderId}&statusId=ORDER_APPROVED"
                           target="dialog" mask="true" title="订单处理"><span>确认</span></a>
                    </#if>
                    <#if orderStatu=='ORDER_APPROVED'>
                        <a class="button" close="closeProdialog" width="480"
                           href="<@ofbizUrl>toChangeOrderStatus</@ofbizUrl>?orderId=${orderHeader.orderId}&statusId=ORDER_CANCELLED&setItemStatus=Y"
                           target="dialog" mask="true" title="订单处理"><span>无效</span></a>
                        <#if orderHeader.salesChannelEnumId!="POS_SALES_CHANNEL">
                            <#if payStatu=="1"||payStatu=="2"||(payStatu=="4" && isContainsSaleReward=="N")>
                                <a class="button" close="closeProdialog" width="480"
                                   href="<@ofbizUrl>toPaymentOrder</@ofbizUrl>?orderId=${orderHeader.orderId}&statusId=ORDER_APPROVED"
                                   target="dialog" mask="true" title="订单处理"><span>支付</span></a>
                            </#if>
                            <#if payStatu=="3">
                                <a class="button" close="closeProdialog" width="880"
                                   href="<@ofbizUrl>toBackPaymentOrder</@ofbizUrl>?orderId=${orderHeader.orderId}&statusId=ORDER_CANCELLED&setItemStatus=Y"
                                   target="dialog" mask="true" title="退款"><span>退款</span></a>
                                <a class="button" width="480"
                                   onclick="operEditDialog('<@ofbizUrl>toQuickShipOrder</@ofbizUrl>?orderId=${orderHeader.orderId}')"
                                   href="#" title="订单处理"><span>打包货运公司</span></a>
                            </#if>
                            <#if payStatu=="5">
                                <a class="button" close="closeProdialog" width="480"
                                   href="<@ofbizUrl>toQuickShipOrder</@ofbizUrl>?orderId=${orderHeader.orderId}"
                                   target="dialog" mask="true" title="订单处理"><span>打包货运公司</span></a>
                            </#if>
                        <#elseif orderHeader.salesChannelEnumId=="POS_SALES_CHANNEL">
                            <a class="button" close="closeProdialog" width="480"
                               href="<@ofbizUrl>toQuickShipPosOrder</@ofbizUrl>?orderId=${orderHeader.orderId}"
                               target="dialog" mask="true" title="订单处理"><span>完成</span></a>
                        </#if>
                    </#if>
                    <#if orderStatu=='ORDER_CANCELLED'>
                        <#if orderHeader.salesChannelEnumId!="POS_SALES_CHANNEL">
                            <#if payStatu=="3"||payStatu=="2">
                                <a class="button" close="closeProdialog" width="880"
                                   href="<@ofbizUrl>toBackPaymentOrder</@ofbizUrl>?orderId=${orderHeader.orderId}&statusId=ORDER_CANCELLED&setItemStatus=Y"
                                   target="dialog" mask="true" title="退款"><span>退款</span></a>
                            </#if>
                        </#if>
                    </#if>
                    <#if orderHeader.salesChannelEnumId!="POS_SALES_CHANNEL">
                        <!--ORDER_COMPLETED||to||SHIPMENT_PACKED-->
                        <#assign shipments = delegator.findByAnd("Shipment", {"primaryOrderId" : orderHeader.orderId})>
                        <#if orderStatu == "ORDER_COMPLETED"&&shipmentStatu=='SHIPMENT_SHIPPED'>
                            <#if shipments?has_content>
                                <#assign shipment = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(shipments) />
                                <a class="button" close="closeProdialog" width="480"
                                   href="<@ofbizUrl>toShippedOrder</@ofbizUrl>?orderId=${orderHeader.orderId}&statusId=SHIPMENT_DELIVERED&shipmentId=${shipment.shipmentId?if_exists}"
                                   target="dialog" mask="true" title="客户确认收货"><span>客户确认收货</span></a>
                                <a class="button" close="closeProdialog" width="480"
                                   href="<@ofbizUrl>toShippedOrder</@ofbizUrl>?orderId=${orderHeader.orderId}&statusId=SHIPMENT_CANCELLED&shipmentId=${shipment.shipmentId?if_exists}"
                                   target="dialog" mask="true" title="客户拒收收货"><span>客户拒收收货</span></a>
                                <a class="button" close="closeProdialog" width="880"
                                   href="<@ofbizUrl>makeReturn</@ofbizUrl>?orderId=${orderHeader.orderId}"
                                   target="dialog" mask="true" title="退货项目"><span>退换货</span></a>
                            <#else>
                                <a class="button" href="javascript:orderSend("${orderHeader.orderId}");"
                                title="发货"><span>发货</span></a>
                                <script type="text/javascript">
                                    function orderSend(orderId) {
                                        $.ajax({
                                            url: 'updateOrderHeader',
                                            type: 'POST',
                                            data: {orderId: orderId, statusId: 'ORDER_SENT'},
                                            success: function (result) {
                                                if (result._ERROR_MESSAGE_LIST_ || result._ERROR_MESSAGE_) {
                                                    alert(result._ERROR_MESSAGE_LIST_ || result._ERROR_MESSAGE_);
                                                } else {
                                                    window.location.href = window.location.href;
                                                }
                                            }
                                        });
                                    }
                                </script>
                            </#if>
                        </#if>
                        <#if orderStatu == "ORDER_COMPLETED"&&shipmentStatu=='SHIPMENT_CANCELLED'>
                            <#if shipments?has_content>
                                <#assign shipment = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(shipments) />
                                <a class="button" close="closeProdialog" width="880"
                                   href="<@ofbizUrl>makeReturn</@ofbizUrl>?orderId=${orderHeader.orderId}"
                                   target="dialog" mask="true" title="退货项目"><span>退换货</span></a>
                            </#if>
                        </#if>
                        <#if orderStatu == "ORDER_COMPLETED"&&shipmentStatu=='SHIPMENT_PACKED'>
                            <#if shipments?has_content>
                                <#assign shipment = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(shipments) />
                                <a class="button" close="closeProdialog" width="480"
                                   href="<@ofbizUrl>toShippedOrder</@ofbizUrl>?orderId=${orderHeader.orderId}&statusId=SHIPMENT_SHIPPED&shipmentId=${shipment.shipmentId?if_exists}"
                                   target="dialog" mask="true" title="货运发货"><span>货运发货</span></a>
                            </#if>
                        </#if>
                        <#if orderStatu == "ORDER_COMPLETED"&&shipmentStatu=='SHIPMENT_DELIVERED'>
                            <a class="button" close="closeProdialog" width="880"
                               href="<@ofbizUrl>makeReturn</@ofbizUrl>?orderId=${orderHeader.orderId}" target="dialog"
                               mask="true" title="退货项目"><span>退换货</span></a>
                        </#if>
                    <#elseif orderHeader.salesChannelEnumId=="POS_SALES_CHANNEL">
                        <#if orderStatu == "ORDER_COMPLETED">
                            <a class="button" close="closeProdialog" width="880"
                               href="<@ofbizUrl>makeReturn</@ofbizUrl>?orderId=${orderHeader.orderId}" target="dialog"
                               mask="true" title="退货项目"><span>退换货</span></a>
                        </#if>
                    </#if>
                    <#--
                    <input type="button" onclick="window.open('<@ofbizUrl>printOrderItem</@ofbizUrl>?orderId=${orderHeader.orderId}','打印购物清单','status=yes,toolbar=yes,menubar=yes,location=yes,fullscreen=yes,scrollbars=yes')" value="打印购物清单" class="btn btn-info" name="input">
                    <input type="button" onclick="window.open('<@ofbizUrl>printOrderShip</@ofbizUrl>?orderId=${orderHeader.orderId}','打印配货单','status=yes,toolbar=yes,menubar=yes,location=yes,fullscreen=yes,scrollbars=yes')" value="打印配货单" class="btn btn-info" name="input">
                    <input type="button" onclick="window.open('<@ofbizUrl>printOrderAll</@ofbizUrl>?orderId=${orderHeader.orderId}','打印订单','status=yes,toolbar=yes,menubar=yes,location=yes,fullscreen=yes,scrollbars=yes')" value="打印订单" class="btn btn-info" name="input5">
                    -->
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!--主要内容-->
    <div id="list" layouth="15" class="pageFormContent">
        <div id="cont02" style="">
            <div class="content_temp">
                <div class="screenlet screenlet-title-bar">
                    <ul>
                        <li class="h3">订单基本信息</li>
                    </ul>
                    <br class="clear">
                </div>
                <!--订单基本信息 start-->
                <#-- 
                <table cellspacing="0" cellpadding="0" border="0"  class="table-bordered">
                    <tbody>
                    <tr>
                        <td class="label">订单状态：</td>
                        <td class="border02 width35"><#if currentStatus??>${currentStatus.get("description",locale)}</#if></td>
                        <td class="label">支付状态：</td>
                        <td>
                        <#if orderHeader.paymentStatus?has_content>
                            <#if orderHeader.paymentStatus == "1">未支付
                            <#elseif orderHeader.paymentStatus == "2">部分支付
                            <#elseif orderHeader.paymentStatus == "3" || orderHeader.paymentStatus == "5">已支付
                            <#elseif orderHeader.paymentStatus == "4">已退款
                            </#if>
                        </#if>
                        </td>
                    </tr>
                    <tr class="background_tr">
                        <td class="label">支付方式：</td>
                        <td>
                        <#assign payType =Static["org.ofbiz.ebiz.order.OrderServices"].getOrderPayTypeCn(delegator, orderHeader.orderId)>${payType!}
                        </td>
                        <td class="label">配送时间：</td>
                        <td>${shippmentDateType!}
                        </td>
                    </tr>
                    <tr>
                        <td class="label">配送方式：</td>
                    <#if shipGroups?has_content>
                        <#list shipGroups as shipGroup>
                            <#assign shipmentMethodType = shipGroup.getRelatedOne("ShipmentMethodType")?if_exists>
                        </#list>
                    </#if>
                        <td>${shipmentMethodType.description!}
                            &nbsp;<#if shipGroups?has_content><#list shipGroups as shipGroup>${shipGroup.trackingNumber!}</#list></#if>
                        </td>

                        <td class="label">下单方式：</td>
                        <td><#if orderHeader.salesChannelEnumId?has_content>
                    <#assign channel = orderHeader.getRelatedOne("SalesChannelEnumeration")>
                    ${(channel.get("description",locale))?default("N/A")}
                  <#else>
                        ${uiLabelMap.CommonNA}
                        </#if>
                        </td>

                    </tr>
                    <tr>
                        <td class="label">店铺：</td>
                    <#assign productStore = orderHeader.getRelatedOneCache("ProductStore")>

                        <td>
                        <#if productStore?has_content>
				  ${productStore.storeName!}
			  </#if>
                        </td>
                        <td></td>
                        <td></td>

                    </tr>

                    </tbody>
                </table>
                -->
                <table cellspacing="0" cellpadding="0" border="0" width="100%" class="table-bordered">
                	<tbody>
                		<tr class="background_tr">
                			<td>订单状态：</td>
                			<td>支付状态：</td>
                			<td>支付方式：</td>
                			<td>配送时间：</td>
                			<td>配送方式：</td>
                			<td>下单方式：</td>
                			<td>店铺：</td>
                		</tr>
                		<tr>
                			<td><#if currentStatus??>${currentStatus.get("description",locale)}</#if></td>
                			
                	<#assign orh = Static["org.ofbiz.order.order.OrderReadHelper"].getHelper(orderHeader)>
                	<#assign orderItemShipGroups =orh.getOrderItemShipGroups()>
                	<#if orh.getPaymentPreferences()?has_content>
                        <#list orh.getPaymentPreferences() as orderPaymentPreference>
                        	<#assign paymentMethodType = orderPaymentPreference.getRelatedOne("PaymentMethodType")>
                        	<#assign oppStatusItem = orderPaymentPreference.getRelatedOne("StatusItem")>
                        	<td>
                        	<#if oppStatusItem?exists>${oppStatusItem.get("description",locale)}<#else>${orderPaymentPreference.statusId}</#if>
                        	</td>
                        	<td class="border07 width20">${paymentMethodType.get("description",locale)?if_exists}<#if orderPaymentPreference.finAccountCode?has_content>
                                &nbsp;${orderPaymentPreference.finAccountCode?if_exists}</#if></td>
                        </#list>
                    </#if>
                        <#-- 
                        <#if orderHeader.paymentStatus?has_content>
                            <#if orderHeader.paymentStatus == "1">未支付
                            <#elseif orderHeader.paymentStatus == "2">部分支付
                            <#elseif orderHeader.paymentStatus == "3" || orderHeader.paymentStatus == "5">已支付
                            <#elseif orderHeader.paymentStatus == "4">已退款
                            </#if>
                        </#if>
                        -->
                        	
                        	<#-- 
                        	<#if shipGroups?has_content>
                        	<#list shipGroups as shipGroup>
                            	<#assign shipmentMethodType = shipGroup.getRelatedOne("ShipmentMethodType")?if_exists>
                        	</#list>
                    		</#if>
                        	<td>${shipmentMethodType.description!}ee
                            	&nbsp;<#if shipGroups?has_content><#list shipGroups as shipGroup>${shipGroup.trackingNumber!}</#list></#if>
                        	</td>
                        	-->
                        	<#-- 
                        	<td>PayEase</td>
                        	-->
                        	<td>${shippmentDateType!}</td>
                        	<#if shipGroups?has_content>
                        		<#list shipGroups as shipGroup>
                            		<#assign shipmentMethodType = shipGroup.getRelatedOne("ShipmentMethodType")?if_exists>
                        		</#list>
                    		</#if>
                        	<td>${shipmentMethodType.description!}
                            	&nbsp;<#if shipGroups?has_content><#list shipGroups as shipGroup>${shipGroup.trackingNumber!}</#list></#if>
                        	</td>
                        	<td><#if orderHeader.salesChannelEnumId?has_content>
                    			<#assign channel = orderHeader.getRelatedOne("SalesChannelEnumeration")>
                    			${(channel.get("description",locale))?default("N/A")}
                  				<#else>
                        		${uiLabelMap.CommonNA}
                        		</#if>
                        	</td>
                        	<#assign productStore = orderHeader.getRelatedOneCache("ProductStore")>
                        	<td>
                        		<#if productStore?has_content>${productStore.storeName!}</#if>
                        	</td>
                		</tr>
                	</tbody>
                </table>
                <!--订单基本信息 end-->
                <!--用户信息 end-->
            <#assign emailContactMech = delegator.findByAnd("OrderContactMech", {"orderId" : orderHeader.orderId, "contactMechPurposeTypeId" : "ORDER_EMAIL"})>
            <#if emailContactMech?has_content>
                <#assign email = delegator.findOne("ContactMech", {"contactMechId" : emailContactMech[0].contactMechId}, true)>
            </#if>

                <div class="screenlet screenlet-title-bar">
                    <ul>
                        <li class="h3">买家信息</li>

                    </ul>
                    <br class="clear">
                </div>
                <table cellspacing="0" cellpadding="0" border="0"  class="table-bordered">
                    <tbody>
                    <tr>
                        <td >买家ID：</td>
                        <td >
                        <#assign userId =Static["org.ofbiz.ebiz.order.OrderServices"].getOrderUserLoginIdFromParty(delegator, orderHeader.orderId,'PLACING_CUSTOMER')>
		      ${userId!}
                        </td>
                        <td >E-mail：</td>
                        <td >
                        <#if email?has_content>
  			  	${email.infoString}
  			  </#if>
                        </td>
                    </tr>
                    <tr >
                        <td >收货人：</td>
                        <td><#if postalAddress?has_content>${postalAddress.toName!}</#if></td>
                        <td >收货地区：</td>
                        <td>
                         <#list orderItemShipGroups as shipGroup>
        			<#assign postalAddress = shipGroup.getRelatedOne("PostalAddress", false)?if_exists>
                			<#assign AddressGeoAllCn =Static["org.ofbiz.system.ContactMechTools"].
                           			 getAddressGeoAllCn(delegator,postalAddress.stateProvinceGeoId,postalAddress.cityGeoId,postalAddress.countyGeoId)>
                			${AddressGeoAllCn}
               		</#list>	
                        </td>
                    </tr>
                    <tr>
                        <td >收货地址：</td>
                        <td><#if postalAddress?has_content>${postalAddress.address1!}</#if></td>
                        <td>邮编：</td>
                        <td><#if postalAddress?has_content>${postalAddress.postalCode!}</#if></td>
                    </tr>
                    <tr >
                        <td >手机：</td>
                        <td><#if postalAddress?has_content>${postalAddress.mobileExd!}</#if></td>
                        <td >固定电话：</td>
                        <td><#if postalAddress?has_content>${postalAddress.phoneAreaExd!}</#if>
                            -<#if postalAddress?has_content>${postalAddress.phoneExd!}</#if></td>
                    </tr>
                    </tbody>
                </table>
               
                <!--用户信息 end-->
                <!--其他信息 start-->
                <div class="screenlet screenlet-title-bar">
                    <ul>
                        <li class="h3">其他信息</li>

                    </ul>
                    <br class="clear">
                </div>
				<#-- 
                <table cellspacing="0" cellpadding="0" border="0"  class="basic-table">
                    <tbody>
                    <tr>
                        <td class="label">发票抬头：</td>
                        <td class="border02 width35">${invoiceTitle!}</td>
                        <td class="label">发票内容：</td>
                        <td class="border02 width35">${invoiceText!}</td>
                    </tr>
                    <tr class="background_tr">
                        <td class="label">客户留言：</td>
                        <td colspan="3">
                        ${noteInfo!}
                            &nbsp;</td>

                    </tr>
                    </tbody>
                </table>
                -->
                <table cellspacing="0" cellpadding="0" border="0"  class="table-bordered">
                	<tbody>
                		<tr class="background_tr">
                			<td>发票抬头：</td>
                			<td>发票内容：</td>
                			<td>客户留言：</td>
                		</tr>
                		<tr>
                			<td class="border02 width35">${invoiceTitle!}</td>
                			<td class="border02 width35">${invoiceText!}</td>
                			<td colspan="3">${noteInfo!}&nbsp;</td>
                		</tr>
                	</tbody>
                </table>
                
                <!--其他信息 end-->
                <!--商品信息 start-->
                <div class="screenlet screenlet-title-bar">
                    <ul>
                        <li class="h3">商品信息</li>

                    </ul>
                    <br class="clear">
                </div>
                <br/>
                <table cellspacing="0" cellpadding="0" border="0" 
                       class="table-bordered">
                    <tbody>
                    <tr class="background_tr">
                        <td class="border06 width5">图片</td>
                        <td class="border07 width18">商品编号</td>
                        <td class="border07 width22">商品名称</td>
                        <!--
                        <td class="border07 width12">规格</td>
                        -->
                        <td class="border07 width10">单价</td>
                        
                        <td class="border07 width8">数量</td>
                        <#-- 
                        <td class="border07 width10">积分</td>
                        -->
                        <td class="border07 width7">调整</td>
                        <td class="border07 width8">订单金额</td><#--小计 -->
                    </tr>
                    <!-- 非礼包信息 -->

                    <#list orderItemList as orderItem>

                        <#assign product = orderItem.getRelatedOneCache("Product")>

                        <#assign orderItemPriceInfos = orderReadHelper.getOrderItemPriceInfos(orderItem)?if_exists>
                    <tr>
                        <td class="border06"><img src="${product.smallImageUrl!}" width="100px" height="100px"/></td>
                        <td class="border07">${product.productId}</td>
                        <td>${product.productName!}</td>

                        <td class="border07">
                            <@ofbizCurrency amount=orderItem.unitPrice isoCode=currencyUomId/>
                        </td>
                        <td class="border07">${orderItem.quantity?default(0)?string.number}</td>
                        <#-- 
                        <td class="border07"><#if orderItem.isSaleReward?has_content && orderItem.isSaleReward=="Y">${orderItem.saleReward!}</#if></td>
                        -->
                        <td class="border07">
                            <#assign orderItemAdjustments = Static["org.ofbiz.order.order.OrderReadHelper"].getOrderItemAdjustmentList(orderItem, orderAdjustments)>
              <#if orderItemAdjustments?exists && orderItemAdjustments?has_content>
                            <#list orderItemAdjustments as orderItemAdjustment>
                                <@ofbizCurrency amount=Static["org.ofbiz.order.order.OrderReadHelper"].calcItemAdjustment(orderItemAdjustment, orderItem) isoCode=currencyUomId/>
                            </#list>
                        </#if>
                        </td>

                        <td class="border07">
                            <#if orderItem.statusId != "ITEM_CANCELLED">
                                <@ofbizCurrency amount=Static["org.ofbiz.order.order.OrderReadHelper"].getOrderItemSubTotal(orderItem, orderAdjustments) isoCode=currencyUomId/>
                            <#else>
                                <@ofbizCurrency amount=0.00 isoCode=currencyUomId/>
                            </#if>
                            <#if orderItem.isSaleReward?has_content && orderItem.isSaleReward=="Y">
                                + ${orderItem.saleReward*orderItem.quantity!}积分
                            </#if>
                        </td>
                    </tr>
                    </#list>
                    <!-- 礼包信息 -->
                    </tbody>
                </table>
                <!--商品信息 end-->

                <!--订单金额 start-->
                <div class="screenlet screenlet-title-bar">
                    <ul>
                        <li class="h3">订单金额</li>

                    </ul>
                    <br class="clear">
                </div>
                <table cellspacing="0" cellpadding="0" border="0"  class="basic-table">
                    <tbody>
                    <tr>
                        <td colspan='6' align='right'>
                            商品总额:<@ofbizCurrency amount=orderSubTotal isoCode=currencyUomId/><br>
                        <#--运费:<@ofbizCurrency amount=shippingAmount isoCode=currencyUomId/><br>-->
                        </td>
                    </tr>
                    <#list orderHeaderAdjustments as orderHeaderAdjustment>
                        <#assign adjustmentType = orderHeaderAdjustment.getRelatedOne("OrderAdjustmentType")?if_exists>
                        <#assign adjustmentAmount = Static["org.ofbiz.order.order.OrderReadHelper"].calcOrderAdjustment(orderHeaderAdjustment, orderSubTotal)>
                        <#if adjustmentAmount != 0>
                        <tr>
                            <td align="right" colspan="6">
                                <#if orderHeaderAdjustment.comments?has_content>${orderHeaderAdjustment.comments}
                                    - </#if>
                                <#if orderHeaderAdjustment.description?has_content>${orderHeaderAdjustment.description}
                                    - </#if>
                                <span class="label">${adjustmentType.get("description", locale)}</span>
                                <@ofbizCurrency amount=adjustmentAmount isoCode=currencyUomId/>
                            </td>

                        </tr>
                        </#if>
                    </#list>
                    <tr>
                        <td align="right" colspan="6">
                        <#--礼券使用:0<br>-->
                            订单总金额:<@ofbizCurrency amount=grandTotal isoCode=currencyUomId/>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <!--订单金额 end-->
                <div class="screenlet screenlet-title-bar">
                    <ul>
                        <li class="h3">支付信息</li>

                    </ul>
                    <br class="clear">
                </div>
            <#assign orh = Static["org.ofbiz.order.order.OrderReadHelper"].getHelper(orderHeader)>
                <table cellspacing="0" cellpadding="0" border="0"  style="margin-top:15px"
                       class="table-bordered">
                    <tbody>
                    <tr class="background_tr">
                    	
                        <td class="border06 width15">支付类型</td>
                        <td class="border07 width40">金额</td>
                        <td class="border07 width20">支付状态</td>
                        
                    </tr>
                    <#if orh.getPaymentPreferences()?has_content>
                        <#list orh.getPaymentPreferences() as orderPaymentPreference>
                            <#assign paymentMethodType = orderPaymentPreference.getRelatedOne("PaymentMethodType")>
                            <#assign oppStatusItem = orderPaymentPreference.getRelatedOne("StatusItem")>
                        <tr>
                        	 
                            <td class="border07 width20">${paymentMethodType.get("description",locale)?if_exists}<#if orderPaymentPreference.finAccountCode?has_content>
                                &nbsp;${orderPaymentPreference.finAccountCode?if_exists}</#if></td>
                                <td class="border07 width20"><@ofbizCurrency amount=orderPaymentPreference.maxAmount?default(0.00) isoCode=orh.getCurrency()/></td>
                            <td class="border07 width20"><#if oppStatusItem?exists>${oppStatusItem.get("description",locale)}<#else>${orderPaymentPreference.statusId}</#if></td>
                           
                        </tr>
                        </#list>
                    </#if>
                    </tbody>
                </table>
                </br>


                <div class="screenlet screenlet-title-bar">
                    <ul>
                        <li class="h3">订单操作记录</li>

                    </ul>
                    <br class="clear">
                </div>
                <table cellspacing="0" cellpadding="0" border="0"  style="margin-top:15px"
                       class="table-bordered">
                    <tbody>
                    <tr class="background_tr">
                        <td class="border06 width15">操作人</td>
                        <td class="border07 width20">操作时间</td>
                        <td class="border07 width25">操作记录</td>
                        <td class="border07 width40">操作备注</td>
                    </tr>
                    <#if orderHeaderStatuses?has_content>
                        <#list orderHeaderStatuses as orderHeaderStatus>
                            <#assign loopStatusItem = orderHeaderStatus.getRelatedOne("StatusItem")>
                            <#assign userlogin = orderHeaderStatus.getRelatedOne("UserLogin")>
                        <tr>
                            <td class="border07 width20">${orderHeaderStatus.statusUserLogin}</td>
                            <td class="border07 width20"> ${orderHeaderStatus.statusDatetime?default("0000-00-00 00:00:00")?string} </td>
                            <td class="border07 width20">${loopStatusItem.get("description",locale)}</td>
                            <td class="border07 width20">${orderHeaderStatus.changeReason!}</td>
                        </tr>
                        </#list>
                    </#if>
                    </tbody>
                </table>
                </br>
				<#--
                <div class="screenlet screenlet-title-bar">
                    <ul>
                        <li class="h3">货运运作记录</li>

                    </ul>
                    <br class="clear">
                </div>
                <table cellspacing="0" cellpadding="0" border="0"  style="margin-top:15px"
                       class="table-bordered">
                    <tbody>
                    <tr class="background_tr">
                        <td class="border06 width15">操作人</td>
                        <td class="border07 width20">操作时间</td>
                        <td class="border07 width25">操作记录</td>
                        <td class="border07 width40">操作备注</td>
                    </tr>
                    <#if shipmentStateHistorys?has_content>
                        <#list shipmentStateHistorys as shipmentStateHistory>
                            <#assign loopStatusItem = shipmentStateHistory.getRelatedOne("StatusItem")>

                        <tr>
                            <td class="border07 width20">${userLogin.userLoginId!}</td>
                            <td class="border07 width20"> ${shipmentStateHistory.statusDate?default("0000-00-00 00:00:00")?string} </td>
                            <td class="border07 width20">${loopStatusItem.get("description",locale)}</td>
                            <td class="border07 width20">${shipmentStateHistory.changeReason!}</td>
                        </tr>
                        </#list>
                    </#if>
                    </tbody>
                </table>
                </br>
				-->
            <#if returnStatuses??>
                <table cellspacing="0" cellpadding="0" border="0"  style="margin-top:15px"
                       class="basic-table">
                    <tbody>
                    <tr class="title02">
                        <td colspan="6">退换货记录</td>
                    </tr>
                    <tr class="background_tr">
                        <td class="border06 width15">操作人</td>
                        <td class="border07 width20">操作时间</td>
                        <td class="border07 width25">操作记录</td>
                        <td class="border07 width25">操作备注</td>
                    </tr>
                        <#list returnStatuses as returnStatus>
                            <#assign loopStatusItem = returnStatus.getRelatedOne("StatusItem")>
                        <tr>
                            <td class="border07 width20">${returnStatus.changeByUserLoginId!}</td>
                            <td class="border07 width20"> ${returnStatus.statusDatetime?default("0000-00-00 00:00:00")?string} </td>
                            <td class="border07 width20">${loopStatusItem.get("description",locale)}</td>
                            <td class="border07 width20">${returnStatus.changeReason!}</td>
                        </tr>
                        </#list>

                    </tbody>
                </table>
            </#if>
                </br></br>

            </div>
        </div>
    </div>
</div>