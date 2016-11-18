import net.sf.json.JSONObject;
import net.sf.json.JSONArray;
import java.io.Writer;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.*;
import org.ofbiz.entity.*;

homePageId=parameters.homePageId;
messageContentToOne=parameters.messageContentToOne;
messageContentToTwo=parameters.messageContentToTwo;
messageContentToThree=parameters.messageContentToThree;
messageContentToFour=parameters.messageContentToFour;

Map  map=UtilMisc.toMap("homePageId",homePageId,"messageContentToOne",messageContentToOne,"messageContentToTwo",messageContentToTwo,"messageContentToThree",messageContentToThree,"messageContentToFour",messageContentToFour);

HomePageSet = delegator.makeValue("HomePageSetter", map);

delegator.store(HomePageSet);

return "success";



/*GenericValue thisCommEvent = delegator.findOne("CommunicationEvent", false, "communicationEventId", thisCommEventId);
if (thisCommEvent != null) {
    thisCommEvent.set("contactListId", contactListId);
    thisCommEvent.set("parentCommEventId", communicationEventId);
    thisCommEvent.store();
}*/




