<@htmlTemplate.navTitle titleProperty/>
<div class="pageContent" id="pageContent">
	<div class="screenlet-body" id="screenlet-body">
	<form method="post" action="<#if workEffortGV??>saveExaminCarUseApplyRegister<#else><#if entity??>updateCarUseApplyRegister<#else>createCarUseApplyRegister</#if></#if>" id="EditCarUseApplyRegister" class="single_table"   name="EditCarUseApplyRegister">
	    <input type="hidden" name="carUseId" id="EditCarUseApplyRegister_carUseId" value='<#if entity??>${entity.carUseId!}</#if>'/>
	    <input type="hidden" name="status" value="NOT_START" />
	    <input type="hidden" name="areaId" value="10000" />
	    <input type="hidden" name="entityIdValue" value="<#if entity??>${entity.carUseId?if_exists}</#if>"/>
	    <table cellspacing="0" class="basic-table">
		    <tr>
			    <td class="label"><span class="norequired" >车牌号码</span></td>
		    	<td>
		    		<input type="text" name="carNo" value="${(entity.carNo)?if_exists}" maxlength="250"   class='required' />
		    	</td>
			    <td class="label"><span class="norequired" >使用天数</span></td>
		    	<td>
		    		<input type="text" name="dayNum" value="${(entity.dayNum)?if_exists}" maxlength="250"   class='required number' />
		    	</td>
		    </tr>
			<#if !parameters.oper??>	
			<!-- 工作流中下一步活动以及参与者选择 -->
		    <#include "component://sysCommon/webapp/sysCommon/includes/wf/wf_common_mac.ftl"/>
			<@wfNextActivity  resultList 'EditCarUseApplyRegister' ''/>
			</#if>
			<#include "component://sysCommon/webapp/sysCommon/includes/wf/wf_examine_trace.ftl"/>
	    </table>
	</form>
    </div> 
	 <@htmlTemplate.submitButton formId="EditCarUseApplyRegister"  dialogId="${parameters.dialogId!}" submitJs="${submitJs!}" oper="${parameters.oper!}"/>
		
</div>
