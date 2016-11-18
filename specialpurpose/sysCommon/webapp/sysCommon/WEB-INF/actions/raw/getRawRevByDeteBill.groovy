import org.ofbiz.entity.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import java.util.List;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.base.util.*;
import org.ofbiz.entity.util.*;

/**
 * 根据检测单ID获取最新原始记录版本
 */
String detectionBillCode=parameters.get("detectionBillCode");
//if(detectionBillCode!=null){
    context.put("detectionBillCode",detectionBillCode);
    context.put("templateGroupId",parameters.get("templateGroupId"));
    
    if(detectionBillCode!=null&&parameters.get("revId")==null){
        GenericValue revGv=EntityUtil.getFirst(delegator.findByAnd("RawDataRev",UtilMisc.toMap("detectionBillCode",detectionBillCode),["-revId"]));
        if(revGv!=null){
    		context.put("revId",revGv.get("revId"));
    		context.put("templateGroupId",revGv.get("templateGroupId"));
        }
    }else if(parameters.get("revId")!=null){
        GenericValue revGv=delegator.findOne("RawDataRev",UtilMisc.toMap("revId",parameters.get("revId")),false);
        if(revGv.get("detectionBillCode")!=null){
    	    context.put("detectionBillCode",revGv.get("detectionBillCode"));
    	    context.put("templateGroupId",revGv.get("templateGroupId"));
    	}
    }
//}

