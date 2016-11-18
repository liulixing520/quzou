<div id="pageContent" >
   		  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="basic-table">
   		    <tr class="background_tr">
   		      <td class="border03 width15">配送区域名称：</td>
   		      <td class="border02 width85">
   		        <#if geo?has_content>${geo.get("geoName",locale)}</#if>
   		      </td>
	        </tr>
   		    <tr>
   		      <td class="border03 width15">地区费用类型：</td>
   		      <td class="border02 width85">
   		        <#if !(geoDistribution?has_content) || geoDistribution?has_content && geoDistribution.feeType == '0'>统一运费</#if>
                <#if geoDistribution?has_content && geoDistribution.feeType == '1'>按重量计算</#if>
              </td>
	        </tr>
	        <#if !(geoDistribution?has_content) || geoDistribution?has_content && geoDistribution.feeType == '0'>
	        <tr style="display:none" id="carrage_tr">
   		      <td class="border03 width15">运费金额：</td>
   		      <td class="border02 width85">
   		      	<#if geoDistribution?has_content>${geoDistribution.totalPrice?if_exists}</#if>元
              </td>
	        </tr>
	        </#if>
	        <#if !(geoDistribution?has_content) || geoDistribution?has_content && geoDistribution.feeType == '1'>
	        <tr style="display:none" id="first_money_tr"  class="background_tr">
   		      <td class="border03 width15">首重费用：</td>
   		      <td class="border02 width85">
   		      	<#if geoDistribution?has_content>${geoDistribution.firstMoney?if_exists}</#if>元/
      	      	  <#assign h = ''>
      	      	  <#if geoDistribution?has_content && geoDistribution.firstDimension?has_content && geoDistribution.firstUnit?has_content>
      	      	    <#assign h = geoDistribution.firstDimension?string+':'+geoDistribution.firstUnit?string>
      	      	  </#if>
      	      	  ${h?if_exists}
              </td>
	        </tr>
	        <tr style="display:none" id="add_money_tr">
   		      <td class="border03 width15">续重费用：</td>
   		      <td class="border02 width85">
   		      	<#if geoDistribution?has_content>${geoDistribution.additionalMoney?if_exists}</#if>元/
		          <#assign ah = ''>
		          <#if geoDistribution?has_content && geoDistribution.additionalDimension?has_content && geoDistribution.additionalUnit?has_content>
      	      	    <#assign ah = geoDistribution.additionalDimension?string+':'+geoDistribution.additionalUnit?string>
      	      	  </#if>
      	      	  ${ah?if_exists}
              </td>
	        </tr>
	        </#if>
	        <tr class="background_tr">
   		      <td class="border03 width15">配送地区：</td>
   		      <td class="border02 width85">
   		      	<#if geoDistribution?has_content>
		    		<#if geoDistribution.feeType?has_content>
						<#assign geoDistributionAssocs = delegator.findByAnd("GeoDistributionAssoc",{'geoId':geoDistribution.geoId})?if_exists >
		    			<#if geoDistribution.feeType=='0'>
		    				<#list geoDistributionAssocs as geoDistributionAssoc>
			    				<#assign g = delegator.findByPrimaryKey("Geo",Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",geoDistributionAssoc.geoIdTo))?if_exists>
			    				<strong><#if g?has_content>${g.geoName}</#if></strong>
								${geoDistributionAssoc.totalPrice?if_exists}元<br/>
							</#list>
		    			<#elseif geoDistribution.feeType=='1'>
		    				<#list geoDistributionAssocs as geoDistributionAssoc>
			    				<#assign g = delegator.findByPrimaryKey("Geo",Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",geoDistributionAssoc.geoIdTo))?if_exists>
			    				<strong>${g.get("geoName",locale)}</strong>
								首重：${geoDistributionAssoc.firstMoney?if_exists}元
			                    <#assign fu = delegator.findByPrimaryKey("Uom",Static["org.ofbiz.base.util.UtilMisc"].toMap("uomId",geoDistributionAssoc.firstUnit))?if_exists>
			                    ${geoDistributionAssoc.firstDimension?if_exists}${fu.abbreviation?if_exists}
								续重：${geoDistributionAssoc.additionalMoney?if_exists}元
			                    <#assign au = delegator.findByPrimaryKey("Uom",Static["org.ofbiz.base.util.UtilMisc"].toMap("uomId",geoDistributionAssoc.additionalUnit))?if_exists>
			                    ${geoDistributionAssoc.additionalDimension?if_exists}${au.abbreviation?if_exists}<br/>
			                    
							</#list>
		    			</#if>
		    		</#if>
		    	</#if>
              </td>
	        </tr>
   		    <tr>
   		      <td class="border03 ">排序：</td>
   		      <td class="border02 ">
   		        <#if geoDistribution?has_content>${geoDistribution.sequenceNum?if_exists}</#if>
   		      </td>
   		    </tr>
   		    <tr class="background_tr">
   		      <td class="border03 width15">管理用户：</td>
   		      <td class="border02 width85">
   		      	<#if geoDistributionUsers?has_content>
		    		<#list geoDistributionUsers as geoDistributionUser>
		    			${geoDistributionUser.userLoginId?if_exists}<br/>
		    		</#list>
		    	</#if>
              </td>
	        </tr>
   		    <tr>
   		      <td class="border03 ">详细介绍：</td>
   		      <td class="border02 ">
   		        <#if geoDistribution?has_content>${geoDistribution.description?if_exists}</#if>
   		      </td>
   		    </tr>
	    </table>
</div>
<div class="formBar" >
	<ul>
		<li><div class="button"><div class="buttonContent"><button class="close" type="button">${uiLabelMap.CommonClose}</button></div></div></li>
	</ul>
</div>