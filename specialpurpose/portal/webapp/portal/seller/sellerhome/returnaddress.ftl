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


 <#if postalAddress.attnName?has_content>
 <tr>
 <th>${uiLabelMap.sellerAddressee}:</th><td> ${postalAddress.attnName}</td>
 </tr>
 </#if>



 <tr>
 <th>${uiLabelMap.sellerAddress}:</th><td> ${postalAddress.address1?if_exists}</td>
 </tr>


<#if postalAddress.countryGeoId?has_content><br />
<#assign country = postalAddress.getRelatedOneCache("CountryGeo")>
 <tr>
<th>${uiLabelMap.sellerCountry}:</th><td>${country.get("geoName", locale)?default(country.geoId)}</td>
 </tr>
</#if>

 

<tr>
 <th>${uiLabelMap.sellerCity}:</th><td>${postalAddress.city?if_exists}</td>
</tr>

<#if postalAddress.stateProvinceGeoId?has_content>
      <#assign stateProvince = postalAddress.getRelatedOneCache("StateProvinceGeo")>
     <th>${uiLabelMap.sellerProvince}:</th><td> ${stateProvince.abbreviation?default(stateProvince.geoId)}</td>
</#if>

<tr>
 <th>${uiLabelMap.sellercode}:</th><td>${postalAddress.postalCode?if_exists}</td>
</tr>

