   <script src="../product/js/jquery.js" type="text/javascript"></script>
   <script src="/portal/seller/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
   <#-- 
  <script type="text/javascript">
	function searchGeo(obj,num){
        geoId=jQuery("#"+obj+"  option:selected").val();
        var htmls=""
		if(geoId!="" && geoId!=null){
			jQuery.ajax({
            	url: 'search_geo_reg',
            	async: false,
            	type: 'POST',
            	data: "geoId="+geoId,
            	success: function(data) {
            		if(data.length>0){
            			objs=eval('('+data+')');
                        if(num==2){
                            for(var p in objs){
                                htmls=htmls+"<option value="+objs[p].geoId+">"+objs[p].geoName+"</option>";
                            }
                        }
                        if(num==3){
                            htmls = "<table><tr>"
                            var i=0;
            			    for(var p in objs){
            					htmls += "<td><input name='chinaCountys' type='checkbox' value="+objs[p].geoId+" >"+objs[p].geoName+" </input><br/></td>";
                                if(i%5==4){
                                    htmls += "</tr><tr>"
                                }
                                i++;
            				}
                            htmls +="</tr></table>";
            			}
            			if(num==2){
            				$("#city").html("<option value=''> 请选择市</option>"+htmls);
            				$("#county2").html("");
            			}
            			if(num==3){
            				$("#county2").html("<label>请选择小区：</label><br/>"+htmls);
            			}
            		}else{
            			if(num==2){
            				$("#city").html("<option value=''> 请选择市</option>");
            				$("#county2").html("");
            			}
            			if(num==3){
            				$("#county2").html("");
            			}
            		}

            	}
        	});
		}
		

	}
  </script>
  -->
<#assign actionUrlStr="createProductStore">
<#if productStore?has_content>
    <#assign actionUrlStr="updateProductStore">
</#if>
<div class="screenlet">
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
        <div class="screenlet-title-bar">
            <h3>基本信息</h3>
        </div>
        <div class="screenlet-body">
            <table class="basic-table">
                <tbody>
                <tr>
                    <td class="label">商铺名称：</td>
                    <td><input id="js-shopName" name="storeName" value="${(productStore.storeName)!}" type="text"
                               size="60"></td>
                </tr>
                <tr>
                    <td class="label">标题：</td>
                    <td><input type="text" name="title" value="${(productStore.title)!}"/ size="60"></td>
                </tr>

                <tr>
                    <td class="label">主营业务：</td>
                    <td><textarea type="text" name="subtitle" id="subtitle" rows="2"
                                  cols="60">${(productStore.subtitle)!}</textarea></td>
                </tr>
                <tr>
                    <td class="label"> 公司名称：</td>
                    <td>
                        <input name="companyName" maxLength="140" value="${(productStore.companyName)!}"
                               size="60"
                               type="text"></td>
                </tr>
                <tr>
                    <td class="label">商业类型：</td>
                    <td>
                        <input name="businessType" maxLength="50" value="${(productStore.businessType)!}"
                               size="60"
                               type="text">
                    </td>
                </tr>
                <tr>
                    <td class="label">创建时间：</td>
                    <td>
                        <input id="id-date-picker-1" type="text" name="createTime" size="60"
                               data-date-format="yyyy-mm-dd"
                               onClick="WdatePicker()"
                               value="${(productStore.createTime)!}">
                    </td>
                </tr>
                <tr>
                    <td class="label">注册地址：</td>
                    <td>
                        <input name="registeredAddress" maxLength="150" size="60"
                               value="${(productStore.registeredAddress)!}" type="text">
                    </td>
                </tr>
                <tr>
                    <td class="label">公司规模：</td>
                    <td>
                        <input name="scaleCompany" maxLength="7" value="${(productStore.scaleCompany)!}"
                               size="60"
                               type="text">
                    </td>
                </tr>
                <#-- 
                <tr>
                    <td class="label"> 服务区域：</th>
                    <td style="width:300px;">
                        <select name="geo_china" id="province" style="height:35px; width:190px; border:1px solid #ccc;" onchange="searchGeo(this.id,2);">
                            <option value=""> 请选择省</option>
                            <#if geoList?has_content>
                            	<#list geoList as geo>
                            		<#if geoFirst?has_content && geo.geoId == geoFirst.geoId>
                            			<option value="${geo.geoId!}" selected="selected">${geo.geoName!}</option>
                            		<#else>
                            			<option value="${geo.geoId!}">${geo.geoName!}</option>
                            		</#if>
                            	</#list>
                            </#if>
                        </select>
                        <select name="productStoreCity" id="city" style="height:35px; width:200px; border:1px solid #ccc;" onchange="searchGeo(this.id,3);">
                            <option value=""> 请选择市</option>
                            <#if geoSecond?has_content>
								<option value="${geoSecond.geoId!}" selected="selected">${geoSecond.geoName!}</option>
                            </#if>
                        </select>
                    </td>
                </tr>
                -->
                <#if geoStatus>
                <#if geoProvinceList?has_content>
                	<tr>
                    	<td class="label">已选省(直辖市)：</td>
                    	<td>
                    		<div>
                    		
                    			<label>已选择区域：</label><br/>
                    			<#list geoProvinceList as geo2>
                    				<input name="chinaCountys" type="checkbox" value="${geo2.geoId!}" checked="checked" disabled="disabled">${geo2.geoName!} </input><br/>
								</#list>
                           
                    		</div>
                    	</td>
                	</tr>
                </#if>
                <#if geoCityList?has_content>
                	<tr>
                    	<td class="label">已选市(县)：</td>
                    	<td>
                    		<div>
                    		
                    			<label>已选择区域：</label><br/>
                    			<#list geoCityList as geo2>
                    				<input name="chinaCountys" type="checkbox" value="${geo2.geoId!}" checked="checked" disabled="disabled">${geo2.geoName!} </input><br/>
								</#list>
                            
                    		</div>
                    	</td>
                	</tr>
                </#if>
                <#if geoCountyList?has_content>
                	<tr>
                    	<td class="label">已选小区：</td>
                    	<td>
                    		<div>
                    			<label>已选择区域：</label><br/>
                    			<#list geoCountyList as geo2>
                    				<input name="chinaCountys" type="checkbox" value="${geo2.geoId!}" checked="checked" disabled="disabled">${geo2.geoName!} </input><br/>
								</#list>
                    		</div>
                    	</td>
                	</tr>
                </#if>
                </#if>
               
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
