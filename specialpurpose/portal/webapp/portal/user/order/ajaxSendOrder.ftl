<#if parameters.orderId??>
	<#assign ShipGroups = delegator.findByAnd("OrderItemShipGroup", {"orderId": parameters.orderId})?if_exists />
	<#if ShipGroups?? && ShipGroups?size &gt; 0>
		<#assign carrierPartyGroup = delegator.findOne("PartyGroup",false,{"partyId":ShipGroups[0].carrierPartyId!''})?if_exists/>
		<#if carrierPartyGroup??>
			<p style="padding-top:10px; padding-left:55px;">快递名称：${(carrierPartyGroup.groupName)!}</p>
		</#if>
	</#if>
	<#if contactMeches??>
		<p style="padding-top:10px; padding-left:55px;">发货地址：<select id="contactMecheId" style="width:163px;">
			<option value="">===请选择===</option>
			<#list contactMeches as contactMechMap>
				<#assign contactMeche = contactMechMap.contactMech>
				<#assign hasShipOrigPurpose=false>
				<#if contactMechMap.facilityContactMechPurposes?has_content>
	                <#list contactMechMap.facilityContactMechPurposes as partyContactMechPurpose>
	                    <#assign contactMechPurposeType = partyContactMechPurpose.getRelatedOne("ContactMechPurposeType", true)>
	                    <#if "SHIP_ORIG_LOCATION" == contactMechPurposeType.get("contactMechPurposeTypeId")>
	                    	<#assign hasShipOrigPurpose=true>
	                    </#if>
	                </#list>
                </#if>
                <#if "POSTAL_ADDRESS" == contactMeche.contactMechTypeId && hasShipOrigPurpose==true>
					<option value="${contactMeche.contactMechId}">${contactMechMap.postalAddress.address1!}</option>
				</#if>
			</#list>
		</select></p>
	</#if>
	<input type="hidden" id="orderId" value="${parameters.orderId!}"/>
	<p style="padding-top:10px; padding-left:55px;">单　　号：<input type="text" id="trackingNumber"/></p>
	</div>
<#elseif parameters.backUrl??>
	<script>
		$(function(){
			location.href='${StringUtil.wrapString(parameters.backUrl!'#')}';
		});
	</script>
</#if>