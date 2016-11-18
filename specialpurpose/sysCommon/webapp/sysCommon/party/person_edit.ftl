 <@htmlTemplate.submitButton formId="EditPerson"  dialogId="${parameters.dialogId!}" submitJs="${submitJs!}" oper="${parameters.oper!}"/>
<div class="row-fluid sortable">
	<div class="box span12">
		<div class="box-content">
		<form method="post" action="<#if entity??>updatePerson<#else>createPerson</#if>" id="EditPerson" class="form-horizontal"   name="<#if entity??>EditPerson<#else>createPerson</#if>" enctype="multipart/form-data">
		    <input type="hidden" name="partyId" value="${(entity.partyId)?if_exists}"/>
		    <table cellspacing="0" class="basic-table">
		    <tr ><td class='label'>用户名</td><td ><input type="text" name="userLoginId" <#if entity??>readonly</#if>  value="${(entity.userLoginId)?if_exists}"  size="60" maxlength="100" class="required"  /></td></tr>
		    <tr><td class='label'>姓名</td><td ><input type="text" name="firstName"  value="${(entity.firstName)?if_exists}"  size="60" maxlength="100" required='true' class="required" /></td></tr>
		    <#if !entity??>
		    	<tr ><td class='label'>密码</td><td ><input onblur="checkValue('密码',this)" type="password" name="currentPassword" id="currentPassword"  class="easyui-validatebox" data-options="required:true"  value="111111"  size="60"  class='password'/>&nbsp;&nbsp;默认111111</td></tr>
				<tr ><td class='label'>确认密码</td><td ><input  type="password" id="currentPasswordVerify" onblur="checkValue('确认密码',this)"  name="currentPasswordVerify" class="easyui-validatebox" data-options="required:true" validType="reapet['#currentPassword']" value="111111"  size="60"  class='password' invalidMessage="两次输入的密码不一致！"/>&nbsp;&nbsp;默认111111</td></tr>
				<script type="text/javascript">
					function checkValue(name,Obj){
						if(!$.trim($(Obj).val()) || $(Obj).val().length<6)
						{
							$.messager.show({title:'错 误！',msg:'<font color="red">'+name+'不能少于6位或者为空，请重新输入！</font>'});
							$(Obj).val("");
						}
					}
				</script>
			</#if>
			<#if entity??&&entity.partyId??>
				<#assign parentPartyMap=Static["org.extErp.sysCommon.party.PartyServices"].getPartyGroupsMapByParty(delegator,entity.partyId)>
			</#if>
		    <tr><td class='label'>选择部门</td><td >
					<input type='text' name='parentPartyName' style='width:200px' size='20'  id='parentPartyName' >
					<input type='hidden' name='parentPartyId'  id='parentPartyId' >
					<a href='#'  class="btn btn-primary" onclick="javascript:selectCheckallPartyGroup('parentPartyId','parentPartyName','N')">选择</a>
				</td>
			</tr>
			</table></form>
 		</div> 
</div>	