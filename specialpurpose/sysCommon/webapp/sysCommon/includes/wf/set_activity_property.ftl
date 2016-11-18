<#assign stActivityMap=requestAttributes.stActivityMap>
<#assign gPackageValue=stActivityMap.packageInfo>
<#assign gProcessValue=stActivityMap.processInfo>
<#assign gActivityInfo=stActivityMap.gActivityValue>
<#assign lNextActivity=stActivityMap.lLastActivityList>
<#assign lNextActivityList=stActivityMap.lNextActivityList>
<#assign lParticipantList=stActivityMap.lParticipantList>
<#assign gParticipant=stActivityMap.gParticipantValue>

<link href="/images/dwz/themes/css/core.css" rel="stylesheet" type="text/css" media="screen"/>
	<script language="JavaScript" type="text/javascript">
	//传入的参数[例子为当前选中的图元对象ClickedIconObject]：
	//接收参数方式：使用window.dialogArguments，对其修改会自动修改图元对象ClickedIconObject的属性：
	var curIcon_grahic = window.dialogArguments;
	</script>
	
	<body>
		<form action="<@ofbizUrl>saveEditActivityInfo</@ofbizUrl>" name="actionForm" method="post" target="mainFrame">
			<table width="98%" height='400'  align="center" class="basic-table" >
				<tr class='background_tr'>
					<td colspan="2" align="center" height="40" >
						<strong>活动信息</strong>
						<INPUT TYPE='hidden' name="packageId" value="${gActivityInfo.packageId!}" />
						<INPUT TYPE='hidden' name="packageVersion" value="${gActivityInfo.packageVersion!}" />
						<INPUT TYPE='hidden' name="processId" value="${gActivityInfo.processId!}" />
						<INPUT TYPE='hidden' name="processVersion" value="${gActivityInfo.processVersion!}" />
						<INPUT TYPE='hidden' name="activityId" value="${gActivityInfo.activityId!}" />
						<INPUT TYPE='hidden' name="oldHasNextActiveSelect" value="${hasNextActiveSelectStr!}" />
						<input type="hidden" name="xmlString" value="" />
					</td>
				</tr>
				<tr>
					<td width="40%" height="30" class="label">
						<div>活动Id</div>
					</td>
					<td width="60%" >
						<input name="ActivtyId" id="activtyId" type="text" readonly value="${gActivityInfo.activityId!}" class="input1" mustinput/>
					</td>
				</tr>
				<tr class='background_tr'>
					<td width="40%" height="30" class="label">
						<div>活动名称</div>
					</td>
					<td width="60%" >
						<input name="OBJECT_NAME" type="text" value="${gActivityInfo.objectName!}" size="20" class="input1" mustinput>
					</td>
				</tr>				
				<tr style='display:none'>
					<td width="40%" height="30" class="label">
						<div>是否主活动</div>
					</td>
					<td width="60%" >
						<select name="MAIN_ACTIVITY" class="select_style">
							<option value="Y" <#if gActivityInfo.mainActivity??&&gActivityInfo.mainActivity=='Y'>selected</#if> >Y(是)</option>
							<option value="N" <#if gActivityInfo.mainActivity??&&gActivityInfo.mainActivity=='N'>selected</#if> >N(否)</option>
						</select>
					</td>
				</tr>
				<tr class='background_tr'>
					<td width="40%" height="30" class="label">
						<div>是否可退回</div>
					</td>
					<td width="60%" >
						<select name="CAN_RETURN">
							<option value="yes" <#if gActivityInfo.canReturn??&&gActivityInfo.canReturn=='yes'>selected</#if> >Y(是)</option>
							<option value="no" <#if gActivityInfo.canReturn??&&gActivityInfo.canReturn=='no'>selected</#if> >N(否)</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="40%" height="30" class="label">
						<div>是否有退回</div>
					</td>
					<td width="60%" >
						<select name="HAS_RETURN_PROCESS">
							<option value="yes" <#if gActivityInfo.hasReturnProcess??&&gActivityInfo.hasReturnProcess=='yes'>selected</#if> >Y(是)</option>
							<option value="no" <#if gActivityInfo.hasReturnProcess??&&gActivityInfo.hasReturnProcess=='no'>selected</#if> >N(否)</option>
						</select>
					</td>
				</tr>
				<tr class='background_tr'>
					<td width="40%" height="30" class="label">
						<div>开始条件</div>
					</td>
					<td width="60%" >
						<select name="ACCEPT_ALL_ASSIGNMENTS">
							<option value="Y" <#if gActivityInfo.acceptAllAssignments??&&gActivityInfo.acceptAllAssignments=='Y'>selected</#if> >
							所有人都接受才能开始</option>
							<option value="N" <#if gActivityInfo.acceptAllAssignments??&&gActivityInfo.acceptAllAssignments=='N'>selected</#if> >
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
							<option value="Y" <#if gActivityInfo.completeAllAssignments??&&gActivityInfo.completeAllAssignments=='Y'>selected</#if> >
							所有人都完成才能结束</option>
							<option value="N" <#if gActivityInfo.completeAllAssignments??&&gActivityInfo.completeAllAssignments=='N'>selected</#if> >
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
							<option value="${gParticipant.participantId}" ptype="${gParticipant.participantTypeId}">
								${gParticipant.participantName}
							</option>
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
							<option value="MyDepartment" <#if gActivityInfo.performerRange??&&gActivityInfo.performerRange=='MyDepartment'>selected</#if> >本部门人员</option>
							<option value="OfficeDepartment"  <#if gActivityInfo.performerRange??&&gActivityInfo.performerRange=='OfficeDepartment'>selected</#if> >办公室人员</option>
							<option value="HeadDepartment" <#if gActivityInfo.performerRange??&&gActivityInfo.performerRange=='HeadDepartment'>selected</#if> >领导</option>
							<option value="AllClerk" <#if gActivityInfo.performerRange??&&gActivityInfo.performerRange=='AllClerk'>selected</#if> >所有人员</option>
							<option value="AllDepartment" <#if gActivityInfo.performerRange??&&gActivityInfo.performerRange=='AllDepartment'>selected</#if> >所有部门</option>
							<option value="RoleClerk" <#if gActivityInfo.performerRange??&&gActivityInfo.performerRange=='RoleClerk'>selected</#if> >符合角色人员范围</option>
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
							<option value="yes" <#if gActivityInfo.hasNextActiveSelect??&&gActivityInfo.hasNextActiveSelect=='yes'>selected</#if> >Y(是)</option>
							<option value="no" <#if gActivityInfo.hasNextActiveSelect??&&gActivityInfo.hasNextActiveSelect=='no'>selected</#if> >N(否)</option>
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
							<option value="true" <#if gActivityInfo.isContainMainAndVice??&&gActivityInfo.isContainMainAndVice=='true'>selected</#if> >Y(是)</option>
							<option value="false" <#if gActivityInfo.isContainMainAndVice??&&gActivityInfo.isContainMainAndVice=='false'>selected</#if> >N(否)</option>
							
						</select>
					</td>
				</tr>
				<tr class='background_tr'>
					<td width="40%" height="30" class="label">
						<div>活动描述</div>
					</td>
					<td width="60%" >
						<textarea rows="4" cols="40"  name="DESCRIPTION" >${gActivityInfo.description!}</textarea>
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
	var newHasNextActiveSelect=document.all.hasNextActiveSelect.value;
	var oldHasNextActiveSelect=document.all.oldHasNextActiveSelect.value;

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


 