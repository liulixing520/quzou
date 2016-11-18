
<#assign stActivityMap=requestAttributes.stActivityMap?if_exists>
<#if stActivityMap??>	
	<#assign lParticipantList=stActivityMap.lParticipantList?if_exists>
	<#assign gParticipant=stActivityMap.gParticipantValue?if_exists>
</#if>	
<link href="/images/dwz/themes/css/core.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="/flatgrey/maincss.css" rel="stylesheet" type="text/css" media="screen"/>
	<script language="JavaScript" type="text/javascript">
	//传入的参数[例子为当前选中的图元对象ClickedIconObject]：
	//接收参数方式：使用window.dialogArguments，对其修改会自动修改图元对象ClickedIconObject的属性：
	var curIcon_grahic = window.dialogArguments;
	</script>
	
	<body>
		<form action="<@ofbizUrl>createActivityInfo</@ofbizUrl>" name="actionForm" method="post" target="mainFrame">
			<table width="98%" height='400'  align="center" class="basic-table" >
				<tr class='background_tr'>
					<td colspan="2" align="center" height="40" >
						<strong>活动信息</strong>
						<INPUT TYPE='hidden' name="packageId" value="${requestAttributes.packageId!}" />
						<INPUT TYPE='hidden' name="packageVersion" value="${requestAttributes.packageVersion!}" />
						<INPUT TYPE='hidden' name="processId" value="${requestAttributes.processId!}" />
						<INPUT TYPE='hidden' name="processVersion" value="${requestAttributes.processVersion!}" />
						
						
						<input type="hidden" name="xmlString" value="" />
					</td>
				</tr>
				<tr>
					<td width="40%" height="30" class="label">
						<div>活动Id</div>
					</td>
					<td width="60%" >
						<input name="ActivtyId" id="activtyId" type="text" value="" class="input1" mustinput/>
					</td>
				</tr>
				<tr class='background_tr'>
					<td width="40%" height="30" class="label">
						<div>活动名称</div>
					</td>
					<td width="60%" >
						<input name="OBJECT_NAME" type="text" value="" size="20" class="input1" mustinput>
					</td>
				</tr>				
				<tr style='display:none'>
					<td width="40%" height="30" class="label">
						<div>是否主活动</div>
					</td>
					<td width="60%" >
						<select name="MAIN_ACTIVITY" class="select_style">
							<option value="Y" >Y(是)</option>
							<option value="N"  >N(否)</option>
						</select>
					</td>
				</tr>
				<tr class='background_tr'>
					<td width="40%" height="30" class="label">
						<div>是否可退回</div>
					</td>
					<td width="60%" >
						<select name="CAN_RETURN">
							<option value="yes" >Y(是)</option>
							<option value="no" >N(否)</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="40%" height="30" class="label">
						<div>是否有退回</div>
					</td>
					<td width="60%" >
						<select name="HAS_RETURN_PROCESS">
							<option value="yes" >Y(是)</option>
							<option value="no"  >N(否)</option>
						</select>
					</td>
				</tr>
				<tr class='background_tr'>
					<td width="40%" height="30" class="label">
						<div>开始条件</div>
					</td>
					<td width="60%" >
						<select name="ACCEPT_ALL_ASSIGNMENTS">
							<option value="Y">
							所有人都接受才能开始</option>
							<option value="N" >
							任何一个人接受就开始</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="40%" height="30" class="label">
						<div>结束条件</div>
					</td>
					<td width="60%" >
						<select name="COMPLETE_ALL_ASSIGNMENTS">
							<option value="Y"  >
							所有人都完成才能结束</option>
							<option value="N"  >
							任何一个人完成就结束</option>
						</select>
					</td>
				</tr>
				<tr class='background_tr'>
					<td width="40%" height="30" class="label">
						<div>参与人</div>
					</td>
					<td width="60%" >
						<select name="PARTICIPANT_ID">
							<#list lParticipantList as participant>
							<option value="<#if participant??>${participant.participantId}</#if>" ptype="<#if participant??>${participant.participantTypeId}</#if>">
								<#if participant??&&participant.participantName??>${participant.participantName}</#if>
							</option>
							</#list>
						</select>
					</td>
				</tr>
				<tr id="singleSelectTr" >
					<td  class="label">
						<div>是否单选</div>
					</td>
					<td width="60%" >
						<select name="SINGLE_SELECT">
							<option value=""></option>
							<option value="Y" >Y(是)</option>
							<option value="N" >N(否)</option>
						</select>
					</td>
				</tr>
				<tr id="performerRangeTr" class='background_tr'>
					<td class="label">
						<div>选择范围</div>
					</td>
					<td width="60%" >
						<select name="PERFORMER_RANGE" onchange="performerRangeFun(this)">
							<option value=""></option>
							<option value="MyDepartment">本部门人员</option>
							<option value="OfficeDepartment" >办公室人员</option>
							<option value="HeadDepartment">领导</option>
							<option value="AllClerk">所有人员</option>
							<option value="AllDepartment">所有部门</option>
							<option value="RoleClerk">符合角色人员范围</option>
							<!-- <option value="RoleDepartment" >符合角色人员所属部门范围</option>-->
						</select>
					</td>
				</tr>

				
				<tr id="roleTypeTr" style="display:none">
					<td width="40%" height="30" class="label">
						<div>
							选择系统角色
						</div>
					</td>
					<td width="60%" >
						<select name="PerformerRangeRole" class="selectBox">
							<OPTION value=""></OPTION>
								</select>
					</td>
				</tr>
				<tr class='background_tr'>
					<td width="40%" height="30" class="label">
						<div>
							是否显示活动选择
						</div>
					</td>
					<td width="60%" >
						<select name="hasNextActiveSelect" class="selectBox">
							<option value="yes"  >Y(是)</option>
							<option value="no">N(否)</option>
						</select>
					</td>
				</tr>
				<tr class='background_tr'>
					<td width="40%" height="30" class="label">
						<div>
							活动时限
						</div>
					</td>
					<td width="60%" >
						<input type='text'>分钟
					</td>
				</tr>
				<tr class='background_tr'>
					<td width="40%" height="30" class="label">
						<div>
							活动超时出发服务
						</div>
					</td>
					<td width="60%" >
						<input type='text'>
					</td>
				</tr>
				<tr>
					<td width="40%" height="30" class="label">
						<div>是否区分主协办</div>
					</td>
					<td width="60%" >
						<select name="isContainMainAndVice" class="selectBox">
							<option value="true">Y(是)</option>
							<option value="false" >N(否)</option>
							
						</select>
					</td>
				</tr>
				<tr class='background_tr'>
					<td width="40%" height="30" class="label">
						<div>活动描述</div>
					</td>
					<td width="60%" >
						<textarea rows="4" cols="40"  name="DESCRIPTION" ></textarea>
					</td>
				</tr>
				
				<tr>
					<td colspan='2'  align="center">
						<input type="button" value="修改保存" onclick="actionFormFun()">
						<input type="button" value="取消" onclick="window.close()">
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
<script language="JavaScript" type="text/javascript">
function participantIdFun(thisObj)
{
	var selectedPType;
	var ableUpdateVar;
	for (i=0; i< thisObj.options.length; i++)
	{
		if(thisObj.options[i].selected == true)
		{
		    selectedPType = thisObj.options[i].ptype;
		    ableUpdateVar=thisObj.options[i].optionAbleUpdate;
		}
	}	
 
  if("" == selectedPType)
  {
     	singleSelectTr.style.display = "";
     	performerRangeTr.style.display = "";
  }
  else
  {
      singleSelectTr.style.display = "none";
     	performerRangeTr.style.display = "none";
  }
}

function performerRangeFun(thisObj)
{
	document.all.PerformerRangeRole.selectedIndex=-1;	
  	if(thisObj.value == "RoleClerk" || thisObj.value == "RoleDepartment")
      roleTypeTr.style.display = "";
  	else
  	  roleTypeTr.style.display = "none";  	  
}


function actionFormFun(){
  
  var selectedPType;
  for (i=0; i< actionForm.PARTICIPANT_ID.options.length; i++)
  {
     if(actionForm.PARTICIPANT_ID.options[i].selected == true)
         selectedPType = actionForm.PARTICIPANT_ID.options[i].ptype;
  }	
  

  //针对路由otherwise的处理
	//传入的参数[例子为当前选中的图元对象ClickedIconObject]：----------------------------------------------
	//接收参数方式：使用window.dialogArguments，对其修改会自动修改图元对象ClickedIconObject的属性：
	//判断图元的ID是否已经被占用：
	var IconID=actionForm.activtyId.value;
		var activityName = window.document.getElementsByName("OBJECT_NAME")[0].value;
		curIcon_grahic.modify(IconID,activityName,activityName);
	document.getElementById("xmlString").value = curIcon_grahic.getXmlString();
	actionForm.submit();
	window.close();
}
</script>


 