package org.extErp.sysCommon.security;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javolution.util.FastList;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.StringUtil;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.base.util.cache.UtilCache;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;

public class SecurityServices
{
    public static final String module = SecurityServices.class.getName();

    /**
     * 创建安全组
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> createSecutiryGroup(DispatchContext dctx, Map<String, ? extends Object> context)
    {
	Map result = new HashMap();
	LocalDispatcher dispatcher = dctx.getDispatcher();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    String groupId = delegator.getNextSeqId("SecurityGroup");
	    dispatcher.runSync("createSecurityGroup",
		    UtilMisc.<String, Object> toMap("groupId", groupId, "description", context.get("description"), "userLogin", context.get("userLogin")));

	    // 保存与选择权限的映射-先删除后创建
	    if (context.get("permissionIds") != null)
	    {
		String permissionIds = context.get("permissionIds").toString();
		String[] permissionIdArray = permissionIds.split(",");
		List<String> pidList = FastList.newInstance();
		for (int i = 0; i < permissionIdArray.length; i++)
		{
		    String pid = permissionIdArray[i];
		    if (!pidList.contains(pid))
		    {
			dispatcher.runSync("addSecurityPermissionToSecurityGroup",
				UtilMisc.<String, Object> toMap("groupId", groupId, "permissionId", permissionIdArray[i], "userLogin", context.get("userLogin")));
			pidList.add(pid);
		    }
		}
	    }
	    // 保存与选择登录用户的映射-先删除后创建
	    if (context.get("userLoginId") != null)
	    {
		String userLoginId = context.get("userLoginId").toString();
		String[] userLoginIdArray = userLoginId.split(",");
		for (int i = 0; i < userLoginIdArray.length; i++)
		{
		    {
			dispatcher.runSync("addUserLoginToSecurityGroup", UtilMisc.<String, Object> toMap("groupId", groupId, "userLoginId", userLoginIdArray[i], "fromDate",
				UtilDateTime.nowTimestamp(), "userLogin", context.get("userLogin")));
		    }
		}
	    }
	    result.put("groupId", groupId);
	} catch (Exception e)
	{
	    e.printStackTrace();
	    return ServiceUtil.returnError("创建安全组失败");
	}
	return result;

    }

    /**
     * 更新安全组
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> updateSecutiryGroup(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Delegator delegator = dctx.getDelegator();
	Map result = ServiceUtil.returnSuccess();
	LocalDispatcher dispatcher = dctx.getDispatcher();
	String groupId = (String) context.get("groupId");
	try
	{
	    dispatcher.runSync("updateSecurityGroup",
		    UtilMisc.<String, Object> toMap("groupId", groupId, "description", context.get("description"), "userLogin", context.get("userLogin")));

	    // 保存与选择权限的映射-先删除后创建
	    if (context.get("permissionIds") != null)
	    {
		String permissionIds = context.get("permissionIds").toString();
		String[] permissionIdArray = permissionIds.split(",");

		delegator.removeByAnd("SecurityGroupPermission", UtilMisc.toMap("groupId", groupId));
		List<String> pidList = FastList.newInstance();
		for (int i = 0; i < permissionIdArray.length; i++)
		{
		    String pid = permissionIdArray[i];
		    if (!pidList.contains(pid))
		    {
			dispatcher.runSync("addSecurityPermissionToSecurityGroup",
				UtilMisc.<String, Object> toMap("groupId", groupId, "permissionId", permissionIdArray[i], "userLogin", context.get("userLogin")));
			pidList.add(pid);
		    }
		}
	    }
	} catch (Exception e)
	{
	    return ServiceUtil.returnError("更新失败");
	}
	return result;

    }

    /**
     * 用户批量授权
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> permissionToParty(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Delegator delegator = dctx.getDelegator();
	Map result = ServiceUtil.returnSuccess();
	LocalDispatcher dispatcher = dctx.getDispatcher();
	String groupId = (String) context.get("groupId");
	try
	{

	    // 保存与选择登录用户的映射
	    List userLoginList = FastList.newInstance();
	    userLoginList = StringUtil.split((String) context.get("ids"), ",");

	    // @add By WuHK 防止重复授权
	    List<EntityCondition> cdtList = FastList.newInstance();
	    Timestamp now = UtilDateTime.nowTimestamp();
	    cdtList.add(EntityCondition.makeCondition(
		    UtilMisc.toList(EntityCondition.makeCondition("thruDate", EntityOperator.GREATER_THAN, now),
			    EntityCondition.makeCondition("thruDate", EntityOperator.EQUALS, null)), EntityOperator.OR));
	    cdtList.add(EntityCondition.makeCondition("groupId", groupId));

	    for (int i = 0; i < userLoginList.size(); i++)
	    {
		// 检查是否已授权
		if (cdtList.size() == 3)
		    cdtList.remove(cdtList.size() - 1);
		cdtList.add(EntityCondition.makeCondition("userLoginId", ((String) userLoginList.get(i)).trim()));
		List<GenericValue> checkList = delegator.findList("UserLoginSecurityGroup", EntityCondition.makeCondition(cdtList), null, null, null, false);
		if (UtilValidate.isNotEmpty(checkList))
		{
		    continue;
		}

		dispatcher.runSync(
			"addUserLoginToSecurityGroup",
			UtilMisc.<String, Object> toMap("groupId", groupId, "userLoginId", userLoginList.get(i), "fromDate", UtilDateTime.nowTimestamp(), "userLogin",
				context.get("userLogin")));
	    }

	} catch (Exception e)
	{
	    return ServiceUtil.returnError("授权失败");
	}
	return result;

    }

    /**
     * 用户批量删除授权
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> removePermissionToParty(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Delegator delegator = dctx.getDelegator();
	Map<String, Object> result = ServiceUtil.returnSuccess();
	String groupId = (String) context.get("groupId");
	try
	{

	    // 删除与选择登录用户的映射
	    List<String> userLoginList = FastList.newInstance();
	    userLoginList = StringUtil.split((String) context.get("ids"), ",");
	    for (int i = 0; i < userLoginList.size(); i++)
	    {
		delegator.removeByAnd("UserLoginSecurityGroup", UtilMisc.toMap("groupId", groupId, "userLoginId", userLoginList.get(i)));
		// delegator.getCache().remove("UserLoginSecurityGroup",
		// EntityCondition.makeCondition("userLoginId",
		// EntityOperator.EQUALS, userLoginList.get(i)));
		// 清除当前用户的UserLoginSecurityGroup缓存
		UtilCache<?, ?> utilCache = UtilCache.findCache("entitycache.entity-list.default.UserLoginSecurityGroup");

		if (utilCache != null)
		{
		    Iterator<?> ksIter = utilCache.getCacheLineKeys().iterator();
		    while (ksIter.hasNext())
		    {

			Object key = ksIter.next();
			if (key.toString().indexOf(userLoginList.get(i).toString()) != -1)
			{
			    utilCache.remove(key);
			}

		    }
		}
	    }

	} catch (Exception e)
	{
	    return ServiceUtil.returnError("删除授权失败");
	}
	return result;

    }

    /**
     * 删除安全组
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> deleteSecutiryGroup(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = ServiceUtil.returnSuccess();
	Delegator delegator = dctx.getDelegator();
	String groupId = (String) context.get("groupId");
	GenericValue gv = delegator.findOne("SecurityGroup", UtilMisc.toMap("groupId", groupId), false);
	if (UtilValidate.isNotEmpty(gv))
	{
	    gv.remove();
	}
	return result;
    }

    /**
     * 批量授权用户的安全组
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> deleteSecutiryGroupAll(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = ServiceUtil.returnSuccess();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    String ids = (String) context.get("ids");
	    if (ids != null && ids.length() > 0)
	    {
		String[] groupId = ids.split(",");
		for (int i = 0; i < groupId.length; i++)
		{

		    GenericValue gv = delegator.findOne("SecurityGroup", UtilMisc.toMap("groupId", groupId[i]), false);
		    if (UtilValidate.isNotEmpty(gv))
		    {
			gv.remove();
		    }
		}
	    }
	} catch (Exception e)
	{
	    // e.printStackTrace();
	}

	return result;
    }

    /**
     * 用户批量分配角色
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> roleToParty(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Delegator delegator = dctx.getDelegator();
	Map result = ServiceUtil.returnSuccess();
	LocalDispatcher dispatcher = dctx.getDispatcher();
	String roleTypeId = (String) context.get("roleTypeId");
	try
	{

	    // 保存与选择用户的映射
	    String ids = (String) context.get("ids");
	    String[] partyList = ids.split(",");
	    if (ids != null && ids.length() > 0)
	    {
		for (int i = 0; i < partyList.length; i++)
		{
		    // 检查是否已授权
		    List<EntityCondition> cdtList = FastList.newInstance();
		    cdtList.add(EntityCondition.makeCondition("roleTypeId", roleTypeId));
		    cdtList.add(EntityCondition.makeCondition("partyId", ((String) partyList[i]).trim()));
		    List<GenericValue> checkList = delegator.findList("PartyRole", EntityCondition.makeCondition(cdtList), null, null, null, false);
		    if (UtilValidate.isNotEmpty(checkList))
		    {
			continue;
		    }
		    GenericValue gv = delegator.makeValue("PartyRole");
		    gv.set("partyId", partyList[i]);
		    gv.set("roleTypeId", roleTypeId);
		    gv.create();

		}
	    }

	} catch (Exception e)
	{
	    return ServiceUtil.returnError("授权失败");
	}
	return result;

    }

    /**
     * 用户批量删除分配角色
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> removeRoleToParty(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Delegator delegator = dctx.getDelegator();
	Map result = ServiceUtil.returnSuccess();
	LocalDispatcher dispatcher = dctx.getDispatcher();
	String roleTypeId = (String) context.get("roleTypeId");
	try
	{

	    // 删除与选择用户的映射
	    List partyList = FastList.newInstance();
	    partyList = StringUtil.split((String) context.get("ids"), ",");
	    for (int i = 0; i < partyList.size(); i++)
	    {
		delegator.removeByAnd("PartyRole", UtilMisc.toMap("roleTypeId", roleTypeId, "partyId", partyList.get(i)));
	    }

	} catch (Exception e)
	{
	    return ServiceUtil.returnError("删除授权失败");
	}
	return result;

    }

    /**
     * 
     * getSecurityGroupIdList(根据用户获取安全组list)<br/>
     * (这里描述这个方法适用条件 – 可选)<br/>
     * 
     * @param delegator
     * @param userLoginId
     * @return
     */
    public static List getSecurityGroupIdList(Delegator delegator, String userLoginId)
    {
	List groupIdList = FastList.newInstance();
	try
	{
	    List<GenericValue> list = delegator.findByAnd("UserLoginSecurityGroup", UtilMisc.toMap("userLoginId", userLoginId), null, true);
	    for (int i = 0; i < list.size(); i++)
	    {
		groupIdList.add(list.get(i).getString("groupId"));
	    }
	} catch (Exception e)
	{
	    e.printStackTrace();
	    Debug.log("获取权限失败");
	}
	return groupIdList;
    }
}
