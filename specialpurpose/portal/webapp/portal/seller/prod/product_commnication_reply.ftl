<script language='javascript'>
function deleteCommunication(communicationEventId,parentCommEventId){
try{
	jQuery.ajax({
        url: "<@ofbizUrl>deleteCommunication</@ofbizUrl>?communicationEventId="+communicationEventId+"&parentCommEventId="+parentCommEventId,
        type: 'POST',
        error: function(msg) {
           alert(msg);
        },
        success: function(msg) {
        	alert('删除成功');
			jQuery('#CommnicationDiv').html(msg);
			$('#CommnicationDiv').initUI();
        }
    });
    }catch(e){alert(e.message);}
}
</script>
<div id="CommnicationDiv">
<table width="100%" class="basic-table"  >
<#assign communicationEvent = delegator.findByPrimaryKey("CommunicationEvent", {"communicationEventId" : parentCommEventId})?if_exists>	
<#if communicationEvent?has_content>	
	<#assign communicationEventProducts = delegator.findByAnd("CommunicationEventProduct", {"communicationEventId" : parentCommEventId})?if_exists>	
	<#if communicationEvent?has_content>
		<#assign product = delegator.findByPrimaryKey("Product", {"productId" : communicationEventProducts[0].productId})?if_exists>	
		<tr class="background_tr"><td>&nbsp;&nbsp;<strong>1.&nbsp;${communicationEvent.partyIdFrom?if_exists}</strong>&nbsp;于&nbsp;${communicationEvent.entryDate?if_exists}&nbsp;对&nbsp;<strong>${product.productName?if_exists}</strong>&nbsp;发表了咨询</td><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr class="background_tr"><td>&nbsp;&nbsp;<strong>咨询内容：</strong><br/></td><td>&nbsp;</td></tr>
		<tr class="background_tr"><td>&nbsp;&nbsp;${communicationEvent.content?if_exists}</td><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	</#if>
</#if>
<#if communicationEvents?has_content>
	<#list communicationEvents as communicationEvent>
		<tr class="background_tr">
		<td>
			&nbsp;&nbsp;<strong>${communicationEvent_index+2}.&nbsp;${communicationEvent.partyIdFrom?if_exists}</strong>&nbsp;于&nbsp;${communicationEvent.entryDate?if_exists}&nbsp;对&nbsp;${communicationEvent.partyIdTo?if_exists}&nbsp;进行回复
		</td>
		<td>
			&nbsp;
		</td>
		</tr>
		<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr class="background_tr"><td>&nbsp;&nbsp;${communicationEvent.content?if_exists}</td><td><a class="button" href="#" onclick="javascript:deleteCommunication('${(communicationEvent.communicationEventId)?if_exists}','${parentCommEventId?if_exists}');"><span>${uiLabelMap.CommonDelete}</span></a></td></tr>
		<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	</#list>
</#if>
</table>
<br/>
</div>