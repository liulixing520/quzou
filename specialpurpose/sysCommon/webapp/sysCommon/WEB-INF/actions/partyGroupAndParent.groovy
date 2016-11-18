import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import java.util.List;
import java.util.*;
entityList=delegator.findByAnd("PartyGroupAndParent", UtilMisc.toMap("partyId",parameters.partyId));
if(entityList.size()>0){
	context.entity=entityList.get(0);
}
