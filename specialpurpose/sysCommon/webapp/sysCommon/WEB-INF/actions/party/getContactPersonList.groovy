/*
 * 按照传入的ID返回联系人列表.
 * */

import java.util.List;

import javolution.util.FastMap
import javolution.util.FastList
import javolution.util.FastList.*

import org.ofbiz.base.util.*
import org.ofbiz.entity.*
import org.ofbiz.entity.util.*
import org.ofbiz.entity.condition.EntityExpr
import org.ofbiz.entity.condition.EntityFunction
import org.ofbiz.entity.condition.EntityOperator
import org.ofbiz.entity.condition.EntityFieldValue
import org.ofbiz.entity.condition.EntityConditionList
import org.ofbiz.entity.condition.EntityCondition

import org.extErp.sysCommon.crm.CrmUtils
import org.extErp.sysCommon.party.CommonWorkers
import org.extErp.sysCommon.util.*

String module = "getContactPersonList"

partyId=parameters.partyId
roleTypeIdTo = parameters.roleTypeIdTo
roleTypeIdFrom = parameters.roleTypeIdFrom

personId=parameters.personId

if(partyId)
{
    try
    {
        personList = []
        List<GenericValue> prList = CrmUtils.getActiveEntrustingPartyRelationships(delegator, partyId, roleTypeIdFrom)
        
        if(prList)
        {
            prList.each
            {
                pr ->
                gv = delegator.findOne("Person", UtilMisc.toMap("partyId", pr.partyIdFrom), false)
                if(gv){
                    item = [:]
                    item.put('partyId',gv.partyId)
                    item.put('nickname',gv.nickname)
                    if(personId && personId==gv.partyId){
                       item.put('selected', true)
                    }
                    personList.add(item)
                }
            }
        }
        JsonUtil.toJsonObjectList(personList, response)
    }catch (Exception e)
    {
        e.printStackTrace()
        Debug.log(e.toString(), module)
    }
}


