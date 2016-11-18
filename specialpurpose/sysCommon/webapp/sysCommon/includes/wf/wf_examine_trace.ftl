<#if requestAttributes.workEffortList??>
<table cellspacing="0" width='100%' class="basic-table hover-bar">
<tr class="title02">
          <td height="30" colspan="5" style=" border-left:none"><b>流程信息</b></td>
      </tr>
<tr class='header-row'> 
      <td width="10%" class="border07">活动名称</td>
      <td width="10%" class="border07">活动状态</td>
      <td width="10%" class="border07">办理人</td>
      <td width="40%" class="border07">办理意见</td>
      <td width="15%" class="border07">办理时间</td>
    </tr>   
    <#list requestAttributes.workEffortList as workEffort>
    
   <#assign partyAssignList=delegator.findByAnd("WorkEffortPartyAssignment",{"workEffortId",workEffort.workEffortId})>
    <tr class='tr_content' rowspan='${partyAssignList?size}'>
				<td >${workEffort.workEffortName}</td>
				<td >
				<#assign status=delegator.findOne("StatusItem",{"statusId",workEffort.currentStatusId},true)>
				${status.description}</td>
				
				<#list partyAssignList as partyAssign>
					<#if partyAssignList?size&gt;1>
						<tr >
					</#if>
					<#assign person=delegator.findOne("Person",{"partyId",partyAssign.partyId},false)>
					<td>${person.firstName!}</td>
					<#assign approve=Static["org.ofbiz.entity.util.EntityUtil"].getFirst(delegator.findByAnd("ExamineApprove",{"partyId",partyAssign.partyId,"sourceReferenceId",parameters.sourceReferenceId,"workflowActivityId",workEffort.workflowActivityId,"workEffortId",workEffort.workEffortId}))?if_exists>
					
					<td><#if approve??>${approve.examineCensure!}</#if></td>
					<#if partyAssignList?size&gt;1>
						</tr>
					</#if>
				</#list>
				</td>
				<td >${workEffort.actualCompletionDate!}</td>
				
				
			
			</tr>
	</#list>		
    <#-- 
    <#assign personMap=requestAttributes.personMap>
    <#assign workEffortMap=requestAttributes.workEffortMap>
    <#list requestAttributes.examine_list as examine>
    	<#assign examineId=examine.examineId>
    	<#assign workeffortGv=workEffortMap[examineId]>
    <tr class='tr_content'>
				<td class="border06">${personMap[examine.examineId]}</td>
				<td class="border06">${examine.examineTime!}</td>
				<td class="border06">${workeffortGv.lastDayLimit!}</td>
				<td class="border06">${examine.examineCensure!}</td>
				<td class="border06">${workeffortGv.objectName!}</td>
				
			
			</tr>
    </#list>
    -->
    <tr><td class="td_list" colspan="5" align="center">
    	<a href="viewWorkFlowDesign?packageId=${parameters.workflowPackageId}&packageVersion=1.2&processId=${processId!}&processVersion=1.0&sourceReferenceId=${sourceReferenceId!}" target="_blank"><font color="red">查看流程图</font></a>
    </td></tr>
 
 </table>   
</#if>
