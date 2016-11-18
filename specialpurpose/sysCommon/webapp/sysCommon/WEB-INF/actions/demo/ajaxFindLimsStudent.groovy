import org.ofbiz.base.util.*
import org.ofbiz.entity.*
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.*
import java.util.*
import org.extErp.sysCommon.util.*
inputFields = [:];
inputFields=org.ofbiz.base.util.UtilHttp.getParameterMap(request);
performFindInMap = [:];
performFindInMap.entityName ="LimsStudent";
outputList = [];
viewIndex=0;
viewSize=20;
if(inputFields.page){
	viewIndex=Integer.valueOf(inputFields.page).intValue()-1;
}
if(inputFields.rows){
	viewSize=Integer.valueOf(inputFields.rows);
}
if(UtilValidate.isEmpty(inputFields.sort)){
	inputFields.sort="-createdStamp";
}
performFindInMap.put("viewIndex",viewIndex);
performFindInMap.put("viewSize",viewSize);
//处理in类型 strings转换为list
org.extErp.sysCommon.util.OfbizExtUtil.convertParamStrsToList(inputFields);

performFindInMap.noConditionFind = "Y";
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
for(Map<String,Object> result:outputList){
    //  从关联表获取信息
	 if(UtilValidate.isNotEmpty(result.get("classId"))){
			GenericValue gv = delegator.findOne("LimsClass",[classId:result.get("classId")],true);
			if(gv)result.classId = gv.className?gv.className:"";
	     }
}

request.setAttribute("rows",outputList);
request.setAttribute("total",listSize);

//导出excel
if(UtilValidate.isNotEmpty(inputFields.exportExcel)){
   org.extErp.sysCommon.util.OfbizExtUtil.exportExcel(request,response,outputList,"studentName,studentEmail","学生名称,邮箱","filename");
}
