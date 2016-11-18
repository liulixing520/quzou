<script language="javascript"> 
function addPNode(){
	$('#group').clone().show().appendTo("#grouptd"); 
}
function deletePNode(t){
	var pn = t.parentNode;
	pn.parentNode.removeChild(pn);
}
function changeText(t){
	var v = $(t).val(),nextsib = $(t).next(),n=nextsib.val(),v1;
	if($.trim(n)){
		v1 = n.split(",")[0]+','+v;
		nextsib.val(v1);
	}else{
		v1=","+v;
	}
	nextsib.val(v1);
}
function checktype(){
	var inputTypes = document.getElementsByName('inputTypes'),inputType;
	var sele='<input type="radio" name="searchType" id="radio3" value="0" />渐进式筛选<input type="radio" name="searchType" id="radio4" value="1" checked="checked" />下拉筛选 <input type="radio" name="searchType" id="radio5" value="2"  />不可筛选 ';
	var notsele='<input type="radio" name="searchType" id="radio3" value="3" checked="checked"/>可进行搜索<input type="radio" name="searchType" id="radio4" value="4"  />不可进行搜索';
	for(var i = 0;i<inputTypes.length;i++){
		if(inputTypes[i].checked==true)
		 inputType=inputTypes[i].value;
	}
	if('select'!=inputType){
		$("#grouptd").children().filter(".up_05").remove();
		document.getElementById("addbutton").disabled=true;
		$('#issearch').html(notsele);		
	}else{
		document.getElementById("addbutton").disabled=false;
		$('#issearch').html(sele);
	}
}

function checktype2(){
	var inputTypes = document.getElementsByName('entryWay'),inputType;
	var sele='<input type="radio" name="searchType" id="radio3" value="0" />渐进式筛选<input type="radio" name="searchType" id="radio4" value="1" checked="checked" />下拉筛选 <input type="radio" name="searchType" id="radio5" value="2"  />不可筛选 ';
	var search1='<input type="radio" name="indexType" id="radio33" value="0" checked="checked"/>不搜索<input type="radio" name="indexType" id="radio34" value="1"  />关键字搜索<input type="radio" name="indexType" id="radio35" value="2"  />范围搜索';
	var search2='<input type="radio" name="indexType" id="radio33" value="0" checked="checked"/>不搜索<input type="radio" name="indexType" id="radio34" value="1"  />关键字搜索';
	for(var i = 0;i<inputTypes.length;i++){
		if(inputTypes[i].checked==true)
		 inputType=inputTypes[i].value;
	}
	if('TEXT'== inputType){
		$("#grouptd").children().filter(".up_05").remove();
		document.getElementById("addbutton").disabled=true;
		$('#issearch').html(sele);	
		$('#tdIndexType').html(search1);
	}else if('SELECT'==inputType){
		document.getElementById("addbutton").disabled=false;
		$('#issearch').html(sele);
		$('#tdIndexType').html(search2);
	}else if('TEXTAREA'==inputType){
		$("#grouptd").children().filter(".up_05").remove();
		document.getElementById("addbutton").disabled=true;
		$('#issearch').html(sele);	
		$('#tdIndexType').html("");		
		$('#tdIndexType').html(search2);
	}
}
//改变检索类型
function changeIndexType(){
	var indexTypes = $("input[name='indexType']"), indexType;
	for(var i=0; i<indexTypes.length; i++){
		if(indexTypes[i].checked==true){
			indexType = indexTypes[i].value;
			break;
		}
	}
	
    
	if(indexType=="2" && document.getElementById("radio12").checked && !document.getElementById("tdIndexDefine")){//范围搜索
	   var tdIndexType = document.getElementById('tdIndexType').parentNode;
       var table = tdIndexType.parentNode;
	   var newtr = tdIndexType.cloneNode(true);
	   tds = newtr.getElementsByTagName("td");
	   tds[0].innerHTML="检索区间";
	   tds[1].id = "tdIndexDefine";
	   tds[1].onclick="";
	   tds[1].innerHTML='<textarea rows="5" name="indexDefine"></textarea>';
	   table.appendChild(newtr);
	}else{
	    if(document.getElementById('tdIndexDefine')){
	    	var tr = document.getElementById('tdIndexDefine').parentNode;
	    	var table = tr.parentNode;
			table.removeChild(tr);
	    }
	    
	}
}
function disable(t){
	t.disabled=true;
}
</script>
<form id="EditProductTypeAttribute" name="EditProductTypeAttribute" action="<@ofbizUrl><#if entity?has_content>updateProductTypeAttr<#else>createProductTypeAttr</#if></@ofbizUrl>" method="post" style="margin:0;padding:0">
<#if entity?has_content>
	<input type="hidden" name="attributeId" id="attributeId" value="${entity.attributeId?if_exists}"/>
