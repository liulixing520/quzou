<div class="pageContent" id="pageContent">
	<div class="screenlet-body" id="screenlet-body">
	<form id="EditFeatureCategory" name="EditFeatureCategory" action="<@ofbizUrl><#if entity?has_content>UpdateFeatureCategory<#else>CreateFeatureCategory</#if></@ofbizUrl>" method="post" style="margin:0;padding:0">
	<#if entity?has_content><input type="hidden" name="productFeatureCategoryId" id="productFeatureCategoryId" value="${entity.productFeatureCategoryId?if_exists}"/></#if>	
	<input type="hidden" value="${productFeatureList.size()!0}" name="specValuesCount" id="specValuesCount">   
		<div id="all_main" >
		  <!--主要内容-->
		    <div class="main_pag" id="list">
			  <div id="cont02">
				<table class="basic-table" cellspacing="0">
		  			<tr >
		  			  <td  class="label">规格名称：</td>
		  			  <td >
		  			  	<input name="description" id="description"  value="<#if entity?has_content>${entity.description?if_exists}</#if>"/>  			    
				      </td>
				    </tr>
		  			<tr style='display:none'>
		  			  <td  class="label">规格中文名称：</td>
		  			  <td >
		  			  	<input name="descriptionZh" id="descriptionZh"  value="<#if entity?has_content>${entity.descriptionZh?if_exists}</#if>"/>  			    
				      </td>
				    </tr>
		  			<tr style='display:none'>
		  			  <td  class="label">规格俄文名称：</td>
		  			  <td >
		  			  	<input name="descriptionRu" id="descriptionRu"  value="<#if entity?has_content>${entity.descriptionRu?if_exists}</#if>"/>  			    
				      </td>
				    </tr>
				    <#-- 
				    <tr style='display:none'>
		  			  <td  class="label">类型选择：</td>
		  			  <td  >
		  			  <label>
						<select name="productCategoryId" id="productCategoryId">
						<option value="">请选择所属类型</option>
						<#assign productCategoryList = delegator.findByAnd("ProductCategory", {})> 
						<#if productCategoryList?has_content>
							<#list productCategoryList as categoryGv>
								<option value="${categoryGv.productCategoryId?if_exists}" <#if parameters.productCategoryId?has_content><#if parameters.productCategoryId == categoryGv.productCategoryId>selected=selected</#if></#if>>${categoryGv.categoryName?if_exists}</option>
							</#list>
						</#if>
						</select>		      
						</label> 
				      </td>
				    </tr>	
				    -->	  
				</table>
				<br/>
				<input type="button" onclick="addTableRow()" value="添加规格值" id="button3" class="botinput" name="button3">
				<br/>
				<br/>
				<table id="tableCont" cellspacing="0" class="table table-striped table-bordered table-hover dataTable no-footer">
		  			<tr class="header-row">
		  			  <td  >规格值名称</td>
		  			  <td  style='display:none'>规格值中文</td>
		  			  <td  style='display:none'>规格值俄文</td>
		  			  <!-- <td >规格图片</td> -->
		  			  <td   width="150px">操作</td>
				    </tr>
				    <#if productFeatureList?has_content>
					    <#list productFeatureList as productFeature>
					    	<tr  id="${productFeature_index}" class='background_tr'>
						    	<td >
						    		<input type='text' name='productFeature_description_${productFeature.productFeatureId?if_exists}' id='productFeature_description_${productFeature.productFeatureId?if_exists}'  class='required' value="${productFeature.description?if_exists}"/>
						    	</td>
						    	<td   style='display:none'>
						    		<input type='text' name='productFeature_descriptionZh_${productFeature.productFeatureId?if_exists}' id='productFeature_descriptionZh_${productFeature.productFeatureId?if_exists}'  class='required' value="${productFeature.descriptionZh?if_exists}"/>
						    	</td>
						    	<td   style='display:none'>
						    		<input type='text' name='productFeature_descriptionRu_${productFeature.productFeatureId?if_exists}' id='productFeature_descriptionRu_${productFeature.productFeatureId?if_exists}'  class='required' value="${productFeature.descriptionRu?if_exists}"/>
						    	</td>
						    	<#--
						    	<td width="200px">
						    		<select name="productFeature_type_${productFeature.productFeatureId?if_exists}" id="productFeature_type_${productFeature.productFeatureId?if_exists}" class="required">
									<option value="" >请选择所属类型</option>
										<#if productFeatureTypeList?has_content>
											<#list productFeatureTypeList as productFeatureType>
												<option value="${productFeatureType.productFeatureTypeId?if_exists}" <#if productFeature?has_content && productFeature.productFeatureTypeId?has_content><#if productFeature.productFeatureTypeId == productFeatureType.productFeatureTypeId>selected=selected</#if></#if>>${productFeatureType.get("description",locale)?if_exists}</option>
											</#list>
										</#if>
									</select>	
						    	</td>
						    	
			  			  		<td  >
			  			  		<input type="hidden" name="featureImg_${productFeature.productFeatureId?if_exists}"  id="featureImg_${productFeature.productFeatureId?if_exists}" size="25" value='<#if productFeature?? && productFeature.imageUrl??>${productFeature.imageUrl!}</#if>'/>
								
								<div id="imageDiv_${productFeature_index}"><#if productFeature?? && productFeature.imageUrl??><img onclick="preView(this);" id="featureImgSrc_${productFeature.productFeatureId?if_exists}_pre" src="${productFeature.imageUrl!}" style="width:40px; height:40px; cursor:pointer;"/></#if></div>
								<input  id="testFileInput_${productFeature_index}" name="image_${productFeature_index}" 
									type="file"
									uploader="/images/dwz/uploadify/scripts/uploadify.swf"
									cancelImg="/images/dwz/uploadify/cancel.png" 
									script="<@ofbizUrl>uploadProductFeatureImage?imgFor=${productFeature.productFeatureId?if_exists}</@ofbizUrl>" 
									folder=""
									fileDataName="file" 
									onComplete="myUplaodifyFeatureComplete"
									fileQueue="fileQueue"
									fileExt="*.jpg;*.jpeg;*.gif;*.png;"
									fileDesc="*.jpg;*.jpeg;*.gif;*.png;"/>
								&nbsp;&nbsp;&nbsp;<div id="delDiv_${productFeature.productFeatureId?if_exists}"><#if productFeature.imageUrl?has_content><a href="#" onclick="delImgII(${productFeature.productFeatureId?if_exists})">取消</a></#if></div>
			  			  		</td>	
			  			  		-->
			  			  		<td  width="150px"><input name='input2' type='button' class='input02' value='删除'onclick='deleteRow(event)' /></td>	
		  			  		</tr>
					    </#list>  
				    </#if>
				</table>
			</div>
		</div>
		
			<div class="col-md-offset-3 col-md-9">
                        <button class="btn btn-info" type="submit" name="submitButton">保存</button>
                        &nbsp; &nbsp; &nbsp;
                        <a href="/manage/control/FindProductFeatureCategory" <button="" class="btn" type="button">取消
                        </a>
            </div>            
	</form>  
