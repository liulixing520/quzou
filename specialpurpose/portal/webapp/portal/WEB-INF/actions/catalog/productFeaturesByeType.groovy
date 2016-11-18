import org.ofbiz.base.util.*;
import org.ofbiz.entity.condition.*;


productFeatureTypeId=request.getAttribute("optProductFeatureTypeId");
context.productFeatureTypeId = productFeatureTypeId;

findPftMap = UtilMisc.toMap("productFeatureTypeId", productFeatureTypeId);
productFeatureType = delegator.findOne("ProductFeatureType", findPftMap, true);
context.productFeatureType = productFeatureType;

productFeatures = delegator.findList("ProductFeature", EntityCondition.makeCondition("productFeatureTypeId", EntityOperator.EQUALS, productFeatureTypeId), null, null, null, false);

context.productFeatures = productFeatures;
