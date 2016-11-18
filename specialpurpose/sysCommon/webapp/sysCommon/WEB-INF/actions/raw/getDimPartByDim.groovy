import org.ofbiz.entity.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import java.util.List;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.base.util.*;
import org.extErp.sysCommon.util.*;

List<GenericValue> dimensionPartList=FastList.newInstance();
dimensionPartList=delegator.findByAnd("RawDimensionPart",UtilMisc.toMap("dimensionId",parameters.get("dimensionId")));

request.setAttribute("dimensionPartList",dimensionPartList);
