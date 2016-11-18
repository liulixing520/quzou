<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<#include "component://widget/templates/htmlFormMacroLibrary.ftl"/>

<#macro lookupField className="" alert="" name="" value="" size="20" maxlength="20" id="" event="" action="" readonly="" autocomplete="" descriptionFieldName="" formName="" fieldFormName="" targetParameterIter="" imgSrc="" ajaxUrl="" ajaxEnabled="" presentation="layer" width="" height="" position="topleft" fadeBackground="true" clearText="" showDescription="" initiallyCollapsed="">
    <#if (!ajaxEnabled?has_content)>
        <#assign javascriptEnabled = Static["org.ofbiz.base.util.UtilHttp"].isJavaScriptEnabled(request) />
        <#if (javascriptEnabled)>
            <#local ajaxEnabled = true>
        </#if>
    </#if>
    <#if (!id?has_content)>
        <#local id = Static["org.ofbiz.base.util.UtilHttp"].getNextUniqueId(request) />
    </#if>
    <#if "true" == readonly>
        <#local readonly = true/>
    <#else>
        <#local readonly = false />
    </#if>
    <#if userPreferences.VISUAL_THEME == "BIZZNESS_TIME">
        <#local position = "center" />
    </#if>
    <@renderLookupField name formName fieldFormName className alert value size maxlength id event action readonly autocomplete descriptionFieldName targetParameterIter imgSrc ajaxUrl ajaxEnabled presentation width height position fadeBackground clearText showDescription initiallyCollapsed/>
</#macro>

<#macro nextPrev commonUrl="" ajaxEnabled=false javaScriptEnabled=false paginateStyle="nav-pager" paginateFirstStyle="nav-first" viewIndex=0 highIndex=0 listSize=0 viewSize=1 ajaxFirstUrl="" firstUrl="" paginateFirstLabel="" paginatePreviousStyle="nav-previous" ajaxPreviousUrl="" previousUrl="" paginatePreviousLabel="" pageLabel="" ajaxSelectUrl="" selectUrl="" ajaxSelectSizeUrl="" selectSizeUrl="" commonDisplaying="" paginateNextStyle="nav-next" ajaxNextUrl="" nextUrl="" paginateNextLabel="" paginateLastStyle="nav-last" ajaxLastUrl="" lastUrl="" paginateLastLabel="" paginateViewSizeLabel="" >
    <#local javaScriptEnabled = javaScriptEnabled />
    <#if (!javaScriptEnabled)>
        <#local javaScriptEnabled = Static["org.ofbiz.base.util.UtilHttp"].isJavaScriptEnabled(request) />
    </#if>
    <#if (commonUrl?has_content)>
        <#if (!firstUrl?has_content)>
            <#local firstUrl=commonUrl+"VIEW_SIZE=${viewSize}&amp;VIEW_INDEX=${viewIndexFirst}"/>
        </#if>
        <#if (!previousUrl?has_content)>
             <#local previousUrl=commonUrl+"VIEW_SIZE=${viewSize}&amp;VIEW_INDEX=${viewIndexPrevious}"/>
        </#if>
        <#if (!nextUrl?has_content)>
            <#local nextUrl=commonUrl+"VIEW_SIZE=${viewSize}&amp;VIEW_INDEX=${viewIndexNext}"/>
        </#if>
        <#if (!lastUrl?has_content)>
            <#local lastUrl=commonUrl+"VIEW_SIZE=${viewSize}&amp;VIEW_INDEX=${viewIndexLast}"/>
        </#if>
        <#if (!selectUrl?has_content)>
            <#local selectUrl=commonUrl+"VIEW_SIZE=${viewSize}&amp;VIEW_INDEX="/>
        </#if>
        <#if (!selectSizeUrl?has_content)>
            <#local selectSizeUrl=commonUrl+"VIEW_SIZE='+this.value+'&amp;VIEW_INDEX=0"/>
        </#if>
    </#if>
    <@renderNextPrev paginateStyle paginateFirstStyle viewIndex highIndex listSize viewSize ajaxEnabled javaScriptEnabled ajaxFirstUrl firstUrl uiLabelMap.CommonFirst paginatePreviousStyle ajaxPreviousUrl previousUrl uiLabelMap.CommonPrevious uiLabelMap.CommonPage ajaxSelectUrl selectUrl ajaxSelectSizeUrl selectSizeUrl commonDisplaying paginateNextStyle ajaxNextUrl nextUrl uiLabelMap.CommonNext paginateLastStyle ajaxLastUrl lastUrl uiLabelMap.CommonLast uiLabelMap.CommonItemsPerPage/>
</#macro>


<#macro submitButton formId="" dialogId=""  submitJs="" oper=""  backHref="" isReset="" >
   <div class=""> 
    		<div id='toolBar' class="buttonBar">
				<#if !(oper?has_content&&oper=="view")>
					<button onclick="<#if dialogId?has_content><#if submitJs?has_content>${submitJs}<#else>submitDialogForm</#if><#else><#if submitJs?has_content>${submitJs}<#else>submitForm</#if></#if>('${formId}');return false;" class="btn btn-primary">保存</button>
				</#if>
				<#if (isReset?has_content&&isReset=="yes")>
					<button type="reset" class="btn">重置</button>
				<#else>
					<button class="btn" onclick="javascript:<#if dialogId?has_content>closeDialog('${dialogId!}')<#elseif backHref?has_content>window.location.href='${backHref!}'<#else>window.history.back()</#if>;" href="javascript:void(0);">
						<#if dialogId?has_content>关闭<#else>返回</#if>
					</button>
				</#if>
    		</div>
		</div>
	<#--
   <div class="form-actions">
   		<#if !(oper?has_content&&oper=="view")>
			<button type="submit" class="btn btn-primary">保存</button>
		</#if>
   		<#if (isReset?has_content&&isReset=="yes")>
			<button type="reset" class="btn">重置</button>
		<#else>
			<button class="btn" onclick="javascript:<#if dialogId?has_content>closeDialog('${dialogId!}')<#elseif backHref?has_content>window.location.href='${backHref!}'<#else>window.history.back()</#if>;">
					<#if dialogId?has_content>关闭<#else>返回</#if>
			</button>					
		</#if>
  </div>-->
