
import org.ofbiz.base.util.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import org.ofbiz.entity.*;
import java.util.List;
import java.util.*;
import org.ofbiz.workflowMng.*;
import org.ofbiz.workflow.client.*;
import org.ofbiz.entity.condition.*;


//界面表单参数
String workEffortId = parameters.get("workEffortId");
if(UtilValidate.isNotEmpty(workEffortId)){
    	WorkflowClient wfc = new WorkflowClient(delegator, dispatcher);
	    Map ctx = wfc.getContext(workEffortId);
	GenericValue workEffortGV = delegator.findByPrimaryKey("WorkEffort", UtilMisc.toMap("workEffortId", workEffortId));

	// 得到WorkEffort中的相关字段
	String packageId = workEffortGV.getString("workflowPackageId");
	String processId = workEffortGV.getString("workflowProcessId");
	String activityId = workEffortGV.getString("workflowActivityId");

	GenericValue workFlowPackage = (GenericValue) delegator.findByAnd("WorkflowPackage", UtilMisc.toMap("packageId", packageId)).get(0);
	List<GenericValue> activityList = delegator.findByAnd("WorkflowActivity", UtilMisc.toMap("packageId", packageId, "processId", processId, "activityId", activityId));
	context.packageName=workFlowPackage.getString("packageName");
	context.workEffortGV=workEffortGV;
	context.packageId=packageId;
	context.processId=processId;
	context.activity=(GenericValue)activityList.get(0);
	context.activityId=activityId;
	context.sourceReferenceId=workEffortGV.getString("sourceReferenceId");
	context.parameters=parameters;
	context.returnActivityList=org.ofbiz.workflowMng.WorkflowReturnProcess.getReturnActivitySelectOption(delegator,workEffortGV.workEffortId,workEffortGV.sourceReferenceId);
}