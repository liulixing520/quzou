package org.extErp.sysCommon.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;

/**
 * 
 * <b>类名称：</b>UserLoginContext<br/>
 * <b>类描述：</b>用户登陆信息处理<br/>
 * <b>类详细描述：</b>查询得到用户所属的partyGroup,并得到用户角色权限等信息<br/>
 * <b>创建人：</b>Wangyg<br/>
 * <b>修改备注：</b><br/>
 * 
 * @version 1.0.0<br/>
 * 
 */
public class UserLoginContext
{

    /**
     * 得到登陆用户所属的部门信息并放到session中<br/>
     * 将登陆用户的party信息和person信息以及委托方客户的组织机构信息group放在session中.<br/>
     * 
     * @param request
     * @param response
     * @throws GenericEntityException
     */
    public static void setPartyInfos(HttpServletRequest request, HttpServletResponse response) throws GenericEntityException
    {
	Delegator delegator = (Delegator) request.getAttribute("delegator");
	GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
	GenericValue party = null;
	GenericValue person = null;
	List<GenericValue> groupPartyList = null;
	String deparmentIds = "";// 所属部门IDS
	HttpSession session = request.getSession();

	if (UtilValidate.isNotEmpty(userLogin))
	{
	    party = userLogin.getRelatedOne("Party");
	    if (UtilValidate.isNotEmpty(party))
	    {
		session.setAttribute("party", party);
		person = party.getRelatedOne("Person");

		if (UtilValidate.isNotEmpty(person))
		{
		    groupPartyList = delegator.findByAnd("PartyRelationship", UtilMisc.toMap("partyIdTo", party.get("partyId"), "partyRelationshipTypeId", "EMPLOYMENT"), null,
			    false);
		    if (UtilValidate.isNotEmpty(groupPartyList))
		    {
			for (GenericValue partyGroup : groupPartyList)
			{
			    deparmentIds += partyGroup.get("partyIdFrom") + ",";
			    // 获取部门相信信息
			    // GenericValue gv =
			    // delegator.findOne("PartyGroup", true,
			    // UtilMisc.toMap("PartyGroup",
			    // partyGroup.get("partyId")));
			}
		    }
		    session.setAttribute("person", person);
		    session.setAttribute("deparmentIds", (deparmentIds.length() > 0 ? deparmentIds.substring(0, deparmentIds.length() - 1) : ""));
		}
	    }
	}

    }
}
