import org.ofbiz.base.util.UtilMisc;

import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;

import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.entity.util.*;
import org.ofbiz.party.contact.ContactHelper;

import java.util.*;

import org.extErp.sysCommon.party.CommonWorkers;

partyId = parameters.partyId;// ?:request.getAttribute("partyId");

if(UtilValidate.isNotEmpty(partyId)){
	party = delegator.findOne("Party",false,"partyId",partyId);
	entity = delegator.findOne("PartyGroup",false,"partyId",partyId);
	context.partyId  = partyId;
	context.entity  = entity;
	
	generalLocation = EntityUtil.getFirst(ContactHelper.getContactMech(party,"GENERAL_LOCATION","POSTAL_ADDRESS",false));
	if(UtilValidate.isNotEmpty(generalLocation)){
		context.generalLocationContactMech = delegator.findOne("ContactMechDetail",false,"contactMechId",generalLocation.contactMechId);
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
			UtilMisc.toMap("partyIdTo",partyId,"roleTypeIdTo","SUBCONTRACTOR","partyRelationshipTypeId","CUSTOMER_CONTACT_REL"),
			UtilMisc.toList("-fromDate"));
	if(UtilValidate.isNotEmpty(EntityUtil.filterByDate(contactRelList))){
		context.contactRelList = contactRelList;
		context.contactRel = EntityUtil.getFirst(contactRelList);
		context.contactRelPerson = delegator.findOne("Person",false,"partyId",context.contactRel.partyIdFrom);
	}
	
	gradeInfo = CommonWorkers.getGradeInfo(delegator,partyId,"SUBCONT");
	if(UtilValidate.isNotEmpty(gradeInfo)){
		context.gradeInfo = gradeInfo;
	}
}
