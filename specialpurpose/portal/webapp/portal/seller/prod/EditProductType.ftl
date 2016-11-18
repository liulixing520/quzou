<script language="javascript"> 
function changeText(t){
	var v = $(t).val(),nextsib = $(t.nextSibling),n=nextsib.val(),v1;
	if($.trim(n)){
		v1 = n.split(",")[0]+','+v;
		nextsib.val(v1);
	}else{
		v1=","+v;
	}
	nextsib.val(v1);
}
function addPNode(){
	$('#group').clone().show().appendTo("#grouptd"); 
}
function deletePNode(t){
	var pn = t.parentNode;
	pn.parentNode.removeChild(pn);
}
function onSubmitFormsSimple(currentForm) {//
	var flag = 'Y';
	var vars = [];
	$("#EditProductType").find("input[type=checkbox][name='textfield2']").each(function(){
		for (var i = 0 ; i < vars.length; i++) {
			if(vars[i] == this.value){
				flag = 'N';
				alert("属性分组名称 '"+ vars[i]+ "' 重复！");
			}
		}
		vars.push(this.value);
	});
	if(flag == "Y"){
		submitFormsSimple(currentForm);
	}else{
		return false;
	}
}
</script>
<div class="pageContent" id="pageContent">
	<div class="screenlet-body" id="screenlet-body">
<form id="EditProductType" name="EditProductType" action="<@ofbizUrl><#if entity?has_content>updateProductType<#else>createProductType</#if></@ofbizUrl>" method="post" style="margin:0;padding:0">
<#if entity?has_content><input type="hidden" name="productCategoryId" id="productTypeId" value="${entity.productCategoryId?if_exists}"/></#if>	
<input type="hidden" name="navTabId" value="FindProductType"/>
<input type="hidden" name="callbackType" value="closeCurrent"/>		 
<input type="hidden" name="prodCatalogId" value="ProductType"/>	
<input type="hidden" name="prodCatalogCategoryTypeId" value="PCCT_SEARCH"/>	 
		  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="basic-table">
  			<#--tr>
    			<td colspan="2"><#if entity??||productCategoryId??>编辑商品类型<#else>添加商品类型</#if></td>
   			</tr-->
  			<tr class="background_tr">
  			  <td height="28" class="label">商品类型名称：</td>
  			  <td ><input name="description" id="description" class="required"  value="<#if entity?has_content>${entity.categoryName?if_exists}</#if>"/>  			    </td>
		    </tr>
  			<#--<tr>
  			  <td height="28" class="label">属性分组：</td>
  			  <td  id="grouptd">
  			    <#--<input type="button" name="button" id="button" value="添加一个属性分组" onclick="addPNode();" />-- >
  			    <#if allTypeAttributeGroupList??&&allTypeAttributeGroupList?size gt 0>
	  			    <#list allTypeAttributeGroupList as typeAttributeGroup>
		  			    <#--<p class="up_05">
		  			      <input type="text" name="textfield2" id="textfield2" class="input200" onchange="changeText(this)" value="${typeAttributeGroup.attributeGroupName!}"/><input type="hidden" name="attributeGroupName" id="attributeGroupName" class="input200" value="${typeAttributeGroup.attributeGroupId!},${typeAttributeGroup.attributeGroupName!}"/><img src="/images/delete.gif" width="16" height="16" onclick="deletePNode(this)"/>
		  			    </p>-- >
		  			    <input type="checkbox" name="attributeGroupId" <#if choseTypeAttributeGroupList?? && choseTypeAttributeGroupList?contains(typeAttributeGroup.attributeGroupId)>checked</#if> value="${typeAttributeGroup.attributeGroupId!}">${typeAttributeGroup.attributeGroupName!} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  			    </#list>
  			    </#if>
  			    
               </td>
		    </tr>-->
  			<tr class="background_tr">
  			  <td height="28" class="label">关联品牌：</td>
  			  <td >
  			  	<#if productBrandList?? && productBrandList?size gt 0>
	  			  	<#list productBrandList as brand>
		  			  	<#if productTypeAndBrandList?? && productTypeAndBrandList?size gt 0>
		  			  		<#list productTypeAndBrandList as typeBrand>
			  			  		<#if typeBrand.productBrandId==brand.id>
			  			  			<#assign n=1> 
							     </#if>
		  			  		</#list>
		  			  		<#if n??&&n = 1>
		  			  			<label>
					  			    <input type="checkbox" name="brandsId" id="checkbox" checked="checked"   value="${brand.id!}" />
								</label>
							     	${brand.brandName!}
							     <#assign n=0> 	
							 <#else>
							 	 <label>
			  			    		<input type="checkbox" name="brandsId" id="checkbox" value="${brand.id!}" />
						    	</label>
					     			 ${brand.brandName!}
					     		  <#assign n=0> 		    	
		  			  		</#if>
		  			  	<#else>
			  			  	<label>
			  			    	<input type="checkbox" name="brandsId" id="checkbox" value="${brand.id!}" />
						    </label>
					     		 ${brand.brandName!}
				     	</#if>	 
			     	</#list>	 
		     	</#if>	 
		      	</td>
		  </tr>
		</table>
</form>  
<div class="col-md-offset-3 col-md-9">
                        <button class="btn btn-info" type="submit" name="submitButton">保存</button>
                        &nbsp; &nbsp; &nbsp;
                        <a href="/portal/control/brandmanage" <button="" class="btn" type="button">取消
                        </a>
            </div>           		
</div>

<!-- 分组节点副本start -->
	<p class="up_05" id = "group" style="display: none;">
      <input type="text" name="textfield2" id="textfield2" class="input200" onchange="changeText(this);"/><input type="hidden" name="attributeGroupName" id="attributeGroupName" class="input200" /><img src="/images/delete.gif" width="16" height="16" onclick="deletePNode(this)"/>
    </p>
    <!-- 分组节点副本end -->