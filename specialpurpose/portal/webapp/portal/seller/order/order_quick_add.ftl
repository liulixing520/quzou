<script language='javascript'>
function checkName(){
	var name = document.getElementById("userName1").value;
	if(name){
		jQuery.getJSON("checkUserLoginReg",{userName:name},function(data){
		jQuery("#userNameError").html("");
		if(null!=data&&data.msg!=undefined){
			document.getElementById("userNameError").innerHTML=data.msg;
		}
	});
	}else{
		jQuery("#userNameError").html("用户名不能为空!");
	}
} 
</script>
<#--
快速添加订单：最早送货时间、最晚送货时间、 批量选择商品、（是否显示促销）、物流、购买用户选择、选择收货地址、发票抬头。
支付方式：站内余额支付金额大于等于订单应付金额时，支付方式为余额支付，若小于订单应付金额时，必须选择一种支付方式。

-->

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
<@htmlTemplate.navTitle titleProperty/>
<div class="pageContent" id="pageContent">
	<div class="screenlet-body" id="screenlet-body">
		<form name="order_form" id="order_form" method="post" action='checkout' class="order_form">
		
		<input type="hidden" name="may_split" value="FindOrder"/><!-- “送有现货的”? -->
		<input type="hidden" name="is_gift" value="false"/><!-- 是否礼品 -->
		<input type="hidden" name="checkoutpage" value="quick"/><!-- 快速下单 -->
		<input type="hidden" name="navTabId" value="FindOrder"/>
		<input type="hidden" name="finAcount" id="finAcount"   value=""/>
		<input type="hidden" name="callbackType" value="closeCurrent"/>
		<input type="hidden" name="type" value="add"/>
		<input type="hidden" name="partyId" value=""/>
		<input type="hidden" id="userId" name="userId" value=""/>
		<input type="hidden"  name="payTotal"  id="payTotal">
		<input type="hidden" id="isBuyProduct" name="isBuyProduct"/>
		<input type="hidden" id="errorMessage"/>
		<input type="hidden" value="SALES_ORDER" name="orderMode"  id="orderMode">
		<input type="hidden" value="10000" name="productStoreId"  id="productStoreId">
		<!--<input type="hidden"  name="checkOutPaymentId"  id="checkOutPaymentIdFinAcount">-->
		<input type="hidden"  name="USER_FIRST_NAME"  id="USER_FIRST_NAME">
		<input type="hidden"  name="CONFIRM_PASSWORD"  id="CONFIRM_PASSWORD">
  	<div class="content_temp">
    <!--选择用户 start-->
    <table  class="basic-table" cellspacing="0">
      <tr class="title02">
        <td height="30" colspan="5"  style=" border-left:none"><b>选择用户</b></td>
      </tr>
      <tr>
        	<!--
        	<td width="80" class="label">商品店铺：</td>
        	<td width="130" class="border11" >
        	<select  id="productStoreId" name="productStoreId">
            
                <#list productStores as productStore>
                  <option value="${productStore.productStoreId}">${productStore.storeName?if_exists}</option>
                </#list>
              </select>
              </td>
              -->
              
         <td width="80" class="label">销售渠道：</td>
         <td width="130" class="border11" >
        	<select id="salesChannelEnumId" name="salesChannelEnumId">
				<#assign currentChannel = shoppingCartChannelType>
                <option value="">${uiLabelMap.OrderNoChannel}</option>
                <#list salesChannels as salesChannel>
                  <option value="${salesChannel.enumId}" <#if (salesChannel.enumId == currentChannel)>selected="selected"</#if>>${salesChannel.get("description",locale)}</option>
                </#list>
              </select></td>   
              <td></td> <td></td>  
      </tr>  
      <tr>
        <td width="80" class="label">输入用户名：</td>
        <td width="130" >
        	<@htmlTemplate.lookupField value="${parameters.userLogin.userLoginId}" formName="order_form" name="userLoginId" id="userLoginId_sales" fieldFormName="LookupPartyAndUserLoginAndPerson"/>
        </td>
        </tr>
    </table>
    <!--选择用户 end-->
    <!--商品信息 start-->
     <div id="carttab">
    <table id='proListTb' class="border04 overall_03" width="100%" border="0" cellspacing="0" cellpadding="0" >
      <tr class="title02">
        <td colspan="7">商品信息</td>
        <td colspan="1" width="72px">
          <a class="button"  close="closeProdialog" width="580" height="380"  param="{}"
           href="<@ofbizUrl>LookupBulkAddProducts?partyId=document.getElementById('userName').value</@ofbizUrl>" target="dialog" mask="true" title="添加商品"><span>添加商品</span></a>
        </td>
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
     
    </table>
    </div>
     <!--商品信息 end--> 
    <!--用户信息 end-->
    	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="basic-table">
    <tr class="title02">
      <td height="30" colspan="4"  style=" border-left:none"><b>用户信息</b></td>
    </tr>
    <tr>
      <td class="border03 width15">Email：</td>
      <td class="border02 width35"><input name="CUSTOMER_EMAIL" type="text" class="input200" id="email" /><span id="emailError" style="color:red"></span></td>
      <td class="border10 width15">&nbsp;</td>
      <td class="border02 width35">&nbsp;</td>
    </tr>
        <tr class="background_tr">
          <td class="border03 width15">选择收货地址：</td>
          <td class="border02 width35">
          <div id="addrIdDiv"/>
          
    	  &nbsp;
          </td>
          <td class="border10 width15">&nbsp;</td>
          <td class="border02 width35">&nbsp;</td>
        </tr>
  			<tr >
  			  <td class="label">收货人：</td>
  			  <td ><input name="receiveAddr.receiver" id="receiver"  value="<#if receiveAddr??>${receiveAddr.receiver!}</#if>" type="text" class="input200" id="textfield" /><span id="receiverError" style="color:red"/></td>
  			  <td class="border10">收货地区：</td>
  			  <td >
  			  <select id='CUSTOMER_STATE' name="CUSTOMER_STATE"  onchange="getArea(this,'ajaxArea','CUSTOMER_CITY','CUSTOMER_COUNTY');" >
				<option value="">选择省市</option>
				<#assign stateAssocs = Static["org.ofbiz.iteamgr.party.ContactMechTools"].getAssociatedStateList(delegator,'CHN')>
					<#list stateAssocs as stateAssoc>
					    <option value='${stateAssoc.geoId}'>${stateAssoc.geoName?default(stateAssoc.geoId)}</option>
					</#list>
				</select>
				<select name="CUSTOMER_CITY" id="CUSTOMER_CITY"  onchange="getArea(this,'ajaxArea','CUSTOMER_COUNTY','null');">
					<option value="">选择城市</option>
				</select>
				<select  name="CUSTOMER_COUNTY" id="CUSTOMER_COUNTY">
					<option value="">选择区县</option>
				</select>
  			 <span id="provinceError" ></span></td>
		  </tr>
  			<tr class="background_tr">
  			  <td class="label">收货地址：</td>
  			  <td ><span id="addressSpan"></span><input name="CUSTOMER_ADDRESS1"  maxlength='80' id="address" value="<#if receiveAddr??>${receiveAddr.address!}</#if>" type="text" class="input200" id="textfield" /><span id="addressError" style="color:red"></span></td>
  			  <td class="border10">邮编：</td>
  			  <td ><input name="CUSTOMER_POSTAL_CODE" maxlength='6' id="postCode"  onkeypress="justNum(event)" onkeyup="clear_chinese(this)" value="<#if receiveAddr??>${receiveAddr.postCode!}</#if>" type="text" class="input200" id="textfield" /><span id="postCodeError" style="color:red"></span></td>
		  </tr>
  			 <tr  >
  			  <td class="label">手机：</td>
  			  <td ><input name="CUSTOMER_MOBILE_CONTACT" maxlength='11'  onkeypress="justNum(event)" onkeyup="clear_chinese(this)" id="mobile" value="<#if receiveAddr??>${receiveAddr.mobile!}</#if>" type="text" class="input200" id="textfield" /><span id="mobileError" style="color:red"></span></td>
  			  <td class="border10">固定电话：</td>
  			  <td >
  			  <input name="CUSTOMER_HOME_AREA"  maxlength='16' size="8" onkeypress="justNum(event)"  onkeyup="clear_chinese(this)" id="phoneA" value="<#if receiveAddr??>${receiveAddr.phone!}</#if>" type="text" class="input200"/>
  			  <input name="CUSTOMER_HOME_CONTACT"  maxlength='16' size="16" onkeypress="justNum(event)"  onkeyup="clear_chinese(this)" id="phone" value="<#if receiveAddr??>${receiveAddr.phone!}</#if>" type="text" class="input200"/><span id="phoneError" style="color:red"></span></td>
		  </tr>
    </table>
    <!--用户信息 end-->
    
    <!--支付信息 start-->
    <!--
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="basic-table">
      <tr class="title02" id="grouptd">
        <td height="30" colspan="1"  style=" border-left:none"><b>支付信息</b></td>
        <td>选择支付方式:
        <select name="checkOutPaymentId" id="checkOutPaymentId">
        <option value="">请选择</option>
        </select>
         	金额/卡号 <input type="text"  name="productNumber" id="" value="" /> </td>
        <td><input type="button" name="button" id="button" value="添加" onclick="add_tr();" /></td>
        <td><td>
      </tr>
    </table>
    -->
    <!--支付信息 end-->
    
    <!--配送信息 start-->
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03">
      <tr class="title02">
        <td height="30" colspan="5"  style=" border-left:none"><b>配送信息</b></td>
      </tr>
      <tr>
        <td width="38" class="label">&nbsp;</td>
        <td class="border11" colspan="2"><span style="margin-right:10px">选择配送方式</span><span id='sendTypeDiv'> 
        <select class="required"  name="shipping_method" id="shipMethod" onchange='changeShipMethod(this)' style="width:70px">
        <option value="NO_SHIPPING@_NA_">请选择</option>
        <option value="NO_SHIPPING@_NA_">不配送</option>
       <!--added by dongyc 21020909-->
       <#list carrierShipmentMethodList as carrierShipmentMethod>
        <#assign shippingMethod = carrierShipmentMethod.shipmentMethodTypeId + "@" + carrierShipmentMethod.partyId>
        <#if shoppingCart.getShippingContactMechId()?exists>
            <#assign shippingEst = shippingEstWpr.getShippingEstimate(carrierShipmentMethod)?default(-1)>
        </#if>
        <#if carrierShipmentMethod.partyId != "_NA_">
	          <option value='${shippingMethod?if_exists}'>
	          <#if shoppingCart.getShippingContactMechId()?exists>
		        <#assign shippingEst = shippingEstWpr.getShippingEstimate(carrierShipmentMethod)?default(-1)>
		      </#if>
		      <#if carrierShipmentMethod.partyId != "_NA_">${carrierShipmentMethod.partyId?if_exists}&nbsp;</#if>${carrierShipmentMethod.description?if_exists}
		      <#if shippingEst?has_content> - <#if (shippingEst > -1)><@ofbizCurrency amount=shippingEst isoCode=shoppingCart.getCurrency()/><#else>${uiLabelMap.OrderCalculatedOffline}</#if></#if></option>
          </#if>
        </#list>
        <!--added by dongyc 21020909-->
        </select>
        </span></td>
        </tr>
      <tr>
        <td width="38" class="label">&nbsp;</td>
        <td class="border11" colspan="2"><span style="margin-right:10px">选择配送时间</span>
	        <select name="shipDateEnumId" id="shippmentDateType" style="width:70px">
	       	<option value="">请选择</option>
	       	<#if orderShipDateList??>
	        	<#list  orderShipDateList as shipDate>
	        		<option value='${shipDate.enumId}'>${shipDate.description} </option>
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
      </table>
    </div>
    
    <input type="hidden" name="orderAttributeNames" value="shipDateEnumId,noteInfo,invoiceTitle,invoiceItemType"/>
    <!--其他信息 start-->
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03">
    <tr class="title02">
          <td height="30" colspan="4" style=" border-left:none"><b>其他信息</b></td>
      </tr>
        <tr>
  			  <td class="border03 width15">发票抬头：</td>
		      <td class="border02 width35"><input name="invoiceTitle" type="text" class="input200" id="textfield" /></td>
  			  <td class="border10 width15">发票内容：</td>
  			  <td class="border02 width35">
  			  <select name="invoiceItemType" style="width:70px">
                <option value="">请选择</option>
                <#list  orderInvoiceContentList as orderInvoiceContent>
        			<option value='${orderInvoiceContent.enumId}'>${orderInvoiceContent.description} </option>
        		</#list>
                
        </select></td>
	      </tr>
  			<tr class="background_tr">
  			  <td class="label">客户留言：</td>
  			  <td ><input name="noteInfo" type="text" class="input200" id="textfield2" /></td>
  			  <td class="border10">选择仓库：</td>
  			  <td >
  			  <#assign productStoreFacilityList=Static["org.ofbiz.iteamgr.inventory.InventoryWorker"].getStoreFacility(request)?if_exists>
  			  <select name="${shipGroupIndex?default("0")}_shipGroupFacilityId" style="width:70px">
                        <option value=""></option>
                        <#list productStoreFacilityList  as facility>
                          <option value="${facility.facilityId}">${facility.facilityName?if_exists} </option>
                        </#list>
                      </select>
          </td>
		  </tr>
    </table>
    <!--其他信息 end-->
    <!--购物必填信息  start-->
    <div id="shoppingInfoDiv">
    <#if shopping_info??&&shopping> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03">
      <tr class="title02">
        <td height="30" colspan="2"  style=" border-left:none"><b>购物必填信息</b></td>
      </tr>
      ${shopping_info!}
    </table>
    </#if>
    </div>
    <!--购物必填信息  end--> 
    
    <div id="accountDiv"></div>
    <div id="integralsDiv"></div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03">
        <tr class="title02a">
        <input type="hidden"  name="checkOutPaymentId"  id="checkOutPaymentId" value="CASH">
          <td width="440" >&nbsp;使&nbsp;用&nbsp;现&nbsp;金&nbsp;&nbsp;&nbsp;&nbsp;：<input name="amount_CASH" type="text" class="input80 currency" id="amount" maxlength="9"/><span style="font-weight:normal"></span></td>
          <td></td>
        </tr>
      </table>
     <table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03">
        <tr class="title02a">
          <td width="440" >使用会员卡&nbsp;&nbsp;&nbsp;&nbsp;：<input name="checkOutPaymentId_STORE_USER_CARD" type="text" class="input80" id="checkOutPaymentId_STORE_USER_CARD" maxlength="20"/>
         	 密码：<input type="password" id="finAcountCardPassword" maxlength="20"></td>
          <td>
          余额：<span id="availableBalance" style="font-weight:normal"></span><input name="input6"  id="useIntegralsBtn" onclick="getFinAccountAvailableBlance()" type="button" value="查看会员卡余额" /><span id="mc_fc_av_Blance" style="color:red"/>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03">
        <tr class="title02a">
        <input type="hidden"  name="checkOutPaymentId_STORE_USER_ACCT"  id="checkOutPaymentId_STORE_USER_ACCT" value="">
        <input type="hidden" id="finAcountBalanceAmount" value="">
          <td width="440" >使用账户余额：<input name="amount_STORE_USER_ACCT" id="amount_STORE_USER_ACCT"  class="input80 currency" type="text"  value='' maxlength="9"/>（您的余额：<span id='finAcountBalanceSpan'></span>  元）</td>
          <td >
          </td>
        </tr>
      </table>
  	</div>
  </div>
  </div>
</form>

<@htmlTemplate.submitButton formId="order_form"  dialogId="${parameters.dialogId!}" submitJs="${submitJs!}" oper="${parameters.oper!}" backHref="${parameters.backHref!}"/>
		
<div class="formBar" >
		<ul>
		<li>
		<div class="button"><div class="buttonContent"><button id="quickOrderAddButton" class="button" onclick="javascript:ajaxSubmitOrderForms('order_form');" type="button">${uiLabelMap.CommonSave}</button></div></div>
		<div class="button"><div class="buttonContent"><button class="close" type="button">${uiLabelMap.CommonClose}</button></div></div></li>
		</ul>
	</div>  
</div>




</#if>