import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import java.util.List;
import java.util.*;
entityList=delegator.findByAnd("PartyGroupAndParent", null);

	context.entityList=entityList;

