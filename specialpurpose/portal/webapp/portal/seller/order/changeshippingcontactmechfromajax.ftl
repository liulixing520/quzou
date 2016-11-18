<select  name="shipping_method" id="shipMethod" onchange='changeShipMethod(this)' style="width:70px">
    <option value="">请选择</option>
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
      <#if shippingEst?has_content> - <#if (shippingEst > -1)><@ofbizCurrency amount=shippingEst isoCode=shoppingCart.getCurrency()/><#else>${uiLabelMap.OrderCalculatedOffline}</#if></#if>
      </option>
      </#if>
    </#list>
</select>