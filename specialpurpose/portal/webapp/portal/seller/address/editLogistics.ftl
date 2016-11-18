<script type="text/javascript">
	function selExchangebyShipmentMethod(){
			var v=$("#carrierShipmentString").val();
			
			if(v){
				var strs=new Array();
				strs=v.split("|");
				var partyId=strs[0];
				var roleTypeId=strs[1];
				var shipmentMethodTypeId=strs[2];
				
				$("#EditProductStoreShipmentMeth_shipmentMethodTypeId").val(shipmentMethodTypeId) 
				$("#EditProductStoreShipmentMeth_roleTypeId").val(roleTypeId) 
				$("#EditProductStoreShipmentMeth_partyId").val(partyId) 
			}
	}
</script>




<div id="screenlet_2" class="screenlet">
	<div id="screenlet_2_col" class="screenlet-body">
		<!-- Begin  Form Widget - Form Element  component://portal/widget/seller/ProductStoreForms.xml#EditProductStoreShipmentMeth -->
		<form id="EditProductStoreShipmentMeth" class="basic-form"
			onsubmit="javascript:submitFormDisableSubmits(this)" method="post"
			name="EditProductStoreShipmentMeth"
			action="<@ofbizUrl>storeCreateShipMeth</@ofbizUrl>">
			<input id="EditProductStoreShipmentMeth_productStoreId" name="productStoreId" value="${productStoreId?if_exists}" type="hidden">
			<input id="EditProductStoreShipmentMeth_shipmentMethodTypeId" name="shipmentMethodTypeId" value="" type="hidden">
			<input id="EditProductStoreShipmentMeth_roleTypeId" name="roleTypeId" value="${roleTypeId?if_exists}" type="hidden"> 
			<input id="EditProductStoreShipmentMeth_partyId" name="partyId" value="${partyId?if_exists}" type="hidden">
			
			<#--	物流公司
			 <select name="carrierShipmentString" id="carrierShipmentString" onChange="selExchangebyShipmentMethod();">
              <option>请选择</option>
              <#list carrierShipmentMethods as shipmentMethod>
                <option value="${shipmentMethod.partyId}|${shipmentMethod.roleTypeId}|${shipmentMethod.shipmentMethodTypeId}">${shipmentMethod.shipmentMethodTypeId} (${shipmentMethod.partyId}/${shipmentMethod.roleTypeId})</option>
              </#list>
            </select>	
            <p></p>
            <input class="btn btn-info" name="submitButton" value="保存" type="submit">
							
							-->
			
	<table cellspacing="0" class="basic-table">
        <tr>
          <td align="right" class="label">物流公司</td>
          <td>
            <select name="carrierShipmentString" id="carrierShipmentString" onChange="selExchangebyShipmentMethod();">
              <option>请选择</option>
              	<#list carrierShipmentMethods![] as shipmentMethod>
          			<#if shipmentMethod.partyId??>
		              	<#assign shipGroup = delegator.findOne("PartyGroup",false,{"partyId":shipmentMethod.partyId})?if_exists/>
		                <option value="${shipmentMethod.partyId}|${shipmentMethod.roleTypeId}|${shipmentMethod.shipmentMethodTypeId}">${(shipGroup.groupName)!} (${shipmentMethod.partyId}/${shipmentMethod.roleTypeId})</option>
	              	</#if>
              </#list>
            </select>
          </td>
        </tr>
        <tr>
          <td></td>
          <td>
            <input type="submit" class="smallSubmit" value="${uiLabelMap.CommonAdd}"/>
          </td>
        </tr>
    </table>
					
							
							
			<table class="table-bordered" style="display:none;"
				cellSpacing="0">
				<tbody>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_shipmentMethodTypeId_title">送货方法类型标识</span>
						</td>
						<td>-</td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_roleTypeId_title">角色类型标识</span>
						</td>
						<td>-</td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_partyId_title">会员标识</span></td>
						<td></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_minSize_title">最小尺寸</span></td>
						<td><input id="EditProductStoreShipmentMeth_minSize"
							name="minSize" size="25" type="text"> <span
							class="tooltip">仅在最小产品尺寸大于等于这个值时显示</span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_maxSize_title">最大尺寸</span></td>
						<td><input id="EditProductStoreShipmentMeth_maxSize"
							name="maxSize" size="25" type="text"> <span
							class="tooltip">仅在最大产品尺寸小于等于这个值时显示</span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_minWeight_title">最小重量</span></td>
						<td><input id="EditProductStoreShipmentMeth_minWeight"
							name="minWeight" size="25" type="text"> <span
							class="tooltip">仅在重量合计大于等于这个值时显示</span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_maxWeight_title">最大重量</span></td>
						<td><input id="EditProductStoreShipmentMeth_maxWeight"
							name="maxWeight" size="25" type="text"> <span
							class="tooltip">仅在重量合计小于等于这个值时显示</span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_minTotal_title">最小数量</span></td>
						<td><input id="EditProductStoreShipmentMeth_minTotal"
							name="minTotal" size="25" type="text"> <span
							class="tooltip">仅在价格合计大于等于这个值时显示</span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_maxTotal_title">最大数量</span></td>
						<td><input id="EditProductStoreShipmentMeth_maxTotal"
							name="maxTotal" size="25" type="text"> <span
							class="tooltip">仅在价格合计小于等于这个值时显示</span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_allowUspsAddr_title">允许USPS地址</span>
						</td>
						<td><span class="ui-widget"> <select
								id="EditProductStoreShipmentMeth_allowUspsAddr" size="1"
								name="allowUspsAddr">
									<option selected="selected" value="Y">是</option>
									<option value="N">否</option>
							</select> </span> <span class="tooltip">允许USPS地址 (邮箱、 退货率等)</span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_requireUspsAddr_title">需要USPS地址</span>
						</td>
						<td><span class="ui-widget"> <select
								id="EditProductStoreShipmentMeth_requireUspsAddr" size="1"
								name="requireUspsAddr">
									<option value="Y">是</option>
									<option selected="selected" value="N">否</option>
							</select> </span> <span class="tooltip">如果允许是'N'，将忽略设置 </span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_allowCompanyAddr_title">允许公司地址</span>
						</td>
						<td><span class="ui-widget"> <select
								id="EditProductStoreShipmentMeth_allowCompanyAddr" size="1"
								name="allowCompanyAddr">
									<option selected="selected" value="Y">是</option>
									<option value="N">否</option>
							</select> </span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_requireCompanyAddr_title">需要公司地址</span>
						</td>
						<td><span class="ui-widget"> <select
								id="EditProductStoreShipmentMeth_requireCompanyAddr" size="1"
								name="requireCompanyAddr">
									<option value="Y">是</option>
									<option selected="selected" value="N">否</option>
							</select> </span> <span class="tooltip">如果允许是'N'，将忽略设置 </span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_companyPartyId_title">公司会员标识</span>
						</td>
						<td>
							<!-- @renderLookupField --> <script type="text/javascript">
								jQuery(document)
										.ready(
												function() {
													if (!jQuery('form[name="EditProductStoreShipmentMeth"]').length) {
														alert("Developer: for lookups to work you must provide a form name!")
													}
												});
							</script> <span class="field-lookup">
								<div
									id="0_lookupId_EditProductStoreShipmentMeth_companyPartyId_auto"></div>
								<input
								id="0_lookupId_EditProductStoreShipmentMeth_companyPartyId"
								name="companyPartyId" size="25" type="text"> <script
									type="text/javascript">
									jQuery(document)
											.ready(
													function() {
														var options = {
															requestUrl : "LookupPartyName",
															inputFieldId : "EditProductStoreShipmentMeth_companyPartyId",
															dialogTarget : document.EditProductStoreShipmentMeth.companyPartyId,
															dialogOptionalTarget : null,
															formName : "EditProductStoreShipmentMeth",
															width : "",
															height : "",
															position : "topleft",
															modal : "true",
															ajaxUrl : "EditProductStoreShipmentMeth_companyPartyId,/portal/control/LookupPartyName,ajaxLookup=Y&amp;_LAST_VIEW_NAME_=EditProductStoreShipSetup&amp;searchValueFieldName=companyPartyId",
															showDescription : "true",
															presentation : "layer",
															defaultMinLength : "2",
															defaultDelay : "300",
															args : []
														};
														new Lookup(options)
																.init();
													});
								</script> <a id="0_lookupId_button" href="javascript:void(0);"></a>
							<div id="0_lookupId" title=""></div>
						</span> <span class="tooltip">与允许公司地址一起使用</span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_includeNoChargeItems_title">包括免费货明细</span>
						</td>
						<td><span class="ui-widget"> <select
								id="EditProductStoreShipmentMeth_includeNoChargeItems" size="1"
								name="includeNoChargeItems">
									<option selected="selected" value="Y">是</option>
									<option value="N">否</option>
							</select> </span> <span class="tooltip">当购物车仅包含免费送货明细时，设置为否以便隐藏</span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_includeGeoId_title">包含地区</span>
						</td>
						<td>
							<!-- @renderLookupField --> <script type="text/javascript">
								jQuery(document)
										.ready(
												function() {
													if (!jQuery('form[name="EditProductStoreShipmentMeth"]').length) {
														alert("Developer: for lookups to work you must provide a form name!")
													}
												});
							</script> <span class="field-lookup"> <input
								id="EditProductStoreShipmentMeth_includeGeoId"
								name="includeGeoId" size="25" type="text"> <script
									type="text/javascript">
									jQuery(document)
											.ready(
													function() {
														var options = {
															requestUrl : "LookupGeo",
															inputFieldId : "EditProductStoreShipmentMeth_includeGeoId",
															dialogTarget : document.EditProductStoreShipmentMeth.includeGeoId,
															dialogOptionalTarget : null,
															formName : "EditProductStoreShipmentMeth",
															width : "",
															height : "",
															position : "topleft",
															modal : "true",
															ajaxUrl : "EditProductStoreShipmentMeth_includeGeoId,/portal/control/LookupGeo,ajaxLookup=Y&amp;_LAST_VIEW_NAME_=EditProductStoreShipSetup&amp;searchValueFieldName=includeGeoId",
															showDescription : "true",
															presentation : "layer",
															defaultMinLength : "2",
															defaultDelay : "300",
															args : []
														};
														new Lookup(options)
																.init();
													});
								</script> </span> <span class="tooltip">仅当送货地址在这个地区时显示</span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_excludeGeoId_title">排除地区</span>
						</td>
						<td>
							<!-- @renderLookupField --> <script type="text/javascript">
								jQuery(document)
										.ready(
												function() {
													if (!jQuery('form[name="EditProductStoreShipmentMeth"]').length) {
														alert("Developer: for lookups to work you must provide a form name!")
													}
												});
							</script> <span class="field-lookup"> <input
								id="EditProductStoreShipmentMeth_excludeGeoId"
								name="excludeGeoId" size="25" type="text"> <script
									type="text/javascript">
									jQuery(document)
											.ready(
													function() {
														var options = {
															requestUrl : "LookupGeo",
															inputFieldId : "EditProductStoreShipmentMeth_excludeGeoId",
															dialogTarget : document.EditProductStoreShipmentMeth.excludeGeoId,
															dialogOptionalTarget : null,
															formName : "EditProductStoreShipmentMeth",
															width : "",
															height : "",
															position : "topleft",
															modal : "true",
															ajaxUrl : "EditProductStoreShipmentMeth_excludeGeoId,/portal/control/LookupGeo,ajaxLookup=Y&amp;_LAST_VIEW_NAME_=EditProductStoreShipSetup&amp;searchValueFieldName=excludeGeoId",
															showDescription : "true",
															presentation : "layer",
															defaultMinLength : "2",
															defaultDelay : "300",
															args : []
														};
														new Lookup(options)
																.init();
													});
								</script> </span> <span class="tooltip">仅在送货地址不在这个地区时显示</span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_includeFeatureGroup_title">包含特征组</span>
						</td>
						<td><input
							id="EditProductStoreShipmentMeth_includeFeatureGroup"
							name="includeFeatureGroup" size="25" type="text"> <span
							class="tooltip">仅当全部明细都具有在这个组的全部特征时显示</span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_excludeFeatureGroup_title">排除特征组</span>
						</td>
						<td><input
							id="EditProductStoreShipmentMeth_excludeFeatureGroup"
							name="excludeFeatureGroup" size="25" type="text"> <span
							class="tooltip">仅在全部明细没有属于这个组的特征时显示</span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_serviceName_title">送货服务名称（已放弃使用）</span>
						</td>
						<td><input id="EditProductStoreShipmentMeth_serviceName"
							name="serviceName" size="25" type="text"></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_configProps_title">配置属性（已经被弃用）</span>
						</td>
						<td><input id="EditProductStoreShipmentMeth_configProps"
							name="configProps" size="25" type="text"></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_shipmentCustomMethodId_title">送货定制方法</span>
						</td>
						<td><span class="ui-widget"> <select
								id="EditProductStoreShipmentMeth_shipmentCustomMethodId"
								size="1" name="shipmentCustomMethodId">
									<option value="">&nbsp;</option>
									<option value="SHIP_EST_DHL">DHL rate estimate
										(dhlRateEstimate)</option>
									<option value="SHIP_EST_FEDEX">FedEx rate estimate
										(fedexRateEstimate)</option>
									<option value="SHIP_EST_UPS">UPS rate estimate
										(upsRateEstimate)</option>
									<option value="SHIP_EST_USPS">USPS rate estimate
										(uspsRateInquire)</option>
									<option value="SHIP_EST_USPS_INT">USPS rate estimate
										international (uspsInternationalRateInquire)</option>
							</select> </span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_shipmentGatewayConfigId_title">送货网关配置标识</span>
						</td>
						<td><span class="ui-widget"> <select
								id="EditProductStoreShipmentMeth_shipmentGatewayConfigId"
								size="1" name="shipmentGatewayConfigId">
									<option value="">&nbsp;</option>
									<option value="DHL_CONFIG">DHL Config</option>
									<option value="FEDEX_CONFIG">Fedex Config</option>
									<option value="UPS_CONFIG">UPS Config</option>
									<option value="USPS_CONFIG">USPS Config</option>
							</select> </span></td>
					</tr>
					<tr>
						<td class="form-group"><span
							id="EditProductStoreShipmentMeth_sequenceNumber_title">序号数字</span>
						</td>
						<td><input id="EditProductStoreShipmentMeth_sequenceNumber"
							name="sequenceNumber" size="25" type="text"> <span
							class="tooltip">用来显示订购</span></td>
					</tr>
					<tr>
						<td class="form-group">&nbsp;</td>
						<td colSpan="4"><input class="btn btn-info"
							name="submitButton" value="提交" type="submit"></td>
					</tr>
				</tbody>
			</table>
			
		</form>
		<!-- End  Form Widget - Form Element  component://portal/widget/seller/ProductStoreForms.xml#EditProductStoreShipmentMeth -->
	</div>
</div>
