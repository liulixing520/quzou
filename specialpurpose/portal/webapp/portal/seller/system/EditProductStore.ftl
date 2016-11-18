<div class="pageContent">
	<form id="EditProductStore" name="EditProductStore" action="<#if productStore?has_content>updateProductStore<#else>createProductStore</#if>" method="post" style="margin:0;padding:0" onsubmit="return iframeCallback(this, navTabAjaxDone)">
    	<input type="hidden" name="navTabId" value="EditProductStore"/>
    	<input type="hidden" name="manualAuthIsCapture" value="<#if productStore?has_content>${productStore.manualAuthIsCapture?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="prorateShipping" value="<#if productStore?has_content>${productStore.prorateShipping?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="prorateTaxes" value="<#if productStore?has_content>${productStore.prorateTaxes?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="viewCartOnAdd" value="<#if productStore?has_content>${productStore.viewCartOnAdd?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="autoSaveCart" value="<#if productStore?has_content>${productStore.autoSaveCart?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="autoApproveReviews" value="<#if productStore?has_content>${productStore.autoApproveReviews?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="autoInvoiceDigitalItems" value="<#if productStore?has_content>${productStore.autoInvoiceDigitalItems?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="reqShipAddrForDigItems" value="<#if productStore?has_content>${productStore.reqShipAddrForDigItems?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="isDemoStore" value="<#if productStore?has_content>${productStore.isDemoStore?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="isImmediatelyFulfilled" value="<#if productStore?has_content>${productStore.isImmediatelyFulfilled?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="checkInventory" value="<#if productStore?has_content>${productStore.checkInventory?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="requireInventory" value="<#if productStore?has_content>${productStore.requireInventory?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="reserveInventory" value="<#if productStore?has_content>${productStore.reserveInventory?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="reserveOrderEnumId" value="<#if productStore?has_content>${productStore.reserveOrderEnumId?if_exists}<#else>INVRO_FIFO_REC</#if>"/>
    	<input type="hidden" name="balanceResOnOrderCreation" value="<#if productStore?has_content>${productStore.balanceResOnOrderCreation?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="showOutOfStockProducts" value="<#if productStore?has_content>${productStore.showOutOfStockProducts?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="oneInventoryFacility" value="<#if productStore?has_content>${productStore.oneInventoryFacility?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="defaultCurrencyUomId" value="<#if productStore?has_content>${productStore.defaultCurrencyUomId?if_exists}<#else>CNY</#if>"/>
    	<input type="hidden" name="allowPassword" value="<#if productStore?has_content>${productStore.allowPassword?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="retryFailedAuths" value="<#if productStore?has_content>${productStore.retryFailedAuths?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="headerApprovedStatus" value="<#if productStore?has_content>${productStore.headerApprovedStatus?if_exists}<#else>ORDER_APPROVED</#if>"/>
    	<input type="hidden" name="itemApprovedStatus" value="<#if productStore?has_content>${productStore.itemApprovedStatus?if_exists}<#else>ITEM_APPROVED</#if>"/>
    	<input type="hidden" name="digitalItemApprovedStatus" value="<#if productStore?has_content>${productStore.digitalItemApprovedStatus?if_exists}<#else>ITEM_APPROVED</#if>"/>
    	<input type="hidden" name="headerDeclinedStatus" value="<#if productStore?has_content>${productStore.headerDeclinedStatus?if_exists}<#else>ORDER_REJECTED</#if>"/>
    	<input type="hidden" name="itemDeclinedStatus" value="<#if productStore?has_content>${productStore.itemDeclinedStatus?if_exists}<#else>ITEM_REJECTED</#if>"/>
    	<input type="hidden" name="headerCancelStatus" value="<#if productStore?has_content>${productStore.headerCancelStatus?if_exists}<#else>ORDER_CANCELLED</#if>"/>
    	<input type="hidden" name="itemCancelStatus" value="<#if productStore?has_content>${productStore.itemCancelStatus?if_exists}<#else>ITEM_CANCELLED</#if>"/>
    	<input type="hidden" name="storeCreditAccountEnumId" value="<#if productStore?has_content>${productStore.storeCreditAccountEnumId?if_exists}<#else>FIN_ACCOUNT</#if>"/>
    	<input type="hidden" name="explodeOrderItems" value="<#if productStore?has_content>${productStore.explodeOrderItems?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="checkGcBalance" value="<#if productStore?has_content>${productStore.checkGcBalance?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="usePrimaryEmailUsername" value="<#if productStore?has_content>${productStore.usePrimaryEmailUsername?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="requireCustomerRole" value="<#if productStore?has_content>${productStore.requireCustomerRole?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="showCheckoutGiftOptions" value="<#if productStore?has_content>${productStore.showCheckoutGiftOptions?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="selectPaymentTypePerItem" value="<#if productStore?has_content>${productStore.selectPaymentTypePerItem?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="showPricesWithVatTax" value="<#if productStore?has_content>${productStore.showPricesWithVatTax?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="showTaxIsExempt" value="<#if productStore?has_content>${productStore.showTaxIsExempt?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="prodSearchExcludeVariants" value="<#if productStore?has_content>${productStore.prodSearchExcludeVariants?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="enableDigProdUpload" value="<#if productStore?has_content>${productStore.enableDigProdUpload?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="enableAutoSuggestionList" value="<#if productStore?has_content>${productStore.enableAutoSuggestionList?if_exists}<#else>N</#if>"/>
    	<input type="hidden" name="autoOrderCcTryExp" value="<#if productStore?has_content>${productStore.autoOrderCcTryExp?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="autoOrderCcTryOtherCards" value="<#if productStore?has_content>${productStore.autoOrderCcTryOtherCards?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="autoOrderCcTryLaterNsf" value="<#if productStore?has_content>${productStore.autoOrderCcTryLaterNsf?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="autoApproveInvoice" value="<#if productStore?has_content>${productStore.autoApproveInvoice?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="autoApproveOrder" value="<#if productStore?has_content>${productStore.autoApproveOrder?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="shipIfCaptureFails" value="<#if productStore?has_content>${productStore.shipIfCaptureFails?if_exists}<#else>Y</#if>"/>
    	<input type="hidden" name="primaryStoreGroupId" value="<#if productStore?has_content>${productStore.primaryStoreGroupId?if_exists}<#else>_NA_</#if>"/>
    	<div>
			<table  class="basic-table" border="0" cellspacing="0" cellpadding="0">
	    		<tr class='background_tr'>
	  			  	<td class="label">店铺编号：</td>
	  			  	<td >
			       		<input type="text" name="productStoreId" <#if productStore?has_content>value="${productStore.productStoreId?if_exists}" readonly="readonly"</#if>/>
		          	</td>
		      	</tr>
	    		<tr>
	  			  	<td class="label">店铺名称：</td>
	  			  	<td >
			       		<input type="text" name="storeName" id="storeName" class="input150 required" value="<#if productStore??>${productStore.storeName!}</#if>" size="30" maxlength="20"/>
		          	</td>
		      	</tr>
	    		<tr class='background_tr'>
	  			  	<td class="label">店铺类型：</td>
	  			  	<td >
			       		<select name="productStoreTypeId">
				          <#list productStoreTypeList as productStoreType>
				      	  	<option <#if productStore?has_content><#if productStore.productStoreTypeId == productStoreType.enumId>selected=selected</#if></#if> value="${productStoreType.enumId?if_exists}">${productStoreType.description?if_exists}</option>
				      	  </#list>
				        </select>
		          	</td>
		      	</tr>
	    		<tr class='background_tr'>
	  			  	<td class="label">店铺仓库：</td>
	  			  	<td >
			       		<select name="inventoryFacilityId" class="required">
				          <#list facilityList as facility>
				      	  	<option <#if productStore?has_content><#if productStore.inventoryFacilityId == facility.facilityId>selected=selected</#if></#if> value="${facility.facilityId?if_exists}">${facility.facilityName?if_exists}</option>
				      	  </#list>
				        </select>
		          	</td>
		      	</tr>
	    		<tr>
	  			  	<td class="label">负责人：</td>
	  			  	<td >
	  			  		<input type="hidden" name="managerPartyId" id="managerPartyId" suggestFields="managerPartyId"  class="input150 required" value="<#if productStoreRoleId?has_content>${productStoreRoleId!}</#if>"/>
	  			  		<#if productStoreRoleId?has_content><#assign persongv = delegator.findByPrimaryKey("Person",Static["org.ofbiz.base.util.UtilMisc"].toMap("partyId",productStoreRoleId))></#if>
			       		<table><tr><td><input type="text" name="managerPartyName" id="managerPartyName" suggestFields="managerPartyName" class="input150" value="<#if persongv?has_content>${persongv.firstName!}</#if>" readonly="readonly"/></td><td><a class="btnLook" href="<@ofbizUrl>LookupProductStoreManager</@ofbizUrl>" lookupGroup="">选择负责人</a></td></tr></table>
		          	</td>
		      	</tr>
	    		<tr class='background_tr'>
	  			  	<td class="label">电话：</td>
	  			  	<td >
			       		<input type="text" name="telPhone" id="telPhone" suggestFields="telPhone" class="input150" value="<#if telecomPhoneNumber?has_content>${telecomPhoneNumber.countryCode!}-${telecomPhoneNumber.areaCode!}-${telecomPhoneNumber.contactNumber!}</#if>" readonly="readonly"/>
		          	</td>
		      	</tr>
	    		<tr>
	  			  	<td class="label">手机：</td>
	  			  	<td >
			       		<input type="text" name="mobile" id="mobile" suggestFields="mobile" class="input150" value="<#if telecomMobileNumber?has_content>${telecomMobileNumber.contactNumber!}</#if>" readonly="readonly"/>
		          	</td>
		      	</tr>
	    		<tr class='background_tr'>
	  			  	<td class="label">店铺地址：</td>
	  			  	<td >
			                <select class="editor_inner_third_two required" id='stateProvinceGeoId' name="stateProvinceGeoId"  onchange="getArea(this,'ajaxAreaCommon','cityGeoId','countyGeoId');" >
							<#if productStore??&&productStore.stateProvinceGeoId??>
								<#assign geo = delegator.findByPrimaryKey("Geo",  Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",productStore.stateProvinceGeoId))>
								<option value='${productStore.stateProvinceGeoId}'>${geo.geoName}</option>
							</#if>
							<option value="">选择省市--</option>
							<#assign stateAssocs = Static["org.ofbiz.iteamgr.party.ContactMechTools"].getAssociatedStateList(delegator,'CHN')>
							<#list stateAssocs as stateAssoc>
							    <option value='${stateAssoc.geoId}'>${stateAssoc.geoName?default(stateAssoc.geoId)}</option>
							</#list>
							</select>
							<select class="editor_inner_third_two required" name="cityGeoId" id="cityGeoId"  onchange="getArea(this,'ajaxAreaCommon','countyGeoId','null');">
								<#if productStore??&&productStore.cityGeoId??>
									<#assign geo = delegator.findByPrimaryKey("Geo",  Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",productStore.cityGeoId))>
									<option value='${productStore.cityGeoId}'>${geo.geoName}</option>
								</#if>
								<option value="">选择城市</option>
							</select>
							<select class="editor_inner_third_two required" name="countyGeoId" id="countyGeoId">
								<#if productStore??&&productStore.countyGeoId??>
									<#assign geo = delegator.findByPrimaryKey("Geo",  Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",productStore.countyGeoId))>
									<option value='${productStore.countyGeoId}'>${geo.geoName}</option>
								</#if>
								<option value="">选择区县</option>
							</select>
		          	</td>
		      	</tr>
		      	<tr>
	  			  	<td class="label">详细地址：</td>
	  			  	<td >
			       		<input name="address1" id="address1"  class="required editor_inner_first_two width_240px"  <#if productStore??>  value='${productStore.address1!}' </#if> type="text" maxlength="50" size="30"/>
		          	</td>
		      	</tr>
	    	</table>
		</div>
	</form>
		        
</div>	