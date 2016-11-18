<#if parameters.orderId??>
	<#assign ShipGroups = delegator.findByAnd("OrderItemShipGroup", {"orderId": parameters.orderId})?if_exists />
	<#if ShipGroups?? && ShipGroups?size &gt; 0>
		<#assign carrierPartyGroup = delegator.findOne("PartyGroup",false,{"partyId":ShipGroups[0].carrierPartyId!''})?if_exists/>
		<#if carrierPartyGroup??>
			快递名称：${(carrierPartyGroup.groupName)!}<br/>
		</#if>
	</#if>
	<#if contactMeches??>
		发货地址：<select id="contactMecheId">
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
		</select><br/>
	</#if>
	<input type="hidden" id="orderId" value="${parameters.orderId!}"/>
	单号：<input type="text" id="trackingNumber"/><br/>
	<input type="button" onclick="sendOrder();" value="提交"/>
	<input type="button" onclick="location.href='${parameters.backUrl!}'" value="取消"/>
	<script>
		function sendOrder(){
			var trackingNumber = $("#trackingNumber").val();
			var contactMecheId = $("#contactMecheId").val();
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
			$.ajax({
				url:'doSendOrder',
				type:'POST',
				data:{trackingNumber:trackingNumber,contactMecheId:contactMecheId,orderId:orderId},
				success:function(r){
					if(r._ERROR_MESSAGE_){
						alert(r._ERROR_MESSAGE_);
					}else{
						location.href="${StringUtil.wrapString(parameters.backUrl!'#')}";
					}
				}
			});
		}
	</script>
<#elseif parameters.backUrl??>
	<script>
		$(function(){
			location.href='${StringUtil.wrapString(parameters.backUrl!'#')}';
		});
	</script>
</#if>