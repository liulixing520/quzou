/*
 *按照传入的名称查询PartyGroup 的 GroupName 是否可用  ,
 *新建的时候如果已经有同名的,则不可用,返回 true
 *编辑的时候,如果修改以后有别人用了的,则不可用,返回true
 */

import org.ofbiz.base.util.*
import javolution.util.FastMap
import javolution.util.FastList
import javolution.util.FastList.*
import org.ofbiz.entity.*
import java.util.List
module = 'ajaxCheckPartyGroupName'

result = false

gourpName = parameters.gourpName
partyId = parameters.partyId
if(gourpName)
{
    partyGroupList = delegator.findByAnd('PartyGroup', UtilMisc.toMap('groupName', gourpName), null, true)
    if(partyGroupList)
    {
        result = true
    }

    if(partyId)
    {
        partyGroupList = delegator.findByAnd('PartyGroup', UtilMisc.toMap('groupName', gourpName, 'partyId', partyId), null, true)
        if(partyGroupList)
        {
            result = false
        }
    }
}

request.setAttribute('result',result)