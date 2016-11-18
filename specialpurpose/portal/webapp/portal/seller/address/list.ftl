   <script type="text/javascript">
  	 $(function(){ 
		$(".breadcrumb").append("<li class='active'>物流管理</li><li class='active'>退货地址管理</li>")
	}); 
  </script> 
<div class="screenlet">
    <div class="screenlet-title-bar">
        <ul>
            <li class="h3">退货地址列表</li>
        </ul>
        <br class="clear">
    </div>
    <div class="address-well">
        <ul>
            <li>
                <a href="<@ofbizUrl>seller_EditAddress</@ofbizUrl>"><img class="addImg" src="<@ofbizUrl>../images/add.png</@ofbizUrl>"/> </a>
            </li>
            <#if contactMeches?has_content>
                <#list contactMeches as contactMechMap>
                    <#assign contactMech = contactMechMap.contactMech>
                    <#list contactMechMap.partyContactMechPurposes as partyContactMechPurpose>
                        <#assign contactMechPurposeType = partyContactMechPurpose.getRelatedOne("ContactMechPurposeType", true)>
<#--                        <div>
                            <#if contactMechPurposeType?has_content>
                                <b>${contactMechPurposeType.get("description",locale)}</b>
                            </#if>
                        </div>-->
                    </#list>
                    <#if "POSTAL_ADDRESS" = contactMech.contactMechTypeId && "Purchase Return Address" = contactMechPurposeType.get("description")>
                        <li>
                            <div class="address">
                                <#if contactMechMap.postalAddress?has_content>
                                    <#assign postalAddress = contactMechMap.postalAddress>
                                    ${setContextField("postalAddress", postalAddress)}
                                    ${screens.render("component://party/widget/partymgr/PartyScreens.xml#postalAddressHtmlFormatter")}
                                    <#if postalAddress.geoPointId?has_content>
                                        <#if contactMechPurposeType?has_content>
                                            <#assign popUptitle = contactMechPurposeType.get("description", locale) + uiLabelMap.CommonGeoLocation>
                                        </#if>
                                        <a href="javascript:popUp('<@ofbizUrl>PartyGeoLocation?geoPointId=${postalAddress.geoPointId}&partyId=${partyId}</@ofbizUrl>', '${popUptitle?if_exists}', '450', '550')" class="buttontext">${uiLabelMap.CommonGeoLocation}</a>
                                    </#if>
                                </#if>
                            </div>
                            <div style="padding-top:5px; clear:both;">
                                <a style="float:left;" href="<@ofbizUrl>seller_EditAddress?partyId=${partyId}&amp;contactMechId=${contactMech.contactMechId}</@ofbizUrl>">${uiLabelMap.CommonUpdate}</a>
                                <a style="float:right;" href="<@ofbizUrl>seller_deleteContactMech?partyId=${partyId}&amp;contactMechId=${contactMech.contactMechId}</@ofbizUrl>">${uiLabelMap.CommonExpire}</a>
                            </div>
                        </li>
                    </#if>
                </#list>
            </#if>
        </ul>
    </div>
</div>