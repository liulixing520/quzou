package org.extErp.sysCommon.party;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.extErp.sysCommon.security.SecurityServices;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.StringUtil;
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
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;

public class PartyServices
{

    public static final String module = SecurityServices.class.getName();

    /**
     * 创建组织机构 上级组织机构关系类型PARENT
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> createPartyGroup(DispatchContext dctx, Map<String, ? extends Object> context)
    {
	Map<String, Object> result = new HashMap<String, Object>();
	LocalDispatcher dispatcher = dctx.getDispatcher();
	try
	{
	    Map<String, Object> groupMap = dispatcher.runSync(
		    "createPartyGroup",
		    UtilMisc.<String, Object> toMap("groupName", context.get("groupName"), "sortNum", context.get("sortNum"), "barCode", context.get("barCode"), "remark",
			    context.get("remark"), "userLogin", context.get("userLogin")));
	    String partyId = groupMap.get("partyId").toString();
	    // 创建与上级组织机构关系
	    if (UtilValidate.isNotEmpty(context.get("parentPartyId")))
	    {
		dispatcher.runSync("createPartyRelationship", UtilMisc.<String, Object> toMap("partyIdTo", partyId, "partyIdFrom", context.get("parentPartyId"),
			"partyRelationshipTypeId", "PARENT", "userLogin", context.get("userLogin")));
	    }
	    // 创建partyRole
	    Map<String, Object> map = FastMap.newInstance();
	    map.put("partyId", partyId);
	    map.put("roleTypeId", context.get("roleTypeId"));
	    map.put("userLogin", context.get("userLogin"));
	    dispatcher.runSync("createPartyRole", map);

	    result.put("partyId", partyId);
	} catch (Exception e)
	{
	    e.printStackTrace();
	}
	return result;

    }

    /**
     * 更新组织机构
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> updatePartyGroup(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map<String, Object> result = ServiceUtil.returnSuccess();
	LocalDispatcher dispatcher = dctx.getDispatcher();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    String partyId = context.get("partyId").toString();
	    dispatcher
		    .runSync(
			    "updatePartyGroup",
			    UtilMisc.<String, Object> toMap("partyId", partyId, "groupName", context.get("groupName"), "sortNum", context.get("sortNum"), "barCode",
				    context.get("barCode"), "remark", context.get("remark"), "principalPartyId", context.get("principalPartyId"), "userLogin",
				    context.get("userLogin")));

	    // 删除与上级关系
	    delegator.removeByAnd("PartyRelationship", UtilMisc.<String, Object> toMap("partyIdTo", partyId, "partyRelationshipTypeId", "PARENT"));
	    // 创建与上级组织机构关系
	    if (UtilValidate.isNotEmpty(context.get("parentPartyId")))
	    {
		dispatcher.runSync("createPartyRelationship", UtilMisc.<String, Object> toMap("partyIdTo", partyId, "partyIdFrom", context.get("parentPartyId"),
			"partyRelationshipTypeId", "PARENT", "userLogin", context.get("userLogin")));
	    }
	    result.put("partyId", partyId);
	} catch (Exception e)
	{}
	return result;

    }

    /**
     * 创建用户 系统用户与部门关系类型EMPLOYMENT
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     * 
     */
    public static Map<String, Object> createPerson(DispatchContext dctx, Map<String, ? extends Object> context)
    {
	Map<String, Object> result = new HashMap<String, Object>();
	LocalDispatcher dispatcher = dctx.getDispatcher();
	try
	{
	    // Map<String, Object> groupMap =
	    // dispatcher.runSync("createPerson",UtilMisc.<String,
	    // Object> toMap("firstName", context.get("firstName"),
	    // "userLogin",
	    // context.get("userLogin"),"ufmFilePath",context.get("ufmFilePath")));
	    Map<String, Object> personParam = UtilMisc.<String, Object> toMap("firstName", context.get("firstName"), "userLogin", context.get("userLogin"));
	    String ifElecSign = UtilProperties.getPropertyValue("sysCommon", "ifEleSignOn");
	    if (ifElecSign != null && ifElecSign.equals("Y") && context.get("ufmFilePath") != null)
	    {
		personParam.put("ufmFilePath", context.get("ufmFilePath"));
	    }
	    Map<String, Object> groupMap = dispatcher.runSync("createPerson", personParam);
	    String partyId = groupMap.get("partyId").toString();
	    dispatcher.runSync("createUserLogin", UtilMisc.<String, Object> toMap("userLoginId", context.get("userLoginId"), "partyId", partyId, "currentPassword",
		    context.get("currentPassword"), "currentPasswordVerify", context.get("currentPasswordVerify"), "userLogin", context.get("userLogin")));
	    dispatcher.runSync("createPartyRole", UtilMisc.<String, Object> toMap("partyId", partyId, "roleTypeId", "EMPLOYEE", "userLogin", context.get("userLogin")));

	    // 创建与组织机构关系[多个组织机构]
	    List<?> parentPartyList = FastList.newInstance();
	    if (UtilValidate.isNotEmpty(context.get("parentPartyId")))
	    {
		parentPartyList = (List<?>) StringUtil.split(context.get("parentPartyId").toString(), ",");
		if (parentPartyList.size() > 0)
		{
		    for (int i = 0; i < parentPartyList.size(); i++)
		    {
			dispatcher.runSync("createPartyRelationship", UtilMisc.<String, Object> toMap("partyIdFrom", parentPartyList.get(i).toString(), "partyIdTo", partyId,
				"partyRelationshipTypeId", "EMPLOYMENT", "roleTypeIdFrom", "DEPARTMENT", "roleTypeIdTo", "EMPLOYEE", "userLogin", context.get("userLogin")));
		    }
		}
	    }
	    result.put("partyId", partyId);
	} catch (Exception e)
	{
	    e.printStackTrace();
	    return ServiceUtil.returnError("添加失败");
	}
	return result;

    }

