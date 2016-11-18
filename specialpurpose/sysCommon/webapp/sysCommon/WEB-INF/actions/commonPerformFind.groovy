/*
  通用performFindList
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

searchField = inputFields.remove("searchField");
searchOper = inputFields.remove("searchOper");
searchString = inputFields.remove("searchString");
if(searchField && searchOper && searchString){
	inputFields[searchField]=searchString
	inputFields[searchField+'_op']='contains'
}

performFindInMap = [:];
performFindInMap.entityName = inputFields.entityName;
outputList = [];
viewIndex=0;
viewSize=20;
if(inputFields.page){
	viewIndex=Integer.valueOf(inputFields.page).intValue()-1;
}
if(inputFields.rows){
	viewSize=Integer.valueOf(inputFields.rows);
}
inputFields.thruDate_op = "empty";
performFindInMap.put("viewIndex",viewIndex);
performFindInMap.put("viewSize",viewSize);

//处理in类型 strings转换为list
org.extErp.sysCommon.util.OfbizExtUtil.convertParamStrsToList(inputFields,inputFields);

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
simpleDateFormatMap = [:];
if (inputFields.simpleDateFormat) {
	if(inputFields.simpleDateFormat.equals("configMark")){
	    simpleDateFormatMap = org.extErp.sysCommon.util.JsonUtil.configMark;
	}else if(inputFields.simpleDateFormat.equals("configChinese")){
	    simpleDateFormatMap = org.extErp.sysCommon.util.JsonUtil.configChinese;
	}else
	    simpleDateFormatMap = org.extErp.sysCommon.util.JsonUtil.config;
	
}else{
    simpleDateFormatMap = org.extErp.sysCommon.util.JsonUtil.config;
}
outputList = org.extErp.sysCommon.util.JsonUtil.jsonFromGenericValueList(resultList,simpleDateFormatMap);
request.setAttribute("rows",outputList);
request.setAttribute("total",listSize);
