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
import org.extErp.sysCommon.util.*

inputFields = [:];
inputFields=org.ofbiz.base.util.UtilHttp.getParameterMap(request);

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
inputFields.thruDate_op= "empty";
performFindInMap.put("viewIndex",viewIndex);
performFindInMap.put("viewSize",viewSize);

//处理in类型 strings转换为list
org.extErp.sysCommon.util.OfbizExtUtil.convertParamStrsToList(inputFields,inputFields);

performFindInMap.noConditionFind = inputFields.noConditionFind?inputFields.noConditionFind:"Y";
performFindInMap.inputFields = inputFields;
/*performFindInMap.orderBy = inputFields.sidx;
if (inputFields.sord) {
	if(inputFields.sord.equals("desc")){
		performFindInMap.orderBy="-"+performFindInMap.orderBy;
	}
}*/
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
//request.setAttribute("aaData",outputList);
//request.setAttribute("iTotalRecords",Integer.valueOf(listSize));
if("Y".equals(parameters.json)){
		resultMap = [:];
		status = "1";
		msg = "";
		if(UtilValidate.isEmpty(outputList)){
			status = "2";
			msg = "无数据";
		}
		resultMap.put("status",status);
		resultMap.put("msg",msg);
		resultMap.put("records",listSize);
		resultMap.put("total",BigDecimal.valueOf((listSize+viewSize-1)).divide(BigDecimal.valueOf(viewSize),1,BigDecimal.ROUND_HALF_UP).intValue());
		resultMap.put("page",viewIndex+1);
		resultMap.put("rows",outputList);
		JsonUtil.toJsonObject(resultMap,response);
		return "successJson";
	}else{
		request.setAttribute("records",listSize);
		request.setAttribute("rows",outputList);
		request.setAttribute("total",BigDecimal.valueOf((listSize+viewSize-1)).divide(BigDecimal.valueOf(viewSize),1,BigDecimal.ROUND_HALF_UP).intValue());
		request.setAttribute("page",viewIndex+1);
		return "success";
	}
