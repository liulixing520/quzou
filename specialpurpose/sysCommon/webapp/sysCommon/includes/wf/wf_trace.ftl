<br>
 <#assign sourceReferenceId=requestAttributes.sourceReferenceId>
 <#assign workActivityMap=requestAttributes.workActivityMap>
 <#assign workflowProcess=requestAttributes.workflowProcess>
<table cellspacing="0" class="basic-table hover-bar">
<tr class="title02">
          <td height="30" colspan="8" style=" border-left:none"><b>流程信息</b>&nbsp;&nbsp;&nbsp; 
          <a href='/extErp/control/viewWorkFlowDesign?packageId=${workflowProcess.packageId}&packageVersion=${workflowProcess.packageVersion}&processVersion=${workflowProcess.processVersion}&processId=${workflowProcess.processId}' target='_blank'>查看流程图</a></td>
      </tr>
<tr class='background_tr'> 
      <td width="15%" class="border06 width5">活动名称</td>
      <td width="10%" class="border07 width15">活动状态</td>      
      <td width="22%" class="border07 width15">办理人</td>
      <td width="5%" class="border07 width15">是否委派</td>
      <td width="8%" class="border07 width15">处理状态</td>
      <td width="15%" class="border07 width15">完成时间</td>
      <td width="15%" class="border07 width15">规定时限</td>
      <td width="20%" class="border07 width15">办理意见</td>      
  </tr>  
   

    <#assign partyAssignmentsMap=requestAttributes.partyAssignmentsMap>
    <#list requestAttributes.workEffortList as workEffort>
    	<#assign workEffortId=workEffort.workEffortId>
    	<#assign currentStatusId=workEffort.currentStatusId>
    	<#assign activtyStatus=''>
    			<#if  currentStatusId=='WF_COMPLETED'||currentStatusId=='WF_TERMINATED'||currentStatusId=='WF_ABORTED'>
					<#assign activtyStatus='完成'>
				</#if>
				<#if  currentStatusId=='WF_RUNNING'||currentStatusId=='WF_NOT_STARTED'>
					<#assign activtyStatus='进行中'>
				</#if>
    	<#assign workflowAcrivity=workActivityMap[workEffortId]>
    	<#assign partyAssignmentList=partyAssignmentsMap[workEffortId]>
				<#list partyAssignmentList as partyAssignment>
				<tr>
				<td class="border06">${workflowAcrivity.objectName!}</td>
				
				<td class="border06">${activtyStatus!}</td>
				<td class="border06">${partyAssignment.partyId!}</td>
				<td class="border06">否</td>
				<#assign  processStatus=''>
				<#assign  statusId=partyAssignment.statusId>
				<#if  statusId=='CAL_COMPLETED'>
					<#assign processStatus='完成'>
				</#if>
				<#if  statusId=='CAL_ACCEPTED'>
					<#assign processStatus='进行中'>
				</#if>
				<#assign  examineApproveList =delegator.findByAnd("ExamineApprove",{"partyId",partyAssignment.partyId,"sourceReferenceId",sourceReferenceId,"workflowActivityId",workEffort.workflowActivityId,"workEffortId",workEffort.workEffortId},Static["org.ofbiz.base.util.UtilMisc"].toList("examineTime DESC"))/>                   
				<#if examineApproveList?has_content>
					<#assign  examineApprove = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(examineApproveList)/> 
				</#if>  
				<td class="border06">${processStatus!}&nbsp;</td>
				<td class="border06"><#if examineApprove??>${examineApprove.examinetime!}</#if>&nbsp;</td>                
				<td class="border06"><#if examineApprove??>${workflowAcrivity.lastDayLimit!}</#if>&nbsp;</td>                
				<td class="border06"><#if examineApprove??>${examineApprove.examineCensure!}</#if>&nbsp;</td>                
				
				</tr>	
				</#list>
			
    </#list>
    
 </table>   

