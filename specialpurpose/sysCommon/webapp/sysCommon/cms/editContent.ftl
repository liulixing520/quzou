<#assign FCK=JspTaglibs["/WEB-INF/tags/FCKeditor.tld"]>
<div class="box-content">
	<form action="<#if entity??>updateCmsArticle<#else>createContent</#if>?navTabId=FindCmsArticle&callbackType=closeCurrent&ajax=1" method="post" 
 enctype="multipart/form-data" class="form-horizontal"  >
   <div class="pageFormContent" layoutH="97">
   <input type="hidden" name="articleId" id="EditCmsArticle_articleId"  value='<#if entity??>${entity.articleId!}</#if>'/>
   <input type="hidden" name="statusId" id="EditCmsArticle_statusId"  value='<#if entity??>${entity.statusId!}<#else>1</#if>'/>
<table cellspacing="0" class="basic-table">
    <tr class='background_tr'>
    <td class='border03' style="width:80px">
<span id="EditCmsArticle_title_title">${uiLabelMap.cmsTitle}
</span>    </td>
    <td class='border02'>
<input type="text" name="title" class="required" 
         size="30"     maxlength="27"  value='<#if entity??>${entity.title!}</#if>'       id="EditCmsArticle_title"         autocomplete="off"/>
         <span style="color:red;font-size:20">*注意:标题字数不能超过27个字！</span>
    </td>
    </tr>
    <tr class='background_tr'>
    <td class='border03'>
<span id="EditCmsArticle_websiteId_title">${uiLabelMap.cmsWebSiteId}
</span>    </td>
    <td class='border02'>

<select name="websiteId"   
 id="EditCmsArticle_websiteId" size="1"  style='width:100px;' onchange="changeSelect(this,'EditCmsArticle_catalogId')">
 	<#list cmsWebSiteList as cmsWebSite>
 			<option <#if  entity?? && cmsWebSite.websiteId==entity.websiteId>selected=selected</#if>  value='${cmsWebSite.websiteId!}'>
 			${cmsWebSite.websiteName!}</option>
	</#list>
</select>
 </td>
    </tr>
    <tr class='background_tr'>
    <td class='border03'>
<span id="EditCmsArticle_catalogId_title">${uiLabelMap.cmsCatalogName}
</span>    </td>
    <td class='border02'>

<select name="catalogId"   
 id="EditCmsArticle_catalogId" size="1"  style='width:100px;'> 
	<#list cmsCatalogList as cmsCatalog>
 			<option <#if  entity?? && cmsCatalog.catalogId==entity.catalogId>selected=selected</#if>  value='${cmsCatalog.catalogId!}'>
 			<#if cmsCatalog.parentId!='8000'>--</#if>
 			${cmsCatalog.catalogName!}</option>
	</#list>
</select>
 </td>
    </tr>    
    <tr>
    <td class='border03'>
<span id="EditCmsArticle_articleTypeId_title">${uiLabelMap.articleTypeId}
</span>    </td>
    <td class='border02'>

<select name="articleTypeId"  
 id="EditCmsArticle_articleTypeId" size="1" style='width:100px;' onchange="changeType()"> 
 
 	<#list cmsArticleTypeList as cmsArticleType>
 		<option <#if entity?? && cmsArticleType.articleTypeId==entity.articleTypeId>selected=selected</#if>   value='${cmsArticleType.articleTypeId!}'>${cmsArticleType.displayName!}</option>
	</#list>			
 </select>
    </td>
    </tr>
    <tr id="controlShow1">
    <td class='border03'>
<span id="EditCmsArticle_isDisplay_title">${uiLabelMap.cmsIsDisplay}
</span>    </td>
    <td class='border02'>

<select name="isDisplay"  style='width:100px;'
 id="EditCmsArticle_isDisplay" size="1"> <option <#if entity?? && entity.isDisplay=='Y'>selected=selected</#if>     value="Y">&#26159;</option>
  <option <#if entity?? && entity.isDisplay=='N'>selected=selected</#if>   value="N">&#21542;</option></select>
    </td>
    </tr>
    <tr class='background_tr' id="controlShow2">
    <td class='border03'>
