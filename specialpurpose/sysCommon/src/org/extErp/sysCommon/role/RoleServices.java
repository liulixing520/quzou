package org.extErp.sysCommon.role;

import java.util.List;
import java.util.Map;

import javolution.util.FastList;

import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;

public class RoleServices
{
    public static final String module = RoleServices.class.getName();

    /**
     * 用户批量授权
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
	String groupId = (String) context.get("groupId");
	try
	{

	    // 保存与选择登录用户的映射
	    List userLoginList = FastList.newInstance();
	    userLoginList = (List) context.get("ids");
	    for (int i = 0; i < userLoginList.size(); i++)
	    {
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
    public static Map<String, Object> removeRoleToParty(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Delegator delegator = dctx.getDelegator();
	Map result = ServiceUtil.returnSuccess();
	LocalDispatcher dispatcher = dctx.getDispatcher();
	String groupId = (String) context.get("groupId");
	try
	{

	    // 删除与选择登录用户的映射
	    List userLoginList = FastList.newInstance();
	    userLoginList = (List) context.get("ids");
	    for (int i = 0; i < userLoginList.size(); i++)
	    {
		delegator.removeByAnd("UserLoginSecurityGroup", UtilMisc.toMap("groupId", groupId, "userLoginId", userLoginList.get(i)));
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

}