</div>

<script language="javascript"> 
addTableRow =function(){
	var count=parseInt($("#specValuesCount").val());
	return function(){
		addRow(count);
		count++;
	}
}()
function addRow(id){
	var delete_btn = "<input name='input2' type='button' class='input02' value='删除'onclick='deleteRow(event)' />";
	var imageTd = "<input id='testFileInput_"+id+"' name='image_"+ id+"'"; 
								imageTd+=" type='file' uploader='/images/dwz/uploadify/scripts/uploadify.swf' cancelImg='/images/dwz/uploadify/cancel.png' ";
								imageTd+=" script='<@ofbizUrl>uploadProductFeatureImage?imgFor="+id+"</@ofbizUrl>' folder='' ";
								imageTd+=" fileDataName='file'";
								imageTd+=" onComplete='myUplaodifyFeatureComplete'";
								imageTd+=" fileQueue='fileQueue'";
								imageTd+=" fileExt='*.jpg;*.jpeg;*.gif;*.png;'";
								imageTd+=" fileDesc='*.jpg;*.jpeg;*.gif;*.png;'" + ">";
	//alert(imageTd);
	imageTd+=" <input type='hidden' name='featureImg_"+id+"'  id='featureImg_"+id+"'/>";
	var preImageTd=" <div id='imageDiv_"+id+"'/>";
	var delDiv=" <div id='delDiv_"+id+"'/>";
	var trStr ="<tr id="+id+" class='background_tr'><td  ><input type='text' name='productFeature_description_" + id + "' id='productFeature_description_ " + id + " ' class='required'/></td>";
	trStr+="<td  style='display:none'><input type='text' name='productFeature_descriptionZh_" + id + "' id='productFeature_descriptionZh_ " + id + " ' class='required'/></td>";
	trStr+="<td  style='display:none'><input type='text' name='productFeature_descriptionRu_" + id + "' id='productFeature_descriptionRu_ " + id + " ' class='required'/></td><td>"+delete_btn+"</td></tr>";
	$('#tableCont').append(trStr);
}
function deleteRow(event){
	var o =event.srcElement||event.target;
	var currRowIndex=o.parentNode.parentNode.rowIndex;
	document.getElementById("tableCont").deleteRow(currRowIndex);
}
function myUplaodifyFeatureComplete(event,queueId,fileObj,response,data){  
   var filePath = jQuery.parseJSON(response).filePath;
   var imgFor = jQuery.parseJSON(response).imgFor;
   $('#featureImg_'+imgFor).val(filePath);
   //$('#featureImg_'+imgFor+"_pre").val(filePath);
   var imageTd =" <img onclick='preView(this);' id='featureImgSrc_"+imgFor+"_pre's src="+filePath+" style='width:83px; height:65px; cursor:pointer;'/>";
   $('#imageDiv_'+imgFor).html(imageTd);
   var delDiv = "<a href='#' onclick='delImgII('"+imgFor+"')'>取消</a>";
   $('#delDiv_'+imgFor).html(delDiv);
   $('#featureImgSrc_'+imgFor+'_pre').attr('src', filePath);
}
var delImgII = function(id){
	$("#featureImg_"+id).val("");
	$("#featureImgSrc_"+id+"_pre").attr("src","");
}
function preView(obj){
	window.open(obj.src);
}
</script>