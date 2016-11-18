/*
  查询组织机构
 */

import java.util.*;
import java.lang.*;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.*;
import org.ofbiz.base.util.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import org.ofbiz.entity.condition.EntityFunction;

inputFields = [:];
inputFields=org.ofbiz.base.util.UtilHttp.getParameterMap(request);

performFindInMap = [:];
performFindInMap.entityName = "PartyGroupAndParent";
outputList = [];
viewIndex=0;
viewSize=20;
if(inputFields.page){
	viewIndex=Integer.valueOf(inputFields.page).intValue()-1;
}
if(inputFields.rows){
	viewSize=Integer.valueOf(inputFields.rows);
}
performFindInMap.put("viewIndex",viewIndex);
performFindInMap.put("viewSize",viewSize);

if(inputFields.hasChild && session.getAttribute("deparmentIds")){
    inputFields.put("partyId_op","in");
    inputFields.put("partyId",org.extErp.sysCommon.party.CommonWorkers.getChildPartyGroupAndCurrentByGroupIds(delegator,session.getAttribute("deparmentIds").toString()));
}

//处理in类型 strings转换为list
org.extErp.sysCommon.util.OfbizExtUtil.convertParamStrsToList(inputFields);

performFindInMap.noConditionFind = inputFields.noConditionFind?inputFields.noConditionFind:"Y";
performFindInMap.inputFields = inputFields;
performFindInMap.orderBy = inputFields.sort;
if (inputFields.order) {
	if(inputFields.order.equals("desc")){
		performFindInMap.orderBy="-"+performFindInMap.orderBy;
	}
}
performFindResults = dispatcher.runSync("performFindList", performFindInMap);
resultList = performFindResults.list;
listSize=performFindResults.listSize;

//日期类型转换
outputList = org.extErp.sysCommon.util.JsonUtil.jsonFromGenericValueList(resultList);
request.setAttribute("rows",outputList);
request.setAttribute("total",listSize);
