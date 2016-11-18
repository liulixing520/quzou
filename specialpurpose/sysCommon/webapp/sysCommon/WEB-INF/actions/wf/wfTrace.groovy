
import org.ofbiz.base.util.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import org.ofbiz.entity.*;
import java.util.List;
import org.ofbiz.entity.util.*;
import java.util.*;
import org.ofbiz.workflowMng.*;
import org.ofbiz.tools.IntegrateUtil;



List workEffortList = IntegrateUtil.getWorkflowTraceList(delegator,workflowPackageId,sourceReferenceId);
Map workActivityMap =new HashMap();
Map partyAssignmentsMap =new HashMap();
for(int i=0;i<workEffortList.size();i++){
	GenericValue gv=(GenericValue)workEffortList.get(i);
	workActivityMap.put(gv.getString("workEffortId"),EntityUtil.getFirst(delegator.findByAnd("WorkflowActivity",UtilMisc.toMap("activityId",gv.getString("workflowActivityId")))));
	List partyAssignmentList=new ArrayList();
	partyAssignmentList=delegator.findByAnd("WorkEffortPartyAssignment",UtilMisc.toMap("workEffortId",gv.getString("workEffortId")));
    
	partyAssignmentsMap.put(gv.getString("workEffortId"),partyAssignmentList);
    
}

request.setAttribute("workEffortList",workEffortList);
request.setAttribute("workActivityMap",workActivityMap);
request.setAttribute("partyAssignmentsMap",partyAssignmentsMap);
request.setAttribute("sourceReferenceId",sourceReferenceId);
request.setAttribute("workflowProcess",EntityUtil.getFirst(delegator.findByAnd("WorkflowProcess",UtilMisc.toMap("packageId",workflowPackageId))));