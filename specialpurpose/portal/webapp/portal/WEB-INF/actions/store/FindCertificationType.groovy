import org.ofbiz.entity.util.*;
if (userLogin) {
	party=delegator.findOne("Party",[partyId:userLogin.partyId],false);
	if(party){
		context.party=party;
	}
	partyClassificationGrouplist = delegator.findByAnd("PartyClassificationGroup", [partyClassificationTypeId : "SELLER_CLASSIFY"], null, false);
	context.classificationList=partyClassificationGrouplist;
	person=delegator.findOne("Person",[partyId : userLogin.partyId],false);
	context.person=person;
}