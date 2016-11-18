   <script type="text/javascript">
  	 $(function(){ 
		$(".breadcrumb").append("<li class='active'>物流设置</li><li class='active'>发货地址</li>")
	}); 
  </script> 
<div class="screenlet">
    <div class="screenlet-title-bar">
        <ul>
            <li class="h3">发货地址列表</li>
        </ul>
        <br class="clear">
    </div>
    <div class="address-well">
        <ul>
            <li>
            	<form method="post" action='<@ofbizUrl>seller_EditFacilityAddress</@ofbizUrl>' name="createcontactmechform">
			      <input type='hidden' name='facilityId' value='${facilityId}'/>
			      <input type='hidden' name='DONE_PAGE' value='ViewContactMechs'/>
			      <input type='hidden' name='preContactMechTypeId' value='POSTAL_ADDRESS' />
			      <a href="javascript:document.createcontactmechform.submit()"><img class="addImg" src="<@ofbizUrl>../images/add.png</@ofbizUrl>"/> </a>
			    </form>
            </li>

<#if contactMeches?has_content>
      <#list contactMeches as contactMechMap>
          <#assign contactMech = contactMechMap.contactMech>
          <#assign facilityContactMech = contactMechMap.facilityContactMech>
            <#if "POSTAL_ADDRESS" = contactMech.contactMechTypeId>
		            <li>
		                 <div class="address">
		                <#-- ${contactMechMap.contactMechType.get("description",locale)}<br/>-->
		                  <#assign postalAddress = contactMechMap.postalAddress>
		                    <#if postalAddress.toName?has_content><b>${uiLabelMap.CommonTo}:</b> ${postalAddress.toName}<br /></#if>
		                    <#if postalAddress.attnName?has_content><b>发件人:</b> ${postalAddress.attnName}<br /></#if>
		                     <#assign AddressGeoAllCn =Static["org.ofbiz.system.ContactMechTools"].
                           			 getAddressGeoAllCn(delegator,postalAddress.stateProvinceGeoId,postalAddress.cityGeoId,postalAddress.countyGeoId)>
		                    ${AddressGeoAllCn?if_exists}<br />
		                    <#if postalAddress.address1?has_content>${postalAddress.address1?if_exists}<br /></#if>
		                    	邮编: ${postalAddress.postalCode?if_exists}
		                   <#--  ${postalAddress.city?if_exists},
		                    ${postalAddress.stateProvinceGeoId?if_exists}
		                   
		                     <#if postalAddress.countryGeoId?has_content><br />${postalAddress.countryGeoId}</#if>
		                  <#if (postalAddress?has_content && !postalAddress.countryGeoId?has_content) || postalAddress.countryGeoId = "USA">
		                      <#assign addr1 = postalAddress.address1?if_exists>
		                      <#if (addr1.indexOf(" ") > 0)>
		                        <#assign addressNum = addr1.substring(0, addr1.indexOf(" "))>
		                        <#assign addressOther = addr1.substring(addr1.indexOf(" ")+1)>
		                        <br /><a target='_blank' href='${uiLabelMap.CommonLookupWhitepagesAddressLink}' class='buttontext'>${uiLabelMap.CommonLookupWhitepages}</a>
		                      </#if>
		                  </#if>
		                
		                  <#if postalAddress.geoPointId?has_content>
		                    <#if contactMechPurposeType?has_content>
		                      <#assign popUptitle = contactMechPurposeType.get("description",locale) + uiLabelMap.CommonGeoLocation>
		                    </#if>
		                    <br /><a href="javascript:popUp('<@ofbizUrl>geoLocation?geoPointId=${postalAddress.geoPointId}</@ofbizUrl>', '${popUptitle?if_exists}', '450', '550')" class="buttontext">${uiLabelMap.CommonGeoLocation}</a>
		             	</#if>
		             	-->
		            </#if>
		            </div>
		            <div style="padding-top:5px; clear:both;">
		                <a style="float:left;" href="<@ofbizUrl>seller_EditFacilityAddress?facilityId=${facilityId}&amp;contactMechId=${contactMech.contactMechId}</@ofbizUrl>">${uiLabelMap.CommonUpdate}</a>
		                <a style="float:right;" href="<@ofbizUrl>seller_deleteFacilityContactMech?facilityId=${facilityId?if_exists}&amp;contactMechId=${contactMech.contactMechId?if_exists}</@ofbizUrl>">${uiLabelMap.CommonExpire}</a>
		            </div>
		        </li>
      </#list>
  <#else>
    <div class="screenlet-body">${uiLabelMap.CommonNoContactInformationOnFile}.</div>
  </#if>
</div>
            
 <#--     <#if contactMeches?has_content>
                <#list contactMeches as contactMechMap>
                    <#assign contactMech = contactMechMap.contactMech>
                    <#list contactMechMap.partyContactMechPurposes as partyContactMechPurpose>
                        <#assign contactMechPurposeType = partyContactMechPurpose.getRelatedOne("ContactMechPurposeType", true)>
			<!--                        <div>
                            <#if contactMechPurposeType?has_content>
                                <b>${contactMechPurposeType.get("description",locale)}</b>
                            </#if>
                        </div>-->
                 <#--   </#list>
                    <#if "POSTAL_ADDRESS" = contactMech.contactMechTypeId && "SHIP_ORIG_LOCATION" = contactMechPurposeType.get("contactMechPurposeTypeId")>
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
                                <a style="float:left;" href="<@ofbizUrl>seller_EditDeliveryAddress?partyId=${partyId}&amp;contactMechId=${contactMech.contactMechId}</@ofbizUrl>">${uiLabelMap.CommonUpdate}</a>
                                <a style="float:right;" href="<@ofbizUrl>seller_deleteDeliveryContactMech?partyId=${partyId}&amp;contactMechId=${contactMech.contactMechId}</@ofbizUrl>">${uiLabelMap.CommonExpire}</a>
                            </div>
                        </li>
                    </#if>
                </#list>
            </#if>-->
        </ul>
    </div>
</div>