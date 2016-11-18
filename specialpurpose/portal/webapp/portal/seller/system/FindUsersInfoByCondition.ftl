<div style="width:100%;float:left">
		<form action='<@ofbizUrl>findUsersInfoByCondition</@ofbizUrl>' id='findUsersBycondition' name='findUsersBycondition' class="pageForm"  method="post" rel="pageForm">
			<table style="width:550px">
			<tr style="height:15px">
			<td  style="width:100px" align="right">用户名&nbsp;&nbsp;&nbsp;</td><td style="width:175px"><input name="userLoginId" type="text"style="width:150px;height:13px" value="${(params.userLoginId)!''}"></td>
			<td  style="width:100px"align="right">Email&nbsp;&nbsp;&nbsp;</td><td style="width:175px"><input name="Email" type="text"style="width:150px;height:13px" value="${(params.Email)!''}"></td>
			</tr>
			<tr style="height:15px">
			<td  style="width:100px" align="right">姓名&nbsp;&nbsp;&nbsp;</td><td style="width:175px"><input name="name"type="text" style="width:150px;height:13px"value="${(params.name)!''}"></td>
			<td  style="width:100px"align="right">手机&nbsp;&nbsp;&nbsp;</td><td style="width:175px"><input name="mobilePhone"type="text" style="width:150px;height:13px" value="${(params.mobilePhone)!''}"></td>
			</tr>
			<tr style="height:15px">
			<td  style="width:100px" align="right">地址&nbsp;&nbsp;&nbsp;</td><td style="width:175px"><input name="address"type="text" style="width:150px;height:13px" value="${(params.address)!''}"></td>
			<td  style="width:100px"align="right">备注&nbsp;&nbsp;&nbsp;</td><td style="width:175px"><input name="remark" type="text"style="width:150px;height:13px" value="${(params.remark)!''}"></td>
			</tr>
			<tr style="height:15px">
			<td  style="width:100px" align="right">注册时间&nbsp;&nbsp;&nbsp;</td><td colspan="3" ><input type="text"style="width:130px;height:13px" readonly name="regionDateStart" class="date" value="${(params.regionDateStart)!''}"/>&nbsp;&nbsp;&nbsp;------&nbsp;&nbsp;&nbsp;<input class="date"readonly name="regionDateEnd"type="text" style="width:130px;height:13px" value="${(params.regionDateEnd)!''}"></td>
			</tr>
			<tr style="height:15px">
			<td  style="width:100px" align="right">上次登录时间&nbsp;&nbsp;&nbsp;</td><td colspan="3"><input type="text"style="width:130px;height:13px"readonly name="loginDateStart" class="date" value="${(params.loginDateStart)!''}" />&nbsp;&nbsp;&nbsp;------&nbsp;&nbsp;&nbsp;<input class="date"readonly name="loginDateEnd"type="text" style="width:130px;height:13px" value="${(params.loginDateEnd)!''}"></td>
			</tr>
			
			<tr style="height:15px">
			<td  style="width:100px" align="right">会员等级&nbsp;&nbsp;&nbsp;</td><td colspan="3">
			<input type="checkbox" name="checkAllToo" value="0" onclick="changeAllCKB(this,'gradeToo')">所有会员&nbsp;&nbsp;
			<#if (params.gradeToo)??&&(params.gradeToo)?has_content>
				<#assign paramGrades = params.gradeToo/>
			</#if>
			
			<#assign PCGList = delegator.findByAnd("PartyClassificationGroup",{"partyClassificationTypeId","MEMBER_GRADE"})>
			<#if PCGList??&&PCGList?size&gt;0>
				<#list PCGList as partyClassificationGroup>
					<#assign checkedSign='N'/>
					<#if paramGrades??>
						<#list paramGrades as grade>
							<#if partyClassificationGroup.partyClassificationGroupId??&&partyClassificationGroup.partyClassificationGroupId==grade>
								<#assign checkedSign = 'Y'/>
							</#if>
						</#list>
					</#if>
					<input type="checkbox" <#if checkedSign??&&checkedSign=='Y'>checked</#if> name="gradeToo" value="${partyClassificationGroup.partyClassificationGroupId?if_exists}">${partyClassificationGroup.description?if_exists}&nbsp;&nbsp;
				</#list>
			</#if>
			</td>
			</tr>
			<tr style="height:15px">
			<td  style="width:100px" align="right">会员积分&nbsp;&nbsp;&nbsp;</td><td colspan="3"><input onkeyup="value=value.replace(/\D/g,'')" type="text"style="width:130px;height:13px" name="integralLow" value="${(params.integralLow)!''}" />&nbsp;&nbsp;&nbsp;------&nbsp;&nbsp;&nbsp;<input onkeyup="value=value.replace(/\D/g,'')"  name="integralHigh"type="text" style="width:130px;height:13px" value="${(params.integralHigh)!''}" /></td>
			</tr>
			<tr style="height:15px">
			<td  style="width:100px" align="right">会员性别&nbsp;&nbsp;&nbsp;</td><td colspan="3">
				<input name="gender_M" value="M" type="checkbox" <#if (params.gender_M)??>checked</#if>>男
		  		&nbsp;&nbsp;&nbsp;&nbsp;
		  		<input name="gender_F" value="F" type="checkbox"<#if (params.gender_F)??>checked</#if>>女
		  		&nbsp;&nbsp;&nbsp;&nbsp;
		  		<input name="gender_NULL" value="NULL" type="checkbox" <#if (params.gender_NULL)??>checked</#if>>保密
           	</td>
			</tr>
			<tr style="height:15px">
			<td  style="width:100px" align="right">所在地区&nbsp;&nbsp;&nbsp;</td><td colspan="3">
			<select id='stateProvinceGeoId' name="stateProvinceGeoId"  onchange="getArea(this,'ajaxAreaCommon','cityGeoId','countyGeoId');" >
				<option value="">选择省市</option>
				<#assign stateAssocs = Static["org.ofbiz.iteamgr.party.ContactMechTools"].getAssociatedStateList(delegator,'CHN')>
				<#list stateAssocs as stateAssoc>
				    <option value='${stateAssoc.geoId}'<#if (params.stateProvinceGeoId)??&&params.stateProvinceGeoId==stateAssoc.geoId>selected</#if>>${stateAssoc.geoName?default(stateAssoc.geoId)}</option>
				</#list>
			</select>
			<select name="cityGeoId" id="cityGeoId"  onchange="getArea(this,'ajaxAreaCommon','countyGeoId','null');">
				<option value="">选择城市</option>
				<#if (params.stateProvinceGeoId)??>
					<#assign cityList = Static["org.ofbiz.iteamgr.party.ContactMechTools"].getAssociatedStateList(delegator,params.stateProvinceGeoId) />
					<#list cityList as city>
						<option value='${city.geoId}' <#if (params.cityGeoId)??&&params.cityGeoId==city.geoId>selected</#if>>${city.geoName!''}</option>
					</#list>
				</#if>
			</select>
			<select  name="countyGeoId" id="countyGeoId">
				<option value="">选择区县</option>
				<#if (params.cityGeoId)??>
					<#assign countyList = Static["org.ofbiz.iteamgr.party.ContactMechTools"].getAssociatedStateList(delegator,params.cityGeoId) />
					<#list countyList as county>
						<option value='${county.geoId}' <#if (params.countyGeoId)??&&params.countyGeoId==county.geoId>selected</#if>>${county.geoName!''}</option>
					</#list>
				</#if>
			</select>
			</td>
			</tr>
			<tr style="height:15px">
			<td  style="width:100px" align="right">账户余额&nbsp;&nbsp;&nbsp;</td><td colspan="3"><input onkeyup="value=value.replace(/\D/g,'')" type="text"style="width:130px;height:13px" name="accountBalanceLow" value="${(params.accountBalanceLow)!''}"/>&nbsp;&nbsp;&nbsp;------&nbsp;&nbsp;&nbsp;<input onkeyup="value=value.replace(/\D/g,'')" name="accountBalanceHigh" value="${(params.accountBalanceHigh)!''}" type="text" style="width:130px;height:13px"></td>
			</tr>
			<tr style="height:25px" vAlign="middle">
			<td  colspan="4" align="right">
			<input type="button" onclick="javascript:submitDialogForm('findUsersBycondition');" style="width:50px;height:20px" value="查询"/>
			</td>
			</tr>
			</table>
		</form>	
	</div>
	<div style="width:100%;overflow:hidden;height:25px">
		<table class="table" width="100%">
			<thead>
				<td width="10%" align='center'><input type="checkbox" name="checkAllAlso" onclick="changeAllCKB(this,'userCheck')">全选</td>
				<td width="24%" align='center'>会员名</td>
		        <td width="25%" align='center'>手机号</td>
		        <td width="39%" align='center'>邮箱地址</td>
		        <td width="2%" align='center'></td>
	      	</thead>
      	</table>
	</div>
	<div style="width:100%;overflow:auto;height:250px">
		<#--<table class="table" width="100%" layoutH="78">
			<thead>
				<tr>
					<td width="10%" align='center'><input type="checkbox" name="checkAllAlso" onclick="changeAllCKB(this,'userCheck')">全选</td>
					<td width="25%" align='center'>会员名</td>
			        <td width="25%" align='center'>手机号</td>
			        <td width="40%" align='center'>邮箱地址</td>
		      	</tr>
	      	</thead>-->
		<table class="table" width="100%" layoutH="78">
	      	<#if userList??&&userList?size&gt;0>
	      		<#list userList as user>
	      			<#if user.partyId??>
	      				<#assign email ="">
	      				<#assign mobileTel = "">
	      				<#assign contactMeches = Static["org.ofbiz.iteamgr.party.ContactMechTools"].getPrimaryPartyContactMechValueMaps(delegator, user.partyId, false)/>
	      				<#if contactMeches??&&contactMeches.emailAddress??>
	      					<#assign email =contactMeches.emailAddress.infoString />
	      				</#if>
	      				<#if contactMeches??&&contactMeches.mobileNumber??>
	      					<#assign mobileTel =contactMeches.mobileNumber.contactNumber />
	      				</#if>
	      	<#--<#assign partyContactMechList = delegator.findByAnd("PartyContactMech",  {"partyId":user.partyId})>
	      	<#if partyContactMechList??&&partyContactMechList?size&gt;0>
	      	<#list partyContactMechList as partyContactMech>
	      		<#assign contactMech = delegator.findOne("ContactMech",{"contactMechId":partyContactMech.contactMechId},true)?if_exists/>
		      	<#if (contactMech.contactMechTypeId)??&&contactMech.contactMechTypeId=="EMAIL_ADDRESS">
		      		<#assign email = (contactMech.infoString)!>
		      	<#elseif !(contactMech.contactMechTypeId?exists)||contactMech.contactMechTypeId=="TELECOM_NUMBER">
		      		<#assign telecomNum = delegator.findOne("TelecomNumber",{"contactMechId":partyContactMech.contactMechId},true)?if_exists>
		      		<#if telecomNum?has_content&&telecomNum.contactNumber?exists>
		      			<#assign mobileTel = (telecomNum.contactNumber)!>
		      		</#if>
		      	</#if>
	      	</#list>
	      	</#if>-->
	      	<#--<#assign userLoginList =delegator.findByAnd("UserLogin",  {"partyId":user.partyId})>
	      	${userLoginList?size} ===${user.partyId}
	      	<#if userLoginList??&&userLoginList?size&gt;0>
		      	<#list userLoginList as userLogin>-->
			      	<tr>
			      		<td width="10%" align='center'><input type="checkbox" name="userCheck" id="${(user.partyId)!}" value="${(user.partyId)!}"/></td>
			      		<td width="25%" align='center'>${(user.partyId)!}</td>
			      		<td width="25%" align='center'>${(mobileTel)!}</td>
			      		<td width="40%" align='center'>${(email)!}</td>
			      	</tr>
		      	<#--</#list>
	      	</#if>-->
	      			</#if>
	      		</#list>
	      	</#if>
	    </table>
	    </div>
	    <!--dwz  分页 -->
		<#include "component://itea/webapp/iteamgr/ftl/dwz_pagination.ftl"/>      
		<@dwzPagin userList userListSize viewSize viewIndex searchAction "panelBar_dialog"/>
	    <!--dwz  分页 -->
	    <div class="formBar">
		<ul>
		<li><a class="button" href="#" onclick="javascript:addUserToDis();"><span>提交</span></a></li>
		<li><a class="button" href="#" onclick='javascript:closeDialog();'><span>关闭</span></a></li>
		</ul>
		</div>
	
	<script type="text/javascript">
	function addUserToDis(){
		var checkboxes = $("input:checked[type=checkbox][name=userCheck]");
		if (checkboxes.length == 0) {
			alert("请选择要添加的用户名");
			return;
		}
		var choseNameStr = $("#chooseList").val();
		var choseNameList = choseNameStr.split(",");
		for (var i = 0, ci; ci = checkboxes[i]; i++){
			var flag=true;
			$.each(choseNameList,function(n,ele){
				if(ci.value==ele){
				flag=false;
				}
			});
			if(flag){
				if(choseNameStr!=""){
					choseNameStr+=","+ci.value;
				}else{
					choseNameStr+=ci.value;
				}
			}
		}
		$("#chooseList").val(""+choseNameStr);
		$.pdialog.closeCurrent();
	}
	var changeAllCKB = function(thisObj,name){
		var ifChecked = thisObj.checked;
		$("input[type=checkbox][name="+name+"]").attr("checked",ifChecked);
	}
	$(document).ready(function(){});
	<#--var choseNameListStr= $("#choseNameList").val();
	var choseNameList=choseNameListStr.split(",");
	var mailType = $("input:checked[type=radio][name=mailType]").val();
		for(var o=0,choseName;choseName=choseNameList[o];o++){
			var checkboxes = $("input[type=checkbox][name=userCheck]");
			for (var i = 0, ci; ci = checkboxes[i]; i++){
				var useValue;
				if(mailType=="EMAIL"){
					useValue=$(ele).attr("email");
				}else if(mailType=="NOTE"){
					useValue=$(ele).attr("mobileTel");
				}
				if(choseName == useValue){
					$("#"+ci.id).attr("checked",true);
				}
			}
		}-->
</script>
	