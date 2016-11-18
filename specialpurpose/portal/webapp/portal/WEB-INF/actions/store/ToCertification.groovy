import org.ofbiz.entity.util.*;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilDateTime;

firstName=parameters.firstName?:null;
socialSecurityNumber=parameters.socialSecurityNumber?:null;
partyClassificationGroupId=parameters.partyClassificationGroupId?:null;
if(userLogin){
	if (firstName && socialSecurityNumber) {
		context.firstName=firstName;
		context.socialSecurityNumber=socialSecurityNumber;
		context.partyClassificationGroupId=partyClassificationGroupId;
		person=delegator.findOne("Person",[partyId : userLogin.partyId.toString()],false);
		if(person){
			person.put("firstName",firstName);
			person.put("socialSecurityNumber",socialSecurityNumber);
			int update=delegator.store(person);
		}
		partyClassficatList=delegator.findByAnd("PartyClassification",[partyId : userLogin.partyId],["-fromDate"],false);
		if(partyClassficatList){
			partyClassficatList.each{it ->
				it.put("partyClassificationGroupId", partyClassificationGroupId);
				it.put("fromDate", UtilDateTime.nowTimestamp());
				delegator.removeByAnd("PartyClassification",UtilMisc.toMap("partyId",it.partyId));
			}
			
		}
		Map map = UtilMisc.toMap("partyClassificationGroupId", partyClassificationGroupId, "partyId", userLogin.partyId, "fromDate", UtilDateTime.nowTimestamp());
		partyClassfication = delegator.makeValidValue("PartyClassification", map);
		createPartyClassfication=delegator.create(partyClassfication);
	}else{
		person=delegator.findOne("Person",[partyId : userLogin.partyId.toString()],false);
		context.firstName=person.firstName;
		context.socialSecurityNumber=person.socialSecurityNumber;
		if(partyClassificationGroupId){
			context.partyClassificationGroupId=partyClassificationGroupId;
			partyClassficatList=delegator.findByAnd("PartyClassification",[partyId : userLogin.partyId],["-fromDate"],false);
			if(partyClassficatList){
				partyClassficatList.each{it ->
					it.put("partyClassificationGroupId", partyClassificationGroupId);
					it.put("fromDate", UtilDateTime.nowTimestamp());
					delegator.removeByAnd("PartyClassification",UtilMisc.toMap("partyId",it.partyId));
				}
				
			}
			Map map = UtilMisc.toMap("partyClassificationGroupId", partyClassificationGroupId, "partyId", userLogin.partyId, "fromDate", UtilDateTime.nowTimestamp());
			partyClassfication = delegator.makeValidValue("PartyClassification", map);
			createPartyClassfication=delegator.create(partyClassfication);
		}
	}
}
