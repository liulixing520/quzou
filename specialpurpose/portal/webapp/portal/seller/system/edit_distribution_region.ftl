<script type="text/javascript">
	<#if !(geoDistribution?has_content) || geoDistribution?has_content && geoDistribution.feeType == '0'>
		show_unite_carriage();
	<#else>
		show_by_weight();
	</#if>
	//点击统一运费单选按纽
	$("#uniteCarriageRad").click(function(){
		show_unite_carriage();
	});
	//点击按重量计算单选按纽
	$("#byWeightRad").click(function () {
		show_by_weight();
	});
	//显示统一运费的输入框
	function show_unite_carriage(){
		$("#carrage_tr").css("display","");
		$("#first_money_tr").css("display","none");
		$("#add_money_tr").css("display","none");
		document.getElementById('distribution_region').href='setDistributionRegionByUnit<#if geo?has_content>?geoId=${geo.geoId}</#if>';
		//$("#distribution_regions").empty();
	}
	//显示按重量计算的输入框
	function show_by_weight(){
		$("#carrage_tr").css("display","none");
		$("#first_money_tr").css("display","");
		$("#add_money_tr").css("display","");
		document.getElementById('distribution_region').href='setDistributionRegionByWeight<#if geo?has_content>?geoId=${geo.geoId}</#if>';
		//$("#distribution_regions").empty();
	}
