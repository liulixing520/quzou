import java.util.*;
import java.sql.Timestamp;
import org.ofbiz.entity.*;
import org.ofbiz.base.util.*;
/*
 if(contentId){
 contentObj = delegator.findByPrimaryKey("Content", UtilMisc.toMap("contentId", contentId));
 if(contentObj){
 context.content	= contentObj;
 context.template = delegator.findByPrimaryKey("DataResource", UtilMisc.toMap("dataResourceId", contentObj.dataResourceId));
 context.templateContent = delegator.findByPrimaryKey("electronicText", UtilMisc.toMap("dataResourceId", contentObj.dataResourceId));
 }else{
 context.template=null;
 }
 }
 else{
 context.template=null;
 }
 */
if(productStoreId&&msgTypeId&&eventTypeId){
	productStoreMsgList = delegator.findByAnd("ProductStoreMsgSetting", UtilMisc.toMap("productStoreId", productStoreId,"msgTypeId", msgTypeId,"eventTypeId", eventTypeId));
	if(productStoreMsgList.size()==1){
		productStoreMsg = productStoreMsgList[0];
		context.productStoreMsg=productStoreMsg;
		if(productStoreMsg.contentId){
			content = delegator.findOne("Content",false,UtilMisc.toMap("contentId", productStoreMsg.contentId));
			if(content){
				context.content=content;
				if(content.dataResourceId){
					electronicTextList = delegator.findByAnd("ElectronicText", UtilMisc.toMap("dataResourceId", content.dataResourceId));
					if(electronicTextList){
						electronicText = electronicTextList[0];
						context.electronicText = electronicText;
					}
				}
			}
		}
	}
	eventType = delegator.findOne("Enumeration",false,UtilMisc.toMap("enumId", eventTypeId));
	context.eventType = eventType;
	msgType = delegator.findOne("Enumeration",false,UtilMisc.toMap("enumId", msgTypeId));
	context.msgType = msgType;
}