    /**
     * 更新用户
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> updatePerson(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map<String, Object> result = ServiceUtil.returnSuccess();
	LocalDispatcher dispatcher = dctx.getDispatcher();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    String partyId = context.get("partyId").toString();
	    // dispatcher.runSync("updatePerson", UtilMisc.<String,
	    // Object> toMap("partyId", partyId, "firstName",
	    // context.get("firstName"), "userLogin",
	    // context.get("userLogin"),"ufmFilePath",context.get("ufmFilePath")));
	    Map<String, Object> personParam = UtilMisc.<String, Object> toMap("partyId", partyId, "firstName", context.get("firstName"), "userLogin", context.get("userLogin"));
	    String ifElecSign = UtilProperties.getPropertyValue("sysCommon", "ifEleSignOn");
	    if (ifElecSign != null && ifElecSign.equals("Y"))
	    {
		personParam.put("ufmFilePath", context.get("ufmFilePath"));
	    }
	    dispatcher.runSync("updatePerson", personParam);

	    // 删除与上级关系
	    delegator.removeByAnd("PartyRelationship", UtilMisc.<String, Object> toMap("partyIdTo", partyId, "partyRelationshipTypeId", "EMPLOYMENT"));
	    // 创建与组织机构关系[多个组织机构]
	    List<?> parentPartyList = FastList.newInstance();
	    if (UtilValidate.isNotEmpty(context.get("parentPartyId")))
	    {
		parentPartyList = (List<?>) StringUtil.split(context.get("parentPartyId").toString(), ",");
		if (parentPartyList.size() > 0)
		{
		    for (int i = 0; i < parentPartyList.size(); i++)
		    {
			dispatcher.runSync("createPartyRelationship", UtilMisc.<String, Object> toMap("partyIdFrom", parentPartyList.get(i).toString(), "partyIdTo", partyId,
				"partyRelationshipTypeId", "EMPLOYMENT", "roleTypeIdFrom", "DEPARTMENT", "roleTypeIdTo", "EMPLOYEE", "userLogin", context.get("userLogin")));
		    }
		}
	    }
	} catch (Exception e)
	{
	    return ServiceUtil.returnError("修改失败");
	}
	return result;

    }

    /**
     * 批量重置密码
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> initUserLoginPassword(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map<String, Object> result = ServiceUtil.returnSuccess("重置成功，初始化密码为：\"111111\"");
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    String newPassword = (String) context.get("newPassword");
	    if (UtilValidate.isNotEmpty(context.get("ids")))
	    {
		String userLoginIdStr = (String) context.get("ids");
		String userLoginIds[] = userLoginIdStr.split(",");
		for (int i = 0; i < userLoginIds.length; i++)
		{
		    GenericValue gv = delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId", userLoginIds[i]), false);
		    boolean useEncryption = "true".equals(UtilProperties.getPropertyValue("security.properties", "password.encrypt"));
		    // gv.set("currentPassword", useEncryption ?
		    // HashCrypt.digestHash(getHashType(),
		    // newPassword.getBytes()) : newPassword, false);
		    gv.store();
		}
	    }
	} catch (Exception e)
	{
	    e.printStackTrace();
	    return ServiceUtil.returnError("重置失败!");
	}
	return result;

    }

    /**
     * 修改密码
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> updatePasswordExt(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map<String, Object> result = ServiceUtil.returnSuccess();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    String userLoginId = (String) context.get("userLoginId");
	    String newPassword = (String) context.get("newPassword");
	    // String
	    // currentPassword=(String)context.get("currentPassword");
	    boolean useEncryption = "true".equals(UtilProperties.getPropertyValue("security.properties", "password.encrypt"));
	    GenericValue gv = delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId", userLoginId), false);
	    // currentPassword=useEncryption ?
	    // HashCrypt.getDigestHash(currentPassword, getHashType())
	    // : currentPassword;
	    if (true)
	    {
		// if(true||currentPassword.equals(gv.get("currentPassword"))){
		// gv.set("currentPassword", useEncryption ?
		// HashCrypt.digestHash(getHashType(),
		// newPassword.getBytes()) : newPassword, false);
		gv.store();
		result.putAll(ServiceUtil.returnSuccess("修改成功"));
	    }
	} catch (Exception e)
	{
	    e.printStackTrace();
	    return ServiceUtil.returnError("修改失败");
	}
	return result;

    }

    /**
     * 更新party状态
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> updatePartyStatus(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map<String, Object> result = ServiceUtil.returnSuccess();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    if (UtilValidate.isNotEmpty(context.get("ids")))
	    {
		String partyStr = (String) context.get("ids");
		String partys[] = partyStr.split(",");
		for (int i = 0; i < partys.length; i++)
		{
		    GenericValue gv = delegator.findOne("Party", UtilMisc.toMap("partyId", partys[i]), false);
		    gv.set("statusId", context.get("statusId"));
		    gv.store();
		}
	    }
	} catch (Exception e)
	{
	    e.printStackTrace();
	    return ServiceUtil.returnError("修改失败");
	}
	result.put("navTabId", context.get("navTabId"));
	return result;

    }

    /**
     * 更新userlogin和party状态
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> updateUserPartyStatus(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map<String, Object> result = ServiceUtil.returnSuccess();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    if (UtilValidate.isNotEmpty(context.get("ids")))
	    {
		String userLoginStr = (String) context.get("ids");
		String userLogins[] = userLoginStr.split(",");
		for (int i = 0; i < userLogins.length; i++)
		{
		    GenericValue ugv = delegator.findOne("UserLogin", false, UtilMisc.toMap("userLoginId", userLogins[i]));
		    ugv.set("enabled", context.get("statusId").equals("PARTY_ENABLED") ? "Y" : "N");
		    ugv.store();
		    GenericValue gv = delegator.findOne("Party", UtilMisc.toMap("partyId", ugv.get("partyId")), false);
		    gv.set("statusId", context.get("statusId"));
		    gv.store();
		}
	    }
	} catch (Exception e)
	{
	    e.printStackTrace();
	    return ServiceUtil.returnError("修改失败");
	}
	result.put("navTabId", context.get("navTabId"));
	return result;

    }

    /*
     * 根据partyId获取所属组织机构名称','号分隔
     */
    public static String getPartyGroupsNameByParty(Delegator delegator, String partyId)
    {
	List<GenericValue> list = new ArrayList<GenericValue>();
	String groupNames = "";
	try
	{
	    list = getPartyGroupsByParty(delegator, partyId);
	    for (GenericValue gv : list)
	    {
		groupNames += gv.get("groupName") + ",";
	    }

	} catch (Exception e)
	{
	    Debug.logError(e, "获取部门名称失败", module);
	}
	return groupNames.length() > 0 ? groupNames.substring(0, groupNames.length() - 1) : "";
    }

