<#--
<link rel="stylesheet" type="text/css" href="../seller/css/javascript.css">
<script src="/images/jquery/plugins/validate/jquery.validate.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/jeditable/jquery.jeditable.js" type="text/javascript"></script>
<script src="/images/jquery/ui/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/datetimepicker/jquery-ui-timepicker-addon.min-1.4.3.js" type="text/javascript"></script>
<#assign actionUrlStr="createPersonInfo">
<#if partyInfo?has_content>
<#assign actionUrlStr="updatePersonInfo">
</#if>
<div class="content profile">
<h2 class="title" style='font-size:20px'>店主信息</h2>
<div class="profile_detail clearfix">
<!-- Begin  Form Widget - Form Element  component://common/widget/SecurityForms.xml#updatePassword - - >
<form id="" class="basic-form" onsubmit="javascript:submitFormDisableSubmits(this)" method="post" name="" action="<@ofbizUrl>${actionUrlStr}</@ofbizUrl>">
<input id="partyId" name="partyId" type="hidden" value="${(partyId)!}"> 
<table class="basic-table" cellSpacing="0">
<tbody>
<tr>
<td class="label"><span >名字</span></td>
<td><input name="firstName" size="25" type="text" value="${(partyInfo.firstName)!}">
</td>
</tr>
<tr>
<td class="label"><span >姓氏</span></td>
<td><input name="lastName" size="25" type="text" value="${(partyInfo.lastName)!}">
</td>
</tr>
<tr>
<td class="label"><span >身份证号码</span></td>
<td><input name="socialSecurityNumber" maxLength="30" size="35" type="text" value="${(partyInfo.socialSecurityNumber)!}">
</td>
</tr>
<#--<tr>
<td class="label"><span >护照编号</span></td>
<td><input  name="passportNumber" maxLength="30" size="35" type="text" value="${(partyInfo.passportNumber)!}" autocomplete="off">
</td>
</tr>
<tr>
<td class="label"><span >护照过期日期</span></td>
<td><input id="passportExpireDate" name="passportExpireDate" maxLength="30" size="35" type="text" value="${(partyInfo.passportExpireDate)!}">
<script type="text/javascript">
jQuery(function () {
    // 时间设置
    jQuery('#passportExpireDate').datetimepicker({
	 	showSecond: false,
	 	timeFormat: "",
	 	dateFormat: "yy-mm-dd"
    });
});
</script>
</td>
</tr>	- - >
<tr>
<td class="label"><span >生日</span></td>
<td><input id="birthDate"
name="birthDate" maxLength="30" size="25" type="text" value="${(partyInfo.birthDate)!}">
<script type="text/javascript">
jQuery(function () {
// 时间设置
jQuery('#birthDate').datetimepicker({
showSecond: false,
timeFormat: "",
dateFormat: "yy-mm-dd"
});
});
</script>
</td>
</tr>	
<tr>
<td class="label"><span >性别</span></td>
<td>
<select  size="1" name="gender">              
<option value="M"<#if partyInfo.gender=="M">selected="selected"</#if> >男</option>          
<option value="F"<#if partyInfo.gender=="F">selected="selected"</#if> >女</option>    
</select>
</td>
</tr>												
<tr>
<td class="label"><span>手机</span></td>
<td><input id="cellPhone"
name="cellPhone" maxLength="11" size="25" type="text" value="${(partyInfo.cellPhone)!}">
</td>
</tr>
<#--<tr>
<td class="label"><span >地址</span></td>
<td>
<select name=""><option value="">&nbsp;</option>
<option value="M">北京市</option></select>
<select name=""><option value="">&nbsp;</option>
<option value="M">xx区</option></select>
<select name=""><option value="">&nbsp;</option>
<option value="M">xx镇</option></select>
</td>
</tr> - - >
<#--<tr>
<td class="label"><span >详细地址</span></td>
<td><input id="updatePassword_newPasswordVerify" name="" maxLength="11" size="60" type="text">
</td>
</tr> - - >
<tr>
<td class="label">&nbsp;</td>
<td>
<input type="submit" class="smallSubmit" value="保存"/>
</td>
</tr>
<#--<tr>
<td class="label">&nbsp;</td>
<td colSpan="4"><a class="smallSubmit" title=" " href="/portal/control/userMain?"> 取消/完成</a></td>
</tr> - - >
</tbody>
</table>
</form>
<!-- End  Form Widget - Form Element  component://common/widget/SecurityForms.xml#updatePassword - - >
</div>
</div>
</div>
</div>
</div>
</div>
</div>-->
<#--
<field name="partyId" type="id-ne"><description>会员标识</description></field>
<field name="partyQualTypeId" type="id-ne"><description>资质类型标识</description></field>
<field name="qualificationDesc" type="id-long"><description>资质描述</description></field>
<field name="title" type="id-long"><description>标题</description></field>
<field name="statusId" type="id"><description>状态标识(statusTypeId="IMAGE_MANAGEMENT_ST")</description></field>
<field name="verifStatusId" type="id"><description>审核状态</description></field>
<field name="fromDate" type="date-time"><description>起始时间(默认:创建时间)</description></field>
<field name="thruDate" type="date-time"><description>截止时间</description></field>
<field name="imagePath" type="url"><description>图片路径</description></field>
-->
<#--
<field name="partyQualTypeId" type="id-ne"><description>资质类型标识</description></field>
<field name="parentTypeId" type="id-ne"><description>资质父类型标识</description></field>
<field name="description" type="description"><description>描述</description></field>
-->

