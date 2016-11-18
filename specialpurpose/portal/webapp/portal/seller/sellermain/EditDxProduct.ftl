<div class="screenlet">  
    <form method="post" action="<@ofbizUrl><#if entity??><#if specValueList?has_content>updateDxProduct<#else>updateOneDxProduct</#if><#else><#if specValueList?has_content>createDxProduct<#else>createOneDxProduct</#if></#if></@ofbizUrl>" id="EditProductStore"
          name="EditProductStore" novalidate="novalidate">
        <input type="hidden" name="supplierStoreId"   value="${parameters.supplierStoreId!}">
        <input type="hidden" name="dxStoreId"   value="${parameters.dxStoreId!}">
        <input type="hidden" name="productId"   value="${parameters.productId!}">

            <h3>自定义销售价格</h3>
        </div>
		 
	<span
        <div class="screenlet-body">
            <table class="basic-table">
                <tbody> 
                <tr>
                <td colspan='2'>
                 <span class="g-title"> ${product.internalName?if_exists}</span> 
                 </td>
                 </tr>
                <tr> 
                 <td class="label">供应商价格：</td>
               		 <#if priceList?has_content>	
						  	<#assign usdPrice = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(priceList,{"currencyUomId":"USD"})?if_exists  />
						  	<#assign cnyPrice = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(priceList,{"currencyUomId":"CNY"})?if_exists  />
						  	<#assign rurPrice = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(priceList,{"currencyUomId":"RUR"})?if_exists  />
						</#if> 
						<td><#if cnyPrice??>${(cnyPrice[0].price)!}</#if></td>
                    <td class="label">分销价格：</td>
                    <td> 
                    	<span class='basePrice'><input type='text' name='dxPrice' value='<#if dxProduct??>${dxProduct.dxPrice!}</#if>' id='dxPrice'></span>
                    </td>	
                </tr>
                <#if specValueList?has_content>
                <tr>
                <td  colspan='2'>
                <table class="table-bordered"  >
                <tbody id="specsHead">
	                <#assign productFeatureCategoryId = "">
	                <#list specValueList as spec>
						<#if productFeatureCategoryId != spec.productFeatureCategoryId>
							<input type="hidden" name="specId" value="${spec.productFeatureCategoryId!}"/><#rt>
							<input type="hidden" name="st[${spec.productFeatureCategoryId!}]" value="${spec_index}"/><#rt>
							<td class="border07">
								<#assign pfcGv = spec.getRelatedOne("ProductFeatureCategory")>
								${pfcGv.description!} 
							</td>
						</#if>
						<#assign valId=spec.productFeatureId><#rt>
						<#assign productFeatureCategoryId = spec.productFeatureCategoryId>
					</#list>
					<td class="border07 width20">供应商价格</td>
					<td class="border07 width20">分销价格</td>
					</tr>
				</tbody>
				<tbody id="specsBody">
										<#if product?has_content>
											<#assign assocToProducts = Static["org.ofbiz.entity.util.EntityUtil"].filterByDate(delegator.findByAnd("ProductAssoc",{'productId':product.productId,'productAssocTypeId':'PRODUCT_VARIANT'}, Static["org.ofbiz.base.util.UtilMisc"].toList("sequenceNum ASC"))?if_exists) />
										</#if>
										<#if assocToProducts??><#rt>
											<#list assocToProducts as comm><#rt>
												<#assign commId="${comm.productIdTo}" /><#rt>
												<#assign p = delegator.findByPrimaryKey("Product",Static["org.ofbiz.base.util.UtilMisc"].toMap("productId",comm.productIdTo))>
												<tr >
													<input type="hidden" name="productId_o_${comm_index!}" value="${commId!}" /><!--productId-->
													<#assign pSpecFeatures = Static["org.ofbiz.entity.util.EntityUtil"].filterByDate(delegator.findByAnd("ProductFeatureAndAppl",{'productId':comm.productIdTo}, Static["org.ofbiz.base.util.UtilMisc"].toList("productFeatureCategoryId"))?if_exists) />
												   	<#if pSpecFeatures?has_content>
														<#list pSpecFeatures as specFeature>
															<#assign specId="${specFeature.productFeatureCategoryId!}" />
															<td class="border07" specId="${specId!}">
																${specFeature.description!}
															</td>
														</#list>
													</#if>
													
													<#assign priceList = Static["org.ofbiz.entity.util.EntityUtil"].filterByDate(delegator.findByAnd("ProductPrice",{'productId':comm.productIdTo,'productPriceTypeId':'DEFAULT_PRICE'}, Static["org.ofbiz.base.util.UtilMisc"].toList("fromDate"))?if_exists) />
													<#if priceList?has_content>	
													  	<#assign usdPrice = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(priceList,{"currencyUomId":"USD"})?if_exists  />
													  	<#assign cnyPrice = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(priceList,{"currencyUomId":"CNY"})?if_exists  />
													  	<#assign rurPrice = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(priceList,{"currencyUomId":"RUR"})?if_exists  />
													</#if>	
													<#assign result = dispatcher.runSync("getProductInventoryAvailable", Static["org.ofbiz.base.util.UtilMisc"].toMap("productId", comm.productIdTo))/>
													<td>
														<#if cnyPrice?has_content>${cnyPrice[0].price}</#if>
													</td>
													<td>
													<#assign dxProductChild=delegator.findOne("DxProduct",{"dxStoreId",parameters.dxStoreId,"supplierStoreId",parameters.supplierStoreId,"productId",comm.productIdTo},false)?if_exists>
														<input type="text" name="dxPrice_o_${comm_index}" value="<#if dxProductChild??>${dxProductChild.dxPrice!}</#if>" class="currency input40" maxlength="10" size="5"/>
													</td>
												</tr>
											</#list>
										</#if>
									</tbody>
								</table>
						</td>
					</tr>	
				</#if>					
               <tr>
                    <td>&nbsp;</td>
                    <td>
                    	<input value="保 存" class="btn btn-info" type="submit">&nbsp;&nbsp;&nbsp;
                    </td>
                    
                </tr>
            </table>
        </div>
    
    
 </form>
</div>

