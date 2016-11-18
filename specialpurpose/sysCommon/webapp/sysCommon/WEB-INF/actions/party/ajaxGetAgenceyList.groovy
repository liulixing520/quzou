import javolution.util.FastMap
import javolution.util.FastList
import javolution.util.FastList.*

import org.ofbiz.entity.*
import org.ofbiz.entity.util.*

import org.extErp.sysCommon.crm.CrmUtils
import org.extErp.sysCommon.util.*

module = 'AjaxGetAgenceyList'

partyId = parameters.partyId
if(partyId)
{
    agencyList = CrmUtils.getAgencyList(delegator, partyId)
    
    println agencyList 
    resultList = []
    if(agencyList)
    {
        agencyList.each
        {
            gv ->
            if(gv){
                item = [:]
                item.put('partyId',gv.partyId)
                item.put('groupName',gv.groupName)
                resultList.add(item)
            }
        }
    }
    JsonUtil.toJsonObjectList(resultList, response)
    
}