import java.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.base.util.*;
import org.ofbiz.base.util.collections.*;
import org.ofbiz.accounting.invoice.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.math.BigDecimal;
import java.math.MathContext;
import org.ofbiz.base.util.UtilNumber;
import javolution.util.FastList;
import javolution.util.FastMap;
featureList = FastMap.newInstance();
productId = parameters.get("productId");
product = delegator.findByPrimaryKey("Product", [productId : productId]);
resultQohTotal = FastMap.newInstance();//商品库存
if (product) {
	features = product.getRelated("ProductFeatureAppl");
	if (features) {
		features.each { feature ->
			featureList.put(feature.productFeatureId, feature.productFeatureId);
		}
		context.featureList = featureList.keySet().asList();
	}
	resultQohTotal= dispatcher.runSync("getProductInventoryAvailable", [productId : productId]);
	context.resultQohTotal=resultQohTotal;
}
//获取几级分类
cateGv=delegator.findByPrimaryKey("ProductCategory", [productCategoryId : productTypeCategoryId]);
context.categoryName=cateGv.get("categoryName");

parentCategoryRoll = EntityUtil.getFirst(EntityUtil.filterByDate(delegator.findByAnd("ProductCategoryRollup", UtilMisc.toMap(
        "productCategoryId", productTypeCategoryId))));
if(parentCategoryRoll){  
	parentCategory = delegator.findByPrimaryKey("ProductCategory", [productCategoryId : parentCategoryRoll.parentProductCategoryId]);
	context.parentName=parentCategory.get("categoryName");
	parentCategoryPRoll = EntityUtil.getFirst(EntityUtil.filterByDate(delegator.findByAnd("ProductCategoryRollup", UtilMisc.toMap(
	        "productCategoryId",parentCategoryRoll.parentProductCategoryId))));
	if(parentCategoryPRoll){
		parentPCategory = delegator.findByPrimaryKey("ProductCategory", [productCategoryId : parentCategoryPRoll.parentProductCategoryId]);
		context.parentFirstName=parentPCategory.get("categoryName");
	}
	
	
}  