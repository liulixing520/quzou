<script language="javascript">
    function submitProReport(){
	    jQuery.ajax({
	        url: "AjaxOrderProSaleStats",
	        type: 'POST',
	        data:jQuery('#OrderProSaleStats').serialize(),
	        error: function(msg) {
	           //alert(msg);
	        },
	        success: function(msg) {
	        jQuery('#ReportProDiv').html(msg);
			$('#ReportProDiv').initUI();
	        }
	    });
	}  
</script>
<div class="pageHeader" id="ReportProDiv" layouth="55">
	<form name="OrderProSaleStats" onsubmit="javascript:submitFormDisableSubmits(this)" class="basic-form" id="OrderProSaleStats" target="_BLANK" action="OrderProSaleStatsReport" method="post">
		<input type="hidden" name="selectType" value="ok" />
		<table>
			<tr>
				<td>
					选择时间：
					<input type="text" name="fromDate" id="fromDate" <#if fromDate?has_content>value="${fromDate}"</#if> readonly="true" class="date textInput readonly valid" size="10">
					-
					<input type="text" name="thruDate" id="thruDate" <#if thruDate?has_content>value="${thruDate}"</#if> readonly="true" class="date textInput readonly valid" size="10">
					商品分类：
					<select name="primaryProductCategoryId" id="primaryProductCategoryId" class="required">
						<option value="" >请选择商品分类</option>
						<#if productCategoryList?has_content>
							<#list productCategoryList as productCategoryGv>
								<#assign productCategory = delegator.findByPrimaryKey("ProductCategory",Static["org.ofbiz.base.util.UtilMisc"].toMap("productCategoryId",productCategoryGv.productCategoryId))?if_exists>
								<option value="${productCategoryGv.productCategoryId?if_exists}" <#if primaryProductCategoryId?has_content><#if primaryProductCategoryId == productCategoryGv.productCategoryId>selected=selected</#if></#if>>${productCategory.categoryName?if_exists}</option>
							</#list>
						</#if>
					</select>	
					品牌：
					<select name="brandName" id="brandName">
						<option value="">请选择品牌</option>
						<#if productBrandList?has_content>
							<#list productBrandList as brand>
								<option value="${brand.id?if_exists}" <#if brandName?has_content><#if brandName == brand.id>selected=selected</#if></#if>>${brand.brandName?if_exists}</option>
							</#list>
						</#if>
					</select>
					类型：
					<select name="productTypeCategoryId" id="productTypeId" class="required">
						<option value="" >请选择所属类型</option>
						<#if productTypeList?has_content>
							<#list productTypeList as productType>
								<#assign productCategory = delegator.findByPrimaryKey("ProductCategory",Static["org.ofbiz.base.util.UtilMisc"].toMap("productCategoryId",productType.productCategoryId))?if_exists>
								<option value="${productType.productCategoryId?if_exists}" <#if productTypeCategoryId?has_content><#if productTypeCategoryId == productType.productCategoryId>selected=selected</#if></#if>>${productCategory.categoryName?if_exists}</option>
							</#list>
						</#if>
					</select>
					店铺：
					<select name="productStoreId" id="productStoreId" class="required">
						<option value="" >请选择所属店铺</option>
						<#if productStoreList?has_content>
							<#list productStoreList as productStore>
								<option value="${productStore.productStoreId?if_exists}" <#if productStoreId?has_content><#if productStoreId == productStore.productStoreId>selected=selected</#if></#if>>${productStore.storeName?if_exists}</option>
							</#list>
						</#if>
					</select>		
					<input type="button" onclick="javascript:submitProReport();" value="查询">
				</td>
				<td>
					<input type="submit" value="生成Excel报表" name="submit" <#if !selectType?has_content>disabled</#if>>
				</td>
			</tr>
		</table>
	</form>
	<table cellspacing="0" cellpadding="0" border="0" width="100%" class="border04 overall_03">
      <tr class="title02">
        <td align="right">排名</td>
        <td align="right">商品名称</td>
        <td align="right">商品货号</td>
        <td align="right">销售数量</td>
        <td align="right">销售总价</td>
        <td align="right">平均售价</td>
      </tr>
      <#if resultList?has_content>
	      <#list resultList as gvMap>
	      	  <#assign product = delegator.findByPrimaryKey("Product", {"productId" : gvMap.productId})>	
		      <tr>
		        <td  class="border03 width35">${gvMap_index+1!}</td>
		        <td  class="border03 width35">${product.productName!}</td>
		        <td  class="border03 width35">${product.goodsNo!}</td>
		        <td  class="border03 width35">${gvMap.quantity!}</td>
		        <td  class="border03 width35">${gvMap.total!}</td>
		        <td  class="border03 width35">${gvMap.avgePrice}</td>
		      </tr>
	      </#list>
      </#if>
    </table> 
</div>