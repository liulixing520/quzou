import java.text.NumberFormat;
import java.util.List;
import java.util.ArrayList;
import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.*;
import org.ofbiz.service.*;
import org.ofbiz.webapp.taglib.*;
import org.ofbiz.product.catalog.*;
import org.ofbiz.product.store.*;
import javolution.util.FastList;
import org.ofbiz.entity.condition.*;


      dxStore = delegator.findOne("ProductStore",["productStoreId":parameters.dxStoreId],false); 

     context.dxStore =dxStore;


