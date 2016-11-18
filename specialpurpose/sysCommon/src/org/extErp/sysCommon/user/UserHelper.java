package org.extErp.sysCommon.user;

import java.util.List;

import javolution.util.FastList;

import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;

public class UserHelper
{
    /**
     * 按照用户ID查询所属某个角色类型的组织结构
     * 
     * @param delegator
     * @param partyId
     *            用户ID
     * @param roleTypeIdTo
     *            组织角色类型ID
     * @return
     * @throws GenericEntityException
     */
    public static List<GenericValue> getPartyGroupByUserId(Delegator delegator, String partyId, String partyRelationshipTypeId) throws GenericEntityException
    {
	List<GenericValue> resultList = FastList.newInstance();
	if (UtilValidate.isNotEmpty(partyId))
	{
	    GenericValue userGenericValue = delegator.findOne("Party", false, UtilMisc.toMap("partyId", partyId));
	    if (UtilValidate.isNotEmpty(userGenericValue))
	    {
		resultList = delegator.findByAnd("PartyRelationship", UtilMisc.toMap("partyIdFrom", partyId, "partyRelationshipTypeId", partyRelationshipTypeId), null, false);
	    }
	}
	return resultList;
    }


}
