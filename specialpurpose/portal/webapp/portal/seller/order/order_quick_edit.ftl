<#--
订单编辑-参考ofbiz订单编辑，部分更新数据，如增加一个商品后直接触发到后台并插入了数据库，修改收货地址同样处理
发票抬头、发票内容、客户 留言等信息在触发【保存】按钮后入库
修改支付方式和修改仓库在ofbiz中不支持。只能选择更新收货地址，如要调整收货地址详细信息，需要去会员中心-收货地址中修改
-->

<form name="appendItemForm" id="appendItemForm" action="<@ofbizUrl>appendItemToOrder</@ofbizUrl>" method="post">
 	<input type="hidden" value="${orderId?if_exists}" name="orderId" >
	<input type="hidden" value="00001" name="shipGroupSeqId">
	<input type="hidden" value="" name="productId" id='productId'>
	<input type="hidden" value="" name="quantity" id="quantity">
	<input type="hidden" value="" name="basePrice">
	
</form>	
<#macro updateOrderContactMech orderHeader contactMechTypeId contactMechList contactMechPurposeTypeId contactMechAddress>
  <#if (!orderHeader.statusId.equals("ORDER_COMPLETED")) && !(orderHeader.statusId.equals("ORDER_REJECTED")) && !(orderHeader.statusId.equals("ORDER_CANCELLED"))>
    <form name="updateOrderContactMech" id='${contactMechTypeId}_updateOrderContactMech' method="post" action="<@ofbizUrl>updateOrderContactMech</@ofbizUrl>">
      <input type="hidden" name="orderId" value="${orderId?if_exists}" />
      <input type="hidden" name="contactMechPurposeTypeId" value="${contactMechPurpose.contactMechPurposeTypeId?if_exists}" />
      <input type="hidden" name="oldContactMechId" value="${contactMech.contactMechId?if_exists}" />
      <select name="contactMechId" onchange="changeAddr('${contactMechTypeId}_updateOrderContactMech');">
        <#if contactMech.contactMechTypeId == "POSTAL_ADDRESS">
          <option value="${contactMechAddress.contactMechId}">${(contactMechAddress.address1)?default("")} - ${contactMechAddress.city?default("")}</option>
          <option value="${contactMechAddress.contactMechId}"></option>
          <#list contactMechList as contactMech>
            <#assign postalAddress = contactMech.getRelatedOne("PostalAddress")?if_exists />
            <#assign partyContactPurposes = postalAddress.getRelated("PartyContactMechPurpose")?if_exists />
            <#list partyContactPurposes as partyContactPurpose>
              <#if contactMech.contactMechId?has_content && partyContactPurpose.contactMechPurposeTypeId == contactMechPurposeTypeId>
                <option value="${contactMech.contactMechId?if_exists}">${(postalAddress.address1)?default("")} - ${postalAddress.city?default("")}</option>
              </#if>
            </#list>
          </#list>
        <#elseif contactMech.contactMechTypeId == "TELECOM_NUMBER">
          <option value="${contactMechAddress.contactMechId}">${contactMechAddress.countryCode?if_exists} <#if contactMechAddress.areaCode?exists>${contactMechAddress.areaCode}-</#if>${contactMechAddress.contactNumber}</option>
          <option value="${contactMechAddress.contactMechId}"></option>
          <#list contactMechList as contactMech>
             <#assign telecomNumber = contactMech.getRelatedOne("TelecomNumber")?if_exists />
             <#assign partyContactPurposes = telecomNumber.getRelated("PartyContactMechPurpose")?if_exists />
             <#list partyContactPurposes as partyContactPurpose>
               <#if contactMech.contactMechId?has_content && partyContactPurpose.contactMechPurposeTypeId == contactMechPurposeTypeId>
                  <option value="${contactMech.contactMechId?if_exists}">${telecomNumber.countryCode?if_exists} <#if telecomNumber.areaCode?exists>${telecomNumber.areaCode}-</#if>${telecomNumber.contactNumber}</option>
               </#if>
             </#list>
          </#list>
        <#elseif contactMech.contactMechTypeId == "EMAIL_ADDRESS">
          <option value="${contactMechAddress.contactMechId}">${(contactMechAddress.infoString)?default("")}</option>
          <option value="${contactMechAddress.contactMechId}"></option>
          <#list contactMechList as contactMech>
             <#assign partyContactPurposes = contactMech.getRelated("PartyContactMechPurpose")?if_exists />
             <#list partyContactPurposes as partyContactPurpose>
               <#if contactMech.contactMechId?has_content && partyContactPurpose.contactMechPurposeTypeId == contactMechPurposeTypeId>
                  <option value="${contactMech.contactMechId?if_exists}">${contactMech.infoString?if_exists}</option>
               </#if>
             </#list>
          </#list>
        </#if>
      </select>
    </form>
  </#if>
