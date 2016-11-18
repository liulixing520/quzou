
import org.ofbiz.base.util.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import org.ofbiz.entity.*;
import java.util.List;
import java.util.*;
import org.ofbiz.entity.condition.*;
import java.io.Writer;


entityName=parameters.entityName;
verifyField=parameters.verifyField;
verifyValue=parameters.verifyValue;

entityName="Norm";

dataList=delegator.findByAnd(entityName,UtilMisc.toMap(verifyField,verifyValue),null,false);

if(dataList!=null && (dataList.size() > 0)){
	request.setAttribute("result","false");
}
request.setAttribute("result","false");