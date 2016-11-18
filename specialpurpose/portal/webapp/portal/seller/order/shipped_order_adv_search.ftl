

<div class="pageContent">
	
   <form action="FindShippedOrder" name='FindShippedOrderdiv'  id='FindShippedOrderdiv' method="post"  class="single_table" >
   <div class="pageFormContent" layoutH="97">
   <table cellspacing="0" class="basic-table">
   <tr class='background_tr'>
    <td class='border03' >订单号 </td>
    <td class='border02'><input type="text" name="orderId"  size="30"     maxlength="255"  />
    </td>
    </tr>
    <tr class='background_tr'>
    <td class='border03' >下单人 </td>
    <td class='border02'><input type="text" name="userLoginId"  size="30"     maxlength="255"  />
    </td>
    </tr>
    
    <tr class='background_tr'>
    <td class='border03' >支付方式 </td>
    <td class='border02'>
    <select name='paymentMethodTypeId' id='paymentMethodTypeId'><option value=''>请选择</option><option value='CASH'>现金支付</option><option value='FINACT_USERACCT'>站内余额</option><option value='FINACT_USERCARD'>会员卡支付</option></select>
    </td>
    </tr>
    <tr class='background_tr'>
    <td class='border03' >支付状态 </td>
    <td class='border02'>
	<select name='oppStatusId' id='oppStatusId'><option value=''>请选择</option><option value='3'>已支付</option><option value='2'>部分支付</option><option value='1'>未支付</option><option value='4'>已退款</option></select>
    </td>
    </tr>
    <tr class='background_tr'>
    <td class='border03' >店铺</td>
    <td class='border02'>
		<select  id="productStoreId" name="productStoreId">
	        <#list productStores as productStore>
	          	<option value="${productStore.productStoreId}">${productStore.storeName?if_exists}</option>
	        </#list>
        </select>
    </td>
    </tr>
    <tr class='background_tr'>
	<input name='orderStatusId' type='hidden' value='ORDER_COMPLETED'>
	<input type='hidden' name='shipmentStatusId' value='SHIPMENT_SHIPPED'/>
    <tr class='background_tr'>
    <td class='border03' >发货仓库</td>
    <td class='border02'>
	<select name='estimatedShipFacilityId' id='estimatedShipFacilityId'><option value=''>请选择</option>
	 <#list facilityList as facility>
	 	<option value='${facility.facilityId!}'>${facility.facilityName!}</option>
	 </#list>
	
	</select>
    </td>
    </tr>
    
   <tr >
  			  <td >地区：</td><td >
  			  <select id='CUSTOMER_STATE' name="stateGeoId"  onchange="getArea(this,'ajaxArea','CUSTOMER_CITY0','CUSTOMER_COUNTY0');" >
				<#--<#if contactMeches.postalAddress??&&contactMeches.postalAddress.stateGeoId??>
					<option value='${contactMeches.postalAddress.stateGeoId}'>${contactMeches.postalAddress.stateGeoName}</option>
				</#if>-->
				<option value="">选择省市--</option>
				<#assign stateAssocs = Static["org.ofbiz.iteamgr.party.ContactMechTools"].getAssociatedStateList(delegator,'CHN')>
					<#list stateAssocs as stateAssoc>
					    <option value='${stateAssoc.geoId}' <#if contactMeches??&&contactMeches.postalAddress??&&contactMeches.postalAddress.stateGeoId?? && contactMeches.postalAddress.stateGeoId==stateAssoc.geoId>selected</#if>>${stateAssoc.geoName?default(stateAssoc.geoId)}</option>
					</#list>
				</select>
				<select name="cityGeoId" id="CUSTOMER_CITY0"  onchange="getArea(this,'ajaxArea','CUSTOMER_COUNTY0','null');">
					<option value="">选择城市</option>
					<#if contactMeches??&& contactMeches.postalAddress??&&contactMeches.postalAddress.cityGeoId??>
					<option value='${contactMeches.postalAddress.cityGeoId}' selected>${contactMeches.postalAddress.cityGeoName}</option>
				    </#if>
				</select>
				<select name="countyGeoId" id="CUSTOMER_COUNTY0">
					<option value="">选择区县</option>
					<#if contactMeches??&&contactMeches.postalAddress??&&contactMeches.postalAddress.countyGeoId??>
						<option value='${contactMeches.postalAddress.countyGeoId}' selected>${contactMeches.postalAddress.countyGeoName}</option>
					</#if>
				</select>
  			  </td>
		  </tr>
    </table>
  		
	</div>
<div class="formBar">
<ul>
				<li><a  href="#" onclick="javascript:submitForm('FindShippedOrderdiv');" class="button"><span>${uiLabelMap.CommonFind}</span></a></li>
				<li><div class="button"><div class="buttonContent"><button type="reset">清空重输</button></div></div></li>
			</ul>
</div>    
    </form>	
</div>