</#if>
<div class="pageContent" style="height:485px;overflow:auto;" layouth='35'>
	<div id="all_main" >
	  <!--主要内容-->
	    <div class="main_pag" id="list">
		  <div id="cont02">
		  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="basic-table">
  			<tr>
  			  <td height="28" class="label">属性名称：</td>
  			  <td ><input type="text" name="attributeName" id="textfield" maxlength="20" class="input200" value="<#if entity??>${entity.attributeName!}</#if>"/>
  			    <span class="reg">*</span><span  class="reg" id="namesError"></span></td>
		  </tr>
  		<#--	<tr>
  			  <td height="28" class="label">属性中文名称：</td>
  			  <td ><input type="text" name="attributeNameZh" id="textfield" maxlength="20" class="input200" value="<#if entity??>${entity.attributeNameZh!}</#if>"/>
  			    <span class="reg">*</span><span  class="reg" id="namesError"></span></td>
		  </tr>
  			<tr>
  			  <td height="28" class="label">属性俄文名称：</td>
  			  <td ><input type="text" name="attributeNameRu" id="textfield" maxlength="20" class="input200" value="<#if entity??>${entity.attributeNameRu!}</#if>"/>
  			    <span class="reg">*</span><span  class="reg" id="namesError"></span></td>
		  </tr>  -->
		  <tr id="background_tr" style='display:none'>
  			  <td height="28" class="label">商品分类：</td>
  			  <td ><label>
  			    <select name="productCategoryId" id="select">
  			        <!-- TODO:层级获取分类 -->
					<#assign productCategories = delegator.findByAnd("ProductCategory", {})> 
  			    	<#if productCategories?? && productCategories?size gt 0>
  			    		<#list productCategories as productCategory>
	    					<option value="${productCategory.productCategoryId!}" <#if entity?? && entity.productCategoryId??><#if entity.productCategoryId==productCategory.productCategoryId>selected="selected"</#if></#if><#if productCategoryId?? && productCategoryId==productCategory.productCategoryId >selected="selected"</#if>>${productCategory.categoryName!}</option>
  			    		</#list>
		    		</#if>
		        </select>
  			  </label></td>
		  </tr>
  			<#--
  			<tr id="background_tr">
  			  <td height="28" class="label">属性分组：</td>
  			  <td ><label>
  			    <#if productsTypeAttribGroups?? && productsTypeAttribGroups?size gt 0>
  			    <select name="attributeGroupId" id="select">
  			    		<option value="">请选择</option>
  			    		<#list productsTypeAttribGroups as productsTypeAttribGroup>
	    					<option value="${productsTypeAttribGroup.attributeGroupId!}" <#if entity?? && entity.attributeGroupId??><#if entity.attributeGroupId==productsTypeAttribGroup.attributeGroupId>selected="selected"</#if></#if>>${productsTypeAttribGroup.attributeGroupName!}</option>
  			    		</#list>
		        </select>
				<#else>
				无属性组
		        </#if>
  			  </label></td>
		  </tr>-->
  			<tr>
  			  <td class="label">属性值的录入方式：</td>
  			  <td  onclick="checktype2();"><input type="radio" name="entryWay" id="radio12" value="TEXT" <#if !entity??>checked="checked"</#if> <#if entity?? && entity.entryWay=='TEXT'>checked="checked"</#if>/>
  			    手工录入
  			    <input type="radio" name="entryWay" id="radio13" value="SELECT"  <#if entity?? && entity.entryWay=='SELECT'>checked="checked"</#if>/>
  			    从下面的列表中选择
  			    <input type="radio" name="entryWay" id="radio14" value="TEXTAREA" <#if entity?? && entity.entryWay=='TEXTAREA'>checked="checked"</#if>/>
  			    多行文本框 </td>
		  </tr>
  			<tr id="background_tr">
  			  <td class="label">可选值列表：</td>
  			  <td  id="grouptd">
  			  <#if  entity?? && entity.entryWay=='SELECT'>
  			  		<input type="button" name="button" id="addbutton" value="添加一个列表项" onclick="addPNode();" />
	  			   	<#if inputValuess??&&inputValuess?size gt 0>
		  			    <#list inputValuess as inputValue>
		  			    <p class="up_05">
		  			     英文: <input type="text" name="textfield2" id="textfield2" class="input200" onchange="changeText(this)" value="${inputValue.optionalName!}"/>
		  			      <input type="hidden" name="optionalNames" id="optionalNames" class="input200" value="${inputValue.optionalId!},${inputValue.optionalName!}"/>
		  			<#--     中文: <input type="text" name="textfield2" id="textfield2" class="input200" onchange="changeText(this)" value="${inputValue.optionalNameZh!}"/>
		  			      <input type="hidden" name="optionalNameZhs" id="optionalNameZhs" class="input200" value="${inputValue.optionalId!},${inputValue.optionalNameZh!}"/>
		  			     俄文: <input type="text" name="textfield2" id="textfield2" class="input200" onchange="changeText(this)" value="${inputValue.optionalNameRu!}"/>
		  			      <input type="hidden" name="optionalNameRus" id="optionalNameZhs" class="input200" value="${inputValue.optionalId!},${inputValue.optionalNameRu!}"/>
		  			    --> 
		  			      <img src="/portal/seller/images/delete.gif" width="16" height="16" onclick="deletePNode(this)"/>
		  			    </p>
		  			    </#list>
	  			    <#else>
		  			    <p class="up_05">
		  			        英文: <input type="text" name="textfield2" id="textfield2" class="input200" onchange="changeText(this)"/>
		  			      <input type="hidden" name="optionalNames" id="optionalNames" class="input200" value=""/>
		  			<#--     中文: <input type="text" name="textfield2" id="textfield2" class="input200" onchange="changeText(this)" value=""/>
		  			      <input type="hidden" name="optionalNameZhs" id="optionalNameZhs" class="input200" value=""/>
		  			     俄文: <input type="text" name="textfield2" id="textfield2" class="input200" onchange="changeText(this)" value=""/>
		  			      <input type="hidden" name="optionalNameRus" id="optionalNameZhs" class="input200" value=""/>
		  			      -->
		  			      <img src="/portal/seller/images/delete.gif" width="16" height="16" onclick="deletePNode(this)"/>
		  			    </p>
	  			    </#if>
  			   <#else> 
  			   		<input type="button"  disabled="disabled"  name="button" id="addbutton" value="添加一个列表项" onclick="addPNode();"/>
  			   </#if>
  			    
  			   </td>
		  </tr> 
		</table>
		</div>
	</div>
	<!--
	<@htmlTemplate.submitButton formId="${currentForm}"  dialogId="${parameters.dialogId!}" submitJs="${submitJs!}" oper="${parameters.oper!}" backHref="${parameters.backHref!}"/>
	-->
	<div class="col-md-offset-3 col-md-9">
                        <button class="btn btn-info" type="submit" name="submitButton">保存</button>
                        &nbsp; &nbsp; &nbsp;
                        <a href="/portal/control/FindTypeAttribute" <button="" class="btn" type="button">取消
                        </a>
                    </div>	
</div>
</div>
</form>  
<!-- 分组节点副本start -->
	<p class="up_05" id = "group" style="display: none;">
     英文: <input type="text" name="textfield2" id="textfield2" class="input200" onchange="changeText(this)"/>
      <input type="hidden" name="optionalNames" id="optionalNames" class="input200" value=""/>
<#--     中文: <input type="text" name="textfield2" id="textfield2" class="input200" onchange="changeText(this)" value=""/>
      <input type="hidden" name="optionalNameZhs" id="optionalNameZhs" class="input200" value=""/>
     俄文: <input type="text" name="textfield2" id="textfield2" class="input200" onchange="changeText(this)" value=""/>
      <input type="hidden" name="optionalNameRus" id="optionalNameZhs" class="input200" value=""/> -->
      <img src="/portal/seller/images/delete.gif" width="16" height="16" onclick="deletePNode(this)"/>
    </p>
    <!-- 分组节点副本end -->