    /*
     * 根据partyId获取所属组织机构id和名称','号分隔Map
     */
    public static Map getPartyGroupsMapByParty(Delegator delegator, String partyId)
    {
	List<GenericValue> list = new ArrayList<GenericValue>();
	String partyIds = "";
	String groupNames = "";
	Map groupMap = FastMap.newInstance();
	try
	{
	    list = getPartyGroupsByParty(delegator, partyId);
	    for (GenericValue gv : list)
	    {
		partyIds += gv.get("partyId") + ",";
		groupNames += gv.get("groupName") + ",";
	    }

	} catch (Exception e)
	{
	    Debug.logError(e, "获取部门名称失败", module);
	}
	groupMap.put("partyId", partyIds.length() > 0 ? partyIds.substring(0, partyIds.length() - 1) : "");
	groupMap.put("groupName", groupNames.length() > 0 ? groupNames.substring(0, groupNames.length() - 1) : "");
	return groupMap;
    }

    /*
     * 根据userLoginId获取person
     */
    public static GenericValue getPersonByUserLogin(Delegator delegator, String userLoginId)
    {
	GenericValue gv = null;
	try
	{
	    GenericValue ugv = delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId", userLoginId), false);
	    gv = delegator.findOne("Person", UtilMisc.toMap("partyId", ugv.get("partyId")), false);
	} catch (Exception e)
	{
	    Debug.logError(e, "获取部门名称失败", module);
	}
	return gv;
    }

