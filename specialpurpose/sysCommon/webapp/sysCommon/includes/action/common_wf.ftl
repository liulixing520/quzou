<table>
<#if !parameters.oper??>	
<!-- 工作流中下一步活动以及参与者选择 -->
<#include "component://sysCommon/webapp/sysCommon/includes/wf/wf_common_mac.ftl"/>
<@wfNextActivity  resultList '${currentForm}' ''/>
</#if>
<#include "component://sysCommon/webapp/sysCommon/includes/wf/wf_examine_trace.ftl"/>
</table>
</form>