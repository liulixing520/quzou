
<div class="pageContent" id="pageContent">
<!--
	<h2 class="contentTitle">${uiLabelMap.roleInfo}</h2>
	-->
<div id="screenlet-body" class="screenlet-body" layoutH="96">
<div><form method="post" action="carUseApplyExamineSave" id="routeForm"    name="routeForm">
    <input type="hidden" name="carUseId" id="routeForm_carUseId" value='<#if entity??>${entity.carUseId!}</#if>'/>
    <input type="hidden" name="navTabId" value="FindCarUseApplyRegister" />
    <input type="hidden" name="areaId" value="10000" />
    <input type="hidden" name="workEffortId" value="${workEffortGV.workEffortId!}" />
    <input type="hidden" name="fromDate" value="${parameters.fromDate!}" />
    <input type="hidden" name="roleTypeId" value="${parameters.roleTypeId!}" />
    <input type="hidden" name="signLead" value="${userLogin.partyId!}" />
    <input type="hidden" name="nextActiveFlag" value="${nextActiveFlag!}" />
    <input type="hidden" name="callbackType" value="closeCurrent" />
    <table cellspacing="0" class="basic_table">
    <tr class="title02">
          <td height="30" colspan="4" style=" border-left:none"><b>车辆申请信息</b></td>
      </tr>
    <tr class='background_tr'>

    <td class="label">车牌号码</td>
    <td colspan="3" >
		<input type="text" name="carNo"  value="${entity.carNo!}"
         size="60"     maxlength="250"    class='required'              autocomplete="off"/>
    </td>
    </tr>
         <tr>
  		    <td width="20%" height="60" class="label">意见</td>
  		    <td height="60"  colspan="3" >
  		    <textarea name="LeadCensure" maxlength="255" rows="5" cols="50" class="textarea1"></textarea>
  		      </td>
  		  </tr>
  		  ${resultList}
  	<!-- 下一步活动以及参与者选择 -->	  
	<#include "component://sysCommon/webapp/sysCommon/includes/wf/wf_common_mac.ftl"/>
	<#if activity.hasNextActiveSelect!='no'>	
		<@wfNextActivity  resultList 'routeForm' returnActivityList/>
	</#if>	
    </table>
   
</form>
     
     
     ${screens.render("component://sysCommon/widget/WorkflowScreens.xml#examineTrace")}
     </div> 
    </div> 
<div class="buttonBarOuter">
	<div class="buttonBar">
		<a class="l-btn" onclick="javascript:submitForm('routeForm');" href="javascript:void(0);">
				<span class="l-btn-left">
					<span class="l-btn-text icon-no l-btn-icon-left">
						保存
					</span>
				</span>
			</a>
		<a class="l-btn" onclick="javascript:window.history.back();" href="javascript:void(0);">
				<span class="l-btn-left">
					<span class="l-btn-text icon-no l-btn-icon-left">
						返回
					</span>
				</span>
			</a>	
    </div>   
</div> 