
import org.ofbiz.base.util.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import org.ofbiz.entity.*;
import java.util.List;
import java.util.*;
import org.ofbiz.workflowMng.*;
import org.ofbiz.entity.condition.*;


List constraints = new LinkedList();
constraints.add(EntityCondition.makeCondition("workflowProcessId", EntityOperator.LIKE, "%"+workflowProcessId+"%"));
constraints.add(EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, userLogin.get("partyId")));
constraints.add(EntityCondition.makeCondition("workEffortTypeId", EntityOperator.EQUALS, "ACTIVITY"));
constraints.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "CAL_DECLINED"));
constraints.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "CAL_DELEGATED"));
constraints.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "CAL_COMPLETED"));
constraints.add(EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "CAL_CANCELLED"));
constraints.add(EntityCondition.makeCondition("currentStatusId", EntityOperator.NOT_EQUAL, "WF_TERMINATED"));
constraints.add(EntityCondition.makeCondition("currentStatusId", EntityOperator.NOT_EQUAL, "WF_ABORTED"));
constraints.add(EntityCondition.makeCondition("workflowActivityId", EntityOperator.NOT_EQUAL, "CollectDepartSignLeadExamine"));
partyWorkEfforts = delegator.findList("WorkEffortAndPartyAssign", EntityCondition.makeCondition(constraints, EntityOperator.AND), null, null, null, false);

context.partyWorkEfforts=partyWorkEfforts;