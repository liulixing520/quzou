
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


List workEffortList=delegator.findByAnd("WorkEffort",
	                                     UtilMisc.toMap(
	          "sourceReferenceId",
	          parameters.sourceReferenceId, "workEffortTypeId", "ACTIVITY"), UtilMisc.toList("createdDate"));
/* List examine_list = IntegrateUtil.getExamineApproveList(delegator,parameters.get("workflowPackageId"),sourceReferenceId);	
Map personMap = new HashMap();
Map workActivityMap =new HashMap();
for(int i=0;i<workEffortList.size();i++){
	GenericValue gv=(GenericValue)workEffortList.get(i);
	personMap.put(gv.getString("examineId"), org.extErp.sysCommon.party.PartyServices.getPersonNameByUserLogin(delegator,gv.getString("partyId")));
	workEffortMap.put(gv.getString("examineId"),EntityUtil.getFirst(delegator.findByAnd("WorkflowActivity",UtilMisc.toMap("activityId",gv.getString("workflowActivityId")))));
}
request.setAttribute("examine_list",examine_list);
request.setAttribute("personMap",personMap);
request.setAttribute("workActivityMap",workActivityMap);
*/

request.setAttribute("workEffortList",workEffortList);
