<script>
<!--
function resetAdType(){
	var advertiseTypeId = $('#advertiseTypeId').val();
	//alert(advertiseTypeId);
	if(advertiseTypeId != ''){
		var adId = $('#adId').val();
		var url = "<@ofbizUrl>LoadAdvertiseBody</@ofbizUrl>";
		var param = {'advertiseTypeId': advertiseTypeId, 'adId': adId};
		$('#ad_content${nowlong}').empty();
		$.post(url,param,function(data){
			$('#ad_content${nowlong}').html(data);
			
			//$('#ad_content${nowlong}').initUI();
		}, 'html');
	}
}

function uplodifyInit(id,item){
	$("#"+id).uploadify({
	    'uploader':'/sysCommon/images/uploadify/scripts/uploadify.swf',
		'cancelImg':'/sysCommon/images/uploadify/cancel.png',
		'script':'<@ofbizUrl>uploadProductImage</@ofbizUrl>?imgFor=item'+item,
	    'folder': '',
	    'queueID': 'fileQueue',
	    'auto': true,
	    'multi': true,
	    'onComplete': function(event,queueId,fileObj,response,data){
		    	uploadImgComplete(event,queueId,fileObj,response,data);
		    },
		'fileQueue': 'fileQueue',
		'fileExt': '*.jpg;*.jpeg;*.gif;*.png;',
		'fileDesc': '*.jpg;*.jpeg;*.gif;*.png;'
	});
}

function uploadImgComplete(event, queueId, fileObj, response, data){
	
	var filePath = jQuery.parseJSON(response).filePath;
	
	var imgFor   = jQuery.parseJSON(response).imgFor;
	var domObj;
	if(event.srcElement){
		domObj = event.srcElement;
	}else{
		domObj = event.target;
	}
	var DOId = domObj.id;
	var imgId = DOId.substring(2);
	var urlId = "url"+DOId.substring(5);
	document.getElementById(urlId).value=filePath;
	document.getElementById(imgId).src=filePath;
	//$('img.item1').attr('src', filePath);
	//$('input.item1').val(filePath);
}

$(function(){
	<#if entity?? && entity.advertiseTypeId??>
		resetAdType();
	</#if>
});
function preSubmitForm(){
	if(!$("#adName").val()){
		alert("请填写广告名称");
		return FALSE;
	}
	var data = [];
	var flag = 0;
	var pos = "";
	$('#ad_content${nowlong} table').each(function(i,obj){
		var item = [];
		if($(obj).css('display') == 'none'){
			return false;
		}
		//alert($('input[name="imgTitle"]', $(obj)).val());
		//alert($('input[name="href"]', $(obj)).val());
		//alert($('input[name="orderNum"]', $(obj)).val());
		//alert($('input[name="status"]', $(obj)).val());
		if($('input[name="imgTitle"]', $(obj)).val()==""){
			flag=1;
			if(pos==""){
				pos+=(i+1);
			}else{
				pos+="、"+(i+1);
			}
		}
		//alert(flag);
		item.push($('input[name="imgTitle"]', $(obj)).val());
		item.push($('input[name="imgUrl"]', $(obj)).val());
		if($('input[name="href"]', $(obj)).val()!=""){
			item.push($('input[name="href"]', $(obj)).val());
		}else{
			item.push("#");
		}
		if($('input[name="orderNum"]', $(obj)).val()!=""){
			item.push($('input[name="orderNum"]', $(obj)).val());
		}else{
			item.push("0");
		}
		item.push($('input[name="advertiseImgId"]', $(obj)).val());
		if($('input[name="status"]', $(obj)).val()!=""){
			item.push($('input[name="status"]', $(obj)).val());
		}else{
			item.push("0");
		}
		data.push(item.join('@PROP@'));
		
	});
	if(flag==1){
		alert("请填写第"+pos+"张图片标题！");
		return false;
	}
	$('input[name="imgsInfo"]').val(data.join('@ITEM@'));
	//alert($('input[name="imgsInfo"]').val());
	//alert($('input[name="imgsInfo"]').val());
	//return false;
	//return iframeCallback(f, navTabAjaxDone);
	$("#EditAdverse").submit();
}
//-->
</script>
<@htmlTemplate.navTitle titleProperty/>
<div class="pageContent" id="pageContent">
	<div class="screenlet-body" id="screenlet-body">
		<form action="<#if entity??>updateAdvertise<#else>createAdvertise</#if>" id="EditAdverse" method="post" 
	 	enctype="multipart/form-data" class="single_editor">
			<input type="hidden" name="imgsInfo"/>
			<input type="hidden" name="statusId" id="EditCmsArticle_statusId"  value='<#if entity??>${entity.statusId!}<#else>1</#if>'/>
			<table class="basic-table" cellspacing="0">
			    <tr class='background_tr' style="display:none">
				    <td class='border03' ><span id="EditCmsArticle_adId">${uiLabelMap.AdId}</span>    </td>
				    <td class='border02'><input type="text" id="adId" name="adId" class="required"   size="30"     maxlength="20"  value='<#if entity??>${entity.adId}</#if>'              autocomplete="off"/> </td>
			    </tr>
			    <tr class='background_tr'>
				    <td class='border03' ><span id="EditCmsArticle_title_title">名称</span>    </td>
				    <td class='border02'><input type="text" name="adName" id="adName" class="required" size="30"     maxlength="255"  value='<#if entity??>${entity.adName}</#if>'              autocomplete="off"/> </td>
			    </tr>
			    <tr class='background_tr'>
				    <td class='border03' ><span id="EditCmsArticle_ad_type">类型</span>    </td>
				    <td class='border02'>
				    	<select id="advertiseTypeId" name="advertiseTypeId" onchange="resetAdType()">
				    		<option value="">请选择</option>
				    		<#if adTypes?? >
				    			<#list adTypes as t>
				    				<option value="${t.advertiseTypeId}" <#if entity?? && (entity.advertiseTypeId == t.advertiseTypeId)>selected="selected"</#if> >${t.advertiseTypeName}</option>
				    			</#list>
				    		</#if>
				    	</select> 
				    </td>
			    </tr>
		    </table>	
	    <div id="ad_content${nowlong}">
	    </form>	
    </div>
 	<#--<@htmlTemplate.submitButton formId="EditAdverse"  dialogId="${parameters.dialogId!}" submitJs="${submitJs!}" oper="${parameters.oper!}" backHref="${parameters.backHref!}"/>-->
 	<div class="buttonBarOuter">
		<div class="buttonBar" id="toolBar">
			<a onclick="preSubmitForm()" class="l-btn">
				<span class="l-btn-left">
					<span class="l-btn-text icon-save l-btn-icon-left">
						保存
					</span>
				</span>
			</a>
			<a href="javascript:void(0);" onclick="javascript:window.history.back();" class="l-btn">
				<span class="l-btn-left">
					<span class="l-btn-text icon-no l-btn-icon-left">
						返回
					</span>
				</span>
			</a>
		</div>
	</div>
	 
</div>	
