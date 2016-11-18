

<div class="pageContent">
	
<form  id='productForm'  action="updateProductInventory" method="post"  class="single_table"  >
	<input type='hidden' name='productIds' value='${productIds}'>
   <div class="pageFormContent" layoutH="97">

	<table class="table-bordered" width="100%" layoutH="78">
		<thead>
			<tr>
				<td>商品名称</td>
				<#list facilityList as psfacility>
					<#assign facility = psfacility.getRelatedOne("Facility")?if_exists>
					<td>仓库：${facility.facilityName!}</td>
				</#list>
			</tr>
		</thead>
		<tbody>
		 <#list productList as product>
		 	<tr>
				<td >${product.internalName?if_exists}</td>
				<#list facilityList as pfacility>
				<#assign facility = pfacility.getRelatedOne("Facility")?if_exists>
				<#assign inventory=productInventoryMap[product.productId+"_"+facility.facilityId]>
					<td align='left'><input type='text' name='${product.productId}_${facility.facilityId}' value='<#if inventory?has_content>${inventory.availableToPromiseTotal!}</#if>'  size='5'></td>
				</#list>
				
			</tr>
		 </#list>
			
		</tbody>
	</table>
  		
	</div>
	<div class="formBar" >
		<table>
		<tr>
            <td>&nbsp;</td>
            <td><input value="保 存" class="btn btn-info" type="submit"></td>
        </tr>
		</table>
	</div>  
</form>	
	

