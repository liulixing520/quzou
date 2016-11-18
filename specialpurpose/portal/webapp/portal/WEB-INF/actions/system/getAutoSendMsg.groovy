import org.ofbiz.base.util.*
import org.ofbiz.entity.condition.*
import javolution.util.*
import java.util.*
import java.sql.*
import org.ofbiz.entity.*
import org.ofbiz.base.util.*

productStoreMsgSettingList = delegator.findList("ProductStoreMsgSetting",EntityCondition.makeCondition(UtilMisc.toMap("productStoreId",productStoreId)),null,null,null,false)
eventTypeList = delegator.findList("Enumeration",EntityCondition.makeCondition(UtilMisc.toMap("enumTypeId","MSG_EVENT_TYPE")),null,UtilMisc.toList("sequenceId"),null,false)
msgTypeList = delegator.findList("Enumeration",EntityCondition.makeCondition(UtilMisc.toMap("enumTypeId","MSG_TYPE")),null,UtilMisc.toList("sequenceId"),null,false)

templateMap = new HashMap()
for(productStoreMsgSetting in productStoreMsgSettingList){
	if(templateMap.containsKey(productStoreMsgSetting.eventTypeId)){
		templateMap.get(productStoreMsgSetting.eventTypeId).put(productStoreMsgSetting.msgTypeId,productStoreMsgSetting)
	}else{
		eventTypeGroup = new HashMap()
		eventTypeGroup.put(productStoreMsgSetting.msgTypeId,productStoreMsgSetting)
		templateMap.put(productStoreMsgSetting.eventTypeId,eventTypeGroup)
	}
}
context.eventTypeList=eventTypeList
context.msgTypeList=msgTypeList
context.templateMap=templateMap