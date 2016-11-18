<div id="pageContent" >
    <form name="EditRegion" id="EditRegion" action="<@ofbizUrl><#if geo?has_content>updateRegion<#else>createRegion</#if></@ofbizUrl>" method="post">
    	  <#if geo?has_content><input type="hidden" id="geoId" name="geoId" value="${geo.geoId}"/></#if>
    	  <input type="hidden" name="navTabId" value="EditRegion"/>
    	  <input type="hidden" name="callbackType" value="closeCurrent"/>
   		  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="basic-table">
   		    <tr class="background_tr">
   		      <td class="border03 width15">地区名称：</td>
   		      <td class="border02 width85">
   		        <input name="geoName" type="text" class="required" value="<#if geo?has_content>${geo.get("geoName",locale)}</#if>"/>
   		      </td>
	        </tr>
   		    <tr>
   		      <td class="border03 width15">地区类型：</td>
   		      <td class="border02 width85">
   		        <select name="geoTypeId" id="geoTypeId">
      	      	  <option value="PROVINCE" <#if geo?has_content><#if geo.geoTypeId == "PROVINCE">selected=selected</#if></#if>>省</option>
      	      	  <option value="MUNICIPALITY" <#if geo?has_content><#if geo.geoTypeId == "MUNICIPALITY">selected=selected</#if></#if>>直辖市</option>
      	      	  <option value="CITY" <#if geo?has_content><#if geo.geoTypeId == "CITY">selected=selected</#if></#if>>市</option>
      	      	  <option value="COUNTY" <#if geo?has_content><#if geo.geoTypeId == "COUNTY">selected=selected</#if></#if>>县级市</option>
      	      	  <option value="COUNTY_CITY" <#if geo?has_content><#if geo.geoTypeId == "COUNTY_CITY">selected=selected</#if></#if>>县/区</option>
		        </select>
              </td>
	        </tr>
	        <tr class="background_tr">
   		      <td class="border03 width15">上级地区：</td>
   		      <td class="border02 width85">
   		      	<select name="parentGeoId" id="parentGeoId">
   		      	<#if geo?has_content>
	   		      	<#assign parentGeo = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(delegator.findByAnd("GeoAssoc", {"geoIdTo" :  geo.geoId})) />
	   		      	<#assign parentGeoId = parentGeo.geoId/>
	   		    <#else>
	   		    	<#if pGeoId?has_content><#assign parentGeoId = pGeoId/></#if>
   		      	</#if>
   		      	<option value="CHN" <#if parentGeoId?has_content><#if parentGeoId == 'CHN'>selected=selected</#if></#if>>中国</option>
   		      	<#if geoList?has_content>
	   		      	<#list geoList as geoMap>
	      	      	  <option value="${geoMap.geoGv.geoId}" <#if parentGeoId?has_content><#if parentGeoId == geoMap.geoGv.geoId>selected=selected</#if></#if>>
	      	      	  <#if geoMap?? && geoMap.lev!=1><#list 1..2 as a>-</#list></#if>${geoMap.geoGv.geoName}
	      	      	  </option>
	      	      	</#list>
      	      	</#if>
		        </select>
              </td>
	        </tr>
   		    <tr>
   		      <td class="border03 ">排序：</td>
   		      <td class="border02 ">
   		        <input name="sequenceNum" type="text" class="input200 required" value="<#if parentGeo?has_content>${parentGeo.sequenceNum?if_exists}<#else>1</#if>"/>
   		      </td>
   		    </tr>
   		    <tr class="background_tr">
   		      <td class="border03 ">地区码：</td>
   		      <td class="border02 ">
   		        <input name="geoCode" type="text" class="input200" value="<#if geo?has_content>${geo.geoCode?if_exists}</#if>"/>
   		      </td>
   		    </tr>
	    </table>
	</form>
</div>