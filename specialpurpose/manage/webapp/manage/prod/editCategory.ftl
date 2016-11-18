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
<script language="JavaScript" type="text/javascript">
$(document).ready(function(){
    $("#productCategoryForm").validate({
	  	rules: {
		    description: {
		      required: false,
		      rangelength: [0, 120]
		    }
	  	},
	  	submitHandler: function(form) {
            submitCategoryForm();
        }
	});
});
var productCategoryForm = document.productCategoryForm;
function submitCategoryForm() {
    jQuery.ajax({
        url: productCategoryForm.action,
        type: "POST",
        data: jQuery("#productCategoryForm").serialize(),
        error: function(msg) {
                showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
        },
        success: function(msg) {
            jQuery('#miniproductlist').html(msg);
			jQuery("#tree").jstree("refresh");
        }
    });
}
function onSubmitFormsSimple(currentForm) {
	productCategoryId= document.getElementById('productCategoryId').value;
	categoryName= document.getElementById('categoryName').value;
	if(categoryName == "")
		return false;
	jQuery.getJSON("checkCategoryName", {
		productCategoryId:productCategoryId,categoryName:categoryName
	}, function(json) {
		if (json && json.result != null && json.result != 'undefined') {
			var result = (json.result != null) ? json.result : null;
			if(result == "success"){
				submitFormsSimple(currentForm);
			}
		} 
	});
	
}
function checksubmitCategoryName() {
	
}
function checkCategoryName() {
	productCategoryId= document.getElementById('productCategoryId').value;
	categoryName= document.getElementById('categoryName').value;
	if(categoryName == "")
		return false;
	jQuery.getJSON("checkCategoryName", {
		productCategoryId:productCategoryId,categoryName:categoryName
	}, function(json) {
		if (json && json.result != null && json.result != 'undefined') {
			var result = (json.result != null) ? json.result : null;
			if(result == "error"){
				alert("分类名称重复！");
				$("#categoryName").val("");
				return false;
			}
		} 
	});
}
</script>
<div class="pageContent" id="pageContent">
	<div class="screenlet-body" id="screenlet-body">
<#if ! entity?has_content>
    <#if productCategoryId?has_content>
            <form action="<@ofbizUrl>createProductCategory</@ofbizUrl>" method="post" style="margin: 0;" name="productCategoryForm" id="productCategoryForm" onsubmit="javascript:return checkCategoryName()" >
                <table cellspacing="0" class="basic-table">
                    <tr class="background_tr">
                        <td align="right" class="label"></td>
                        <td>&nbsp;</td>
                        <td>
                            <input type="hidden" name="productCategoryId" id="productCategoryId" size="20" maxlength="40" value="${productCategoryId}"/>
                        </td>
                    </tr>
    <#else>
            <form action="<@ofbizUrl>createProductCategoryTree</@ofbizUrl>" method="post" style="margin: 0;" name="productCategoryForm" id="productCategoryForm" onsubmit="javascript:return checkCategoryName()">
                <table cellspacing="0" class="basic-table">
                    <#--tr>
                        <td align="right" class="label">${uiLabelMap.ProductProductCategoryId}</td>
                        <td>&nbsp;</td>
                        <td>
                            <input type="hidden" name="productCategoryId" size="20" maxlength="40" value=""/>
                        </td>
                    </tr-->
                    <input type="hidden" name="productCategoryId"  id="productCategoryId" size="20" maxlength="40" value=""/>
    </#if>
<#else>
        <form action="<@ofbizUrl>updateProductCategory</@ofbizUrl>" method="post" style="margin: 0;" name="productCategoryForm" id="productCategoryForm" onsubmit="javascript:return checkCategoryName()">
            <input type="hidden" name="productCategoryId" id="productCategoryId" value="${productCategoryId}"/>
            <input type="hidden" name="navTabId" value="FindCategory"/>
			            <input type="hidden" name="prodCatalogId" value="ProductCategory"/>
			            <input type="hidden" name="prodCatalogCategoryTypeId" value="PCCT_OTHER_SEARCH"/>
			            <input type="hidden" name="productCategoryTypeId" value="CATALOG_CATEGORY"/>
			           
            <table cellspacing="0" class="basic-table">
