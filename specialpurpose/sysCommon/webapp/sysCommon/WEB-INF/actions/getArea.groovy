import org.ofbiz.entity.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import java.util.List;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
areaList = org.extErp.sysCommon.party.CommonWorkers.getAssociatedStateList(delegator,parameters.get("parentId"));

if (areaList.size() > 0) {
	request.setAttribute("areaList",areaList);
}
