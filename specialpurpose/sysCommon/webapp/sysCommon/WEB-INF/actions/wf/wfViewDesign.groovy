
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.workflow.WfActivity;
import org.ofbiz.workflow.WfException;
import org.ofbiz.workflow.WfFactory;
import org.ofbiz.workflowMng.*;



String packageId=parameters.get("packageId");
request.setAttribute("workflowUiDesign",org.ofbiz.entity.util.EntityUtil.getFirst(delegator.findByAnd("WorkflowUiDesign",UtilMisc.toMap("packageId",packageId,"packageVersion",
		parameters.packageVersion,"processId",parameters.processId,"processVersion",parameters.processVersion))));
request.setAttribute("parameters",parameters);

