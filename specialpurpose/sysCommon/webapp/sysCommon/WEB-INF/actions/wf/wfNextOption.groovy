
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.workflow.WfActivity;
import org.ofbiz.workflow.WfException;
import org.ofbiz.workflow.WfFactory;
import org.ofbiz.workflowMng.*;



String workflowPackageId=parameters.get("workflowPackageId");
String workflowProcessId=parameters.get("workflowProcessId");
String workflowActivityId=parameters.get("workflowActivityId");
String areaId=parameters.get("areaId");
String selectedId=parameters.get("selectedId");
if(areaId!=null){
    workflowPackageId = WorkflowMng.getWorkFlowPackageId(workflowPackageId, areaId);
}
String nextActivityStr="";
String selectOption = "";
nextActivityStr="";
filter="";
Map resultMap=new HashMap();
List filterList = new ArrayList();
if(filter != null)
{
	String[] filterArray = filter.split(",");
	for (int i = 0; i < filterArray.length; i++)
	{
		filterList.add(filterArray[i]);
	}
}
List resultList=new ArrayList();
List toActivityList=new ArrayList();
GenericValue currentActivity=EntityUtil.getFirst(delegator.findByAnd("WorkflowActivity", UtilMisc.toMap("packageId", workflowPackageId, "processId", workflowProcessId, "activityId", workflowActivityId)));
    if(currentActivity){
    String hasNextActiveSelect=(currentActivity.hasNextActiveSelect)?currentActivity.hasNextActiveSelect:"yes"
    if(hasNextActiveSelect.equals("yes")){
        toActivityList= delegator.findByAnd("WorkflowTransition", UtilMisc.toMap("packageId", workflowPackageId, "processId", workflowProcessId, "fromActivityId", workflowActivityId));
    
        if(toActivityList != null && toActivityList.size() > 0)
        {
        	for (int i = 0; i < toActivityList.size(); i++)
        	{
        		Map map=new HashMap();
        		GenericValue workflowTransitionGv = (GenericValue) toActivityList.get(i);
        		String toActivityId = workflowTransitionGv.getString("toActivityId");
        		if(filterList.contains(toActivityId))
        			continue;
        		List activityList = delegator.findByAnd("WorkflowActivity", UtilMisc.toMap("packageId", workflowPackageId, "processId", workflowProcessId, "activityId", toActivityId));
        		GenericValue activityGv = (GenericValue) activityList.get(0);
        		String objectName = activityGv.getString("objectName");
        		
        		//if(objectName != null && objectName.indexOf("退回") != -1)
        		//{
        		//	continue;
        		//}
        		String performerRange = Tools.checkNull(activityGv.getString("performerRange"));
        		String performerRangeRole = Tools.checkNull(activityGv.getString("performerRangeRole"));
        		String singleSelect = Tools.checkNull(activityGv.getString("singleSelect"));
        		map.putAll(workflowTransitionGv);
        		map.put("objectName",objectName);
        		map.put("performerRange",performerRange);
        		map.put("performerRangeRole",performerRangeRole);
        		map.put("singleSelect",singleSelect);
        		resultList.add(map);
        	}
        }
    
    }	
}
context.resultList=resultList;
context.partyGroup=org.ofbiz.entity.util.EntityUtil.getFirst(delegator.findByAnd("PersonAndPartyGroup",UtilMisc.toMap("partyId",userLogin.partyId)));

context.toActivityList=toActivityList;