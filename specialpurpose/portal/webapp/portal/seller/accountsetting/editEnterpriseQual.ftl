<script type="text/javascript" src="/sysCommon/images/uploadify/scripts/swfobject.js"></script>
<script type="text/javascript" src="/sysCommon/images/uploadify/scripts/jquery.uploadify.v2.1.0.js"></script>
<link href="/sysCommon/images/uploadify/css/uploadify.css" type="text/css" rel="stylesheet"></link>
<script type="text/javascript">
	function initUploadifyBtn(){
		var fileInfo = '*.jpg;*.jpeg;*.gif;*.png;';
		$("#uploadBtn").uploadify({
			'uploader':'/testpaper/images/uploadify/scripts/uploadify.swf',
			'cancelImg':'/testpaper/images/uploadify/cancel.png',
			'script':('<@ofbizUrl>uploadImage</@ofbizUrl>'),
			'folder': 'UploadFile',
			//'queueID': 'fileQueue',
			'auto': true,
			'multi': true,
			'onComplete': function(event,queueId,fileObj,response,data){
				var jsonObj = jQuery.parseJSON(response);
				var info = jsonObj.info;
				if(info){
					alert(info);
				}else{
					var filePath = jsonObj.msg.url;
					if(filePath){
						$("#editEnterpriseQual input[name=imagePath]").val(filePath);
						$("#imgShow").html('<img src="'+filePath+'" width="150px;"/>');
					}
				}
			},
	    	//'onUploadSuccess': 'myUplaodifyComplete',
			//'fileQueue': 'fileQueue',
			'fileExt': fileInfo,
			'fileDesc': fileInfo
		});
	}
	function saveEnterpriseQual(){
		$.ajax({
			url:'saveEnterpriseQual',
			type:'post',
			data:$("#editEnterpriseQual").serialize(),
			success:function(r){
				if(r.info||r._ERROR_MESSAGE_||r._ERROR_MESSAGE_LIST_){
					alert(r.info||r._ERROR_MESSAGE_||r._ERROR_MESSAGE_LIST_);
				}else{
					alert("保存成功");
					history.go(-1);
				}
			}
		});
	}
	$(function(){
		initUploadifyBtn();
	});
</script>
<div class="content my_order">
<div class="screenlet" id="screenlet_1"><div class="screenlet-title-bar"><ul><li class="h3">资质信息</li>
<form id="editEnterpriseQual" action="">
	<input name="partyId" type="hidden" value="${parameters.partyId!}">
	<input name="fromDate" type="hidden" value="${parameters.fromDate!}">
	<input name="imagePath" type="hidden" value="${(entity.imagePath)!}">
	
	<table style="margin:15px;">
		
		<tr>
			<td>&nbsp;</td>
			<td>资质类型:</td>
			<td>
				<#if (entity.partyQualTypeId)??>
					<#assign type=delegator.findOne("EnterpriseQualType",true,{"partyQualTypeId":entity.partyQualTypeId})?if_exists/>
					<input name="partyQualTypeId" type="hidden" value="${entity.partyQualTypeId!}"/>
					${type.description!}
				<#else>
					<select name="partyQualTypeId">
						<#list list![] as entry>
							<option value="${entry.partyQualTypeId}" <#if (entity.partyQualTypeId)?? && entity.partyQualTypeId==entry.partyQualTypeId>selected</#if>>${(entry.description)!}</option>
						</#list>
					</select>
				</#if>
			</td>
		</tr>
		<tr>
			<td></td>
			<td>标题:</td>
			<td>
				<input name="title" type="text" value="${(entity.title)!}"/>
			</td>
		</tr>
		<tr>
			<td></td>
			<td>资质描述:</td>
			<td>
				<input name="qualificationDesc" type="text" value="${(entity.qualificationDesc)!}"/>
			</td>
		</tr>
		<tr>
			<td></td>
			<td colspan='2'><input id="uploadBtn" type="file"/></td>
		</tr>
		<tr>
			<td></td>
			<td colspan='2'>
				<span id="imgShow">
					<#if (entity.imagePath)??>
						<img src="${entity.imagePath}" width="150px;"/>
					</#if>
				</span>
			</td>
		</tr>
		<tr>
			<td style="width:50px;">&nbsp;</td>
			<td>
				<input style="padding:0 5px;" class="smallSubmit" type="button" onclick="saveEnterpriseQual();" value="保存"/>
			</td>
			<td>
			</td>
		</tr>
	</table>
</form>
</div>