</script>
<div id="pageContent" style="height:485px;overflow:auto;" layouth='30'>
    <form name="EditDistributionRegion" id="EditDistributionRegion" action="<@ofbizUrl><#if geo?has_content>updateDistributionRegion<#else>createDistributionRegion</#if></@ofbizUrl>" method="post">
    	  <#if geo?has_content><input type="hidden" id="geoId" name="geoId" value="${geo.geoId}"/></#if>
    	  <input type="hidden" name="navTabId" value="EditDistributionRegion"/>
    	  <#assign productStoreId = Static["org.ofbiz.product.store.ProductStoreWorker"].getProductStoreId(request) />
    	  <input type="hidden" name="productStoreId" value="${productStoreId?if_exists}"/>
		  <input type="hidden" name="callbackType" value="closeCurrent"/>	
		  <input type="hidden" name="puom" value="CNY"/>	
   		  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="basic-table">
   		    <#--
   		    <tr>
   		      <td colspan="2" style="text-align:left"><strong><#if geo?has_content>编辑配送区域<#else>添加配送区域</#if></strong>
   		      </td>
	        </tr>
	        -->
   		    <tr class="background_tr">
   		      <td class="border03 width15">配送区域名称：</td>
   		      <td class="border02 width85">
   		        <input name="geoName" type="text" class="required" value="<#if geo?has_content>${geo.get("geoName",locale)}</#if>"/>
   		      </td>
	        </tr>
   		    <tr>
   		      <td class="border03 width15">地区费用类型：</td>
   		      <td class="border02 width85">
   		        <input name="feeType" id="uniteCarriageRad" type="radio" value="0" <#if !(geoDistribution?has_content) || geoDistribution?has_content && geoDistribution.feeType == '0'>checked</#if>/>统一运费
                <input name="feeType" id="byWeightRad" type="radio" value="1" <#if geoDistribution?has_content && geoDistribution.feeType == '1'>checked</#if>/>按重量计算
              </td>
	        </tr>
	        <tr style="display:none" id="carrage_tr">
   		      <td class="border03 width15">运费金额：</td>
   		      <td class="border02 width85">
   		      	<input type="text" id="carriage" class="digits" name="totalPrice" value="<#if geoDistribution?has_content>${geoDistribution.totalPrice?if_exists}</#if>"/>元
              </td>
	        </tr>
	       <tr style="display:none" id="first_money_tr"  class="background_tr">
   		      <td class="border03 width15">首重费用：</td>
   		      <td class="border02 width85">
   		      	<input type="text" name="firstMoney" id="firstMoneyTxt" class="digits" value="<#if geoDistribution?has_content>${geoDistribution.firstMoney?if_exists}</#if>" />元
   		      	<select name="firstUnit" id="firstUnitSel">
      	      	  <#assign h = ''>
      	      	  <#if geoDistribution?has_content && geoDistribution.firstDimension?has_content && geoDistribution.firstUnit?has_content>
      	      	    <#assign h = geoDistribution.firstDimension?string+':'+geoDistribution.firstUnit?string>
      	      	  </#if>
      	      	  <option value="1:WT_kg" <#if h == "1:WT_kg">selected=selected</#if>>1kg</option>
      	      	  <option value="10:WT_kg" <#if h == "10:WT_kg">selected=selected</#if>>10kg</option>
      	      	  <option value="20:WT_kg" <#if h == "20:WT_kg">selected=selected</#if>>20kg</option>
      	      	  <option value="50:WT_kg" <#if h == "50:WT_kg">selected=selected</#if>>50kg</option>
      	      	  <option value="100:WT_kg" <#if h == "100:WT_kg">selected=selected</#if>>100kg</option>
				  <option value="200:WT_kg" <#if h == "200:WT_kg">selected=selected</#if>>200kg</option>
				  <option value="500:WT_kg" <#if h == "500:WT_kg">selected=selected</#if>>500kg</option>
				  <option value="1000:WT_kg" <#if h == "1000:WT_kg">selected=selected</#if>>1000kg</option>
		        </select>
              </td>
	        </tr>
	        <tr style="display:none" id="add_money_tr">
   		      <td class="border03 width15">续重费用：</td>
   		      <td class="border02 width85">
   		      	<input type="text" name="additionalMoney" id="additionalMoneyTxt"  class="digits" value="<#if geoDistribution?has_content>${geoDistribution.additionalMoney?if_exists}</#if>" />元
   		      	<select name="additionalUnit" id="additionalUnitSel">
		          <#assign ah = ''>
		          <#if geoDistribution?has_content && geoDistribution.additionalDimension?has_content && geoDistribution.additionalUnit?has_content>
      	      	    <#assign ah = geoDistribution.additionalDimension?string+':'+geoDistribution.additionalUnit?string>
      	      	  </#if>
      	      	  <option value="1:WT_kg" <#if ah == "1:WT_kg">selected=selected</#if>>1kg</option>
      	      	  <option value="10:WT_kg" <#if ah == "10:WT_kg">selected=selected</#if>>10kg</option>
      	      	  <option value="20:WT_kg" <#if ah == "20:WT_kg">selected=selected</#if>>20kg</option>
      	      	  <option value="50:WT_kg" <#if ah == "50:WT_kg">selected=selected</#if>>50kg</option>
      	      	  <option value="100:WT_kg" <#if ah == "100:WT_kg">selected=selected</#if>>100kg</option>
				  <option value="200:WT_kg" <#if ah == "200:WT_kg">selected=selected</#if>>200kg</option>
				  <option value="500:WT_kg" <#if ah == "500:WT_kg">selected=selected</#if>>500kg</option>
				  <option value="1000:WT_kg" <#if ah == "1000:WT_kg">selected=selected</#if>>1000kg</option>
		        </select>
              </td>
	        </tr>
	        <tr class="background_tr">
   		      <td class="border03 width15">配送地区：</td>
   		      <td class="border02 width85">
   		      	<a id="distribution_region" class="button" href="<@ofbizUrl>setDistributionRegionByUnit<#if geo?has_content>?geoId=${geo.geoId?if_exists}</#if></@ofbizUrl>" target="dialog" rel="productpec"><span>设置配送地区</span></a>
              </td>
	        </tr>
   		    <tr>
   		      <td class="border03 ">排序：</td>
   		      <td class="border02 ">
   		        <input name="sequenceNum" type="text" class="input200" value="<#if geoDistribution?has_content>${geoDistribution.sequenceNum?if_exists}</#if>"/>
   		      </td>
   		    </tr>
   		    <tr class="background_tr">
   		      <td class="border03 width15">管理用户：</td>
   		      <td class="border02 width85">
   		      	<a id="distribution_userIds" width="580" height="380"  class="button" href="<@ofbizUrl>setDistributionRegionUser<#if geo?has_content>?geoId=${geo.geoId?if_exists}</#if></@ofbizUrl>" target="dialog" rel="productpec"><span>设置管理用户</span></a>
              </td>
	        </tr>
   		    <#--tr class="background_tr">
   		      <td class="border03 ">状态：</td>
   		      <td class="border02 ">
   		        <input name="distribution.status" type="radio" value="1" <#if !(geoDistribution??) || (geoDistribution?? && geoDistribution.status == 1)>checked</#if>/>启用
                <input name="distribution.status" type="radio" value="0" <#if geoDistribution?? && geoDistribution.status == 0>checked</#if>/>关闭
              </td>
	        </tr-->
   		    <tr>
   		      <td class="border03 ">详细介绍：</td>
   		      <td class="border02 ">
   		        <textarea name="description" cols="45" rows="5" class="textarea01"><#if geoDistribution?has_content>${geoDistribution.description?if_exists}</#if></textarea>
   		      </td>
   		    </tr>
	    </table>
	    <input type="hidden" name="modified" id="hidd_modified" value="default"/>
	    <div id="distribution_regions">
	    	<#if geoDistribution?has_content>
	    		<#if geoDistribution.feeType?has_content>
					<#assign geoDistributionAssocs = delegator.findByAnd("GeoDistributionAssoc",{'geoId':geoDistribution.geoId})?if_exists >
	    			<#if geoDistribution.feeType=='0'>
	    				<#list geoDistributionAssocs as geoDistributionAssoc>
		    				<input type='hidden' id='distRegions_unitId_regionId_${geoDistributionAssoc.geoIdTo?if_exists}' name='distRegions_unitId_regionId_${geoDistributionAssoc.geoIdTo?if_exists}' value='${geoDistributionAssoc.geoIdTo?if_exists}'/>
							<input type='hidden' id='distRegions_unitId_carriage_${geoDistributionAssoc.geoIdTo?if_exists}' name='distRegions_unitId_carriage_${geoDistributionAssoc.geoIdTo?if_exists}' value='${geoDistributionAssoc.totalPrice?if_exists}'/>
							<input type='hidden' id='distRegions_unitId_opened_${geoDistributionAssoc.geoIdTo?if_exists}' name='distRegions_unitId_opened_${geoDistributionAssoc.geoIdTo?if_exists}' value='default'/>
						</#list>
	    			<#elseif geoDistribution.feeType=='1'>
	    				<#list geoDistributionAssocs as geoDistributionAssoc>
		    				<input type='hidden' id='distRegions_weightId_regionId_${geoDistributionAssoc.geoIdTo?if_exists}' name='distRegions_unitId_regionId_${geoDistributionAssoc.geoIdTo?if_exists}' value='${geoDistributionAssoc.geoIdTo?if_exists}'/>
							<input type='hidden' name='distRegions_weightId_firstMoney_${geoDistributionAssoc.geoIdTo?if_exists}' id='distRegions_weightId_firstMoney_${geoDistributionAssoc.geoIdTo?if_exists}'value='${geoDistributionAssoc.firstMoney?if_exists}'/>
							<input type='hidden' name='distRegions_weightId_additionalMoney_${geoDistributionAssoc.geoIdTo?if_exists}' id='distRegions_weightId_additionalMoney_${geoDistributionAssoc.geoIdTo?if_exists}' value='${geoDistributionAssoc.additionalMoney?if_exists}'/>
		                    <input type='hidden' name='distRegions_weightId_firstDimension_${geoDistributionAssoc.geoIdTo?if_exists}' id='distRegions_weightId_firstDimension_${geoDistributionAssoc.geoIdTo?if_exists}' value='${geoDistributionAssoc.firstDimension?if_exists}'/>
		                    <input type='hidden' name='distRegions_weightId_additionalDimension_${geoDistributionAssoc.geoIdTo?if_exists}' id='distRegions_weightId_additionalDimension_${geoDistributionAssoc.geoIdTo?if_exists}' value='${geoDistributionAssoc.additionalDimension?if_exists}'/>
		                    <input type='hidden' name='distRegions_weightId_firstUnit_${geoDistributionAssoc.geoIdTo?if_exists}' id='distRegions_weightId_firstUnit_${geoDistributionAssoc.geoIdTo?if_exists}' value='${geoDistributionAssoc.firstUnit?if_exists}'/>
		                    <input type='hidden' name='distRegions_weightId_additionalUnit_${geoDistributionAssoc.geoIdTo?if_exists}' id='distRegions_weightId_additionalUnit_${geoDistributionAssoc.geoIdTo?if_exists}' value='${geoDistributionAssoc.additionalUnit?if_exists}'/>
							<input type='hidden' id='distRegions_weightId_opened_${geoDistributionAssoc.geoIdTo?if_exists}' name='distRegions_unitId_opened_${geoDistributionAssoc.geoIdTo?if_exists}' value='default'/>
						</#list>
	    			</#if>
	    		</#if>
	    	</#if>
	    </div>
	    <div id="distribution_users">
	    	<#if geoDistributionUsers?has_content>
	    		<#list geoDistributionUsers as geoDistributionUser>
	    			<input type='hidden' id='distRegions_user_${geoDistributionUser.userLoginId?if_exists}' name='distRegions_user_${geoDistributionUser.userLoginId?if_exists}' value='${geoDistributionUser.userLoginId?if_exists}'/>
	    		</#list>
	    	</#if>
	    </div>
	</form>
</div>