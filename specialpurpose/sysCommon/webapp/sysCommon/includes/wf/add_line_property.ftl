

<HTML>

<script language="JavaScript" type="text/javascript">
	//传入的参数[例子为当前选中的连线对象ClickedLineObject]：---------------------------------------------------------
	//接收参数方式：使用window.dialogArguments，对其修改会自动修改连线对象ClickedLineObject的属性：
	var curLine_grahic = window.dialogArguments;
	//alert("curLine_grahic.lineID="+curLine_grahic.lineID+";curLine_grahic.displayName="+curLine_grahic.displayName);
	//----------------------------------------------------------------------------------------------------------------
</script>

	<body>
		<table width=98% class='table_control' border="0" cellspacing="1" cellpadding="0" align=center>
			<tr>
				<td></td>
			</tr>
			<tr></tr>
		</table>
		
		<form action="<@ofbizUrl>saveEditLineInfo</@ofbizUrl>" name="actionForm" method="post" target="mainFrame">
			<table width="98%" align="center" class="table_lt" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td colspan="3" align="center" height="40" class="td_rbb">
						<strong>连线信息</strong>
						<INPUT TYPE='hidden' name="packageId" value="${parameters.packageId!}" />
						<INPUT TYPE='hidden' name="packageVersion" value="${parameters.packageVersion!}" />
						<INPUT TYPE='hidden' name="processId" value="${parameters.processId!}" />
						<INPUT TYPE='hidden' name="processVersion" value="${parameters.processVersion!}" />	
						<input name="xmlString" type="hidden"  value="" />
					</td>
				</tr>
				<tr>
					<td width="40%" height="30" class="td_rbb">
						<div>连线Id:</div>
					</td>
					<td width="60%" class="td_rb">											
						<input name="transitionId" id="transitionId"  type="text" value="" class="input1" mustinput/>
					</td>
				</tr>
				<tr>
					<td width="40%" height="30" class="td_rbb">
						<div>名字:</div>
					</td>
					<td width="60%" class="td_rb">											
						<input name="transitionName" id="transitionName"  type="text" value="" class="input1" mustinput/>
					</td>
				</tr>				
				<tr>
					<td width="40%" height="30" class="td_rbb">
						<div>来自:</div>
					</td>
					<td width="60%" class="td_rb">
						<input name="fromActivityId" type="text" readonly value="${parameters.theFromNodeID!}" size="60" class="input1" mustinput>
					</td>
				</tr>
				<tr>
					<td width="40%" height="30" class="td_rbb">
						<div>到:</div>
					</td>
					<td width="60%" class="td_rb" >
						<input name="toActivityId" type="text" readonly  value="${parameters.theToNodeID!}"  class="input1" mustinput>
					</td>
				</tr>
				<tr>
					<td width="40%" height="30" class="td_rbb">
						<div>类型:</div>
					</td>
					<td width="60%" class="td_rb">
						<select name="conditionTypeEnumId" class="select_style">
							<option value="WTC_CONDITION" selected>CONDITION</option>
							<option value="WTC_OTHERWISE" >OTHERWISE</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="40%" height="30" class="td_rbb">
						<div>表达式:</div>
					</td>
					<td width="60%" class="td_rb">
							<textarea name="conditionExpr" rows="1"  cols="50" style="word-break:break-all">nextActive.equals("${parameters.theToNodeID!}")</textarea>
					</td>
				</tr>
				</table>			
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


 