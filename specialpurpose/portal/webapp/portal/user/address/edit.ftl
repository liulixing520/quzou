<#assign actionUrlStr="user_createPostalAddress">
<#if mechMap.postalAddress?has_content>
    <#assign actionUrlStr="user_updatePostalAddress">
</#if>
<#assign postalAddress = (mechMap.postalAddress)!>
<div class="content profile">
            <h2 class="title" style='font-size:20px'>收货地址管理</h2>
            <div class="profile_detail clearfix">
        <form method="post" action="<@ofbizUrl>${actionUrlStr}</@ofbizUrl>" name="editcontactmechform"
              id="editcontactmechform" class="basic-form"
              onsubmit="javascript:submitFormDisableSubmits(this)">
            <input type="hidden" name="contactMechId" id="updateAddress_contactMechId"
                   value="${(mechMap.postalAddress.contactMechId)?default(request.getParameter('contactMechId')?if_exists)}">
            <input type="hidden" name="userLoginId" id="updateAddress_userLoginId">
            <input type="hidden" name="contactMechPurposeTypeId" id="contactMechPurposeTypeId" value="SHIPPING_LOCATION">
            <input type="hidden" name="partyId" id="updateAddress_partyId"
                   value="${request.getParameter('partyId')?if_exists}">
            <table cellspacing="0" class="basic-table">
                <tbody>
                <tr>
                    <td class="label">${uiLabelMap.PartyAttentionName}</td>
                    <td>
                        <input type="text" size="50" maxlength="100" name="attnName"
                               value="${(mechMap.postalAddress.attnName)?default(request.getParameter('attnName')?if_exists)}"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">收件人电话</td>
                    <td>
                        <input type="text" maxlength="11" class="new-input" name="mobileExd" id="address_mobile" value="${(postalAddress.mobileExd)!}" style="width:100%;">
                    </td>
                </tr>
                <tr>
                    <td class="label">地区</td>
                    <td>
                        <#if postalAddress??&&postalAddress.stateProvinceGeoId??>
							<#assign geo = delegator.findByPrimaryKey("Geo",{"geoId":postalAddress.stateProvinceGeoId})>
						</#if>
						<select name="stateProvinceGeoId" id="address_province" class="new-select" style="width:100px;" onchange="getArea(this, '', 'address_city', 'address_area')">
		                	<#assign stateAssocs = Static["org.ofbiz.system.ContactMechTools"].getAssociatedStateList(delegator,'CHN')>
							<#list stateAssocs as stateAssoc>
								<option <#if (postalAddress.stateProvinceGeoId)?? && postalAddress.stateProvinceGeoId==stateAssoc.geoId>selected</#if> value="${stateAssoc.geoId}">${stateAssoc.geoName?default(stateAssoc.geoId)}</option>
							</#list>
		                </select>
		                <#if (postalAddress.stateProvinceGeoId)??>
							<#assign cityAssocs = delegator.findByAnd("GeoAssoc",{"geoId":postalAddress.stateProvinceGeoId})/>
						</#if>
						<#if (postalAddress.cityGeoId)??>
							<#assign geoCity = delegator.findByPrimaryKey("Geo",{"geoId":postalAddress.cityGeoId})/>
						</#if>
						<select name="cityGeoId" id="address_city" class="new-select" style="width:100px;" onchange="getArea(this, '', 'address_area', 'null')">
		                	<#if cityAssocs??>
								<#list cityAssocs as cityAssoc>
									<#assign city = delegator.findByPrimaryKey("Geo",{"geoId":cityAssoc.geoIdTo})/>
									<option <#if (postalAddress.cityGeoId)?? && postalAddress.cityGeoId==city.geoId>selected</#if> value="${city.geoId}">${city.geoName?default(city.geoId)}</option>
								</#list>
							</#if>
		            	</select>
		            	<#if (postalAddress.cityGeoId)??>
							<#assign countyAssocs = delegator.findByAnd("GeoAssoc",{"geoId":postalAddress.cityGeoId})/>
						</#if>
						<#if (postalAddress.countyGeoId)??>
							<#assign geoCounty = delegator.findByPrimaryKey("Geo",{"geoId":postalAddress.countyGeoId})/>
						</#if>
						<select class="new-select" name="countyGeoId" id="address_area" style="width:100px;">
		                	<#if countyAssocs??>
								<#list countyAssocs as countyAssoc>
									<#assign county = delegator.findByPrimaryKey("Geo",{"geoId":countyAssoc.geoIdTo})/>
									<option <#if (postalAddress.countyGeoId)?? && postalAddress.countyGeoId==county.geoId>selected</#if> value="${county.geoId}">${county.geoName?default(county.geoId)}</option>
								</#list>
							</#if>
		            	</select>
                    </td>
                </tr>
                <tr>
                    <td class="label">${uiLabelMap.PartyAddressLine1} *</td>
                    <td>
                        <input type="text" size="100" maxlength="255" name="address1"
                               value="${(mechMap.postalAddress.address1)?default(request.getParameter('address1')?if_exists)}"/>
                    </td>
                </tr>
                <#--<tr>
                    <td class="label">${uiLabelMap.CommonCountry}</td>

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
                    <td class="label">${uiLabelMap.PartyCity} *</td>
                    <td>
                        <input type="text" size="50" maxlength="100" name="city"
                               value="${(mechMap.postalAddress.city)?default(request.getParameter('city')?if_exists)}"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">${uiLabelMap.PartyState}</td>
                    <td>
                        <select name="stateProvinceGeoId" id="editcontactmechform_stateProvinceGeoId">
                        </select>
                    </td>
                </tr>-->
                <tr>
                    <td class="label">${uiLabelMap.PartyZipCode} *</td>
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
        <a href="javascript:document.editcontactmechform.submit()" class="confirm_btn">${uiLabelMap.CommonSave}</a>
        <!-- <a href="<@ofbizUrl>user_listAddress</@ofbizUrl>" class="confirm_btn">${uiLabelMap.CommonGoBack}</a>-->
    </div>
</div>
<script type="text/javascript">
	// 设置省县市,传入出发的对象this,请求地址,表单ID,替换内容的name
	function getArea(thisObj, url, replaceDivId, childAreaDiv) {
		var area = document.getElementById(replaceDivId + "");
		var childArea = document.getElementById(childAreaDiv + "");
		$.ajax({
			url:'ajaxArea',
			type:'POST',
			data:{parentId:thisObj.value},
			success:function(r){
				if ( r.areaList ) {
					var areaList = r.areaList;
					var optStr = '<option></option>';
					for ( var i = 0, end = areaList.length; i < end; i++) {
						optStr += '<option value="'+areaList[i].geoId+'">'+areaList[i].geoName+'</option>';
					}
					$("#"+replaceDivId).html(optStr);
					if(childAreaDiv=='null'){}else{
						$("#"+childAreaDiv).html('');
					}
				}
			}
		});
	}
</script>