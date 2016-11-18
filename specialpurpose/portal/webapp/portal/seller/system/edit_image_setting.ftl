<link rel="stylesheet" href="/itea/images/itea/css/colorpicker.css" type="text/css" />
<link rel="stylesheet" media="screen" type="text/css" href="/itea/images/itea/css/layout.css" />
<script src="/itea/images/itea/js/colorpicker.js"></script>
<script type="text/javascript" src="/itea/images/itea/js/eye.js"></script>
<script type="text/javascript" src="/itea/images/itea/js/utils.js"></script>
<script type="text/javascript" src="/itea/images/itea/js/layout.js?ver=1.0.2"></script>
<script language="javascript"> 
	function uploadProductImageSettingComplete(event,queueId,fileObj,response,data){  
	   var filePath = jQuery.parseJSON(response).filePath;
	   var imageTypeId = jQuery.parseJSON(response).imageTypeId;
	   var imageTd =" <img onclick='preView(this);' id='imgSettingSrc_"+imageTypeId+"_pre's src="+filePath+" style='width:83px; height:65px; cursor:pointer;'/>";
	   $('#defaultImageUrl_'+imageTypeId).val(filePath);
	   $('#imageDiv_'+imageTypeId).html(imageTd);
	}
	function uploadProductImageWaterComplete(event,queueId,fileObj,response,data){  
	   var filePath = jQuery.parseJSON(response).filePath;
	   $('#watermarkImageUrl').val(filePath);
	   var imageTd =" <img onclick='preView(this);' id='imgWaterSrc's src="+filePath+" style='width:83px; height:65px; cursor:pointer;'/>";
	   $('#imageWaterDiv').html(imageTd);
	}
	function preView(obj){
		window.open(obj.src);
	}
	function changeWaterType(id1,id2){
		document.getElementById(id1).style.display = "none";
		document.getElementById(id2).style.display = "";
	}
	$('#fontShadowColor, #textFontColor').ColorPicker({
		onSubmit: function(hsb, hex, rgb, el) {
			$(el).val(hex);
			$(el).ColorPickerHide();
		},
		onBeforeShow: function () {
			$(this).ColorPickerSetColor(this.value);
		}
	})
	.bind('keyup', function(){
		$(this).ColorPickerSetColor(this.value);
	});
	
	// iframe方式编辑表单-提交、刷新处理
