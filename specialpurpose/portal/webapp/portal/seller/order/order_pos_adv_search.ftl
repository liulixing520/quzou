

<div class="pageContent">
	
   <form action="searchPosorders" name='FindOrderAdv'  id='FindOrderAdv' method="post"  class="single_table" >
   <input type='hidden' name='salesChannelEnumId' value='POS_SALES_CHANNEL'/>
   <input type='hidden' name='selectChanneltype' value='POS_CHANNEL'/>
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
	<select name='oppStatusId' id='oppStatusId'><option value=''>请选择</option><option value='3'>已支付</option><option value='2'>部分支付</option><option value='1'>未支付</option></select>
    </td>
    </tr>
    <tr class='background_tr'>
    <td class='border03' >订单状态</td>
    <td class='border02'>
	<select name='orderStatusId' id='orderStatusId'>
		<option value=''>请选择</option>
		<option value='ORDER_COMPLETED'>已完成</option>
		<option value='ORDER_APPROVED'>待发货</option>
		<option value='ORDER_CREATED'>待付款</option>
	</select>
    </td>
    </tr>
    <tr class='background_tr'>
    <td class='border03' >店铺</td>
    <td class='border02'>
		<select  id="productStoreId" name="productStoreId">
	        <option value="">请选择店铺</option>
	        <#list productStores as productStore>
	        <#list productStores2 as productStore2>
	        	<#if productStore2.productStoreId?trim==productStore.productStoreId?trim>
	          	<option value="${productStore.productStoreId}">${productStore.storeName?if_exists}</option>
	          	</#if>
	        </#list>
	        </#list>
        </select>
    </td>
    </tr>
    </table>
  		
	</div>
<div class="formBar">
<ul>
				<li><a  href="#" onclick="javascript:submitForm('FindOrderAdv');" class="button"><span>${uiLabelMap.CommonFind}</span></a></li>
				<li><div class="button"><div class="buttonContent"><button type="reset">清空重输</button></div></div></li>
			</ul>
</div>    
    </form>	
</div>


