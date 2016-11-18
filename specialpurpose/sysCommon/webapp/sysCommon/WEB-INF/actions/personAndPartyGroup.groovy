import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import java.util.List;
import java.util.*;
entityList=delegator.findByAnd("PersonAndUserLoginAndRole", UtilMisc.toMap("partyId",parameters.partyId));
//TODO 需要添加部门排序-先排父部门、再排子部门
partyGroupAll=delegator.findByAnd("PartyGroupAndParent",UtilMisc.toMap("roleTypeId",parameters.roleTypeId),UtilMisc.toList("parentPartyId"));
partySelect=delegator.findByAnd("PartyRelationship",UtilMisc.toMap("partyIdTo",parameters.partyId));
if(entityList!=null&&entityList.size()>0){
	context.entity=entityList.get(0);
}
context.partyGroupAll=partyGroupAll;
context.partySelect=partySelect;
