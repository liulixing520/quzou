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
<script langugage='javascript'>
	 jQuery(function(){
	 	jQuery("#mechListDiv").initUI();
	 }); 	
</script>
	<div id='mechListDiv'>
					<h3>收货地址</h3><br>
					<table class="table" width="100%" >
					<thead>
					
						<tr class="title04">
							<td>仓库</td>
							<td>配送区域</td>
							<td>开始时间</td>
							<td>结束时间</td>
							<td>操作</td>
						</tr>
					</thead>	
						<tbody>
						<#if facilityGeoAssocList??>
							<#list facilityGeoAssocList as facilityGeoAssoc>
								<tr>
									<td>${facilityGeoAssoc.facilityId!}</td>
									<#assign geo = delegator.findByPrimaryKey("Geo",  Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",facilityGeoAssoc.geoId))>
									<td>${geo.geoName!}</td>
									<td >${facilityGeoAssoc.fromDate!}</td>
									<td >
										<form method="post" action="<@ofbizUrl>updateFacilityGeoAssoc</@ofbizUrl>" name="lineForm${facilityGeoAssoc_index}" id="lineForm${facilityGeoAssoc_index}">
				                            <input type="hidden" name="facilityId" value="${facilityGeoAssoc.facilityId!}" />
				                            <input type="hidden" name="geoId" value="${facilityGeoAssoc.geoId!}" />
				                            <input type="hidden" name="assocTypeId" value="${facilityGeoAssoc.assocTypeId!}" />
				                            <input type="hidden" name="fromDate" value="${facilityGeoAssoc.fromDate!}" />
				                            <input type="text" class="date textInput readonly valid" readonly="true" format="yyyy-MM-dd HH:mm:ss" name="thruDate" size="18" value="${(facilityGeoAssoc.thruDate?string('yyyy-MM-dd HH:mm:ss'))?if_exists}">
				                        </form>
			                        </td>
									<td>
										<a class="button" href="javascript:void(0)" onclick="javascript:submitContactForms('lineForm${facilityGeoAssoc_index}');"><span>更新</span></a>
										
										<a class="button" href="javascript:void(0)" onclick="deletefgo('${facilityGeoAssoc.facilityId!}','${facilityGeoAssoc.geoId!}','${facilityGeoAssoc.assocTypeId!}','${facilityGeoAssoc.fromDate!}')" style="margin:0 10px"><span>删除</span></a>
									</td>
								</tr>
							</#list>
						<#else>
						<tr>
							<td colspan="7">还没有添加地址</td>
						</tr>
						</#if>
				  </table>
				 </tbody>
				</div>