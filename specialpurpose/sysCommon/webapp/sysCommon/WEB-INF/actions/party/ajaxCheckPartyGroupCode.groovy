/*
 *按照传入的名称查询PartyGroup 的 code 是否可用  ,
 *新建的时候如果已经有同样code的,则不可用,返回 true
 *编辑的时候,如果修改以后有别人用了的,则不可用,返回true
 */

import org.ofbiz.base.util.*
import javolution.util.FastMap
import javolution.util.FastList
import javolution.util.FastList.*
import org.ofbiz.entity.*
import java.util.List

module = 'ajaxCheckPartyGroupCode'
result = false

customerCode = parameters.code
partyId = parameters.partyId
if(customerCode)
{
    list = delegator.findByAnd('PartyGroup', UtilMisc.toMap('customerCode', customerCode), null, true)
    if(list)
    {
        result = true
    }
    
    if(partyId){
        list = delegator.findByAnd('PartyGroup', UtilMisc.toMap('partyId', partyId, 'customerCode', customerCode), null, true)
        if(list)
        {
            result = false
        }
    }
}

request.setAttribute('result',result)