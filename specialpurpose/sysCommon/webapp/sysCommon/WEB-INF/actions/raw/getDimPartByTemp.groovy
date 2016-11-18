import org.ofbiz.entity.*;
import org.ofbiz.entity.util.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import java.util.List;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.base.util.*;
import org.extErp.sysCommon.util.*;

List<GenericValue> measureList=FastList.newInstance();
List<GenericValue> dimPartList=FastList.newInstance();
Map<String, Object> dimPartMap = FastMap.newInstance();
GenericValue templateGv=delegator.findOne("RawTemplate",false,UtilMisc.toMap("templateId",parameters.get("templateId")));
dimPartList=delegator.findByAnd("RawCrossAndDimPart",UtilMisc.toMap("templateId",templateGv.get("templateId")));
measureList=delegator.findByAnd("RawTemplateAndmeasure",UtilMisc.toMap("templateId",parameters.get("templateId")));
for (int i=1;i<templateGv.get("dimCountNum")+1;i++) {
	dimPartMap.put(i+"",EntityUtil.filterByCondition(dimPartList,EntityCondition.makeCondition("dimPartNum",new Long(i))));
}

request.setAttribute("measureList",measureList);
request.setAttribute("dimPartMap",dimPartMap);
request.setAttribute("templateGv",templateGv);
