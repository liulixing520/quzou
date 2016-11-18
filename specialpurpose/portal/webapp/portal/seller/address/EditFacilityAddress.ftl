<#--
新增仓库地址
-->
<#assign actionUrlStr="seller_createFacilityAddress">
<#if mechMap.contactMech?has_content>
    <#assign actionUrlStr="seller_updateFacilityPostalAddress">
</#if>

<#if !mechMap.facilityContactMech?exists && mechMap.contactMech?exists>
  <p><h3>${uiLabelMap.PartyContactInfoNotBelongToYou}.</h3></p>
  &nbsp;<a href="<@ofbizUrl>authview/${donePage}?facilityId=${facilityId}</@ofbizUrl>" class="buttontext">${uiLabelMap.CommonGoBack}</a>
<#else>
<script type="text/javascript">
  	 $(function(){ 
		$(".breadcrumb").append("<li class='active'>物流管理</li><li class='active'>发货地址管理</li>")
	}); 
</script> 
<div class="screenlet-title-bar">
  <#if mechMap.contactMechTypeId?has_content>
    <#if !mechMap.contactMech?has_content>
      	<ul>
            <li class="h3">发货地址管理</li>
        </ul>
        <br class="clear"></div>
       <div id="screenlet_1_col" class="screenlet-body">
      <#if contactMechPurposeType?exists>
        <div><span class="label">(${uiLabelMap.PartyMsgContactHavePurpose}</span>"${contactMechPurposeType.get("description",locale)?if_exists}")</div>
      </#if>
      <table width="90%" class="basic-table" cellspacing="0">
        <form method="post" action='<@ofbizUrl>${actionUrlStr}</@ofbizUrl>' name="editcontactmechform" id="editcontactmechform">
        <input type='hidden' name='DONE_PAGE' value='${donePage}' />
        <input type='hidden' name='contactMechTypeId' value='${mechMap.contactMechTypeId}' />
        <input type='hidden' name='facilityId' value='${facilityId}' />
        <#if preContactMechTypeId?exists><input type='hidden' name='preContactMechTypeId' value='${preContactMechTypeId}' /></#if>
        <#if contactMechPurposeTypeId?exists><input type='hidden' name='contactMechPurposeTypeId' value='${contactMechPurposeTypeId?if_exists}' /></#if>

        <#if paymentMethodId?exists><input type='hidden' name='paymentMethodId' value='${paymentMethodId}' /></#if>
		
		<input  type="hidden" name="contactMechPurposeTypeId" value="SHIP_ORIG_LOCATION"/>
        </tr>
    <#else>
   		 <ul>
            <li class="h3">发货地址管理</li>
        </ul>
        <br class="clear"></div>
        <div id="screenlet_1_col" class="screenlet-body">
      <#if contactMechPurposeType?exists>
        <div><span class="label">(${uiLabelMap.PartyMsgContactHavePurpose}</span>"${contactMechPurposeType.get("description",locale)?if_exists}")</div>
      </#if>
      <table width="90%" class="basic-table" cellspacing="0">
        <form method="post" action='<@ofbizUrl>${actionUrlStr}</@ofbizUrl>' name="editcontactmechform" id="editcontactmechform">
        <input type='hidden' name='DONE_PAGE' value='${donePage}' />
        <input type='hidden' name='contactMechTypeId' value='${mechMap.contactMechTypeId}' />
        <input type='hidden' name='facilityId' value='${facilityId}' />
        <#if preContactMechTypeId?exists><input type='hidden' name='preContactMechTypeId' value='${preContactMechTypeId}' /></#if>
        <#if contactMechPurposeTypeId?exists><input type='hidden' name='contactMechPurposeTypeId' value='${contactMechPurposeTypeId?if_exists}' /></#if>
        <#if paymentMethodId?exists><input type='hidden' name='paymentMethodId' value='${paymentMethodId}' /></#if>
		<input  type="hidden" name="contactMechPurposeTypeId" value="SHIP_ORIG_LOCATION"/>
		<input type="hidden" name="contactMechId" value="${contactMechId?if_exists}" />
        </tr>
    </#if>

  <#if "POSTAL_ADDRESS" = mechMap.contactMechTypeId?if_exists>
    <#--<tr>
      <td class="label">${uiLabelMap.PartyToName}</td>
      <td>
        <input type="text" size="30" maxlength="60" name="toName" value="${(mechMap.postalAddress.toName)?default(request.getParameter('toName')?if_exists)}" />
      </td>
    </tr>-->
    <tr>
      <td class="label">发件人*</td>
      <td>
        <input type="text" size="30" maxlength="60" name="attnName" value="${(mechMap.postalAddress.attnName)?default(request.getParameter('attnName')?if_exists)}" />
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
    	<tr>
                    <td class="label">${uiLabelMap.PartyZipCode} *</td>
                    <td>
                        <input type="text" size="30" maxlength="60" name="postalCode"
                               value="${(mechMap.postalAddress.postalCode)?default(request.getParameter('postalCode')?if_exists)}"/>
                    </td>
                </tr>
    
  </#if>
  </form>
  </table>
  </#if>
</#if>
</div>
    <div class="button-bar">
         <a href="javascript:document.editcontactmechform.submit()" class="smallSubmit">保存</a>
        <a href="<@ofbizUrl>seller_listFacilityAddress</@ofbizUrl>" class="smallSubmit">取消</a>
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