</#macro>
<#macro fileLink documentPurpose="" entityIdValue="">
	<#assign fileName = Static["org.extErp.sysCommon.document.DocumentUtils"].getDocNameByPurpose(request,"${documentPurpose}","${entityIdValue}")?if_exists/>
	<a href='getDocUrlByPurpose?sysDocPurposeId=${documentPurpose}&relatedIdValue=${entityIdValue}' target='_blank'>${fileName!}
</#macro>	
<#macro operButton operationButton>
	<#if operationButton?has_content>
	      <#assign operationButtonNew=operationButton?replace(" ","")?replace("&#123;","")?replace("&#125;","")> ${operationButtonNew}
	      <#list operationButtonNew?split(",") as button>
	      <#assign buttonAtts =button?replace(" ","")?split("&#124;")>
	      <#if buttonAtts?size==5>
	      <#assign buttonPermission =buttonAtts[4]>
	      <#assign hasPersonssion=Static["org.extErp.sysCommon.util.OfbizExtUtil"].hasPermission(buttonPermission,security,userLogin)>
	      <#if  hasPersonssion>
	          <#assign buttonUiLabelName =buttonAtts[0]?replace(" ","")>
	          <#assign operInfo =buttonAtts[3]?split("-")>
	         	<@juiButton id="${buttonAtts[0]}" value="${buttonAtts[0]}" disabled="disabled" class="${buttonAtts[1]}"
	         	  target="${operInfo[0]!}" 
	         	  href="${buttonAtts[2]}" title="${operInfo[1]!}"/>
	       </#if>
	       </#if>
	      </#list>
	</#if>
</#macro>
<#macro juiButton id value disabled class="button" target="href" href="#" title="">
	<#assign targets =target?split("@")>
	<a <#if target=='href'> href='${href}' 
	<#elseif target=='removeSelected'>onclick="javascript:removeFormsGridFun('ids','${href}','${title}');"
	<#elseif target=='editSelected'>onclick="javascript:editFormsGridFun('ids','${href}','${title}');"
	<#elseif target=='dialog'>onclick="javascript:operEditDialog('${href}');"
	<#else>onclick="${href}"</#if>  href="javascript:void(0);" class="btn btn-primary">${value}</a>
</#macro>
<#macro searchButton searchForm>
	<a class="l-btn" onclick="javascript:searchFormFun('${searchForm!}');return false;" href="javascript:void(0);">
		<span class="l-btn-left">
			<span class="l-btn-text icon-search l-btn-icon-left">
				查询
			</span>
		</span>
	</a>
</#macro>
<#macro navTitle titleProperty="">
<div class="panel-heading">
	${titleProperty!}
</div>
</#macro>
<#macro commonGeo entity>
<input type='hidden' name='city' value='city'>
<input type='hidden' name='postalCode' value='100000'>
<input type="hidden" name="contactMechId" value="<#if entity??>${entity.contactMechId?if_exists}</#if>">
<select  id='stateProvinceGeoId' style='width:90px' name='stateProvinceGeoId' onchange="getArea(this,'ajaxAreaCommon','cityGeoId','countyGeoId');">
	<#if entity??&&entity.stateProvinceGeoId??>
	<#assign stateProvinceGeo = delegator.findOne("Geo",{"geoId",entity.stateProvinceGeoId},false)>
	    <option value='${stateProvinceGeo.geoId}'>${stateProvinceGeo.geoName}</option>
	<#else>  
	<option value="">省份/直辖市</option>
	<#assign stateAssocs = Static["org.extErp.sysCommon.party.CommonWorkers"].getAssociatedStateList(delegator,'CHN')>
	<#list stateAssocs as stateAssoc>
	    <option value='${stateAssoc.geoId}'>${stateAssoc.geoName?default(stateAssoc.geoId)}</option>
	</#list>
	</#if>
</select>
<select  id="cityGeoId" style='width:90px' name="cityGeoId"  onchange="getArea(this,'ajaxAreaCommon','countyGeoId','null');">
	<#if entity??&&entity.cityGeoId??>
	<#assign city = delegator.findOne("Geo",{"geoId",entity.cityGeoId},false)>
	    <option value='${city.geoId}'>${city.geoName}</option>
	<#else><option>市</option>    
	</#if>
</select>
<select  id="countyGeoId" style='width:90px' name="countyGeoId">
	<#if entity??&&entity.countyGeoId??>
	<#assign countyGeo = delegator.findOne("Geo",{"geoId",entity.countyGeoId},false)>
	    <option value='${countyGeo.geoId}'>${countyGeo.geoName}</option>
	<#else><option>县/区</option>
	</#if>
	
</select>
</#macro>	
<#macro productName product request>
    <#assign productName = Static["org.ofbiz.product.product.EbizProductContentWrapper"].getProductTitleByLocale(product,request)/>
    ${productName!}
</#macro>
<#macro storeNameMac storeName dxStoreId>
	<#if dxStoreId?has_content>
		<#assign dxStore=delegator.findOne("ProductStore",{"productStoreId",dxStoreId},false)?if_exists>
		${dxStore.storeName!}	
	<#else>
		 ${storeName!}
	</#if>	
   
</#macro>