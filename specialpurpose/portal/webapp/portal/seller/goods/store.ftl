   <script src="../product/js/jquery.js" type="text/javascript"></script>
   <script src="/portal/seller/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<#assign actionUrlStr="createProductStore">
<#if productStore?has_content>
    <#assign actionUrlStr="updateProductStore">
</#if>
<div class="content profile">
            <h2 class="title" style='font-size:20px'>基本信息</h2>
    <form method="post" action="<@ofbizUrl>${actionUrlStr}</@ofbizUrl>" id="EditProductStore"
          name="EditProductStore" novalidate="novalidate">
        <input type="hidden" name="productStoreId" id="EditProductStore_productStoreId"
               value="${(productStore.productStoreId)!}">
        <input type="hidden" name="oldStyleSheet" id="EditProductStore_oldStyleSheet"
               value="${(productStore.oldStyleSheet)!}">
        <input type="hidden" name="oldHeaderLogo" id="EditProductStore_oldHeaderLogo"
               value="${(productStore.oldHeaderLogo)!}">
        <input type="hidden" name="oldHeaderMiddleBackground" id="EditProductStore_oldHeaderMiddleBackground"
               value="${(productStore.oldHeaderMiddleBackground)!}">
        <input type="hidden" name="oldHeaderRightBackground" id="EditProductStore_oldHeaderRightBackground"
               value="${(productStore.oldHeaderRightBackground)!}">
	    <input type="hidden" name="defaultCurrencyUomId"  value="USD">
	    <input type="hidden" name="defaultLocaleString"  value="en_US">
	    <input type="hidden" name="reserveOrderEnumId"  value="INVRO_FIFO_REC">
	    <input type="hidden" name="balanceResOnOrderCreation"  value="Y">
	    <input type="hidden" name="checkInventory"  value="N">
	    <input type="hidden" name="reserveInventory"  value="Y">
        <div class="screenlet-body">
            <table class="basic-table">
                <tbody>
                <tr>
                    <td class="label">商铺名称：</td>
                    <td><input id="js-shopName" name="storeName" value="${(productStore.storeName)!}" type="text"
                               size="60"></td>
                </tr>
             
                <tr>
                    <td class="label"> 公司名称：</td>
                    <td>
                        <input name="companyName" maxLength="140" value="${(productStore.companyName)!}"
                               size="60"
                               type="text"></td>
                </tr>
               
               
                <tr>
                    <td class="label">注册地址：</td>
                    <td>
                        <input name="registeredAddress" maxLength="150" size="60"
                               value="${(productStore.registeredAddress)!}" type="text">
                    </td>
                </tr>
                
                <tr class="tr-normal">
                                    <td class="col1">银行账号<span class="required">*</span></td>

                                    <td class="col2"><input class="text" type="text" name="bankCode" id="bankCode" value="${(productStore.bankCode)!}"></td>

                                  
                                </tr>
                                
                                <tr class="tr-normal">
                                    <td class="col1">开户行<span class="required">*</span></td>

                                    <td class="col2">
                                    <#if bankList?has_content>
                                    	<select name="bankId" style="width:196px;" id="bankId">
                                    		<#list bankList as item>
                                    			<option value="${(item.baseId)!}">${(item.bankName)!}</option>
                                    		</#list>
                                    	</select>
                                    </#if>
                                    </td>

                                   
                                </tr>
                                <tr class="tr-normal">
                                    <td class="col1">银行收款人<span class="required">*</span></td>

                                    <td class="col2"><input class="text" type="text" name="bankUserName" id="bankUserName"  value="${(productStore.bankUserName)!}"></td>

                                  
                                </tr>
                                <tr class="tr-normal">
                                    <td class="col1">开户行所在地<span class="required">*</span></td>

                                    <td class="col2"><input class="text" type="text" name="bankAddress" id="bankAddress" value="${(productStore.bankAddress)!}"></td>

                                   
                                </tr>
                                
                                
                                <tr class="tr-normal">
                                    <td class="col1">开户行所在省份<span class="required">*</span></td>
                                    <td class="col2">
	                                    <select id="bankProvince" name="bankProvince"  onchange="getArea(this,'ajaxAreaCommon','bankCity',null);" style="width: 274">
	                                    	<#assign stateAssocs = Static["org.extErp.sysCommon.party.CommonWorkers"].getAssociatedStateList(delegator,'CHN')>
											<#list stateAssocs as stateAssoc>
											    <option value='${stateAssoc.geoId}' <#if entity?has_content &&entity.bankProvince?has_content&&stateAssoc.geoId==entity.bankProvince>selected</#if> >${stateAssoc.geoName?default(stateAssoc.geoId)}</option>
											</#list>
	                                    </select>
                                    </td>

                                  
                                </tr>
								<tr class="tr-normal">
                                    <td class="col1">开户行所在城市<span class="required">*</span></td>
                                    <td class="col2">
	                                    <select id="bankCity" name="bankCity" style="width: 274"></select>
                                    </td>

                                  
                                </tr>
            </table>
        </div>
    
    <div class="screenlet-title-bar">
        <h3>图片信息</h3>
    </div>
    <div class="screenlet-body">
        <table>
            <tr>
                <td class="label">商铺LOGO：</td>
                <td>
                	<input name="productStoreLogo" id="productStoreLogo" type="hidden" value="<#if productStore??>${productStore.productStoreLogo!}</#if>" >
                        <input type="file" size="50"   onchange="fileImport('productStoreLogoFile')"  name="productStoreLogoFile" id="productStoreLogoFile" style="float:left;"/>
                        <#if (productStore.productStoreLogo)?exists>
                            <br>
                            <a href="<@ofbizContentUrl>${(productStore.productStoreLogo)?if_exists}</@ofbizContentUrl>"
                               target="_blank"><img alt="Category Image" width="200px" height="200px"
                                                    src="<@ofbizContentUrl>${(productStore.productStoreLogo)?if_exists}</@ofbizContentUrl>"
                                                    class="cssImgSmall"/></a>
                        </#if>
                </td>
            </tr>
            <tr>
                <td class="label">商铺横幅：</td>
                <td>
                		<input name="productStoreBanner" id="productStoreBanner" type="hidden" value="<#if productStore??>${productStore.productStoreBanner!}</#if>" >
                        <input type="file" size="50"  onchange="fileImport('productStoreBannerFile')" name="productStoreBannerFile" id="productStoreBannerFile"  style="float:left;"/>
                        <#if (productStore.productStoreBanner)?exists>
                            <br>
                            <a href="<@ofbizContentUrl>${(productStore.productStoreBanner)?if_exists}</@ofbizContentUrl>"
                               target="_blank"><img alt="Category Image"  width="880px" height="176px"
                                                    src="<@ofbizContentUrl>${(productStore.productStoreBanner)?if_exists}</@ofbizContentUrl>"
                                                    class="cssImgSmall"/></a>
                        </#if>
                </td>
            </tr>
            <iframe name="fileName_iframe" style="display:none"></iframe>
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

