import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;

import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.entity.util.*;
import org.ofbiz.party.contact.ContactHelper;

import java.util.*;
import org.extErp.sysCommon.party.CommonWorkers;

partyId = parameters.partyId ?:request.getAttribute("partyId");

if(UtilValidate.isNotEmpty(partyId)){
	party = delegator.findOne("Party",false,"partyId",partyId);
	entrustingPartyList = delegator.findByAnd("EntrustingParty","partyId",partyId);
	if(UtilValidate.isNotEmpty(entrustingPartyList)){
		entrustingParty = EntityUtil.getFirst(entrustingPartyList);
		context.entrustingParty = entrustingParty;
	}
	
	ownershipId = entrustingParty.getString("ownershipId");
	pcId = entrustingParty.getString("pcId");
	if(UtilValidate.isNotEmpty(ownershipId)){
		context.ownership = delegator.findOne("Ownership",false,"ownershipId",ownershipId);
	}
	if(UtilValidate.isNotEmpty(pcId)){
		context.pc = delegator.findOne("ProvinceCity",false,"pcId",pcId);
	}
	
	nameList = delegator.findByAnd("PartyName","partyId",partyId);
	if(UtilValidate.isNotEmpty(EntityUtil.filterByDate(nameList))){
		context.names = nameList;
	}
	
	generalLocation = EntityUtil.getFirst(ContactHelper.getContactMech(party,"GENERAL_LOCATION","POSTAL_ADDRESS",false));
	if(UtilValidate.isNotEmpty(generalLocation)){
		context.generalLocationContactMech = delegator.findOne("ContactMechDetail",false,"contactMechId",generalLocation.contactMechId);
	}
	
	email = EntityUtil.getFirst(ContactHelper.getContactMech(party,"PRIMARY_EMAIL","EMAIL_ADDRESS",false));
	if(UtilValidate.isNotEmpty(email)){
		context.emailContactMech = delegator.findOne("ContactMechDetail",false,"contactMechId",email.contactMechId);
	}
	
	phone = EntityUtil.getFirst(ContactHelper.getContactMech(party,"PHONE_WORK","TELECOM_NUMBER",false));	
	if(UtilValidate.isNotEmpty(phone)){
		context.phoneContactMech = delegator.findOne("ContactMechDetail",false,"contactMechId",phone.contactMechId);
	}
	
	fax = EntityUtil.getFirst(ContactHelper.getContactMech(party,"FAX_NUMBER","TELECOM_NUMBER",false));	
	if(UtilValidate.isNotEmpty(fax)){
		context.faxContactMech = delegator.findOne("ContactMechDetail",false,"contactMechId",fax.contactMechId);
	}
	
	contactRelList = delegator.findByAnd("PartyRelationshipAndDetail",
			"partyIdTo",partyId,
			"roleTypeIdFrom","SALES_REP",
			"roleTypeIdTo","ENTRUSTING_PARTY",
			"partyRelationshipTypeId","CUSTOMER_CONTACT_REL");
	if(UtilValidate.isNotEmpty(EntityUtil.filterByDate(contactRelList))){
		context.contactRelList = contactRelList;
	}
	
	
	
	gradeInfo = CommonWorkers.getGradeInfo(delegator,partyId,"EP_GRADE");
	if(UtilValidate.isNotEmpty(gradeInfo)){
		context.gradeInfo = gradeInfo;
	}
	println(context.gradeInfo);
}

