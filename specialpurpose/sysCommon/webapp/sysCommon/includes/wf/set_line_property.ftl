<#assign lineTransIdMap=requestAttributes.lineTransIdMap>
<#assign lineInfo=requestAttributes.lineInfo>

<HTML>
<link href="/images/dwz/themes/css/core.css" rel="stylesheet" type="text/css" media="screen"/>
<script language="JavaScript" type="text/javascript">
	//传入的参数[例子为当前选中的连线对象ClickedLineObject]：---------------------------------------------------------
	//接收参数方式：使用window.dialogArguments，对其修改会自动修改连线对象ClickedLineObject的属性：
	var curLine_grahic = window.dialogArguments;
	//alert("curLine_grahic.lineID="+curLine_grahic.lineID+";curLine_grahic.displayName="+curLine_grahic.displayName);
	//----------------------------------------------------------------------------------------------------------------
</script>

	<body>
		<form action="<@ofbizUrl>saveEditLineInfo</@ofbizUrl>" name="actionForm" method="post" target="mainFrame">
			<table width="98%" align="center" class="basic-table" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td colspan="2" align="center" height="40" >
						<strong>修改连线信息</strong>
						<INPUT TYPE='hidden' name="packageId" value="${parameters.packageId!}" />
						<INPUT TYPE='hidden' name="packageVersion" value="${parameters.packageVersion!}" />
						<INPUT TYPE='hidden' name="processId" value="${parameters.processId!}" />
						<INPUT TYPE='hidden' name="processVersion" value="${parameters.processVersion!}" />	
						<input name="xmlString" type="hidden"  value="" />
					</td>
				</tr>
				<tr class='background_tr'>
					<td width="40%" height="30" class="label">
						<div>连线Id:</div>
					</td>
					<td width="60%" >
						<input name="transitionId" id="transitionId"  readonly type="text" value="${lineInfo.transitionId}" class="input1" mustinput/>
					</td>
				</tr>
				<tr>
					<td width="40%" height="30" class="label">
						<div>名字:</div>
					</td>
					<td width="60%" >											
						<input name="transitionName" id="transitionName"  type="text" value="${lineInfo.transitionName!}" class="input1" mustinput/>
					</td>
				</tr>				
				<tr class='background_tr'>
					<td width="40%" height="30" class="label">
						<div>来自:</div>
					</td>
					<td width="60%" >
						<input name="fromActivityId" type="text" value="${lineInfo.fromActivityId!}" size="30" class="input1" readonly="readonly" mustinput>
					</td>
				</tr>
				<tr>
					<td width="40%" height="30" class="label">
						<div>到:</div>
					</td>
					<td width="60%"  >
						<input name="toActivityId" type="text" value="${lineInfo.toActivityId!}" readonly="readonly" size="30"  class="input1" mustinput>
					</td>
				</tr>
				<tr class='background_tr'>
					<td width="40%" height="30" class="label">
						<div>类型:</div>
					</td>
					<td width="60%" >
					
						<select name="conditionTypeEnumId" class="select_style">
							<option value="WTC_CONDITION" >有条件</option>
							<option value="WTC_OTHERWISE" >无条件</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="40%" height="30" class="label">
						<div>表达式:</div>
					</td>
					<td width="60%" >
							<textarea name="conditionExpr" rows="3" cols="40" style="word-break:break-all">${lineInfo.conditionExpr!}</textarea>
					</td>
				</tr>
				</table>			

			<br>
			<table id="table1" width="100%" align="center" cellPadding="0" cellSpacing="1">
				<tr>
					<td colspan="6" align="center" class="fb_add_bottom">
						<div align="center">
							<input type="button" value="修改保存" onClick="actionFormFun()">
							<input type="button" value=" 取 消 " onClick="javascript:window.close();">
						</div>
					</td>
				</tr>
			</table >
		</form>
</body>
</HTML>

<script language="JavaScript" type="text/javascript">
	
function actionFormFun(){
	//传入的参数[例子为当前选中的连线对象ClickedLineObject]：---------------------------------------
	//接收参数方式：使用window.dialogArguments，对其修改会自动修改连线对象ClickedLineObject的属性：
	//判断连线的ID是否已经被占用：
  
	var LineID = actionForm.transitionId.value;
	
		var activityName = window.document.getElementsByName("transitionName")[0].value;
		
		curLine_grahic.modify(LineID,activityName,activityName);
	document.getElementById("xmlString").value = curLine_grahic.getXmlString();
	actionForm.submit();
	window.close();	
}	
</script>
</HTML>


 