<span id="EditCmsArticle_sortNum_title">${uiLabelMap.CommonSortOrder}
</span>    </td>
    <td class='border02'>
<input type="text" name="sortNum" class="number" 
         size="25"             id="EditCmsArticle_sortNum" value='<#if entity??>${entity.sortNum!}</#if>'        autocomplete="off"/>
    </td>
    </tr>
    <tr class='background_tr' id="controlShow3">
	    <td class='border03'>
			<span id="EditCmsArticle_titleImg_title">标题缩略图</span>    
		</td>
	    <td class='border02'>
			<input type="hidden" name="titleImg"  id="EditCmsArticle_titleImg" size="25" value='<#if entity?? && entity.titleImg??>${entity.titleImg!}</#if>'/>
			<img onclick="preView(this);" id="EditCmsArticle_titleImg_pre" src="<#if entity?? && entity.titleImg??>${entity.titleImg!}</#if>" style="width:83px; height:65px; cursor:pointer;"/>
			<input  id="testFileInput" name="image" type="file"/>
			
			<#--<input  id="testFileInput" name="image" 
				type="file"
				uploader="/images/dwz/uploadify/scripts/uploadify.swf"
				cancelImg="/images/dwz/uploadify/cancel.png" 
				script="<@ofbizUrl>uploadProductImage?imgFor=EditCmsArticle_titleImg</@ofbizUrl>" 
				folder=""
				scriptData="{navTabId:'EditContent', callbackType:''}"
				fileDataName="file" 
				onComplete="uploadTitleImgComplete"
				fileQueue="fileQueue"
				fileExt="*.jpg;*.jpeg;*.gif;*.png;"
				fileDesc="*.jpg;*.jpeg;*.gif;*.png;"/>-->
			&nbsp;&nbsp;&nbsp;<a href="#" onclick="delImgII('titleImg')">取消</a>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:red;font-size:20">*各栏目像素：定制产品(277,183),品鉴文化、国家优势(166,129) ！</span>
	    </td>
    </tr>
    <tr class='background_tr' id="controlShow3">
	    <td class='border03'>
			<span id="EditCmsArticle_titleImg_title">长方形缩略图</span>    
		</td>
	    <td class='border02'>
			<input type="hidden" name="titleImgRect"  id="EditCmsArticle_titleImgRect" size="25" value='<#if entity?? && entity.titleImgRect??>${entity.titleImgRect!}</#if>'/>
			<img onclick="preView(this);" id="EditCmsArticle_titleImgRect_pre" src="<#if entity?? && entity.titleImgRect??>${entity.titleImgRect!}</#if>" style="width:100px; height:50px; cursor:pointer;"/>
			<input  id="testFileInputRect" name="imageRect" type="file"/>
			<#--<input  id="testFileInputRect" name="imageRect" 
				type="file"
				uploader="/images/dwz/uploadify/scripts/uploadify.swf"
				cancelImg="/images/dwz/uploadify/cancel.png" 
				script="<@ofbizUrl>uploadProductImage?imgFor=EditCmsArticle_titleImgRect</@ofbizUrl>" 
				folder=""
				scriptData="{navTabId:'EditContent', callbackType:''}"
				fileDataName="file" 
				onComplete="uploadTitleImgComplete"
				fileQueue="fileQueue"
				fileExt="*.jpg;*.jpeg;*.gif;*.png;"
				fileDesc="*.jpg;*.jpeg;*.gif;*.png;"/>-->
			&nbsp;&nbsp;&nbsp;<a href="#" onclick="delImgII('titleImgRect')">取消</a>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:red;font-size:20">*各栏目像素：最新动态、媒体报道(198,98)</span>
	    </td>
    </tr> 
    <tr class='background_tr' id="controlShow4">
	    <td class='border03'>
			<span id="EditCmsArticle_keywords_title">关键词</span>    
		</td>
	    <td class='border02'>
			<input type="text" name="keywords" id="EditCmsArticle_keywords" size="25" value='<#if entity?? && entity.keywords??>${entity.keywords!}</#if>'/>
	    </td>
    </tr> 
    <tr class='background_tr' id="controlShow5">
	    <td class='border03'>
			<span id="EditCmsArticle_description_title">短描述</span>    
		</td>
	    <td class='border02'>
			<input type="text" name="description" id="EditCmsArticle_description" size="85" maxlength="200" value='<#if entity?? && entity.description??>${entity.description!}</#if>'/>
			<span style="color:red;font-size:20">*注意:短描述字数不能超过200！</span>
	    </td>
    </tr> 
    <script type="text/javascript">
 	var changeType = function(){
     	var artType = $("#EditCmsArticle_articleTypeId").val();
     	var tr1 = $("#controlShow1");
     	var tr2 = $("#controlShow2");
     	var tr3 = $("#controlShow3");
     	var tr4 = $("#controlShow4");
     	var tr5 = $("#controlShow5");
     	if(artType=="section"){
     		tr1.css("display","none");
     		tr2.css("display","none");
     		tr3.css("display","none");
     		tr4.css("display","none");
     		tr5.css("display","none");
     	}else{
     		tr1.css("display","");
     		tr2.css("display","");
     		tr3.css("display","");
     		tr4.css("display","");
     		tr5.css("display","");
     	}
     }
		changeType();
		
	function uplodifyInit(id,imgFor){
		$("#"+id).uploadify({
		    'uploader':'/sysCommon/images/uploadify/scripts/uploadify.swf',
			'cancelImg':'/sysCommon/images/uploadify/cancel.png',
			'script':'<@ofbizUrl>uploadProductImage</@ofbizUrl>?imgFor='+imgFor,
		    'folder': '',
		    'fileDataName':'file',
		    'queueID': 'fileQueue',
		    'auto': true,
		    'multi': true,
		    'onComplete': function(event,queueId,fileObj,response,data){
			    	uploadTitleImgComplete(event,queueId,fileObj,response,data);
			    },
			'fileQueue': 'fileQueue',
			'fileExt': '*.jpg;*.jpeg;*.gif;*.png;',
			'fileDesc': '*.jpg;*.jpeg;*.gif;*.png;'
		});
	}
	uplodifyInit('testFileInput','EditCmsArticle_titleImg');
	uplodifyInit('testFileInputRect','EditCmsArticle_titleImgRect');
 	</script>
    
    <tr >
    <td class='border03' rowspan='2'>
