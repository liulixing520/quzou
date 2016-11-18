
import org.ofbiz.base.util.*;
import org.ofbiz.entity.condition.*;
operationButton = []; 
//组织机构显示为2级
long pcount=0;
if(parameters.parentPartyId){
	EntityCondition findValCondition = EntityCondition.makeCondition(
            EntityCondition.makeCondition("partyIdTo", EntityOperator.EQUALS, parameters.parentPartyId),
            EntityCondition.makeCondition("partyRelationshipTypeId", EntityOperator.EQUALS,"PARENT"));
   
	pcount=delegator.findCountByCondition("PartyRelationship", findValCondition, null, null)
}
if(pcount==0){
	//operationButton[0]="增加子部门|add|EditPartyGroup?parentPartyId="+(parameters.parentPartyId!=null?parameters.parentPartyId:"")+"|dialog|PartyGroup_ADD";
	//context.operationButton=operationButton;
}
