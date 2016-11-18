import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;

import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.entity.util.*;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityFunction;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.condition.EntityFieldValue;
import org.ofbiz.entity.condition.EntityConditionList;
import org.ofbiz.entity.condition.EntityCondition;
import org.extErp.sysCommon.party.CommonWorkers;


partyId=parameters.partyId;
//联系地址
List<GenericValue> addrList=new ArrayList<GenericValue>();
List<GenericValue> contactMechList = delegator.findByAnd("PartyContactWithPurpose", 
		UtilMisc.toMap("partyId",partyId,"contactMechPurposeTypeId","GENERAL_LOCATION"));
for(GenericValue gv:contactMechList){
	Map map=new HashMap();
	GenericValue pgv= EntityUtil.getFirst(delegator.findByAnd("PostalAddress",UtilMisc.toMap("contactMechId",gv.get("contactMechId"))));
	map.put("contactMechTelId",gv.get("contactMechId"));
	map.put("addressGeoAllCn",CommonWorkers.getAddressGeoAllCn(delegator,
			pgv.get("stateProvinceGeoId"),pgv.get("cityGeoId"),pgv.get("countyGeoId"))
			+"--"+pgv.getString("address1"));
	map.put("postalCode",pgv.getString("postalCode"));
	addrList.add(map);
}

//TODO:以后可能需要优化
//获取默认的联系人、联系电话、手机号码、邮箱
parentGroupId=partyId;
GenericValue defaultPerson=null;
GenericValue defaultMobile=null;
GenericValue defaultPhone=null;
GenericValue defaultEmail=null;
GenericValue gv = EntityUtil.getFirst(delegator.findByAnd("PartyRelationship", 
		UtilMisc.toMap("partyIdTo",parentGroupId,"partyRelationshipTypeId","CUSTOMER_CONTACT_REL")));
if(gv){
defaultPerson= delegator.findByPrimaryKey("Person", UtilMisc.toMap("partyId",gv.get("partyIdFrom")))
contactMechPurposeTypeId="PHONE_MOBILE";
personId=defaultPerson.get("partyId");
GenericValue gvmb = EntityUtil.getFirst(delegator.findByAnd("PartyContactMechPurpose", 
		UtilMisc.toMap("partyId",personId,"contactMechPurposeTypeId",contactMechPurposeTypeId)));
if(gvmb)defaultMobile= gvmb.getRelatedOneCache("TelecomNumber");
contactMechPurposeTypeId="PRIMARY_PHONE";
GenericValue gvph = EntityUtil.getFirst(delegator.findByAnd("PartyContactMechPurpose", 
		UtilMisc.toMap("partyId",personId,"contactMechPurposeTypeId",contactMechPurposeTypeId)));
if(gvph)defaultPhone= gvph.getRelatedOneCache("TelecomNumber");
contactMechPurposeTypeId="PRIMARY_EMAIL";
 GenericValue gvem = EntityUtil.getFirst(delegator.findByAnd("PartyContactMechPurpose", 
 		UtilMisc.toMap("partyId",personId,"contactMechPurposeTypeId",contactMechPurposeTypeId)));
 if(gvem)  defaultEmail= gvem.getRelatedOneCache("ContactMech");
}
request.setAttribute("defaultPerson",defaultPerson);
request.setAttribute("defaultPhone",defaultPhone);
request.setAttribute("defaultMobile",defaultMobile);
request.setAttribute("defaultEmail",defaultEmail);


request.setAttribute("postAddrlist",addrList);


