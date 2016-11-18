import org.ofbiz.entity.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import java.util.List;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.base.util.*;
import org.extErp.sysCommon.util.*;

StringBuffer genericCrossDivStr=new StringBuffer();
List<GenericValue> dimensionList=FastList.newInstance();
List<GenericValue> measureList=FastList.newInstance();
dimensionList=delegator.findByAnd("RawDimension",UtilMisc.toMap("templateGroupId",parameters.get("templateGroupId")));
measureList=delegator.findByAnd("RawMeasure",UtilMisc.toMap("templateGroupId",parameters.get("templateGroupId")));

request.setAttribute("dimensionList",dimensionList);
request.setAttribute("measureList",measureList);
