import net.sf.json.JSONObject;
import net.sf.json.JSONArray;
import java.io.Writer;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.*;
import org.ofbiz.entity.*;

messageId=parameters.messageId;
messageForOne=delegator.findOne("MessageSet", [messageId : messageId], false);
Map map=null;
if(messageForOne.releases){
	if(messageForOne.releases.equals("-Y-")||messageForOne.releases=="-Y-"){
		map=UtilMisc.toMap("messageId",messageId,"releases","-N-");
	}else{
		map=UtilMisc.toMap("messageId",messageId,"releases","-Y-");
	}
}else{
	map=UtilMisc.toMap("messageId",messageId,"releases","-Y-");
}

MessageForRelease = delegator.makeValue("MessageSet", map);

delegator.store(MessageForRelease);

return "success";



/*GenericValue thisCommEvent = delegator.findOne("CommunicationEvent", false, "communicationEventId", thisCommEventId);
if (thisCommEvent != null) {
    thisCommEvent.set("contactListId", contactListId);
    thisCommEvent.set("parentCommEventId", communicationEventId);
    thisCommEvent.store();
}*/




