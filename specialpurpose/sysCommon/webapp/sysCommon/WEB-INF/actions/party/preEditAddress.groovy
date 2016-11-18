import org.ofbiz.party.contact.ContactMechWorker;

partyId=context.partyId;
curContactMechId=context.contactMechId;

context.result = ContactMechWorker.getCurrentPostalAddress(request, partyId, curContactMechId);