</#macro>


<#assign shoppingCartOrderType = "">
<#assign shoppingCartProductStore = "NA">
<#assign shoppingCartChannelType = "">
<#if shoppingCart?exists>
  <#assign shoppingCartOrderType = shoppingCart.getOrderType()>
  <#assign shoppingCartProductStore = shoppingCart.getProductStoreId()?default("NA")>
  <#assign shoppingCartChannelType = shoppingCart.getChannelType()?default("")>
<#else>
<#-- allow the order type to be set in parameter, so only the appropriate section (Sales or Purchase Order) shows up -->
  <#if parameters.orderTypeId?has_content>
    <#assign shoppingCartOrderType = parameters.orderTypeId>
  </#if>
</#if>
<!-- Sales Order Entry -->
<#if security.hasEntityPermission("ORDERMGR", "_CREATE", session)>
<div id="all_main" class='pageContent'>
<form name="order_form" id="order_form" method="post" action='checkout' class="order_form">

<input type="hidden" name="may_split" value="FindOrder"/><!-- “送有现货的”? -->
<input type="hidden" name="is_gift" value="false"/><!-- 是否礼品 -->
<input type="hidden" name="checkoutpage" value="quick"/><!-- 快速下单 -->
<input type="hidden" name="navTabId" value="FindOrder"/>
<input type="hidden" name="finAcount" id="finAcount"   value=""/>
<input type="hidden" name="callbackType" value="closeCurrent"/>
<input type="hidden" name="type" value="add"/>
<input type="hidden" name="partyId" value="${placingPartyRole.partyId!}"/>
<input type="hidden" id="userId" name="userId" value="<#if customerInfo??&&customerInfo.userId??>${customerInfo.userId}</#if>"/>
<input type="hidden" id="isBuyProduct" name="isBuyProduct"/>
<input type="hidden" id="errorMessage"/>
<input type="hidden" value="SALES_ORDER" name="orderMode"  id="orderMode">
<input type="hidden" value="9000" name="productStoreId"  id="productStoreId">
<input type="hidden"  name="checkOutPaymentId"  id="checkOutPaymentIdFinAcount">
<input type="hidden"  name="USER_FIRST_NAME"  id="USER_FIRST_NAME">
<input type="hidden"  name="CONFIRM_PASSWORD"  id="CONFIRM_PASSWORD">
<input type="hidden"  name="salesChannelEnumId"  value='${shoppingCartChannelType}'>
</form>
  <!--功能区域-->
   <!--功能区域-->
  <div id="head_main" class='head_main'>
   <div class="main_nav"><span>订单详情<strong style="margin:0 10px">${orderHeader.orderId}</strong>下单时间:${orderHeader.orderDate.toString()}</span>
    </div>
