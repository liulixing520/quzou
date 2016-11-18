/*
 * 按照partyId 得到可用的 证书名称列表的json,如果传入 nameId,则返回的时候此ID被设为选中
 * */
import java.util.List;

import javolution.util.FastMap
import javolution.util.FastList
import javolution.util.FastList.*

import org.ofbiz.base.util.*

import org.extErp.sysCommon.crm.CrmUtils
import org.extErp.sysCommon.util.*

String module = 'getCertNameList'

partyId=parameters.partyId
nameId=parameters.nameId
if(partyId)
{
    
    certNamesList = CrmUtils.getPartyNameList(delegator, partyId, "CERTIFICATE_NAME")
    nameList = []
    if(certNamesList)
    {
        certNamesList.each
        {
            nameGv ->
            if(nameGv){
                item = [:]
                item.put('nameId',nameGv.nameId)
                item.put('name',nameGv.name)
                if(nameId && nameId==nameGv.nameId){
                   item.put('selected', true)
                }
                nameList.add(item)
            }
        }
    }
    JsonUtil.toJsonObjectList(nameList, response)
}