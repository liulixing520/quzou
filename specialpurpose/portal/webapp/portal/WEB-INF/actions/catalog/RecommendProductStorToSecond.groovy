import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.EntityUtil;

pli = delegator.find("ProductStore", null, null,null,null,null);
stores=pli.getPartialList(0, 5);
pli.close();
context.stores=stores;