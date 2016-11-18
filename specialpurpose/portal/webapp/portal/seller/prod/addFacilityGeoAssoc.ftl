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
<script language='javascript'>
function submitContactForms(form){
try{
	if(validateForm(document.getElementById(form))==undefined){
	jQuery.ajax({
        url: jQuery("#"+form).attr("action"),
        type: 'POST',
        data:jQuery("#"+form).serializeArray(),
        error: function(msg) {
           alert(msg);
        },
        success: function(msg) {
        	alert('操作成功');
			jQuery('#geoId').val("");
			jQuery('#fromDate').val("");
			jQuery('#thruDate').val("");
			jQuery('#facility_Geo_Assoc_list_div').html(msg);
        }
    });
    }
    }catch(e){alert(e.message);}
}
function deletefgo(facilityId,geoId,assocTypeId,fromDate){

try{
	jQuery.ajax({
        url: "<@ofbizUrl>deleteFacilityGeoAssoc</@ofbizUrl>?facilityId="+facilityId+"&geoId="+geoId+"&assocTypeId="+assocTypeId+"&fromDate="+fromDate,
        type: 'POST',
        //data:{facilityId:facilityId},
        error: function(msg) {
        alert("failed");
           alert(msg);
        },
        success: function(msg) {
        	alert('删除成功');
			jQuery('#facility_Geo_Assoc_list_div').html(msg);
			$('#facility_Geo_Assoc_list_div').initUI();
        }
    });
    }catch(e){alert(e.message);}
}

function viewfgo(facilityId,geoId,assocTypeId,fromDate){
try{
	jQuery.ajax({
        url: "<@ofbizUrl>viewFacilityGeoAssoc</@ofbizUrl>?facilityId="+facilityId+"&geoId="+geoId+"&assocTypeId="+assocTypeId+"&fromDate="+fromDate,
        type: 'POST',
        error: function(msg) {
           alert(msg);
        },
        success: function(msg) {
			jQuery('#add_facility_Geo_Assoc_div').html(msg);
			$('#add_facility_Geo_Assoc_div').initUI();
        }
    });
    }catch(e){alert(e.message);}
}
</script>
<div id="add_facility_Geo_Assoc_div">
<br>
<br>
 <h2>添加收货地址</h2><br>
 <!--<#if facilityGeoAssocList??><@ofbizUrl>updateFacilityGeoAssoc</@ofbizUrl><#else><@ofbizUrl>createFacilityGeoAssoc</@ofbizUrl></#if> -->
	 <form action="<#if facilityGeoAssoc??><@ofbizUrl>updateFacilityGeoAssoc</@ofbizUrl><#else><@ofbizUrl>createFacilityGeoAssoc</@ofbizUrl></#if>" method="post" id="currentForm" name="currentForm">
			         <input type="hidden"  name="facilityId" value="${facilityId!}" /><!--仓库idfacilityId-->
					  <table class="basic-table" >
					 	 
						  <tr>
							  <td  class="tar">选择地区：</td>
							  <td>
								  <select id='geoId' name="geoId" class="required">
									<#if postalAddressView??&&postalAddressView.stateProvinceGeoId??>
										<#assign geo = delegator.findByPrimaryKey("Geo",  Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",postalAddressView.stateProvinceGeoId))>
										<option value='${postalAddressView.stateGeoId}'>${geo.geoName}</option>
									</#if>
									
									<option value="">选择省市--</option>
									<#assign stateAssocs = Static["org.ofbiz.iteamgr.party.ContactMechTools"].getAssociatedStateList(delegator,'CHN')>
										<#list stateAssocs as stateAssoc>
										    <option value='${stateAssoc.geoId}' <#if facilityGeoAssoc??><#if stateAssoc.geoId == (facilityGeoAssoc.geoId?string)>selected="selected"<#else></#if></#if> >${stateAssoc.geoName?default(stateAssoc.geoId)}</option>
										</#list>
									</select>
								  <span id="addressError" style="color:red"></span>
							  </td>
							 <input name="assocTypeId" id="assocTypeId"  class="required"   value='SHIP_REGION' type="hidden"   />
							  <td  class="tar">开始时间：</td>
							  <td>
							  <input type="text" class="required date textInput readonly valid" readonly="true" format="yyyy-MM-dd HH:mm:ss" <#if facilityGeoAssoc??>  value='${facilityGeoAssoc.fromDate?string('yyyy-MM-dd HH:mm:ss')}' </#if> name="fromDate" id="fromDate" size="18"/>
							  <span id="addressError" style="color:red"></span>
							  </td>
							  <td  class="tar">结束时间：</td> 
							  <td>
							  <input type="text" class="date textInput readonly valid" readonly="true" format="yyyy-MM-dd HH:mm:ss" id="thruDate" name="thruDate" size="18">
							  </td>
						  </tr>
						  
					  </table>
					  
				  </form>
				</div>
			
<div class="formBarCenter" >
		<ul>
		<li><a class="button" href="#" onclick="javascript:submitContactForms('currentForm');"><span>保存</span></a></li>
		<li><div class="button"><div class="buttonContent"><button class="close" type="button">关闭</button></div></div></li>
		</ul>
	</div>  