import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javolution.util.FastList;


import org.apache.commons.collections.MapUtils;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilGenerics;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityFunction;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.model.DynamicViewEntity;
import org.ofbiz.entity.model.ModelKeyMap;
import org.ofbiz.entity.util.EntityFindOptions;
import org.ofbiz.entity.util.EntityListIterator;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;
import org.ofbiz.entity.transaction.TransactionUtil;

Map<String, Object> result = ServiceUtil.returnSuccess();
//Delegator delegator = dctx.getDelegator();
//GenericValue userLogin = (GenericValue) context.get("userLogin");
//Locale locale = (Locale) context.get("locale");
String userLoginId =(String)parameters.get("userLoginId");
String groupId =(String)parameters.get("groupId");
String roleTypeId =(String)parameters.get("roleTypeId");
String groupName=(String)parameters.get("groupName");
String firstName=(String)parameters.get("firstName");
ifAssignGroupLeader = parameters.ifAssignGroupLeader
// set the page parameters
inputFields = [:];
inputFields=org.ofbiz.base.util.UtilHttp.getParameterMap(request);
int viewIndex = 0;
try {
    if(inputFields.page){
		viewIndex = Integer.valueOf(inputFields.page).intValue()-1;
    }
} catch (Exception e) {
    viewIndex = 0;
}


int viewSize = 15;
try {
    if(inputFields.rows){
		viewSize = Integer.valueOf(inputFields.rows);
    }
} catch (Exception e) {
    viewSize = 15;
}
context.put("viewSize", Integer.valueOf(viewSize));
context.put("VIEW_INDEX_1", Integer.valueOf(viewIndex));



// blank param list
String paramList = "";

