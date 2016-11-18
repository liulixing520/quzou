import org.ofbiz.entity.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import org.ofbiz.iteamgr.party.*;
import org.ofbiz.party.contact.*;
import java.util.List;
contactMechId = parameters.get("shipping_contact_mech_id");
facilityId = parameters.get("facilityId");
showOld = "true".equals(parameters.SHOW_OLD);
if(facilityId){
	contactMeches = ContactMechTools.getFacilityPostalContactMech(delegator,facilityId, showOld,contactMechId,"SHIP_ORIG_LOCATION");
	if(contactMeches.size()>0)
		context.postalAddressView = contactMeches.get(0);
}