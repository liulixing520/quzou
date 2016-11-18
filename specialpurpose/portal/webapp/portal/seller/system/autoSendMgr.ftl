<script type="text/javascript">
	var changeAll = function(obj){
		var allObjSign = $(obj).attr('sign');
		var ifChecked = obj.checked;
		var childSign = allObjSign.substring(3);
		$("input[sign="+ childSign +"]").each(function(i,checkObj){
			if($(checkObj).attr('disabled')=='disabled'||$(checkObj).attr('disabled')==true){
			}else{
				$(checkObj).attr('checked',ifChecked);
				changeValue(checkObj);
			}
		});
	}
	
	var changeValue = function(obj){
		var valueInputId = $(obj).attr('directInputId');
		var value = $("#"+valueInputId).attr("value");
		var flag="0";
		if(obj.checked){
			flag="1";
		}
		var newValue = value.substr(0,value.length-1)+flag;
		 $("#"+valueInputId).attr("value",newValue);
	}
</script>
<form action="updateAutoSend?navTabId=autoSendMgr&callbackType=closeCurrent&ajax=1" method="post" class="single_editor" onsubmit="return iframeCallback(this, navTabAjaxDone);" >
<div style="width:100%;border:solid 1px">
	<div style="width:100%;height:40px;margin-top:10px;margin-bottom:10px;">
		<span style="font-size:15px;">&nbsp;&nbsp;&nbsp;&nbsp;自动发送信息维护</span>
	</div>
	<div style="width:520px;margin-top:10px;margin-left:50px;margin-bottom:10px">
		<input type="hidden" name="productStoreId" value="${productStoreId}"/>
		
		<#if msgTypeList??>
		<#assign typeAmount = msgTypeList?size>
		<table id="xiaowu" style="width:100%;border: 1px solid #C1DAD7;">
		<tHead>
		<tr>
		<td align="center">
		发送项目
		</td>
			<#list msgTypeList as msgType>
				<td align="center">
					<input type="checkbox"  sign="All${msgType.enumId}" onclick="changeAll(this)">${msgType.description}模板
				</td>
			</#list>
		</tr>
		</tHead>
		<#if eventTypeList??&&eventTypeList?size&gt;0>
			<#list eventTypeList as eventType>
				<#assign eventTypeId = eventType.enumId>
				<tr>
					<td align="center">
					${(eventType.description)!}
					</td>
					<#list msgTypeList as msgType>
						<#assign msgTypeId = msgType.enumId>
						<#if templateMap[eventTypeId]??>
							<#assign eventTypeGroup = templateMap[eventTypeId]>
							<#if eventTypeGroup[msgTypeId]??>
								<#assign template = eventTypeGroup[msgTypeId]>
									<#if (template.ifAutoSend)??&&(template.ifAutoSend)='1'>
										<#assign ifAuto = '1'>
									</#if>
							</#if>
						</#if>
					<td align="center">
					<input type="hidden" id="${eventType.enumId+msgType.enumId}" name="${eventType.enumId+msgType.enumId}" value="${eventType.enumId}@split@${msgType.enumId}@split@${ifAuto!0}"<#if (templateMap[eventType.enumId][msgType.enumId])??><#else>disabled</#if> />
					<input type="checkbox" sign="${msgType.enumId}" directInputId="${eventType.enumId+msgType.enumId}"  <#if ifAuto??&&ifAuto=='1'>checked</#if> <#if (templateMap[eventType.enumId][msgType.enumId])??><#else>disabled</#if> onclick="changeValue(this)"/>
					&nbsp;<a  href="<@ofbizUrl>editNoteAndEmailModel?productStoreId=${productStoreId}&msgTypeId=${msgType.enumId}&eventTypeId=${eventType.enumId}</@ofbizUrl>"><#if (templateMap[eventType.enumId][msgType.enumId])??>编辑<#else><span style="color:#CCCC99">创建<span></#if></a>
					</td>
					<#assign ifAuto = '0'>
					</#list>
				</tr>
			</#list>
		<#else>
		<tr>
			<td colspan="${typeAmount+1}">
				没有定义自动发送信息的事件类型！
			</td>
		</tr>
		</#if>
		</table>
		<#else>
		没有定义的消息类型！
		</#if>
		<br/>
			<span style="font-size:15px;color:red">
			操作须知：
			</span>
			<br/>
			<span style="font-size:14px;color:red">
			&nbsp;&nbsp;&nbsp;&nbsp;①、如果对应事件-信息模板为暗绿色“<span style="font-size:15px;color:#CCCC99">创建</span>”，则还未存在该信息模板，点击进入创建保存。<br/>
			&nbsp;&nbsp;&nbsp;&nbsp;②、如果对应事件-信息模板为黑色“<span style="font-size:15px;color:black">编辑</span>”，则表示已存在该模板，点击可进行修改模板操作。<br/>
			&nbsp;&nbsp;&nbsp;&nbsp;③、如果禁止对应事件-信息系统自动发送，则取消选择，反之勾选即可系统自动向客户发送该事件信息
			</span>
	</div>
	<div class="formBar">
		<ul>
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">${uiLabelMap.CommonSave}</button></div></div></li>
		</ul>
	</div> 
	</div>
</div>
</form>