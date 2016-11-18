/*
 * 按照partyId 得到可用的 证书名称列表的json,如果传入 nameId,则返回的时候此ID被设为选中
 * */
import java.util.List;

import javolution.util.FastMap
import javolution.util.FastList
import javolution.util.FastList.*

import org.ofbiz.base.util.*
import org.ofbiz.entity.*
import org.ofbiz.entity.util.EntityUtil

import org.extErp.sysCommon.crm.CrmUtils
import org.extErp.sysCommon.util.*

String module = 'getAddressList'

partyId=parameters.partyId
purposeTypeId=parameters.contactMechPurposeTypeId
contactMechId=parameters.contactMechId

if(partyId && purposeTypeId)
{
    GenericValue party = delegator.findOne('Party', UtilMisc.toMap('partyId', partyId), false)
    if(party)
    {
        cmpMap = CrmUtils.getContactMechStringByPurpose(delegator, party, purposeTypeId)
        resultList = []
        if(cmpMap)
        {
            cmpMap.each
            {
                key, value ->
                    item = [:]
                    item.put('key', key)
                    item.put('value', value)
                    if(contactMechId && contactMechId==key){
                       item.put('selected', true)
                    }
                    resultList.add(item)
            }
            if(!contactMechId)
            {
                resultList[0].put('selected', true)
            }
        }
        JsonUtil.toJsonObjectList(resultList, response)
    }
}