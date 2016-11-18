import org.ofbiz.entity.util.*;
import org.ofbiz.base.util.UtilMisc;

if (userLogin) {
	partyId2=parameters.partyId?:null;
	partyGroup=null;
	if(partyId2){
		person=delegator.findOne("Person",[partyId : partyId2],false);
		context.firstName=person.firstName;
		context.socialSecurityNumber=person.socialSecurityNumber;
		partyGroup=delegator.findOne("PartyGroup",[partyId : partyId2],false);
		if(partyGroup){
			context.groupName=partyGroup.groupName;
			context.officeSiteName=partyGroup.officeSiteName;
			context.barCode=partyGroup.barCode;
		}

		partyContentList = delegator.findByAnd("PartyContent", [partyId : partyId2], ["-fromDate"], false);
		partyContentList = EntityUtil.filterByDate(partyContentList);
		context.partyContentList = partyContentList;
	}
	
	/**
	isPerson=parameters.isPerson?:null;
	groupName=parameters.groupName?:null;
	officeSiteName=parameters.officeSiteName?:null;//公司名称
	barCode=parameters.barCode?:null;//公司或个体户的执照编号
	partyGroup=delegator.findOne("PartyGroup",[partyId : userLogin.partyId.toString()],false);
	party=delegator.findOne("Party",[partyId : userLogin.partyId],false);
	if(groupName && officeSiteName && barCode){
		if(partyGroup){
			partyGroup.put("groupName",groupName);
			partyGroup.put("officeSiteName",officeSiteName);
			partyGroup.put("barCode",barCode);
			partyGroup.put("groupNameLocal","zh_CN");
			int update=delegator.store(partyGroup);
		}else{
			Map map = UtilMisc.toMap("groupName", groupName, "partyId", userLogin.partyId, "officeSiteName", officeSiteName,"barCode",barCode,"groupNameLocal","zh_CN");
			pg = delegator.makeValidValue("PartyGroup", map);
			createPartyClassfication=delegator.create(pg);
		}
		if(party){
			if(party.sellerStatusId=="" || party.sellerStatusId==null){
				party.put("sellerStatusId","SELLER_CREATED");
				int update=delegator.store(party);
			}
		}
		context.groupName=groupName;
		context.officeSiteName=officeSiteName;
		context.barCode=barCode;
	}else{
		if(partyGroup){
			if(isPerson){
				if(party){
					if(party.sellerStatusId=="" || party.sellerStatusId==null){
						party.put("sellerStatusId","SELLER_CREATED");
						int update=delegator.store(party);
					}
				}
			}
			context.groupName=partyGroup.groupName;
			context.officeSiteName=partyGroup.officeSiteName;
			context.barCode=partyGroup.barCode;
		}else{
			if(isPerson){
				if(party){
					if(party.sellerStatusId=="" || party.sellerStatusId==null){
						party.put("sellerStatusId","SELLER_CREATED");
						int update=delegator.store(party);
					}
				}
			}
			context.groupName=groupName;
			context.officeSiteName=officeSiteName;
			context.barCode=barCode;
		}
	}
	**/

}