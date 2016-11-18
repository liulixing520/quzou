import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.base.util.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import org.ofbiz.entity.*;
import java.util.List;

String module = "menuTree";

menuRoot = session.getAttribute("menuRoot");

menuRoot = menuRoot ?:"root";

rootItems = delegator.findByAndCache("MenuTree",["parentItemId":menuRoot], ["rank"]);

context.rootItems = rootItems;

