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
    //optProductStoreId = request.getAttribute("optProductStoreId");
    optProductStoreId= '10200';

    List<EntityExpr> exprs = FastList.newInstance();
    
      exprs.add(EntityCondition.makeCondition("productStoreId",EntityOperator.EQUALS,optProductStoreId));
    
      optProductMap = delegator.findList("ProductStore", EntityCondition.makeCondition(exprs, EntityOperator.AND),null,null,null,false); 

     context.optProductMap = optProductMap;

     println(context.optProductMap+"********************************************************************************************");

