
<div class="pageContent" id="pageContent">

<div id="screenlet-body" class="screenlet-body" layoutH="96">
<div><form method="post" action="updatePassword"  class="single_table"   name="EditPassword" id="EditPassword">
    <input type="hidden" name="userLoginId" value="${userLoginId!}"/>
    <input type="hidden" name="callbackType" value="closeCurrent"/>
    <table cellspacing="0" class="basic-table">
        <!--
        <tr class='background_tr'><td class='border03'>原密码</td><td class='border02'><input type="password" name="currentPassword"    size="60" maxlength="100"  class='required'/></td></tr>
    	-->
    	<tr class='background_tr'><td class='border03'>新密码</td><td class='border02'><input  type="password" name="newPassword" id="newPassword"  class="easyui-validatebox" data-options="required:true" value=""  size="60"  class='password'/></td></tr>
		<tr ><td class='border03'>确认新密码</td><td class='border02'><input  type="password" id="newPasswordVerify"   name="newPasswordVerify" class="easyui-validatebox" data-options="required:true"equalto="#newPassword" value=""  size="60"  class='password'/></td></tr>
	
	 
		</tbody>
	</table>
	</td></tr></table></form>
     </div> 
    </div> 
    <div class="buttonBarOuter">
    	<div class="buttonBar">
    		<a  href='#'  class="easyui-linkbutton" iconCls="icon-save" onclick="ajaxSubmitForm('EditPassword');" >保存</a>
    		<a  href='#'  class="easyui-linkbutton" iconCls="icon-no" onclick="commonCloseCurrentTab();" >关闭</a>
    	</div>  
	</div>	
</div>