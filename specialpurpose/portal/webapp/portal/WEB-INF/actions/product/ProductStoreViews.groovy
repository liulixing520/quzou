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


    // get the optProduct 查询商铺的基本 信息  
    optExcludeProductStoreId = request.getAttribute("optExcludeProductStoreId");
    // product_visit    fromDate

    //List<EntityExpr> exprs = FastList.newInstance();

    //exprs.add(EntityCondition.makeCondition("ProductVisitId",EntityOperator.EQUALS,optExcludeProductStoreId));
    
    //optProductVisits = delegator.findList("ProductVisit", EntityCondition.makeCondition(exprs, EntityOperator.AND),null,null,null,false); 
     
     optProductVisits = delegator.findList("ProductVisit", null,null,null,null,false); 
     context.optProductVisits = optProductVisits;

     println(context.optProductVisits+"******optProductVisits*********"+optProductVisits);

     

     
     
