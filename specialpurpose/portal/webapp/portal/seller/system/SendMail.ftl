<script type="text/javascript">
	var changeAll = function(){
		var ifChecked = $("input[name=checkAll][type=checkbox]").attr("checked");
		$("input[name=grade][type=checkbox]").attr("checked",ifChecked?true:false);
	}
	var cleanValue = function(){
		$("#chooseList").val("");
	}
	var disabledCK = function(){
		$("input[type=checkbox][name=checkAll]").attr("disabled",true);
		$("input[type=checkbox][name=grade]").attr("disabled",true);
		$("#flagMgr1").attr("checked",false);
		$("#chooseListTr").css("display","");
		$("#chooseType").val("advanced");
	}
	
	function enabledCK(){
		$("input[type=checkbox][name=checkAll]").attr("disabled",false);
		$("input[type=checkbox][name=grade]").attr("disabled",false);
		$("#flagMgr1").attr("checked",true);
		$("#chooseListTr").css("display","none");
		$("#chooseType").val("ordinary");
	}
</script>
<div>
<#--<div style="width:100%;height:30px;background:#003366;padding-top:10px">
	<span style="font-size:18px;color:white;">&nbsp;发送消息</span>
</div>-->
<form action="sendManualMail?navTabId=sendMail&ajax=1" method="post" class="single_editor" onsubmit="return iframeCallback(this, navTabAjaxDone);" name="sendManualMail" id="sendManualMail" >
<div style="width:100%">
<table style="width:100%">
	<tr style="height:40px">
		<td vAlign="middle" align="right"style="width:140px">
			<span style="font-family:宋体;font-size:13px;font-weight:bold;font-style:normal;text-decoration:none;color:#333333;">发送类型</span>
		</td>
		<td>
			<table style="width:100%;height:100%">
				<tr>
					<td style="width:250px">
						<input type="radio" name="mailType" value="EMAIL" checked onclick="cleanValue()">发送邮件
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="mailType" value="NOTE" onclick="cleanValue()">发送短信
					</td>
					<td>
						发送批次&nbsp;&nbsp;<input name="sendBatch" style="width:100px;height:12px"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr style="height:60px">
		<td vAlign="middle" align="right">
			<span style="font-family:宋体;font-size:13px;font-weight:bold;font-style:normal;text-decoration:none;color:#333333;">发送对象</span>
		</td>
		<td>
		<br/>
		<input type="radio" id="flagMgr1" onclick="enabledCK()" checked style="height:20px">范围发送&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="checkbox" name="checkAll" value="0" onclick="changeAll()">所有会员&nbsp;&nbsp;
			<#assign partyClassificationGroupList = delegator.findByAnd("PartyClassificationGroup",{"partyClassificationTypeId","MEMBER_GRADE"})>
			<#if partyClassificationGroupList??&&partyClassificationGroupList?size&gt;0>
				<#list partyClassificationGroupList as partyClassificationGroup>
					<input type="checkbox" name="grade" value="${partyClassificationGroup.partyClassificationGroupId?if_exists}">${partyClassificationGroup.description?if_exists}&nbsp;&nbsp;&nbsp;&nbsp;
				</#list>
			</#if>
			<br/><br/><br/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a width="580" height="610" href="<@ofbizUrl>findUsersInfoByCondition</@ofbizUrl>" onclick="disabledCK()" target="dialog"><span style="font-size:13px;color:#999966;font-weight:bold">高级搜索-会员</span></a>
		<font style="color:red">*启用高级搜索时候范围发送功能将失效，可选择重新启用！</font>
			<input type="hidden" id="chooseType" name="chooseType" value="ordinary"/>
		<br/><br/>
		</td>
	</tr><tr id="chooseListTr" style="display:none">
		<td vAlign="middle" align="right">
			<span style="font-family:宋体;font-size:13px;font-weight:bold;font-style:normal;text-decoration:none;color:#333333;">收件人</span>
		</td>
		<td>
			<textarea name="chooseList" id="chooseList" readonly style="color: #000000;height: 64px;text-align: left;text-decoration: none;width: 510px;"></textarea>
		</td>
	</tr>
	<tr style="height:40px">
		<td vAlign="middle" align="right">
			<span style="font-family:宋体;font-size:13px;font-weight:bold;font-style:normal;text-decoration:none;color:#333333;">信息标题</span>
		</td>
		<td>
			<input name="subject" id="subject" style="color: #000000;width: 300px;"/><span style="color:red">*短信标题不发送，只作为信息标识!</span>
		</td>
	</tr>
	<tr>
		<td vAlign="middle" align="right">
			<span style="font-family:宋体;font-size:13px;font-weight:bold;font-style:normal;text-decoration:none;color:#333333;">信息内容</span>
		</td>
		<td>
			<textarea name="content" id="content" style="color: #000000;height: 104px;text-align: left;text-decoration: none;width: 510px;"></textarea>
		</td>
	</tr>
	<tr style="height:40px" vAlign="middle">
		<td colspan="2" align="center">
			<!--<input type="button" value="发送" onclick="javascript:forms['sendManualMail'].submit()" style="height:25px;width:50px">-->
		</td>
	</tr>
</table>
<div class="formBar">
		<ul>
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">${uiLabelMap.CommonSave}</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button class="close" type="button">${uiLabelMap.CommonClose}</button></div></div></li>
		</ul>
	</div>  
</div>
</form>
</div>