<script type="text/javascript">
    $('.date-picker').datepicker({
        autoclose: true,
        todayHighlight: true
    })
    
    
  function fileImport(fileId){
	var fileValue = $("#"+fileId).val();
	if(fileValue!=''){
		var flag = true;
		var extName = fileValue.substring(fileValue.lastIndexOf(".")+1,fileValue.length);
		if(extName !="jpg" && extName !="png"){
			flag = false;
		}	
		if(flag){
			$("#EditProductStore").attr("enctype","multipart/form-data");
			$("#EditProductStore").attr("encoding","multipart/form-data");
			$("#EditProductStore").attr("target","fileName_iframe");
			$("#EditProductStore").attr("action","commonAjaxFileUploadProduct?fileId="+fileId);
			$("#EditProductStore").submit();
		}else{
			alert("格式不正确，请上传图片文件，扩展名为.jpg或者.png");
		}
	}else{
		alert("请选择文件");
	}
}

function fileImport_callBack(filePath,fileName,fileId){
    var action='<@ofbizUrl>${actionUrlStr}</@ofbizUrl>';
	$("#EditProductStore").attr("enctype","application/x-www-form-urlencoded");
	$("#EditProductStore").attr("encoding","application/x-www-form-urlencoded");
	$("#EditProductStore").attr("target","");
	$("#EditProductStore").attr("action",action);
	if(fileId=='productStoreLogoFile'){
		$("#productStoreLogoFile").attr("src",filePath);
		$("#productStoreLogo").val(filePath);
	}
	if(fileId=='productStoreBannerFile'){alert(fileId+filePath);
		$("#productStoreBannerFile").attr("src",filePath);
		$("#productStoreBanner").val(filePath);
	}
}

</script>
