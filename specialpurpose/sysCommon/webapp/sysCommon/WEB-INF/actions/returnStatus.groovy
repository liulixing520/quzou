
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
import org.ofbiz.entity.util.*;


List<GenericValue> returnlist= new ArrayList<GenericValue>();
List<GenericValue> list= delegator.findByAnd("StatusItem", UtilMisc.toMap("statusTypeId", parameters.modelName));
GenericValue gv=org.ofbiz.entity.util.EntityUtil.getFirst(EntityUtil.filterByAnd(list,
		UtilMisc.toMap("statusId",parameters.statusId)));
		
for(GenericValue siGv:list){
	if((Integer.parseInt(gv.getString("sequenceId")))>Integer.parseInt(siGv.getString("sequenceId"))){
		returnlist.add(siGv);
	}
}

context.statuslist=returnlist;
