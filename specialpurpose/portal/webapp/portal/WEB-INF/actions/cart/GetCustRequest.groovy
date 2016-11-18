import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.base.util.*;
import javolution.util.*;
import org.ofbiz.entity.util.*;

module = "GetCustRequest.groovy";

fromPartyIdVal=userLogin.partyId?:null;
println "---------------------------------"+fromPartyIdVal;
//fromPartyIdVal="10000"; //买家 也可以说是网站会员  fromPartyId 

minDate = request.getParameter("minDate");
println "--------------minDate-------------------"+minDate;
maxDate = request.getParameter("maxDate");
println "--------------maxDate-------------------"+maxDate;

contextInput = [fromPartyId :fromPartyIdVal];
if(minDate){
	contextInput.minDate = minDate;
	context.minDate=minDate;
}
if(maxDate){
	contextInput.maxDate = maxDate;
	context.maxDate=maxDate;
	conditionList = [];
	conditionList.add(EntityCondition.makeConditionDate(EntityOperator.BETWEEN, minDate, EntityOperator.AND,maxDate));

	conditions = EntityCondition.makeCondition(conditionList, EntityOperator.AND);
	println "--------------conditions-------------------"+conditions;
}


if(fromPartyIdVal){	
	curList = delegator.findByAnd("CustRequest", [fromPartyId :fromPartyIdVal], null, false);
	if(curList){
		context.curList=curList;
	}
}else{
	curList=null;
	context.curList=curList;
}

println "---------------------------------"+curList.size();

curListItem = delegator.findByAnd("CustRequestItem", null, null, false);

if(curListItem){
	context.curListItem=curListItem;
}


proList = delegator.findByAnd("ProductStore", null, null, false);

if(proList){
	context.proList=proList;
}


/*userLogin = null;
try {
    userLogin = delegator.findOne("UserLogin",UtilMisc.toMap("userLoginId","admin"), false);
    println "----------------------userLogin-----------"+userLogin;
} catch(e) {
        Debug.logError(e,"");
}
input =  FastMap.newInstance();
inputFields =  FastMap.newInstance();
if(fromPartyIdVal!=null){
    inputFields.put("fromPartyId", fromPartyIdVal);
}
println "----------------------inputFields-----------"+inputFields;
input.put("userLogin",userLogin);
input.put("inputFields",inputFields);
input.put("entityName","CustRequest");
input.put("orderBy","createdDate DESC");
input.put("viewIndex", 1);
input.put("viewSize", 10);
try {
    result = dispatcher.runSync("performFind", input);
    println "---------------------------------"+result.size();   
   
} catch (e) {
    Debug.logError(e, module);
}*/







