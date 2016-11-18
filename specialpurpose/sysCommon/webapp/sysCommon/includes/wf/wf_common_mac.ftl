<#macro wfNextActivity    resultList currentForm returnActivityList>

<#if workEffortGV??>
<input type="hidden" name="workEffortId" value="${workEffortGV.workEffortId!}" />
</#if>
<#if (resultList?size>0)>
<tr class='background_tr'>
<td  class="label">下一处理 </td>
<td  >
<select class="select_style" name="nextActive" id='${currentForm!}_nextActive'  onchange="displaySelectNextActiveClerk(this)">
          <option></option>
          <#list resultList as activityGv>
          	<option value='${activityGv.toActivityId!}' performerRange='${activityGv.performerRange!}'  
          	singleSelect='${activityGv.singleSelect!}' performerRangeRole='${activityGv.performerRangeRole!}'>${activityGv.objectName!}</option>
          </#list>
          <#if workEffortGV??>
          	<#if workEffortGV.workEffortName?index_of("退回")==-1&&Static["org.ofbiz.workflowMng.WorkflowReturnProcess"].haveReturnHandling(workEffortGV.workEffortId)>
          	 <option value="return">退回</option>
          	 </#if>
          </#if>
      </select>
     </td>
     <td width="20%"  id="${currentForm!}_nextActivityTd1">　</td>
     <td width="30%"  id="${currentForm!}_nextActivityTd2" style='display:none'><select name='returnActivity' class='select_style'><option value=''></option>
     	<#if returnActivityList?has_content>
     		 <#list returnActivityList as returnActivity>
     		 <option value='${returnActivity.workflowActivityId}'>${returnActivity.workEffortName}</option>
     		 </#list>
     	</#if>
     </td>
    </tr>
    <tr id="${currentForm!}_joinPersonTR"  style="display:none">
      <td  class="label" id="${currentForm!}_joinPersonTD" height="22">参与人员</td>
      <td id='selectPartyId'  height="22">
      	<input type='hidden' name='joinPersonId'  id='joinPersonId'>
      	<input type='text'  id='joinPersonName'><a id='lookupId' >选择</a>
      <#--  <@htmlTemplate.lookupField value='' height="400" formName="${currentForm}" name="joinPersonId"  fieldFormName="LookupAllDepartment"/> -->
      </td>
      
    </tr>
</#if>    
    <tr>
  		    <td>办理意见</td>
  		    <td colspan='3'>
  		    <textarea name="LeadCensure" maxlength="255" rows="5" cols="50" class="textarea1"></textarea>
  		    </td>
    </tr>
    <script language='javascript'>
//显示参与人员选择框,针对动态角色的选人
function displaySelectNextActiveClerk(thisObj)
{
	var myPartyGroupId='${partyGroup.parentPartyId!}';
	var nextActive = document.getElementById("${currentForm!}_nextActive");
	try{
	   //如果存在人员选择范围的属性显示参与人员选择框
	    if(nextActive.value == "return")
     {		
    	    document.getElementById("${currentForm!}_nextActivityTd1").innerHTML = "退回选择";
    	    document.getElementById("${currentForm!}_nextActivityTd2").style.display="";
     }else{
	   var performerRange=$.trim($(thisObj).find('option:selected').attr("performerRange"));
	   var singleSelect=$.trim($(thisObj).find('option:selected').attr("singleSelect"));
	   singleSelect=(singleSelect=='true')?"Y":"N";
	   if(performerRange!=null && performerRange!=''&& performerRange.length>0 && performerRange!=undefined)
	   {	
		      	document.getElementById('${currentForm!}_joinPersonTR').style.display="";
		       	$("#${currentForm!}_joinPersonId").val("");
	      		$("#${currentForm!}_joinPersonName").val("");
		       	if(performerRange=='MyDepartment'){
		       		//initSelect();
		       		//new ConstructLookup("LookupPersonMyDepartment", "autoId_1", document.${currentForm!}.joinPersonId, null, "${currentForm!}", "", "400", "topcenter", "true", "autoId_1,/oa/control/LookupPersonMyDepartment,ajaxLookup=Y&amp;_LAST_VIEW_NAME_=main&amp;searchValueFieldName=joinPersonId", true, "layer", "2", "300");
		       		$("#lookupId").attr("href","javascript:selectMyDepartmentPerson('joinPersonId','joinPersonName','"+singleSelect+"')");  
		       	}else if(performerRange=='AllDepartment'){
					//initSelect();
		       		//new ConstructLookup("LookupAllDepartment", "autoId_1", document.${currentForm!}.joinPersonId, null, "${currentForm!}", "", "400", "topcenter", "true", "autoId_1,/oa/control/LookupAllDepartment,ajaxLookup=Y&amp;_LAST_VIEW_NAME_=main&amp;searchValueFieldName=joinPersonId", true, "layer", "2", "300");
		       		$("#lookupId").attr("href","javascript:selectCheckallPartyGroup('joinPersonId','joinPersonName','"+singleSelect+"')");  
		       	}else if(performerRange=='RoleClerk'){
		       		var  performerRangeRole=$(thisObj).find('option:selected').attr("performerRangeRole");
		       		$("#${currentForm!}_lookUp").attr('href','LookupPersonByRole?roleTypeId='+performerRangeRole);
		       	}else{
		       		$("#lookupId").attr("href","javascript:selectCheckallPerson('joinPersonId','joinPersonName','"+singleSelect+"')");  
		       	}
	   }
	   else
	   {
	      document.getElementById('${currentForm!}_joinPersonTR').style.display="none";
	      $("#${currentForm!}_joinPersonId").val("");
	      $("#${currentForm!}_joinPersonName").val("");
	   }
	   }
   }catch(e){alert(e);}
}
function initSelect(){
	$("#selectPartyId").html("<span class='field-lookup'><div id='autoId_1'></div><input type='text' name='joinPersonId' size='20' maxlength='20' id='0_lookupId_autoId_1' class='ui-autocomplete-input' autocomplete='off' role='textbox' aria-autocomplete='list' aria-haspopup='true'></span>");
}
</script>
</#macro>