function submitImgSettingForm(formId) {
	
	jQuery.ajax({
		url : jQuery("#EditImageSetting").attr("action"),
		type : 'POST',
		data : jQuery("#EditImageSetting").serializeArray(),
		error : function(result) {
			alert('出错了！');
		},
		success : function(result) {
			if (result._ERROR_MESSAGE_LIST_) {
				alert(result._ERROR_MESSAGE_LIST_);
			} else {
				alert('保存成功!');
			}
		}
	});
}
</script> 
<div id="all_main"  class="pageContent">
	<form id="EditImageSetting" name="EditImageSetting" action="imageSettingDo" method="post" style="margin:0;padding:0" onsubmit="return iframeCallback(this, navTabAjaxDone)">
	 <#-- 图片设置 -->
	<#assign productStoreId = Static["org.ofbiz.product.store.ProductStoreWorker"].getProductStoreId(request) />
    <input type="hidden" name="productStoreId" value="${productStoreId?if_exists}"/>
    <input type="hidden" name="imageWaterTypeId" value="SPR_IMGTP_ALL"/>
    <input type="hidden" name="navTabId" value="EditImageSetting"/>
     <div layouth="56" class="pageFormContent" style="height: 460px; overflow: auto;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr class="title02">
	      <td height="30" colspan="9"  style=" border-left:none"><b>图片设置</b></td>
	    </tr>

		<#list imageSettingTypeList as imageSettingType>
			<tr <#if imageSettingType_index%2==0>class='background_tr'</#if>>
		    	<td class="border02 width15" width="65px">${imageSettingType.description?if_exists}<input type="hidden" name="imageTypeId_${imageSettingType.enumId?if_exists}" value="${imageSettingType.enumId?if_exists}"/></td>
				<td class="border02 width15" width="100px">
					高：<input name="height_${imageSettingType.enumId?if_exists}" type="text" class="input40 required digits" value='<#if imageSettingType.height?has_content>${imageSettingType.height?if_exists}<#else>40</#if>' size="8"/>
			    </td>
				<td class="border02 width15" width="100px">
			      	宽：<input name="width_${imageSettingType.enumId?if_exists}" type="text" class="input40 required digits" value='<#if imageSettingType.width?has_content>${imageSettingType.width?if_exists}<#else>40</#if>' size="8"/>
			   </td>
				<td class="border02 width15" width="170px">    	
			       	备注：<input  type="text" class="input100" name="comments_${imageSettingType.enumId?if_exists}" value='${imageSettingType.comments?if_exists}'/>
			    </td>
			    <td class="border02 width15" width="50px"> 
			    	缺省图：   
			        <span id="span_upload">
			        <input name="defaultImageUrl_${imageSettingType.enumId?if_exists}" id="defaultImageUrl_${imageSettingType.enumId?if_exists}" type="hidden" class="input100" value='${imageSettingType.defaultImageUrl?if_exists}' id="txt"/>
			        </span>
		      	</td>
			    <td class="border02 width85" width="50px">    
			        <div id="imageDiv_${imageSettingType.enumId?if_exists}"><#if imageSettingType?has_content && imageSettingType.defaultImageUrl?has_content><img onclick="preView(this);" id="imgSettingSrc_${imageSettingType.enumId?if_exists}_pre" src="${imageSettingType.defaultImageUrl!}" style="width:83px; height:65px; cursor:pointer;"/></#if></div>
		      	</td>
			    <td class="border02 width85" width="70px">    
					<input  id="testFileInput_${imageSettingType.enumId?if_exists}" name="image_${imageSettingType.enumId?if_exists}" 
					type="file"
					uploader="/images/dwz/uploadify/scripts/uploadify.swf"
					cancelImg="/images/dwz/uploadify/cancel.png" 
					script="<@ofbizUrl>uploadProductImageSetting?imageTypeId=${imageSettingType.enumId?if_exists}</@ofbizUrl>" 
					folder=""
					fileDataName="file" 
					onComplete="uploadProductImageSettingComplete"
					fileQueue="fileQueue"
					fileExt="*.jpg;*.jpeg;*.gif;*.png;"
					fileDesc="*.jpg;*.jpeg;*.gif;*.png;"/>
		      	</td>
		      	<td class="border02 width15" width="120px">压缩方式：
			        <select name="imageScaleTypeId_${imageSettingType.enumId?if_exists}">
			          <#list imageSettingSclTypeList as imageSettingSclType>
			      	  	<option <#if imageSettingType.imageScaleTypeId?has_content><#if imageSettingType.imageScaleTypeId == imageSettingSclType.enumId>selected=selected</#if></#if> value="${imageSettingSclType.enumId?if_exists}">${imageSettingSclType.description?if_exists}</option>
			      	  </#list>
			        </select>
		      	</td>
		      	<td class="border02 width15" width="70px">
			        <input type="checkbox" name="openWatermark_${imageSettingType.enumId?if_exists}" value="Y" <#if imageSettingType.openWatermark?has_content><#if imageSettingType.openWatermark == "Y">checked="checked"</#if></#if> />开启水印
		      	</td>
		    </tr>
	    </#list>
	</table>	
	<br/>  
	<#--    水印设置        -->
	
	<#assign watermarkBean = delegator.findByPrimaryKey("ProductStoreWatermarkSetting",Static["org.ofbiz.base.util.UtilMisc"].toMap("productStoreId",productStoreId,"imageTypeId","SPR_IMGTP_ALL"))?if_exists>      
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr class="title02">
	      <td height="30" colspan="8"  style="border-left:none"><b>水印设置</b></td>
	    </tr>
	    <tr class='background_tr'>
		  <td class="border03 width15">水印类型：</td>
		  <td class="border02 width85">
			  <input name="watermarkTypeId" type="radio" value="SPR_WMTYPE_TXT" onclick="changeWaterType('SPR_WMTYPE_PIC','SPR_WMTYPE_TXT')" checked/>
      		    文字水印
      		  <input name="watermarkTypeId" type="radio" value="SPR_WMTYPE_PIC" onclick="changeWaterType('SPR_WMTYPE_TXT','SPR_WMTYPE_PIC')" <#if watermarkBean?? && watermarkBean.watermarkTypeId?? && watermarkBean.watermarkTypeId=='SPR_WMTYPE_PIC'>checked</#if>/>
      		    图片水印
		  </td>
	    </tr>
	    <tbody <#if watermarkBean?has_content&&watermarkBean.watermarkTypeId?has_content&&watermarkBean.watermarkTypeId=='SPR_WMTYPE_TXT' || !watermarkBean?has_content>style="display:none"</#if> id="SPR_WMTYPE_PIC">
  			<tr>
  			  	<td class="label">水印图片：</td>
  			  	<td >
  			  		<div id="imageWaterDiv"><#if watermarkBean?? && watermarkBean.watermarkImageUrl??><img onclick="preView(this);" id="imgWaterSrc" src="${watermarkBean.watermarkImageUrl!}" style="width:83px; height:65px; cursor:pointer;"/></#if></div>
  			  		<input type="hidden" name="watermarkImageUrl" id="watermarkImageUrl" class="input150" value="<#if watermarkBean??&& watermarkBean.watermarkTypeId??&& watermarkBean.watermarkTypeId=='SPR_WMTYPE_PIC'>${watermarkBean.watermarkImageUrl!}</#if>"/>
              		<input  id="testFileInputs" name="images" 
					type="file"
					uploader="/images/dwz/uploadify/scripts/uploadify.swf"
					cancelImg="/images/dwz/uploadify/cancel.png" 
					script="<@ofbizUrl>uploadProductImageWater</@ofbizUrl>" 
					folder=""
					fileDataName="file" 
					onComplete="uploadProductImageWaterComplete"
					fileQueue="fileQueue"
					fileExt="*.jpg;*.jpeg;*.gif;*.png;"
					fileDesc="*.jpg;*.jpeg;*.gif;*.png;"/>
				</td>
	      	</tr>
          	</tbody>
          	<tbody  id="SPR_WMTYPE_TXT" <#if watermarkBean??&&watermarkBean.watermarkTypeId??&&watermarkBean.watermarkTypeId=='SPR_WMTYPE_PIC'>style="display:none"</#if>>
  			<tr>
  			  	<td class="label">水印文字：</td>
  			  	<td >
		       		<input type="text" name="watermarkText" id="textfield2" class="input150" value="<#if watermarkBean??>${watermarkBean.watermarkText!}</#if>"/>
		       		<span id="valueError" style="color:red"></span>
	          	</td>
	      	</tr>
  			<tr>
  			  	<td class="label">水印文字字体：</td>
  			  	<td >
  			  		<#--select name="textFont" id="select" value="<#if watermarkBean??>${watermarkBean.textFont!}</#if>" >
  			  			<#if fonts??>
  			  			<#list fonts as font>
  			  				<option value="${font!}" <#if watermarkBean??  && watermarkBean.textFont??><#if font == watermarkBean.textFont>selected</#if></#if>>${font!}</option>
  			  			</#list>
  			  			</#if>
	          		</select-->
	          		<select name="textFont" id="select" value="<#if watermarkBean??>${watermarkBean.textFont!}</#if>">
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "AR-PL-ShanHeiSun-Uni-Regular" == watermarkBean.textFont>selected</#if></#if> value="AR-PL-ShanHeiSun-Uni-Regular">AR-PL-ShanHeiSun-Uni-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "AR-PL-ZenKai-Uni-Medium" == watermarkBean.textFont>selected</#if></#if> value="AR-PL-ZenKai-Uni-Medium">AR-PL-ZenKai-Uni-Medium</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Bitstream-Charter-Bold" == watermarkBean.textFont>selected</#if></#if> value="Bitstream-Charter-Bold">Bitstream-Charter-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Bitstream-Charter-Bold-Italic" == watermarkBean.textFont>selected</#if></#if> value="Bitstream-Charter-Bold-Italic">Bitstream-Charter-Bold-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Bitstream-Charter-Italic" == watermarkBean.textFont>selected</#if></#if> value="Bitstream-Charter-Italic">Bitstream-Charter-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Bitstream-Charter-Regular" == watermarkBean.textFont>selected</#if></#if> value="Bitstream-Charter-Regular">Bitstream-Charter-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Bitstream-Vera-Sans-Bold" == watermarkBean.textFont>selected</#if></#if> value="Bitstream-Vera-Sans-Bold">Bitstream-Vera-Sans-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Bitstream-Vera-Sans-Bold-Oblique" == watermarkBean.textFont>selected</#if></#if> value="Bitstream-Vera-Sans-Bold-Oblique">Bitstream-Vera-Sans-Bold-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Bitstream-Vera-Sans-Mono-Bold" == watermarkBean.textFont>selected</#if></#if> value="Bitstream-Vera-Sans-Mono-Bold">Bitstream-Vera-Sans-Mono-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Bitstream-Vera-Sans-Mono-Bold-Ob" == watermarkBean.textFont>selected</#if></#if> value="Bitstream-Vera-Sans-Mono-Bold-Ob">Bitstream-Vera-Sans-Mono-Bold-Ob</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Bitstream-Vera-Sans-Mono-Oblique" == watermarkBean.textFont>selected</#if></#if> value="Bitstream-Vera-Sans-Mono-Oblique">Bitstream-Vera-Sans-Mono-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Bitstream-Vera-Sans-Mono-Roman" == watermarkBean.textFont>selected</#if></#if> value="Bitstream-Vera-Sans-Mono-Roman">Bitstream-Vera-Sans-Mono-Roman</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Bitstream-Vera-Sans-Oblique" == watermarkBean.textFont>selected</#if></#if> value="Bitstream-Vera-Sans-Oblique">Bitstream-Vera-Sans-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Bitstream-Vera-Sans-Roman" == watermarkBean.textFont>selected</#if></#if> value="Bitstream-Vera-Sans-Roman">Bitstream-Vera-Sans-Roman</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Bitstream-Vera-Serif-Bold" == watermarkBean.textFont>selected</#if></#if> value="Bitstream-Vera-Serif-Bold">Bitstream-Vera-Serif-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Bitstream-Vera-Serif-Roman" == watermarkBean.textFont>selected</#if></#if> value="Bitstream-Vera-Serif-Roman">Bitstream-Vera-Serif-Roman</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Century-Schoolbook-Bold" == watermarkBean.textFont>selected</#if></#if> value="Century-Schoolbook-Bold">Century-Schoolbook-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Century-Schoolbook-Bold-Italic" == watermarkBean.textFont>selected</#if></#if> value="Century-Schoolbook-Bold-Italic">Century-Schoolbook-Bold-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Century-Schoolbook-Italic" == watermarkBean.textFont>selected</#if></#if> value="Century-Schoolbook-Italic">Century-Schoolbook-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Century-Schoolbook-Roman" == watermarkBean.textFont>selected</#if></#if> value="Century-Schoolbook-Roman">Century-Schoolbook-Roman</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Console-Regular" == watermarkBean.textFont>selected</#if></#if> value="Console-Regular">Console-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Courier-10-Pitch-Bold" == watermarkBean.textFont>selected</#if></#if> value="Courier-10-Pitch-Bold">Courier-10-Pitch-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Courier-10-Pitch-Bold-Italic" == watermarkBean.textFont>selected</#if></#if> value="Courier-10-Pitch-Bold-Italic">Courier-10-Pitch-Bold-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Courier-10-Pitch-Italic" == watermarkBean.textFont>selected</#if></#if> value="Courier-10-Pitch-Italic">Courier-10-Pitch-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Courier-10-Pitch-Regular" == watermarkBean.textFont>selected</#if></#if> value="Courier-10-Pitch-Regular">Courier-10-Pitch-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Courier-Bold" == watermarkBean.textFont>selected</#if></#if> value="Courier-Bold">Courier-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Courier-Bold-Italic" == watermarkBean.textFont>selected</#if></#if> value="Courier-Bold-Italic">Courier-Bold-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Courier-Italic" == watermarkBean.textFont>selected</#if></#if> value="Courier-Italic">Courier-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Courier-Regular" == watermarkBean.textFont>selected</#if></#if> value="Courier-Regular">Courier-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Cursor-Regular" == watermarkBean.textFont>selected</#if></#if> value="Cursor-Regular">Cursor-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Sans-Bold" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Sans-Bold">DejaVu-LGC-Sans-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Sans-Bold-Oblique" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Sans-Bold-Oblique">DejaVu-LGC-Sans-Bold-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Sans-Book" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Sans-Book">DejaVu-LGC-Sans-Book</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Sans-Condensed-Bold" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Sans-Condensed-Bold">DejaVu-LGC-Sans-Condensed-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Sans-Condensed-Bold-O" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Sans-Condensed-Bold-O">DejaVu-LGC-Sans-Condensed-Bold-O</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Sans-Condensed-Conden" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Sans-Condensed-Conden">DejaVu-LGC-Sans-Condensed-Conden</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Sans-Condensed-Obliqu" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Sans-Condensed-Obliqu">DejaVu-LGC-Sans-Condensed-Obliqu</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Sans-Light-ExtraLight" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Sans-Light-ExtraLight">DejaVu-LGC-Sans-Light-ExtraLight</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Sans-Mono-Bold" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Sans-Mono-Bold">DejaVu-LGC-Sans-Mono-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Sans-Mono-Bold-Obliqu" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Sans-Mono-Bold-Obliqu">DejaVu-LGC-Sans-Mono-Bold-Obliqu</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Sans-Mono-Book" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Sans-Mono-Book">DejaVu-LGC-Sans-Mono-Book</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Sans-Mono-Oblique" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Sans-Mono-Oblique">DejaVu-LGC-Sans-Mono-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Sans-Oblique" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Sans-Oblique">DejaVu-LGC-Sans-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Serif-Bold" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Serif-Bold">DejaVu-LGC-Serif-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Serif-Bold-Oblique" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Serif-Bold-Oblique">DejaVu-LGC-Serif-Bold-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Serif-Book" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Serif-Book">DejaVu-LGC-Serif-Book</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Serif-Condensed-Bold" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Serif-Condensed-Bold">DejaVu-LGC-Serif-Condensed-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Serif-Condensed-Bold-" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Serif-Condensed-Bold-">DejaVu-LGC-Serif-Condensed-Bold-</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Serif-Condensed-Conde" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Serif-Condensed-Conde">DejaVu-LGC-Serif-Condensed-Conde</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Serif-Condensed-Obliq" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Serif-Condensed-Obliq">DejaVu-LGC-Serif-Condensed-Obliq</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "DejaVu-LGC-Serif-Oblique" == watermarkBean.textFont>selected</#if></#if> value="DejaVu-LGC-Serif-Oblique">DejaVu-LGC-Serif-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Dingbats-Regular" == watermarkBean.textFont>selected</#if></#if> value="Dingbats-Regular">Dingbats-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Fixed-Regular" == watermarkBean.textFont>selected</#if></#if> value="Fixed-Regular">Fixed-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Liberation-Mono-Bold" == watermarkBean.textFont>selected</#if></#if> value="Liberation-Mono-Bold">Liberation-Mono-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Liberation-Mono-Bold-Italic" == watermarkBean.textFont>selected</#if></#if> value="Liberation-Mono-Bold-Italic">Liberation-Mono-Bold-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Liberation-Mono-Italic" == watermarkBean.textFont>selected</#if></#if> value="Liberation-Mono-Italic">Liberation-Mono-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Liberation-Mono-Regular" == watermarkBean.textFont>selected</#if></#if> value="Liberation-Mono-Regular">Liberation-Mono-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Liberation-Sans-Bold" == watermarkBean.textFont>selected</#if></#if> value="Liberation-Sans-Bold">Liberation-Sans-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Liberation-Sans-Bold-Italic" == watermarkBean.textFont>selected</#if></#if> value="Liberation-Sans-Bold-Italic">Liberation-Sans-Bold-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Liberation-Sans-Italic" == watermarkBean.textFont>selected</#if></#if> value="Liberation-Sans-Italic">Liberation-Sans-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Liberation-Sans-Regular" == watermarkBean.textFont>selected</#if></#if> value="Liberation-Sans-Regular">Liberation-Sans-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Liberation-Serif-Bold" == watermarkBean.textFont>selected</#if></#if> value="Liberation-Serif-Bold">Liberation-Serif-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Liberation-Serif-Bold-Italic" == watermarkBean.textFont>selected</#if></#if> value="Liberation-Serif-Bold-Italic">Liberation-Serif-Bold-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Liberation-Serif-Italic" == watermarkBean.textFont>selected</#if></#if> value="Liberation-Serif-Italic">Liberation-Serif-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Liberation-Serif-Regular" == watermarkBean.textFont>selected</#if></#if> value="Liberation-Serif-Regular">Liberation-Serif-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "LucidaTypewriter-Sans" == watermarkBean.textFont>selected</#if></#if> value="LucidaTypewriter-Sans">LucidaTypewriter-Sans</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "LucidaTypewriter-Sans-Bold" == watermarkBean.textFont>selected</#if></#if> value="LucidaTypewriter-Sans-Bold">LucidaTypewriter-Sans-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Luxi-Mono-Bold" == watermarkBean.textFont>selected</#if></#if> value="Luxi-Mono-Bold">Luxi-Mono-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Luxi-Mono-Bold-Oblique" == watermarkBean.textFont>selected</#if></#if> value="Luxi-Mono-Bold-Oblique">Luxi-Mono-Bold-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Luxi-Mono-Oblique" == watermarkBean.textFont>selected</#if></#if> value="Luxi-Mono-Oblique">Luxi-Mono-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Luxi-Mono-Regular" == watermarkBean.textFont>selected</#if></#if> value="Luxi-Mono-Regular">Luxi-Mono-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Luxi-Sans-Bold" == watermarkBean.textFont>selected</#if></#if> value="Luxi-Sans-Bold">Luxi-Sans-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Luxi-Sans-Bold-Oblique" == watermarkBean.textFont>selected</#if></#if> value="Luxi-Sans-Bold-Oblique">Luxi-Sans-Bold-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Luxi-Sans-Oblique" == watermarkBean.textFont>selected</#if></#if> value="Luxi-Sans-Oblique">Luxi-Sans-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Luxi-Sans-Regular" == watermarkBean.textFont>selected</#if></#if> value="Luxi-Sans-Regular">Luxi-Sans-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Luxi-Serif-Bold" == watermarkBean.textFont>selected</#if></#if> value="Luxi-Serif-Bold">Luxi-Serif-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Luxi-Serif-Bold-Oblique" == watermarkBean.textFont>selected</#if></#if> value="Luxi-Serif-Bold-Oblique">Luxi-Serif-Bold-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Luxi-Serif-Oblique" == watermarkBean.textFont>selected</#if></#if> value="Luxi-Serif-Oblique">Luxi-Serif-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Luxi-Serif-Regular" == watermarkBean.textFont>selected</#if></#if> value="Luxi-Serif-Regular">Luxi-Serif-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "MiscFixed-Bold" == watermarkBean.textFont>selected</#if></#if> value="MiscFixed-Bold">MiscFixed-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "MiscFixed-Bold-SemiCondensed" == watermarkBean.textFont>selected</#if></#if> value="MiscFixed-Bold-SemiCondensed">MiscFixed-Bold-SemiCondensed</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "MiscFixed-Regular" == watermarkBean.textFont>selected</#if></#if> value="MiscFixed-Regular">MiscFixed-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "MiscFixed-SemiCondensed" == watermarkBean.textFont>selected</#if></#if> value="MiscFixed-SemiCondensed">MiscFixed-SemiCondensed</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Nimbus-Mono-Bold" == watermarkBean.textFont>selected</#if></#if> value="Nimbus-Mono-Bold">Nimbus-Mono-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Nimbus-Mono-Bold-Oblique" == watermarkBean.textFont>selected</#if></#if> value="Nimbus-Mono-Bold-Oblique">Nimbus-Mono-Bold-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Nimbus-Mono-Regular" == watermarkBean.textFont>selected</#if></#if> value="Nimbus-Mono-Regular">Nimbus-Mono-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Nimbus-Mono-Regular-Oblique" == watermarkBean.textFont>selected</#if></#if> value="Nimbus-Mono-Regular-Oblique">Nimbus-Mono-Regular-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Nimbus-Roman-No9-Bold" == watermarkBean.textFont>selected</#if></#if> value="Nimbus-Roman-No9-Bold">Nimbus-Roman-No9-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Nimbus-Roman-No9-Bold-Italic" == watermarkBean.textFont>selected</#if></#if> value="Nimbus-Roman-No9-Bold-Italic">Nimbus-Roman-No9-Bold-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Nimbus-Roman-No9-Regular" == watermarkBean.textFont>selected</#if></#if> value="Nimbus-Roman-No9-Regular">Nimbus-Roman-No9-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Nimbus-Roman-No9-Regular-Italic" == watermarkBean.textFont>selected</#if></#if> value="Nimbus-Roman-No9-Regular-Italic">Nimbus-Roman-No9-Regular-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Nimbus-Sans-Bold" == watermarkBean.textFont>selected</#if></#if> value="Nimbus-Sans-Bold">Nimbus-Sans-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Nimbus-Sans-Bold-Italic" == watermarkBean.textFont>selected</#if></#if> value="Nimbus-Sans-Bold-Italic">Nimbus-Sans-Bold-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Nimbus-Sans-Condensed-Bold" == watermarkBean.textFont>selected</#if></#if> value="Nimbus-Sans-Condensed-Bold">Nimbus-Sans-Condensed-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Nimbus-Sans-Condensed-Bold-Itali" == watermarkBean.textFont>selected</#if></#if> value="Nimbus-Sans-Condensed-Bold-Itali">Nimbus-Sans-Condensed-Bold-Itali</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Nimbus-Sans-Condensed-Regular" == watermarkBean.textFont>selected</#if></#if> value="Nimbus-Sans-Condensed-Regular">Nimbus-Sans-Condensed-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Nimbus-Sans-Condensed-Regular-It" == watermarkBean.textFont>selected</#if></#if> value="Nimbus-Sans-Condensed-Regular-It">Nimbus-Sans-Condensed-Regular-It</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Nimbus-Sans-Regular" == watermarkBean.textFont>selected</#if></#if> value="Nimbus-Sans-Regular">Nimbus-Sans-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Nimbus-Sans-Regular-Italic" == watermarkBean.textFont>selected</#if></#if> value="Nimbus-Sans-Regular-Italic">Nimbus-Sans-Regular-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Standard-Symbols-Regular" == watermarkBean.textFont>selected</#if></#if> value="Standard-Symbols-Regular">Standard-Symbols-Regular</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "URW-Bookman-Demi-Bold" == watermarkBean.textFont>selected</#if></#if> value="URW-Bookman-Demi-Bold">URW-Bookman-Demi-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "URW-Bookman-Demi-Bold-Italic" == watermarkBean.textFont>selected</#if></#if> value="URW-Bookman-Demi-Bold-Italic">URW-Bookman-Demi-Bold-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "URW-Bookman-Light" == watermarkBean.textFont>selected</#if></#if> value="URW-Bookman-Light">URW-Bookman-Light</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "URW-Bookman-Light-Italic" == watermarkBean.textFont>selected</#if></#if> value="URW-Bookman-Light-Italic">URW-Bookman-Light-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "URW-Chancery-Medium-Italic" == watermarkBean.textFont>selected</#if></#if> value="URW-Chancery-Medium-Italic">URW-Chancery-Medium-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "URW-Gothic-Book" == watermarkBean.textFont>selected</#if></#if> value="URW-Gothic-Book">URW-Gothic-Book</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "URW-Gothic-Book-Oblique" == watermarkBean.textFont>selected</#if></#if> value="URW-Gothic-Book-Oblique">URW-Gothic-Book-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "URW-Gothic-Demi" == watermarkBean.textFont>selected</#if></#if> value="URW-Gothic-Demi">URW-Gothic-Demi</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "URW-Gothic-Demi-Oblique" == watermarkBean.textFont>selected</#if></#if> value="URW-Gothic-Demi-Oblique">URW-Gothic-Demi-Oblique</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "URW-Palladio-Bold" == watermarkBean.textFont>selected</#if></#if> value="URW-Palladio-Bold">URW-Palladio-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "URW-Palladio-Bold-Italic" == watermarkBean.textFont>selected</#if></#if> value="URW-Palladio-Bold-Italic">URW-Palladio-Bold-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "URW-Palladio-Italic" == watermarkBean.textFont>selected</#if></#if> value="URW-Palladio-Italic">URW-Palladio-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "URW-Palladio-Roman" == watermarkBean.textFont>selected</#if></#if> value="URW-Palladio-Roman">URW-Palladio-Roman</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Utopia-Bold" == watermarkBean.textFont>selected</#if></#if> value="Utopia-Bold">Utopia-Bold</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Utopia-Bold-Italic" == watermarkBean.textFont>selected</#if></#if> value="Utopia-Bold-Italic">Utopia-Bold-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Utopia-Italic" == watermarkBean.textFont>selected</#if></#if> value="Utopia-Italic">Utopia-Italic</option>
  			  				<option <#if watermarkBean??  && watermarkBean.textFont??><#if "Utopia-Regular" == watermarkBean.textFont>selected</#if></#if> value="Utopia-Regular">Utopia-Regular</option>
	          		</select>
	          	</td>
	      	</tr>
          	<tr>
  			  	<td class="label">字体大小：</td>
  			  	<td >
  			  		<select name="textFontSize">
	  			  		<#list 12..72 as num>
	  			  		<option value="${num!}" <#if watermarkBean?? && watermarkBean.textFontSize??><#if num?string == watermarkBean.textFontSize>selected</#if></#if>>${num!}</option>
	  			  		</#list>
	            	</select>
	            	<span id="fontsizeError" style="color:red"></span>
	            </td>
	      	</tr>
  			<tr>
  			  	<td class="label">字体颜色：</td>
  			  	<td >
  			  		<input type="text" name="textFontColor" id="textFontColor" class="input80" value="<#if watermarkBean??>${watermarkBean.textFontColor!}</#if>"/>
  			  		<div class="block"></div>
  			  		<span id="fontcolorError" style="color:red"></span>
		      	</td>
	      	</tr>
  			<tr>
  			  	<td class="label">字体阴影颜色：</td>
  			  	<td >
  			  		<input type="text" name="fontShadowColor" id="fontShadowColor" class="input80" value="<#if watermarkBean??>${watermarkBean.fontShadowColor!}</#if>"/>
  			  		<span id="shadowcolorError" style="color:red"></span>
		      	</td>
	      	</tr>
          	</tbody>
          	<tr>
  			  	<td class="label">图片水印透明度：</td>
  			  	<td >
  			  		<input type="text" name="imageTransparency" id="textfield2" class="input80 digits" value="<#if watermarkBean??>${watermarkBean.imageTransparency!}</#if>"/>
  			  		<span id="opacityError" style="color:red"></span>
  			  	</td>
	      	</tr>
	      <tr>
		  	<td class="label">水印位置：</td>
		  	<td >
		  	<#if watermarkPositionList??>
			  	<#list watermarkPositionList as watermarkPosition>
			  		<input name="watermarkPositionId" type="radio" value="${watermarkPosition.enumId!}" <#if watermarkBean??&&watermarkBean.watermarkPositionId??&&watermarkBean.watermarkPositionId==watermarkPosition.enumId>checked</#if> />${watermarkPosition.description!}
		  		</#list>
	  		</#if>
        	</td>
      	</tr>
	</table>
	</div>	
	</form>	        
</div>		  
 <div class="formBar" >
	<ul>
		<li>
			<a class="button" href="#" onclick="javascript:submitImgSettingForm();"  >
				<span>
					<#if entity??>
					${uiLabelMap.CommonSave}
					<#else>
					${uiLabelMap.CommonSave}
					</#if>
				</span>
			</a>
		</li>
		<#--
		<li>
			<div class="button">
				<div class="buttonContent">
					<button class="close" type="button">${uiLabelMap.CommonClose}</button>
				</div>
			</div>
		</li>
		-->
	</ul>
</div>           