    /*
     * 根据userLoginId获取person的firstName
     */
    public static String getPersonNameByUserLogin(Delegator delegator, String userLoginId)
    {
	String personName = "";
	try
	{
	    personName = getPersonByUserLogin(delegator, userLoginId).get("firstName").toString();
	} catch (Exception e)
	{
	    Debug.logError(e, "获取部门名称失败", module);
	}
	return personName;
    }

    public static List<GenericValue> getPartyGroupsByParty(Delegator delegator, String partyId)
    {
	List<GenericValue> list = new ArrayList<GenericValue>();
	try
	{
	    List<GenericValue> prlist = delegator.findByAnd("PartyRelationship", UtilMisc.<String, Object> toMap("partyIdTo", partyId, "partyRelationshipTypeId", "EMPLOYMENT"),
		    null, false);
	    for (GenericValue gv : prlist)
	    {
		GenericValue obj = delegator.findOne("PartyGroup", UtilMisc.<String, Object> toMap("partyId", gv.get("partyIdFrom")), false);
		if (UtilValidate.isNotEmpty(obj))
		{
		    list.add(obj);
		}
	    }
	} catch (GenericEntityException e)
	{
	    Debug.logError(e, "查询部门失败", module);
	}
	return list;
    }

    /**
     * 部门分配部门负责人 关系-DEPARTMENT_LEADER_REL
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> assignGroupLeaderToGroup(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map<String, Object> result = ServiceUtil.returnSuccess();
	LocalDispatcher dispatcher = dctx.getDispatcher();
	String partyId = (String) context.get("partyId");
	try
	{

	    // 多个部门负责人
	    List<?> partyList = FastList.newInstance();
	    partyList = StringUtil.split((String) context.get("ids"), ",");

	    for (int i = 0; i < partyList.size(); i++)
	    {
		// 创建用户DEP_LEADER角色
		dispatcher.runSync("createPartyRole",
			UtilMisc.<String, Object> toMap("partyId", partyList.get(i), "roleTypeId", "DEP_LEADER", "userLogin", context.get("userLogin")));
		// 创建关系
		dispatcher.runSync("createPartyRelationship", UtilMisc.<String, Object> toMap("partyIdFrom", partyId, "partyIdTo", partyList.get(i), "partyRelationshipTypeId",
			"DEP_LEADER_REL", "roleTypeIdFrom", "DEPARTMENT", "roleTypeIdTo", "DEP_LEADER", "userLogin", context.get("userLogin")));

	    }

	} catch (Exception e)
	{
	    return ServiceUtil.returnError("分配失败");
	}
	return result;

    }

    /**
     * 删除部门分配部门负责人 关系-DEPARTMENT_LEADER_REL
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> unAssignGroupLeaderToGroup(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Delegator delegator = dctx.getDelegator();
	Map<String, Object> result = ServiceUtil.returnSuccess();
	String partyId = (String) context.get("partyId");
	try
	{
	    // 多个部门负责人
	    List<?> partyList = FastList.newInstance();
	    partyList = StringUtil.split((String) context.get("ids"), ",");
	    for (int i = 0; i < partyList.size(); i++)
	    {
		// 删除与上级关系
		delegator.removeByAnd("PartyRelationship", UtilMisc.<String, Object> toMap("partyIdTo", partyList.get(i), "partyIdFrom", partyId, "partyRelationshipTypeId",
			"DEP_LEADER_REL", "roleTypeIdFrom", "DEPARTMENT", "roleTypeIdTo", "DEP_LEADER"));
	    }

	} catch (Exception e)
	{
	    return ServiceUtil.returnError("删除授权失败");
	}
	return result;

    }

    public static Map<String, Object> findPartyExt(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map<String, Object> result = ServiceUtil.returnSuccess();
	Delegator delegator = dctx.getDelegator();
	GenericValue userLogin = (GenericValue) context.get("userLogin");
	String userLoginId = (String) context.get("userLoginId");
	String groupId = (String) context.get("groupId");
	String groupName = (String) context.get("groupName");
	String firstName = (String) context.get("firstName");
	// set the page parameters
	int viewIndex = 0;
	try
	{
	    viewIndex = Integer.parseInt((String) context.get("VIEW_INDEX_1"));
	} catch (Exception e)
	{
	    viewIndex = 0;
	}

	int viewSize = 20;
	try
	{
	    viewSize = Integer.parseInt((String) context.get("VIEW_SIZE_1"));
	} catch (Exception e)
	{
	    viewSize = 20;
	}
	result.put("viewSize", Integer.valueOf(viewSize));
	result.put("viewIndex", Integer.valueOf(viewIndex));

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
	fieldsToSelect.add("statusId");
	fieldsToSelect.add("partyTypeId");

	// filter on parties that have relationship with logged in
	// user
	String partyRelationshipTypeId = (String) context.get("partyRelationshipTypeId");
	if (UtilValidate.isNotEmpty(partyRelationshipTypeId))
	{
	    // add relation to view
	    dynamicView.addMemberEntity("PRSHP", "PartyRelationship");
	    dynamicView.addAlias("PRSHP", "partyIdTo");
	    dynamicView.addAlias("PRSHP", "partyRelationshipTypeId");
	    dynamicView.addViewLink("PT", "PRSHP", Boolean.FALSE, ModelKeyMap.makeKeyMapList("partyId", "partyIdTo"));
	    List<String> ownerPartyIds = UtilGenerics.cast(context.get("ownerPartyIds"));
	    EntityCondition relationshipCond = null;
	    if (UtilValidate.isEmpty(ownerPartyIds))
	    {
		String partyIdFrom = userLogin.getString("partyId");
		paramList = paramList + "&partyIdFrom=" + partyIdFrom;
		relationshipCond = EntityCondition.makeCondition(EntityFunction.UPPER_FIELD("partyIdFrom"), EntityOperator.EQUALS, EntityFunction.UPPER(partyIdFrom));
	    } else
	    {
		relationshipCond = EntityCondition.makeCondition("partyIdFrom", EntityOperator.IN, ownerPartyIds);
	    }
	    dynamicView.addAlias("PRSHP", "partyIdFrom");
	    // add the expr
	    andExprs.add(EntityCondition.makeCondition(relationshipCond, EntityOperator.AND,
		    EntityCondition.makeCondition(EntityFunction.UPPER_FIELD("partyRelationshipTypeId"), EntityOperator.EQUALS, EntityFunction.UPPER(partyRelationshipTypeId))));
	    fieldsToSelect.add("partyIdTo");
	}

	// modify the dynamic view
	dynamicView.addMemberEntity("UL", "UserLogin");
	dynamicView.addAlias("UL", "userLoginId");
	dynamicView.addViewLink("PT", "UL", Boolean.FALSE, ModelKeyMap.makeKeyMapList("partyId"));

	// add the expr
	// filter on user login
	if (UtilValidate.isNotEmpty(userLoginId))
	{

	    andExprs.add(EntityCondition.makeCondition(EntityFunction.UPPER_FIELD("userLoginId"), EntityOperator.LIKE, EntityFunction.UPPER("%" + userLoginId + "%")));
	}
	fieldsToSelect.add("userLoginId");

	// ----
	// PartyGroup Fields
	// ----

	// filter on groupName
	if (UtilValidate.isNotEmpty(groupName))
	{
	    paramList = paramList + "&groupName=" + groupName;

	    // modify the dynamic view
	    dynamicView.addMemberEntity("PG", "PartyGroup");
	    dynamicView.addAlias("PG", "groupName");
	    dynamicView.addViewLink("PT", "PG", Boolean.FALSE, ModelKeyMap.makeKeyMapList("partyId"));

	    // add the expr
	    andExprs.add(EntityCondition.makeCondition(EntityFunction.UPPER_FIELD("groupName"), EntityOperator.LIKE, EntityFunction.UPPER("%" + groupName + "%")));

	    fieldsToSelect.add("groupName");
	}

	// 排除已授权的userLogin
	List<EntityCondition> conds = UtilMisc.<EntityCondition> toList(EntityCondition.makeCondition("groupId", EntityOperator.EQUALS, groupId));
	List<GenericValue> permissionList = delegator.findList("UserLoginSecurityGroup", EntityCondition.makeCondition(conds), UtilMisc.toSet("userLoginId"), null, null, false);
	List<Object> list = new ArrayList<Object>();
	for (GenericValue gvp : permissionList)
	{
	    list.add(gvp.get("userLoginId"));
	}
	if (list.size() > 0)
	{
	    andExprs.add(EntityCondition.makeCondition(EntityFunction.UPPER_FIELD("userLoginId"), EntityOperator.NOT_IN, list));
	}

	// ----
	// Person Fields
	// ----

	// modify the dynamic view

	dynamicView.addMemberEntity("PE", "Person");
	dynamicView.addAlias("PE", "firstName");
	dynamicView.addViewLink("PT", "PE", Boolean.FALSE, ModelKeyMap.makeKeyMapList("partyId"));

	fieldsToSelect.add("firstName");

	// filter on firstName
	if (UtilValidate.isNotEmpty(firstName))
	{
	    paramList = paramList + "&firstName=" + firstName;
	    andExprs.add(EntityCondition.makeCondition(EntityFunction.UPPER_FIELD("firstName"), EntityOperator.LIKE, EntityFunction.UPPER("%" + firstName + "%")));
	}

	// ---- End of Dynamic View Creation

	// build the main condition
	if (andExprs.size() > 0)
	    mainCond = EntityCondition.makeCondition(andExprs, EntityOperator.AND);

	try
	{
	    // get the indexes for the partial list
	    // add by wangyg
	    viewIndex = viewIndex < 2 ? 0 : viewIndex;
	    lowIndex = viewIndex * viewSize + 1;
	    highIndex = (viewIndex + 1) * viewSize;

	    // set distinct on so we only get one row per order
	    EntityFindOptions findOpts = new EntityFindOptions(true, EntityFindOptions.TYPE_SCROLL_INSENSITIVE, EntityFindOptions.CONCUR_READ_ONLY, -1, highIndex, true);
	    // using list iterator
	    EntityListIterator pli = delegator.findListIteratorByCondition(dynamicView, mainCond, null, fieldsToSelect, orderBy, findOpts);

	    // get the partial list for this page
	    partyList = pli.getPartialList(lowIndex, viewSize);

	    // attempt to get the full size
	    partyListSize = pli.getResultsSizeAfterPartialList();
	    if (highIndex > partyListSize)
	    {
		highIndex = partyListSize;
	    }

	    // close the list iterator
	    pli.close();
	} catch (GenericEntityException e)
	{
	    String errMsg = "Failure in party find operation, rolling back transaction: " + e.toString();
	    Debug.logError(e, errMsg, module);

	}

	if (partyList == null)
	    partyList = FastList.newInstance();
	result.put("partyList", partyList);
	result.put("partyListSize", Integer.valueOf(partyListSize));
	result.put("paramList", paramList);
	result.put("highIndex", Integer.valueOf(highIndex));
	result.put("lowIndex", Integer.valueOf(lowIndex));

	return result;
    }

    public static String getHashType()
    {
	String hashType = UtilProperties.getPropertyValue("security.properties", "password.encrypt.hash.type");

	if (UtilValidate.isEmpty(hashType))
	{
	    Debug.logWarning("Password encrypt hash type is not specified in security.properties, use SHA", module);
	    hashType = "SHA";
	}

	return hashType;
    }
}