<div class="content my_account">
	<div class="listheight" style="height:75%; width:100%; overflow-y: auto;">
		<div style="padding:10px 0px;">
			<select id="verifStatusId" onchange="filterByVerifStatusId(this);">
				<option value="">审核状态</option>
				<#assign items = delegator.findByAnd("StatusItem",{"statusTypeId":"IMAGE_MANAGEMENT_ST"},null,false)?if_exists/>
				<#list items![] as enum>
					<option <#if parameters.verifStatusId?? && parameters.verifStatusId==enum.statusId>selected</#if> value="${enum.statusId}">${enum.description!}</option>
				</#list>
			</select>
			<a class="btn-mini" href="javascript:{void(0)}" onClick="editEnterpriseQual('${partyId!}');">添加资质</a>
		</div>
		<table class="points_table tab_content" cellspacing="0" width="100%">
			<thead>
				<tr class='border-bottom:none;'>
					<th width="50px"><input type="checkBox" class="checkboxCtrl" onclick="checkAll(this);" group="orderIndexs"></th>
					<th style="text-align:center;">类型</th>
					<th style="text-align:center;">标题</th>
					<th style="text-align:center;width:250px">描述</th>
					<th style="text-align:center;">图片</th>
					<th style="text-align:center;">状态</th>
					<th style="text-align:center;">操作</th>
				</tr>
			</thead>
			<tbody>
				<#list enterpriseQuals![] as enterpriseQual>
					<tr>
						<td>
							<input type="checkbox" value="${enterpriseQual.partyId!}|${enterpriseQual.partyQualTypeId!}|${enterpriseQual.fromDate!}" name="orderIndexs" >
						</td>
						<td style="text-align:center;">
							<#if enterpriseQual.partyQualTypeId?? && enterpriseQualTypes??>
								<#assign typeGv = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(enterpriseQualTypes,{"partyQualTypeId":enterpriseQual.partyQualTypeId})?if_exists[0]/>
								${(typeGv.description)!}
							</#if>
						</td>
						<td style="text-align:center;">${StringUtil.wrapString(enterpriseQual.title!)}</td>
						<td style="text-align:center;">${StringUtil.wrapString(enterpriseQual.qualificationDesc!)}</td>
						<td style="text-align:center;"><#if enterpriseQual.imagePath??><img src="${StringUtil.wrapString(enterpriseQual.imagePath!)}" height="100px"/></#if></td>
						<td style="text-align:center;">
							<#if enterpriseQual.verifStatusId??>
								<#assign enum = delegator.findOne("StatusItem",true,{"statusId":enterpriseQual.verifStatusId})?if_exists/>
								${(enum.description)!}
							</#if>
						</td>
						<td>
							<a href="editEnterpriseQual?partyId=${enterpriseQual.partyId!}&partyQualTypeId=${enterpriseQual.partyQualTypeId!}&fromDate=${enterpriseQual.fromDate!}">修改</a>
						</td>
					</tr>
				</#list>
			</tbody>
		</table>
	</div>
</div>
<script type="text/javascript">
	function editEnterpriseQual(partyId){
		if(partyId){
			location.href="editEnterpriseQual?partyId="+partyId;
		}
	}
	function filterByVerifStatusId(obj){
		var verifStatusId = obj.value
		if(verifStatusId){
			location.href="merchantInfo?verifStatusId="+verifStatusId;
		}else{
			location.href="merchantInfo";
		}
	}
</script>