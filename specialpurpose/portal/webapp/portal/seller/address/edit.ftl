<#assign actionUrlStr="seller_createPostalAddress">
<#if mechMap.postalAddress?has_content>
    <#assign actionUrlStr="seller_updatePostalAddress">
</#if>
   <script type="text/javascript">
  	 $(function(){ 
		$(".breadcrumb").append("<li class='active'>账户设置</li><li class='active'>地址管理</li>")
	}); 
  </script> 
<div class="screenlet">
    <div class="screenlet-title-bar">
        <ul>
            <li class="h3">地址管理</li>
        </ul>
        <br class="clear"></div>
    <div id="screenlet_1_col" class="screenlet-body">
        <form method="post" action="<@ofbizUrl>${actionUrlStr}</@ofbizUrl>" name="editcontactmechform"
              id="editcontactmechform" class="basic-form"
              onsubmit="javascript:submitFormDisableSubmits(this)">
            <input type="hidden" name="contactMechId" id="updateAddress_contactMechId"
                   value="${(mechMap.postalAddress.contactMechId)?default(request.getParameter('contactMechId')?if_exists)}">
            <input type="hidden" name="userLoginId" id="updateAddress_userLoginId">
            <input type="hidden" name="contactMechPurposeTypeId" id="contactMechPurposeTypeId" value="PUR_RET_LOCATION">
            <input type="hidden" name="partyId" id="updateAddress_partyId"
                   value="${request.getParameter('partyId')?if_exists}">
            <table cellspacing="0" class="basic-table">
                <tbody>
                <tr>
                    <td class="label">收件人*</td>
                    <td>
                        <input type="text" size="50" maxlength="100" name="attnName"
                               value="${(mechMap.postalAddress.attnName)?default(request.getParameter('attnName')?if_exists)}"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">地址*</td>
                    <td>
                        <input type="text" size="100" maxlength="255" name="address1"
                               value="${(mechMap.postalAddress.address1)?default(request.getParameter('address1')?if_exists)}"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">国家*</td>

                    <td>
                        <select name="countryGeoId" id="editcontactmechform_countryGeoId">
                        ${screens.render("component://common/widget/CommonScreens.xml#countries")}
                        <#if (mechMap.postalAddress?exists) && (mechMap.postalAddress.countryGeoId?exists)>
                            <#assign defaultCountryGeoId = mechMap.postalAddress.countryGeoId>
                        <#else>
                            <#assign defaultCountryGeoId = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("general.properties", "country.geo.id.default")>
                        </#if>
                            <option selected="selected" value="${defaultCountryGeoId}">
                            <#assign countryGeo = delegator.findOne("Geo",Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",defaultCountryGeoId), false)>
                                    ${countryGeo.get("geoName",locale)}
                            </option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="label">城市*</td>
                    <td>
                        <input type="text" size="50" maxlength="100" name="city"
                               value="${(mechMap.postalAddress.city)?default(request.getParameter('city')?if_exists)}"/>
                    </td>
                </tr>
               <#--<tr>
                    <td class="label">${uiLabelMap.PartyState}</td>
                    <td>
                        <select name="stateProvinceGeoId" id="editcontactmechform_stateProvinceGeoId">
                        </select>
                    </td>
                </tr>--> 
                <tr>
                    <td class="label">邮政编码*</td>
                    <td>
                        <input type="text" size="30" maxlength="60" name="postalCode"
                               value="${(mechMap.postalAddress.postalCode)?default(request.getParameter('postalCode')?if_exists)}"/>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
    </div>
    <div class="button-bar">
        <a href="javascript:document.editcontactmechform.submit()" class="smallSubmit">保存</a>
        <a href="<@ofbizUrl>seller_listAddress</@ofbizUrl>" class="smallSubmit">取消</a>
    </div>
</div>