<span id="EditCmsArticle_content_title">${uiLabelMap.cmsContent}
</span></td>
<td class='border02'>
<span style="color:red;font-size:20">*注意:编辑器内图片宽度不能超过750否则页面无法完全显示！</span>
</td>
</tr>
<tr>
    <td class='border02' colspan="4">

		<#if entity??&&(entity.content)??><#assign contentData= StringUtil.wrapString(entity.content)></#if>
		<@FCK.editor instanceName="content" value="${contentData!}" height="500"></@FCK.editor>
	</td>
    </tr>
    </table>
  		
	</div>
		<div id="toolBar" class="buttonBar">
			<button type="submit" class="btn btn-primary">保存</button>
			<button class="btn" onclick="javascript:window.history.back();" href="javascript:void(0);">
				返回
			</button>
    	</div>
    </form>	
</div>
<script type="text/javascript">
<!--
var delImgII = function(id){
	$("#EditCmsArticle_"+id).val("");
	$("#EditCmsArticle_"+id+"_pre").attr("src","");
}
function uploadTitleImgComplete(event, queueId, fileObj, response, data){
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
	$('#'+urlId).val(filePath);
	$('#'+imgFor).val(filePath);
	$('#'+imgFor+'_pre').attr('src', filePath);
	//$('input.item1').val(filePath);
}

function preView(obj){
	window.open(obj.src);
}
//-->
</script>