</div>
  <div layouth="79" class="pageFormContent" style="height: 158px; overflow: auto;">

  <div id="cont02">
  	<div class="content_temp">
   
    <!--用户信息 end-->
    	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="basic-table">
    <tr class="title02">
      <td height="30" colspan="4"  style=" border-left:none"><b>用户信息</b></td>
    </tr>
    <tr>
      <td class="border03 width15">Email：</td>
      <#list orderContactMechValueMaps as orderContactMechValueMap>
          <#assign contactMech = orderContactMechValueMap.contactMech>
          <#assign contactMechPurpose = orderContactMechValueMap.contactMechPurposeType>
          <#if contactMech.contactMechTypeId == "EMAIL_ADDRESS">
          <#assign email=contactMech.infoString>
          </#if>
       </#list>
      <td class="border02 width35"><input name="CUSTOMER_EMAIL" type="text" value='${email!}' readonly class="input200" id="email" /><span id="emailError" style="color:red"></span></td>
      <td class="border10 width15">&nbsp;</td>
      <td class="border02 width35">&nbsp;</td>
    </tr>
        <tr class="background_tr">
          <td class="border03 width15">其他地址：</td>
          <td class="border02 width35">
          <div id="addrIdDiv"/>

          <#list orderContactMechValueMaps as orderContactMechValueMap>
          <#assign contactMech = orderContactMechValueMap.contactMech>
          <#assign contactMechPurpose = orderContactMechValueMap.contactMechPurposeType>
          <#if contactMech.contactMechTypeId == "POSTAL_ADDRESS">
           <#assign postalAddress = orderContactMechValueMap.postalAddress>
            <@updateOrderContactMech orderHeader=orderHeader?if_exists contactMechTypeId=contactMech.contactMechTypeId contactMechList=postalContactMechList?if_exists contactMechPurposeTypeId=contactMechPurpose.contactMechPurposeTypeId?if_exists contactMechAddress=postalAddress?if_exists />
          </#if>
          </#list>
    	  &nbsp;
          </td>
          <td class="border10 width15">&nbsp;</td>
          <td class="border02 width35">&nbsp;</td>
        </tr>
  			<tr >
  			  <td class="label">收货人：</td>
  			  <td ><input name="receiveAddr.receiver" id="receiver" readonly value="<#if postalAddress?has_content>${postalAddress.toName!}</#if>" type="text" class="input200" id="textfield" /><span id="receiverError" style="color:red"/></td>
  			  <td class="border10">收货地区：</td>
  			  <td >
  			  <#if postalAddress?has_content>
  			  <#assign AddressGeoAllCn =Static["org.ofbiz.iteamgr.party.ContactMechTools"].
  			  getAddressGeoAllCn(delegator,postalAddress.stateProvinceGeoId,postalAddress.cityGeoId,postalAddress.countyGeoId)>
  			  ${AddressGeoAllCn!}
  			  </#if>
  			 <span id="provinceError" style="color:red"></span></td>
		  </tr>
  			<tr class="background_tr">
  			  <td class="label">收货地址：</td>
  			  <td ><span id="addressSpan"></span><input name="CUSTOMER_ADDRESS1" readonly maxlength='80' id="address" value="<#if postalAddress?has_content>${postalAddress.address1!}</#if>" type="text" class="input200" id="textfield" /><span id="addressError" style="color:red"></span></td>
  			  <td class="border10">邮编：</td>
  			  <td ><input name="CUSTOMER_POSTAL_CODE" maxlength='6' readonly  id="postCode" onkeypress="justNum(event)" onkeyup="clear_chinese(this)" value="<#if postalAddress?has_content>${postalAddress.postalCode!}</#if>" type="text" class="input200" id="textfield" /><span id="postCodeError" style="color:red"></span></td>
		  </tr>
  			 <tr  >  
  			  <td class="label">手机：</td>
  			  <td ><input name="CUSTOMER_MOBILE_CONTACT" maxlength='11' readonly onkeypress="justNum(event)" onkeyup="clear_chinese(this)" id="mobile" value="<#if postalAddress?has_content>${postalAddress.mobileExd!}</#if>" type="text" class="input200" id="textfield" /><span id="mobileError" style="color:red"></span></td>
  			  <td class="border10">固定电话：</td>
  			  <td >
  			  <input name="CUSTOMER_HOME_AREA"  maxlength='16' readonly onkeypress="justNum(event)" onkeyup="clear_chinese(this)" id="phone" value="<#if postalAddress?has_content>${postalAddress.phoneExd!}</#if>" type="text" class="input200" id="textfield" />
  			  <input name="CUSTOMER_HOME_CONTACT"  maxlength='16' readonly onkeypress="justNum(event)" onkeyup="clear_chinese(this)" id="phone" value="<#if postalAddress?has_content>${postalAddress.phoneAreaExd!}</#if>" type="text" class="input200" id="textfield" /><span id="phoneError" style="color:red"></span></td>
		  </tr>
          
		  
    </table>
    <!--用户信息 end-->
     <!--商品信息 start-->
     <div id="carttab">
    <table id='proListTb' class="border04 overall_03" width="100%" border="0" cellspacing="0" cellpadding="0" >
      <tr class="title02">
        <td colspan="6">商品信息</td>
        <td colspan="2" align="right"><label>
          <a class="button"  close="closeProdialog" width="580" height="380"  param="{}"
           href="<@ofbizUrl>LookupBulkEditProducts?partyId=document.getElementById('userName').value</@ofbizUrl>" target="dialog" mask="true" title="添加商品"><span>添加商品</span></a>
        </label></td>
        </tr>
      <tr class="background_tr">
        <td class="border06 width5">序号</td>
        <td class="border07 width15">商品编号</td>
        <td class="border07 width22">商品名称</td>
        <td class="border07 width10">单价</td>
        <td class="border07 width5">数量</td>
     	<td class="border07 width5">调整</td>
        <td class="border07 width7">小计</td>
        <td class="border07 width7">操作</td>
      </tr>
     <#list orderItemList as orderItem>
                      <tr>
                          <#assign orderItemType = orderItem.getRelatedOne("OrderItemType")?if_exists>
                          <#assign productId = orderItem.productId?if_exists>
                          <#assign product = orderItem.getRelatedOneCache("Product")>
                              <td class="border06">
                                  	${index!}
                              </td>
                              <td class="border06">
                                  	${productId!}
                              </td>
								<td class="border06">
                                  	${product.productName!}
                              </td>
                          		<td class="border06">
                                  	<input type="text" size="5" name="ipm_${orderItem.orderItemSeqId}" value="<@ofbizAmount amount=orderItem.unitPrice/>"/>
                                      
                              </td>
                              <td class="border06">
                              	<img width='9' height='9' onclick=\"decreaseProductNum('${orderItem.productId}')\" src='/images/decrease.gif' style='cursor: pointer;'>&nbsp;
                                  	<input type="text" size="5" name="ipm_${orderItem.orderItemSeqId}" value="${orderItem.quantity?string.number}"/>
                                &nbsp;<img width='9' height='9' onclick="appendItemToOrder('${orderItem.productId}','${orderItem.quantity?string.number}');" src='/images/adding.gif' style='cursor: pointer;'> 
                              </td>
                              <td class="border06">
                               <@ofbizCurrency amount=Static["org.ofbiz.order.order.OrderReadHelper"].getOrderItemAdjustmentsTotal(orderItem, orderAdjustments, true, false, false) isoCode=currencyUomId/>
                              </td>
                              
                              <td class="border06">
                              <#if orderItem.statusId != "ITEM_CANCELLED">
                                  <@ofbizCurrency amount=Static["org.ofbiz.order.order.OrderReadHelper"].getOrderItemSubTotal(orderItem, orderAdjustments) isoCode=currencyUomId/>
                                  <#else>
                                  <@ofbizCurrency amount=0.00 isoCode=currencyUomId/>
                                  </#if>
                                   </td>
                             <td class="border06">
                              		删除
                                   </td>      
                     </tr>              
                </#list>
    </table>
    </div>
     <!--商品信息 end--> 
    
    
    <!--配送信息 start-->
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03">
      <tr class="title02">
        <td height="30" colspan="5"  style=" border-left:none"><b>配送信息</b></td>
      </tr>
      <tr>
        <td width="38" class="label">&nbsp;</td>
        <td width="73" class="border11">选择配送方式</td>
        <td class="border11" colspan="1">
        <form name="updateOrderItemShipGroup" id="updateOrderItemShipGroup" method="post" action="<@ofbizUrl>updateOrderItemShipGroup</@ofbizUrl>">
        <input type="hidden" name="orderId" value="${orderId?if_exists}"/>
        <input type="hidden" name="shipGroupSeqId" value="<#if shipGroup??>${shipGroup.shipGroupSeqId?if_exists}<#else>00001</#if>"/>
        <input type="hidden" name="contactMechPurposeTypeId" value="SHIPPING_LOCATION"/>
        <input type="hidden" name="oldContactMechId" value="<#if shipGroup??>${shipGroup.contactMechId?if_exists}</#if>"/>
        <#if orderHeader?has_content && orderHeader.statusId != "ORDER_CANCELLED" && orderHeader.statusId != "ORDER_COMPLETED" && orderHeader.statusId != "ORDER_REJECTED">
                            <#-- passing the shipmentMethod value as the combination of three fields value
                            i.e shipmentMethodTypeId & carrierPartyId & roleTypeId. Values are separated by
                            "@" symbol.
                            -->
                            <select name="shipmentMethod" onchange="javascript:changeShipMethod();">
                                <#if shipGroup.shipmentMethodTypeId?has_content>
                                <option value="${shipGroup.shipmentMethodTypeId}@${shipGroup.carrierPartyId!}@${shipGroup.carrierRoleTypeId!}"><#if shipGroup.carrierPartyId != "_NA_">${shipGroup.carrierPartyId!}</#if>&nbsp;${shipmentMethodType.get("description",locale)!}</option>
                                <#else>
                                <option value=""/>
                                </#if>
                                <#list productStoreShipmentMethList as productStoreShipmentMethod>
                                <#assign shipmentMethodTypeAndParty = productStoreShipmentMethod.shipmentMethodTypeId + "@" + productStoreShipmentMethod.partyId + "@" + productStoreShipmentMethod.roleTypeId>
                                <#if productStoreShipmentMethod.partyId?has_content || productStoreShipmentMethod?has_content>
                                <option value="${shipmentMethodTypeAndParty?if_exists}"><#if productStoreShipmentMethod.partyId != "_NA_">${productStoreShipmentMethod.partyId?if_exists}</#if>&nbsp;${productStoreShipmentMethod.get("description",locale)?default("")}</option>
                                </#if>
                                </#list>
                            </select>
                            <#else>
                            <#if shipGroup.carrierPartyId != "_NA_">
                            ${shipGroup.carrierPartyId?if_exists}
                            </#if>
                            ${shipmentMethodType?if_exists.get("description",locale)?default("")}
                            </#if>
         </form>
        </span></td>
        </tr>
        
        
      <tr>
        <td width="38" class="label">&nbsp;</td>
        <td class="border11" colspan="2">选择配送时间</span>
	        <select name="shipDateEnumId" id="shipDateEnumId">
	        <option value="">请选择</option>
	       	<#if orderShipDateList??>
	        	<#list  orderShipDateList as shipDate>
	        		<option value='${shipDate.enumId}' <#if shipDate.enumId==shipDateEnumId>selected</#if>>${shipDate.description} </option>
	        	</#list>
        	</#if>	
        	</select>
        </td>
        </tr>
    </table>
    <!--配送信息 end-->
    <!-- 订单总金额 -->
    <div id='totalDiv'>
    	<table width='100%' border='0' cellspacing='0' cellpadding='0' class='border04 overall_03'>
      <tr class='title02'>
        <td height='30' colspan='5'  style=' border-left:none'><b>订单总额</b></td>
      </tr>
      <tr>
  			<td align="right" colspan="6"><div>商品总额:<@ofbizCurrency amount=orderSubTotal isoCode=currencyUomId/><br>
  			运费:<@ofbizCurrency amount=shippingAmount isoCode=currencyUomId/><br>
  			
  			
		    <#list orderHeaderAdjustments as orderHeaderAdjustment>
                    <#assign adjustmentType = orderHeaderAdjustment.getRelatedOne("OrderAdjustmentType")>
                    <#assign adjustmentAmount = Static["org.ofbiz.order.order.OrderReadHelper"].calcOrderAdjustment(orderHeaderAdjustment, orderSubTotal)>
                    <#if adjustmentAmount != 0>
                       
                                <#if orderHeaderAdjustment.comments?has_content>${orderHeaderAdjustment.comments} - </#if>
                                <#if orderHeaderAdjustment.description?has_content>${orderHeaderAdjustment.description} - </#if>
                                <br><span class="label">${adjustmentType.get("description", locale)}</span>
                                <@ofbizCurrency amount=adjustmentAmount isoCode=currencyUomId/>
                    </#if>
                </#list>
                	<br>订单总金额:<@ofbizCurrency amount=grandTotal isoCode=currencyUomId/>
                            </td>
                 </tr>	
      </table>
    </div>
    
    <!--支付信息 start    ofbiz中已经选择的支付方式是不能修改的  只能添加其他支付 暂先隐藏-->
    <span id="paymentTypeSpan"  style='display:none' > 
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="basic-table">
      <tr class="title02">
        <td height="30" colspan="2"  style=" border-left:none"><b>支付信息</b></td>
        <td>选择支付方式:
        <select name="checkOutPaymentId" id="checkOutPaymentId">
        <#if productStorePaymentSettingList??>
        	<#list  productStorePaymentSettingList as paymentMethod>
        		<option value='${paymentMethod.paymentMethodTypeId}'>${paymentMethod.paymentMethodTypeId} </option>
        	</#list>
        </#if>	
        </select></td>
      </tr>
    </table>
    </span>
    <!--支付信息 end-->
    <!--其他信息 start-->
    <!-- 订单其他项信息 -->
        <form name="updateOrderOther" id='updateOrderOther' method="post" action="<@ofbizUrl>updateOrderOther</@ofbizUrl>">
        <#if orderNotes?has_content><#assign orderNoteGv = orderNotes.get(0)>
        <#assign orderNote =orderNoteGv.noteInfo?replace("\n", "<br/>")>
        <#assign noteId =orderNoteGv.noteId>
        </#if>
  			  
		<input type='hidden' id='noteId' name='noteId'  value='${noteId!}'>
		<input type='hidden' id='orderId' name='orderId'  value='${orderId?if_exists}'>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03">
    <tr class="title02">
          <td height="30" colspan="4" style=" border-left:none"><b>其他信息</b></td>
      </tr>
        <tr>
  			  <td class="border03 width15">发票抬头：</td>
		    <td class="border02 width35"><input name="invoiceTitle" type="text" class="input200" value='${invoiceTitle}' id="textfield" /></td>
  			  <td class="border10 width15">发票内容：</td>
  			  <td class="border02 width35">
  			  <select name="invoiceText">
                <option value="">请选择</option>
                <#list  orderInvoiceContentList as orderInvoiceContent>
                	
        			<option value='${orderInvoiceContent.enumId}' <#if orderInvoiceContent.enumId==invoiceTextId>selected</#if> >${orderInvoiceContent.description} </option>
        		</#list>
                
        </select></td>
	      </tr>
  			<tr class="background_tr">
  			  <td class="label">客户留言：</td>
  			  <td ><input name="noteString" type="text" value='${orderNote!}'
  			  class="input200" id="textfield2" /></td>
  			  <!--  ofbiz直接不能修改仓库
  			  <td class="border10">选择仓库</td>
  			  <td ><#assign productStoreFacilityList=Static["org.ofbiz.iteamgr.inventory.InventoryWorker"].getStoreFacility(request)>
  			  <select name="${shipGroupIndex?default("0")}_shipGroupFacilityId" style="width:70px">
                        <option value=""></option>
                        <#list productStoreFacilityList  as facility>
                          <option value="${facility.facilityId}">${facility.facilityName?if_exists} </option>
                        </#list>
                      </select></td>
              -->
		  </tr>
    </table>
    </form>
    <!--其他信息 end-->
    
   
     <!--支付金额  start
     <table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03">
    		<tr class="title02">
    			<td colspan="6">支付金额 </td>
		    </tr>
  			<tr class="background_tr">
    			<td class="border06 width17">订单总金额</td>
    			<td class="border07 width15">-个人账户支付</td>
  			  <td class="border07 width15">-在线支付</td>
  			  <td class="border07 width15">-财务已收</td>
  			  <td class="border07 width15">-积分抵用</td>
  			  <td class="border07 width18">=应收金额</td>
		    </tr>
  			<tr>
  			  <td class="border06"><span id="money">0</span>&nbsp;</td>
  			  <td class="border07"><span id="virtualMoney">0</span></td>
  			  <td class="border07">0</td>
  			  <td class="border07">0</td>
  			  <td class="border07"><span id="integralMoney">0</span></td>
			  <td class="border07"><span id="money1">0</span>&nbsp;</td>
		  </tr>
  			
		</table>
             支付金额  end-->
     <!--积分  start
     <table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03">
    		<tr class="title02">
    			<td colspan="6">积分 </td>
		    </tr>
  			<tr class="background_tr">
    			<td class="border06 width25">原账户积分</td>
    			<td class="border07 width25">-使用积分</td>
  			  <td class="border07 width25">+赠送积分</td>
  			  <td class="border07 width25">=现账户积分</td>
		    </tr>
  			<tr>
  			  <td class="border06"><span id="accountIntegral"><#if userAccount??>${userAccount.integral!}<#else>0</#if></span></td>
  			  <td class="border07"><span id="useIntegral">0</span>&nbsp;</td>
  			  <td class="border07"><span id="sendIntegral">0</span>&nbsp;</td>
  			  <td class="border07"><span id="integral">0</span>&nbsp;</td>
		  </tr>
  			
		</table>
           积分  end-->
  	</div>
  </div>
  </div>
<div class="formBar" >
		<ul>
		<li><a class="button" href="#" onclick="javascript:ajaxSubmitOrderForms('updateOrderOther');"  ><span>
		${uiLabelMap.CommonSave}</span></a>
		
		<div class="button"><div class="buttonContent"><button class="close" type="button">${uiLabelMap.CommonClose}</button></div></div></li>
		</ul>
	</div>  
</div>




</#if>