</#if>
				 <input type="hidden" name="primaryParentCategoryId" value="${parameters.parentProductCategoryId!}"/>
				<#--
                <tr>
                    <td width="26%" align="right"  class="label">上级分类</td>
                    <td width="74%" >
			            
			            
                        <select name="primaryParentCategoryId" size="1">
                        <option value="">(无)新建顶级分类</option>
                        	<#assign selectedKey = "">
	                    	<#list productCategorys as productCategory>
                    			<#assign productCategoryGv = delegator.findByPrimaryKey("ProductCategory",Static["org.ofbiz.base.util.UtilMisc"].toMap("productCategoryId",productCategory.productCategoryId))?if_exists>
                        		<#if requestParameters.parentProductCategoryId?has_content>
                        			<#assign selectedKey = requestParameters.parentProductCategoryId>
                        		<#elseif (entity?has_content && entity.primaryParentCategoryId?if_exists == productCategory.productCategoryId)>
                        			<#assign selectedKey = entity.primaryParentCategoryId>
	                        	</#if>
                        		<option <#if selectedKey == productCategory.productCategoryId?if_exists>selected="selected"</#if> value="${productCategory.productCategoryId!}">${productCategoryGv.categoryName!}</option>
                        	</#list>
                        </select>
                       
                        
                    </td>
                </tr>
                 -->
                <#--tr class="background_tr">
                    <td width="26%" align="right"  class="label">${uiLabelMap.ProductProductCategoryType}</td>
                    <td width="74%" >
                        <select name="productCategoryTypeId" size="1">
                        	<#assign selectedKey = "">
	                    	<#list productCategoryTypes as productCategoryTypeData>
                        		<#if requestParameters.productCategoryTypeId?has_content>
                        			<#assign selectedKey = requestParameters.productCategoryTypeId>
                        		<#elseif (entity?has_content && entity.productCategoryTypeId?if_exists == productCategoryTypeData.productCategoryTypeId)>
                        			<#assign selectedKey = entity.productCategoryTypeId>
	                        	</#if>
                        		<option <#if selectedKey == productCategoryTypeData.productCategoryTypeId?if_exists>selected="selected"</#if> value="${productCategoryTypeData.productCategoryTypeId}">${productCategoryTypeData.get("description",locale)}</option>
                        	</#list>
                        </select>
                    </td>
                </tr-->
                <tr>
                    <td width="26%" align="right"  class="label">分类名称</td>
                    <td width="74%" ><input type="text" value="${(entity.categoryName)?if_exists}" name="categoryName" id="categoryName" size="60" maxlength="60" class="required" onchange="checkCategoryName();"/></td>
                </tr>
                <tr class="background_tr">
                    <td width="26%" align="right"  class="label">描述</td>
                    <td width="74%" ><textarea id="description" name="description" cols="60" rows="2"><#if entity?has_content>${(entity.description)?if_exists}</#if></textarea></td>
                </tr>
                <#assign sequenceNum = 1>
                <#if productCategoryId?has_content>
                	<#assign prodCatalogCategoryGvs = Static["org.ofbiz.entity.util.EntityUtil"].filterByDate(delegator.findByAnd("ProdCatalogCategory", {"productCategoryId",productCategoryId,"prodCatalogId" : "ProductCategory"})?if_exists)> 
                	<#if (prodCatalogCategoryGvs.size() >0)>
	                	<#assign gv = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(prodCatalogCategoryGvs)/>
	                	<#if gv.sequenceNum?has_content><#assign sequenceNum = gv.sequenceNum></#if>
                	</#if>
                </#if>
                <tr class="background_tr">
                    <td width="26%" align="right"  class="label">分类排序</td>
                    <td width="74%" ><input type="text" value="${sequenceNum?if_exists}" name="sequenceNum" id="sequenceNum"size="10" maxlength="10" class="required digits"/></td>
                </tr>
            </table>
            <div class="col-md-offset-3 col-md-9">
                        <button class="btn btn-info" type="submit" name="submitButton">保存</button>
                        &nbsp; &nbsp; &nbsp;
                        <a href="/portal/control/brandmanage" <button="" class="btn" type="button">取消
                        </a>
            </div>  
        </form>
    </div>
</div>
		