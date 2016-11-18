<div class="pageContent">
	<form  id='facilityForm'  action="<#if entity??>updateFacility<#else>createFacility</#if>" method="post"  class="single_table"  >
   <div class="pageFormContent" layoutH="97">
   <input type="hidden" name="facilityId" id="EditFacility_facilityId"  value='<#if entity??>${entity.facilityId!}</#if>'/>
   <input type="hidden" name="ownerPartyId" value="Company" id="ownerPartyId"/>
   <input type="hidden" name="defaultInventoryItemTypeId" value="NON_SERIAL_INV_ITEM" id="defaultInventoryItemTypeId"/>
   <input type="hidden" name="facilityTypeId" value="WAREHOUSE" id="facilityTypeId"/>
   <input type="hidden" name="navTabId" id="navTabId" value="FindFacility" />
   <input type="hidden" name="callbackType" id="callbackType" value="closeCurrent" />
   <input type="hidden" name="contactMechPurposeTypeId" value="SHIP_ORIG_LOCATION" />
<table cellspacing="0" class="basic-table">
					    <tr class='background_tr'>
						    <td class='border03' >
								<span>仓库名称</span>    
							</td>
						    <td class='border02'>
								<input type='checkbox' name='beijing' value=1>北京
								<input type='checkbox' name='tianjin' value=1>天津
						    </td>
					    </tr>
					     <tr >
								<td width="16%" class="tar">仓库1：</td>
								<td width="84%"><input name="toName"   class="required" id="toName" <#if postalAddressView??>  value='${postalAddressView.toName!}' </#if>  type="text" maxlength="16"/><span id="receiverError" style="color:red"></span></td>
						 </tr>				  
						  <tr class="background_tr">
							  <tr >
				  			  <td >仓库2：</td><td >
									
				  			  <select id='stateProvinceGeoId' name="stateProvinceGeoId"  onchange="ajaxSelect(this,'ajaxAreaCommon','cityGeoId');" >
								<#if postalAddressView??&&postalAddressView.stateProvinceGeoId??>
									<#assign geo = delegator.findByPrimaryKey("Geo",  Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",postalAddressView.stateProvinceGeoId))>
									<option value='${postalAddressView.stateGeoId}'>${geo.geoName}</option>
								</#if>
								<option value="">选择省市--</option>
								<#assign stateAssocs = Static["org.ofbiz.iteamgr.party.ContactMechTools"].getAssociatedStateList(delegator,'CHN')>
									<#list stateAssocs as stateAssoc>
									    <option value='${stateAssoc.geoId}'>${stateAssoc.geoName?default(stateAssoc.geoId)}</option>
									</#list>
								</select>
								<select name="cityGeoId" id="cityGeoId"  onchange="ajaxSelect(this,'ajaxAreaCommon','countyGeoId');">
									<#if postalAddressView??&&postalAddressView.cityGeoId??>
										<#assign geo = delegator.findByPrimaryKey("Geo",  Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",postalAddressView.cityGeoId))>
										<option value='${postalAddressView.cityGeoId}'>${geo.geoName}</option>
									</#if>
									<option value="">选择城市</option>
								</select>
								<select  name="countyGeoId" id="countyGeoId">
									<#if postalAddressView??&&postalAddressView.countyGeoId??>
										<#assign geo = delegator.findByPrimaryKey("Geo",  Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",postalAddressView.countyGeoId))>
										<option value='${postalAddressView.countyGeoId}'>${geo.geoName}</option>
									</#if>
									<option value="">选择区县</option>
								</select>
				  			  
				  			  <span id="areaError" style="color: red"></span></td>
						  </tr>
						  </tr>
						  <tr>
							  <td  class="tar">详细地址：</td>
							  <td><input name="address1" id="address1"  class="required"  <#if postalAddressView??>  value='${postalAddressView.address1!}' </#if> type="text" maxlength=50 style="width:250px"/><span id="addressError" style="color:red"></span></td>
						  </tr >
						  <tr class="background_tr">
							  <td  class="tar">邮政编码：</td>
							  <td><input name="postalCode" id="postalCode"  class="required"  <#if postalAddressView??>   value='${postalAddressView.postalCode!}' </#if> type="text" maxlength=6 onKeyUp="this.value=this.value.replace(/[^\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/><span id="postCodeError" style="color:red"></span></td>
						  </tr>
						  <tr>
							  <td  class="tar">手机：</td> 
							  <td><input name="mobileExd" id="mobileExd"  class="required"  <#if postalAddressView??>  value='${postalAddressView.mobileExd!}' </#if> type="text" maxlength=11 onKeyUp="this.value=this.value.replace(/[^\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/><span id="mobileError" style="color:red"></span></td>
						  </tr>
						  <tr class="background_tr">
							  <td  class="tar">固定电话：</td>
							  <td>
							  <input type="text" value="<#if postalAddressView??>${postalAddressView.phoneAreaExd!}</#if>"   name="phoneAreaExd">-
							  <input name="phoneExd" id="phoneExd"  class="required" <#if postalAddressView??>   value='${postalAddressView.phoneExd!}' </#if> type="text" maxlength=11 onKeyUp="this.value=this.value.replace(/[^\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/>手机和固定电话至少有一项必填<span id="phoneError" style="color:red"></span></td>
						  </tr>
    <tr class='background_tr'>
    <td class='border03'>
		<span id="EditFacility_content_title">描述
		</span>    
	</td>
    <td colspan="4">
		<textarea name="description" cols="50"  ><#if entity??>${entity.description!}</#if></textarea>
	</td>
    </tr>
    
    <tr class='background_tr'>
	    <td class='border03'>
			<span id="EditFacility_content_title">仓储销售区域分配管理
			</span>    
		</td>
	    <td colspan="4">
			<a href="/iteamgr/control/FacilityGeoAssoc" ><input type="button" value="保存配置2" /></a>
		</td>
    </tr>
    </table>
  		
	</div>
	<div class="formBar">
		<ul>
			<li><a class="button" href="#" onclick="javascript:submitFormsSimple('facilityForm');"  ><span>${uiLabelMap.CommonSave}</span></a></li>
			<li><div class="button"><div class="buttonContent"><button class="close" type="button">${uiLabelMap.CommonClose}</button></div></div></li>
		</ul>
	</div>  
    </form>	
</div>