List<GenericValue> partyList = null;
int partyListSize = 0;
int lowIndex = 0;
int highIndex = 0;


    // create the dynamic view entity
    DynamicViewEntity dynamicView = new DynamicViewEntity();

    // default view settings
    dynamicView.addMemberEntity("PT", "Party");
    dynamicView.addAlias("PT", "partyId");
    dynamicView.addAlias("PT", "partyName");
    dynamicView.addAlias("PT", "partyFlag");
    dynamicView.addAlias("PT", "thruDate");
    dynamicView.addAlias("PT", "statusId");
    dynamicView.addAlias("PT", "partyTypeId");
    dynamicView.addRelation("one-nofk", "", "PartyType", ModelKeyMap.makeKeyMapList("partyTypeId"));
    dynamicView.addRelation("many", "", "UserLogin", ModelKeyMap.makeKeyMapList("partyId"));

    // define the main condition & expression list
    List<EntityCondition> andExprs = FastList.newInstance();
    EntityCondition mainCond = null;

    List<String> orderBy = FastList.newInstance();
    List<String> fieldsToSelect = FastList.newInstance();
    // fields we need to select; will be used to set distinct
    fieldsToSelect.add("partyId");
    fieldsToSelect.add("partyFlag");
    fieldsToSelect.add("thruDate");
    fieldsToSelect.add("partyName");
    fieldsToSelect.add("statusId");
    fieldsToSelect.add("partyTypeId");

	//排除已经禁用的用户
	//andExprs.add(EntityCondition.makeCondition("statusId",EntityOperator.NOT_EQUAL,"PARTY_DISABLED"))
	andExprs.add(EntityCondition.makeCondition("partyFlag",EntityOperator.NOT_EQUAL,null))
	andExprs.add(EntityCondition.makeCondition("thruDate",EntityOperator.EQUALS,null))
	
    // filter on parties that have relationship with logged in user
    String partyRelationshipTypeId = (String) parameters.get("partyRelationshipTypeId");
    if (UtilValidate.isNotEmpty(partyRelationshipTypeId)) {
        // add relation to view
        dynamicView.addMemberEntity("PRSHP", "PartyRelationship");
        dynamicView.addAlias("PRSHP", "partyIdTo");
        dynamicView.addAlias("PRSHP", "partyRelationshipTypeId");
        dynamicView.addViewLink("PT", "PRSHP", Boolean.FALSE, ModelKeyMap.makeKeyMapList("partyId", "partyIdTo"));
        List<String> ownerPartyIds = UtilGenerics.cast(parameters.get("ownerPartyIds"));
        EntityCondition relationshipCond = null;
        if (UtilValidate.isEmpty(ownerPartyIds)) {
            String partyIdFrom = userLogin.getString("partyId");
            paramList = paramList + "&partyIdFrom=" + partyIdFrom;
            relationshipCond = EntityCondition.makeCondition(EntityFunction.UPPER_FIELD("partyIdFrom"), EntityOperator.EQUALS, EntityFunction.UPPER(partyIdFrom));
        } else {
            relationshipCond = EntityCondition.makeCondition("partyIdFrom", EntityOperator.IN, ownerPartyIds);
        }
        dynamicView.addAlias("PRSHP", "partyIdFrom");
        // add the expr
        andExprs.add(EntityCondition.makeCondition(
                relationshipCond, EntityOperator.AND,
                EntityCondition.makeCondition(EntityFunction.UPPER_FIELD("partyRelationshipTypeId"), EntityOperator.EQUALS, EntityFunction.UPPER(partyRelationshipTypeId))));
        fieldsToSelect.add("partyIdTo");
    }

   
            // modify the dynamic view
            dynamicView.addMemberEntity("UL", "UserLogin");
            dynamicView.addAlias("UL", "userLoginId");
            dynamicView.addViewLink("PT", "UL", Boolean.FALSE, ModelKeyMap.makeKeyMapList("partyId"));

            // add the expr
            // filter on user login
            if (UtilValidate.isNotEmpty(userLoginId)) {

            	andExprs.add(EntityCondition.makeCondition(EntityFunction.UPPER_FIELD("userLoginId"), EntityOperator.LIKE, EntityFunction.UPPER("%"+userLoginId+"%")));
            }
            fieldsToSelect.add("userLoginId");

        // ----
        // PartyGroup Fields
        // ----

        // filter on groupName
        if (UtilValidate.isNotEmpty(groupName)) {
            paramList = paramList + "&groupName=" + groupName;

            // modify the dynamic view
            dynamicView.addMemberEntity("PG", "PartyGroup");
            dynamicView.addAlias("PG", "groupName");
            dynamicView.addViewLink("PT", "PG", Boolean.FALSE, ModelKeyMap.makeKeyMapList("partyId"));

            // add the expr
            andExprs.add(EntityCondition.makeCondition(EntityFunction.UPPER_FIELD("groupName"), EntityOperator.LIKE, EntityFunction.UPPER("%"+groupName+"%")));

            fieldsToSelect.add("groupName");
        }
        
        
        //排除已授权的userLogin
        if(UtilValidate.isNotEmpty(context.get("searchAction"))&&context.get("searchAction").toString().equals("FindPermissionPerson")){
	        List<EntityCondition> conds = UtilMisc.<EntityCondition>toList(EntityCondition.makeCondition("groupId", EntityOperator.EQUALS, groupId));
	        List<GenericValue> permissionList=delegator.findList("UserLoginSecurityGroup", EntityCondition.makeCondition(conds), UtilMisc.toSet("userLoginId"), null, null, false);
	        List list=new ArrayList();
	        for(GenericValue gvp:permissionList){
	        	list.add(gvp.get("userLoginId"));
	        }
	        if(list.size()>0){
	        	andExprs.add(EntityCondition.makeCondition(EntityFunction.UPPER_FIELD("userLoginId"), EntityOperator.NOT_IN, list));
	        }
        }  
        //排除已分配的party
        if(UtilValidate.isNotEmpty(context.get("searchAction"))&&context.get("searchAction").toString().equals("FindRoleTypeParty")){
	        List<EntityCondition> conds = UtilMisc.<EntityCondition>toList(EntityCondition.makeCondition("roleTypeId", EntityOperator.EQUALS, roleTypeId));
	        List<GenericValue> partyRoleList=delegator.findList("PartyRole", EntityCondition.makeCondition(conds), UtilMisc.toSet("partyId"), null, null, false);
	        List list=new ArrayList();
	        for(GenericValue gvp:partyRoleList){
	        	list.add(gvp.get("partyId"));
	        }
	        if(list.size()>0){
	        	andExprs.add(EntityCondition.makeCondition(EntityFunction.UPPER_FIELD("partyId"), EntityOperator.NOT_IN, list));
	        }
        }  
        // ----
        // Person Fields
        // ----

        // modify the dynamic view
      
            dynamicView.addMemberEntity("PE", "Person");
            dynamicView.addAlias("PE", "firstName");
            if(ifAssignGroupLeader)
            {
            	dynamicView.addViewLink("PT", "PE", Boolean.TRUE, ModelKeyMap.makeKeyMapList("partyId"));
            }else{
            	dynamicView.addViewLink("PT", "PE", Boolean.FALSE, ModelKeyMap.makeKeyMapList("partyId"));
			}
            fieldsToSelect.add("firstName");
        

        // filter on firstName
        if (UtilValidate.isNotEmpty(firstName)) {
            paramList = paramList + "&firstName=" + firstName;
            andExprs.add(EntityCondition.makeCondition(EntityFunction.UPPER_FIELD("firstName"), EntityOperator.LIKE, EntityFunction.UPPER("%"+firstName+"%")));
        }
		
		if(ifAssignGroupLeader && ifAssignGroupLeader=="Y")
		{
			dynamicView.addMemberEntity("PR", "PartyRole");
            dynamicView.addAlias("PR", "roleTypeId");
            dynamicView.addViewLink("PT", "PR", Boolean.TRUE, ModelKeyMap.makeKeyMapList("partyId"));
            
            andExprs.add(EntityCondition.makeCondition("roleTypeId","EMPLOYEE"))
		}

        // ---- End of Dynamic View Creation

        // build the main condition
        if (andExprs.size() > 0) mainCond = EntityCondition.makeCondition(andExprs, EntityOperator.AND);


        try {
            // get the indexes for the partial list
        	//add by wangyg
            lowIndex = viewIndex * viewSize + 1;
            highIndex = (viewIndex + 1) * viewSize;

            // set distinct on so we only get one row per order
            EntityFindOptions findOpts = new EntityFindOptions(true, EntityFindOptions.TYPE_SCROLL_INSENSITIVE, EntityFindOptions.CONCUR_READ_ONLY, -1, highIndex, true);
            
            TransactionUtil.begin();
            
            // using list iterator
            EntityListIterator pli = delegator.findListIteratorByCondition(dynamicView, mainCond, null, fieldsToSelect, orderBy, findOpts);

			TransactionUtil.commit();
			
            // get the partial list for this page
            partyList = pli.getPartialList(lowIndex, viewSize);

            // attempt to get the full size
            partyListSize = pli.getResultsSizeAfterPartialList();
            //partyListSize = partyList.size()
            if (highIndex > partyListSize) {
                highIndex = partyListSize;
            }

            // close the list iterator
            pli.close();
        } catch (GenericEntityException e) {
            String errMsg = "Failure in party find operation, rolling back transaction: " + e.toString();
            Debug.logError(e, errMsg, module);
           
        }
        

    if (partyList == null) partyList = FastList.newInstance();
    context.put("partyList", partyList);
    context.put("partyListSize", Integer.valueOf(partyListSize));
    context.put("paramList", paramList);
    context.put("highIndex", Integer.valueOf(highIndex));
    context.put("lowIndex", Integer.valueOf(lowIndex));
    
    request.setAttribute("rows",partyList);
    request.setAttribute("total",Integer.valueOf(partyListSize));

